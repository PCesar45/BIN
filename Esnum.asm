

Datos Segment para 'Data'
	noNumero db 'No digito un numero ,vuelva ha digitar$'
    siNumero db 'Si es un numero',10,13,'$'
    DelTeclado db ?
    cont db 0d

Datos EndS

	Include macroST.cbc		;Llama la lib de macros...


Codigo Segment  ;Define el segmento de código para tasm.
	   Assume cs:Codigo, ds:Datos

     	Inicio:

     	mov ax,Datos;Mueve la posición de SData al reg ax.
     	mov      DS,ax           ;Mueve la posición de ax (SData) al reg DS.

     	push ax

     	LeeCaracter DelTeclado
	 	xor ax,ax
	 	mov al,DelTeclado
	    sub al,30h
	    mov DelTeclado,al
     	push word ptr DelTeclado

     	push cx
     	xor cx,cx
 	   	mov cl,10d
 	   	ciclo:
 	   		; cmp cl,DelTeclado
 	   		; jz siEsNum
 	   		imprimeString siNumero
 	   	loop ciclo
 	   	imprimeString noNumero
 	   	jnz siga
 	   	siEsNum:
 	   		imprimeString siNumero
 	   		;retorna algo
 	   	siga:
 	   	pop cx

 	   	pop ax
		mov ax,4c00h
	    int 21h
Codigo EndS                        ;Fin del segmento de código.
     End Inicio 
