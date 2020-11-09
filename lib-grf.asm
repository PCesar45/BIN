include macros.asm

public PonerModoVideo
;public PonerCoordenada
;public PonerPixel
Public TipoVideo

valorParametros equ 2
ProceFar        equ 2
ProceNear       equ 0

Datos Segment para public 'Datos'
 ;extrn filaG       :word
 ;extrn columnaG    :word
 ;extrn colorPixel  :byte

 	TipoVideo db ?
Datos EndS

Codigo segment
 Assume cs:Codigo , ds:Datos

 PonerModoVideo Proc far
 	;inicializa modo de video
 	mov ah,00h
 	mov al,TipoVideo
 	int 10h
 	ret
PonerModoVideo EndP

;PonerCoordenada Proc Far
;PonerCoordenada EndP

;PonerPixel Proc Far
;	mov ah,0ch
;	mov al,colorPixel
;	xor bh,bh
;	mov cx,filag
;	int 10h
;	ret
;PonerPixel EndP

Codigo EndS
End