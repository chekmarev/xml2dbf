This program takes input as shown in example files header.txt and result.txt located in this directory and converts them to DBF file.
Header file has following format: <COLUMN NAME>,<COLUMN TYPE: C=CHAR,N=NUMBER>,<FIELD SIZE>,<DEFAULT=0>
Result.txt is simple csv file separated with comma.
After you compile it with MS Visual Fox Pro 5.0, make sure to run 'editbin /SUBSYSTEM:CONSOLE your_binary.exe' to get rid of blinking white screen of visual fox pro when the program starts.
Editbin is a part of Microsoft Visual C++ Tools. You could use any tool to change PE Header if you wish to recompile this program.
Also, you have to create a new project in Visual Fox Pro 5.0, add 'oor2.prg' to Code\Programs and 'config.fpw' to All\Text files to get rid of blinking white screen of visual fox pro when the program starts.
