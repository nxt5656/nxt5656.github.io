# Linux-内存

## 内存使用分析
```
# 1. free命令
free -h  

# 2. top命令
top 

# 3. htop
htop

# 4. vmstat命令
vmstat 1  

# 5. ps命令
ps aux --sort=-%mem | head -n 10  

# 6. 使用 /proc/meminfo
cat /proc/meminfo  

# 7. 使用 smem
apt -y install smem  
smem -r -k 

# 8. 使用 pmap,pmap 可以用于显示进程的内存映射情况。
pmap <pid>  

9. 使用 sar
apt -y install sysstat  
sar -r 1  

```



## 内存相关操作
```
# 清理内存
# 同步,将内存中数据写入磁盘
sync
# 清理缓存
echo 1 > /proc/sys/vm/drop_caches
```