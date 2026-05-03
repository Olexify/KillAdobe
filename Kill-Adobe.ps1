# Kill-Adobe.ps1
# Run as Administrator

$ErrorActionPreference = "SilentlyContinue"

Write-Host "Stopping Adobe processes and services..." -ForegroundColor Cyan

# Known common Adobe / Creative Cloud / updater / licensing processes
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
    "AdobeUpdateService",
    "Adobe Installer",
    "Adobe Crash Processor",
    "AdobeGCClient",
    "AGSService",
    "AGMService",
    "AdobeARM",
    "armsvc",
    "PDApp",
    "node"
)

foreach ($name in $processNames) {
    Get-Process -Name $name -ErrorAction SilentlyContinue | Stop-Process -Force
}

# Also kill any process whose name/path/company suggests Adobe / Creative Cloud
Get-CimInstance Win32_Process | ForEach-Object {
    $p = $_
    $match = $false

    if ($p.Name -match 'Adobe|Acro|Creative Cloud|CCX|CoreSync|AGM|AGS|GC') {
        $match = $true
    }

    if ($p.ExecutablePath -and $p.ExecutablePath -match 'Adobe|Creative Cloud') {
        $match = $true
    }

    if ($match) {
        try {
            Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
            Write-Host "Killed PID $($p.ProcessId): $($p.Name)"
        } catch {}
    }
}

# Stop Adobe-related services
$serviceNames = @(
    "AdobeARMservice",
    "AdobeUpdateService",
    "AGSService",
    "AGMService",
    "AdobeDesktopService",
    "Adobe Acrobat Update Service"
)

foreach ($svc in $serviceNames) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
}

# Also stop any installed service whose display name or service name mentions Adobe
Get-Service | Where-Object {
    $_.Name -match 'Adobe|AGS|AGM|Acro' -or $_.DisplayName -match 'Adobe|Creative Cloud|Acrobat'
} | ForEach-Object {
    try {
        Stop-Service -Name $_.Name -Force -ErrorAction SilentlyContinue
        Write-Host "Stopped service: $($_.Name)"
    } catch {}
}

Write-Host "Done." -ForegroundColor Green