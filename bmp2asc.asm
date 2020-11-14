;Examen1 de arquitectura de computadores
extrn PonerModoVideo	:far

Datos Segment para public 'Datos'
	extrn TipoVideo :byte
	filename db    0FFh Dup (?)
	ErrorMsg db    'Error al abrir archivo', 13, 10,'$'
	filehandle dw ?
	buffer db 0ffh dup('$')
	
	cont db 0

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
	mov ah,3fh
	mov bx,filehandle
	mov cx,54                 ;; cuantos bytes se van a leer
	mov dx,offset buffer  ;; donde se va almacenar los datos
	int 21h
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
	;	mov dl,buffer[cl]
	;	int 21h
	;loop cicloN

	
	lea dx,buffer ;lea=carga la direccion al registro (lea registro16,direccion)
	mov ah,09h ;le mueve al registro ah un 09 en hexadecimal por eso la h 
	int 21h  ;int = interrupcion /interrupcion 21,9(ah =09): imprime hasta toparse
		; con el simbolo "$",              por eso en la linea anterior le movi un 09 al ah   
	;Espera que le de enter  para salirse
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


    mov ax,4c00h
  	int 21h

 Codigo EndS
 	End Inicio
