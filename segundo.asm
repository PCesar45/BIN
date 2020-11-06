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
     
SData EndS

CSeg Segment para public 'Code'	;Define el segmento de código para tasm.
 Begin:
      Assume CS:CSeg, SS:SSeg	;Asignación de los segmentos a los registro de segmentos del CPU.
       
                        ;Va a reservar la dirección del PSP en el ES.       
       push   ax		;Guarda el desplazamiento cero en la pila.
       xor    ax,ax		;Pone en cero al reg ax.
       
       mov    ax,SData		;Mueve la posición de SData al reg ax.
       mov    DS,ax		;Mueve la posición de ax (SData) al reg DS.
  	   pop    ax

  	   mov ax,0003h
       int 10h
  	   
       push   ax                 ;Guarda el valor del ax para ser usado por la int.
       xor    ax,ax              ;limpia el valor del ax y lo prepara para la interrupción.
       lea    dx,Message         ;Coloca la dirección del desplazamiento de la etiqueta DS:Message 
       mov    ah,09              ;parámetro 09 del servicio de int 21 (imprimir en pantalla cadena terminada en $)
       int    21h                ;ejecute la interrupción, e imprima en pantalla.
       pop    ax                 ;equilibre la pila, saque y restaure al ax.

       mov ah,00
	   int 16h

       xor ax,ax		;Limpia el al y prepara el ah para la salida.
       mov ax,4c00h 	;Servicio AH=4c int 21h para salir del programa.
       int 21h	   		;Llamada al DOS. Termine el programa.
CSeg EndS 			;Fin del segmento de código.
     End Begin			;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa. 

