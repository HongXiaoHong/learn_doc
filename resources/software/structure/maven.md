https://blog.csdn.net/seasonsbin/article/details/79093647?spm=1001.2101.3001.6650.12&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-12-79093647-blog-57428763.pc_relevant_multi_platform_whitelistv3&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-12-79093647-blog-57428763.pc_relevant_multi_platform_whitelistv3&utm_relevant_index=13

[高效使用Java构建工具｜Maven篇](https://mp.weixin.qq.com/s/Wvq7t2FC58jaCh4UFJ6GGQ)

## 常见问题

#### maven 中的 packageing pom 是作何用

POM是最简单的打包类型。不像一个JAR，SAR，或者EAR，它生成的构件只是它本身
没有代码需要测试或者编译，也没有资源需要处理。打包类型为POM的项目的默认目标生命周期阶段

目标 package

site:attach-descriptor install

install:install deploy

deploy:deploy

pom项目里没有java代码，也不执行任何代码，只是为了聚合工程或传递依赖用的。

### IDEA使用maven自定义archetype生成项目骨架

https://blog.csdn.net/qq_37345604/article/details/100581940

### 常见指令

#### help

##### effective-pom | 输出最后生成的 pom.xml

>  mvn -Pdev help:effective-pom

#### profile | 分支相关

> mvn clean install -Pdev

## 配置文件

### properties | maven 内置属性以及自定义属性

pom.xml 中

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.companyname.bank</groupId>
  <artifactId>consumerBanking</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>consumerBanking</name>
  <url>http://maven.apache.org</url>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <java.version>1.8</java.version>
  </properties>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
   <profiles>
    <profile>
      <id>dev</id>
      <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <java.version>1.8</java.version>
      </properties>
    </profile>
  </profiles>
</project>

```

"D:\app\code\maven\maven3\conf\settings.xml"

也就是 我 maven conf 下面的 settings.xml 全局配置

```xml
<profiles>

    <profile> 
      <id>jdk-17</id>  
      <activation>
        <activeByDefault>true</activeByDefault>
        <jdk>17</jdk>  
      </activation>  

      <properties>  
        <maven.compiler.source>17</maven.compiler.source>  
        <maven.compiler.target>17</maven.compiler.target>  
        <maven.compiler.compilerVersion>17</maven.compiler.compilerVersion>  
      </properties>   
    </profile>
  </profiles>
```

"C:\Users\hong\.m2\settings.xml"

在我的用户路径下配置了一个 settings.xml 用户级配置

<mark>用户级配置是最高级别的</mark>

```xml
<profiles>
<profile> 
      <id>jdk-17</id>  
      <activation>
        <activeByDefault>true</activeByDefault>
        <jdk>17</jdk>  
      </activation>  

      <properties>  
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <java.version>1.8</java.version>
      </properties>   
    </profile>
  </profiles>
```

我们用 

> mvn -Pdev help:effective-pom

生成最后的 pom.xml 文件

#### properties 优先级

经过试验后

##### .m2/settings.xml maven_home/conf/settings.xml pom.xml 都有的情况下

按照 .m2/settings.xml 中激活的 profile 中的 properties 结合 pom.xml 中的 properties

```xml
<properties>
    <java.version>1.8</java.version>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```

##### .m2/settings.xml 无配置, maven_home/conf/settings.xml pom.xml 都有的情况下

```xml
<properties>
    <java.version>1.8</java.version>
    <maven.compiler.compilerVersion>17</maven.compiler.compilerVersion>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```

使用就是  maven_home/conf/settings.xml 中的配置 加上 pom.xml 

##### 注释

```xml
<profiles>
    <profile> 
      <id>jdk-17</id>  
      <activation>
        <activeByDefault>true</activeByDefault>
        <jdk>17</jdk>  
      </activation>  

      <properties>  
        <!-- <maven.compiler.source>17</maven.compiler.source>  
        <maven.compiler.target>17</maven.compiler.target>  
        <maven.compiler.compilerVersion>17</maven.compiler.compilerVersion>   -->
      </properties>   
    </profile>
  </profiles>

```

使用的便是 pom.xml 中 Dev profile 中的 properties

```xml
 <properties>
    <java.version>1.8</java.version>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```

##### pom.xml 文件中 默认的 properties 与 profile 中的 properties

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.companyname.bank</groupId>
  <artifactId>consumerBanking</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>consumerBanking</name>
  <url>http://maven.apache.org</url>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <java.version>1.8</java.version>
  </properties>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
   <profiles>
    <profile>
      <id>dev</id>
      <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <java.version>17</java.version>
      </properties>
    </profile>
  </profiles>
</project>

```

最后使用的还是 dev profile 中的属性

```xml
<properties>
    <java.version>17</java.version>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```

properties优先级高低如下: 

.m2/settings.xml > maven_home/conf/settings.xml > pom.xml profile 中的 properties > pom.xml 文件中 默认的 properties