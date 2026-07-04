# ===================
# CEREBRO DEPLOY
# ===================

winget install Google.Chrome --silent
winget install Google.Drive --silent
winget install Tailscale.Tailscale --silent
winget install RustDesk.RustDesk --silent
winget install VideoLAN.VLC --silent
winget install 7zip.7zip --silent

# Modo oscuro

New-ItemProperty `
-Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize `
-Name AppsUseLightTheme `
-Value 0 `
-PropertyType DWord `
-Force

New-ItemProperty `
-Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize `
-Name SystemUsesLightTheme `
-Value 0 `
-PropertyType DWord `
-Force

# Explorador

Set-ItemProperty `
-Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced `
-Name HideFileExt `
-Value 0

Set-ItemProperty `
-Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced `
-Name Hidden `
-Value 1

# Energía

powercfg /hibernate off
powercfg /change standby-timeout-ac 0
powercfg /change monitor-timeout-ac 0