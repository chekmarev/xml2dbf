chcp 1251>NUL
REG ADD "HKCR\xmlfile\shell\������������� Xpack\command" /ve /t REG_SZ /d "%~d0%~p0xpack.bat %%1"