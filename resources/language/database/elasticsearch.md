# elasticsearch



## todo

- [ ] [Elasticsearch学习笔记_巨輪的博客-CSDN博客](https://blog.csdn.net/u011863024/article/details/115721328)

- [ ] [【尚硅谷】ElasticSearch教程入门到精通（基于ELK技术栈elasticsearch 7.x+8.x新特性）](https://www.bilibili.com/video/BV1hh411D7sb?p=1&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## 部署

系统: windows 11

环境: jdk 8

可以用 msi 进行安装

我这里使用 docker 进行安装

```bash
# 9200 http请求端口 9300：集群通信端口
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 \
# 单节点运行
-e "discovery.type=single-node" \
# 设置初始内存和最大内存，否则导致过大启动不了ES
-e ES_JAVA_OPTS="-Xms250m -Xmx512m" \
# 数据挂载
-v /E/test/docker/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /E/test/docker/es/data:/usr/share/elasticsearch/data \
-v /E/test/docker/es/plugins:/usr/share/elasticsearch/plugins \
-d elasticsearch:7.4.2

# windows 11 一行
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms250m -Xmx512m" -v /E/test/docker/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /E/test/docker/es/data:/usr/share/elasticsearch/data -v /E/test/docker/es/plugins:/usr/share/elasticsearch/plugins -d elasticsearch:7.4.2
```

验证是否启动成功

使用 http://localhost:9200/ 浏览器访问

```json
{
  "name" : "54c3425212b4",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "Vmu_qFldRxuGXJ-FbX-K9Q",
  "version" : {
    "number" : "7.4.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "2f90bbf7b93631e52bafb59b3b049cb44ec25e96",
    "build_date" : "2019-10-28T20:40:44.881551Z",
    "build_snapshot" : false,
    "lucene_version" : "8.2.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/chrome_MyPcWpEi93.png) 
