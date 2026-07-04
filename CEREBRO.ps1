# ==========================================
# CEREBRO DEPLOY v1.0
# ==========================================

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "====================================="
Write-Host "      CEREBRO DEPLOY INICIADO"
Write-Host "====================================="
Write-Host ""

# ==========================================
# COMPROBAR WINGET
# ==========================================

if (!(Get-Command winget -ErrorAction SilentlyContinue))
{
    Write-Host "ERROR: Winget no está disponible."
    exit
}

# ==========================================
# INSTALACION DE APLICACIONES
# ==========================================

$Apps = @(

    "Google.Chrome",
    "Google.Drive",
    "Tailscale.Tailscale",
    "RustDesk.RustDesk",
    "VideoLAN.VLC",
    "7zip.7zip",
    "Notepad++.Notepad++"

)

foreach ($App in $Apps)
{
    try
    {
        Write-Host ""
        Write-Host "Instalando: $App"

        winget install `
            --id $App `
            --exact `
            --silent `
            --accept-package-agreements `
            --accept-source-agreements

        Write-Host "OK -> $App"
    }
    catch
    {
        Write-Host "ERROR -> $App"
    }
}

# ==========================================
# PERSONALIZACION WINDOWS
# ==========================================

Write-Host ""
Write-Host "Aplicando personalizacion..."

# Modo oscuro

New-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    -Name "AppsUseLightTheme" `
    -Value 0 `
    -PropertyType DWord `
    -Force | Out-Null

New-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    -Name "SystemUsesLightTheme" `
    -Value 0 `
    -PropertyType DWord `
    -Force | Out-Null

# Mostrar extensiones

Set-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "HideFileExt" `
    -Value 0

# Mostrar archivos ocultos

Set-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "Hidden" `
    -Value 1

# Barra de tareas alineada a la izquierda

Set-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "TaskbarAl" `
    -Value 0 `
    -ErrorAction SilentlyContinue

# ==========================================
# CONFIGURACION DE ENERGIA
# ==========================================

Write-Host ""
Write-Host "Configurando energia..."

powercfg /hibernate off

powercfg /change standby-timeout-ac 0

powercfg /change monitor-timeout-ac 0

# ==========================================
# WALLPAPER CEREBRO
# ==========================================

Write-Host ""
Write-Host "Aplicando wallpaper..."

try
{
    $WallpaperFolder = "$env:PUBLIC\Pictures"

    if (!(Test-Path $WallpaperFolder))
    {
        New-Item `
            -ItemType Directory `
            -Path $WallpaperFolder `
            -Force | Out-Null
    }

    $WallpaperFile = "$WallpaperFolder\t3st-scr1pt.png"

    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/t3st-scr1pt/CEREBRO-DEPLOY/main/wallpapers/t3st-scr1pt.png" `
        -OutFile $WallpaperFile

    Set-ItemProperty `
        -Path "HKCU:\Control Panel\Desktop" `
        -Name Wallpaper `
        -Value $WallpaperFile

    RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

    Write-Host "Wallpaper aplicado."
}
catch
{
    Write-Host "No se pudo aplicar el wallpaper."
}

# ==========================================
# REINICIAR EXPLORADOR
# ==========================================

Write-Host ""
Write-Host "Actualizando explorador..."

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

Start-Process explorer.exe

# ==========================================
# FIN
# ==========================================

Write-Host ""
Write-Host "====================================="
Write-Host " CEREBRO DEPLOY FINALIZADO "
Write-Host "====================================="
Write-Host ""

Start-Sleep 5