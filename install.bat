set DIR=%USERPROFILE%\medivia
set ZIP=%DIR%\medivia.zip

curl -L "https://github.com/caioedut/medivia-maps/archive/main.zip" -o "%ZIP%"

PowerShell.exe Expand-Archive -Force -Path "%ZIP%" -DestinationPath "%DIR%"

xcopy /s/Y "%DIR%\medivia-maps-main\minimap\*" "%DIR%\minimap\*"

del "%ZIP%
del /F/Q/S "%DIR%\minimap_cache"
del /F/Q/S "%DIR%\medivia-maps-main"
rmdir /Q/S "%DIR%\medivia-maps-main"

EXIT /b 0
