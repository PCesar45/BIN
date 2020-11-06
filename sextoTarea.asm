;-------------------------------------------;
;Estructura de un programa en ensamblador,  ;
;para arquitectura 8086/8088/80306 mips     ;
;Creado por: Ing. Carlos Benavides C. MsC.  ;
;Propósito: Docente, académico, ejemplo.    ;
;Forma de compilación:                      ;
;  Usando el turbo assembler de borland 4.  ;
;    tasm /zi /l cuarto[.asm]              ;
;    tlink /v cuarto[.oobj]                ;
;                                           ;
; y si lo quiere depurar turbo debuger      ;
;                                           ;
;      td cuarto[.exe]                     ;
; FUM: Mayo 16, 2003.                       ;
;-------------------------------------------;



Datos Segment para 'Data'
     
     Message db 'Hola Mundo',10,13,'$'
     Noiguales db 'No son iguales$'
     Siiguales db 'si son iguales$'
     DelTeclado db ?
     multiplicador db 10d
     Otro db 'quiere imprimir otro$'
Datos EndS

   Include macros.cbc		;Llama la lib de macros...

Datos2 Segment ;Un programa puede  tener varios segmentos de la ,isma clase
	varia db 'Segundo msg$'
Datos2 EndS

Codigo2 Segment             
	Assume cs:codigo2,ds:Datos2

	imprimirMensaje proc Far
		push ax
		mov ax,Datos2
		mov ds,ax
		mov bp,sp
		mov ah,09h
		mov dx,6[bp]
		int 21h
		pop ax
		ret 2*1
	imprimirMensaje EndP	

	impresiones Proc Far
		Assume ds:Datos

		mov ax,Datos
		mov ds,ax
		imprimeString Mensaje
		imprimeString Otro
		LeeCaracter DelTeclado
		cmp delteclado,'y'

		pop ax       ;obtengo el tope conteniendo el seg del ret
		pop bx		 ;obtengo el tope continiendo el oofset de ret.
		pushf        ;meto el parametro a mi conveniensa
		push bx      ;y preparo la direcc de retorno con la pila
		push ax      ;ordenada como yo queria

		ret
	impresiones EndP
Codigo2 EndS

Codigo Segment para public 'Code'  ;Define el segmento de código para tasm.
   
    Amarrilo EQU 14d
    ColIzq db 0
    FilIzq db 0
    ColDer db 79
    FilDer db 24
    Atri db Amarrilo
   
     Assume cs:Codigo, ds:Datos

     Inicio:

     	mov ax,Datos;Mueve la posición de SData al reg ax.
     	 mov      DS,ax           ;Mueve la posición de ax (SData) al reg DS.
     	 limpiarPantalla FilIzq,ColIzq,FilDer,ColDer,Atri
     	 ; imprimeString Mensaje

     	 ; push ax

     	 ; LeeCaracter DelTeclado
     	 ; xor ax,ax
     	 ; mov al,DelTeclado
     	 ; sub al,30h
     	 ; mul multiplicador
     	 ; mov DelTeclado,al
     	 ; push word ptr DelTeclado

     	 ; LeeCaracter DelTeclado

     	 ; pop word ptr DelTeclado
     	 ; sub al,30h
     	 ; add DelTeclado,al

     	 ; pop ax 

     	 ; ;-Estructuras basicas

	     	;  ;if -else
	     	;   cmp DelTeclado,Amarrilo
	     	;   jz iguales
	     	;   imprimeString Noiguales
	     	;   jmp short saleif

	     	;   iguales:
	     	;   	imprimeString Siiguales
	     	;   saleif:
	     	;  ;-if

	     	; ;-ciclos

	     	;    	;-ciclo1 loop
	     	;    	push cx
	     	;    	mov cx,10d
	     	;    	ciclo:
	     	;    		imprimeString Mensaje
	     	;    	loop ciclo

	     	;    	pop cx
	     	;    	;-ciclo1

	     	;    	;ciclo2 repeat
	     	;    	ciclo2:
	     	;    		LeeCaracter
	     	;    		cmp DelTeclado,'a'
	     	;    	 jne ciclo
	     	;    	;-ciclo2

	     	;    	; ciclo3 while
	     	   	call impresiones
	     	   	popf
	     	   	jnz siga 
	     	   	ciclo3:
	     	   		call impresiones
	     	   		popf
	     	   	je ciclo3
	     	   	;-ciclo3	   	

	     	;-ciclos
	     ;-Estructuras basicas
	     siga:
	     ; mov dx,offset Mensaje
	     ; push dx
	     ; call imprimirMensaje 
	     :

	     mov ax,4c00h
	     int 21h
Codigo EndS                        ;Fin del segmento de código.
     End Inicio                    ;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.