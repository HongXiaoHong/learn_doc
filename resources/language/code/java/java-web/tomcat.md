# java web 与 Tomcat

[第一个 SpringMVC Controller · Heart First JavaWeb (skyline75489.github.io)](https://skyline75489.github.io/Heart-First-JavaWeb/5-First-SpringMVC-Controller.html)



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230725234231.png)



[Spring Web 如何在 Tomcat 中启动 | Utokato's Notes](https://utokato.cn/2019/10/19/spring-run-with-or-without-external-tomcat/)



一般而言，Java Web 应用程序需要一个 web.xml 文件，在这个文件中描述了当前 Web 应用部署的情况，如果这个 Web 应用不包含任何的 servlet、filter、listener 组件，即这是一个静态的 Web 应用，那么就可以不需要这个 web.xml 文件。换句话来说，只包含了静态文件的应用并不需要这个文件。

如果是一个动态的 Web 应用呢？是否必须包含这个 web.xml 文件呢？答案是否定的。因为在 `servlet3.0` 及其以后的规范中，引入了一个新的特性 — 共享库/运行时的可插拔特性，基于这一新特性，再配合注解的方式，可以完全替代该 web.xml 配置文件。

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230725230250.png)



`ContextLoaderListener` 和 `DispatcherServlet` 是在 Java Spring Web 开发中的两个重要组件，它们分别负责不同的功能。

1. ContextLoaderListener：
   `ContextLoaderListener` 是一个监听器（Listener），用于在 Web 应用程序启动时加载 Spring 的根应用程序上下文（Root Application Context）。它的主要作用如下：
- 初始化 Spring 根应用程序上下文：`ContextLoaderListener` 在 Web 应用程序启动时自动加载，并负责创建和初始化 Spring 的根应用程序上下文。根应用程序上下文是整个 Web 应用程序的核心容器，负责管理应用程序中的所有 bean。

- 管理生命周期：`ContextLoaderListener` 在 Web 应用程序的生命周期中起到重要的作用。它会在 Web 应用程序启动时加载根应用程序上下文，在 Web 应用程序关闭时销毁根应用程序上下文，确保资源的正确释放和回收。

- 全局共享：根应用程序上下文是全局共享的，可以在整个 Web 应用程序中共享 bean 实例。这意味着在不同的 Servlet、Filter 或其他组件中，可以通过获取根应用程序上下文来共享同一个 bean 实例。
2. DispatcherServlet：
   `DispatcherServlet` 是一个 Servlet，用于处理所有的客户端请求，并将请求分发给相应的处理器（Handler）来处理。它的主要作用如下：
- 请求分发：`DispatcherServlet` 是一个中央控制器，负责接收所有的客户端请求，并根据请求的 URL 和其他条件将请求分发给相应的处理器（Handler）来处理。处理器可以是 Spring Controller 或其他处理组件。

- 视图解析：`DispatcherServlet` 负责调用处理器处理请求后，根据处理结果选择合适的视图进行渲染。它使用视图解析器来将逻辑视图名映射为真正的视图，最终将响应返回给客户端。

- 集成 Spring MVC：`DispatcherServlet` 是 Spring MVC 框架的核心组件，它将 Spring MVC 集成到 Spring Web 应用程序中。通过 `DispatcherServlet`，开发者可以使用 Spring MVC 提供的各种功能来开发 Web 应用程序。

总结：
`ContextLoaderListener` 负责在 Web 应用程序启动时加载 Spring 的根应用程序上下文，管理根应用程序上下文的生命周期，并提供全局共享的上下文。而 `DispatcherServlet` 则负责处理客户端的请求，根据请求分发给相应的处理器来处理，并最终渲染合适的视图返回给客户端。它们在 Spring Web 开发中分别扮演着应用程序的核心容器初始化和请求处理的角色，共同构成了完整的 Spring Web 应用程序架构。



Tomcat 源码:

[Tomcat原理系列之四：tomcat与spring容器的关系-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/924391?ex=cloudnative#slide-5)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230725233813.png)



ContextLoaderListener 监听器, 在容器启动的时候通过回调

初始化容器



> Tomcat 通过 urlpath 匹配到对应servlet
> 
> 通过 /** 匹配 DispatcherServlet
> 
> DispatcherServlet 再转发到应用的 controller



### ContextLoaderListener

[ContextLoaderListener解析 - 简书 (jianshu.com)](https://www.jianshu.com/p/523bfddf0810)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230725231936.png)



### HTTP请求的完整流转 从Tomcat到Spring MVC

[(26条消息) 记一次HTTP请求的完整流转 从Tomcat到Spring MVC_一个请求的所有过程,从tcpip连接到tomcat容器,到spring的controller_高兴的才哥的博客-CSDN博客](https://blog.csdn.net/u012803274/article/details/104723613)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230725234030.png)



源码分析:



[http请求从tomcat到springmvc的完整流程 - 掘金 (juejin.cn)](https://juejin.cn/post/7110415265271119880)



可能出现的问题

[Spring mvc 启动配置文件加载两遍问题-腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1129875)


