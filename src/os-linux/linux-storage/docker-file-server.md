# Linux-使用Docker + filebrowser搭建文件管理服务

[filebrowser官方文档](https://filebrowser.org/installation)
要先安装[docker](/virtualization-container/virtualization-docker/docker-base.html)



```shell
# 拉取镜像
docker pull filebrowser/filebrowser

# 生成配置文件
mkdir -p filebrowser/storage
tee filebrowser/.filebrowser.json <<-'EOF'
{
  "port": 80,
  "baseURL": "",
  "address": "",
  "log": "stdout",
  "database": "/database/filebrowser.db",
  "root": "/srv"
}
EOF

# 运行容器
docker run \
  --name filebrowser \
  -p 8080:80 \
  -v $(PWD)/filebrowser/storage:/srv \
  -v $(PWD)/filebrowser/filebrowser.db:/database.db \
  -v $(PWD)/filebrowser/.filebrowser.json:/.filebrowser.json \
  -u $(id -u):$(id -g)  \
   -p 8080:80     \
   filebrowser/filebrowser
```

默认密码和账号都是:
admin