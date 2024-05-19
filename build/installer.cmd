@ECHO OFF
CLS

Title Creating DVDArt Installer

IF "%programfiles(x86)%XXX"=="XXX" GOTO 32BIT
    :: 64-bit
    SET PROGS=%programfiles(x86)%
    GOTO CONT
:32BIT
    SET PROGS=%ProgramFiles%
:CONT

IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Get version from DLL
FOR /F "tokens=*" %%i IN ('..\Tools\Tools\sigcheck.exe /accepteula /nobanner /n "..\DVDArt\DVDArt_Plugin\bin\Release\DVDArt_Plugin.dll"') DO (SET version=%%i)

:: Temp xmp2 file
COPY ..\MPEI\DVDArt_Plugin.xmp2 ..\MPEI\DVDArt_Plugin_Temp.xmp2

:: Build MPE1
CD ..\MPEI
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" DVDArt_Plugin_Temp.xmp2 /B /V=%version% /UpdateXML
CD ..\build

:: Cleanup
DEL ..\MPEI\DVDArt_Plugin_Temp.xmp2
