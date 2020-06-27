cd /d %tmp%
rd /s /q itunes_silent
md itunes_silent
cd itunes_silent

powershell.exe Invoke-WebRequest -Uri "http://stahlworks.com/dev/unzip.exe" -OutFile "unzip.exe"
powershell.exe Invoke-WebRequest -Uri "https://www.7-zip.org/a/7za920.zip" -OutFile "7za920.zip"
unzip.exe -o 7za920.zip 7za.exe

reg.exe query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set os=32bit || set os=64bit

title %os%
if %os%==64bit goto 64bits

powershell.exe Invoke-WebRequest -Uri "https://www.apple.com/itunes/download/win32" -OutFile "itunes32.exe"
7za.exe e itunes32.exe *.msi

msiexec.exe /i AppleApplicationSupport.msi /qn REBOOT=ReallySuppress
msiexec.exe /i Bonjour.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleMobileDeviceSupport.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleSoftwareUpdate.msi /qn REBOOT=ReallySuppress
msiexec.exe /i iTunes.msi /qn REBOOT=ReallySuppress

goto finish

:64bits

powershell.exe Invoke-WebRequest -Uri "https://www.apple.com/itunes/download/win64" -OutFile "itunes64.exe"
7za.exe e itunes64.exe *.msi

msiexec.exe /i AppleApplicationSupport.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleApplicationSupport64.msi /qn REBOOT=ReallySuppress
msiexec.exe /i Bonjour64.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleMobileDeviceSupport64.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleSoftwareUpdate.msi /qn REBOOT=ReallySuppress
msiexec.exe /i iTunes64.msi /qn REBOOT=ReallySuppress

:finish

cd /d %tmp%
rd /s /q itunes_silent
exit /b
