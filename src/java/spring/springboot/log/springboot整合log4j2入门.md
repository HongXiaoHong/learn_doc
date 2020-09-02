### 1.pom文件 排除默认配置 加入log4j2启动器
```xml
<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <exclusions><!-- 去掉默认配置 -->
                <exclusion>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-logging</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <dependency> <!-- 引入log4j2依赖 -->
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-log4j2</artifactId>
        </dependency>
```
### 2.配置 log4j2-spring.xml

存放位置：
![log4j2-spring.xml](./photo/log4j2-spring配置文件存放位置.jpg)

记得修改存放的位置 

``` xml
<Property name="LOG_FILE_PATH">D:/temp/test/log</Property>
```

以及 

自己包路径
例如这里的
``` xml
<Logger name="person.hong.learn.api" level="INFO"/>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!--日志级别以及优先级排序: OFF > FATAL > ERROR > WARN > INFO > DEBUG > TRACE > ALL -->
<!--Configuration后面的status，这个用于设置log4j2自身内部的信息输出，可以不设置，当设置成trace时，你会看到log4j2内部各种详细输出-->
<!--monitorInterval：Log4j能够自动检测修改配置 文件和重新配置本身，设置间隔秒数-->
<Configuration status="WARN" monitorInterval="30">
    <!--全局属性-->
    <Properties>
        <Property name="LOG_FILE_PATH">D:/temp/test/log</Property>
        <!--   linux日志存放路径      <Property name="LOG_FILE_PATH">/usr/logs</Property> -->
        <Property name="PATTERN_FORMAT">%d{yyyy-MM-dd HH:mm:ss.SSS} %-5level %class{36} %L %M - %msg%xEx%n</Property>
    </Properties>

    <Appenders>
        <!--输出到控制台-->
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="${PATTERN_FORMAT}"/>
        </Console>


        <!--输出到文件 用来定义超过指定大小自动删除旧的创建新的的Appender.-->
        <RollingFile name="RollingInfoFile" fileName="${LOG_FILE_PATH}/info.log"
                     filePattern="${LOG_FILE_PATH}/$${date:yyyyMM}/info-%d{yyyyMMdd}-%i.log.gz">
            <!--控制台只输出level及以上级别的信息（onMatch），其他的直接拒绝（onMismatch）-->
            <Filters>
                <ThresholdFilter level="warn" onMatch="DENY" onMismatch="NEUTRAL"/>
                <ThresholdFilter level="info" onMatch="ACCEPT" onMismatch="DENY"/>
            </Filters>

            <PatternLayout>
                <pattern>${PATTERN_FORMAT}</pattern>
            </PatternLayout>

            <Policies>
                <!-- rollover on startup, daily and when the file reaches 10 MegaBytes -->
                <OnStartupTriggeringPolicy/>
                <SizeBasedTriggeringPolicy size="100 MB"/>
                <TimeBasedTriggeringPolicy/>
            </Policies>
        </RollingFile>

        <!--输出警告日志到文件-->
        <RollingFile name="RollingWarnFile" fileName="${LOG_FILE_PATH}/warn.log"
                     filePattern="${LOG_FILE_PATH}/$${date:yyyyMM}/warn-%d{yyyyMMdd}-%i.log.gz">
            <!--控制台只输出level及以上级别的信息（onMatch），其他的直接拒绝（onMismatch）-->
            <Filters>
                <ThresholdFilter level="error" onMatch="DENY" onMismatch="NEUTRAL"/>
                <ThresholdFilter level="warn" onMatch="ACCEPT" onMismatch="DENY"/>
            </Filters>

            <PatternLayout>
                <pattern>${PATTERN_FORMAT}</pattern>
            </PatternLayout>

            <Policies>
                <!-- rollover on startup, daily and when the file reaches 10 MegaBytes -->
                <OnStartupTriggeringPolicy/>
                <SizeBasedTriggeringPolicy size="100 MB"/>
                <TimeBasedTriggeringPolicy/>
            </Policies>
        </RollingFile>

        <!--输出错误日志到文件-->
        <RollingFile name="RollingErrorFile" fileName="${LOG_FILE_PATH}/error.log"
                     filePattern="${LOG_FILE_PATH}/$${date:yyyyMM}/error-%d{yyyyMMdd}-%i.log.gz">
            <!--控制台只输出level及以上级别的信息（onMatch），其他的直接拒绝（onMismatch）-->
            <ThresholdFilter level="error" onMatch="ACCEPT" onMismatch="DENY"/>

            <PatternLayout>
                <pattern>${PATTERN_FORMAT}</pattern>
            </PatternLayout>

            <Policies>
                <!-- rollover on startup, daily and when the file reaches 10 MegaBytes -->
                <OnStartupTriggeringPolicy/>
                <SizeBasedTriggeringPolicy size="100 MB"/>
                <TimeBasedTriggeringPolicy/>
            </Policies>
        </RollingFile>
    </Appenders>

    <Loggers>

        <!--过滤掉spring和mybatis的一些无用的DEBUG信息-->
        <Logger name="org.springframework" level="INFO"/>
        <Logger name="org.mybatis" level="INFO"/>

        <!-- LOG "com.luis*" at TRACE level -->
        <Logger name="person.hong.learn.api" level="INFO"/>

        <!-- LOG everything at INFO level -->
        <Root level="ALL">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="RollingInfoFile"/>
            <AppenderRef ref="RollingWarnFile"/>
            <AppenderRef ref="RollingErrorFile"/>
        </Root>
    </Loggers>

</Configuration>
```

### 3. 在代码里的使用
示例代码：

```java
private static final Logger logger = LogManager.getLogger(ImageController.class);
```

### 4. 参考链接🔗

- [springBoot完美配置log4j2](https://blog.csdn.net/V_Come_On/article/details/79408773?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.channel_param)
- [Spring Boot 使用 Log4j2（代码示例来源）](https://www.cnblogs.com/xishuai/p/spring-boot-log4j2.html)
- [Spring Boot系列教程六：日志输出配置log4j2(多套环境示例)](https://blog.csdn.net/woniu211111/article/details/54347846?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)
- [Spring Boot + Log4j2 日志框架配置 (Maven)](https://blog.51cto.com/11931236/2058708)
- [聊一聊log4j2配置文件log4j2.xml（配置详情）](https://www.cnblogs.com/hafiz/p/6170702.html)
- [spring-boot日志log4j2配置](https://my.oschina.net/tongjh/blog/1602240)