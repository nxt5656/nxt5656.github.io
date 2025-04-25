# ElasticSearch-安装-单节点-docker


```
docker run -dit --name=es docker.elastic.co/elasticsearch/elasticsearch:8.17.0 /bin/bash
docker exec -it es /bin/bash
./bin/elasticsearch-certutil ca
./bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12
sudo docker cp es:/usr/share/elasticsearch/elastic-certificates.p12 .


mkdir -p es01/data
mkdir -p es01/logs
mkdir plugins

sudo chmod 777 es* -R
sudo chmod 777 elastic* 
sudo sysctl -w vm.max_map_count=262144  
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf  
sudo sysctl -p 
sudo systemctl restart docker  

## todo 这里修改yaml文件
docker compose up -d

docker exec -ti es01 bash
./bin/elasticsearch-setup-passwords auto

```


docker-compose.yam
```
version: '2.2'
services:
  es01:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.17.0
    container_name: es01
    restart: always
    environment:
      - node.name=es01
      - cluster.name=es-docker-cluster
      - cluster.initial_master_nodes=es01
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms10g -Xmx10g"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./es01/data:/usr/share/elasticsearch/data
      - ./es01/logs:/usr/share/elasticsearch/logs
      - ./plugins:/usr/share/elasticsearch/plugins
      - ./elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
      - ./elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12
    ports:
      - 9200:9200
    networks:
      - elastic

  
  kib01:
    depends_on:
      - es01
    image: docker.elastic.co/kibana/kibana:8.17.0
    container_name: kib01
    restart: always
    ports:
      - 5601:5601
    environment:
      ELASTICSEARCH_URL: http://es01:9200
      ELASTICSEARCH_HOSTS: http://es01:9200
    volumes:
      - ./kibana.yml:/usr/share/kibana/config/kibana.yml
    networks:
      - elastic

networks:
  elastic:
    driver: bridge
```

elasticsearch.yml

```
network.host: 0.0.0.0
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.type: PKCS12
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.type: PKCS12
xpack.security.audit.enabled: true
```

kibana.yml
es密码后面生成后要修改
```
server.name: kibana
server.host: "0.0.0.0"
xpack.monitoring.ui.container.elasticesearch.enabled: true
i18n.locale: "zh-CN"
monitoring.ui.container.elasticsearch.enabled: true
elasticsearch.username: "kibana"
elasticsearch.password: "IJ6Ufez6xiaUGpzLPMXw" 
```

