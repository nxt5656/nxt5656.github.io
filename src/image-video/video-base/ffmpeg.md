# ffmpeg

<div id="tocw"></div>

[官方文档](https://www.ffmpeg.org/ffmpeg.html)

## 通过ffmpeg推流

使用 FFmpeg 将本地 MP4 文件推送到直播推流地址（RTMP 服务器）上，可以通过以下命令实现：

```bash  
ffmpeg -re -i input.mp4 -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k -c:a aac -b:a 128k -f flv rtmp://your_server/live/stream_key  
```  

### 参数解析：
1. **`-re`**：以实时模式读取输入文件。这是推流时必需的，它会以文件的帧率进行读取，而不是尽可能快地处理。
2. **`-i input.mp4`**：指定输入文件的路径，比如你的本地 MP4 文件。
3. **`-c:v libx264`**：指定视频编码器为 `libx264`（H.264 编码）。
4. **`-preset veryfast`**：编码速度和质量的平衡设置。`veryfast` 是常用的推流选项，编码速度较快，适合实时推流。
5. **`-b:v 3000k`**：设置视频码率为 3000kbps。可以根据实际需要调整。
6. **`-maxrate 3000k` 和 `-bufsize 6000k`**：设置最大码率和缓冲区大小，确保推流的稳定性。
7. **`-c:a aac`**：指定音频编码器为 AAC。
8. **`-b:a 128k`**：设置音频码率为 128kbps。可以根据需要调整。
9. **`-f flv`**：指定输出格式为 FLV。RTMP 推流使用 FLV 封装格式。
10. **`rtmp://your_server/live/stream_key`**：这是你的 RTMP 推流地址，需要替换为实际的推流 URL 和密钥。

### 示例
假如你的 RTMP 推流地址为：`rtmp://live.example.com/live`，推流密钥为：`stream123`，本地 MP4 文件为 `video.mp4`，命令如下：

```bash  
ffmpeg -re -i video.mp4 -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k -c:a aac -b:a 128k -f flv rtmp://live.example.com/live/stream123  
```  

### 注意事项
1. 确保你的 RTMP 推流服务器（如 Nginx + RTMP 模块、OBS 推流服务器等）已经配置好，并能正常工作。
2. 如果 MP4 文件的编码格式已经符合推流需求（如 H.264 视频和 AAC 音频），可以通过 `-c:v copy -c:a copy` 直接复制流，以避免重新编码，提高效率：
   ```bash  
   ffmpeg -re -i video.mp4 -c:v copy -c:a copy -f flv rtmp://live.example.com/live/stream123  
   ```  
3. 如果推流失败，检查网络连接、RTMP 地址是否正确，以及 FFmpeg 是否安装了相应的编码器。

### 常用的调试方法
- 查看 FFmpeg 输出日志，检查是否有错误信息。
- 使用工具（如 VLC 或 OBS）测试 RTMP 推流地址是否能正常播放。