# 生成证书


## 签发根证书

### 1. 创建OpenSSL配置文件
首先，创建一个OpenSSL配置文件，例如`openssl.cnf`。该文件可以包含如下内容：
```
[ req ]  
default_bits       = 2048  
default_keyfile    = rootCA.key  
distinguished_name = req_distinguished_name  
x509_extensions    = v3_ca  
prompt             = no  
   
[ req_distinguished_name ]  
C                   = CN                  # 国家  
ST                  = Beijing             # 省份  
L                   = Beijing             # 城市  
O                   = My Company          # 组织名称  
OU                  = My Unit             # 组织单位  
CN                  = My Root CA          # 公共名称 
   
[ v3_ca ]  
subjectKeyIdentifier = hash  
authorityKeyIdentifier = keyid:always,issuer  
basicConstraints = CA:true  
keyUsage = critical, digitalSignature, keyCertSign, cRLSign  
```
#### 配置文件说明
```ini
[req]
default_bits: 指定密钥长度，通常使用 2048 位或 4096 位。
default_keyfile: 输出密钥文件的默认名称。
distinguished_name: 指定使用的 DN 配置（例如 [req_distinguished_name]）。
x509_extensions: 用于定义证书扩展，指向 [v3_ca] 配置。
prompt: 设置为 no 表示不提示交互信息，直接使用配置中的值。
[req_distinguished_name]
定义证书的主体字段：

C: 国家，使用 ISO 3166-1 的两位国家代码，例如 CN（中国）。
ST: 省份名称。
L: 城市名称。
O: 组织名称。
OU: 组织单位名称。
CN: 公共名称（通常是 CA 的名称）。
[v3_ca]
定义证书扩展：

subjectKeyIdentifier: 标识证书的公钥。
authorityKeyIdentifier: 标识签发者密钥。
basicConstraints: 指定该证书为 CA 证书（CA:true）。
keyUsage: 限定证书的用途，比如 keyCertSign 和 cRLSign。
```

### 2. 使用命令生成根证书
```shell
# 使用命令生成根证书
openssl req -x509 -new -nodes -keyout rootCA.key -sha256 -days 3650 -out rootCA.pem -config openssl.cnf
#  验证生成的证书
openssl x509 -in rootCA.pem -text -noout  
```
####  说明
```
rootCA.key 是生成的私钥文件
rootCA.pem 是生成的根证书文件。
```