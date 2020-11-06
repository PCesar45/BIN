;-------------------------------------------;
;Estructura de un programa en ensamblador,  ;
;para arquitectura 8086/8088/80306 mips     ;
;Creado por: Ing. Carlos Benavides C. MsC.  ;
;Propósito: Docente, académico, ejemplo.    ;
;Forma de compilación:                      ;
;  Usando el turbo assembler de borland 4.  ;
;    tasm /zi /l cuarto[.asm]              ;
;    tlink /v cuarto[.oobj]                ;
;                                           ;
; y si lo quiere depurar turbo debuger      ;
;                                           ;
;      td cuarto[.exe]                     ;
; FUM: Mayo 16, 2003.                       ;
;-------------------------------------------;

 public Noiguales
 public Siiguales
Datos Segment para 'Data'
     
     Mensaje db 'Hola Mundo',10,13,'$'
     Noiguales db 'No son iguales$'
     Siiguales db 'si son iguales$'
     noNumero db  10,13,'No ingreso un numero ,vuelva ha ingresar',10,13,'$'
     siNumero db 'Si es un numero $'
     DelTeclado db ?
     multiplicador db 10d
     Otro db 'quiere imprimir otro$'
Datos EndS
   Include macroST.cbc		;Llama la lib de macros...

Datos2 Segment ;Un programa puede  tener varios segmentos de la ,isma clase
	varia db 'Segundo msg$'
Datos2 EndS
	
 extrn IfIguales :near

Codigo Segment para public 'Code'  ;Define el segmento de código para tasm.
   
    Amarrilo EQU 14d
    ColIzq db 0
    FilIzq db 0
    ColDer db 79
    FilDer db 24
    Atri db Amarrilo

    
    extrn IfIguales :near
   
     Assume cs:Codigo, ds:Datos
     
     Inicio:

     	 Inilicializar
     	 limpiarPantalla FilIzq,ColIzq,FilDer,ColDer,Atri
     	 imprimeString Mensaje

     	 push ax
     	 Pedir:
			LeeCaracter DelTeclado
			GuardaPrimerCaracter DelTeclado		

			Esnum ;revisa si lo que esta en el al es un digito
			jz siEsNum
			jnz Pedir
			siEsNum:
			UneCarateres DelTeclado
			
			Esnum2
			jz siEsNum2
			jnz Pedir
			siEsNum2:
			add DelTeclado,al

			xor ax,ax
			mov al,DelTeclado
			mov ah,Amarrilo
			
			call ifIguales
			
			pop ax 
		Finalizar 
Codigo EndS                        ;Fin del segmento de código.
     End Inicio                    ;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.