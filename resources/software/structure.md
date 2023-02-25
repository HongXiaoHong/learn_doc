# structure

## maven 转 gradle 实录

### 环境

系统: windows11

软件:idea

本地已装 maven gradle

### 打开 terminal

确保路径 在 maven 项目根目录

执行 

> gradle init --type pom

```bash
D:\learn\experiment\Java\chats>gradle init --type pom
Starting a Gradle Daemon (subsequent builds will be faster)

> Task :init
Maven to Gradle conversion is an incubating feature.
Get more help with your project: https://docs.gradle.org/6.0.1/userguide/migrating_from_maven.html

BUILD SUCCESSFUL in 19s
2 actionable tasks: 2 executed
```

### 打开项目路径

删除 .idea .mvn pom.xml

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/explorer_gsd0YP5OAo.png)

Spring Boot plugin requires Gradle 6.8.x, 6.9.x, or 7.x. The current version is Gradle 6.0.1

这里碰到的这个错误 是因为本地版本过低 无法使用springboot 插件

如果要使用可以升级下gradle

重启下idea 之后 build下

idea 不能识别 就右键 build.gradle 

使用 import from gradle xxx

打开 application 类 启动