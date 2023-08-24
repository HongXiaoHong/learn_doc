# elasticsearch

## todo



- [ ] [Elasticsearch学习笔记_巨輪的博客-CSDN博客](https://blog.csdn.net/u011863024/article/details/115721328)

- [x] [[译] Elasticsearch 新手指南 - 掘金 (juejin.cn)](https://juejin.cn/post/6913725535717851144)

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

### Elasticsearch多表关联设计指南

[干货 | Elasticsearch多表关联设计指南_elasticsearch 表关联_铭毅天下的博客-CSDN博客](https://blog.csdn.net/laoyang360/article/details/88784748)

2、基础认知
2.1 关系型数据库
关系数据库是专门为关系设计的，有如下特点：

可以通过主键唯一地标识每个实体（如Mysql中的行）。
实体 规范化 。唯一实体的数据只存储一次，而相关实体只存储它的主键。只能在一个具体位置修改这个实体的数据。
实体可以进行关联查询，可以跨实体搜索。
支持ACID特性，即：单个实体的变化是 原子的 ， 一致的 ， 隔离的 ， 和 持久的 。
大多数关系数据库支持跨多个实体的 ACID 事务。
关系型数据库的缺陷：

第一：全文检索有限的支持能力。 这点，postgresql已部分支持，但相对有限。
第二：多表关联查询的耗时很长，甚至不可用。之前系统开发中使用过Mysql8个表做关联查询，一次查询等待十分钟+，基本不可用。
2.2 Elasticsearch
Elasticsearch ，和大多数 NoSQL 数据库类似，是扁平化的。索引是独立文档的集合体。 文档是否匹配搜索请求取决于它是否包含所有的所需信息和关联程度。

Elasticsearch 中单个文档的数据变更是满足ACID的， 而涉及多个文档时则不支持事务。当一个事务部分失败时，无法回滚索引数据到前一个状态。

扁平化有以下优势：

索引过程是快速和无锁的。
搜索过程是快速和无锁的。
因为每个文档相互都是独立的，大规模数据可以在多个节点上进行分布。
2.3 Mysql VS Elasticsearch
mysql才擅长关系管理，而ES擅长的是检索。

Medcl也曾强调：“如果可能，尽量在设计时使用扁平的文档模型。” Elasticsearch的关联存储、检索、聚合操作势必会有非常大的性能开销。

3 Elasticsearch关联关系如何存储
关联关系仍然非常重要。某些时候，我们需要缩小扁平化和现实世界关系模型的差异。
以下四种常用的方法，用来在 Elasticsearch 中进行关联数据的管理：

3.1 应用端关联
这是普遍使用的技术，即在应用接口层面来处理关联关系。
针对星球问题实践，

存储层面：独立两个索引存储。
实际业务层面分两次请求：
第一次查询返回：Top5中文姓名和成绩；
根据第一次查询的结果，第二次查询返回：Top5中文姓名和英文姓名；

将第一次查询结果和第二次查询结果组合后，返回给用户。
即：实际业务层面是进行了两次查询，统一返回给用户。用户是无感知的。

适用场景：数据量少的业务场景。
优点：数据量少时，用户体验好。
缺点：数据量大，两次查询耗时肯定会比较长，影响用户体验。

引申场景：关系型数据库和ES 结合，各取所长。将关系型数据库全量同步到 ES 存储，不做冗余存储。
如前所述：ES 擅长的是检索，而 MySQL 才擅长关系管理。所以可以考虑二者结合，使用 ES 多索引建立相同的别名，针对别名检索到对应 ID 后再回 MySQL 查询，业务层面通过关联 ID join 出需要的数据。

3.2 宽表冗余存储
对应于官方文档中的“Data denormalization”，官方直接翻译为：“非规范化你的数据”，总感觉规范化是什么鬼，不好理解。
通俗解释就是：冗余存储，对每个文档保持一定数量的冗余数据可以在需要访问时避免进行关联。

这点通过logstash 同步关联数据到ES时，通常会建议：先通过视图对Mysql数据做好多表关联，然后同步视图数据到ES。此处的视图就是宽表。

针对星球问题实践：姓名、英文名、成绩两张表合为一张表存储。

适用场景：一对多或者多对多关联。

优点：速度快。因为每个文档都包含了所需的所有信息，当这些信息需要在查询进行匹配时，并不需要进行昂贵的关联操作。

缺点：索引更新或删除数据，应用程序不得不处理宽表的冗余数据；
由于冗余存储，导致某些搜索和聚合操作可能无法按照预期工作。

3.3 嵌套文档（Nested）存储
Nested类型是ES Mapping定义的集合类型之一，它是比object类型更NB的支持独立检索的类型。
举例：有一个文档描述了一个帖子和一个包含帖子上所有评论的内部对象评论。可以借助 Nested 实现。

实践注意1：当使用嵌套文档时，使用通用的查询方式是无法访问到的，必须使用合适的查询方式（nested query、nested filter、nested facet等），很多场景下，使用嵌套文档的复杂度在于索引阶段对关联关系的组织拼装。

推荐实践：https://blog.csdn.net/laoyang360/article/details/82950393

实践注意2：

index.mapping.nested_fields.limit 缺省值是50。即：一个索引中最大允许拥有50个nested类型的数据。
index.mapping.nested_objects.limit 缺省值是10000。即：1个文档中所有nested类型json对象数据的总量是10000。
1
2
适用场景：1 对少量，子文档偶尔更新、查询频繁的场景。
如果需要索引对象数组并保持数组中每个对象的独立性，则应使用嵌套 Nested 数据类型而不是对象 Oject 数据类型。

优点：nested文档可以将父子关系的两部分数据（举例：博客+评论）关联起来，可以基于nested类型做任何的查询。
缺点：查询相对较慢，更新子文档需要更新整篇文档。

3.4 父子文档存储
注意：6.X之前的版本的父子文档存储在相同索引的不同type中。而6.X之上的版本，单索引下已不存在多type的概念。父子文档Join的都是基于相同索引相同type实现的。

Join类型是ES Mapping定义的类型之一，用于在同一索引的文档中创建父/子关系。 关系部分定义文档中的一组可能关系，每个关系是父名称和子名称。

实践参考：https://blog.csdn.net/laoyang360/article/details/79774481

适用场景：子文档数据量要明显多于父文档的数据量，存在1 对多量的关系；子文档更新频繁的场景。

举例：1 个产品和供应商之间是1对N的关联关系。
当使用父子文档时，使用has_child 或者has_parent做父子关联查询。

优点：父子文档可独立更新。
缺点：维护Join关系需要占据部分内存，查询较Nested更耗资源。

4 小结

在Elasticsearch开发实战中对于多表关联的设计要突破关系型数据库设计的思维定式。
不建议在es做join操作，parent-child能实现部分功能，但是它的开销比较大，如果可能，尽量在设计时使用扁平的文档模型。
尽量将业务转化为没有关联关系的文档形式，在文档建模处多下功夫，以提升检索效率。
Nested&Join父子文选型必须考虑性能问题。 nested 类型检索使得检索效率慢几倍，父子Join 类型检索会使得检索效率慢几百倍。



## 持久化

[分布式框架之高性能：ElasticSearch数据持久化 - 墨天轮 (modb.pro)](https://www.modb.pro/db/72514)



## 应用

### ES 与 mysql

[(21条消息) Elasticsearch使用Logstash同步Mysql数据库数据_logstash 达梦数据库_懂的越多不懂的也越多的博客-CSDN博客](https://blog.csdn.net/weixin_44167913/article/details/101194648)

[(21条消息) Elasticsearch使用Logstash导入Mysql多数据源数据_懂的越多不懂的也越多的博客-CSDN博客](https://blog.csdn.net/weixin_44167913/article/details/101200831?spm=1001.2101.3001.6650.11&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-11-101200831-blog-103702846.235%5Ev36%5Epc_relevant_default_base&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-11-101200831-blog-103702846.235%5Ev36%5Epc_relevant_default_base&utm_relevant_index=12)
