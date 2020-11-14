;prueba

SegDatos segment para "Data"
    nombre db   0FFh Dup ('$')
SegDatos EndS ; fin del segmento de datos

ListPush  Macro lista
      IRP i,<lista>
         Push i
      EndM
EndM
 ListPop  Macro lista
        IRP i,<lista>
           Pop i
        EndM
  EndM
PushA Macro 
            ListPush <Ax, Bx, Cx, Dx, Si, Di, Bp, Sp>
      EndM                    ;Su contra parte es la macro siguiente. 

PopA Macro
                            ;...la pila del programa.
          Pop   Sp                  ;poner equilibrar la pila...
          Pop   Bp                  ;...solamente después de haber...
          Pop   Di                  ;...llamado antes a pushallregs.
          Pop   Si                  ;Sino se produce un error en el programa.
          Pop   Dx
          Pop   Cx
          Pop   Bx
          Pop   Ax
EndM
segCodigo segment para "code"

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
  Inicio:
      assume CS:segCodigo
      PushA 
      xor ax,ax ;limpia el registro ax(acumulador)/lo pone en cero
      push ax ;Mete el registro ax a la pila
      mov ax,SegDatos ;mueve la posicion del segmento de datos al registro ax
      mov DS,ax  ;mueve el ax ya con el segDatos al registro DS(Data segment)
     ; pop    ax ;saca el ax de la pila

     
      xor ax,ax
      Mov   Ax,Seg nombre
      Push  Ax
      Lea   Ax,nombre
      Push  Ax
      Call  GetCommanderLine 

      xor dx,dx
      xor ax,ax
      lea dx,nombre ;lea=carga la direccion al registro (lea registro16,direccion)
      mov ah,09h ;le mueve al registro ah un 09 en hexadecimal por eso la h 
      int 21h  ;int = interrupcion /interrupcion 21,9(ah =09): imprime hasta toparse
            ; con el simbolo "$",              por eso en la linea anterior le movi un 09 al ah   

      xor ax,ax    ;Limpia el al y prepara el ah para la salida.
      mov ax,4c00h   ;Servicio AH=4c int 21h para salir del programa.
      int 21h        ;Llamada al DOS. Termine el programa.
segCodigo EndS ; fin del segmento de codigo
    End Inicio ;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.