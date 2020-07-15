cd /d %tmp%
if exist itunes_silent rd /s /q itunes_silent
md itunes_silent
cd itunes_silent

powershell.exe Start-BitsTransfer -Source "https://www.7-zip.org/a/7za920.zip" -Destination "7za920.zip"
powershell.exe Expand-Archive 7za920.zip .

reg.exe query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > nul && set os=32bit || set os=64bit

title %os%
if %os%==64bit goto 64bits

powershell.exe Start-BitsTransfer -Source "https://www.apple.com/itunes/download/win32" -Destination "itunes32.exe"
7za.exe e itunes32.exe *.msi

msiexec.exe /i AppleApplicationSupport.msi /qn REBOOT=ReallySuppress
msiexec.exe /i Bonjour.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleMobileDeviceSupport.msi /qn REBOOT=ReallySuppress
msiexec.exe /i AppleSoftwareUpdate.msi /qn REBOOT=ReallySuppress
msiexec.exe /i iTunes.msi /qn REBOOT=ReallySuppress

goto finish

:64bits

powershell.exe Start-BitsTransfer -Source "https://www.apple.com/itunes/download/win64" -Destination "itunes64.exe"
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