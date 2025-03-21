# openssl.conf配置文件说明

`openssl.cnf` 是 OpenSSL 使用的配置文件，用于定义证书、密钥以及相关操作的参数。它通常用于创建和管理证书颁发机构 (CA) 或生成自签名证书。以下是该配置文件的完整说明，包括其各个部分的典型结构和功能。
   
---  

### 配置文件结构
`openssl.cnf` 文件的内容主要由以下几个部分组成，每个部分用 `[section_name]` 定义：

1. **Global Settings（全局设置）**
    - 指定默认选项，比如默认的 CA 配置。

2. **CA Configuration（证书颁发机构配置）**
    - 定义生成和管理证书的目录、文件名、策略等。

3. **Extension Configuration（扩展配置）**
    - 定义证书的扩展字段，例如 Key Usage、Extended Key Usage、Subject Alternative Name 等。

4. **Policies（策略设置）**
    - 定义证书的字段要求，比如是否必须包含国家、组织等。

---  

### 配置文件字段说明
以下是典型的 `openssl.cnf` 配置文件及其字段说明。
[官方示例](https://github.com/openssl/openssl/blob/master/apps/openssl.cnf)

```ini
## OpenSSL 示例配置文件。  
# 查看 doc/man5/config.pod 了解更多信息。  
## 该文件主要用于生成证书请求，  
# 但也可用于自动加载提供程序。  
  
# 注意：您可以使用 .include 指令从主配置文件中包含其他文件。  
#.include 文件名  
  
# 如果未定义 HOME，这一定义可避免以下行出错。  
HOME			= .  
  
# 启用该设置以自动加载提供程序。  
openssl_conf = openssl_init  
  
# 注释掉下一行以忽略配置错误。  
config_diagnostics = 1  
  
# 额外的对象标识符信息：  
# oid_file       = $ENV::HOME/.oid  
oid_section = new_oids  
  
# 如果要在 "openssl x509" 实用程序的 "-extfile" 选项中使用该配置文件，  
# 需要在此处指定包含 X.509v3 扩展的部分：  
# extensions		=  
# （或者，使用一个仅在主 [= 默认] 部分包含 X.509v3 扩展的配置文件。）  
  
[ new_oids ]  
# 您可以在此处为 'ca'、'req' 和 'ts' 添加新的 OID。  
# 添加一个简单的 OID：  
# testoid1=1.2.3.4  
# 或者使用配置文件替换：  
# testoid2=${testoid1}.5.6  
  
# TSA 示例使用的策略。  
tsa_policy1 = 1.2.3.4.1  
tsa_policy2 = 1.2.3.4.5.6  
tsa_policy3 = 1.2.3.4.5.7  
  
# 对于 FIPS  
# 可选地包含一个由 OpenSSL fipsinstall 应用程序生成的文件。  
# 此文件包含 OpenSSL FIPS 提供程序所需的配置数据。  
# 它包含一个命名的部分，例如 [fips_sect]，并在以下 [provider_sect] 中引用。  
# 有关更多信息，请参阅 OpenSSL 安全策略。  
# .include fipsmodule.cnf  
  
[openssl_init]  
providers = provider_sect  
  
# 要加载的提供程序列表  
[provider_sect]  
default = default_sect  
# fips 部分名称应与 fipsmodule.cnf 文件中定义的部分名称匹配。  
# fips = fips_sect  
  
# 如果没有显式激活任何提供程序，则默认提供程序会被隐式激活。  
# 参见 man 7 OSSL_PROVIDER-default 了解更多细节。  
## 如果您显式激活了任何其他提供程序，您很可能需要显式激活默认提供程序，  
# 否则默认提供程序将不可用。  
# 这可能导致依赖 OpenSSL 的应用程序无法正常工作，可能会导致重大系统问题，  
# 包括无法远程访问系统。  
[default_sect]  
# activate = 1  
  
####################################################################  
[ ca ]  
default_ca	= CA_default		# 默认 CA 部分  
  
####################################################################  
[ CA_default ]  
dir		= ./demoCA		# 所有内容存放的位置  
certs		= $dir/certs		# 已签发证书的存放位置  
crl_dir		= $dir/crl		# 已签发 CRL 的存放位置  
database	= $dir/index.txt	# 数据库索引文件。  
#unique_subject	= no			# 设置为 'no' 允许创建多个相同主题的证书。  
new_certs_dir	= $dir/newcerts		# 新证书的默认存放位置。  
  
certificate	= $dir/cacert.pem 	# CA 证书  
serial		= $dir/serial 		# 当前序列号  
crlnumber	= $dir/crlnumber	# 当前 CRL 序列号（必须注释掉以保持 V1 CRL）  
crl		= $dir/crl.pem 		# 当前 CRL  
private_key	= $dir/private/cakey.pem # 私钥  
  
x509_extensions	= usr_cert		# 要添加到证书的扩展  
  
# 注释掉以下两行以使用传统（高度不推荐）格式。  
name_opt 	= ca_default		# 主题名称选项  
cert_opt 	= ca_default		# 证书字段选项  
  
# 扩展复制选项：谨慎使用。  
# copy_extensions = copy  
  
# 添加到 CRL 的扩展。注意：Netscape Communicator 会因 V2 CRL 出错，  
# 因此默认情况下注释掉以保持 V1 CRL。  
# crlnumber 也必须注释掉以保持 V1 CRL。  
# crl_extensions	= crl_ext  
  
default_days	= 365			# 证书有效期  
default_crl_days= 30			# 下一次 CRL 的时间间隔  
default_md	= default		# 使用公钥默认 MD  
preserve	= no			# 保留传递的 DN 顺序  
  
# 指定请求外观的几种不同方式  
# 对于 CA 类型，列出的属性必须匹配，而可选和提供的字段则是可选的。  
policy		= policy_match  
  
# CA 策略  
[ policy_match ]  
countryName		= match  
stateOrProvinceName	= match  
organizationName	= match  
organizationalUnitName	= optional  
commonName		= supplied  
emailAddress		= optional  
  
# "anything" 策略  
# 在此阶段，您必须列出所有可接受的 "object" 类型。  
[ policy_anything ]  
countryName		= optional  
stateOrProvinceName	= optional  
localityName		= optional  
organizationName	= optional  
organizationalUnitName	= optional  
commonName		= supplied  
emailAddress		= optional  
  
####################################################################  
[ req ]  
default_bits		= 2048  
default_keyfile 	= privkey.pem  
distinguished_name	= req_distinguished_name  
attributes		= req_attributes  
x509_extensions	= v3_ca	# 自签名证书的扩展  
  
# 私钥密码，如果未提供则需要手动输入。  
# input_password = secret  
# output_password = secret  
  
# 设置允许的字符串类型掩码。有以下几种选项：  
# default: PrintableString, T61String, BMPString。  
# pkix	 : PrintableString, BMPString（2004 年前 PKIX 推荐）。  
# utf8only: 仅 UTF8Strings（2004 年后 PKIX 推荐）。  
# nombstr : PrintableString, T61String（无 BMPStrings 或 UTF8Strings）。  
# MASK:XXXX 字面掩码值。  
# 警告：古老版本的 Netscape 会因 BMPStrings 或 UTF8Strings 崩溃。  
string_mask = utf8only  
  
# req_extensions = v3_req # 添加到证书请求的扩展  
  
[ req_distinguished_name ]  
countryName			= 国家名称（2 个字母代码）  
countryName_default		= AU  
countryName_min			= 2  
countryName_max			= 2  
  
stateOrProvinceName		= 州或省全名  
stateOrProvinceName_default	= Some-State  
  
localityName			= 地区名称（例如，城市）  
  
0.organizationName		= 组织名称（例如，公司）  
0.organizationName_default	= Internet Widgits Pty Ltd  
  
# 通常不需要配置此项：  
#1.organizationName		= 第二组织名称（例如，公司）  
#1.organizationName_default	= World Wide Web Pty Ltd  
  
organizationalUnitName		= 组织单位名称（例如，部门）  
#organizationalUnitName_default	=  
  
commonName			= 通用名称（例如，服务器 FQDN 或您的姓名）  
commonName_max			= 64  
  
emailAddress			= 电子邮件地址  
emailAddress_max		= 64  
  
# SET-ex3			= SET 扩展编号 3  
  
[ req_attributes ]  
challengePassword		= 挑战密码  
challengePassword_min		= 4  
challengePassword_max		= 20  
  
unstructuredName		= 可选公司名称  
  
[ usr_cert ]  
# 当 'ca' 签署请求时添加的扩展。  
  
basicConstraints=CA:FALSE  
subjectKeyIdentifier=hash  
authorityKeyIdentifier=keyid,issuer  
  
[ v3_req ]  
basicConstraints = CA:FALSE  
keyUsage = nonRepudiation, digitalSignature, keyEncipherment  
  
[ v3_ca ]  
subjectKeyIdentifier=hash  
authorityKeyIdentifier=keyid:always,issuer  
basicConstraints = critical,CA:true  
  
[ crl_ext ]  
authorityKeyIdentifier=keyid:always  
  
[ proxy_cert_ext ]  
basicConstraints=CA:FALSE  
subjectKeyIdentifier=hash  
authorityKeyIdentifier=keyid,issuer  
proxyCertInfo=critical,language:id-ppl-anyLanguage,pathlen:3,policy:foo  
  
####################################################################  
[ tsa ]  
default_tsa = tsa_config1  
  
[ tsa_config1 ]  
dir		= ./demoCA  
serial		= $dir/tsaserial  
crypto_device	= builtin  
signer_cert	= $dir/tsacert.pem  
certs		= $dir/cacert.pem  
signer_key	= $dir/private/tsakey.pem  
signer_digest  = sha256  
default_policy	= tsa_policy1  
other_policies	= tsa_policy2, tsa_policy3  
digests         = sha1, sha256, sha384, sha512  
accuracy	= secs:1, millisecs:500, microsecs:100  
clock_precision_digits  = 0  
ordering		= yes  
tsa_name		= yes  
ess_cert_id_chain	= no  
ess_cert_id_alg		= sha256  
  
[insta]  
server = pki.certificate.fi:8700  
path = pkix/  
  
recipient = "/C=FI/O=Insta Demo/CN=Insta Demo CA"  
ignore_keyusage = 1  
unprotected_errors = 1  
extracertsout = insta.extracerts.pem  
  
ref = 3078  
secret = pass:insta  
  
cmd = ir  
subject = "/CN=openssl-cmp-test"  
newkey = insta.priv.pem  
out_trusted = apps/insta.ca.crt  
certout = insta.cert.pem  
  
[pbm]  
ref = $insta::ref  
secret = $insta::secret  
  
[signature]  
trusted = $insta::out_trusted  
key = $insta::newkey  
cert = $insta::certout  
  
[ir]  
cmd = ir  
  
[cr]  
cmd = cr  
  
[kur]  
cmd = kur  
oldcert = $insta::certout  
  
[rr]  
cmd = rr  
oldcert = $insta::certout  
```