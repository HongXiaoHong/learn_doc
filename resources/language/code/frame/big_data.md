# 大数据

刚认识 Hadoop

[大数据之hadoop / hive / hbase 的区别是什么？有什么应用场景？ - 掘金 (juejin.cn)](https://juejin.cn/post/6844903734699376648)

# 1. hadoop

它是一个**分布式计算+分布式文件系统**，前者其实就是 **MapReduce**，后者是 **HDFS** 。后者可以独立运行，前者可以选择性使用，也可以不使用

---

# 2. hive

通俗的说是一个**数据仓库**，仓库中的数据是被hdfs管理的数据文件，它支持类似sql语句的功能，你可以通过该语句完成分布式环境下的计算功能，**hive会把语句转换成MapReduce，然后交给hadoop执行**。这里的计算，仅限于查找和分析，而不是更新、增加和删除。

它的优势是对历史数据进行处理，用时下流行的说法是离线计算，因为它的**底层是MapReduce**，MapReduce在实时计算上性能很差。它的做法是把数据文件加载进来作为一个hive表（或者外部表），让你觉得你的sql操作的是传统的表。

---

# 3. hbase

通俗的说，hbase的作用类似于数据库，传统数据库管理的是集中的本地数据文件，而**hbase基于hdfs实现对分布式数据文件的管理，比如增删改查**。也就是说，hbase只是利用hadoop的hdfs帮助其管理数据的持久化文件（HFile），**它跟MapReduce没任何关系。**

**hbase的优势在于实时计算**，所有实时数据都直接存入hbase中，客户端通过API直接访问hbase，实现实时计算。由于它使用的是nosql，或者说是列式结构，从而提高了查找性能，使其能运用于大数据场景，这是它跟MapReduce的区别。

---

# 总结

**hadoop是hive和hbase的基础**，hive依赖hadoop，而hbase仅依赖hadoop的hdfs模块。

hive适用于**离线数据的分析**，操作的是通用格式的（如通用的日志文件）、被hadoop管理的数据文件，它支持类sql，比编写MapReduce的java代码来的更加方便，它的定位是数据仓库，存储和分析历史数据。

hbase适用于**实时计算**，采用列式结构的nosql，操作的是自己生成的特殊格式的HFile、被hadoop管理的数据文件，它的定位是数据库，或者叫DBMS。

hive可以直接操作hdfs中的文件作为它的表的数据，也可以使用hbase数据库作为它的表。

[(24条消息) Hadoop大数据生态：SpringBoot整合hive，使用spring的jdbcTemplate操作Hive_jdbctemplate hive_尘光掠影的博客-CSDN博客](https://blog.csdn.net/alan_liuyue/article/details/90314676)

jdbctemplate操作hive数据源的时候，基本支持所用到的hql语言，可自行测试；
Hive与关系型数据库不一样，关系型数据库都是为了实时查询的业务进行设计的，而Hive则是为海量数据做数据挖掘设计的，实时性很差，一般不做实时性查询，如果需要结合实时性查询，可了解整合spark

[Spark再体验之springboot整合spark - 简书 (jianshu.com)](https://www.jianshu.com/p/69d4547688c9)

[实战代码（十一）：Springboot集成Hbase - 简书 (jianshu.com)](https://www.jianshu.com/p/f0c572bba707)
