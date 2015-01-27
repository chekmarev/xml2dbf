@setlocal enableextensions enabledelayedexpansion
@SET /A MIN=!TIME:~3,1!*10+!TIME:~4,1!
@SET /A SEC=!TIME:~-5,-4!*10+!TIME:~-4,-3!
@SET /A MS=!TIME:~-2,-1!*10+!TIME:~-1!
@SET /A TIMER1=100*60*!MIN!+100*!SEC!+!MS!
@msxsl -? 2>NUL 2>&1 | FIND /I "microsoft"
@msxsl %1 bench.xsl > %TMP%\bench2.log
@SET BENCH=
@FOR /F %%i in (%TMP%\bench2.log) do @SET /A BENCH=%%i
@SET /A MIN=!TIME:~3,1!*10+!TIME:~4,1!
@SET /A SEC=!TIME:~-5,-4!*10+!TIME:~-4,-3!
@SET /A MS=!TIME:~-2,-1!*10+!TIME:~-1!
@SET /A TIMER2=100*60*!MIN!+100*!SEC!+!MS!
@SET /A ELAPSED1=^(1+!TIMER2!-!TIMER1!^)
@SET /A RES=!BENCH! * !ELAPSED1!
@SET /A MS2=!ELAPSED1! %% 100
@SET /A MIN2=!ELAPSED1! / 100 / 60
@SET /A SEC2=^( !ELAPSED1! / 100 ^) - ^( !MIN2! * 60 ^)
@SET /A MS3=!RES! %% 100
@SET /A MIN3=!RES! / 100 / 60
@SET /A SEC3=^( !RES! / 100 ^) - ^( !MIN3! * 60 ^)
@ECHO.
@ECHO Nodes:!BENCH! Run:!ELAPSED1! !MIN2!:!SEC2!.!MS2! ms Estimate:!RES! !MIN3!:!SEC3!.!MS3! ms
@ECHO !RES!  > %TMP%\bench.log
