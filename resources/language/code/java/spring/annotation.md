# spring 注解

Spring是开发中必不可少的一个框架，基于传统的xml方式配置太过繁琐，Spring 从2.5 版本开始提供了对注解技术的全面支持，我们可以使用注解来实现自动装配，简化Spring 的XML 配置
https://blog.csdn.net/ligonglanyuan/article/details/124787811

## @PropertySource | 配置文件值注入 spring environment

https://www.cnblogs.com/binghe001/p/13455820.html

person.properties:

```properties
person.nickName=zhangsan

```

注入灵魂:

```java
package io.mykit.spring.plugins.register.config;
import io.mykit.spring.plugins.register.bean.Person;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
/**
 * @author binghe
 * @version 1.0.0
 * @description 测试属性赋值
 */
@PropertySource(value = {"classpath:person.properties"})
@Configuration
public class PropertyValueConfig {
    @Bean
    public Person person(){
        return new Person();
    }
}

```

日志:
```log
org.springframework.context.annotation.internalConfigurationAnnotationProcessor
org.springframework.context.annotation.internalAutowiredAnnotationProcessor
org.springframework.context.annotation.internalCommonAnnotationProcessor
org.springframework.context.event.internalEventListenerProcessor
org.springframework.context.event.internalEventListenerFactory
propertyValueConfig
person
================================
Person(name=binghe, age=18, nickName=zhangsan)

```

### 使用Environment获取值

```java
@Test
public void testPropertyValue03(){
    AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(PropertyValueConfig.class);
    Environment environment = context.getEnvironment();
    String nickName = environment.getProperty("person.nickName");
    System.out.println(nickName);
}

```

