# nodejs 版本管理工具nvm

[官方GITHUB链接](https://github.com/nvm-sh/nvm)

## nvm安装
版本可以从上面的官方链接查看
```shell
# curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

```

## node/npm 多版本的安装与使用
```shell
# 列出可安装的所有版本(linux&mac)
nvm ls-remote

# 列出可安装的所有版本(windows)
nvm available

# 安装指定版本
nvm install v22.16.0

# 切换到指定版本
nvm use v22.16.0

# 切换到最新版本
nvm use node

# 列出已安装的版本
nvm ls


# 快捷命令
nvm install node # 安装最新版 Node
nvm install iojs # 安装最新版 iojs
nvm install unstable # 安装最新不稳定版本的 Node
```
