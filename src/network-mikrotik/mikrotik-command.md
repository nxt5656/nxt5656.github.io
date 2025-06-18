# Mikrotik常用命令

## 限速
```shell
:for i from=3 to=254 do={/queue simple add target="192.168.0.$i" name="desktop-pc-$i" max-limit=80M/80M }
```