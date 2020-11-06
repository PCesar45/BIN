
SegDatos segment para "Data"
	n db "1"
	n1 db 2
Ends SegDatos
SegCodigo segment para "code"
	Inicio:
		assume CS:SegCodigo

		xor ax,ax ;ax en cero
		push ax ; meter al ax a la pila
		mov ax,SegDatos ;mover al ax el SegDatos
		mov DS,ax; mover al DS el ax con el SegDatos
		;pop ax ;Sacar el ax de la pila

		;push ax
		;add n,n1 ;suma dos operandos y guarda el resultado en el primero

		mov dl,n  ; careacter a imprimir
		mov ah,01h ;ah =05h
		int 21h ;interrupcion 21h con ah=05 imprime un caracter

		xor ax,ax		;Limpia el al y prepara el ah para la salida.
        mov ax,4c00h 	;Servicio AH=4c int 21h para salir del programa.
        int 21h	   		;Llamada al DOS. Termine el programa.
Ends SegCodigo
	end Inicio