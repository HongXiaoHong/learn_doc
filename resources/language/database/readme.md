# database

各种数据库集合

## 数据库范式

[关于数据库理论：数据库的六大范式知识笔记-51CTO.COM](https://www.51cto.com/article/632448.html)

[(131条消息) 数据库范式（1NF 2NF 3NF BCNF）详解_翔飞天宇的博客-CSDN博客_1nf,2nf,3nf,bcnf的理解](https://blog.csdn.net/ljp812184246/article/details/50706596)

## 数据库数据转换

## mysql -> sqllite

https://www.jianshu.com/p/e02438fff9a6
用 Navicat 工具进行转换

### 常见问题

### Oracle与MySQL的区别

[Oracle与MySQL的区别以及优缺点 - 掘金 (juejin.cn)](https://juejin.cn/post/7133095397794250783)

[谈谈mysql和oracle的使用感受 -- 差异 - 等你归去来 - 博客园 (cnblogs.com)](https://www.cnblogs.com/yougewe/p/13662695.html)

#### 1. 本质的区别

Oracle数据库是一个对象关系数据库管理系统（ORDBMS）。它通常被称为Oracle RDBMS或简称为Oracle，是一个收费的数据库。

MySQL是一个开源的关系数据库管理系统（RDBMS）。它是世界上使用最多的RDBMS，作为服务器运行，提供对多个数据库的多用户访问。它是一个开源、免费的数据库。

#### 2. 数据库安全性

MySQL使用三个参数来验证用户，即用户名，密码和位置；Oracle使用了许多安全功能，如用户名，密码，配置文件，本地身份验证，外部身份验证，高级安全增强功能等。

#### 3. SQL语法的区别

Oracle的SQL语法与MySQL有很大不同。Oracle为称为PL / SQL的编程语言提供了更大的灵活性。Oracle的SQL * Plus工具提供了比MySQL更多的命令，用于生成报表输出和变量定义。

##### 3.1. SQL上的区别

###### 3.1.1. 主键的使用

MySQL：一般使用自动增长类型，在创建表的时候只要指定表的主键为auto increment,插入记录时就不需要再为主键添加记录了，主键会自动增长；

Oracle:没有自动增长，主键一般使用序列，插入记录时将序列号的下一值付给该字段即可，只是ORM框架只是需要native主键生成策略即可。

###### 3.1.2. 长字符串的处理

mysql中对超长文本使用text和longtext类型进行处理，和其他字段并没有太多差别（不能建有效索引除外）

　　而oracle中则使用CLOB类型进行存储超长字符，但它有许多限制，普通查询无法显示clob，分号限制等等。但它可以容纳上G的数据。

###### 3.1.3. group by 聚合

group by可以按照某字段去重一些数据，并按需要聚合数据，mysql与oracle都差不多，差别点在于oracle不允许返回group by外的其他字段（或者说不能准确描述的字段），而mysql则会随机返回一个group by的字段值。mysql如下：

    select username, avg(score), grade from tb1 group by grade;

　　oracle中则要求必须确定某值：

    select max(username), avg(score), grade from tb1 group by grade;

　　看起来oracle是更严谨一些的。

###### 3.1.4. 单引号的处理

MySQL里可以用双引号包起字符串，Oracle里只可以用单引号包起字符串，在插入和修改字符串前必须做单引的替换； 把所有出现的一个单引号替换成两个单引号

###### 3.1.5. 分页实现

分页一般用于列表数据多页显示，或取总数中的几条数据使用。mysql中的分页，使用limit，这也是大多数数据库的选择，样例如下：

    select username from tb1 limit 50, 100;

　　而在oracle中则不太一样，它使用行号去定位记录，一般需要使用嵌套子查询；样例如下：

    select * from (select t.*,rownum num from tb1 t where rownum<=100 ) where num>50

　　性能比limit怎么样我不清楚，反正是写得挺烦的。

#### 4. 存储上的区别

与Oracle相比，MySQL没有表空间，角色管理，快照，同义词和包以及自动存储管理。

#### 5. MySQL和Oracle的字符数据类型比较

两个数据库中支持的字符类型存在一些差异。对于字符类型，MySQL具有CHAR和VARCHAR，最大长度允许为65,535字节（CHAR最多可以为255字节，VARCHAR为65.535字节）。

而，Oracle支持四种字符类型，即CHAR，NCHAR，VARCHAR2和NVARCHAR2; 所有四种字符类型都需要至少1个字节长; CHAR和NCHAR最大可以是2000个字节，NVARCHAR2和VARCHAR2的最大限制是4000个字节。可能会在最新版本中进行扩展。

## 分布式数据库

[专栏 - 什么是分布式数据库？我不信，看完这篇你还不懂! | TiDB 社区](https://tidb.net/blog/eb3cb609)

主流分布式数据库

[聊聊主流的分布式数据库 - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1769308)

单体[数据库](https://cloud.tencent.com/solution/database?from=10680)时代，随着系统交易量的不断上升，数据库读写性能出现了严重下降。我们可以借助分库分表中间件，比如mycat、shardingjdbc来实现分库分表，缓解单库的读写性能。但是分库分表中间件并不支持事务，如果要保证数据一致性，就需要借助于[分布式事务中间件](https://cloud.tencent.com/product/dtf?from=10680)，比如阿里巴巴的seata。后来分布式数据库逐渐成为解决数据一致性的选择，目前分布式数据库产品已经比较成熟，支持ACID事务，本文就来聊一聊分布式数据库。

**增加代理层**

以mysql为例，我们来看一下单体数据库的逻辑架构，如下图：

![](https://ask.qcloudimg.com/http-save/yehe-6973249/4amjw8zjt5.png?imageView2/2/w/2560/h/7000)

从这个图我们可以看到，mysql包括连接器层，server层，存储引擎层和数据/文件层。单体数据库场景下，数据库本身就是支持事务的，我们不用事务做额外的工作。

如果需要分库分表，这时架构就需要调整，如下图：

![](https://ask.qcloudimg.com/http-save/yehe-6973249/a7qzid5ktx.png?imageView2/2/w/2560/h/7000)

这个架构增加了代理层，它的功能包括客户端接入、简单的查询处理、进程管理和分片信息管理。这时因为数据分布在不同的切片上，使用的复杂性也大幅度增加。

如果应用要进行全量分页查询、关联查询、排序等应用，一个简单的代理层是很难满足的，代理层必须支持复杂的运算，这时就基本过度到分布式数据库了，而代理层也被叫做了协调节点。

协调节点增加了运算能力，但是要支持[分布式事务](https://cloud.tencent.com/product/dtf?from=10680)的一致性，还是远远不够的。下面我们就看一下一致性问题。

**一致性**

在分布式的CAP理论中，数据一致性是终极目标。我们来聊一下线性一致性和因果一致性。

先看线性一致性，如下图：

![](https://ask.qcloudimg.com/http-save/yehe-6973249/apigdicd8r.png)

user1读取足球比赛成绩，比分4:2,1秒之后，user2读取比赛成绩，但user2读到的成绩是4:1，这样后读取的用户读取到的数据反而是旧的数据。

发生这个问题的原因就是多副本同步延迟，而线性一致性要解决的问题如下：

- 用户的读写请求顺序与实际的时间相一致
- 如果user1读取某一个key之前user2已经修改了key，那user1读取到的值一定是user2修改后的值

线性一致性是分布式下最强的一致性理论，主流的数据库产品解决线程一致性的手段是引入全局时钟，用单点授时的方式，从这个单一节点获取时间，而且必须保证单一时钟节点的高可靠性。

线性一致性的问题是全局时钟的并发问题，如果共用一个物理时钟，性能必然受到影响。

如果我们在一致性和高性能之间做一个取舍，我们可以降低一些一致性来提高并发性能。这个理论就是因果一致性，它一致性要求低于线性一致性。因为一致性的基础是在数据库的单一切片上，事件肯定是有先后顺序的。在不同的切片上，需要通信的话，发送事件肯定早于接收事件。

基于因果一致性，引入了逻辑时钟的概念。目前也有一些数据库使用逻辑时钟来实现因果一致性，虽然比线性一致性弱一些，但是性能更好。

**NewSQL架构**

上面我们介绍了传统关系型数据库，增加了切片集群，增加了协调节点，增加了全局时钟，这样就演变成了分布式数据库。如下图：

![](https://ask.qcloudimg.com/http-save/yehe-6973249/n9winxn9u1.png)

这种数据库架构被业内称为PGXC架构，这个名字是PostgreSQL-XC的简称，它是一种提供写可靠性，多主节点数据同步，数据传输的开源集群方案。

***注意：这种架构被叫做PGXC，并不是专指PostgreSQL-XC这种分布式数据库，而是文章上面讲的架构风格的一类数据库。***

NewSQL是由NoSQL键值数据库发展而来，它是一类新的数据库架构方案，不仅具有NoSQL对海量数据的存储管理能力，还保持了传统数据库支持ACID和SQL等特性。它主要有以下特性：

- **放弃了PGXC架构中单体数据库的事务支持**
- **在BigTable基础上构建了事务支持**
- **引入分片机制，主要采用Range动态分片技术，跟HASH分片相比，数据可以不用固定的在某一个分片上**
- **可靠性方面，放弃传统数据库的主从复制，采用Paxos、Raft等共识算法来保证HA**
- **存储引擎方面，使用LSM-Tree替换B+树模型，写入性能更高**
- **支持事务管理**

**PGXC数据库**

PGXC数据库由传统关系型数据库基于分库分表的技术演化而来，优点是性能比较稳定，缺点是写入能力有限，这是由架构风格决定的。

我们来介绍几款主流的PGXC数据库，代表如下：

1.TBase

TBase是腾讯数据平台团队在基于PostgreSQL研发的，支持HTAP(Hybrid Transaction and Analytical Process)，主要由协调节点、数据节点和全局事务管理器(GTM)组成。特点如下：

分布式事务支持RC和RR两个隔离级别

支持高性能分区表，数据检索效率高

SQL语法兼容SQL2003标准、也支持PostgreSQL语法和Oracle主要语法

开源地址：

```javascript
https://gitee.com/mirrors/tbase
```

复制

2.GuassDB 300

GuassDB 300由华为研发，也是基于开源PostgreSQL研发的，支持HTAP，支持SQL92、SQL99和SQL2003语法，并且支持提供存储过程、触发器、分页等。目前在招商银行、工商银行和民生银行有使用。

3.AntDB

由亚信科技开发，基于开源PostgreSQL内核研发的，主要特点是对Oracle兼容性高，分布式事务支持2PC协议和MVCC，集群支持动态扩展。

开源地址：

```javascript
https://gitee.com/adbsql/antdb
```

复制

4.GoldenDB

由中兴通讯研发，跟前面3款不一样的是，这款数据库以mysql为内核构建的，按照官方的描述，这款数据库对金融行业的支持比较好，目前中信银行的核心业务系统有使用。

5.TDSQL

TDSQL由腾讯研发，它算不上是完全的PGXC架构，因为没有全局时钟。不过它也有自己解决一致性的方案，它的自增长序列为用户提供一个全局唯一数字ID服务，对全局锁和mvcc都有一定的作用。

**NewSQL数据库**

NewSQL数据库有很大的架构上的优势，但是首先难度也很大，我们来看一下目前主流的数据库产品。

1.谷歌Spanner

谷歌Spanner可以说是NewSQL数据库的鼻祖，后来的好多数据库都是借鉴了Spanner的思想。它有下面几个特性：

使用GPS加原子钟的方式来实现全局时钟，这就就是引入了true time，支持全球化部署

支持线性一致性

2.TiDB

TiDB也是非常有名的一块NewSQL数据库，由PingCAP研发，支持HTAP，支持线性一致性，一个亮点是兼容mysql协议和生态，github地址如下：

```javascript
https://github.com/pingcap
```

复制

3.Ocean Base

蚂蚁集团研发，按照官方说法，2020年5月，OceanBase以7.07亿tpmC的在线事务处理性能，打破了去年自己创造的TPC-C 世界纪录。截止至目前，OceanBase 是第一个也是唯一一个上榜的中国数据库。

虽然官方说Ocean Base高度兼容各种主流关系型数据库，但是业界普遍认为对Oracle兼容不太好。

采用Paxos分布式选举算法来实现高可用。

4.SequoiaDB

巨杉金融级分布式数据库，它具有如下特性：

完整支持分布式事务、强一致、多副本高可用，满足分布式核心交易业务需求

支持 MySQL、PostgreSQL、SparkSQL 和 MariaDB 四种关系型数据库实例，100%兼容MySQL语法

支持HTAP混合事务/分析处理

目前在广发、民生等金融机构有一定使用。

5.CockroachDB和YugabyteDB

这2个数据库放在一起讲的原因是它们不支持线性一致性，只支持因果一致性，因为它们使用的是混合逻辑时钟(Hybrid Logical Clocks)，它们的设计思想都是来自Spanner。

CockroachDB采用了Range分区，每个range对应一个RocksDB数据库，同时使用raft算法的改进算法multi raft，让多分片并行处理提升性能。

YugabyteDB除了NewSQL的特性外，还支持文档数据库接口，查询层支持同时SQL和CQL两种API，SQL API是基于postgreSQL改的，所以对postgreSQL的支持非常好。

**Aurora数据库**

Aurora数据库是amazon推出的云原生数据库，它的特点是计算节点垂直扩展，存储节点可以水平扩展。可见计算节点依然是单节点。Aurora基于mysql引擎构建，100%支持mysql。

Aurora数据缓存在主节点，然后同步到其他从节点，可见跟其他分布式数据库相比，从节点不支持写入，所以不支持多写，从节点只能分担读的压力。

不过这也是一种风格，目前这个风格的数据库有阿里的polarDB，腾讯的CynosDB和华为的Taurus。

**总结**

传统的分库分表架构不断演进，增加了协调节点，全局时钟，就演变成了PGXC架构，这是主流分布式数据库的一个分支。

在基于BigTable键值数据库的基础上增加事务支持，就演变成了NewSQL，是分布式数据库的另一个分支。

amazon推出Aurora分布式数据库并不算是上面2种架构的一种，并没有解决分布式场景下的写入压力，但也是一种分布式数据库的风格。

分布式数据库的产品已经很成熟，数量也很多，需要结合业务特性来做技术选型

## 慢查询 | 从简单的分析到日志监控记录到界面展示

[mysql慢查询分析工具: pt-query-digest和mysqldumpslow的使用！ - 果冻编程 (lakeui.com)](https://www.lakeui.com/p/61343aa7db4e7)

简单的系统 用 mysqldumpslow

使用mysqldumpslow的分析结果不会显示具体完整的sql语句,只会显示sql的组成结构;这也是实际操作中用pt-query-digest的原因

安装 pt-query-digest 可以很好的分析 mysql 慢日志

[Druid连接池：慢查询监控 - 快乐的凡人721 - 博客园 (cnblogs.com)](https://www.cnblogs.com/luo630/p/15355711.html)

打开 druid 连接池 的日志监控 可以查看sql语句，sql时间

但是有一定缺陷的，比如它采集的sql是没有限制的，会把所有的sql拿出来，当sql数量非常多时，很难在这个页面中找到你需要的sql，同时它的sql统计也没有存储，数据会不断的丢失。此外，如果在大数据环境里，sql生成的速度非常快时，这个页面也许会出现卡死等情况

这里使用 druid 记录日志, 需要重写druid的日志记录器

再通过 elk 进行收集展示

[druid慢sql日志存储和elk展示 - 简书 (jianshu.com)](https://www.jianshu.com/p/71f9fa53b109)

那么多日志 怎么跟踪呢

日志链路跟踪

[(25条消息) 日志排查问题困难？分布式日志链路跟踪来帮你_ttl 解决日志子线程_zlt2000的博客-CSDN博客](https://blog.csdn.net/zlt2000/article/details/99641821?spm=1001.2101.3001.6650.9&utm_medium=distribute.pc_relevant.none-task-blog-2~default~OPENSEARCH~default-9.highlightwordscore&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~OPENSEARCH~default-9.highlightwordscore)

## 优化

### 索引

#### 索引失效

### 系统层面优化

>   springboot 项目中用mybatis查询一个千万级别的数据库表, 这个时候查询SQL通过加索引,SQL已经没有优化的地方了, 这个时候可以考虑从哪个方向对查询速度进行优化

在 Spring Boot 项目中使用 Mybatis 查询一个千万级别的数据库表，如果已经通过索引优化 SQL 查询，而查询速度仍然不能满足需求，可以考虑从以下几个方向进行优化：

1. 数据库连接池配置：可以适当调整数据库连接池的配置参数，如最大连接数、最小空闲连接数、连接超时时间等，以提高数据库的连接处理能力和并发性能。

2. 分页查询：可以采用分页查询的方式来获取数据，分页查询可以将大量数据分批次查询，减轻数据库的负载和响应时间。

3. 缓存数据：可以将查询到的数据缓存在内存中，以减少对数据库的查询次数和响应时间。可以使用缓存技术，如 Redis、Memcached 等，将查询到的数据缓存起来，以提高查询性能和响应速度。

4. 数据库读写分离：可以将读写操作分离到不同的数据库服务器上，以提高数据库的并发处理能力和响应速度。可以通过主从复制、分区等技术来实现数据库读写分离。

5. 数据库表分片：可以将大型的数据库表按照一定的规则进行拆分成多个小表，以提高数据库的查询性能和并发处理能力。可以采用水平分片、垂直分片等技术来实现数据库表分片。

以上是对查询速度进行优化的一些思路，具体采用哪些方式还需根据具体业务场景和实际需求来选择。

## 常见问题

> 有 5 张上亿的数据表需要关联查询，联表查询好呢还是单表查询后代码拼接？

需求来驱动

在有 5 张上亿数据表需要关联查询的情况下，你需要考虑以下因素来决定使用联表查询还是单表查询后代码拼接：

1. 数据库性能和优化：如果你的数据库引擎能够很好地处理联表查询，通过一次联表查询可能更快。但是，在大型数据表上进行复杂的联表查询可能导致性能下降，因此请确保数据库引擎进行了优化。

2. 索引：请确保涉及到的数据表有适当的索引以提高查询性能。索引有助于减少查询时间，尤其是在处理大量数据时。

3. 查询复杂性：如果查询逻辑非常复杂，可能需要在查询过程中进行多次关联操作。在这种情况下，使用单表查询后代码拼接可能更简单，因为你可以逐步构建结果集。

4. 内存限制：单表查询后代码拼接可能需要在应用程序层面处理大量数据，这可能导致内存不足的问题。如果你的应用程序没有足够的内存来处理这些数据，联表查询可能是更好的选择。

5. 并发和响应时间要求：如果你需要在短时间内完成查询，并且有很多并发查询，联表查询可能会导致数据库服务器压力过大。在这种情况下，可以考虑使用单表查询后代码拼接，以便分散查询负载。

总之，你需要根据实际情况来权衡。如果数据库性能良好，且查询逻辑不是很复杂，可以优先考虑联表查询。如果查询逻辑复杂或者数据库性能不足，单表查询后代码拼接可能是更好的选择。在实践中，你可以尝试两种方法，并根据性能和资源需求来选择最佳方案。

## 垂直水平分库分表

[[译] 数据分片是如何在分布式 SQL 数据库中起作用的 - 掘金 (juejin.cn)](https://juejin.cn/post/6844903904128270350)

## 数据库选型

[[译] 如何选择合适的数据库 - 掘金 (juejin.cn)](https://juejin.cn/post/6844904057925009415)

## SQL 执行顺序

[SQL的执行顺序_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Fu411x7jm/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_8Rzi7O0Mms.png)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_yNn0oIiQo9.png)



上面这个顺序是指的标准顺序

具体执行顺序每个数据库可能不一样

但是也是大差不差了
