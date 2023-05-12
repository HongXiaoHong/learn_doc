# mybatis-plus

## todo

- [MybatisPlus 代码生成器讲解-------各种配置----_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1sq4y1V77p/?spm_id_from=333.999.0.0&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## 版本要求

mybatis-plus 3.5.3 才支持 spring boot 3



## 入门

[【遇见狂神说】MyBatisPlus视频笔记/MyBatisPlus.pdf · 狂神说/KuangLiveNote - 码云 - 开源中国 (gitee.com)](https://gitee.com/kuangstudy/kuang_livenote/blob/master/%E3%80%90%E9%81%87%E8%A7%81%E7%8B%82%E7%A5%9E%E8%AF%B4%E3%80%91MyBatisPlus%E8%A7%86%E9%A2%91%E7%AC%94%E8%AE%B0/MyBatisPlus.pdf)

官网: 



## 重要特性

1. ***代码生成器*** 配置库表,生成类信息信息, 帮我们自动生成entity service controller等类和配置

2. ***Wrapper 条件构造器***, 构造复杂的查询条件

3. 继承基础类, 帮我们产生单表的增删改查方法

4. 通过注解配置主键生成策略, 包括UUID + 雪花算法(默认) + 手动设置 + 不设置

5. 通过注解以及配置自动设置创建时间,修改时间

6. 通过version字段实现乐观锁

7. 实现逻辑删除

8. 有自己的分页插件,甚至还有慢SQL性能分析



## 核心

⭐ ***代码生成器*** [代码生成器（新） | MyBatis-Plus (baomidou.com)](https://baomidou.com/pages/779a6e/)

⭐ ***Wrapper 条件构造器*** [条件构造器 | MyBatis-Plus (baomidou.com)](https://baomidou.com/pages/10c804/)



### 代码生成器



#### 引入jar

记得generator jar包跟 mybatis-plus starter版本匹配

```xml
<dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-generator</artifactId>
            <version>3.5.2</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-freemarker</artifactId>
        </dependency>
```

#### 生成方法

**多个表用 , 隔开**

```java
@Test
    void gen() {
        FastAutoGenerator.create("jdbc:sqlite:D:\\learn\\experiment\\Java\\learn\\mybatis\\sql\\db.sqlite", "", "")
                .globalConfig(builder -> {
                    builder.author("hong") // 设置作者
                            .enableSwagger() // 开启 swagger 模式
                            .fileOverride() // 覆盖已生成文件
                            .outputDir("E:\\mybatis\\plus\\gen"); // 指定输出目录
                })
                .packageConfig(builder -> {
                    builder.parent("cn.gd.cz.hong.demo.plus") // 设置父包名
                            .moduleName("mybatis") // 设置父包模块名
                            .pathInfo(Collections.singletonMap(OutputFile.xml, "E:\\mybatis\\plus\\gen")); // 设置mapperXml生成路径
                })
                .strategyConfig(builder -> {
                    builder.addInclude("teacher"); // 设置需要生成的表名
                            //.addTablePrefix("t_", "c_"); // 设置过滤表前缀
                })
                .templateEngine(new FreemarkerTemplateEngine()) // 使用Freemarker引擎模板，默认的是Velocity引擎模板
                .execute();
    }
```



#### 生成结果



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/explorer_CcXdFaCe1a.png)

## 

## 常用

### 多表查询

其实跟在mybatis 中一样

[(17条消息) mybatis-plus实现自定义SQL、多表查询、多表分页查询_mybatisplus自定义查询_Eric-x的博客-CSDN博客](https://blog.csdn.net/weixin_47316183/article/details/124585722)

## 常见异常

### 代码生成器

#### generator jar包跟 mybatis-plus starter版本不匹配

java.lang.NoSuchMethodError: com.baomidou.mybatisplus.core.toolkit.StringUtils.isBlank

高版本才有 这个方法

#### 没有引入 模板引擎

java.lang.NoClassDefFoundError: freemarker/template/Configuration
