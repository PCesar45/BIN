@echo off
echo .
echo . -------------------------------------------
echo .    Menu compilacion prof. CBenavides.
echo . -------------------------------------------
echo 1. Compilacion de tasm, tlink y td
echo 2. Compilacion de solo tasm y no tlink no td
echo 3. Compilacion de tasm + libreria de procedimientos.
echo 4. Correr td.
echo 5. Salir.

rem Choice /C:abcde de una opcion 
if %1% ==  5 goto fin
if %1% ==  4 goto cuatro
if %1% ==  3 goto tres
if %1% ==  2 goto dos
if %1% ==  1 goto uno


:uno
  cls
  tasm /zi /l /w0 %2 > ERROR.TXT
  IF NOT EXIST %2.obj goto salir
  tlink /v %2
  td %2 %3 %4 %5 %6 %7 %8 %9 
  goto fin 
  :salir
  echo se produjo un error mire el archivo ERROR.TXT
  edit ERROR.TXT 
goto  fin

:dos
  cls
  tasm /zi /l /w0 %2
  edit ERROR.TXT 
goto fin

:tres
  cls
  tasm /zi /l /w0 %2 > ERROR.TXT
  IF NOT EXIST %2.obj goto salir
  tasm /zi /l /w0 %3 > ERROR.TXT
  IF NOT EXIST %3.obj goto salir
  tlink /v %2 + %3
  td %2 %3 %4 %5 %6 %7 %8 %9 
  goto fin 
  :salir
  echo se produjo un error mire el archivo ERROR.TXT
  edit ERROR.TXT 
goto  fin

:cuatro
  cls
  td %2 %3 %4 %5 %6 %7 %8 %9 
goto fin

:fin
cls