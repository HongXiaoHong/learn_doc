# 单点登录

https://www.bilibili.com/video/BV1b14y1y7Dx/?spm_id_from=trigger_reload&vd_source=eabc2c22ae7849c2c4f31815da49f209

## 流程/原理
参  [CAS 协议](https://apereo.github.io/cas/6.6.x/protocol/CAS-Protocol.html)
[单点登录原理（SSO）](http://hongyitong.github.io/2018/03/20/%E5%8D%95%E7%82%B9%E7%99%BB%E5%BD%95%E5%8E%9F%E7%90%86%EF%BC%88SSO%EF%BC%89/)

[【Java面试最新】什么是单点登录，以及单点登录的实现流程？](https://www.bilibili.com/video/BV1b14y1y7Dx/?spm_id_from=trigger_reload&vd_source=eabc2c22ae7849c2c4f31815da49f209)
### 登录
![登录](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230920222508.png)

### 登出
[系统的讲解 - SSO单点登录](https://www.imooc.com/article/286710)
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230920222849.png)

## 来源

系统比较少的情况下, 是可以不用单点登录的

但是当我们的系统多了, 之后不可能每一个系统都有一套认证系统来进行登录吧

于是我们把认证服务抽取出来, 作为一个认证服务

这也就是单点登录的来源了

## 如何实现单点登录

我理解的实现思路有:
- CAS
- OAUTH

虽然说 oauth 是授权的协议
但是如果把 第三方应用替换成多系统的内部系统 那么拿来认证也是可以的呀

### CAS
[CAS 协议](https://apereo.github.io/cas/6.6.x/protocol/CAS-Protocol.html)
[使用 CAS（中央身份验证服务）进行单点登录](https://dinika-15.medium.com/single-sign-on-with-cas-central-authentication-service-fd60bae64fa7)



### 是否将http提升为有状态的协议 | 验证信息存放是否放置到服务器

session 验证需要将 验证信息放置到 客户端

袁大佬理解两种思路:
https://v.douyin.com/ieDYdRuC/

- 使用 session/cookie
  - 适用
    - 多个域名具有公共后缀的情况, 例如 movie.baidu.com 与 app.baidu.com
  - 缺点
    - 不利于分布式部署, 虽然也可以通过 nginx 的转发来实现分布式, 但是扩展起来比较复杂
    - 认证信息存储在服务器, 对服务器的性能/内存/存储 要求高, 成本高
- 使用 token
  - 认证信息存储在客户端
  - 安全问题
    - 使用 jwt
      - jwt = 头 ＋ 负载(具体信息) ＋ 认证
        - 头记载了 jwt 使用的加密方式, 负载记录了用户id过期时间等信息, 
          - 头跟负载只是用 base64 简单进行编码, 并不安全, 不推荐存放敏感信息
        - 认证 用来 对头负载进行加密, 也就是用来保证 头负载不被篡改

## 单点登录过程

总体过程:
https://github.com/xszi/docs/issues/48

### jwt

https://www.bilibili.com/video/BV1b14y1y7Dx/?spm_id_from=trigger_reload&vd_source=eabc2c22ae7849c2c4f31815da49f209

## 实现
### CAS
[简简单单聊下SSO(单点登录)](https://zhuanlan.zhihu.com/p/203308588)
### OAUTH
参  [单点登录踩坑记](https://www.cnblogs.com/zzk0/p/14735442.html)
smart-sso使用当下最流行的SpringBoot技术，基于OAuth2认证授权协议
[smart-sso 智能单点登录](https://github.com/a466350665/smart-sso)

### 扩展阅读

[OAuth 2.0 的一个简单解释 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/oauth_design.html)

[OAuth 2.0 的四种方式 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/oauth-grant-types.html)

[GitHub OAuth 第三方登录示例教程 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/github-oauth.html)

[SSO单点登录看这一篇就够了](https://github.com/IcyBiscuit/Java-Guide/blob/master/docs/system-design/authority-certification/SSO%E5%8D%95%E7%82%B9%E7%99%BB%E5%BD%95%E7%9C%8B%E8%BF%99%E4%B8%80%E7%AF%87%E5%B0%B1%E5%A4%9F%E4%BA%86.md)

