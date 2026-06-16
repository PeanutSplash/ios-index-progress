# ios-index-progress

[English](README.md)

查看 iOS 27 设备 Spotlight 索引进度的命令行工具。

升级 iOS 27 后，系统会重建 Spotlight 搜索索引（包括 Spotlight、照片、邮件），期间搜索功能可能不完整。此工具可以实时查看索引完成百分比。

## 使用方法

```bash
# 下载脚本
curl -fsSL https://raw.githubusercontent.com/PeanutSplash/ios-index-progress/main/ios-index-progress -o ios-index-progress
chmod +x ios-index-progress

# 默认监听 10 秒
./ios-index-progress

# 自定义监听时长（秒）
./ios-index-progress 30
```

## 前置条件

- macOS + [Homebrew](https://brew.sh)（脚本会自动安装依赖）
- iPhone 通过 USB 数据线连接到 Mac
- 手机上已点击「信任此电脑」
- **手机上需要打开「设置」App** 才会产生进度日志

## 示例输出

```
📱 监听 iPhone Spotlight 索引进度（10秒）...
   💡 请确保手机上已打开「设置」App
   按 Ctrl+C 提前退出

🔍 Spotlight 索引进度: 95%

✅ 监听结束。如需继续查看，请重新运行本脚本。
```

## 原理

通过 `libimobiledevice` 的 `idevicesyslog` 工具读取 iPhone 的系统日志，过滤 `PipelineCompleteness` 关键词获取 Spotlight 索引进度。该日志来自 `com.apple.Settings` 子系统的 `Spotlight Indexing Progress` 类别（DEBUG 级别）。

## License

MIT
