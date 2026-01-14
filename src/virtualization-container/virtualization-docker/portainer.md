# 容器管理工具-portainer


[官方文档](https://docs.portainer.io/start/install-ce/server/docker/linux)

## 安装
```
{Ny|_8U("\tN
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always  -v portainer_data:/data portainer/portainer-ce:lts



```