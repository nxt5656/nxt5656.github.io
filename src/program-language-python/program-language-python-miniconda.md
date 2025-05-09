# 编程语言-Python-miniconda

## miniconda的安装
```shell
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
```

## conda的简单操作
```
# 查看版本
conda --version
# 更新conda
conda update conda
# 创建新环境
conda create --name <环境名称> python=<版本号>
# 激活环境
conda activate <环境名称>
# 退出环境
conda deactivate
# 列出环境
conda env list
# 删除环境
conda remove --name <环境名称> --all
# 导出环境配置
conda env export > environment.yml
# 从配置文件创建环境
conda env create -f environment.yml
# 镜像加速
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
# 删除已添加的镜像源（如果需要清理配置）
conda config --remove-key channels
```

## 环境内操作
```
# 安装包
conda install <包名>
conda install jupyterlab
pip install jupyterlab-language-pack-zh-CN
python -m ipykernel install --user --name=zb-dev --display-name "Python zb-dev"
conda run -n py3_wj -m ipykernel install --user --name=zb-dev --display-name "Python zb-dev"


# 更新包
conda update <包名>
# 卸载包
conda remove <包名>

```