;prueba

SegDatos segment para "Data"
    nombre db 'nombre$'
SegDatos EndS ; fin del segmento de datos

segCodigo segment para "code"
  Inicio:
      assume CS:segCodigo

      xor ax,ax ;limpia el registro ax(acumulador)/lo pone en cero
      push ax ;Mete el registro ax a la pila
      mov ax,SegDatos ;mueve la posicion del segmento de datos al registro ax
      mov DS,ax  ;mueve el ax ya con el segDatos al registro DS(Data segment)
     ; pop    ax ;saca el ax de la pila

      lea dx,nombre ;lea=carga la direccion al registro (lea registro16,direccion)
      mov ah,09h ;le mueve al registro ah un 09 en hexadecimal por eso la h 
      int 21h  ;int = interrupcion /interrupcion 21,9(ah =09): imprime hasta toparse
            ; con el simbolo "$",              por eso en la linea anterior le movi un 09 al ah   

      xor ax,ax    ;Limpia el al y prepara el ah para la salida.
      mov ax,4c00h   ;Servicio AH=4c int 21h para salir del programa.
      int 21h        ;Llamada al DOS. Termine el programa.
segCodigo EndS ; fin del segmento de codigo
    End Inicio ;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.