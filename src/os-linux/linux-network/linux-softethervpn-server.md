# linux SoftEtherVPN server
容器方式安装

``` 
mkdir openvpn
docker run -d -name openvpn-base nxt5656/ubuntu:SoftEtherVPN-openvpn
docker cp openvpn-base:/app/vpn_server.config openvpn/vpn_server.config
docker stop openvpn-base && docker rm openvpn-base
docker run \
    --restart=always \
    --name openvpn \
    -v $PWD/openvpn/vpn_server.config:/app/vpn_server.config \
    -v $PWD/openvpn/server_log:/app/server_log \
    -v $PWD/openvpn/security_log:/app/security_log \
    -v $PWD/openvpn/packet_log:/app/packet_log \
    -d \
    -p 1194:1194/udp \
    -p 5555:5555  \
    nxt5656/ubuntu:SoftEtherVPN-openvpn
```