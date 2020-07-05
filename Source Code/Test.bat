@Echo off
cls

Title Graph 1.0 Demo File by TheBATeam - www.thebateam.org
Cd Files 2>nul >nul
Set "Path=%Path%;%cd%;%cd%\files"
Color 0a
Mode 80,25

:Main
Cls
Echo.
title TorqueVsCaster.plot

Call Graph x aa 0,99 10,88 20,77 30,66 40,55 50,44 60,33 70,22 80,11 90,5 100,3 110,2 120,1 130,0 140,50 150,90 160,120 190,0 200,100 220,0
pause>nul
cls
Call Graph * 0a -F TorqueVsCaster.plot

Pause>nul