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

## web/mvc
### 注解
#### @RequestMapping | 路径映射

RequestMapping 还有 其他类似 PostMapping GetMapping 

通过其他参数例如 method/headers/... 来限制
当前请求是否可以被请求, 例如配置请求头是否带有其他参数

#### produces 和 consumes | 请求头 ContentType 和 Accept
[RequestMapping 中produces 和 consumes](https://www.jianshu.com/p/f78b43f048e6)
HTTP协议Header中的两个东西 ContentType 和Accept。

ContentType： 告诉服务器当前发送的数据是什么格式
Accept ： 用来告诉服务器，客户端能认识哪些格式,最好返回这些格式

```java
// value， method；
// value：   指定请求的实际地址，指定的地址可以是URI Template 模式（后面将会说明）；
// method：  指定请求的method类型， PUT、GET、DELETE、POST 分别对应注解@PutMapping @GetMapping @DeleteMapping @PostMapping；

// consumes，produces；
// consumes： 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html;
// produces:    指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；

// params，headers；
// params： 指定request中必须包含某些参数值是，才让该方法处理。
// headers： 指定request中必须包含某些指定的header值，才能让该方法处理请求。

/**
* consumes 标识处理request Content-Type为“application/json”类型的请求.
* produces标识处理request请求中Accept头中包含了"application/json"的请求.
* 同时暗示了返回的内容类型为application/json;
*/
  @ApiOperation(value = "保存用户")
  @PostMapping(value = "/execute",produces = MediaType.APPLICATION_JSON_VALUE,consumes = MediaType.APPLICATION_JSON_VALUE)
  public String saveUser(@RequestBody User userl){
        //TO DO
        return "保存成功";
  }

```

#### @InitBinder | 数据类型转换
加载 Controller 只用于当前 Controller 使用
如果加载 ControllerAdvice 则是所有的 Controller 一起使用

[spring中的@InitBinder注解使用](https://www.cnblogs.com/better-farther-world2099/articles/10971897.html)

```java
@ControllerAdvice
public class GlobalControllerAdvice {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class,
                new StringTrimmerEditor(true));

        binder.registerCustomEditor(Date.class,
                new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), false));

    }
}
```