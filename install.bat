@echo off
setlocal EnableDelayedExpansion

set DIR=%USERPROFILE%\medivia
set ZIP=%DIR%\medivia.zip
set EXTRACT_DIR=%DIR%\medivia-maps-main

set FLAGS=%EXTRACT_DIR%\flags.otml
set CONFIG=%DIR%\config.otml
set CONFIG_TMP=%DIR%\config.tmp.otml
set CONFIG_BKP=%DIR%\config.bkp.otml

curl -L "https://github.com/caioedut/medivia-maps/archive/main.zip" -o "%ZIP%"
PowerShell.exe Expand-Archive -Force -Path "%ZIP%" -DestinationPath "%DIR%"
xcopy /s/Y "%EXTRACT_DIR%\minimap\*" "%DIR%\minimap\*"

move %CONFIG% %CONFIG_BKP%
break>%CONFIG%

set /a ignore=0

for /f "Tokens=* Delims=" %%G in (!CONFIG_BKP!) do (
    set line=%%G

    set sub1=!line:~2,6!
    set sub2=!line:~2,5!

    IF !sub2! == zoom: (
        set ignore=0
    )

    IF !ignore! == 0 IF NOT !line! == "" (
        ECHO !line!>>!CONFIG!
    )

    IF !sub1! == flags: (
        type !FLAGS! >> !CONFIG!
        set ignore=1
    )
)

del "%ZIP%
del /F/Q/S "%DIR%\minimap_cache"
del /F/Q/S "%DIR%\medivia-maps-main"
rmdir /Q/S "%DIR%\medivia-maps-main"

EXIT /b 0
