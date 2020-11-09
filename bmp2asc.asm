;Examen1 de arquitectura de computadores
extrn PonerModoVideo	:far
Datos Segment para public 'Datos'
	extrn TipoVideo :byte
Datos EndS 

;----------------------------
Codigo Segment
Assume cs:Codigo , ds:Datos

Inicio:
	mov ax,Datos
	mov ds,ax

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
