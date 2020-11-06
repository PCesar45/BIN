@echo off

 tasm /zi /l /w0 %1 > ERROR.TXT
 IF NOT EXIST %1.obj GOTO salir
 tlink /v %1
 td %1 %2 %3 %4 %5 %6 %7 %8 %9 
 GOTO fin 
 :salir
 echo se produjo un error mire el archivo ERROR.TXT
 :fin