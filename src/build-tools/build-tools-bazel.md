# 构建工具-Bazel

## Bazel配置缓存 
### 配置本地缓存目录

1. 可以手动指定：

```
bazel build --disk_cache=/path/to/local/cache //target
```
2. 或者写入 .bazelrc：

```
build --disk_cache=/path/to/local/cache
```

### 配置远程缓存（HTTP 示例）
1. 启动远程缓存服务器（可选）
```
docker run -d -p 8080:8080 \
  -v /your/cache/dir:/data \
  buchgr/bazel-remote --dir=/data --max_size=10
```

2. Bazel 连接远程缓存：
```
bazel build --remote_cache=http://localhost:8080 \
            --remote_timeout=60 \
            --experimental_remote_downloader=grpc \
            --experimental_remote_cache_compression
```
或在.bazelrc中配置
```
build --remote_cache=http://localhost:8080
build --experimental_remote_cache_compression
build --experimental_remote_downloader=grpc
```

### 常用缓存相关参数说明
```
--disk_cache	设置本地磁盘缓存路径
--remote_cache	设置远程缓存地址
--experimental_remote_cache_compression	开启压缩
--experimental_remote_downloader=grpc	使用 gRPC 加速缓存下载
--noremote_upload_local_results	只从远程读缓存，不写入（适合 pull-only 的场景）
--remote_timeout=60	设置远程超时（秒）
--experimental_guard_against_concurrent_changes	避免并发修改导致缓存不一致
```
### 其它
```
# 清理本地缓存
bazel clean --expunge
```