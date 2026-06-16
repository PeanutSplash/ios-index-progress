# Check iOS 27 Spotlight indexing progress
# Usage: .\ios-index-progress.ps1 [seconds]
#   Default 10 seconds, pass a number to customize
#   Requires iPhone connected via USB with Settings app open

param(
    [int]$Duration = 10
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "❌ scoop or chocolatey is required. Install scoop: https://scoop.sh" -ForegroundColor Red
        exit 1
    }
    $PackageManager = "choco"
} else {
    $PackageManager = "scoop"
}

if (-not (Get-Command idevicesyslog -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installing libimobiledevice..."
    if ($PackageManager -eq "scoop") {
        scoop install libimobiledevice
    } else {
        choco install libimobiledevice -y
    }
    Write-Host ""
}

$deviceId = & idevice_id -l 2>$null
if (-not $deviceId) {
    Write-Host "❌ No iPhone detected. Please check:" -ForegroundColor Red
    Write-Host "   1. iPhone is connected via USB cable"
    Write-Host "   2. 'Trust This Computer' is confirmed on the iPhone"
    exit 1
}

Write-Host "📱 Monitoring iPhone Spotlight indexing progress (${Duration}s)..."
Write-Host "   💡 Make sure the Settings app is open on your iPhone"
Write-Host "   Press Ctrl+C to exit early"
Write-Host ""

$lastPct = ""
$job = Start-Job -ScriptBlock {
    & idevicesyslog --match "PipelineCompleteness" 2>&1
}

$deadline = (Get-Date).AddSeconds($Duration)
while ((Get-Date) -lt $deadline) {
    $output = Receive-Job -Job $job -ErrorAction SilentlyContinue
    if ($output) {
        foreach ($line in $output) {
            if ($line -match '(\d+)%') {
                $pct = $Matches[1] + "%"
                if ($pct -ne $lastPct) {
                    $lastPct = $pct
                    Write-Host "🔍 Spotlight indexing progress: $pct"
                }
            }
        }
    }
    Start-Sleep -Milliseconds 500
}

Stop-Job -Job $job -ErrorAction SilentlyContinue
Remove-Job -Job $job -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "✅ Done. Run the script again to check latest progress."
