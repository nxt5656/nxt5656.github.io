# web shell

## ttyd
[下载地址](https://github.com/tsl0922/ttyd/releases)
```shell
wget "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.i686"
chmod 775 ttyd.i686
./ttyd.i686   --port 7681   --interface 0.0.0.0   --writable   --stdin   bash
# 然后在浏览器里打开 http://主机ip:7681
```


# teleport
不仅支持ssh 还支持数据库等资源
## 容器启动
[官方安装文档](https://goteleport.com/docs/installation/docker/)
```
docker pull public.ecr.aws/gravitational/teleport-distroless-debug:18.6.1
mkdir -p ./teleport/config ./teleport/data
docker run --hostname localhost --rm \
  --entrypoint=/usr/local/bin/teleport \
  public.ecr.aws/gravitational/teleport-distroless-debug:18.6.1 configure --roles=proxy,auth > ./teleport/config/teleport.yaml
  
docker run --hostname localhost --name teleport \
  -v ./teleport/config:/etc/teleport \
  -v ./teleport/data:/var/lib/teleport \
  -p 3025:3025 -p 3080:3080 \
  public.ecr.aws/gravitational/teleport-distroless-debug:18.6.1

curl --insecure https://localhost:3080/webapi/ping | jq

docker exec -ti teleport tctl users add admin --roles=editor,access
```