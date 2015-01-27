PARAMETERS INNAME,FIELDSNAME,OUTNAME

_SCREEN.visible=.F.

SET SAFETY OFF
SET MEMOWIDTH TO 1500
SET CENTURY ON
SET MARK TO '-'
SET DATE TO ANSI

DECLARE INTEGER WriteConsole IN kernel32;
		INTEGER hConsoleOutput, STRING @lpBuffer,;
		INTEGER nNumberOfCharsToWrite,;
		INTEGER @lpNumberOfCharsWritten,;
		INTEGER lpReserved
		
DECLARE INTEGER GetLastError IN kernel32
DECLARE INTEGER AllocConsole IN kernel32
DECLARE INTEGER FreeConsole IN kernel32

DECLARE INTEGER ShowWindow IN user32 AS ShowWindowA;
    INTEGER hWindow, INTEGER nCmdShow
DECLARE INTEGER GetConsoleWindow IN kernel32
		
DECLARE INTEGER GetStdHandle IN kernel32 LONG nStdHandle

hStdOut = GetStdHandle(-11)


IF EMPTY(INNAME)
cMsg = "CSV->DBF converter version 0.10" + CHR(13) + CHR(10)
=WriteConsole(hStdOut, cMsg, LEN(cMsg),0,0)
cMsg = "Parameters: Data_filename Header_filename [Result_filename]"
=WriteConsole(hStdOut, cMsg, LEN(cMsg),0,0)
CANCEL
ENDIF

IF NOT FILE((INNAME))
cMsg = "CSV->DBF converter version 0.10" + CHR(13) + CHR(10)
=WriteConsole(hStdOut, cMsg, LEN(cMsg),0,0)
cMsg = "File not found: " + (INNAME)
=WriteConsole(hStdOut, cMsg, LEN(cMsg),0,0)
CANCEL
ENDIF


IF NOT FILE((FIELDSNAME))
SET DEVICE TO FILE (FIELDSNAME)
create cursor xtemp (mText m)
append blank
append memo mText from (INNAME) DELIMITED
myheader = mline(mText,1)
flid = CHRTRAN(myheader,',',CHR(13))
FOR n=1 to memlines(flid)
IF LEN(mline(flid,n))>10 AND occurs(mline(flid,n),myheader)>0
	@ n-1,0 SAY LEFT(ALLTRIM(mline(flid,n)),9)+ALLTRIM(STR(occurs(mline(flid,n),myheader)))+',C,22,0'
ELSE
	@ n-1,0 SAY LEFT(ALLTRIM(mline(flid,n)),10)+',C,22,0'
ENDIF
NEXT
SET DEVICE TO SCREEN
CLOSE ALL
ENDIF


&&SET DEFAULT TO D:\AA\292014
&&cMsg = '' + (INNAME) + ' ' + (FIELDSNAME) + ' ' + (OUTNAME) + CHR(13) + CHR(10)
&&=WriteConsole(hStdOut, cMsg, LEN(cMsg),0,0)
&&SET MEMOWIDTH TO 1500
create table xtemp (NAME c(22),TYPE c(1),LENG n(11),OTH n(1))
append from (FIELDSNAME) DELIMITED
COPY TO ARRAY arsha
lstr = ''
FOR n=1 TO ALEN(arsha) STEP 4
&&? ALLTRIM(arsha[n])
  lstr = lstr + IIF(n=1,'',',') + ALLTRIM(arsha[n])
NEXT
&&create table xtemp_edit (NAME c(22),TYPE c(1),LENG n(11),OTH n(1))
&&append from (FIELDSNAME) DELIMITED
&&COPY TO ARRAY arsha2
CREATE TABLE outtmp FROM ARRAY arsha
APPEND FROM (INNAME) DELIMITED
GOTO (1)
DELETE
PACK
SET MARK TO '.'
SET DATE TO GERMAN
COPY TO (OUTNAME) TYPE FOX2X &&FIELDS (mline(mText2,1))
CLOSE ALL DATABASES
DELETE FILE outtmp.dbf
DELETE FILE xtemp.dbf