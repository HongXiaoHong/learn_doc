### 官方文档

maven settings 说明文档:

[Maven – Settings Reference --- Maven – 设置参考 (apache.org)](https://maven.apache.org/settings.html#introduction)

mvnrepository:

[Maven Repository: Search/Browse/Explore --- Maven 存储库：搜索/浏览/探索 (mvnrepository.com)](https://mvnrepository.com/)



[Maven 依赖范围_maven class 依赖_seasonsbin的博客-CSDN博客](https://blog.csdn.net/seasonsbin/article/details/79093647?spm=1001.2101.3001.6650.12&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-12-79093647-blog-57428763.pc_relevant_multi_platform_whitelistv3&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-12-79093647-blog-57428763.pc_relevant_multi_platform_whitelistv3&utm_relevant_index=13)

[高效使用Java构建工具｜Maven篇](https://mp.weixin.qq.com/s/Wvq7t2FC58jaCh4UFJ6GGQ)

### 学习视频

[157-POM深入-profile 详解-概述_ev_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV12q4y147e4?p=157&vd_source=eabc2c22ae7849c2c4f31815da49f209)

相关的笔记:

[Maven 3.1 (wolai.com)](https://www.wolai.com/arAiYJYCr6Kkfi2kZ8HxE8)

### 与 java 版本

[Maven – Maven Releases History --- Maven – Maven 发布历史 (apache.org)](https://maven.apache.org/docs/history.html)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230831000545.png)

版本 不匹配 可能会碰到问题:

[聊聊maven与jdk版本对应关系_java_脚本之家 (jb51.net)](https://www.jb51.net/article/233325.htm)

## 专有名词

### 交叉编译

从 Java 9 开始支持交叉编译

我们可以启用交叉编译，允许应用程序在较旧的 Java 版本上运行，方法是使用 maven.compiler.release 属性

```xml
<properties>
    <maven.compiler.release>8</maven.compiler.release>
</properties>
```

[Setting Java Version used by Maven Compiler --- 设置 Maven 编译器使用的 Java 版本 (howtodoinjava.com)](https://howtodoinjava.com/maven/set-java-version-in-maven/)

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

>  问题: maven setting中定义properties 和 pomxml定义了 properties 定义, 哪个生效

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

### 配置编译的 jdk 版本

甚至你可以在 pom.xml 中引入 编译插件的时候

其实 maven 已经帮我们在最后生成的 pom.xml 文件中引入了 编译插件

我们可以 使用 命令行覆盖文件中的 编译插件属性:

```bash
mvn -Dmaven.compiler.target=1.7 compile
```

#### source/target

[关于 maven-compiler-plugin 插件的使用心得_cab5的博客-CSDN博客](https://blog.csdn.net/yangchao1125/article/details/100585116)

springboot 可以使用 java.version 

[Apache Maven Compiler Plugin – Setting the -source and -target of the Java Compiler --- Apache Maven 编译器插件 – 设置 Java 编译器的 -source 和 -target](https://maven.apache.org/plugins/maven-compiler-plugin/examples/set-compiler-source-and-target.html)

也就是上面配置的例子

其实配置这个 source target 也是跟 javac 挂钩的

可以参考这个 java 11 的官方文档

[javac --- 爪哇 (oracle.com)](https://docs.oracle.com/en/java/javase/11/tools/javac.html#GUID-AEEC9F07-CB49-4E96-8BC7-BCC2C7F725C9)

里面说到 当前版本为 11 source 最大配到 11, 默认是 11

官方文档里面有这么一句话 

> 注意：仅设置该 `target` 选项并不能保证您的代码实际在具有指定版本的 JRE 上运行。陷阱是意外使用仅存在于更高版本的 JRE 中的 API，这将使您的代码在运行时失败并出现链接错误。为了避免此问题，您可以配置编译器的引导类路径以匹配目标 JRE，或者使用 Animal Sniffer Maven 插件来验证您的代码是否未使用意外的 API，或者更好地使用 JDK 9 以来支持 `release` 的选项。同样，设置该 `source` 选项并不能保证您的代码实际在具有指定版本的 JDK 上编译。要使用与用于启动 Maven 的版本不同的特定 JDK 版本编译代码，请参阅使用不同的 JDK 编译示例。

因为上面这个问题

网友也遇到了 配置的一个坑

[maven maven.compiler.source和maven.compiler.target的坑_51CTO博客_maven-compiler-plugin](https://blog.51cto.com/zhjh256/3142351)

也就是 IDE 配置了对应的 project jdk

idea 貌似是配置 java compiler 就会使用 我们配置的, 而不是 pom.xml 文件中配置的

idea 配置 参 [Javac选项source和target的作用_java target_明月几时有666的博客-CSDN博客](https://blog.csdn.net/gao_zhennan/article/details/124232142)

我理解下

咱们配置在 编译器的 source/target 不一定生效

- pom.xml 中的 properties source/target 不一定生效

有可能是因为 settings.xml 中同样配置了 properties 也有 source/target 根据上面 没有使用 exexecutable 的 配置, 用户 settings.xml > 全局 settings.xml > pom.xml profile > pom.xml 默认 properties 中配置的source

- 跟 当前编译 的 jdk 也就是 JAVA_HOME 配置下的 jdk 版本有关

根据 官网中 [javac --- 爪哇 (oracle.com)](https://docs.oracle.com/en/java/javase/11/tools/javac.html#GUID-AEEC9F07-CB49-4E96-8BC7-BCC2C7F725C9)

> `-source release`
> 
> Specifies the version of source code accepted. The following values for `release` are allowed:  
> 指定接受的源代码版本。允许使用以下值 `release` ：
> 
> Note:
> 
> Beginning with JDK 9, `javac` no longer supports `-source` release settings less than or equal to `5`. If settings less than or equal to `5` are used, then the `javac` command behaves as if `-source 6` were specified.
> 
> 注： 从 JDK 9 开始， `javac` 不再支持 `-source` 小于或等于 `5` 的版本设置。如果使用小于或等于的 `5` 设置，则该 `javac` 命令的行为就像指定了一样 `-source 6` 。
> 
> `1.6`
> 
> No language changes were introduced in Java SE 6. However, encoding errors in source files are now reported as errors instead of warnings as was done in earlier releases of Java Platform, Standard Edition.  
> Java SE 6 中没有引入任何语言更改。但是，源文件中的编码错误现在报告为错误，而不是像早期版本的 Java 平台标准版那样报告为警告。
> 
> `6`
> 
> Synonym for 1.6. 1.6 的同义词。
> 
> `1.7`
> 
> The compiler accepts code with features introduced in Java SE 7.  
> 编译器接受具有 Java SE 7 中引入的功能的代码。
> 
> `7`
> 
> Synonym for 1.7. 1.7 的同义词。
> 
> `1.8`
> 
> The compiler accepts code with features introduced in Java SE 8.  
> 编译器接受具有 Java SE 8 中引入的功能的代码。
> 
> `8`
> 
> Synonym for 1.8. 1.8 的同义词。
> 
> `9`
> 
> The compiler accepts code with features introduced in Java SE 9.  
> 编译器接受具有 Java SE 9 中引入的功能的代码。
> 
> `10`
> 
> The compiler accepts code with features introduced in Java SE 10.  
> 编译器接受具有 Java SE 10 中引入的功能的代码。
> 
> `11`
> 
> The default value. The compiler accepts code with features introduced in Java SE 11.  
> 默认值。编译器接受具有 Java SE 11 中引入的功能的代码。

这里是 jdk11 的文档

默认使用 source 11 不过分吧

如果咱们把 source 设置比当前 jdk 版本还要高, 那肯定是不允许的呀

所以只能设置比当前 jdk 版本低的

还有就是 设置了 exexecutable 的情况下, 因为会用 指定的 java 编译器 也就是对应路径下的 javac 进行编译, 会用对应的 默认的 source 进行编译, 所以说最后咱们还是使用 相同版本的 jdk 进行开发

还有就是使用 toolchains 进行开发,可以让有 maven 相关的组件, 使用指定版本的 jdk

#### release

编译器插件版本 3.6 开始

[Apache Maven Compiler Plugin – Setting the --release of the Java Compiler --- Apache Maven 编译器插件 – 设置 Java 编译器的 --release](https://maven.apache.org/plugins/maven-compiler-plugin/examples/set-compiler-release.html)

配置 properties

```xml
<project>
  [...]
  <properties>
    <maven.compiler.release>8</maven.compiler.release>
  </properties>
  [...]
</project>
```

或者配置 plugin

```xml
<project>
  [...]
  <build>
    [...]
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.11.0</version>
        <configuration>
          <release>8</release>
        </configuration>
      </plugin>
    </plugins>
    [...]
  </build>
  [...]
</project>
```

#### exexecutable | 本地 jdk 给某个插件配置

> 这里使用的 jdk 版本就是 当前配置的 exexecutable 的版本

<mark>因为 javac 默认使用的 source 就是当前发行版的 版本</mark>

[Apache Maven Compiler Plugin – Compiling Sources Using A Different JDK --- Apache Maven编译器插件 - 使用不同的JDK编译源代码](https://maven.apache.org/plugins/maven-compiler-plugin/examples/compile-using-different-jdk.html)

pom.xml 中配置 exexecutable compilerVersion fork

```xml
<project>
  [...]
  <build>
    [...]
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.11.0</version>
        <configuration>
          <verbose>true</verbose>
          <fork>true</fork>
          <executable><!-- path-to-javac --></executable>
          <compilerVersion>1.3</compilerVersion>
        </configuration>
      </plugin>
    </plugins>
    [...]
  </build>
  [...]
</project>
```

为了增加 可移植性

使用

```xml
<executable>${JAVA_1_4_HOME}/bin/javac</executable>
```

settings.xml 文件中配置 本地 各个版本的 jdk 位置

另外也要激活 对应的 profile 分支

```xml
<settings>
  [...]
  <profiles>
    [...]
    <profile>
      <id>compiler</id>
        <properties>
          <JAVA_1_4_HOME>C:\Program Files\Java\j2sdk1.4.2_09</JAVA_1_4_HOME>
        </properties>
    </profile>
  </profiles>
  [...]
  <activeProfiles>
    <activeProfile>compiler</activeProfile>
  </activeProfiles>
</settings>

```

#### Toolchains | 配置 java 工具使用的路径 所有插件适用

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230831102604.png)

##### POM 配置 maven-toolchains-plugin

```xml
<plugins>
 ...
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.1</version>
  </plugin>
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-toolchains-plugin</artifactId>
    <version>1.1</version>
    <executions>
      <execution>
        <goals>
          <goal>toolchain</goal>
        </goals>
      </execution>
    </executions>
    <configuration>
      <toolchains>
        <jdk>
          <version>1.5</version>
          <vendor>sun</vendor>
        </jdk>
      </toolchains>
    </configuration>
  </plugin>
  ...
</plugins>
```

##### 配置 toolchains.xml

toolchains.xml （见下文）是设置工具链安装路径的配置文件。此文件应放在您的 ${user.home}/.m2 目录中。执行 maven-toolchains-plugin 时，它会查找文件，读取 toolchains.xml 文件并查找与插件中配置的工具链要求匹配的工具链。在我们的例子中，这将是一个带有“1.5”和 <vendor> “sun”的 <version> JDK工具链。找到匹配项后，插件将存储要在MavenSession中使用的工具链。正如你在 toolchains.xml 下面看到的，确实有一个配置了“1.5”和 <vendor> “sun”的 <version> JDK工具链。因此，当我们在 pom.xml 上面的执行中配置时 maven-compiler-plugin ，它将看到在MavenSession中设置了一个JDK工具链，从而将使用该工具链（在我们的示例中安装 /path/to/jdk/1.5 JDK）来编译源代码。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<toolchains>
  <!-- JDK toolchains -->
  <toolchain>
    <type>jdk</type>
    <provides>
      <version>1.5</version>
      <vendor>sun</vendor>
    </provides>
    <configuration>
      <jdkHome>/path/to/jdk/1.5</jdkHome>
    </configuration>
  </toolchain>
  <toolchain>
    <type>jdk</type>
    <provides>
      <version>1.6</version>
      <vendor>sun</vendor>
    </provides>
    <configuration>
      <jdkHome>/path/to/jdk/1.6</jdkHome>
    </configuration>
  </toolchain>

  <!-- other toolchains -->
  <toolchain>
    <type>netbeans</type>
    <provides>
      <version>5.5</version>
    </provides>
    <configuration>
      <installDir>/path/to/netbeans/5.5</installDir>
    </configuration>
  </toolchain>
</toolchains>
```

## 插件

常用插件:

maven-compiler-plugin：编绎阶段指定jdk版本。

maven-surefire-plugin：用于测试阶段的插件

maven-failsafe-plugin：用作集成测试的配置。

maven-checkstyle-plugin：可以帮助开发检测代码中不合规范的地方。

build-helper-maven-plugin：支持多个source/test/resource。

spring-boot-maven-plugin：可以帮助项目打包成一个fat jar。

jacoco-maven-plugin：生成单元测试覆盖率报告。

sonar-maven-plugin：使用该插件执行sonar扫描。

[【Java】Maven常用的插件汇总（共8个） - 掘金 (juejin.cn)](https://juejin.cn/post/7142115195047903246)

### maven compiler plugin | 编译插件

[Apache Maven Compiler Plugin – compiler:compile --- Apache Maven 编译器插件 – 编译器：编译](https://maven.apache.org/plugins/maven-compiler-plugin/compile-mojo.html)

推荐阅读:

[java - 在 Maven 中指定 Java 版本 - 属性和编译器插件之间的差异 - SegmentFault 思否](https://segmentfault.com/q/1010000042493731)

[Maven 编译与JDK版本 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/34492714)

[聊聊maven与jdk版本对应关系_java_脚本之家 (jb51.net)](https://www.jb51.net/article/233325.htm)

[Maven中配置maven-compiler-plugin 插件和jdk 17版本 - 楼兰胡杨 - 博客园 (cnblogs.com)](https://www.cnblogs.com/east7/p/13363069.html)

#### spring boot maven plugin | 打包运行 springboot 应用

[Spring Boot Maven Plugin Documentation --- Spring Boot Maven 插件文档](https://docs.spring.io/spring-boot/docs/current/maven-plugin/reference/htmlsingle/#introduction)

Spring Boot Maven 插件在 Apache Maven 中提供 Spring Boot 支持。它允许您打包可执行的jar或war存档，运行Spring Boot应用程序，生成构建信息并在运行集成测试之前启动Spring Boot应用程序。 