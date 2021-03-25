regedit /s explorer.reg
regedit /s performance.reg
regedit /s taskbar.reg
REM regedit /s wallpaper.reg
regedit /s transparency.reg
regedit /s login.reg
regedit /s disableAntiSpyware.reg
regedit /s update.reg
regedit /s cortana.reg
regedit /s notifications.reg
regedit /s time.reg

copy StartLayout.xml C:\
regedit /s startMenu.reg

del /q "%userprofile%\Desktop\Microsoft Edge.lnk"

REM Windows Update
net stop wuauserv
net stop bits
net stop dosvc

sc config wuauserv start=disabled
sc config bits start= disabled
sc config dosvc start= disabled

reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\ /v NoAutoUpdate /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU\ /v NoAutoUpdate /t REG_DWORD /d 1 /f

REM wmic useraccount where name="%USERNAME%" get sid

REM [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SystemProtectedUserData\S-1-5-21-150643285-2270290189-2103209189-1001\AnyoneRead\LockScreen]
REM "HideLogonBackgroundImage"=dword:00000001

powershell Set-ExecutionPolicy RemoteSigned
powershell .\removeApps.ps1

taskkill /f /im OneDrive.exe
timeout 1
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
