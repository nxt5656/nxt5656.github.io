# linux 配置代理


```
unset http_proxy
unset https_proxy
unset ftp_proxy
unset no_proxy
```

```
git config --global https.proxy http://127.0.0.1:1080
git config --global http.proxy http://127.0.0.1:1080
git config --global --unset http.proxy
git config --global --unset https.proxy

```