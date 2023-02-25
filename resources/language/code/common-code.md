# 常用代码

## 验证码实现方案

[最简单的java验证码实现方案 - 掘金](https://juejin.cn/post/6844903962018070536#heading-2)

生成验证码

1. 生成验证码图片 使用数组返回验证码以及验证码图片
2. 用session存放 session id 对应的验证码 使用redis的超时功能 顺便记录下用户验证码验证次数

验证

验证的时候 根据session id 从session中拿到验证码 与用户输入的验证码进行对比 正确的通过 没有则将验证次数减一 小于零则将验证码删除失效



## 分布式Session共享解决方案

[Java分布式Session共享解决方案 - 个人文章 - SegmentFault 思否](https://segmentfault.com/a/1190000022490646)

- 使用cookie来完成（很明显这种不安全的操作并不可靠）
- 使用Nginx中的ip绑定策略，同一个ip只能在指定的同一个机器访问（不支持负载均衡）
- 利用数据库同步session（效率不高）
- 使用tomcat内置的session同步（同步可能会产生延迟）
- 使用token代替session
- ***我们使用spring-session以及集成好的解决方案，存放在redis中***



## 单点登录



[GitHub - a466350665/smart-sso: springboot SSO 单点登录，OAuth2实现，支持App登录，支持分布式](https://github.com/a466350665/smart-sso)

[java实现完全跨域SSO单点登录_下雨了_简的博客-CSDN博客](https://blog.csdn.net/zhangjingao/article/details/81735041)



[java实现 SSO 单点登录（最终版）--补充完全跨域SSO_下雨了_简的博客-CSDN博客_sso中loginout](https://blog.csdn.net/zhangjingao/article/details/89052764)