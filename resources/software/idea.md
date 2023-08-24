# idea

## 社区版 | 白嫖真的香

**还是用社区版的吧**

以前不用是因为 没有web插件 不能直接发布到 Tomcat 

现在的版本已经有了

而且现在的管制特别严 还是算了 直接使用社区版的

毕竟有插件可以替代了 够用了

[IntelliJ IDEA Community Edition 社区版插件汇总 - CodeAntenna](https://codeantenna.com/a/KK4BCbaTcE)

但是社区版有一个限制那就是没办法 直接创建 springboot  项目
曲线救国的情况下, 只能这样
https://blog.51cto.com/u_15064627/4317906
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230724153749.png)

我现在的做法是 现在 
https://start.spring.io/
新建一个项目

解压之后

拷贝到 idea 中

标记 pom.xml 文件为 maven 项目


## idea中properties配置文件显示中文

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/chrome_XH1gqRYQK3.png)

## 【IDEA】如何完美的修改重命名一个SpringBoot项目工程名称

[【IDEA】如何完美的修改重命名一个SpringBoot项目工程名称](https://www.cnblogs.com/manmanblogs/p/15871175.html)

## 调试接口

### Http Client

[IntelliJ IDEA的这个接口调试工具真是太好用了！ - 日拱一兵 - 博客园 (cnblogs.com)](https://www.cnblogs.com/FraserYu/p/12290061.html)

结合 restfulToolkit 使用图形化进行操作, 我觉得还是挺香的

使用 IntelliJ IDEA 内置的 Http Client 调用接口，您可以使用编辑器模式或者直接在 Http Client 工具窗口中进行调用。

编辑器模式下调用接口的步骤如下：

1. 在 IntelliJ IDEA 中打开或者创建一个新的 *.http 或 *.rest 文件。

2. 在文件中输入要调用的接口的请求信息，如 URL、请求方法、请求头、请求参数、请求体等。

3. 在请求信息后面添加 `SEND` 指令并保存文件，如：

```http
GET http://example.com/api/users?name=test
Content-Type: application/json

SEND
```

4. 然后，在请求信息行或指令行右键单击，选择“Run 'GET [http://example.com/api/users?name=test'”以运行请求。](http://example.com/api/users?name=test%27%E2%80%9D%E4%BB%A5%E8%BF%90%E8%A1%8C%E8%AF%B7%E6%B1%82%E3%80%82)

5. 查看返回结果，并根据需要进行调试和修改。

### Apifox

已推出 IDEA 插件 「**Apifox Helper」** 。**Apifox Helper 是一款集成在 IDEA 中，帮助开发者自动解析代码注释并快速生成 API 文档的便捷工具。**Apifox Helper 是基于 javadoc（Java）、KDoc（Kotlin）、ScalaDoc（Scala）解析 API 文档，支持 spring Boot、Swagger、JAX-RS 等协议框架，基本可以实现**代码零入侵自动生成接口文档**。APIFox

[IDEA插件Apifox,一键自动生成接口文档！ - 雨点的名字 - 博客园 (cnblogs.com)](https://www.cnblogs.com/qdhxhz/p/17123352.html)

[Apifox IDEA 插件 | 「Apifox Helper」帮助开发者快速生成 API 文档](https://apifox.com/blog/apifox-helper/)

**后端开发者**: 在 IDEA 中安装 「Apifox Helper」，随时编写/调试，随时更新同步；

**前端开发者**: 在 Apifox 中查看最新文档，进行接口调试、API Mock ；

**测试工程师**: 在 Apifox 中获取最新接口信息，编写/保存测试用例、进行自动化测试。让后端开发者只需一个「Apifox Helper」即可在 IDEA 中完成 API 协作所需的工作。

## debug 调试

[IDEA中的debug断点调试技巧，学会真的香！ - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1887019)
