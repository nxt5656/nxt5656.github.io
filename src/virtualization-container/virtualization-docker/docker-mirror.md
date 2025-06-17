# Docker-镜像加速

[官方部署文档](https://distribution.github.io/distribution/about/deploying/)
## 实现效果
1. 使用自有域名
2. 使用证书

## 必须的条件
1. 有域名
2. 有证书(可以通过cloudflare来实现)
3. 安装docker 和 docker compose

## 操作过程
### 1. 创建目录
```shell
mkdir cache certs config
```

### 2. 创建配置文件:
```shell
sudo tee config/config.yml <<-'EOF'
version: 0.1
log:
  fields:
    service: registry
storage:
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  secret: asecretforlocaldevelopment
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
proxy:
  remoteurl: https://registry-1.docker.io
mirrors:
 - source: ghcr.io
   endpoint:
    - https://ghcr.io
EOF
```
### 3. 创建docker compose 文件
```shell
sudo tee config/config.yml <<-'EOF'
version: '3'
services:
  registry:
    image: registry:2
    restart: always
    ports:
      - "5000:5000"
    volumes:
      - ./config:/etc/docker/registry
      - ./cache:/var/lib/registry
EOF
```

最终目录结构如下:
```plan9_x86
├── cache
├── certs
│   ├── 域名.key
│   └── 域名.pem
├── config
│   └── config.yml
└── docker-compose.yml
```

### 4. 启动
```shell
docker compose up  -d
```


## nginx的配置

待添加
## cloudflare的配置
待添加