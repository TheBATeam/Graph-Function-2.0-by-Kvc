@Echo off
Setlocal enabledelayedexpansion

REM Checking important files...
FOR %%A In (GetDim.bat Fn.dll batbox.exe Line.bat) DO (IF Not Exist "%%A" (Echo. Graph Function, Error... File [%%A] is Missing...))

REM Description:
REM This Graph function simply plots multiple Characters (maybe '*') on the cmd console...
REM As specified to the function through passed arguments or a'Graph file'.

REM This Function is Created by Kvc At,10:05 AM 1/6/2016 ... 

REM It maybe useful in mathematical calculations,graphs, Analysis etc.

REM We hope, you'll like our work... Show your love and Response at our Blog:
REM https://batchprogrammers.blogspot.com


REM Setting-up console Size...
Set _Console_Height=40
Set _Console_Width=150


Set Error=1
If /i "%~1" == "" (goto :help)
If /i "%~2" == "" (goto :help)

Set Error=0
If /i "%~1" == "/h" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "ver" (Echo.2.0&&goto :Eof)

REM Setting-up necessary variables for the function...
Set "_Char=%~1"
Set "_Char=!_Char:~0,1!"
Set _Color=%~2
Set _String=
Set _Points=
Set /A _Previous_X=%~3 2>nul >nul
Set /A _Previous_Y=%~4*-1
Set _Count=0

Set _Min_X=0
Set _Min_Y=0
Set _Max_X=0
Set _Max_Y=0

If /i "%~3" == "-F" (Goto :For_Loop)
Shift /3
Shift /3

:Loop
If /i "%~3" == "" (Goto :Next)
Set /a _Y=%~4*-1

Set _X_!_Count!=%~3
Set _Y_!_Count!=!_Y!

Set /a _Count+=1

If %~3 LSS !_Min_X! (Set _Min_X=%~3)
If %~3 GTR !_Max_X! (Set _Max_X=%~3)
If !_Y! LSS !_Min_Y! (Set _Min_Y=!_Y!)
If !_Y! GTR !_Max_Y! (Set _Max_Y=!_Y!)

Shift /3
Shift /3
goto :Loop

:For_Loop
If NOT Exist "%~4" (Exit /b 404)

For /f "usebackq eol=# Tokens=1,2 delims=," %%A in ("%~4") do (
If /I "!_Previous_X!" == "0" (
	Set _Previous_X=%%A
	Set /A _Previous_Y=%%B*-1
	) ELSE (
	Set /a _Y=%%B*-1

	Set _X_!_Count!=%%A
	Set _Y_!_Count!=!_Y!

	Set /a _Count+=1
	)

If %%A LSS !_Min_X! (Set _Min_X=%%A)
If %%A Gtr !_Max_X! (Set _Max_X=%%A)
If !_Y! LSS !_Min_Y! (Set _Min_Y=!_Y!)
If !_Y! Gtr !_Max_Y! (Set _Max_Y=!_Y!)
)

:Next
Call :Setup_Graph
Call :Scaling

REM Handling little Error...
Set /A _Previous_X=!_Previous_X! / !_Scaling_Factor_For_X! 2>nul
Set /A _Previous_Y=!_Previous_Y! / !_Scaling_Factor_For_Y! 2>nul

REM Setting-up the Main String...
For /l %%A in (0,1,!_count!) do (
	Set /a _X=!_X_%%A! / !_Scaling_Factor_For_X! 2>nul
	Set /a _Y=!_Y_%%A! / !_Scaling_Factor_For_Y! 2>nul

	Call Line !_Previous_X! !_Previous_Y! !_X! !_Y! !_Char! !_Color! _Result
	Set "_String=!_String! !_Result!"
	Set "_Points=!_Points!/g !_X! !_Y! /d "!_Char!" "

	Set _Previous_X=!_X!
	Set _Previous_Y=!_Y!
)

:End
Batbox /o 0 !_Console_Height! !_String! !_Numbering! /c 0x0c !_Points! /c 0x07 
Exit /b 0


:help
Echo.
Echo. This function simply prints a Specified Character on the cmd console at
Echo. the specified location. The Bottom-left of the console is taken origin
Echo. then points are plotted against that origin.
ECHo. It maybe helpful in various mathematical operations, or graphs,Analysis
Echo.
Echo. Syntax: Call Graph [Char] [Color] [Co-ord] [Co-ord] [Co-ord] ...
Echo.         Call Graph [Char] [Color] -F "File.Plot"
Echo.         Call Graph [-h ^| help ^| /^? ^| /h]
Echo.         Call Graph [ver]
Echo.         
Echo. Where:
Echo. Char:		Character to represent printing of Points on console...
Echo. Color:		Hexadecimal color code for the Character...
Echo. Ver:		To know version of current plot Function...
Echo. File.plot:	Plot File, It will contain all the co-ordinates to be 
Echo. 		printed on the cmd console...
Echo. Co-Ord:	Co-Ordinates in the form of {X,Y}...
ECHo. -h,help,/h,/?:	To get this help menu...
Echo.
Echo. Example: Call Graph * 0a 2,2 3,3 4,4 5,5 6,6 7,7 8,8
Echo. Example: Call Graph * 0c -F "Example.Plot"
Echo. 
Echo. For more: visit, https://batchprogrammers.blogspot.com #TheBATeam
Exit /b %error%

:Setup_Graph

Fn.dll Font 0
Mode !_Console_Width!,!_Console_Height!

REM Extra Decoration module for Graph function...
Set /A _Console_Height-=1
Set /A _Console_Width-=1

REM FOR /L %%A In (0,5,!_Console_Height!) Do (Call Line 0 %%A !_Console_Width! %%A 250 08)
REM FOR /L %%A In (0,10,!_Console_Width!) Do (Call Line %%A 0 %%A !_Console_Height! 250 08)
Goto :EOF

:Scaling
REM Scaling algorithm by kvc... To scale Both axis, so all specified co-ordinates should be on the graph...
REM Removing negative sign... Or finding their absolute values...
For %%A in (_Max_X _Max_Y _Min_X _Min_Y) do (Set %%A=!%%A:-=!)

REM == For X-Axis
Set /a _Required_Divisions=!_Max_X!+!_Min_X!
Set /a _Scaling_Factor_For_X=(!_Required_Divisions! / !_Console_Width!) + 1

REM == For Y-Axis
Set /a _Required_Divisions=!_Max_Y!+!_Min_Y!
Set /a _Scaling_Factor_For_Y=(!_Required_Divisions! / !_Console_Height!) + 1

REM Numbering Algorithm by kvc... To print Numbers besides the point on axis...
REM Note: The co-ordinates for numbering system are after the change of origin of console from top left corner to the centre of the console...

REM == For origin...
Set "_Numbering=/g 1 0 /d "0" "

REM == For X-Axis
For /l %%A in (5,5,!_Console_Width!) do (
	Set /a _Digit=%%A*!_Scaling_Factor_For_X!
	Set "_Numbering=!_Numbering!/g %%A 0 /d "!_Digit!" "
)

REM == For Y-Axis
For /l %%A in (5,5,!_Console_Height!) do (
	Set /a _Digit=%%A*!_Scaling_Factor_For_Y!
	Set "_Numbering=!_Numbering!/g 0 -%%A /d "!_Digit!" "
)
Goto :EOF