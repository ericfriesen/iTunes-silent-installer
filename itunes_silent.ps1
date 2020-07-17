$TempDir = [System.IO.Path]::GetTempPath()
$WebClient = New-Object System.Net.WebClient
cd $TempDir
if ( Test-Path -Path 'itunes_silent' ) { Remove-Item itunes_silent -Recurse -Force }
md itunes_silent
cd itunes_silent
$destinationFolder = "$TempDir\itunes_silent"
$WebClient.DownloadFile("https://www.7-zip.org/a/7za920.zip","$TempDir\itunes_silent\7za920.zip")
$7z = "$TempDir\itunes_silent\7za920.zip"
$Destination = "$TempDir\itunes_silent"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($7z, $destination)
[System.IntPtr]::Size
if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit")
{
	$WebClient.DownloadFile("https://www.apple.com/itunes/download/win64","$TempDir\itunes_silent\itunes64.exe")
	Start-Process -Wait -FilePath ".\7za.exe" -ArgumentList "e itunes64.exe *.msi" -NoNewWindow
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleApplicationSupport.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleApplicationSupport64.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i Bonjour64.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleMobileDeviceSupport64.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleSoftwareUpdate.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i iTunes64.msi /qn REBOOT=ReallySuppress"
}
else
{
	$WebClient.DownloadFile("https://www.apple.com/itunes/download/win32","$TempDir\itunes_silent\itunes32.exe")
	Start-Process -Wait -FilePath ".\7za.exe" -ArgumentList "e itunes32.exe *.msi" -NoNewWindow
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleApplicationSupport.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i Bonjour.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleMobileDeviceSupport.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i AppleSoftwareUpdate.msi /qn REBOOT=ReallySuppress"
	Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList " /i iTunes.msi /qn REBOOT=ReallySuppress"
}
cd..
Remove-Item $TempDir\itunes_silent -Recurse -Force