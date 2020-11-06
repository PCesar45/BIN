;-------------------------------------------;
;Estructura de un programa en ensamblador,  ;
;para arquitectura 8086/8088/80306 mips     ;
;Creado por: Ing. Carlos Benavides C. MsC.  ;
;Propósito: Docente, académico, ejemplo.    ;
;Forma de compilación:                      ;
;  Usando el turbo assembler de borland 4.  ;
;    tasm /zi /l priemro[.asm]              ;
;    tlink /v primero[.oobj]                ;
;                                           ;
; y si lo quiere depurar turbo debuger      ;
;                                           ;
;      td primero[.exe]                     ;
; FUM: Mayo 16, 2003.                       ;
;-------------------------------------------;

SSeg Segment para Stack 'Stack'

     db 64 Dup ('SegStack ')
     
SSeg EndS

SData Segment para 'Data'
     
     Message db 'Hola Mundo $'
	 contador db ?
     
SData EndS

CSeg Segment para public 'Code'	;Define el segmento de código para tasm.
 Begin:
      Assume CS:CSeg, SS:SSeg	;Asignación de los segmentos a los registro de segmentos del CPU.
       
                        ;Va a reservar la dirección del PSP en el ES.       
       xor    ax,ax		;Pone en cero al reg ax.
       push   ax		;Guarda el desplazamiento cero en la pila.
       mov    ax,SData		;Mueve la posición de SData al reg ax.
       mov    DS,ax		;Mueve la posición de ax (SData) al reg DS.
      
       
       ;aqui va el código de instrucciones
       ;del programa.
	   
	   lea dx,message ;xor dx,dx= mov dx,offset message
	   mov ah,09h
	   int 21h

       xor dx,dx    ; mov dx,offset message
	   mov ah,09h
	   int 21h

	   mov dx,offset message
	   mov ah,09h
	   int 21h
	   
	   mov dx,0
	   mov ah,09h
       int 21h

       
       
      

	   xor ax,ax		;Limpia el al y prepara el ah para la salida.
       mov ax,4c00h 	;Servicio AH=4c int 21h para salir del programa.
       int 21h	   		;Llamada al DOS. Termine el programa.
CSeg EndS 			;Fin del segmento de código.
     End Begin			;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.