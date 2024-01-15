# springcloud

todo

- SpringCloud轻松集成Dubbo实现RPC调用

## 入门

[【狂神说Java】SpringCloud最新教程IDEA版](https://www.bilibili.com/video/BV1jJ411S7xr?p=3)

[狂神说 SpringCloud: 狂神说bilibili课程，随堂代码 - Gitee.com](https://gitee.com/hongxiaohong/kuangspringcloud/tree/master)



[spring-cloud - 纯洁的微笑博客 (ityouknow.com)](http://www.ityouknow.com/spring-cloud.html)
https://github.com/ityouknow/spring-cloud-examples

### 项目搭建
使用 maven 搭建 springcloud 项目
使用IDEA搭建SpringCloud项目方法_简单入门
https://blog.csdn.net/weixin_42547014/article/details/120156385

springcloud 与 springboot 版本依赖
https://docs.spring.io/spring-cloud-release/reference/index.html
https://spring.io/projects/spring-cloud/#learn

### 与dubbo 区别

https://www.bmabk.com/index.php/post/50604.html

### 组件
#### netfix
##### Ribbon | 客户端负载均衡

[Ribbon：Spring Cloud负载均衡与服务调用组件（非常详细）](https://c.biancheng.net/springcloud/ribbon.html)
#### Hystrix | 服务熔断降级
[Springcloud基础知识（7）- Spring Cloud Hystrix (二) | Hystrix 全局/解耦降级、服务熔断、故障监控](https://www.cnblogs.com/tkuang/p/16422160.html)
[Hystrix 原理与实战](https://www.bilibili.com/video/BV1V4411F7my/?p=2&vd_source=eabc2c22ae7849c2c4f31815da49f209)
[share-hystrix 课件](https://gitee.com/phui/share-early-works/blob/master/Hystrix%20%E5%8E%9F%E7%90%86%E4%B8%8E%E5%AE%9E%E6%88%98/share-hystrix%20%E8%AF%BE%E4%BB%B6.jpg)

### alibaba
#### Sentinel | 限流/熔断/降级
[Sentinel：Spring Cloud Alibaba高可用流量控制组件（非常详细）](https://c.biancheng.net/springcloud/sentinel.html)
Sentinel 是阿里中间件团队开源的，面向分布式服务架构的轻量级高可用流量控制组件，主要以流量为切入点，从流量控制、熔断降级、系统负载保护等多个维度来帮助用户保护服务的稳定性。

##### [Sentinel 与 Hystrix 的对比](https://sentinelguard.io/zh-cn/blog/sentinel-vs-hystrix.html)
Hystrix 的关注点在于以 隔离 和 熔断 为主的容错机制，超时或被熔断的调用将会快速失败，并可以提供 fallback 机制。

而 Sentinel 的侧重点在于：

多样化的流量控制
熔断降级
系统负载保护
实时监控和控制台