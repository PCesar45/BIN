extrn LeerChar 			:far
extrn GotoXY   			:far
extrn PonerModoVideo	:far
extrn PonerPixel        :far

Datos Segment para public 'Datos'
public columnaT 
public filaT
public colorPixel
public columnag
public filag

extrn TipoVideo :byte
	
	Coordenada label Word
		filaT     db  ?
		columnaT  db  ?

	;Coordenada label xxxxxxxxxxxxxxxxx
		filaG      dw   ?
		columnaG   dw   ?
		colorPixel db   4
Datos EndS 
;----------------------------
Codigo Segment
Assume cs:Codigo , ds:Datos

Inicio:
	mov ax,Datos
	mov ds,ax

	mov TipoVideo,18
	call PonerModoVideo

	mov filag,100
	mov columnag,50
	mov cx,250
  otropixel:
  	push cx
  	call PonerPixel
  	pop cx
  	inc columnag
  	inc filag
  loop otropixel

  	call LeerChar

  	mov TipoVideo,3
  	call PonerModoVideo

  	mov ax,4c00h
  	int 21h
 Codigo EndS
 	End Inicio
