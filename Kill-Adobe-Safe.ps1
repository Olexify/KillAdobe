# Kill-Adobe-Safe.ps1
# Safer Adobe cleanup: stop common Adobe processes and set services to Manual
# Run as Administrator

$ErrorActionPreference = "SilentlyContinue"

Write-Host "Stopping common Adobe background processes..." -ForegroundColor Cyan

$processNames = @(
    "Creative Cloud",
    "Creative Cloud Helper",
    "CCXProcess",
    "CCLibrary",
    "CoreSync",
    "Adobe Desktop Service",
    "AdobeIPCBroker",
    "Adobe Notification Client",
    "AcrobatNotificationClient",
    "AdobeCollabSync",
    "AcroTray",
    "Adobe CEF Helper",
    "CEPHtmlEngine",
    "AdobeGCClient",
    "PDApp",
    "armsvc",
    "AdobeARM"
)

foreach ($name in $processNames) {
    Get-Process -Name $name -ErrorAction SilentlyContinue | Stop-Process -Force
    Write-Host "Tried to stop process: $name"
}

Write-Host "Stopping Adobe services and setting startup type to Manual..." -ForegroundColor Yellow

$serviceNames = @(
    "AdobeARMservice",
    "AdobeUpdateService",
    "AGSService",
    "AGMService",
    "AdobeDesktopService"
)

foreach ($svc in $serviceNames) {
    try {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Manual -ErrorAction SilentlyContinue
        Write-Host "Handled service: $svc"
    } catch {}
}

# Also handle display-name-based Acrobat updater if present
try {
    Get-Service | Where-Object { $_.DisplayName -eq "Adobe Acrobat Update Service" } | ForEach-Object {
        Stop-Service -Name $_.Name -Force -ErrorAction SilentlyContinue
        Set-Service -Name $_.Name -StartupType Manual -ErrorAction SilentlyContinue
        Write-Host "Handled service: $($_.DisplayName)"
    }
} catch {}

Write-Host "Done." -ForegroundColor Green