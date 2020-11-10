; segmento de datos publicos y compartidos con otros programas

public ClearScreen 
public PrintfS
public PrintfC
public GotoXY
public WhereXY
public PrintHex
public LeerChar
public GetCommanderLine

valorParametros equ 2
ProceFar        equ 2
ProceNear       equ 0
      
Datos Segment para public 'Datos'
 extrn columnaT :Byte
 extrn filaT    :Byte
 extrn filaG	:Word
 extrn columnaG :Word

Procedimientos Segment
	Assume cs:Procedimientos,ds:datos

ClearScreen Proc Far
	   ;PushA			;Debe ser llamado afuera por el paso de parámetros.
       mov       ah,07		;Prepara servicio 07 para la int 10h. (desplazamiento de ventana hacia abajo).
       ;mov       al,25		;Número de líneas por desplazar en este caso total de filas 25.
       ;mov       bh,TextColor	;Atributo con que se va a desplazar; es decir; color. 00 = negro.
       ;mov       ch,00		;En donde comienza: fila de la esquina superior izquierda.
       ;mov       cl,00		;En donde comienza: columna de la esquina superior izquierda.
       ;mov       dh,25		;En donde termina:  fila de la esquina inferior derecha.
       ;mov       dl,80		;En donde termina:  columna de la esquina inferior derecha.
       int       10h		;ejecute la int 10h/ servicio 07h, desplaze la ventana hacia abajo.
       ;PopA			;Debe ser llamado afuera por el paso de parámetros.
       ret			;Se debe retornar o el programa se queda pegado.
ClearScreen EndP

PrintfS Proc Far
	;lea       dx,String      ;Este parámetro debe ser pasado afuera. 
       mov       ah,09          ;parámetro 09 del servicio de int 21 (imprimir en pantalla cadena terminada en $)
       int       21h            ;ejecute la interrupción, e imprima en pantalla.
       ret
PrintfS EndP

PrintfC Proc Far
	;PushA     	        ;Debe ser llamado afuera por el paso de parámetros.
       mov       ah,09          ;Servicio de int 21h / 02 imprimir un caracter en pantalla.
       ;mov       dl,Caracter   ;Este parámetro debe ser pasado afuera.
       mov       bh,00
       ;mov       bl,Atributo   ;Este parámetro debe ser pasado afuera.
       mov	 cx,1            
       int       10h            ;ejecute la interrupción, e imprima en pantalla.
       ;PopA     	    	;Debe ser llamado afuera por el paso de parámetros.
       ret
PrintfC EndP

GotoXY Proc Far
		mov ah,02
		mov bh,00
		mov dl,columnaT
		mov dh,filaT
		int 10h
		ret
GotoXY EndP


WhereXY Proc Far 
;------------------------------------------------------;
;                Parámetros de entrada                 ;
;------------------------------------------------------;
;       bh,Atributo.                                   ;
;------------------------------------------------------;
;                 Parámetros de salida                 ;
;------------------------------------------------------;
;       dh,Fila.                                       ;
;       dl,Columna.                                    ;
;------------------------------------------------------;

       ;PushA			;Debe ser llamado afuera por el paso de parámetros.
       mov	 ah,03
       ;mov	 bh,00
       int	 10h
       ;mov	 Col,dl
       ;mov	 Fil,dh
       ;PopA			;Debe ser llamado afuera por el paso de parámetros.
       ret
WhereXY EndP


PrintHex Proc Far
		;PushA			;Debe ser llamado afuera por el paso de parámetros.
       ;mov       al,Numero
       cmp       al,09h
       jnle      hex 
       ;PushA
       push      ax		;Guarda los todos los registro en... 
       push      bx		;...la pila del programa.
       push      cx		;Preparación para rutinas
       push      dx		;Debe tener cuidado de llamar a la...
       push      si		;...siguiente macro (PopAllRegs) para...
       push      di		;poner equilibrar la pila...
       pushf
       mov       bl,al
       add       al,48
       ;PushA
       push      ax		;Guarda los todos los registro en... 
       push      bx		;...la pila del programa.
       push      cx		;Preparación para rutinas
       push      dx		;Debe tener cuidado de llamar a la...
       push      si		;...siguiente macro (PopAllRegs) para...
       push      di		;poner equilibrar la pila...
       pushf
       call	 PrintfC
       ;PopA
       popf
       pop       di		;...llamado antes a pushallregs.
       pop       si		; Sino se produce un error en el programa.
       pop       dx
       pop       cx
       pop       bx
       pop       ax
       jmp short exit 
    hex: ;PushA
       push      ax		;Guarda los todos los registro en... 
       push      bx		;...la pila del programa.
       push      cx		;Preparación para rutinas
       push      dx		;Debe tener cuidado de llamar a la...
       push      si		;...siguiente macro (PopAllRegs) para...
       push      di		;poner equilibrar la pila...
       pushf
       mov       bl,al
       add       al,55
       call 	 PrintfC   
	exit: ;PopA			;Debe ser llamado afuera por el paso de parámetros.
	   popf
	   pop       di		;...llamado antes a pushallregs.
	   pop       si		; Sino se produce un error en el programa.
	   pop       dx
	   pop       cx
	   pop       bx
	   pop       ax
	   ret
PrintHex EndP

LeerChar Proc Far
	mov bp,sp
	mov ah,01h
	int 21h
	xor ah,ah
	mov Word ptr [bp+ProceFar+valorParametros*1],ax
	ret
LeerChar EndP

;------------------------------------------------------;
;                Parámetros de entrada                 ;
;------------------------------------------------------;
;       Bh,Atributo.                                   ;
;------------------------------------------------------;
;                 Parámetros de salida                 ;
;------------------------------------------------------;
;       Dh,Fila.                                       ;
;       Dl,Columna.                                    ;
;------------------------------------------------------;
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
       Mov   Si,2[LongLC]                        ;dos = uno por la posición 81h y uno más por el espacio en blanco.
       Rep   Movsb
       ListPop <Bp, Bx, Si, Di, Es>
       Ret   14
GetCommanderLine EndP

Procedimientos EndS
	 End