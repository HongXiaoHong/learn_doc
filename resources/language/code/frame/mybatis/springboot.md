# springboot 整合 mybatis

数据源 各种配置包括实体类/mapper xml配置/mapper 接口配置都没问题的情况下

```log
Caused by: java.lang.IllegalArgumentException: Property 'sqlSessionFactory' or 'sqlSessionTemplate' are required
```
https://www.cnblogs.com/han-1034683568/p/16920607.html

因为升级到 springboot 3 的缘故 springboot 引用 spring 6

spring 6 这个老六直接删除了 相关的类

把 mybatis springboot starter 升级就可以了

```xml
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>3.0.2</version>
</dependency>
```

### mybatis 整合 sqlite
#### 创建 sqlite
- 创建 sqlite
- 使用 idea/vscode 或者其他 SQL 客户端 连接到 sqlite
- 插入数据
- 使用 select * ... 进行验证

#### 创建 springboot 工程
spring 网站或者 idea 甚至 vscode 创建
随你
#### idea 准备
安装 mybatis x

#### 导包

导入 sqlite 驱动
导入 mybatis starter 记得要与 springboot 3 兼容, 如果你用的是 springboot 3 的话 记得使用 mybatis starter 3 +

如何整合可参考:
https://blog.csdn.net/chinoukin/article/details/106538925

### 如何将 mapper 注入 spring
[【SpringBoot + Mybatis系列】Mapper接口注册的几种方式](https://cloud.tencent.com/developer/article/1852524)
2.1 @MapperScan注册方式
2.2 @Mapper 注册方式
2.3 MapperScannerConfigurer注册方式