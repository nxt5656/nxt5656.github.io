# GPU-机器基础环境安装

<div id="tocw"></div>


## 安装 CUDA Toolkit

CUDA Toolkit 是由 NVIDIA 开发的一套用于 GPU 加速计算的开发工具包。它是 CUDA (Compute Unified Device Architecture) 技术的核心组成部分，允许开发者使用 NVIDIA GPU 来执行并行计算。CUDA Toolkit 提供了一整套工具、库和编译器，使开发者能够更高效地开发和优化 GPU 应用程序。

*建议使用runfile方式安装*
[官方下载地址](https://developer.nvidia.com/cuda-downloads)

Linux Ubuntu:24.04 安装Demo

```shell
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda_12.8.1_570.124.06_linux.run
sudo sh cuda_12.8.1_570.124.06_linux.run
```


## 安装