@echo off
:: =============================================================================
::  build.bat  -  Automated portable EXE build script
::
::  Developer  : Sebastian Januchowski
::  Company    : polsoft.ITS Group
::  E-mail     : polsoft.its@fastservice.com
::  GitHub     : https://github.com/seb07uk
::  Copyright  : 2026 Sebastian Januchowski & polsoft.ITS Group
::
::  Requirements:
::    Python 3.10+   https://www.python.org
::    pip packages:  PyQt6  sounddevice  numpy  pyinstaller
::
::  Output:
::    dist\dyktafon.exe   (standalone portable EXE, no installer needed)
:: =============================================================================

setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1
title polsoft.ITS - Dyktafon Build Script v4.0.0

echo.
echo ================================================================
echo   polsoft.ITS Group  -  Dyktafon / Voice Recorder  v4.0.0
echo   Build Script
echo ================================================================
echo.

:: -----------------------------------------------------------------------
:: Step 1 - Check Python
:: -----------------------------------------------------------------------
echo [1/6] Checking Python installation...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Python not found.
    echo   Please install Python 3.10+ from https://www.python.org
    goto :fail
)
for /f "tokens=*" %%V in ('python --version 2^>^&1') do echo   Found: %%V
echo   OK

:: -----------------------------------------------------------------------
:: Step 2 - Install dependencies
:: -----------------------------------------------------------------------
echo.
echo [2/6] Installing required packages...

python -m pip install --upgrade pip --quiet
if %ERRORLEVEL% NEQ 0 goto :fail

python -m pip install --upgrade PyQt6 --quiet
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Failed to install PyQt6
    goto :fail
)

python -m pip install --upgrade sounddevice numpy --quiet
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Failed to install sounddevice or numpy
    goto :fail
)

python -m pip install --upgrade pyinstaller --quiet
if %ERRORLEVEL% NEQ 0 (
    echo   ERROR: Failed to install PyInstaller
    goto :fail
)

for /f "tokens=*" %%V in ('pyinstaller --version 2^>^&1') do echo   PyInstaller %%V - OK
echo   All packages installed OK

:: -----------------------------------------------------------------------
:: Step 3 - Verify required files
:: -----------------------------------------------------------------------
echo.
echo [3/6] Verifying build files...

if not exist "dyktafon.py" (
    echo   ERROR: dyktafon.py not found in current directory
    echo   Make sure you run this script from the folder containing dyktafon.py
    goto :fail
)
echo   dyktafon.py        - found

set "ICON_ARG="
if exist "icon.ico" (
    echo   icon.ico           - found
    set "ICON_ARG=--icon=icon.ico"
) else (
    echo   WARNING: icon.ico not found - building without icon
)

set "VERSION_ARG="
if exist "version_info.txt" (
    echo   version_info.txt   - found
    set "VERSION_ARG=--version-file=version_info.txt"
) else (
    echo   WARNING: version_info.txt not found - building without version info
)

:: -----------------------------------------------------------------------
:: Step 4 - Clean previous build
:: -----------------------------------------------------------------------
echo.
echo [4/6] Cleaning previous build artefacts...

if exist "dist\dyktafon.exe" (
    del /f /q "dist\dyktafon.exe" >nul 2>&1
    echo   Removed dist\dyktafon.exe
)
if exist "build" (
    rmdir /s /q "build" >nul 2>&1
    echo   Removed build\ folder
)
echo   Clean OK

:: -----------------------------------------------------------------------
:: Step 5 - Check UPX (optional compression)
:: -----------------------------------------------------------------------
echo.
echo [5/6] Checking UPX (optional compression)...

set "UPX_ARG=--noupx"
upx --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    for /f "tokens=2" %%V in ('upx --version 2^>^&1 ^| findstr /i "upx"') do (
        echo   UPX %%V found - compression enabled
        set "UPX_ARG="
    )
) else (
    echo   UPX not found - building without compression
    echo   Download UPX from https://upx.github.io for smaller .exe
)

:: -----------------------------------------------------------------------
:: Step 6 - Build EXE
:: -----------------------------------------------------------------------
echo.
echo [6/6] Building portable EXE...
echo.

if exist "dyktafon.spec" (
    echo   Using dyktafon.spec ...
    pyinstaller dyktafon.spec --clean --noconfirm
    if %ERRORLEVEL% NEQ 0 goto :fail
) else (
    echo   Building from command line...
    pyinstaller --onefile --windowed --name dyktafon --clean --noconfirm %ICON_ARG% %VERSION_ARG% %UPX_ARG% --hidden-import sounddevice --hidden-import numpy --hidden-import PyQt6.QtCore --hidden-import PyQt6.QtGui --hidden-import PyQt6.QtWidgets --hidden-import cffi --hidden-import _cffi_backend --exclude-module tkinter --exclude-module matplotlib --exclude-module scipy --exclude-module pandas dyktafon.py
    if %ERRORLEVEL% NEQ 0 goto :fail
)

:: -----------------------------------------------------------------------
:: Verify output and report
:: -----------------------------------------------------------------------
if not exist "dist\dyktafon.exe" (
    echo   ERROR: dist\dyktafon.exe was not created
    goto :fail
)

for %%F in ("dist\dyktafon.exe") do set "EXE_SIZE=%%~zF"
set /a "EXE_MB=!EXE_SIZE! / 1048576"

echo.
echo ================================================================
echo   BUILD SUCCESSFUL
echo ================================================================
echo   Output  : dist\dyktafon.exe
echo   Size    : ~!EXE_MB! MB
echo   Type    : Portable - no installation required
echo ================================================================
echo.
echo   The executable is self-contained and can be run directly
echo   from any Windows machine without Python installed.
echo.
echo Press any key to open the output folder...
pause >nul
explorer dist
goto :end

:: -----------------------------------------------------------------------
:fail
echo.
echo ================================================================
echo   BUILD FAILED
echo ================================================================
echo   Check the error messages above and try again.
echo.
echo   Common fixes:
echo     - Run as Administrator if permission errors occur
echo     - Ensure antivirus is not blocking PyInstaller
echo     - Try: pip install pyinstaller --force-reinstall
echo.
pause
exit /b 1

:end
endlocal