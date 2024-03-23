# 分布式-注册中心
## nacos

[什么是 Nacos](https://nacos.io/zh-cn/docs/what-is-nacos.html)

Nacos /nɑ:kəʊs/ 是 Dynamic Naming and Configuration Service的首字母简称，一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台

发现、配置和管理微服务

可作为

- 配置中心
- 注册中心



下载:

[Releases · alibaba/nacos (github.com)](https://github.com/alibaba/nacos/releases)



### nacos 学习网站
[Nacos系列博客说明](https://www.larscheng.com/categories/SpringCloud/)


![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_SlOtLAgwKE.png)


### nacos 搭建
首先你得先搭建一个 springcloud 的 父模块 或者 父工程
示例: 使用IDEA搭建SpringCloud项目方法_简单入门
https://blog.csdn.net/weixin_42547014/article/details/120156385

搭建过程中遇到的问题:
Add a spring.config.import=nacos: property to your configuration.
https://blog.csdn.net/qq_27047215/article/details/129726096
记录一次SpringBoot3+Nacos Config做配置中心时，No spring.config.import property has been defined的问题
因为springcloud 把 bootstrap 依赖默认去掉了

springcloud nacos 学习:
https://spring-cloud-alibaba-group.github.io/github-pages/2021/en-us/index.html##_spring_cloud_alibaba_nacos_config



>c.a.n.c.remote.client.grpc.GrpcClient    : []Error to process server push response: {"headers":{},"abilityTable":
>{"supportPersistentInstanceByGrpc":true},"module":"internal"}

```xml
 <dependency>
	<groupId>org.reflections</groupId>
	<artifactId>reflections</artifactId>
	<version>0.9.11</version>
</dependency>

```

网上是说把依赖的 reflections 版本过低

但是我这里的版本就是 这个 9.11

我试着把nacos 从 2.3.0 换成 2.1.1

结果没有这个错误之后

也可以实现动态配置的功能了



另外的一个问题是:

>java: java.lang.NoSuchFieldError: Class com.sun.tools.javac.tree.JCTree$JCImport does not have member field 'com.sun.tools.javac.tree.JCTree qualid'



是因为 jdk 版本与 lombok 版本不匹配的问题

```bash
C:\Users\hong>java --version
java 21.0.1 2023-10-17 LTS
```

换成

```xml
<lombok.version>1.18.30</lombok.version>
```

就没这个错误了



### 不同语言使用 nacos
#### java
主要还是在 java 的 springcloud 中

##### 配置中心

主要你先要搭建一个 springcloud 的父工程
引入 springcloud 阿里巴巴 包的依赖

###### 动态配置

依赖:

主要还是因为要引入 springcloud-alibaba 依赖

[版本说明 · alibaba/spring-cloud-alibaba Wiki (github.com)](https://github.com/alibaba/spring-cloud-alibaba/wiki/版本说明)



springcloud:  2022.0.0

springboot: 3.0.2

springcloud-alibaba: 2022.0.0.0-RC2

nacos:  2.1.1

###### 测试是否可以动态配置

```yaml
server:
  port: 8003
```

将服务器的启动端口 从 8002 修改到 8003

不重启应用无法修改配置



###### 优先级

nacos 中配置

```yaml
white:
  name: 1.1.1.1
```

项目中配置了

```yaml
white:
  name: 192.122.34.56
```

结果: nacos 更优先

```log
2024-01-13T19:54:04.749+08:00  INFO 3492 --- [nacos-demo] [           main] c.h.d.s.config.WhiteLIstConfigTest       : whiteLIstConfig: WhiteLIstConfig(name=1.1.1.1)

```



#### javascript
node 也有对应的客户端

#### python
python 连接 nacos
因为客户端的关系, 需要将

python 切换为 3.7

nacos 切换为 1.3.2

当然如果 客户端更新了 那自然就没有此限制了

### 术语
#### [灰度配置](https://nacos.io/zh-cn/blog/nacos%201.1.0.html)
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_2554gdcQyB.png)