# 安全认证

## todo

- [x] token 过期了如何延期，只在后端处理，不涉及前端的
- [x] shiro 入门
- [ ] spring security 入门
  - [ ] [java - 68篇干货，手把手教你通关 Spring Security！ - 个人文章 - SegmentFault 思否](https://segmentfault.com/a/1190000038275203)
  - [ ] [(19条消息) SpringBoot整合SpringSecurity超详细入门教程_springsecurity springboot_龙源lll的博客-CSDN博客](https://blog.csdn.net/Lzy410992/article/details/115893355)
  - [ ] [保护web应用的安全 · SpringSecurity从入门到进阶学习笔记 (gitbooks.io)](https://luoluocaihong.gitbooks.io/springsecurity/content/chapter1.html)
  - [ ] [SpringSecurity结合JWT实现前后端分离的后端授权-51CTO.COM](https://www.51cto.com/article/705742.html)
  - [ ] [(21条消息) Spring Security、oauth2、单点登陆SSO的关系_spring security sso_云川之下的博客-CSDN博客](https://blog.csdn.net/m0_45406092/article/details/123797710)
- [ ] 使用 QQ 登录
- [ ] shiro高级
  - [ ] [(21条消息) SpringBoot(13) 集成Shiro实现动态加载权限_郑清的博客-CSDN博客](https://blog.csdn.net/qq_38225558/article/details/101616759) 主要思路是 实现 ShiroService
  - [x] [[译] 用 Apache Shiro 来保护一个 Spring Boot 应用 - 掘金 (juejin.cn)](https://juejin.cn/post/6844903810117140487)
    - [ ] 如何通过数据库进行鉴权 Realm

## jwt

[JSON Web Token 入门教程 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)

JSON Web Token（缩写 JWT）是目前最流行的跨域认证解决方案

服务器索性不保存 session 数据了，所有数据都保存在客户端，每次请求都发回服务器。JWT 就是这种方案的一个代表。

    

- Header（头部）
- Payload（负载）
- Signature（签名）

JWT实现的时候，一般会有两个过期时间

第一个是Token本身的过期时间，这个时间一般1到2个小时，不能太长，也可以在短一点，不过5s的简直纯属扯淡。

第二个是Token过期后，再次刷新的有效期，也就是Token过期后，你还有一段时间可以重新刷新，把过期的Token发给服务端，如果没有过刷新截止期，则服务端返回一个新的Token，不再需要通过用户名密码重新登录获取Token了。

所以为了减少过期后重新获取Token所带来的麻烦，我们一般在每次Http请求成功后，将目前的Token刷新，然后可以在Http响应中返回新的Token。

JWT由于过期数据(exp claim)是封装在Payload中的，所以必须返回一个新Token，而不是在旧Token的基础上刷新。

但是在并发的时候也会出现问题，如果前一个请求刷新了Token(为了安全，刷新后一般会把旧Token加入黑名单)，后面的请求使用了一个旧的Token像服务请求数据，这个时候请求会被拒绝。

可以说这真的是JWT的一个缺陷，目前没有特别好的办法来解决并发刷新的问题。

不过可以通过设置一个宽限时间，在Token刷新后，如果旧Token仍处于刷新宽限时间内，就放行

## SSO | 单点登录

### 简介

[什么是 SSO？- 单点登录简介 - AWS (amazon.com)](https://aws.amazon.com/cn/what-is/sso/)

## 什么是 SSO？

单点登录（SSO）是一种身份验证解决方案，可让用户通过一次性用户身份验证登录多个应用程序和网站。鉴于当今的用户经常直接从其浏览器访问应用程序，因此组织正在优先考虑改善安全性和用户体验的访问管理策略。SSO 兼具这两方面的优点，因为一旦验证身份，用户就可以访问所有受密码保护的资源，而无需重复登录

### SSO 有哪些类型？

SSO 解决方案使用不同的标准和协议来对用户凭证进行验证和身份验证。

#### **SAML**

SAML（或安全断言标记语言）是应用程序用来与 SSO 服务交换身份验证信息的协议或规则集。SAML 使用 XML（一种浏览器友好的标记语言）来交换用户标识数据。基于 SAML 的 SSO 服务提供更好的安全性和灵活性，因为应用程序不需要在其系统上存储用户凭证。

#### **OAuth** | 授权协议

原来是用来授权第三方系统登录的授权标准

现在被用来当认证协议也是没想到 哈哈哈

OAuth（或开放授权）是一种开放标准，它允许应用程序安全地从其他网站获取用户信息，而无需提供密码。应用程序不是请求用户密码，而是使用 OAuth 来获得用户访问受密码保护的数据的权限。OAuth 通过 API 建立应用程序之间的信任，允许应用程序在已建立的框架中发送和响应身份验证请求。

#### **OIDC** | oauth+认证

OpenID 是使用一组用户凭证访问多个站点的方法。它允许服务提供商承担验证用户凭证的角色。Web 应用程序不是将身份验证令牌传递给第三方身份提供商，而是使用 OIDC 来请求附加信息并验证用户的真实性。

#### **Kerberos**

Kerberos 是一种基于票证的身份验证系统，可让两方或多方在网络上相互验证其身份。它使用安全密码学来防止未经授权访问在服务器、客户端和密钥分发中心之间传输的标识信息

GitHub上有名的框架

- Sa-Token [dromara/Sa-Token: 这可能是史上功能最全的Java权限认证框架！目前已集成——登录认证、权限认证、分布式Session会话、微服务网关鉴权、单点登录、OAuth2.0、踢人下线、Redis集成、前后台分离、记住我模式、模拟他人账号、临时身份切换、账号封禁、多账号认证体系、注解式鉴权、路由拦截式鉴权、花式token生成、自动续签、同端互斥登录、会话治理、密码加密、jwt集成、Spring集成、WebFlux集成... (github.com)](https://github.com/dromara/Sa-Token)

- [xuxueli/xxl-sso: A distributed single-sign-on framework.（分布式单点登录框架XXL-SSO） (github.com)](https://github.com/xuxueli/xxl-sso/)

## oauth2

### 简介

[OAuth 2.0 的一个简单解释 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/oauth_design.html)

目前最流行的授权机制，用来授权第三方应用，获取用户数据

### 授权方式

[OAuth 2.0 的四种方式 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/oauth-grant-types.html)

最常见

## 授权码

**授权码（authorization code）方式，指的是第三方应用先申请一个授权码，然后再用该码获取令牌。**

这种方式是最常用的流程，安全性也最高，它适用于那些有后端的 Web 应用。授权码通过前端传送，令牌则是储存在后端，而且所有与资源服务器的通信都在后端完成。这样的前后端分离，可以避免令牌泄漏

## 常见问题

### java后端实现token自动续期

1. 放到 redis 缓存

[java后端实现token自动续期，这方案有点优雅-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/829746)

2. refresh token

[前端鉴权必须了解的 5 个兄弟：cookie、session、token、jwt、单点登录 - 掘金 (juejin.cn)](https://juejin.cn/post/7040695405486538759#heading-3)

**refresh token**

token，作为权限守护者，最重要的就是「安全」。业务接口用来鉴权的 token，我们称之为 access token。越是权限敏感的业务，我们越希望 access token 有效期足够短，以避免被盗用。但过短的有效期会造成 access token 经常过期，过期后怎么办呢？一种办法是，让用户重新登录获取新 token，显然不够友好，要知道有的 access token 过期时间可能只有几分钟。另外一种办法是，再来一个 token，一个专门生成 access token 的 token，我们称为 refresh token。

- access token 用来访问业务接口，由于有效期足够短，盗用风险小，也可以使请求方式更宽松灵活

- refresh token 用来获取 access token，有效期可以长一些，通过独立服务和严格的请求方式增加安全性；由于不常验证，也可以如前面的 session 一样处理

有了 refresh token 后，几种情况的请求流程变成这样：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a6550d6972c743f085e704f0c3ce8185~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

如果 refresh token 也过期了，就只能重新登录了

### SSO 与 OAuth 傻傻分不清？

[SSO 轻量级实现指南（原生 Java 实现）：SSO Server 部分_sp42a的博客-CSDN博客](https://blog.csdn.net/zhangxin09/article/details/123292897)

OAuth 是 OAuth，OAuth 不单单为 SSO 服务的。OAuth 协议初衷是为了用户不用告诉第三方系统账号和密码就可以访问受限的资源，——可以成为 SSO 的通行协议这个想必原设计者都没有料到的。没有 OAuth 之前，SSO 老早就有，只是各家各法自行实现，总能达到单点登录的目的。也就是说，SSO 的协议不一定是 OAuth，而 OAuth 不一定服务于 SSO。

SSO 与 OAuth 两者相同的是，都紧扣“我是谁”之要义，即用户身份认证的问题，是为核心的问题，所有关于用户一切的信息都应存储在 SSO 中心或 OAuth 资源服务器，由它们所把控。稍有出入的是，OAuth 认证服务器往往是与资源服务器在一起的，这个一起的意思可以是物理意义上的同一部机器（部署在一起）。但 SSO 中心呢？一般则简单、纯粹的得多，单纯做用户认证的，——即使涉及用户权限的 SSO 中心，顶多也是功能性的、系统级的权限控制，而不是垂直的数据权限控制（资源的权限控制）。也就是说，SSO 中心不负责资源问题，而资源往往在客户端 Client 那边。总之，狭义的 OAuth 很可能是整个大系统中，对外服务的一个模块；而 SSO 中心则纯粹得多，通常独立部署，独立服务，只做好 SSO 一件事情。

在流程上，SSO 与 OAuth 也有显著不同，例如同意授权访问，典型的第三方登录是有这一步的（如下图所示），但 SSO 没有吧

### 你知道并发Bug的源头是什么吗？

[面试官:你知道并发Bug的源头是什么吗？-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/915704)

可见性、原子性、有序性

讲实话听到这个问题，不太熟悉并发编程的同学有点晕，你可能只能答个因为多线程之间的竞争共享资源啊。对说的没错。

但是呢感觉不够亮眼！我们的目的就是让面试官眼前一亮，让他颤抖！心里鼓掌:"牛批牛批!"

![image.png](https://ucc.alicdn.com/pic/developer-ecology/3e98ccf8dba94fa89171d734076f643b.png "image.png")

多线程，给我们的感觉像啥？就像《风云》里面的无名的"万剑归宗"！《雪中悍刀行》里面老剑神李淳罡一声“剑来！”。哗哗哗的好多剑同时操作着一起飞！多帅哦！

但实际上CPU的执行是有时间片的，也就是其实我们多线程不是同一时间一起执行的，是每个线程执行一会儿就换一个上，但是时间片很短，所以我们感觉上是一起执行的。当然多核CPU的话，每个CPU是并行的，但是我们CPU颗数哪有我们的线程多！

大家都知道我们电脑有CPU，内存，IO设备。IO读取时最慢的，然后是内存读取，最快的是CPU的执行。那因为内存太慢了，跟不上CPU，所以CPU搞了个缓存。就是因为这个缓存再加上多颗CPU并发就出问题了。

举个例子

int addOne(){
             a=a+1;        }

上面这个程序很简单，但是如果有两个线程A和B，分别CPU-A和CPU-B中同时addOne()可能会出现什么问题呢？

![image.png](https://ucc.alicdn.com/pic/developer-ecology/0c22bee8a17d40b3acbe71e4f284fa64.png "image.png")

![image.png](https://ucc.alicdn.com/pic/developer-ecology/ec1d70ba5f464511afe674900357616e.png "image.png")

同时的线程A把a从内存中取到CPU-A缓存中，缓存中a的值是0，线程B把a从内存中取到CPU-B缓存中缓存中a的值是0。然后它们各自+了个1。这时候在它们的各自的缓存中a的值都是1。那之后写入内存中，是不是a就变成1了？

那我们加了两次是不是少了一次了！这是问题就是可见性问题了！CPU-A的缓存的值CPU-B不可见！这就是可见性的根本原因。

我们再来说一下原子性，首先原子性指的就是一个或多个操作在CPU中执行不会被中断的特性称为原子性。

我们的JAVA语言是高级语言。高级语言是怎么个情况。就是我们一条java代码涵盖了好几条底层指令。比如我们上面的a=a+1;把它转换成CPU指令至少有三条。

第一条：把a从内存拿到寄存器中；

第二条：寄存器中+1；

第三条：结果写入缓存或内存中；

那按照CPU的原子性，它是指令级别的！一条指令是不会被中断的，所以说在我们以为a=a+1;是原子级别的，实际上在CPU看来不是。

所以呢如果此时有两个线程同时执行，那可能线程A执行到第二条的时候，时间片到了。现在换线程B上了，然后线程B又把a从内存中拿到，然后+1返回结果，此时换到了线程A，线程A继续执行第三条。那情况就是又错了。

还没完呢！我们编译器或解释器的优化可能带来意料不到的问题！为了优化性能，它可能会改变语句执行的顺序，也就是指令重排！

最经典的就是单例的双重检查了！

![image.png](https://ucc.alicdn.com/pic/developer-ecology/0b4851d196cc4a22913decc94e20c950.png "image.png")

看起来都加锁了好像没问题了，而问题就出在 instance = new Singleton(); 上

我们认为的new操作就是：

1.分配一块内存

    2.在内存上初始化Singleton    
    3.将内存地址赋值给instance

而指令重排之后：

1.分配一块内存

    2.将内存地址分配给instance    
    3.初始化Singleton

这会导致什么问题呢？假设线程A已经执行到new Singleton()的指令2了，然后时间片到了，这时候线程B也调用getInstance();到第一个instance==null时候，直接返回了。很开心拿到了对象了！而实际上对象还没初始化呢！所以用了的话就是空指针了！

这就是有序性问题了！

### java cas aba问题的后果

#### ABA

但CAS存在一个ABA问题，举例来说，假设线程1和线程2拥有同一个引用p，p指向对象A。某个时刻，线程1想要利用CAS把p指向的对象换成C，此时被线程2中断，线程2将p指向的对象换成B后再换成A，然后线程1继续运行，发现p确实仍然指向对象A，因此执行CAS将A换成C。但线程1并不知道在它中断的这段时间内，p指向的引用经历了从A到B在到A的过程，这个bug就称为ABA问题

#### 危害

假设有一种场景 现实中当然是不存在的

银行将你账户的钱取走 然后等到用完的时候再给你填回去

你去取钱的时候 发现咦 钱怎么刚刚少了那么多

银行是不是干了什么坏事 由此产生信用危机

## 备份

### 认证的前世今生 cookie、session、token、jwt、单点登录

- [前端鉴权必须了解的 5 个兄弟：cookie、session、token、jwt、单点登录 - 掘金 (juejin.cn)](https://juejin.cn/post/7040695405486538759#heading-3)

本文你将看到：

- 基于 HTTP 的前端鉴权背景

- cookie 为什么是最方便的存储方案，有哪些操作 cookie 的方式

- session 方案是如何实现的，存在哪些问题

- token 方案是如何实现的，如何进行编码和防篡改？jwt 是做什么的？refresh token 的实现和意义

- session 和 token 有什么异同和优缺点

- 单点登录是什么？实现思路和在浏览器下的处理

### 1、从状态说起

**HTTP 无状态**

我们知道，HTTP 是无状态的。也就是说，HTTP 请求方和响应方间无法维护状态，都是一次性的，它不知道前后的请求都发生了什么。但有的场景下，我们需要维护状态。最典型的，一个用户登陆微博，发布、关注、评论，都应是在登录后的用户状态下的。

**标记**

那解决办法是什么呢？::标记::。

在学校或公司，入学入职那一天起，会录入你的身份、账户信息，然后给你发个卡，今后在园区内，你的门禁、打卡、消费都只需要刷这张卡。

**前端存储**

这就涉及到一发、一存、一带，发好办，登陆接口直接返回给前端，存储就需要前端想办法了。

前提是，你要把卡带在身上。

前端的存储方式有很多。

- 最矬的，挂到全局变量上，但这是个「体验卡」，一次刷新页面就没了

- 高端点的，存到 cookie、localStorage 等里，这属于「会员卡」，无论怎么刷新，只要浏览器没清掉或者过期，就一直拿着这个状态。

前端存储这里不展开了。有地方存了，请求的时候就可以拼到参数里带给接口了。

### 2、基石：cookie

可是前端好麻烦啊，又要自己存，又要想办法带出去，有没有不用操心的？

有，cookie。cookie 也是前端存储的一种，但相比于 localStorage 等其他方式，借助 HTTP 头、浏览器能力，cookie 可以做到前端无感知。一般过程是这样的：

- 在提供标记的接口，通过 HTTP 返回头的 Set-Cookie 字段，直接「种」到浏览器上

- 浏览器发起请求时，会自动把 cookie 通过 HTTP 请求头的 Cookie 字段，带给接口

**配置：Domain / Path**

你不能拿清华的校园卡进北大。

cookie 是要限制::「空间范围」::的，通过 Domain（域）/ Path（路径）两级。

Domain属性指定浏览器发出 HTTP 请求时，哪些域名要附带这个 Cookie。如果没有指定该属性，浏览器会默认将其设为当前 URL 的一级域名，比如 [www.example.com](https://link.juejin.cn?target=http%3A%2F%2Fwww.example.com "http://www.example.com") 会设为 example.com，而且以后如果访问example.com的任何子域名，HTTP 请求也会带上这个 Cookie。如果服务器在Set-Cookie字段指定的域名，不属于当前域名，浏览器会拒绝这个 Cookie。Path属性指定浏览器发出 HTTP 请求时，哪些路径要附带这个 Cookie。只要浏览器发现，Path属性是 HTTP 请求路径的开头一部分，就会在头信息里面带上这个 Cookie。比如，PATH属性是/，那么请求/docs路径也会包含该 Cookie。当然，前提是域名必须一致。

**配置：Expires / Max-Age**

你毕业了卡就不好使了。

cookie 还可以限制::「时间范围」::，通过 Expires、Max-Age 中的一种。

Expires属性指定一个具体的到期时间，到了指定时间以后，浏览器就不再保留这个 Cookie。它的值是 UTC 格式。如果不设置该属性，或者设为null，Cookie 只在当前会话（session）有效，浏览器窗口一旦关闭，当前 Session 结束，该 Cookie 就会被删除。另外，浏览器根据本地时间，决定 Cookie 是否过期，由于本地时间是不精确的，所以没有办法保证 Cookie 一定会在服务器指定的时间过期。Max-Age属性指定从现在开始 Cookie 存在的秒数，比如60 * 60 * 24 * 365（即一年）。过了这个时间以后，浏览器就不再保留这个 Cookie。如果同时指定了Expires和Max-Age，那么Max-Age的值将优先生效。如果Set-Cookie字段没有指定Expires或Max-Age属性，那么这个 Cookie 就是 Session Cookie，即它只在本次对话存在，一旦用户关闭浏览器，浏览器就不会再保留这个 Cookie。

**配置：Secure / HttpOnly**

有的学校规定，不带卡套不让刷（什么奇葩学校，假设）；有的学校不让自己给卡贴贴纸。

cookie 可以限制::「使用方式」::。

Secure属性指定浏览器只有在加密协议 HTTPS 下，才能将这个 Cookie 发送到服务器。另一方面，如果当前协议是 HTTP，浏览器会自动忽略服务器发来的Secure属性。该属性只是一个开关，不需要指定值。如果通信是 HTTPS 协议，该开关自动打开。HttpOnly属性指定该 Cookie 无法通过 JavaScript 脚本拿到，主要是Document.cookie属性、XMLHttpRequest对象和 Request API 都拿不到该属性。这样就防止了该 Cookie 被脚本读到，只有浏览器发出 HTTP 请求时，才会带上该 Cookie。

**HTTP 头对 cookie 的读写**

回过头来，HTTP 是如何写入和传递 cookie 及其配置的呢？HTTP 返回的一个 Set-Cookie 头用于向浏览器写入「一条（且只能是一条）」cookie，格式为 cookie 键值 + 配置键值。例如：

```ini
Set-Cookie: username=jimu; domain=jimu.com; path=/blog; Expires=Wed, 21 Oct 2015 07:28:00 GMT; Secure; HttpOnly
复制代码
```

那我想一次多 set 几个 cookie 怎么办？多给几个 Set-Cookie 头（一次 HTTP 请求中允许重复）

```css
Set-Cookie: username=jimu; domain=jimu.comSet-Cookie: height=180; domain=me.jimu.comSet-Cookie: weight=80; domain=me.jimu.com
复制代码
```

HTTP 请求的 Cookie 头用于浏览器把符合当前「空间、时间、使用方式」配置的所有 cookie 一并发给服务端。因为由浏览器做了筛选判断，就不需要归还配置内容了，只要发送键值就可以。

```ini
Cookie: username=jimu; height=180; weight=80
复制代码
```

**前端对 cookie 的读写**

前端可以自己创建 cookie，如果服务端创建的 cookie 没加HttpOnly，那恭喜你也可以修改他给的 cookie。调用document.cookie可以创建、修改 cookie，和 HTTP 一样，一次document.cookie能且只能操作一个 cookie。

```ini
document.cookie = 'username=jimu; domain=jimu.com; path=/blog; Expires=Wed, 21 Oct 2015 07:28:00 GMT; Secure; HttpOnly';
复制代码
```

调用document.cookie也可以读到 cookie，也和 HTTP 一样，能读到所有的非HttpOnly cookie。

```javascript
console.log(document.cookie);// username=jimu; height=180; weight=80
复制代码
```

（就一个 cookie 属性，为什么读写行为不一样？get / set 了解下）

**cookie 是维持 HTTP 请求状态的基石**

了解了 cookie 后，我们知道 cookie 是最便捷的维持 HTTP 请求状态的方式，大多数前端鉴权问题都是靠 cookie 解决的。当然也可以选用别的存储方式（后面也会多多少少提到）。那有了存储工具，接下来怎么做呢？

### 3、应用方案：服务端 session

现在回想下，你刷卡的时候发生了什么？

其实你的卡上只存了一个 id（可能是你的学号），刷的时候物业系统去查你的信息、账户，再决定「这个门你能不能进」「这个鸡腿去哪个账户扣钱」。

这种操作，在前后端鉴权系统中，叫 session。典型的 session 登陆/验证流程：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d17f731477a343faa4adaf139651285e~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

- 浏览器登录发送账号密码，服务端查用户库，校验用户

- 服务端把用户登录状态存为 Session，生成一个 sessionId

- 通过登录接口返回，把 sessionId set 到 cookie 上

- 此后浏览器再请求业务接口，sessionId 随 cookie 带上

- 服务端查 sessionId 校验 session

- 成功后正常做业务处理，返回结果

**Session 的存储方式**

显然，服务端只是给 cookie 一个 sessionId，而 session 的具体内容（可能包含用户信息、session 状态等），要自己存一下。存储的方式有几种：

- Redis（推荐）：内存型数据库。以 key-value 的形式存，正合 sessionId-sessionData 的场景；且访问快。

- 内存：直接放到变量里。一旦服务重启就没了

- 数据库：普通数据库。性能不高。

**Session 的过期和销毁**

很简单，只要把存储的 session 数据销毁就可以。

**Session 的分布式问题**

通常服务端是集群，而用户请求过来会走一次负载均衡，不一定打到哪台机器上。那一旦用户后续接口请求到的机器和他登录请求的机器不一致，或者登录请求的机器宕机了，session 不就失效了吗？这个问题现在有几种解决方式。

- 一是从「存储」角度，把 session 集中存储。如果我们用独立的 Redis 或普通数据库，就可以把 session 都存到一个库里。

- 二是从「分布」角度，让相同 IP 的请求在负载均衡时都打到同一台机器上。以 nginx 为例，可以配置 ip_hash 来实现。

但通常还是采用第一种方式，因为第二种相当于阉割了负载均衡，且仍没有解决「用户请求的机器宕机」的问题。

**node.js 下的 session 处理**

前面的图很清楚了，服务端要实现对 cookie 和 session 的存取，实现起来要做的事还是很多的。在npm中，已经有封装好的中间件，比如 express-session - npm，用法就不贴了。这是它种的 cookie：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/358b1a38713d4eeeb6f06ea7bb8f97fd~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

express-session - npm 主要实现了：

- 封装了对cookie的读写操作，并提供配置项配置字段、加密方式、过期时间等。

- 封装了对session的存取操作，并提供配置项配置session存储方式（内存/redis）、存储规则等。

- 给req提供了session属性，控制属性的set/get并响应到cookie和session存取上，并给req.session提供了一些方法。

### 4、应用方案：token

session 的维护给服务端造成很大困扰，我们必须找地方存放它，又要考虑分布式的问题，甚至要单独为了它启用一套 Redis 集群。有没有更好的办法？

我又想到学校，在没有校园卡技术以前，我们都靠「学生证」。门卫小哥直接对照我和学生证上的脸，确认学生证有效期、年级等信息，就可以放行了。

回过头来想想，一个登录场景，也不必往 session 存太多东西，那为什么不直接打包到 cookie 中呢？这样服务端不用存了，每次只要核验 cookie 带的「证件」有效性就可以了，也可以携带一些轻量的信息。这种方式通常被叫做 token。

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6e25dd23718c482ebe51a51a2e1746f3~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

token 的流程是这样的：

- 用户登录，服务端校验账号密码，获得用户信息

- 把用户信息、token 配置编码成 token，通过 cookie set 到浏览器

- 此后用户请求业务接口，通过 cookie 携带 token

- 接口校验 token 有效性，进行正常业务接口处理

**客户端 token 的存储方式**

在前面 cookie 说过，cookie 并不是客户端存储凭证的唯一方式。token 因为它的「无状态性」，有效期、使用限制都包在 token 内容里，对 cookie 的管理能力依赖较小，客户端存起来就显得更自由。但 web 应用的主流方式仍是放在 cookie 里，毕竟少操心。

**token 的过期**

那我们如何控制 token 的有效期呢？很简单，把「过期时间」和数据一起塞进去，验证时判断就好。

**token的编码**

编码的方式丰俭由人。

**base64**

比如 node 端的 cookie-session - npm 库

不要纠结名字，其实是个 token 库，但保持了和 express-session - npm 高度一致的用法，把要存的数据挂在 session 上

默认配置下，当我给他一个 userid，他会存成这样：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ff19419925e84823a845001dafe354d8~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

这里的 eyJ1c2VyaWQiOiJhIn0=，就是 {"userid":"abb”} 的 base64 而已。

**防篡改**

那问题来了，如果用户 cdd 拿{"userid":"abb”}转了个 base64，再手动修改了自己的 token 为 eyJ1c2VyaWQiOiJhIn0=，是不是就能直接访问到 abb 的数据了？

是的。所以看情况，如果 token 涉及到敏感权限，就要想办法避免 token 被篡改。解决方案就是给 token 加签名，来识别 token 是否被篡改过。例如在 cookie-session - npm 库中，增加两项配置：

```arduino
secret: 'iAmSecret',signed: true,
复制代码
```

这样会多种一个 .sig cookie，里面的值就是 {"userid":"abb”} 和 iAmSecret通过加密算法计算出来的，常见的比如HMACSHA256 类 (System.Security.Cryptography) | Microsoft Docs。

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/aa4f1401b1f0498fba007015606e3861~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

好了，现在 cdd 虽然能伪造出eyJ1c2VyaWQiOiJhIn0=，但伪造不出 sig 的内容，因为他不知道 secret。

**JWT**

但上面的做法额外增加了 cookie 数量，数据本身也没有规范的格式，所以 JSON Web Token Introduction - jwt.io 横空出世了。

JSON Web Token (JWT) 是一个开放标准，定义了一种传递 JSON 信息的方式。这些信息通过数字签名确保可信。

它是一种成熟的 token 字符串生成方案，包含了我们前面提到的数据、签名。不如直接看一下一个 JWT token 长什么样：

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiJhIiwiaWF0IjoxNTUxOTUxOTk4fQ.2jf3kl_uKWRkwjOP6uQRJFqMlwSABcgqqcJofFH5XCo
复制代码
```

这串东西是怎么生成的呢？看图：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f05dd31eb2a8483d843e0fee6790ac6a~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

类型、加密算法的选项，以及 JWT 标准数据字段，可以参考 RFC 7519 - JSON Web Token (JWT)node 上同样有相关的库实现：express-jwt - npm koa-jwt - npm

**refresh token**

token，作为权限守护者，最重要的就是「安全」。业务接口用来鉴权的 token，我们称之为 access token。越是权限敏感的业务，我们越希望 access token 有效期足够短，以避免被盗用。但过短的有效期会造成 access token 经常过期，过期后怎么办呢？一种办法是，让用户重新登录获取新 token，显然不够友好，要知道有的 access token 过期时间可能只有几分钟。另外一种办法是，再来一个 token，一个专门生成 access token 的 token，我们称为 refresh token。

- access token 用来访问业务接口，由于有效期足够短，盗用风险小，也可以使请求方式更宽松灵活

- refresh token 用来获取 access token，有效期可以长一些，通过独立服务和严格的请求方式增加安全性；由于不常验证，也可以如前面的 session 一样处理

有了 refresh token 后，几种情况的请求流程变成这样：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a6550d6972c743f085e704f0c3ce8185~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

如果 refresh token 也过期了，就只能重新登录了。

**session 和 token**

session 和 token 都是边界很模糊的概念，就像前面说的，refresh token 也可能以 session 的形式组织维护。狭义上，我们通常认为 session 是「种在 cookie 上、数据存在服务端」的认证方案，token 是「客户端存哪都行、数据存在 token 里」的认证方案。对 session 和 token 的对比本质上是「客户端存 cookie / 存别地儿」、「服务端存数据 / 不存数据」的对比。

**客户端存 cookie / 存别地儿**

存 cookie 固然方便不操心，但问题也很明显：

- 在浏览器端，可以用 cookie（实际上 token 就常用 cookie），但出了浏览器端，没有 cookie 怎么办？

- cookie 是浏览器在域下自动携带的，这就容易引发 CSRF 攻击（前端安全系列（二）：如何防止CSRF攻击？- 美团技术团队）

存别的地方，可以解决没有 cookie 的场景；通过参数等方式手动带，可以避免 CSRF 攻击。

**服务端存数据 / 不存数据**

- 存数据：请求只需携带 id，可以大幅缩短认证字符串长度，减小请求体积

- 不存数据：不需要服务端整套的解决方案和分布式处理，降低硬件成本；避免查库带来的验证延迟

### 5、单点登录

前面我们已经知道了，在同域下的客户端/服务端认证系统中，通过客户端携带凭证，维持一段时间内的登录状态。但当我们业务线越来越多，就会有更多业务系统分散到不同域名下，就需要「一次登录，全线通用」的能力，叫做「单点登录」。

“虚假”的单点登录（主域名相同）

简单的，如果业务系统都在同一主域名下，比如wenku.baidu.com tieba.baidu.com，就好办了。可以直接把 cookie domain 设置为主域名 baidu.com，百度也就是这么干的。

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1970dce978c847929d08027b8561172c~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

**“真实”的单点登录（主域名不同）**

比如滴滴这么潮的公司，同时拥有didichuxing.com xiaojukeji.com didiglobal.com等域名，种 cookie 是完全绕不开的。这要能实现「一次登录，全线通用」，才是真正的单点登录。这种场景下，我们需要独立的认证服务，通常被称为 SSO。**「一次「从 A 系统引发登录，到 B 系统不用登录」的完整流程」**

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e644e70e293b42d39f264303ee844ca2~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

- 用户进入 A 系统，没有登录凭证（ticket），A 系统给他跳到 SSO

- SSO 没登录过，也就没有 sso 系统下没有凭证（注意这个和前面 A ticket 是两回事），输入账号密码登录

- SSO 账号密码验证成功，通过接口返回做两件事：一是种下 sso 系统下凭证（记录用户在 SSO 登录状态）；二是下发一个 ticket

- 客户端拿到 ticket，保存起来，带着请求系统 A 接口

- 系统 A 校验 ticket，成功后正常处理业务请求

- 此时用户第一次进入系统 B，没有登录凭证（ticket），B 系统给他跳到 SSO

- SSO 登录过，系统下有凭证，不用再次登录，只需要下发 ticket

- 客户端拿到 ticket，保存起来，带着请求系统 B 接口

**完整版本：考虑浏览器的场景**

上面的过程看起来没问题，实际上很多 APP 等端上这样就够了。但在浏览器下不见得好用。看这里：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/86a16c79f1c24fbe93260b7a748a8f01~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

对浏览器来说，SSO 域下返回的数据要怎么存，才能在访问 A 的时候带上？浏览器对跨域有严格限制，cookie、localStorage 等方式都是有域限制的。这就需要也只能由 A 提供 A 域下存储凭证的能力。一般我们是这么做的：

![图片](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/908cc7ee57824d36ba711e72ace3e538~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp)

图中我们通过颜色把浏览器当前所处的域名标记出来。注意图中灰底文字说明部分的变化。

- 在 SSO 域下，SSO 不是通过接口把 ticket 直接返回，而是通过一个带 code 的 URL 重定向到系统 A 的接口上，这个接口通常在 A 向 SSO 注册时约定

- 浏览器被重定向到 A 域下，带着 code 访问了 A 的 callback 接口，callback 接口通过 code 换取 ticket

- 这个 code 不同于 ticket，code 是一次性的，暴露在 URL 中，只为了传一下换 ticket，换完就失效。

- callback 接口拿到 ticket 后，在自己的域下 set cookie 成功

- 在后续请求中，只需要把 cookie 中的 ticket 解析出来，去 SSO 验证就好

- 访问 B 系统也是一样

### 6、总结

- HTTP 是无状态的，为了维持前后请求，需要前端存储标记

- cookie 是一种完善的标记方式，通过 HTTP 头或 js 操作，有对应的安全策略，是大多数状态管理方案的基石

- session 是一种状态管理方案，前端通过 cookie 存储 id，后端存储数据，但后端要处理分布式问题

- token 是另一种状态管理方案，相比于 session 不需要后端存储，数据全部存在前端，解放后端，释放灵活性

- token 的编码技术，通常基于 base64，或增加加密算法防篡改，jwt 是一种成熟的编码方案

- 在复杂系统中，token 可通过 service token、refresh token 的分权，同时满足安全性和用户体验

- session 和 token 的对比就是「用不用cookie」和「后端存不存」的对比

- 单点登录要求不同域下的系统「一次登录，全线通用」，通常由独立的 SSO 系统记录登录状态、下发 ticket，各业务系统配合存储和认证 ticket

## 秘钥

### 秘钥如何安全存储

- 难以记忆的密钥可用加密形式存储，利用密钥加密密钥来做。如 RSA 的秘密钥可用 DES 加密后存入硬盘，用户须有 DES 密钥，运行解密程序才能将其恢复。
