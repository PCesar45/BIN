
;-------------------------------;
;     Definici�n de Macros	;
;(afuera del segmento de c�digo);
;-------------------------------;

PushA Macro 
       push      ax		;Guarda los todos los registro en... 
       push      bx		;...la pila del programa.
       push      cx		;Preparaci�n para rutinas
       push      dx		;Debe tener cuidado de llamar a la...
       push      si		;...siguiente macro (PopAllRegs) para...
       push      di		;poner equilibrar la pila...
       push      bp		;...sino lo hace el programa se cae...
       push      sp		;...y da un error.
       push      ds		;Note que el �ltimo elemento del pushallregs...
       push      es		;...es el primer elemento en salir en popallregs.
       push      ss
       pushf			;Guarda el registro de banderas en la pila.
EndM				;Su contra parte es la macro siguiente. 

PopA Macro
       popf		        ;...la pila del programa.
       pop       ss	        ;Esto se hace despu�s de la llamada a una rutina
       pop       es	        ;Debe tener cuidado de llamar a esta...
       pop       ds	        ;...macro (PopAllRegs) para...
       pop       sp	        ;poner equilibrar la pila...
       pop       bp		;...solamente despu�s de haber...
       pop       di		;...llamado antes a pushallregs.
       pop       si		; Sino se produce un error en el programa.
       pop       dx
       pop       cx
       pop       bx
       pop       ax
EndM
   
ClearScreen Macro TextColor
       PushA
       mov       ah,07		;Prepara servicio 07 para la int 10h. (desplazamiento de ventana hacia abajo).
       mov       al,25		;N�mero de l�neas por desplazar en este caso total de filas 25.
       mov       bh,TextColor	;Atributo con que se va a desplazar; es decir; color. 00 = negro.
       mov       ch,00		;En donde comienza: fila de la esquina superior izquierda.
       mov       cl,00		;En donde comienza: columna de la esquina superior izquierda.
       mov       dh,25		;En donde termina:  fila de la esquina inferior derecha.
       mov       dl,80		;En donde termina:  columna de la esquina inferior derecha.
       int       10h		;ejecute la int 10h/ servicio 07h, desplaze la ventana hacia abajo.
       PopA
EndM

PrintfS Macro String
       lea       dx,String      ;Coloca la direcci�n del desplazamiento de la etiqueta DS:Message 
       mov       ah,09          ;par�metro 09 del servicio de int 21 (imprimir en pantalla cadena terminada en $)
       int       21h            ;ejecute la interrupci�n, e imprima en pantalla.
EndM

PrintfC Macro Caracter, Atributo
       PushA     	        ;Guarde todos los registros.
       mov       ah,09          ;Servicio de int 21h / 02 imprimir un caracter en pantalla.
       mov       dl,Caracter    ;Caracter Ascii a imprimir.
       mov       bh,00
       mov       bl,Atributo
       and       bl,00001111b
       mov	 cx,1
       int       10h            ;ejecute la interrupci�n, e imprima en pantalla.
       PopA     	    	;Saque todos los registros.
EndM

GotoXY Macro X,Y
       PushA
       mov       ah,02
       mov	 bh,00
       mov	 dl,X
       mov	 dh,Y
       int 	 10h
       PopA
EndM

WhereXY Macro 
       PushA
       mov	 ah,03
       mov	 bh,00
       int	 10h
       mov	 Col,dl
       mov	 Fil,dh
       PopA
EndM

PrintHex Macro Numero
       local     hex, exit
       PushA
       mov       al,Numero
       cmp       al,09h
       jnle      hex 
       add       al,48
       PrintfC   al,Numero
       jmp short exit 
  hex: add       al,55  
       PrintfC   al,Numero
 exit: PopA
EndM
