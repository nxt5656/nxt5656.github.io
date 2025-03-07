# Docker-基础

## 一. Docker 安装
### 1.1 Linux安装

```shell
# 更新软件源 并安装docker及docker-compose
# Docker Compose 是一个用于定义和管理多容器 Docker 应用的工具。它通过一个单一的配置文件（通常是 docker-compose.yml 文件）来描述应用需要的服务、网络和数据卷等配置。借助 Docker Compose，开发者可以轻松地启动、停止和管理由多个容器组成的复杂应用。
sudo apt update && sudo  apt install -y docker.io docker-compose-v2 

# 添加当前用户到docker组,可以让非管理员用户可以使用docker命令,非必须
sudo usermod -aG docker $USER

# 生成docker配置文件,非必须
# data-root部分主要是为了将docker的数据目录移动到非默认目录,默认情况是/var/lib/docker,
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "data-root": "/data/docker-data",
  "log-driver":"json-file",
  "log-opts": {"max-size":"500m", "max-file":"3"},
  "registry-mirrors": ["https://hub.atomgit.com"]
}
EOF

# 重启docker服务,修改配置后,需要重新加载配置
systemctl daemon-reload
systemctl restart docker
```

### 1.2 其它系统安装
[官方安装链接](https://docs.docker.com/engine/install/)