# java 中让人惊讶的框架

## 日志

### slf4j | 日志门面

#### 日志模板

api 有一个日志模板

不使用 String 进行拼接, 当然如果 logger 中有耗时的操作

我们还是需要加上 logger.isDebugEnabled() 进行判断

```java
logger.debug("start process request, url:{}", url); // SLF4J/LOG4J2
logger.debug("receive request: {}", () -> toJson(request)); // LOG4J2
logger.debug(() -> "receive request: " + toJson(request)); // LOG4J2
if (logger.isDebugEnabled()) { // SLF4J/LOG4J2
    logger.debug("receive request: " + toJson(request)); 
}

```

### log4j2 | 日志实现 快

Log4j 2基于LMAX Disruptor库，实现了一个高性能的异步记录器。在多线程场景中，异步记录器的吞吐量比Log4j 1.x和Logback高18倍，延迟低。

![异步记录器的吞吐量最高。](https://logging.apache.org/log4j/2.x/images/async-throughput-comparison.png)

[Log4j – Log4j 2 无锁异步记录器，用于低延迟日志记录 (apache.org)](https://logging.apache.org/log4j/2.x/manual/async.html)

##### 异步日志 | AsyncLogger

要在Log4j2中启用异步日志，可以使用`AsyncLogger`或`AsyncAppender`。以下是一个简单的异步日志配置示例：

```xml
<Configuration>
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <AsyncLogger name="com.example" level="info">
            <AppenderRef ref="Console"/>
        </AsyncLogger>
        <Root level="warn">
            <AppenderRef ref="Console"/>
        </Root>
    </Loggers>
</Configuration>

```

在这个配置示例中，我们使用了`<AsyncLogger>`元素来为名为`com.example`的Logger启用异步日志。这意味着，与`com.example`及其子Logger关联的日志事件将通过异步方式进行处理。对于Root Logger，我们仍然使用了同步日志。

如果你希望整个应用程序都使用异步日志，你可以在配置中使用`<AsyncRoot>`元素替换`<Root>`元素：

```xml
<Configuration>
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <AsyncLogger name="com.example" level="info">
            <AppenderRef ref="Console"/>
        </AsyncLogger>
        <AsyncRoot level="warn">
            <AppenderRef ref="Console"/>
        </AsyncRoot>
    </Loggers>
</Configuration>

```

此配置将确保所有日志事件都通过异步方式进行处理。请注意，虽然异步日志具有性能优势，但也存在一定的数据丢失风险和延迟。因此，在选择使用异步日志时，请根据你的应用程序需求和场景权衡利弊。

## 数据库

### zookeeper | 监听器

树形结构的数据库

可以说是分布式应用的先驱了

这是我第一个接触的分布式应用

临时顺序节点 加 监听器, 衍生了千变万化的应用

利用这个特性可以用来做 分布式锁/注册中心

## 基础构建

### Spring | IOC

IOC/AOP 真的令人惊艳

IOC 让我们免于创建对象, 复杂的对象 IOC 也能帮我们搞定

而AOP 就厉害了, 

依靠 bean 声明周期 

利用 postProcessor 创建代理对象

让我们得以免于CTRL CV重复的代码

利用 IOC 我们可以创建注入第三方对象

利用AOP 我们可以监控我们的接口/打印日志/处理事务

### Springboot | 自动配置

自动配置：根据应用程序的依赖关系自动配置应用程序

嵌入式Web服务器：内置了Tomcat、Jetty和Undertow等嵌入式Web服务器

spring 要跟其他框架结合需要大量的 xml 配置, 真的是苦不堪言

还好有 springboot 的自动化配置, 通过 @Condition 以及引入jar包class, 还有 spring.fatories 文件来达到自动化配置的过程

内嵌我们可以不用自己打包发布到 Tomcat 才能进行测试, 简直不要太爽

## 代码生成

### MapStruct | 对象转换

原先我们转换是通过 Apache 工具包或者 spring 工具包中 BeanUtils 工具类进行转换, 但是这是依靠反射, 这避免不了对性能的损耗

通过 MapStruct 在编译的时候就生成 转换的方法, 这样我们在运行的时候就不用在运行的时候再通过反射消耗时间, 直接调用方法转换就OK了

### ByteBuddy | 生成字节码

使用 ByteBuddy 生成字节码,

我可以不用动态代理就可以做代理了哦

[ByteBuddy 手撕字节码](https://blog.csdn.net/HongZeng_CSDN/article/details/130269007)

## 百宝箱

## Guava | 流畅风格比较器

使用流式替换咱们的比较器

#### 根据对象属性排序

假设我们有一个 Person 类，具有姓名和年龄属性：

```java

public class Person {  
    private String name;    private int age;  
    // 构造函数、getters 和 setters 省略  
}  
```

现在，我们可以使用 Ordering 类根据 Person 的属性进行排序：

```java

List<Person> people = // ... 初始化人员列表  

Ordering<Person> byAgeOrdering = Ordering.natural().onResultOf(Person::getAge);  
List<Person> sortedByAge = byAgeOrdering.sortedCopy(people);  
```

#### 多属性排序

我们还可以使用 Ordering 类根据多个属性进行排序，例如先按年龄排序，年龄相同时再按姓名排序：

```java

Ordering<Person> byNameOrdering = Ordering.natural().onResultOf(Person::getName);  
Ordering<Person> byAgeThenNameOrdering = byAgeOrdering.compound(byNameOrdering);  
List<Person> sortedByAgeThenName = byAgeThenNameOrdering.sortedCopy(people);  
```

这些示例展示了 Guava 中 Ordering 类的强大功能，可以方便地对集合进行排序。通过链式语法和流畅的 API，我们可以轻松地实现复杂的排序需求。
