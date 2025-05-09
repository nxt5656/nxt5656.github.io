# Linux-搭建nfs服务

## 安装服务端
```
sudo apt update
sudo apt install -y nfs-kernel-server
```

## 配置服务端

``` 
# 创建nfs目录
mkdir /data/nfs
# 配置exports
sudo tee /etc/exports <<-'EOF'
/data/nfs *(rw,sync,no_subtree_check)
EOF
#配置生效,启动服务
sudo exportfs -a
sudo systemctl start nfs-kernel-server
sudo systemctl enable nfs-kernel-server
# 检查nfs
showmount -e 
```





## 安装客户端
```
sudo apt-get install -y  nfs-common
```