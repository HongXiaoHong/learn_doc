# springboot

## todo

springboot 3 以及 jdk17 等待学习

- [springboot 3 下连接 mysql 数据库以及整合 mybatis-plus - 掘金](https://juejin.cn/post/7197434894849572923)
- [springboot 启动原理](https://www.bilibili.com/video/BV1e14y1A7pT/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## 版本

[这可能是最全的SpringBoot3新版本变化了！ - 艾小仙 - 博客园 (cnblogs.com)](https://www.cnblogs.com/ilovejaney/p/16931780.html#springboottest%E4%BC%98%E5%8C%96%E5%8D%87%E7%BA%A7)

## yml

使用 ${} 可以引用 环境变量 或者定义在 yaml 中的数据

同时可以用使用默认值
${env_name:default_value}

## springboot 与 存活就绪探针

高版本的 spring boot 2.3.0.M4 + 支持我们的探针 

不用加入 Actuator

### k8s 健康检查

[配置 Pod 的 liveness 和 readiness 探针 · Kubernetes 中文指南——云原生应用架构实战手册](https://jimmysong.io/kubernetes-handbook/guide/configure-liveness-readiness-probes.html)

当应用部署到kubernetes，kubernetes提供了两种探测机制

- Liveness探测(存活探针)：Liveness探测让用户可以自定义判断容器是否健康的条件。如果探测失败，Kubernetes就会重启容器

- Readiness探测(就绪探针)：Readiness探测则是告诉Kubernetes什么时候可以将容器加入到Service负载均衡池中，对外提供服务

### Actuator

[深入研究下Spring Boot Actuator 在kubernetes中探针的应用（spring boot testng） | 半码博客](https://www.bmabk.com/index.php/post/29859.html)

## 常见问题

[Spring Boot 面试，一个问题就干趴下了！ - 纯洁的微笑博客 (ityouknow.com)](http://www.ityouknow.com/springboot/2019/07/24/springboot-interview.html)

### 自动装配实现

[B站目前讲的最透彻的SpringBoot自动配置，大厂面试必备知识点#安员外很有码_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1NY411P7VX/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

### @AutoConfigurationPackage注解 作用

他只是将当前注解标识的包名存入组件中加入到容器里; 作用是用于一些第三方调用这个组件里面的包名用于扫描包内自身实体类加入到容器里. 所以其本身并不会有扫描的作用.

AutoConfigurationPackage注解的作用是将 **添加该注解的类所在的package** 作为 **自动配置package** 进行管理。

[(21条消息) @AutoConfigurationPackage注解_阿湯哥的博客-CSDN博客](https://blog.csdn.net/ttyy1112/article/details/101284541)

### 项目启动时初始化资源

CommandLineRunner 接口的 Component 会在所有 Spring Beans 都初始化之后，SpringApplication.run() 之前执行

```java

```

### 事务

#### spring boot注解@Transactional失效

[(27条消息) spring boot注解@Transactional失效_时光无声_l的博客-CSDN博客](https://blog.csdn.net/liuziteng0228/article/details/81843271)

可能原因

当@Transactional不起作用时，可以通过以下几个步骤确认一下问题：
       1、首先要看数据库对应的库、表所设置的引擎是什么。Mylsam不支持事务，如果需要用事务，必须改为InnnoDB
       2、@Transactional所注解的方法是否为public
       3、@Transactional所注解的方法所在的位置
       4、需要调用该方法，且需要支持事务特性的调用方是在@Transactional所在的类的外面。注意：类内部的其他方法调用了这个注解了@Transactional的方法，事务是不会起作用的
       这意味着，一个目标对象的方法调用该目标对象的另外一个方法，即使被调用的方法已使用了@Transactional注解标记，事务也不会有效执行
       5、注解为事务范围的方法中，事务的回滚仅仅对于unchecked的异常有效，对于checked异常无效。也就是说事务回滚仅仅发生在出现RuntimeException或Error的时候
       如果希望一般的异常也能触发事务回滚，需要在注解了@Transactional的方法上，将@Transactional回滚参数设置为：@Transactional(rollbackFor=Exception.class)
       6、非springboot项目，需要检查spring的xml配置文件中：
       1）扫描包范围是否配置好，否则不会再启动时spring容器中创建和加载对应的bean对象

```xml
<context:component-scan base-package="com.XXX" ></context:component-scan>
```

       2）事务是否已经配置成开启

```xml
<tx:annotation-driven transaction-manager="transactionManager" proxy-target-class="true"/>
```

       7、springboot项目默认已经支持事务了，可以写也可以不写
       1）springboot启动类，即程序入口类，需要注解@EnableTransactionManagement

```java
package com.test.pets;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableTransactionManagement
@SpringBootApplication
public class PetsApplication {
public static void main(String[] args) {
    SpringApplication.run(PetsApplication.class, args);
}
}
```

       2）springboot配置文件application.yml中，可以配置上失败回滚

```yaml
spring:
 profiles:
 active: prod
 datasource:
 driver-class-name: com.mysql.jdbc.Driver
 url: jdbc:mysql://127.0.0.1:3306/spbdb
 username: root
 password:
 transaction:
 rollback-on-commit-failure: true
```

## 常用代码

### 打印出参入参

继承 RequestBodyAdvice ResponseBodyAdvice 加上注解@ControllerAdvice
