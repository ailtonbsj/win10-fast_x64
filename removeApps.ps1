# Set-ExecutionPolicy RemoteSigned

# List All Apps Names
#  Get-AppxPackage | Select Name, PackageFullName

Get-AppxPackage *Weather* | Remove-AppxPackage
Get-AppxPackage *Getstarted* | Remove-AppxPackage
Get-AppxPackage *FeedbackHub* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *OneNote* | Remove-AppxPackage
Get-AppxPackage *Phone* | Remove-AppxPackage
Get-AppxPackage *holographic* | Remove-AppxPackage
Get-AppxPackage *MSPaint* | Remove-AppxPackage
Get-AppxPackage *Print3D* | Remove-AppxPackage
Get-AppxPackage *3DViewer* | Remove-AppxPackage
Get-AppxPackage *Skype* | Remove-AppxPackage
Get-AppxPackage *Spotify* | Remove-AppxPackage
Get-AppxPackage *xbox* | Remove-AppxPackage
Get-AppxPackage *CandyCrush* | Remove-AppxPackage
Get-AppxPackage *MixedReality* | Remove-AppxPackage
Get-AppxPackage *OneConnect* | Remove-AppxPackage
Get-AppxPackage *office* | Remove-AppxPackage
Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage

ps onedrive | Stop-Process -Force
start-process "$env:windir\SysWOW64\OneDriveSetup.exe" "/uninstall"
