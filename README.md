# ios-index-progress

[中文说明](README.zh-CN.md)

A CLI tool to check the real-time Spotlight indexing progress on iOS 27 devices.

After upgrading to iOS 27, the system rebuilds its entire search index (Spotlight, Photos, Mail). During this process, search may return incomplete results. This tool lets you monitor the exact completion percentage from your terminal.

## Quick Start

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/PeanutSplash/ios-index-progress/main/ios-index-progress -o ios-index-progress
chmod +x ios-index-progress
./ios-index-progress
```

### Windows (PowerShell)

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PeanutSplash/ios-index-progress/main/ios-index-progress.ps1" -OutFile "ios-index-progress.ps1"
.\ios-index-progress.ps1
```

## Usage

```bash
# macOS - monitor for 10 seconds (default)
./ios-index-progress

# macOS - monitor for 30 seconds
./ios-index-progress 30

# Windows PowerShell
.\ios-index-progress.ps1
.\ios-index-progress.ps1 -Duration 30
```

## Prerequisites

- **macOS**: [Homebrew](https://brew.sh) installed (the script auto-installs dependencies)
- **Windows**: [Scoop](https://scoop.sh) or [Chocolatey](https://chocolatey.org) installed (the script auto-installs dependencies)
- iPhone connected via USB cable
- "Trust This Computer" confirmed on the iPhone
- **Settings app must be open on the iPhone** for progress logs to appear

## Example Output

```
📱 Monitoring iPhone Spotlight indexing progress (10s)...
   💡 Make sure the Settings app is open on your iPhone

🔍 Spotlight indexing progress: 95%

✅ Done. Run the script again to check latest progress.
```

## How It Works

Uses `idevicesyslog` from [libimobiledevice](https://libimobiledevice.org/) to read the iPhone's system logs, filtering for the `PipelineCompleteness` keyword. This is a DEBUG-level log from the `com.apple.Settings` subsystem under the `Spotlight Indexing Progress` category — the same data shown in macOS Console.app when connected to an iOS device.

## License

MIT
