# AIGC-中国大陆法律法规

## 1. 生成内容必须添加标签
[生成内容必须添加标识](https://www.tc260.org.cn/upload/2025-03-15/1742009439794081593.pdf)


shell操作
```shell
sudo apt install -y attr
setfattr -n user.AIGC.implicit_id -v "aigc_generated_20250516_xyz" test.jpeg
getfattr -d test.jpeg
```
golang操作
使用	"github.com/pkg/xattr"
