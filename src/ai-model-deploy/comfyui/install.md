# comfyui

[官方文档](https://docs.comfy.org/zh-CN/get_started/introduction) 

```shell
docker run -d \
--name comfyui-test \
--gpus all \
-p 8188:8188 \
-h comfyui-test  \
-v $(pwd)/comfyui-data:/workspace/data \
nvcr.io/nvidia/pytorch:25.01-py3  sleep 300d

docker exec -ti comfyui-test bash
# 这里设置代理(国内)

git clone https://github.com/comfyanonymous/ComfyUI /workspace/ComfyUI
git clone https://github.com/ltdrdata/ComfyUI-Manager /workspace/ComfyUI/custom_nodes/comfyui-manager
grep -v 'torchaudio\|torchvision' /workspace/ComfyUI/requirements.txt > /workspace/ComfyUI/temp_requirements.txt
python -m pip install --upgrade pip && pip install -r /workspace/ComfyUI/temp_requirements.txt
mv /workspace/ComfyUI/models /workspace/ComfyUI/models_link
ln -s /workspace/ComfyUI/models_link/configs /workspace/data/models/configs
ln -s /workspace/data/models /workspace/ComfyUI/models

python /workspace/ComfyUI/main.py --listen
```