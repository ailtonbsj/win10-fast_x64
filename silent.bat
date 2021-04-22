copy StartLayout.xml C:\

regedit /s cortana-voiceActivationDisableAboveLockscreen.reg
regedit /s disableActivityFeed.reg
regedit /s disableLockScreenReminders.reg
regedit /s disableLogonBackgroundImage.reg
regedit /s disableRotatingLockScreen.reg
regedit /s disableSubscribedContent.reg
regedit /s disableTransparency.reg
regedit /s explorer-disableAnimationsAndShadow.reg
regedit /s explorer-disableRecentAndFrequent.reg
regedit /s explorer-showFileExt.reg
regedit /s startMenu-hideRecentlyAddedApps.reg
regedit /s startMenu-removeTiles.reg
regedit /s taskbar-removeCortanaAndPeopleBand.reg
regedit /s update-ActiveHours.reg

@rem Get arguments from command line
set dayLight=True
for %%i in (%*) do (
 if "%%i" == "/w" (
  set wall=True
 )
 if "%%i" == "/d" (
  set defender=True
 )
 if "%%i" == "/u" (
  set update=True
 )
 if "%%i" == "/t" (
  set dayLight=False
 )
)

if "%wall%" == "True" (
 echo Applying Wallpaper
 regedit /s changeWallpaper.reg
)
if "%defender%" == "True" (
 echo Applying Defender
 reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f
 regedit /s defender-disableAntiSpyware.reg
 PowerShell Set-MpPreference -DisableRealtimeMonitoring 1
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
)
if "%update%" == "True" (
 echo Applying Update
 net stop bits
 regedit /s update-DisableDoSvc.reg
 sc config bits start=disabled
 reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\ /v NoAutoUpdate /t REG_DWORD /d 1 /f
 reg add HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU\ /v NoAutoUpdate /t REG_DWORD /d 1 /f
 net stop wuauserv
 sc config wuauserv start=disabled
 net stop dosvc
 sc config dosvc start=disabled
)
if "%update%" == "True" (
 regedit /s disableDynamicDaylightTime.reg
)

@rem Remove variables
set "wall="
set "defender="
set "update="

@rem Remove MetroApps
powershell Set-ExecutionPolicy RemoteSigned
powershell .\removeApps.ps1

@rem Remove OneDrive
taskkill /f /im OneDrive.exe
timeout 1
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall

del /q "%userprofile%\Desktop\Microsoft Edge.lnk"
del /q "%public%\Desktop\Microsoft Edge.lnk"
shutdown /r -t 0

@rem wmic useraccount where name="%USERNAME%" get sid
