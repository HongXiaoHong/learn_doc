# vscode

## 



### 使用 vscode 开发java

#### 设置快捷键为 idea 常用快捷键

[(242条消息) vs code快捷键修改为idea快捷键_讓丄帝愛伱的博客-CSDN博客](https://blog.csdn.net/ximaiyao1984/article/details/108950191)

vscode 也能运行 springboot 项目
https://blog.csdn.net/qq_17231297/article/details/115191852

maven 分析插件

Fabric8-analytics-vscode-extension | 依赖关系分析
https://github.com/fabric8-analytics/fabric8-analytics-vscode-extension/blob/master/README.md



#### 第一个 java 应用

安装 vscode 自不必说



##### 安装 java

###### 设置环境变量

PATH JAVA_PATH

- 变量名：**JAVA_HOME**

- 变量值：**C:\Program Files (x86)\Java\jdk1.8.0_91**        // 要根据自己的实际路径配置

- 变量名：**CLASSPATH**

- 变量值：**.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;**         //记得前面有个"."

- 变量名：**Path**

- 变量值：**%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;**

---

如果使用 1.5 以上版本的 JDK，不用设置 CLASSPATH 环境变量，也可以正常编译和运行 Java 程序

---

直到满足

```bash
C:\Users\hong>java --version
java 17.0.6 2023-01-17 LTS
Java(TM) SE Runtime Environment (build 17.0.6+9-LTS-190)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.6+9-LTS-190, mixed mode, sharing)
```

##### 安装 maven

###### 设置到环境变量

右键 "计算机"，选择 "属性"，之后点击 "高级系统设置"，点击"环境变量"，来设置环境变量，有以下系统变量需要配置：

新建系统变量 **MAVEN_HOME**，变量值：E:\Maven\apache-maven-3.3.9

编辑系统变量 **Path**，添加变量值：;%MAVEN_HOME%\bin

直到

```bash
C:\Users\hong>mvn --version
Apache Maven 3.9.0 (9b58d2bad23a66be161c4664ef21ce219c2c8584)
Maven home: D:\app\code\maven\maven3
Java version: 17.0.6, vendor: Oracle Corporation, runtime: D:\app\code\java\jdk-17.0.6
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 11", version: "10.0", arch: "amd64", family: "windows"
```

##### 安装 java 支持合集插件



> Extension Pack for Java



包括

1. Language Support for Java(TM) by Red Hat

2. Debugger for Java

3. Test Runner for Java

4. Maven for Java

5. Project Manager for Java

6. IntelliCode



##### vscode java 配置

###### Language Support for Java(TM) by Red Hat

主要功能

- 支持从 Java 1.5 到 Java 20 的代码
- Maven pom.xml项目支持
- Gradle 项目支持（支持实验性的 Android 项目导入）
- 独立 Java 文件支持
- 解析和编译错误的即类型报告
- 代码完成
- 代码/源操作/重构
- Javadoc 悬停
- 组织导入
  - 手动触发或在保存时触发
  - 使用 （ 在 Mac 上） 将代码粘贴到 Java 文件中时。`Ctrl+Shift+v``Cmd+Shift+v`
- 类型搜索
- 代码大纲
- 代码折叠
- 代码导航
- 代码镜头（参考/实现）
- 突出
- 代码格式（键入/选择/文件）
- 代码片段
- 注释处理支持（Maven 项目自动）
- 语义选择
- 诊断标记
- 呼叫层次结构
- 类型层次结构

查看文档

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230830121948.png)



点击这里

然后edge浏览器已经安装上了 沉浸式翻译

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230830122123.png)



这里就中英文一起看啦



设置项目中的 运行的 jdk

```json
"java.configuration.runtimes": [
        {
            "name": "JavaSE-17",
            "path": "D:\\app\\code\\java\\jdk-17.0.6",
            "default": true
          },
    ], true
  },
]
```



这样运行的时候就会使用我们配置的 jdk 进行运行

```bash
PS E:\vscode\hello-java\hello>  & 'D:\app\code\java\jdk-17.0.6\bin\java.exe' '-agentlib:jdwp=transport=dt_socket,server=n,suspend=y,address=localhost:3218' '-XX:+ShowCodeDetailsInExceptionMessages' '-cp' 'E:\vscode\hello-java\hello\bin' 'App' 
Hello, World!
```

这里使用就是我们配置的本地安装的 jdk17



##### hello java

Ctrl P => create java project



我们创建一个项目

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230830145437.png)



###### 新增文件快捷键修改

我们可以设置自己的快捷键

通过 CTRL K CTRL S 调出快捷键设置界面

通过将 新增文件 设置为 ALT INSERT 跟 idea 一样的快捷方式

其实我觉得快捷键记住一套就够用了

你要学会的是快捷键对应的意思, 而不是每一个工具都去背快捷键, 这得多麻烦呀

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230830165543.png)



接下来 编写一个 java 文件

这里我直接使用 F5 运行 APP.java

```java
public class App {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello, World!");
    }
}

```



得到结果:

```bash
PS E:\vscode\hello-java\hello>  & 'D:\app\code\java\jdk-17.0.6\bin\java.exe' '-agentlib:jdwp=transport=dt_socket,server=n,suspend=y,address=localhost:10998' '-XX:+ShowCodeDetailsInExceptionMessages' '-cp' 'E:\vscode\hello-java\hello\bin' 'App'
Hello, World!
```

### 第一个 maven 应用



### 第一个 springboot 项目

### html

vscode设置html模板
https://blog.csdn.net/joyvonlee/article/details/98179913

可以使用 ctrl shift a 加  html 

```json
{
    "html:5": {
        "prefix": "<html",
        "body": [
            "<!DOCTYPE html>",
            "<html>",
            "<head>",
                "\t<meta charset=\"UTF-8\">",
                "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
                "\t<meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">",
                "\t<title></title>",
            "</head>",
            "<body>",

            "</body>",
            "</html>",
        ],
        "description": "HTML5"
    }
}
```