# mysql

## sql 优化

[（全网讲的最好）面试被问到mysql调优如何回答_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1qt4y157kN/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

1. 业务层面 预置条件 进入某个页面 没有条件特慢

2. 代码层面 多表联合查询 可以通过单表查询之后再在代码里面整合

3. SQL语法层面 联合索引 多建一张表（例如count 数据）

4. 硬件优化

最后没办法就只能换到 es



总的来说，我们知道慢查询的SQL后，优化方案可以做如下尝试：

SQL语句优化，尽量精简，去除非必要语句
索引优化，让所有SQL都能够走索引
如果是表的瓶颈问题，则分表，单表数据量维持在1000W以内
如果是单库瓶颈问题，则分库，读写分离
如果是物理机器性能问题，则分多个数据库节点



### SQL语法优化

#### 索引

[Mysql索引（一篇就够le） - 一寸HUI - 博客园](https://www.cnblogs.com/zsql/p/13808417.html#_label2)

innodb存储的索引是基于B+树实现的



SQL语句常见优化
只要简单了解过MySQL内部优化机制，就很容易写出高性能的SQL

1.不使用子查询：
SELECT * FROM t1 WHERE id (SELECT id FROM t2 WHERE name='hechunyang');
在MySQL5.5版本中，内部执行计划器是先查外表再匹配内表，如果外表数据量很大，查询速度会非常慢

在MySQL5.6中，有对内查询做了优化，优化后SQL如下

SELECT t1.* FROM t1 JOIN t2 ON t1.id = t2.id;
但也仅针对select语句有效，update、delete子查询无效，所以生成环境不建议使用子查询

2.避免函数索引
SELECT * FROM t WHERE YEAR(d) >= 2016;
即使d字段有索引，也会全盘扫描，应该优化为：

SELECT * FROM t WHERE d >= '2016-01-01';
3.使用IN替换OR
SELECT * FROM t WHERE LOC_ID = 10 OR LOC_ID = 20 OR LOC_ID = 30;
非聚簇索引走了3次，使用IN之后只走一次：

SELECT * FROM t WHERE LOC_IN IN (10,20,30);
4.LIKE双百分号无法使用到索引
SELECT * FROM t WHERE name LIKE '%de%';
应优化为右模糊

SELECT * FROM t WHERE name LIKE 'de%';
5.增加LIMIT M,N 限制读取的条数
6.避免数据类型不一致
SELECT * FROM t WHERE id = '19';
应优化为

SELECT * FROM t WHERE id = 19;
7.分组统计时可以禁止排序
SELECT goods_id,count(*) FROM t GROUP BY goods_id;
默认情况下MySQL会对所有GROUP BY co1，col2 …的字段进行排序，我们可以对其使用ORDER BY NULL禁止排序，避免排序消耗资源

SELECT goods_id,count(*) FROM t GROUP BY goods_id ORDER BY NULL;
8.去除不必要的ORDER BY语句





### 查找MySQL中查询慢的SQL语句

[如何查找MySQL中查询慢的SQL语句 - Agoly - 博客园](https://www.cnblogs.com/qmfsun/p/4844472.html)

[MySQL慢查询：慢SQL定位、日志分析与优化方案-技术知识堂，你我他的技术圈子](https://www.jhelp.net/p/2t1OVTuBlm6ZESwn)

### mysql 读写分离

[(131条消息) 【mysql 读写分离】10分钟了解读写分离的作用_东华果汁哥的博客-CSDN博客_mysql读写分离作用](https://blog.csdn.net/u013421629/article/details/78793966)

### MySQL 分库分表

入门

[MySQL 分库分表方案，总结的非常好！ - 掘金 (juejin.cn)](https://juejin.cn/post/6844903648670007310)

#### 中间件

[数据库分库分表中间件实现原理和选型 - xuwc - 博客园 (cnblogs.com)](https://www.cnblogs.com/xuwc/p/14054327.html)

接触过 mycat 感觉mycat要配置好多东西

##### sharding-jdbc

[从前慢-Sharding-JDBC_unique_perfect的博客-CSDN博客](https://blog.csdn.net/unique_perfect/article/details/116134490)

[深入Sharding-JDBC分库分表从入门到精通【黑马程序员】_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1jJ411M78w/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)
