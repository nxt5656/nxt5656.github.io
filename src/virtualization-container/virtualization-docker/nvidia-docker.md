# Docker-安装nvida docker

前提: 安装好docker

[docker安装](./docker-base.md)

[官方安装文档](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installation)

## 一. 配置存储库
```shell
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
    | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
```

## 二. 安装 NVIDIA Container Toolkit 软件包
```shell
sudo apt-get install -y nvidia-container-toolkit
```

### 三. 配置 Docker 以使用 Nvidia 驱动程序
```shell
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```