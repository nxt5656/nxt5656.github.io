# Linux-时间相关

<div id="tocw"></div>

---  

### 1. **更新系统时间并同步**
Ubuntu 系统通常使用 `systemd-timesyncd` 或 `ntp` 服务来同步时间。

#### 使用 `timedatectl` 同步时间：
```bash  
sudo timedatectl set-ntp true  
```  
这将启用自动网络时间同步功能。

#### 检查当前时间状态：
```bash  
timedatectl status  
```  
输出中应该看到 `NTP synchronized: yes`，表示时间同步成功。

#### 手动强制同步时间（可选）：
如果自动同步未立即生效，可以通过安装并使用 `ntpdate` 手动同步：
```bash  
sudo apt update  
sudo apt install ntpdate -y  
sudo ntpdate ntp.ubuntu.com  
```  
   
---  

### 2. **设置时区为上海**
时区可以通过 `timedatectl` 或直接修改 `/etc/localtime` 来设置。

#### 使用 `timedatectl` 设置：
```bash  
sudo timedatectl set-timezone Asia/Shanghai  
```  

#### 验证时区设置：
```bash  
timedatectl  
```  
输出中应该显示 `Time zone: Asia/Shanghai`。
   
---  

### 3. **更新时间同步工具（可选）**
如果你希望使用更强大的时间同步服务，可以安装 `chrony`（推荐）或 `ntp`。

#### 安装 Chrony：
```bash  
sudo apt install chrony -y  
sudo systemctl enable chrony  
sudo systemctl start chrony  
```  

#### 检查 Chrony 状态：
```bash  
chronyc tracking  
```  
   
---  

### 4. **验证时间与时区**
最后，检查系统时间是否正确：
```bash  
date  
```  
输出中应该显示北京时间（上海时区）。
   
---  

完成以上步骤后，Ubuntu 的时间将同步并设置为上海时区。