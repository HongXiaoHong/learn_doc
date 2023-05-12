# 日志打印

## todo

- [SpringBoot 整合 log4j2 使用yml的配置 - 掘金 (juejin.cn)](https://juejin.cn/post/7123954724419665950)

- [(17条消息) log4j2使用filter过滤日志_log4j2 filter_justry_deng的博客-CSDN博客](https://blog.csdn.net/justry_deng/article/details/109413153)

- [log4j2配置详解之Filters - 此木 (chaiguanxin.com)](http://www.chaiguanxin.com/articles/2019/03/04/1551680272725.html#toc_h2_1)

slf4j
slf4j从LoggerFactory.getLogger()说起
https://blog.csdn.net/gs_albb/article/details/110285543

log4j2 之前有一个漏洞

[集成了 log4j 的 SpringBoot 下的漏洞复现 - 链滴 (ld246.com)](https://ld246.com/article/1639235464846)

## 入门

入门这篇完全够够的

[深入掌握Java日志体系，再也不迷路了 - 掘金](https://juejin.cn/post/6905026199722917902#heading-29)

视频:

[【黑马程序员】最牛逼的 Java 日志框架，全面深入学习多种java日志框架，性能无敌，横扫所有对手](https://www.bilibili.com/video/BV11g411P7mv?p=1)

## 桥接模式

https://design-patterns.readthedocs.io/zh_CN/latest/structural_patterns/bridge.html

## slf4j 怎么找到对应的实现类的

findServiceProvide 找到对应的实现类

通过在 classpath 中寻找到对应的 实现类 多个就使用第一个

```java
private static final void bind() {
        try {
            List<SLF4JServiceProvider> providersList = findServiceProviders();
            reportMultipleBindingAmbiguity(providersList);
            if (providersList != null && !providersList.isEmpty()) {
                PROVIDER = (SLF4JServiceProvider)providersList.get(0);
                PROVIDER.initialize();
                INITIALIZATION_STATE = 3;
                reportActualBinding(providersList);
            } else {
                INITIALIZATION_STATE = 4;
                Util.report("No SLF4J providers were found.");
                Util.report("Defaulting to no-operation (NOP) logger implementation");
                Util.report("See https://www.slf4j.org/codes.html#noProviders for further details.");
                Set<URL> staticLoggerBinderPathSet = findPossibleStaticLoggerBinderPathSet();
                reportIgnoredStaticLoggerBinders(staticLoggerBinderPathSet);
            }

            postBindCleanUp();
        } catch (Exception var2) {
            failedBinding(var2);
            throw new IllegalStateException("Unexpected initialization failure", var2);
        }
    }
```

```java
private static ServiceLoader<SLF4JServiceProvider> getServiceLoader(ClassLoader classLoaderOfLoggerFactory) {
        SecurityManager securityManager = System.getSecurityManager();
        ServiceLoader serviceLoader;
        if (securityManager == null) {
            serviceLoader = ServiceLoader.load(SLF4JServiceProvider.class, classLoaderOfLoggerFactory);
        } else {
            PrivilegedAction<ServiceLoader<SLF4JServiceProvider>> action = () -> {
                return ServiceLoader.load(SLF4JServiceProvider.class, classLoaderOfLoggerFactory);
            };
            serviceLoader = (ServiceLoader)AccessController.doPrivileged(action);
        }

        return serviceLoader;
    }
```

## 各种转换关系 SLF4J 的 🤔桥接器和适配器

[一文读懂Java日志系统与SLF4J桥接关系 - 掘金 (juejin.cn)](https://juejin.cn/post/7078293070751465508)

![SLF4J桥接包关系图](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/879f572c91a345849aba912326dc40ae~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?)

## SPI机制

[Java常用机制 - SPI机制详解 | Java 全栈知识体系 (pdai.tech)](https://pdai.tech/md/java/advanced/java-advanced-spi.html)

## logback

[看完这个不会配置 logback ，请你吃瓜！ - 掘金 (juejin.cn)](https://juejin.cn/post/6844903641535479821)

之前在 [日志？聊一聊slf4j吧](https://juejin.cn/post/6844903591455490056 "https://juejin.cn/post/6844903591455490056") 这篇文章中聊了下`slf4j`。本文也从实际的例子出发，针对`logback`的日志配置进行学习。

### logack 简介

> logback 官网：https://logback.qos.ch/

目前还没有看过日志类框架的源码，仅限于如何使用。所以就不说那些“空话”了。最直观的认知是：

- `logback`和`log4j`是一个人写的
- `springboot`默认使用的日志框架是`logback`。
- 三个模块组成
  - logback-core
  - logback-classic
  - logback-access
- 其他的关于性能，关于内存占用，关于测试，关于文档详见源码及官网说明

`logback-core` 是其它模块的基础设施，其它模块基于它构建，显然，`logback-core` 提供了一些关键的通用机制。`logback-classic` 的地位和作用等同于 `Log4J`，它也被认为是 `Log4J` 的一个改进版，并且它实现了简单日志门面 `SLF4J`；而 `logback-access` 主要作为一个与 `Servlet` 容器交互的模块，比如说`tomcat`或者 `jetty`，提供一些与 `HTTP` 访问相关的功能。

### 配置文件详解

这部分主要来学习下logback配置文件的一些配置项。

#### configuration

先来看这张图，这个结构就是整个logback.xml配置文件的结构。

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/20/164b84acd40e3590~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

对应来看下配置文件：

```xml
<configuration scan="true" scanPeriod="60 seconds" debug="false">  
    <property name="glmapper-name" value="glmapper-demo" /> 
    <contextName>${glmapper-name}</contextName> 


    <appender>
        //xxxx
    </appender>   

    <logger>
        //xxxx
    </logger>

    <root>             
       //xxxx
    </root>  
</configuration>  
复制代码
```

> ps：想使用spring扩展profile支持，要以logback-spring.xml命名，其他如property需要改为springProperty

- scan:当此属性设置为true时，配置文件如果发生改变，将会被重新加载，默认值为true。
- scanPeriod:设置监测配置文件是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒。当scan为true时，此属性生效。默认的时间间隔为1分钟。
- debug:当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态。默认值为false。

#### contextName

每个`logger`都关联到`logger`上下文，默认上下文名称为`“default”`。但可以使用`contextName`标签设置成其他名字，用于区分不同应用程序的记录

#### property

用来定义变量值的标签，`property`标签有两个属性，`name`和`value`；其中`name`的值是变量的名称，`value`的值时变量定义的值。通过`property`定义的值会被插入到`logger`上下文中。定义变量后，可以使“${name}”来使用变量。如上面的`xml`所示。

#### logger

用来设置某一个包或者具体的某一个类的日志打印级别以及指定`appender`。

#### root

根logger，也是一种logger，且只有一个level属性

#### appender

负责写日志的组件，下面会细说

#### filter

filter其实是appender里面的子元素。它作为过滤器存在，执行一个过滤器会有返回DENY，NEUTRAL，ACCEPT三个枚举值中的一个。

- DENY：日志将立即被抛弃不再经过其他过滤器
- NEUTRAL：有序列表里的下个过滤器过接着处理日志
- ACCEPT：日志会被立即处理，不再经过剩余过滤器

### 案例分析

首先来配置一个非常简单的文件。这里申请下，我使用的是 `logback-spring.xml`。和 `logback.xml` 在`properties`上有略微差别。其他都一样。

> 工程：springboot+web

先来看下项目目录

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164b8ba7a44783aa~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

properties中就是指定了日志的打印级别和日志的输出位置：

```ini
#设置应用的日志级别
logging.level.com.glmapper.spring.boot=INFO
#路径
logging.path=./logs
复制代码
```

#### 通过控制台输出的log

##### logback-spring.xml的配置如下：

```xml
<configuration>
    <!-- 默认的控制台日志输出，一般生产环境都是后台启动，这个没太大作用 -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <Pattern>%d{HH:mm:ss.SSS} %-5level %logger{80} - %msg%n</Pattern>
        </encoder>
    </appender>

    <root level="info">
        <appender-ref ref="STDOUT"/>
    </root>
</configuration>
复制代码
```

##### 打印日志的controller

```java
private static final Logger LOGGER =
LoggerFactory.getLogger(HelloController.class);
@Autowired
private TestLogService testLogService;

@GetMapping("/hello")
public String hello(){
    LOGGER.info("GLMAPPER-SERVICE:info");
    LOGGER.error("GLMAPPER-SERVICE:error");
    testLogService.printLogToSpecialPackage();
    return "hello spring boot";
}
复制代码
```

##### 验证结果：

```diff
01:50:39.633 INFO  com.glmapper.spring.boot.controller.HelloController
- GLMAPPER-SERVICE:info
01:50:39.633 ERROR com.glmapper.spring.boot.controller.HelloController
- GLMAPPER-SERVICE:error
复制代码
```

上面的就是通过控制台打印出来的，这个时候因为我们没有指定日志文件的输出，因为不会在工程目录下生产`logs`文件夹。

#### 控制台不打印，直接输出到日志文件

先来看下配置文件：

```xml
<configuration>
    <!-- 属性文件:在properties文件中找到对应的配置项 -->
    <springProperty scope="context" name="logging.path"  source="logging.path"/>
    <springProperty scope="context" name="logging.level" source="logging.level.com.glmapper.spring.boot"/>
    <!-- 默认的控制台日志输出，一般生产环境都是后台启动，这个没太大作用 -->
    <appender name="STDOUT"
        class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <Pattern>%d{HH:mm:ss.SSS} %-5level %logger{80} - %msg%n</Pattern>
        </encoder>
    </appender>

    <appender name="GLMAPPER-LOGGERONE"
    class="ch.qos.logback.core.rolling.RollingFileAppender">
        <append>true</append>
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>${logging.level}</level>
        </filter>
        <file>
            ${logging.path}/glmapper-spring-boot/glmapper-loggerone.log
        </file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <FileNamePattern>${logging.path}/glmapper-spring-boot/glmapper-loggerone.log.%d{yyyy-MM-dd}</FileNamePattern>
            <MaxHistory>30</MaxHistory>
        </rollingPolicy>
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <root level="info">
        <appender-ref ref="GLMAPPER-LOGGERONE"/>
    </root>
</configuration>
复制代码
```

这里我们`appender-ref`指定的`appender`是`GLMAPPER-LOGGERONE`，因为之前没有名字为`GLMAPPER-LOGGERONE`的`appender`，所以要增加一个`name`为`GLMAPPER-LOGGERONE`的`appender`。

注意上面这个配置，我们是直接接将`root`的`appender-ref`直接指定到我们的`GLMAPPER-LOGGERONE`这个appender的。所以控制台中将只会打印出bannar之后就啥也不打印了，所有的启动信息都会被打印在日志文件`glmapper-loggerone.log`中。

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164b8d8b5f22d274~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

但是实际上我们不希望我的业务日志中会包括这些启动信息。所以这个时候我们就需要通过`logger`标签来搞事情了。将上面的配置文件进行简单修改：

```ini
<logger name="com.glmapper.spring.boot.controller" level="${logging.level}"
        additivity="false">
    <appender-ref ref="GLMAPPER-LOGGERONE" />
</logger>

<root level="${logging.level}">
    <appender-ref ref="STDOUT"/>
</root>
复制代码
```

让`root`指向控制台输出；`logger`负责打印包`com.glmapper.spring.boot.controller`下的日志。

##### 验证结果

还是通过我们的测试controller来打印日志为例，但是这里不会在控制台出现日志信息了。期望的日志文件在`./logs/glmapper-spring-boot/glmapper-loggerone.log`。

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164b8df30b286089~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

### logger和appender的关系

上面两种是一个基本的配置方式，通过上面两个案例，我们先来了解下`logger/appender/root`之间的关系，然后再详细的说下`logger`和`appender`的配置细节。

在最前面介绍中提到，`root`是根`logger`,所以他两是一回事；只不过`root`中不能有`name`和`additivity`属性，是有一个`level`。

`appender`是一个日志打印的组件，这里组件里面定义了打印过滤的条件、打印输出方式、滚动策略、编码方式、打印格式等等。但是它仅仅是一个打印组件，如果我们不使用一个`logger`或者`root`的`appender-ref`指定某个具体的`appender`时，它就没有什么意义。

因此`appender`让我们的应用知道怎么打、打印到哪里、打印成什么样；而`logger`则是告诉应用哪些可以这么打。例如某个类下的日志可以使用这个`appender`打印或者某个包下的日志可以这么打印。

#### appender 配置详解

这里以上面案例中的名为`GLMAPPER-LOGGERONE`的`appender`说明：

```xml
<appender name="GLMAPPER-LOGGERONE"
    class="ch.qos.logback.core.rolling.RollingFileAppender">
    <append>true</append>
    <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>${logging.level}</level>
    </filter>
    <file>
        ${logging.path}/glmapper-spring-boot/glmapper-loggerone.log
    </file>
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <FileNamePattern>${logging.path}/glmapper-spring-boot/glmapper-loggerone.log.%d{yyyy-MM-dd}</FileNamePattern>
        <MaxHistory>30</MaxHistory>
    </rollingPolicy>
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        <charset>UTF-8</charset>
    </encoder>
</appender>
复制代码
```

`appender` 有两个属性 `name`和`class`;`name`指定`appender`名称，`class`指定`appender`的全限定名。上面声明的是名为`GLMAPPER-LOGGERONE`，`class`为`ch.qos.logback.core.rolling.RollingFileAppender`的一个`appender`。

#### appender 的种类

- ConsoleAppender：把日志添加到控制台
- FileAppender：把日志添加到文件
- RollingFileAppender：滚动记录文件，先将日志记录到指定文件，当符合某个条件时，将日志记录到其他文件。它是FileAppender的子类

#### append 子标签

```go
<append>true</append>
复制代码
```

如果是 `true`，日志被追加到文件结尾，如果是`false`，清空现存文件，默认是`true`。

### filter 子标签

[logback使用filter过滤日志_logback过滤日志_justry_deng的博客-CSDN博客](https://blog.csdn.net/justry_deng/article/details/108074525)

FilterReply有三种枚举值：

DENY：表示不用看后面的过滤器了，这里就给拒绝了，不作记录。
NEUTRAL：表示需不需要记录，还需要看后面的过滤器。若所有过滤器返回的全部都是NEUTRAL，那么需要记录日志。 有序列表里的下个过滤器过接着处理日志；（该级别既不处理，也不抛弃，相当于没有任何处理，日志会被保存下来并在本appender被执行）
ACCEPT：表示不用看后面的过滤器了，这里就给直接同意了，需要记录

在简介中提到了`filter`；作用就是上面说的。可以为`appender` 添加一个或多个过滤器，可以用任意条件对日志进行过滤。`appender` 有多个过滤器时，按照配置顺序执行。

#### ThresholdFilter

临界值过滤器，过滤掉低于指定临界值的日志。当日志级别等于或高于临界值时，过滤器返回`NEUTRAL`；当日志级别低于临界值时，日志会被拒绝。

```xml
<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
    <level>INFO</level>
</filter>
```

#### LevelFilter

级别过滤器，根据日志级别进行过滤。如果日志级别等于配置级别，过滤器会根据`onMath`(用于配置符合过滤条件的操作) 和 `onMismatch`(用于配置不符合过滤条件的操作)接收或拒绝日志。

```xml
<filter class="ch.qos.logback.classic.filter.LevelFilter">   
  <level>INFO</level>   
  <onMatch>ACCEPT</onMatch>   
  <onMismatch>DENY</onMismatch>   
</filter> 
复制代码
```

关于`NEUTRAL`、`ACCEPT`、`DENY` 见上文简介中关于`filter`的介绍。

#### file 子标签

`file` 标签用于指定被写入的文件名，可以是相对目录，也可以是绝对目录，如果上级目录不存在会自动创建，没有默认值。

```bash
<file>
    ${logging.path}/glmapper-spring-boot/glmapper-loggerone.log
</file>
复制代码
```

这个表示当前appender将会将日志写入到`${logging.path}/glmapper-spring-boot/glmapper-loggerone.log`这个目录下。

### rollingPolicy 子标签

这个子标签用来描述滚动策略的。这个只有`appender`的`class`是`RollingFileAppender`时才需要配置。这个也会涉及文件的移动和重命名（a.log->a.log.2018.07.22）。

#### TimeBasedRollingPolicy

最常用的滚动策略，它根据时间来制定滚动策略，既负责滚动也负责出发滚动。这个下面又包括了两个属性：

- FileNamePattern
- maxHistory

```xml
<rollingPolicy     class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
    <!--日志文件输出的文件名:按天回滚 daily -->
    <FileNamePattern>
        ${logging.path}/glmapper-spring-boot/glmapper-loggerone.log.%d{yyyy-MM-dd}
    </FileNamePattern>
    <!--日志文件保留天数-->
    <MaxHistory>30</MaxHistory>
</rollingPolicy>
复制代码
```

上面的这段配置表明**每天生成一个日志文件，保存30天的日志文件**

#### FixedWindowRollingPolicy

根据固定窗口算法重命名文件的滚动策略。

### encoder 子标签

对记录事件进行格式化。它干了两件事：

- 把日志信息转换成字节数组
- 把字节数组写入到输出流

```xml
<encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
    <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50}
    - %msg%n</pattern>
    <charset>UTF-8</charset>
</encoder>
复制代码
```

目前`encoder`只有`PatternLayoutEncoder`一种类型。

### 定义一个只打印error级别日志的appcener

```xml
 <!-- 错误日志 appender ： 按照每天生成日志文件 -->
<appender name="ERROR-APPENDER" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <append>true</append>
    <!-- 过滤器，只记录 error 级别的日志 -->
    <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>error</level>
    </filter>
    <!-- 日志名称 -->
    <file>${logging.path}/glmapper-spring-boot/glmapper-error.log</file>
    <!-- 每天生成一个日志文件，保存30天的日志文件 -->
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <!--日志文件输出的文件名:按天回滚 daily -->
        <FileNamePattern>${logging.path}/glmapper-spring-boot/glmapper-error.log.%d{yyyy-MM-dd}</FileNamePattern>
        <!--日志文件保留天数-->
        <MaxHistory>30</MaxHistory>
    </rollingPolicy>
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
        <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        <!-- 编码 -->
        <charset>UTF-8</charset>
    </encoder>
</appender>
复制代码
```

### 定义一个输出到控制台的appender

```xml
<!-- 默认的控制台日志输出，一般生产环境都是后台启动，这个没太大作用 -->
<appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <Pattern>%d{HH:mm:ss.SSS} %-5level %logger{80} - %msg%n</Pattern>
    </encoder>
</appender>
复制代码
```

## logger 配置详解

```ini
<logger name="com.glmapper.spring.boot.controller"
        level="${logging.level}" additivity="false">
    <appender-ref ref="GLMAPPER-LOGGERONE" />
</logger>
复制代码
```

上面的这个配置文件描述的是：`com.glmapper.spring.boot.controller`这个包下的`${logging.level}`级别的日志将会使用`GLMAPPER-LOGGERONE`来打印。`logger`有三个属性和一个子标签：

- name:用来指定受此`logger`约束的某一个包或者具体的某一个类。
- level:用来设置打印级别（`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `ALL` 和 `OFF`），还有一个值`INHERITED`或者同义词`NULL`，代表强制执行上级的级别。如果没有设置此属性，那么当前`logger`将会继承上级的级别。
- addtivity:用来描述是否向上级`logger`传递打印信息。默认是`true`。

`appender-ref`则是用来指定具体`appender`的。

### 不同日志隔离打印案例

在前面的例子中我们有三种appender,一个是指定包约束的，一个是控制error级别的，一个是控制台的。然后这小节我们就来实现下不同日志打印到不同的log文件中。

#### 根据包进行日志文件隔离

这个例子里我们将`com.glmapper.spring.boot.controller`中的日志输出到`glmapper-controller.log`；将`com.glmapper.spring.boot.service`中的日志输出到`glmapper-service.log`。

```xml
<!--打印日志到glmapper-service.log的appender-->
<appender name="GLMAPPER-SERVICE"
          class="ch.qos.logback.core.rolling.RollingFileAppender">
    <append>true</append>
    <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>${logging.level}</level>
    </filter>
    <file>
        ${logging.path}/glmapper-spring-boot/glmapper-service.log
    </file>
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <FileNamePattern>${logging.path}/glmapper-spring-boot/glmapper-service.log.%d{yyyy-MM-dd}</FileNamePattern>
        <MaxHistory>30</MaxHistory>
    </rollingPolicy>
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        <charset>UTF-8</charset>
    </encoder>
</appender>

<!--打印日志到glmapper-controller.log的appender-->
<appender name="GLMAPPER-CONTROLLER"
          class="ch.qos.logback.core.rolling.RollingFileAppender">
    <append>true</append>
    <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>${logging.level}</level>
    </filter>
    <file>
        ${logging.path}/glmapper-spring-boot/glmapper-controller.log
    </file>
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <FileNamePattern>${logging.path}/glmapper-spring-boot/glmapper-controller.log.%d{yyyy-MM-dd}</FileNamePattern>
        <MaxHistory>30</MaxHistory>
    </rollingPolicy>
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        <charset>UTF-8</charset>
    </encoder>
</appender>

<!--此logger约束将.controller包下的日志输出到GLMAPPER-CONTROLLER，错误日志输出到GERROR-APPENDE；GERROR-APPENDE见上面-->
<logger name="com.glmapper.spring.boot.controller" level="${logging.level}" additivity="false">
    <appender-ref ref="GLMAPPER-CONTROLLER" />
    <appender-ref ref="GERROR-APPENDER" />
</logger>

<!--此logger约束将.service包下的日志输出到GLMAPPER-SERVICE，错误日志输出到GERROR-APPENDE；GERROR-APPENDE见上面-->
<logger name="com.glmapper.spring.boot.service" level="${logging.level}" additivity="false">
    <appender-ref ref="GLMAPPER-SERVICE" />
    <appender-ref ref="GERROR-APPENDER" />
</logger>
复制代码
```

来看运行结果

1、glmaper-controller

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164bac0d699c0ca9~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

2、glmapper-service

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164bac127270addf~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

3、glmapper-error

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164bac1698f84f29~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

满足我们的预期，但是这里有个小问题。在`info`日志里出现了`error`,当然这是正常的。假如我们不想在`info`里面出现`error`怎么办呢？很简单，我们以`APPENDER-SERVICE`为例，将`filter`过滤器进行修改：

将下面的：

```xml
<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
    <level>${logging.level}</level>
</filter>
复制代码
```

修改为：

```xml
<filter class="ch.qos.logback.classic.filter.LevelFilter">
    <level>ERROR</level>
    <!-- 如果命中就禁止这条日志 -->
    <onMatch>DENY</onMatch>  
    <!-- 如果没有命中就使用这条规则 -->
    <onMismatch>ACCEPT</onMismatch>  
</filter>
复制代码
```

这里同时要注意的是，在`logger`中`level`需要设置为`info`级别。

#### 根据类进行日志文件隔离

这个其实也是和上面那个差不过，只不过粒度更细一点，一般情况下比如说我们有个定时任务类需要单独来记录其日志信息，这样我们就可以考虑使用基于类维度来约束打印。

```xml
<!--特殊功能单独appender 例如调度类的日志-->
<appender name="SCHEDULERTASKLOCK-APPENDER" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <append>true</append>
    <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>${logging.level}</level>
    </filter>
    <file>${logging.path}/glmapper-spring-boot/scheduler-task-lock.log</file>
    <!-- 每天生成一个日志文件，保存30天的日志文件 -->
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <!--日志文件输出的文件名:按天回滚 daily -->
        <FileNamePattern>${logging.path}/glmapper-spring-boot/scheduler-task-lock.log.%d{yyyy-MM-dd}</FileNamePattern>
        <!--日志文件保留天数-->
        <MaxHistory>30</MaxHistory>
    </rollingPolicy>
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
        <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        <!-- 编码 -->
        <charset>UTF-8</charset>
    </encoder>
</appender>

<!--这里指定到了具体的某一个类-->
<logger name="com.glmapper.spring.boot.task.TestLogTask" level="${logging.level}" additivity="true">
        <appender-ref ref="SCHEDULERTASKLOCK-APPENDER" />
        <appender-ref ref="ERROR-APPENDER" />
    </logger>
复制代码
```

最终`TestLogTask`中的日志将会被打印到这个自己独立的log文件中。如下所示：

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164bad7d9e4dd631~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

### 根据自定义 logger 的 name 进行日志文件隔离

`logger`的`name`除了类、包等约束之外，当然还可以这样来玩。。。

在进行案例之前，这里先把前面案例中`logger`声明的代码贴一下，以作对比,以`TestLogTask`类中的日志为例：

```arduino
 private static final Logger LOGGER =
 LoggerFactory.getLogger(TestLogTask.class);
复制代码
```

在`getLogger`中我们是将当前对象的`class`作为参数的，这个是为了打印时获取其全限定名的（见下面3-）。

```arduino
1-2018-07-21 11:15:42.003 [pool-1-thread-1] 
2-INFO  
3-com.glmapper.spring.boot.task.TestLogTask -
4-com.glmapper.spring.boot.task:info
复制代码
```

#### 业务类定义

我们同样是`service`包下定义一个类`TestLogNameServiceImpl`

```java
package com.glmapper.spring.boot.service;

@Service("testLogNameService")
public class TestLogNameServiceImpl implements TestLogNameService {

    private static final Logger LOGGER =
    LoggerFactory.getLogger("GLMAPPER-TEST-LOG");

    @Override
    public void print() {
        LOGGER.info("GLMAPPER-TEST-LOG:this is special logger-----info");
        LOGGER.error("GLMAPPER-TEST-LOG:this is special logger-------error");
    }
}
复制代码
```

#### appender和logger配置

```xml
<appender name="ROOT-APPENDER" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <append>true</append>
    <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
        <level>${logging.level}</level>
    </filter>
    <file>${logging.path}/glmapper-spring-boot/glmapper-test.log</file>
    <!-- 每天生成一个日志文件，保存30天的日志文件 -->
    <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <!--日志文件输出的文件名:按天回滚 daily -->
        <FileNamePattern>${logging.path}/glmapper-spring-boot/glmapper-test.log.%d{yyyy-MM-dd}
        </FileNamePattern>
        <!--日志文件保留天数-->
        <MaxHistory>30</MaxHistory>
    </rollingPolicy>
    <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
        <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
        <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        <!-- 编码 -->
        <charset>UTF-8</charset>
    </encoder>
</appender>

<!--这里的name和业务类中的getLogger中的字符串是一样的-->
<logger name="GLMAPPER-TEST-LOG" level="${logging.level}" additivity="true">
        <appender-ref ref="ROOT-APPENDER" />
        <appender-ref ref="ERROR-APPENDER" />
    </logger>
复制代码
```

我们这个预期的是`TestLogNameServiceImpl`中的日志不打印到`glmapper-service.log`中，而是打印到`glmapper-test.log`中。

1、glmapper-test.log

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164bae82de2d1d6c~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

2、glmapper-service.log

![](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/7/21/164bae86cb0f9c04~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.awebp)

满足我们的预期。

### 如何使用logback打印mybatis的sql语句

[(17条消息) mybatis用logback日志不显示sql的解决办法_阿奇XS的博客-CSDN博客](https://blog.csdn.net/xiaoyu411502/article/details/51064885)

这个还是比较坑的。为什么。看下这个：

```xml
<settings>
    <setting name="logImpl" value="slf4j" />
</settings>
复制代码
```

在`mybatis-configration.xml`中，我们通过这样一个配置项来关联到具体的日志组件。但是`logImpl`的实现中是没有`logback`的。那么怎么办呢？这里只能通过`slf4j`的方式桥接到`logback`。

然后在我们的logback-spring.xml中进行如下配置：

```xml
 <!-- 将sql语句输出到具体的日志文件中 -->
<logger name="com.alipay.sofa.cloudplatform.common.dao" level="${logging.sql.level}" additivity="false">
    <appender-ref ref="SQL-APPENDER"/>
</logger>
复制代码
```

这里有几个点需要注意的。首先是`${logging.sql.level}`这个必须是debug，这个是由mybatis本身实现决定的。而这里的`name`设定的`com.alipay.sofa.cloudplatform.common.dao`值就是我们dao接口的包路径。

网上看了一个比较典型的案例，这种方式只能输出到控制台，并不能将文件输出到日志文件；它是根据内部的一个实现机制偷了个懒。[mybatis用logback日志不显示sql的解决办法](https://link.juejin.cn?target=https%3A%2F%2Fblog.csdn.net%2Fxiaoyu411502%2Farticle%2Fdetails%2F51064885 "https://blog.csdn.net/xiaoyu411502/article/details/51064885")

### *logback*-access

*logback*-access*模块与Servlet容器（如Tomcat和Jetty）集成，以提供HTTP访问日志功能。我们可以*使用logback*-*access*模块来替换tomcat的访问日志

### 疑问

不是需要加上 addxxx 才不会用到 root吗

其实是会用到 root 的 appender 的

就是限制了 日志级别而已

```xml
<!--过滤掉spring和mybatis的一些无用的DEBUG信息-->
        <logger name="org.springframework" level="INFO"/>
        <logger name="org.mybatis" level="INFO"/>

        <!-- 第三方日志系统 -->
        <logger name="org.springframework.core" level="info" />
        <logger name="org.springframework.beans" level="info" />
        <logger name="org.springframework.context" level="info" />
        <logger name="org.springframework.web" level="info" />
        <logger name="org.jboss.netty" level="warn" />
        <logger name="org.apache.http" level="warn" />


        <!-- 配置日志的根节点 -->
        <root level="all">
            <appender-ref ref="Console"/>
            <appender-ref ref="RollingFileInfo"/>
            <appender-ref ref="RollingFileWarn"/>
            <appender-ref ref="RollingFileError"/>
        </root>
```

## log4j2

### Log4j2的Loggers配置详解

来自 [Log4j2的Loggers配置详解_log4j2 logger name_ThinkWon的博客-CSDN博客](https://blog.csdn.net/thinkwon/article/details/101628736)

Loggers节点，常见的有两种：Root和Logger。
Root节点用来指定项目的根日志，如果没有单独指定Logger，那么就会默认使用该Root日志输出

Root
每个配置都必须有一个根记录器Root。如果未配置，则将使用默认根LoggerConfig，其级别为ERROR且附加了Console appender。根记录器和其他记录器之间的主要区别是：1.根记录器没有name属性。2.根记录器不支持additivity属性，因为它没有父级。

level：日志输出级别，共有8个级别，按照从低到高为：All < Trace < Debug < Info < Warn < Error < Fatal < OFF
AppenderRef：Root的子节点，用来指定该日志输出到哪个Appender.
Logger
Logger节点用来单独指定日志的形式，比如要为指定包下的class指定不同的日志级别等。

使用Logger元素必须有一个name属性，root logger不用name元属性
每个Logger可以使用TRACE，DEBUG，INFO，WARN，ERROR，ALL或OFF之一配置级别。如果未指定级别，则默认为ERROR。可以为additivity属性分配值true或false。如果省略该属性，则将使用默认值true。

Logger还可以配置一个或多个AppenderRef属性。引用的每个appender将与指定的Logger关联。如果在Logger上配置了多个appender，则在处理日志记录事件时会调用每个appender。

name：用来指定该Logger所适用的类或者类所在的包全路径，继承自Root节点。一般是项目包名或者框架的包名，比如：com.jourwon，org.springframework

level：日志输出级别，共有8个级别，按照从低到高为：All < Trace < Debug < Info < Warn < Error < Fatal < OFF

AppenderRef：Logger的子节点，用来指定该日志输出到哪个Appender，如果没有指定，就会默认继承自Root。如果指定了，那么会在指定的这个Appender和Root的Appender中都会输出，此时我们可以设置Logger的additivity="false"只在自定义的Appender中进行输出。

### 配置demo

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!-- status : 指定log4j本身的打印日志的级别.ALL< Trace < DEBUG < INFO < WARN < ERROR
    < FATAL < OFF。 monitorInterval : 用于指定log4j自动重新配置的监测间隔时间，单位是s,最小是5s. -->
<Configuration status="WARN" monitorInterval="30">
    <Properties>
        <!-- 配置日志文件输出目录 ${sys:user.home} -->
        <Property name="LOG_HOME">/root/workspace/lucenedemo/logs</Property>
        <property name="ERROR_LOG_FILE_NAME">/root/workspace/lucenedemo/logs/error</property>
        <property name="WARN_LOG_FILE_NAME">/root/workspace/lucenedemo/logs/warn</property>

        <property name="PATTERN">%d{yyyy-MM-dd HH:mm:ss.SSS} [%t-%L] %-5level %logger{36} - %msg%n</property>
    </Properties>

    <Appenders>
        <!--这个输出控制台的配置 -->
        <Console name="Console" target="SYSTEM_OUT">
            <!-- 控制台只输出level及以上级别的信息(onMatch),其他的直接拒绝(onMismatch) -->
            <ThresholdFilter level="trace" onMatch="ACCEPT"
                             onMismatch="DENY" />
            <!-- 输出日志的格式 -->
            <!--
                %d{yyyy-MM-dd HH:mm:ss, SSS} : 日志生产时间
                %p : 日志输出格式
                %c : logger的名称
                %m : 日志内容，即 logger.info("message")
                %n : 换行符
                %C : Java类名
                %L : 日志输出所在行数
                %M : 日志输出所在方法名
                hostName : 本地机器名
                hostAddress : 本地ip地址 -->
            <PatternLayout
                    pattern="${PATTERN}" />
        </Console>

        <!--文件会打印出所有信息，这个log每次运行程序会自动清空，由append属性决定，这个也挺有用的，适合临时测试用 -->
        <!--append为TRUE表示消息增加到指定文件中，false表示消息覆盖指定的文件内容，默认值是true -->
        <File name="log" fileName="logs/test.log" append="false">
            <PatternLayout
                    pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </File>
        <!-- 这个会打印出所有的info及以下级别的信息，每次大小超过size，
        则这size大小的日志会自动存入按年份-月份建立的文件夹下面并进行压缩，作为存档 -->
        <RollingFile name="RollingFileInfo" fileName="${LOG_HOME}/info.log"
                     filePattern="${LOG_HOME}/$${date:yyyy-MM}/info-%d{yyyy-MM-dd}-%i.log">
            <!--控制台只输出level及以上级别的信息（onMatch），其他的直接拒绝（onMismatch） -->
            <ThresholdFilter level="info" onMatch="ACCEPT"
                             onMismatch="DENY" />
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n" />
            <Policies>
                <!-- 基于时间的滚动策略，interval属性用来指定多久滚动一次，默认是1 hour。 modulate=true用来调整时间：比如现在是早上3am，interval是4，那么第一次滚动是在4am，接着是8am，12am...而不是7am. -->
                <!-- 关键点在于 filePattern后的日期格式，以及TimeBasedTriggeringPolicy的interval，
                日期格式精确到哪一位，interval也精确到哪一个单位 -->
                <!-- log4j2的按天分日志文件 : info-%d{yyyy-MM-dd}-%i.log-->
                <TimeBasedTriggeringPolicy interval="1" modulate="true" />
                <!-- SizeBasedTriggeringPolicy:Policies子节点， 基于指定文件大小的滚动策略，size属性用来定义每个日志文件的大小. -->
                <!-- <SizeBasedTriggeringPolicy size="2 kB" />  -->
            </Policies>
        </RollingFile>

        <RollingFile name="RollingFileWarn" fileName="${WARN_LOG_FILE_NAME}/warn.log"
                     filePattern="${WARN_LOG_FILE_NAME}/$${date:yyyy-MM}/warn-%d{yyyy-MM-dd}-%i.log">
            <ThresholdFilter level="warn" onMatch="ACCEPT"
                             onMismatch="DENY" />
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n" />
            <Policies>
                <TimeBasedTriggeringPolicy />
                <SizeBasedTriggeringPolicy size="2 kB" />
            </Policies>
            <!-- DefaultRolloverStrategy属性如不设置，则默认为最多同一文件夹下7个文件，这里设置了20
             多了就覆盖旧的文件 保证文件夹里面只有 20个
             -->
            <DefaultRolloverStrategy max="20" />
        </RollingFile>

        <RollingFile name="RollingFileError" fileName="${ERROR_LOG_FILE_NAME}/error.log"
                     filePattern="${ERROR_LOG_FILE_NAME}/$${date:yyyy-MM}/error-%d{yyyy-MM-dd-HH-mm}-%i.log">
            <ThresholdFilter level="error" onMatch="ACCEPT"
                             onMismatch="DENY" />
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n" />
            <Policies>
                <!-- log4j2的按分钟 分日志文件 : warn-%d{yyyy-MM-dd-HH-mm}-%i.log-->
                <TimeBasedTriggeringPolicy interval="1" modulate="true" />
                <!-- <SizeBasedTriggeringPolicy size="10 MB" /> -->
            </Policies>
        </RollingFile>

    </Appenders>

    <!--然后定义logger，只有定义了logger并引入的appender，appender才会生效-->
    <Loggers>
        <!--过滤掉spring和mybatis的一些无用的DEBUG信息-->
        <logger name="org.springframework" level="INFO"/>
        <logger name="org.mybatis" level="INFO"/>

        <!-- 第三方日志系统 -->
        <logger name="org.springframework.core" level="info" />
        <logger name="org.springframework.beans" level="info" />
        <logger name="org.springframework.context" level="info" />
        <logger name="org.springframework.web" level="info" />
        <logger name="org.jboss.netty" level="warn" />
        <logger name="org.apache.http" level="warn" />


        <!-- 配置日志的根节点 -->
        <root level="all">
            <appender-ref ref="Console"/>
            <appender-ref ref="RollingFileInfo"/>
            <appender-ref ref="RollingFileWarn"/>
            <appender-ref ref="RollingFileError"/>
        </root>

    </Loggers>

</Configuration>
```

#### logger level 作用

[log4j2.xml 的标签 loggers 中 root 的属性 level 指的是什么_root level_暗诺星刻的博客-CSDN博客](https://blog.csdn.net/wangpaiblog/article/details/122315204)

log4j2.xml 的标签 loggers 中 root 的属性 level 指的是什么
  log4j2.xml 是 log4j2 中的其中一种配置文件。log4j2.xml 中往往有如下配置：

<configuration ...>
    <appenders/...>

    <loggers>
        <root level="DEBUG">
            <appender-ref ref="Console"/>
            <appender-ref ref="DEBUG"/>
            <appender-ref ref="INFO"/>
            <appender-ref ref="WARN"/>
            <appender-ref ref="ERROR"/>
        </root>
    </loggers>

</configuration>
1
2
3
4
5
6
7
8
9
10
11
12
13
  那么，上面的标签 root 中的属性 level 指的是什么呢？有人说，这是在设定根日志的日志级别。这种回答可以说是“听君一席话，如听一席话”。实际上，这个配置是用于设定最低需要输出的日志输出级别。也就是说，如果将标签 root 中的属性 level 设为 DEBUG，那么，低于 DEBUG 这一级别的日志将不会输出，无论有没有在 <RollingFile/...>、 <appender-ref/...> 中定义低于这种级别的日志都是如此。

  因此，如果突然想去掉一些低级别的日志，可以直接将标签 root 的属性 level 中的日志级别调高，而不需要改动其它的代码。
官方说 RollingRandomAccessFile 比 正常的 RollingFile Appender 快

使用的是 异步记录日志

## springboot

springboot 用的日志框架默认是 logback 

如果我们要用 log4j2 需要先把 原先的 starter-logging 移除

引入log4j2 starter

log4j starter 只在 springboot 1.xx 才有

## 优化

```java
if (log.isInfoEnabled()) {
    log.info("This is a Demo, Request:{}", JSONUtil.toJsonStr(new LogTest()));
}
```

### log4j2 动态修改日志级别

1. 使用接口更改日志级别

[动态设置 log4j2 日志的级别不能落-技术圈 (proginn.com)](https://jishuin.proginn.com/p/763bfbd59869)

2. 使用 zookeeper 的监听器更改日志级别

[(25条消息) 使用Zookeeper动态更改日志级别_zookeeper.out日志级别_Tuzki的学习笔记的博客-CSDN博客](https://blog.csdn.net/qq_34018603/article/details/100150510)

[动态日志级别：小功能，大用处 - 掘金 (juejin.cn)](https://juejin.cn/post/6994966780745613342)