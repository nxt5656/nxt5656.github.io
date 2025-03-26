# ollama-部署配置

<div id="tocw"></div>

## 使用docker 部署
模型小的情况下,可以直接使用cpu来部署ollama

### 只使用cpu
前提: [安装docker](../../virtualization-container/virtualization-docker/docker-base.html)


```shell
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

前提:
[安装nvidia-docker](../../virtualization-container/virtualization-docker/nvidia-docker.html)

```shell
# 使用所有的GPU来部署
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
# 使用指定的GPU来部署
docker run -d --gpus '"device=1"' -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

```


## 拉取模型
[模型列表](https://ollama.com/library)
```shell
docker exec -ti ollama ollama pull deepseek-r1:32b
```

## 测试是否可用
```shell
curl http://127.0.0.1:11434/api/generate -d '{
  "model": "deepseek-r1:32b",
  "prompt":"杭州最高的楼",
  "stream": false
}'
```

## 通过 Open webui来使用ollama上的模型服务
[open webui](https://github.com/open-webui/open-webui)

```shell
```
# 同主机
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
# 不同主机
docker run -d -p 3001:8080 -e OLLAMA_BASE_URL=http://ollama服务器:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```
```