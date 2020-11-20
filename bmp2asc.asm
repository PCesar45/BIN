;Examen1 de arquitectura de computadores
extrn PonerModoVideo	:far

Datos Segment para public 'Datos'
	extrn TipoVideo :byte
	filename db    0FFh Dup (?)
	ErrorMsg db    'Error al abrir archivo', 13, 10,'$'
	filehandle dw ?
	header label word
	Width dw ?
	Height dw ?
	infimg db 400h dup('$')
	nobmp  db  'No es un archivo bmp', 13, 10,'$'
	nowidth db  'La imagen es demasiado ancha,debe tener un ancho menor a 320 pixeles', 13, 10,'$'
	pbm dw ?
	Bm  dw 4D42h
Datos EndS 
 ListPush  Macro lista
		IRP i,<lista>
			Push i
		EndM
	EndM

	ListPop  Macro lista
		IRP i,<lista>
			Pop i
		EndM
	EndM

;----------------------------
Codigo Segment
Assume cs:Codigo , ds:Datos

GetCommanderLine Proc Near
		LongLC    EQU   80h
		ListPush  <Es, Di, Si, Cx, Bp>      
		Mov   Bp,Sp 
		Mov   Ax,Es
		Mov   Ds,Ax
		Mov   Di,12[Bp]
		Mov   Ax,14[Bp]
		Mov   Es,Ax
		Xor   Cx,Cx
		Mov   Cl,Byte Ptr Ds:[LongLC]
		dec   cl 
		Mov   Si,2[LongLC]                        ;dos = uno por la posici�n 81h y uno m�s por el espacio en blanco.
		Rep   Movsb
		ListPop <Bp, Bx, Si, Di, Es>
		Ret   4
GetCommanderLine EndP
OpenFile proc far ;Sirve

    ; Open file

    mov ah, 3Dh
    xor al, al
    mov dx, offset filename
    int 21h

    jc openerror
    mov [filehandle], ax
    ret

    openerror:
    mov dx, offset ErrorMsg
    mov ah, 9h
    int 21h
    ret
OpenFile endp
readfile proc far
;-------------------------lee la cabecera del bmp-----------------------------------------
    mov ah,3fh
	mov bx,filehandle
	mov cx,54             ;; cuantos bytes se van a leer
	mov dx,offset header  ;; donde se va almacenar los datos
	int 21h


;------------------------------------------------------------------

;--------------------Valida que el archivo sea Bmp----------------------------------------------
	xor  ax,ax
	mov  ax,header[00h]

	cmp   Bm, ax
    jnz Noiguales

    jmp short saleif

    Noiguales:
	    mov dx,offset nobmp 
		mov ah,09h 
		int 21h
		jmp Salir
    saleif:
;------------------------------------------------------------------	
;------------------leer y validar el ancho-------------
	xor  ax,ax
	mov  ax,header[12h]
	mov  Width,ax

	xor ax, ax 
	mov ax,320
	cmp width,ax
	ja ErrAncho
	
	jmp short salirif

	ErrAncho:
	   mov dx,offset nowidth 
	   mov ah,09h 
	   int 21h
	   jmp Salir
	salirif:
	Ret
readfile endp 

Inicio:
	mov ax,Datos
	mov ds,ax
	
	;Leer el comando , nombre del archivo
	push Ds
	mov ax,seg filename
	push ax
	lea ax,filename
	push ax
	call GetCommanderLine
	pop Ds

	call OpenFile
	call readfile
	
	


	;xor cx,cx
	;mov cl,64d 
	;cicloN:
	;	mov ah,02h
	;	mov dl,offset buffer[cl]
	;	int 21h
	;loop cicloN

	
	mov dx,offset Width 
	mov ah,09h 
	int 21h  
		
	mov ah,01h 
	int 21h
	xor ah,ah

	mov TipoVideo,18
	call PonerModoVideo
	
	;Espera que le de enter  para salirse
	mov ah,01h 
	int 21h
	xor ah,ah

	mov TipoVideo,3
  	call PonerModoVideo

	Salir:
    mov ax,4c00h
  	int 21h

 Codigo EndS
 	End Inicio
