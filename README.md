# ios-index-progress

[中文说明](README.zh-CN.md)

A CLI tool to check the real-time Spotlight indexing progress on iOS 27 devices.

After upgrading to iOS 27, the system rebuilds its entire search index (Spotlight, Photos, Mail). During this process, search may return incomplete results. This tool lets you monitor the exact completion percentage from your terminal.

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/PeanutSplash/ios-index-progress/main/ios-index-progress -o ios-index-progress
chmod +x ios-index-progress
./ios-index-progress
```

## Usage

```bash
# Monitor for 10 seconds (default)
./ios-index-progress

# Monitor for 30 seconds
./ios-index-progress 30
```

## Prerequisites

- macOS with [Homebrew](https://brew.sh) (the script auto-installs dependencies)
- iPhone connected to Mac via USB cable
- "Trust This Computer" confirmed on the iPhone
- **Settings app must be open on the iPhone** for progress logs to appear

## Example Output

```
📱 监听 iPhone Spotlight 索引进度（10秒）...
   💡 请确保手机上已打开「设置」App
   按 Ctrl+C 提前退出

🔍 Spotlight 索引进度: 95%

✅ 监听结束。如需继续查看，请重新运行本脚本。
```

## How It Works

Uses `idevicesyslog` from [libimobiledevice](https://libimobiledevice.org/) to read the iPhone's system logs, filtering for the `PipelineCompleteness` keyword. This is a DEBUG-level log from the `com.apple.Settings` subsystem under the `Spotlight Indexing Progress` category — the same data shown in macOS Console.app when connected to an iOS device.

## License

MIT
