@setlocal enableextensions enabledelayedexpansion
@FOR /F "tokens=1,2,3,4" %%I in ('CHCP') do @SET PIC=%%L
@CHCP 1251 > NUL
@SET /A MIN=!TIME:~3,1!*10+!TIME:~4,1!
@SET /A SEC=!TIME:~-5,-4!*10+!TIME:~-4,-3!
@SET /A MS=!TIME:~-2,-1!*10+!TIME:~-1!
@SET /A TIMER1=100*60*!MIN!+100*!SEC!+!MS!
@IF NOT "%1"=="" (
SET AN=%~n1
) ELSE (
ECHO %0 ^<Имя xml файла^>
GOTO :EOF
)
@IF NOT "%2"=="" (
SET FN=%2
) ELSE (
SET FN=%~n1
)
@IF NOT EXIST "%~d1%~p1!FN:.dbf=!.dbf" @(
@SET /P PRP=Оценка оставшегося времени: < NUL
@call bench.bat %~d1%~p1!AN:.xml=!.xml >NUL 2>NUL
@FOR /F %%I in (%TMP%\bench.log) do @SET /A EST=%%I
@FOR /F "tokens=1,2" %%I in (%TMP%\bench2.log) do @ECHO Узлов: %%J
@SET /A MS4=!EST! %% 100
@SET /A MIN4=!EST! / 100 / 60
@SET /A SEC4=^( !EST! / 100 ^) - ^( !MIN4! * 60 ^)
@ECHO !MIN4! m !SEC4! s !MS4! ms
@msxsl -? 2>NUL 2>&1 | FIND /I "microsoft"
call %~d0%~p0msxsl.exe %~d1%~p1!AN:.xml=!.xml %~d0%~p0fsa2dbg.xsl | call %~d0%~p0msxsl.exe - %~d0%~p0fil1.xsl -o %TMP%\tet2.xml
@SET /A MIN=!TIME:~3,1!*10+!TIME:~4,1!
@SET /A SEC=!TIME:~-5,-4!*10+!TIME:~-4,-3!
@SET /A MS=!TIME:~-2,-1!*10+!TIME:~-1!
@SET /A TIMER2=100*60*!MIN!+100*!SEC!+!MS!
@SET /A ELAPSED1=^(1+!TIMER2!-!TIMER1!^)
@SET /A MS3=!ELAPSED1! %% 100
@SET /A MIN3=!ELAPSED1! / 100 / 60
@SET /A SEC3=^( !ELAPSED1! / 100 ^) - ^( !MIN3! * 60 ^)
@SET /P PR=!MIN3!:!SEC3!.!MS3!^>Обследуется заголовок dbf...< NUL
@call %~d0%~p0msxsl.exe %TMP%\tet2.xml %~d0%~p0fil2.xsl > %~d0%~p0tet3.xml
@SET /A MIN=!TIME:~3,1!*10+!TIME:~4,1!
@SET /A SEC=!TIME:~-5,-4!*10+!TIME:~-4,-3!
@SET /A MS=!TIME:~-2,-1!*10+!TIME:~-1!
@SET /A TIMER2=100*60*!MIN!+100*!SEC!+!MS!
@SET /A ELAPSED=^(1+!TIMER2!-!TIMER1!^) 
@SET /A MS1=!ELAPSED! %% 100
@SET /A MIN1=!ELAPSED! / 100 / 60
@SET /A SEC1=^( !ELAPSED! / 100 ^) - ^( !MIN1! * 60 ^)
ECHO OK
@SET /P PR=!MIN1!:!SEC1!.!MS1!^>Заполняется dbf...< NUL
@call %~d0%~p0msxsl %TMP%\tet2.xml %~d0%~p0fil3.xsl > %TMP%\tet4.xml
@call %~d0%~p0msxsl %TMP%\tet4.xml %~d0%~p0head.xsl > %TMP%\ATF.txt
@call %~d0%~p0msxsl %TMP%\tet4.xml %~d0%~p0plain.xsl > %TMP%\result.txt
@SET /A MIN=!TIME:~3,1!*10+!TIME:~4,1!
@SET /A SEC=!TIME:~-5,-4!*10+!TIME:~-4,-3!
@SET /A MS=!TIME:~-2,-1!*10+!TIME:~-1!
@SET /A TIMER2=100*60*!MIN!+100*!SEC!+!MS!
@SET /A ELAPSED=^(1+!TIMER2!-!TIMER1!^)
@SET /A MS2=!ELAPSED! %% 100
@SET /A MIN2=!ELAPSED! / 100 / 60
@SET /A SEC2=^( !ELAPSED! / 100 ^) - ^( !MIN2! * 60 ^)
@ECHO OK
@ECHO %1 > %TMP%\xpack.log
@call %~d0%~p0cdbf %TMP%\result.txt %TMP%\ATF.txt %~d1%~p1!FN:.dbf=!
) ELSE @(
@ECHO Заметка %1: dbf файл существует
)
)
@IF EXIST "%~d1%~p1!FN:.dbf=!.dbf" @(
start /I "" "%~d1%~p1!FN:.dbf=!.dbf"
)
@CHCP !PIC! > NUL