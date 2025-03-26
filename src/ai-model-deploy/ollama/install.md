# ollama-部署配置

<div id="tocw"></div>

## 使用docker 部署

### 只使用cpu
前提: [安装docker](../../virtualization-container/virtualization-docker/docker-base.html)


```shell
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

前提:
[安装nvidia-docker](../../virtualization-container/virtualization-docker/nvidia-docker.html)

```shell
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```