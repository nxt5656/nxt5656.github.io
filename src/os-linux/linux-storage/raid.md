# raid 配置

## Raid的对比
| RAID 类型     | 最少硬盘  | 容量利用率   | 容错能力 | 读写性能     | 说明                 |
| ----------- | ----- | ------- | ---- | -------- | ------------------ |
| **RAID 0**  | 2     | 100%    | ❌ 无  | ✅✅ 最高    | 纯性能，零容错，适合非关键数据    |
| **RAID 1**  | 2     | 50%     | ✅ 1块 | ✅ 普通     | 镜像，安全性高，容量减半       |
| **RAID 5**  | 3     | (n-1)/n | ✅ 1块 | ✅ 读快 写中等 | 条带+校验，性能与容错兼顾      |
| **RAID 6**  | 4     | (n-2)/n | ✅ 2块 | ✅ 读快 写较慢 | 比RAID5多一层校验，更安全    |
| **RAID 10** | 4（偶数） | 50%     | ✅ 半数 | ✅✅ 快     | RAID 1 + 0，性能与容错兼顾 |

## 安装配置
### 安装必要工具（所有 RAID 都需）
```
sudo apt update
sudo apt install -y mdadm
```
### RAID 0：性能优先，无容错
```
sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdX /dev/sdY
```
### RAID 1：镜像，数据安全
``` 
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdX /dev/sdY
```
### RAID 5：三块盘起，性能+冗余
``` 
sudo mdadm --create --verbose /dev/md0 --level=5 --raid-devices=3 /dev/sdX /dev/sdY /dev/sdZ
```

### RAID 6：四块盘起，双重容错
``` 
sudo mdadm --create --verbose /dev/md0 --level=6 --raid-devices=4 /dev/sdX /dev/sdY /dev/sdZ /dev/sdW
```
### RAID 10：RAID 1 + 0 组合
```
sudo mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 --layout=n2 /dev/sdX /dev/sdY /dev/sdZ /dev/sdW
```
### ✅ 后续步骤（所有 RAID 通用）
```
# 格式化文件系统：
sudo mkfs.ext4 /dev/md0
# 挂载：
sudo mkdir -p /mnt/raid
sudo mount /dev/md0 /mnt/raid
# 开机自动挂载:
sudo blkid /dev/md0
# 复制 UUID
sudo nano /etc/fstab
# 添加行：
UUID=xxx-xxx /mnt/raid ext4 defaults 0 0

# 查看 RAID 状态
cat /proc/mdstat
sudo mdadm --detail /dev/md0

# 保存 RAID 配置（用于开机自动识别）
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u

# 销毁 RAID 阵列（小心使用）
sudo umount /mnt/raid
sudo mdadm --stop /dev/md0
sudo mdadm --remove /dev/md0
sudo mdadm --zero-superblock /dev/sdX /dev/sdY ...

```