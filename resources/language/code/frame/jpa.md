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



## maven 相关插件

[【Java】Maven常用的插件汇总（共8个） - 掘金 (juejin.cn)](https://juejin.cn/post/7142115195047903246)

在插件中配置Hibernate jpamodelgen

官网：hibernate.org/orm/tooling…
baeldung示例：www.baeldung.com/hibernate-c…

在编绎阶段生成JPA的 Metamodel，然后可以使用hibernate critieria queries。
同样的，在maven-complier-plugin插件中配置：




```xml
<build> <plugins> <plugin> <groupId>org.apache.maven.plugins</groupId>
 <artifactId>maven-compiler-plugin</artifactId>
 <version>3.10.1</version>
 <configuration> <annotationProcessorPaths> <path> <groupId>org.projectlombok</groupId>
 <artifactId>lombok</artifactId>
 <version>1.18.22</version> </path>
 <path> <groupId>org.hibernate</groupId>
 <artifactId>hibernate-jpamodelgen</artifactId>
 <version>5.4.3.Final</version> </path> </annotationProcessorPaths> </configuration> </plugin> </plugins></build>
```

[JPA criteria 查询:类型安全与面向对象 - ZhaoQian's Blog - OSCHINA - 中文开源技术交流社区](https://my.oschina.net/zhaoqian/blog/133500)


