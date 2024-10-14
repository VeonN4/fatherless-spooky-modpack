@echo off

cls

:menu
    ECHO.
    ECHO ...............................................
    ECHO Select Distribution
    ECHO ...............................................
    ECHO.
    ECHO 1 - CurseForge
    ECHO 2 - Modrinth
    ECHO 3 - Both
    ECHO 4 - EXIT
    ECHO.

    SET /P M=Type 1, 2, 3, or 4 then press ENTER:
    if %M%==1 (
        set modpack_distribution=curseforge
    ) 
    if %M%==2 (
        set modpack_distribution=Modrinth
    ) 
    if %M%==3 (
        set modpack_distribution=both
    ) 

cls

set "current_folder=%~dp0"

for /f "tokens=2 delims== " %%a in ('findstr "version" pack.toml') do set "modpack_version=%%a"
set "modpack_version=%modpack_version:"=%"  REM Remove any quotes

setlocal enabledelayedexpansion
for /f "tokens=2* delims== " %%a in ('findstr "name" pack.toml') do (
    set "modpack_name=%%a"
    set "modpack_name=!modpack_name:~1,-1!"
)

if not exist "%current_folder%dist" (
    echo Distribution folder doesn't exist
    echo Creating Distribution folder
    mkdir "%current_folder%dist"
) else (
    echo Distribution folder exist
)

if not exist "%current_folder%dist\%modpack_version%" (
    echo Modpack version folder doesn't exist
    echo Creating Modpack version folder
    mkdir "%current_folder%dist\%modpack_version%"
) else (
    echo Modpack version folder exist
)

echo.

if %modpack_distribution%==curseforge (
    echo Exporting %modpack_name% for CurseForge
    packwiz.exe curseforge export -o "%current_folder%dist\%modpack_version%\%modpack_name%_%modpack_distribution%-v%modpack_version%.zip"
)

pause
