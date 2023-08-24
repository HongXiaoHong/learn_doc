# mysql

看完这个 我觉得就超过 80% 的人了

[(25条消息) MySQL江湖路 | 专栏目录__陈哈哈的博客-CSDN博客](https://blog.csdn.net/qq_39390545/article/details/107786761)

## 基本语法

[(25条消息) 数据库中DQL、DML、DDL、DCL的概念与区别_Levine-Huang的博客-CSDN博客](https://blog.csdn.net/sinat_25059791/article/details/69666318)

SQL语言共分为四大类：数据定义语言DDL，数据操纵语言DML，数据查询语言DQL，数据控制语言DCL

DDL 是数据定义语言的缩写，简单来说，就是对数据库内部的对象进行创建、删除、修改的操作语言

DML 只是对表内部数据的操作，而不涉及到表的定义、结构的修改，更不会涉及到其他对象
4

1. 数据定义语言DDL
   
   数据定义语言DDL用来创建数据库中的各种对象-----表、视图、索引、同义词、聚簇等如：
   
   CREATE TABLE/VIEW/INDEX/SYN/CLUSTER
   
   DDL操作是隐性提交的！不能rollback
   
   2 .数据操纵语言DML
   
   数据操纵语言DML主要有三种形式：
1) 插入：INSERT

2) 更新：UPDATE

3) 删除：DELETE
3. 数据查询语言DQL
   
   数据查询语言DQL基本结构是由SELECT子句，FROM子句，WHERE子句组成的查询块：
   
   SELECT <字段名表>
   
   FROM <表或视图名>
   
   WHERE <查询条件>

4. 数据控制语言DCL
   
   数据控制语言DCL用来授予或回收访问数据库的某种特权，并控制数据库操纵事务发生的时间及效果，对数据库实行监视等。如：
1) GRANT：授权。

2) ROLLBACK [WORK] TO [SAVEPOINT]：回退到某一点。
   
   回滚---ROLLBACK
   
   回滚命令使数据库状态回到上次最后提交的状态。其格式为：
   
   SQL>ROLLBACK

### DDL | 数据定义

创建

更新

删除

#### 字段类型

##### text

[(25条消息) Mysql存储大数据字符串_mysql大字符串存储_runrun117的博客-CSDN博客](https://blog.csdn.net/runrun117/article/details/85772247)

TINYTEXT - 1个字节(255个字符)
TEXT - 64KB(65,535个字符)
MEDIUMTEXT - 16MB(16,777,215个字符)
LONGTEXT - 4GB(4,294,967,295个字符)

### DML | 数据操纵

### DCL | 数据控制

### DQL | 数据查询

#### limit | 分页查询

select _column,_column from _table [where Clause] [limit N][offset M]

- select * : 返回所有记录
- limit N : 返回 N 条记录
- offset M : 跳过 M 条记录, 默认 M=0, 单独使用似乎不起作用
- limit N,M : 相当于 **limit M offset N** , 从第 N 条记录开始, 返回 M 条记录

实现分页：

select * from _table limit (page_number-1)*lines_perpage, lines_perpage

## 底层原理

<img title="" src="https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_NnNEV3xlLM.png" alt="" width="642" data-align="right">

说明:

**1）连接器：**主要负责跟客户端建立连接、获取权限、维持和管理连接。

**2）查询缓存：**优先在缓存中进行查询，如果查到了则直接返回，如果缓存中查询不到，在去数据库中查询。

MySQL缓存是默认关闭的，也就是说不推荐使用缓存，并且在MySQL8.0 版本已经将查询缓存的整块功能删掉了。这主要是它的使用场景限制造成的：

- 先说下缓存中数据存储格式：key（sql语句）- value（数据值），所以如果SQL语句（key）只要存在一点不同之处就会直接进行数据库查询了；

- 由于表中的数据不是一成不变的，大多数是经常变化的，而当数据库中的数据变化了，那么相应的与此表相关的缓存数据就需要移除掉。

**3）解析器/分析器：**分析器的工作主要是对要执行的SQL语句进行词法解析、语法解析，最终得到抽象语法树，然后再使用预处理器对抽象语法树进行语义校验，判断抽象语法树中的表是否存在，如果存在的话，在接着判断select投影列字段是否在表中存在等。

**4）优化器：**主要将SQL经过词法解析、语法解析后得到的语法树，通过数据字典和统计信息的内容，再经过一系列运算 ，最终得出一个执行计划，包括选择使用哪个索引。

在分析是否走索引查询时，是通过进行动态数据采样统计分析出来；只要是统计分析出来的，那就可能会存在分析错误的情况，所以在SQL执行不走索引时，也要考虑到这方面的因素。

**5）执行器：**根据一系列的执行计划去调用存储引擎提供的API接口去调用操作数据，完成SQL的执行

https://www.bilibili.com/list/watchlater?bvid=BV1iv4y1S7nj&oid=562551647  号称 B 站最完整的查询过程

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_Ow6vbAm9dw.png)

## sql 优化

[搞懂这些SQL优化技巧，面试横着走-51CTO.COM](https://www.51cto.com/article/623584.html)

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

##### 4.LIKE双百分号无法使用到索引

SELECT * FROM t WHERE name LIKE '%de%';
应优化为右模糊

SELECT * FROM t WHERE name LIKE 'de%';

覆盖索引

索引中存放了 select 中需要的列 不要重新回标

这里我们可以把 * 改成 id 之后再做关联

- 优化为右模糊 可以在存放的时候倒序存放

- 或者使用覆盖索引
  
  - [mysql覆盖索引详解——like模糊全匹配中使用索引_斗者_2013的博客-CSDN博客](https://blog.csdn.net/w1014074794/article/details/89886068)
  
  - [模糊查询下（like）如何使用覆盖索引优化_模糊查询覆盖索引的方法_布道的博客-CSDN博客](https://blog.csdn.net/alex_xfboy/article/details/82789942)

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

## 表分区

概念: 

[MySQL 分区和分表知识总结_51CTO博客_mysql分区和分表优缺点](https://blog.51cto.com/u_15127572/2721326)

分区和分表相似，都是按照规则分解表。不同在于分表将大表分解为若干个独立的实体表，而分区是将数据分段划分在多个位置存放，可以是同一块磁盘也可以在不同的机器。分区后，表面上还是一张表，但数据散列到多个位置了。app读写的时候操作的还是大表名字，db自动去组织分区的数据

[MySQL 表分区？涨知识了！ - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1963167)

不同于 MyCat 中既可以垂直切分又可以水平切分，[MySQL 数据库](https://cloud.tencent.com/product/cdb?from=10680)支持的分区类型为水平分区，它不支持垂直分区。

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_WHrCscFBVA.png)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_cXpjBJwWG3.png)

## mysql 8 新特性

### 窗口函数/分析函数 | 用来做复杂的分析

入门 [《MySQL 8.0 新特性》第13篇 窗口函数基本概念_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1UP4y137U9/?spm_id_from=333.788&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[(25条消息) mysql窗口函数（分析函数）知识笔记_mysql分析函数_人生苦短，我用python!的博客-CSDN博客](https://blog.csdn.net/weixin_50883445/article/details/115305713)

```mysql
select year,country,product,profit,
sum(profit) OVER (partition by country) as country_profit from sales
order by country,year,product,profit; 
```

不用 group by 就可以做数据的统计分析

每一行都会有一个记录

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_OnIy3Ahs2s.png)

#### 语法

> 函数名([参数]) over(partition by [分组字段] order by [排序字段] asc/desc rows/range between 起始位置 and 结束位置)

## 常见问题

[(25条消息) 细说varchar与char有哪些区别？_char和varchar区别__陈哈哈的博客-CSDN博客](https://blog.csdn.net/qq_39390545/article/details/109379218)

变长与固定

char 尾部空格会被截断 varchar则不会

### 意向锁 作用

用于判断该表是否已经有记录锁住了某条记录 如果刚好想加一个表锁的话

[详解 MySql InnoDB 中意向锁的作用 - 掘金](https://juejin.cn/post/6844903666332368909)

事务 A 获取了某一行的排他锁，并未提交：

```n1ql
SELECT * FROM users WHERE id = 6 FOR UPDATE;复制代码
```

事务 B 想要获取 `users` 表的表锁：

```pgsql
LOCK TABLES users READ;复制代码
```

因为共享锁与排他锁`互斥`，所以事务 B 在视图对 `users` 表加共享锁的时候，必须保证：

- 当前没有其他事务持有 users 表的排他锁。
- 当前没有其他事务持有 users 表中任意一行的排他锁 。

为了检测是否满足第二个条件，事务 B 必须在确保 `users`表不存在任何排他锁的前提下，去检测表中的每一行是否存在排他锁。很明显这是一个效率很差的做法，但是有了**意向锁**之后

### 各种日志

[3000帧动画图解MySQL为什么需要binlog、redo log和undo log | HeapDump性能社区](https://heapdump.cn/article/3890459)

#### binlog | 归档日志

主要用于 主从复制

#### redo log | 重做日志

保证持久性 就算系统宕机 也能恢复数据

#### undo log | 重做日志

用于回退事务

## 重要概念

### 当前读和快照读

- 当前读就是读的是当前时刻已提交的数据

- 快照读就是读的是快照生成时候的数据

[【Mysql核心剖析系列】当前读与快照读的区别 - 掘金 (juejin.cn)](https://juejin.cn/post/7001357238648438821#heading-2)

#### 怎么知道执行的语句是当前读还是快照读？

###### 1.在默认隔离级别下，select 语句默认是快照读

```csharp
select a from t where id = 1
```

###### 2.select 语句加锁是当前读

```csharp
# 共享锁
select a from t where id = 1 lock in share mode;

#排他锁
select a from t where id = 1 for update;
```

###### 3.update 语句是当前读

```ini
update t set a = a + 1;
```



## 高效插入数据

[[译] MySQL 最佳实践 —— 高效插入数据 - 掘金 (juejin.cn)](https://juejin.cn/post/6844904118939549703)

`LOAD DATA INFILE` 是一个专门为 MySQL 高度优化的语句，它直接将数据从 CSV / TSV 文件插入到表中
