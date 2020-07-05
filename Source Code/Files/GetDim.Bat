@Echo off
SetLocal EnabledelayedExpansion
REM GetDim Function ver.1.0 by kvc;
REM It Returns the current Dimensions of cmd console, which is calling this Function.

REM Syntax: Call GetDim [Rows] [Columns]

Rem Visit https://batchprogrammers.blogspot.com for more extensions / plug-ins like this.... :]
Rem #TheBATeam


REM Checking things...
If /i "%~1" == "" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "-help" (goto :help)

If /i "%~1" == "ver" (echo.1.0&&goto :eof)

If /i "%~2" == "" (goto :help)


REM Main Code of function...
For /f "Skip=3 tokens=1,2" %%A in ('mode') do (Set %%A=%%B)
Endlocal && Set "%~1=%Lines:%" && Set "%~2=%Columns:%"
Goto :EOF

:help
Echo.
Echo. This function Simply Returns the current Dimensions of cmd console,
Echo. in Two variables provided.
echo.
echo. Syntax: Call GetDim [Rows] [Columns]
echo. Syntax: call GetDim [help ^| /^? ^| -h ^| -help]
echo. Syntax: call GetDim ver
echo.
echo. Where:-
Echo. Rows		= The Variable to save 'No. of Rows	[Y]'
Echo. Columns	= The Variable to save 'No. of Columns	[X]'
echo. Help		= Shows this screen.
echo. ver		= Version of the function.
echo.
echo. Visit https://batchprogrammers.blogspot.com for more...
echo. #Kvc with #TheBATeam
goto :eof