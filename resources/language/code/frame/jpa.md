# jpa

Spring Data JPA可以根据接口方法名来实现数据库操作
基本使用 推荐
https://blog.csdn.net/qq_30054997/article/details/79420141
https://zhuanlan.zhihu.com/p/100076652

常见问题
什么是JPA？
java 持久 api 一套持久化的规范
我们使用方法去操作我们的数据库
实现的框架有 hibernate

Spring Data JPA的优点是什么？
通过方法去操作数据库 减少SQL的编写
如果切换数据库 不用重新编写SQL

如何使用Spring Data JPA来进行数据持久化？

我们可以通过继承 JpaRepository 实现基本的增删改查
复杂的可以通过 jsql

如何使用JPA的注解来映射数据模型？
@Entity 注解

Spring Data JPA支持哪些数据库？
不支持 sqlite 
支持 mysql Oracle 等

如何使用Spring Data JPA实现多数据源支持？
@Repository("数据源") 指定数据源

Spring Data JPA如何实现动态查询？
使用Specification实现多条件组合的分页查询
@Query动态SQL语句，且分页
https://www.cnblogs.com/zhangliang88/p/13163444.html

如何使用Spring Data JPA实现分页和排序？
使用Specification实现多条件组合的分页查询
https://blog.csdn.net/pan_junbiao/article/details/105581074