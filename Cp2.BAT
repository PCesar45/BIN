@echo off
echo .
echo . -------------------------------------------
echo .    Menu compilacion prof. CBenavides.
echo . -------------------------------------------
echo a. Compilacion de tasm, tlink y td
echo b. Compilacion de solo tasm y no tlink no td
echo c. Compilacion de tasm + libreria de procedimientos.
echo d. Correr td.
echo e. Salir.

Choice /C:abcde de una opcion 
if errorlevel 5 goto fin
if errorlevel 4 goto cuatro
if errorlevel 3 goto tres
if errorlevel 2 goto dos
if errorlevel 1 goto uno


:uno
  cls
  tasm /zi /l /w0 %1 > ERROR.TXT
  IF NOT EXIST %1.obj goto salir
  tlink /v %1
  td %1 %2 %3 %4 %5 %6 %7 %8 %9 
  goto fin 
  :salir
  echo se produjo un error mire el archivo ERROR.TXT
  edit ERROR.TXT 
goto  fin

:dos
  cls
  tasm /zi /l /w0 %1
  edit ERROR.TXT 
goto fin

:tres
  cls
  tasm /zi /l /w0 %1 > ERROR.TXT
  IF NOT EXIST %1.obj goto salir
  tasm /zi /l /w0 %2 > ERROR.TXT
  IF NOT EXIST %2.obj goto salir
  tlink /v %1 + %2
  td %1 %3 %4 %5 %6 %7 %8 %9 
  goto fin 
  :salir
  echo se produjo un error mire el archivo ERROR.TXT
  edit ERROR.TXT 
goto  fin

:cuatro
  cls
  td %1 %2 %3 %4 %5 %6 %7 %8 %9 
goto fin

:fin
cls