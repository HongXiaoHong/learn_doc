# java web

servlet 规范中的三大组件，分别是 servlet、filter、listener

JavaWeb项目经历的阶段：
        1、Servlet + JSP / Servlet + 模板引擎，该阶段XML配置很少，但是需要从基础代码开始编写；
        2、SSH(Spring/Struts2/Hibernate) / SSM(Spring/SpringMVC/Mybatis)，该阶段无需从基础代码开始编写，但是需要大量的XML配置；
        3、SSM，该阶段无需从基础代码开始编写，采用注解+XML配置；
        4、SpringBoot，零配置（XML），采用注解+yml配置；
原文链接：https://blog.csdn.net/ligonglanyuan/article/details/124787811

## ContextLoaderListener解析
https://www.jianshu.com/p/523bfddf0810

### 过滤器 和 拦截器的 6个区别

[过滤器与拦截器的区别及使用场景 - 掘金](https://juejin.cn/post/6989529144535023629)

- **触发时机不同** 过滤器Filter是在请求进入容器后，但在进入servlet之前进行预处理，请求结束是在servlet处理完以后

拦截器 Interceptor 是在请求进入servlet后，在进入Controller之前进行预处理的，Controller 中渲染了对应的视图之后请求结束

- **拦截的请求范围不同** 过滤器几乎可以对所有进入容器的请求起作用，而拦截器只会对Controller中请求或访问static目录下的资源请求起作用

- **注入Bean情况不同** 我们分别在过滤器和拦截器中都注入service，过滤器中注入service，发起请求方法正常，而拦截器中注入service，发起请求方法报错，这是因为加载顺序导致的问题，拦截器加载的时间点在springcontext之前，而Bean又是由spring进行管理

解决方案也很简单，我们在注册拦截器之前，先将Interceptor 手动进行注入。注意：在registry.addInterceptor()注册的是getMyInterceptor() 实例

- **控制执行顺序不同** 过滤器用@Order注解控制执行顺序，通过@Order控制过滤器的级别，值越小级别越高越先执行

### 过滤器与拦截器使用场景

1、日志记录：记录请求信息的日志，以便进行信息监控、信息统计、计算PV（Page View）等

2、权限检查：如登录检测，进入处理器检测检测是否登录，如果没有直接返回到登录页面

3、性能监控：有时候系统在某段时间莫名其妙的慢，可以通过拦截器在进入处理器之前记录开始时间，在处理完后记录结束时间，从而得到该请求的处理时间（如果有反向代理，如apache可以自动记录）

4、通用行为：读取cookie得到用户信息并将用户对象放入请求，从而方便后续流程使用，还有如提取Locale、Theme信息等，只要是多个处理器都需要的即可使用拦截器实现

作者：小小程序猿_肥牛  

[(19条消息) 过滤器 和 拦截器的 6个区别，别再傻傻分不清了_过滤器和拦截器区别_程序员小富的博客-CSDN博客](https://blog.csdn.net/xinzhifu1/article/details/106356958)

我觉得更加通俗易懂的理解

<mark>你自己本身的业务系统用拦截器和过滤器都可以。我这里说一下为什么spring security使用过滤器而不是拦截器。因为作为一个通用的安全框架不应该耦合其他web框架的元素。很显然拦截器是spring mvc或struts等框架提供的，如果基于拦截器势必耦合这些框架，就做不到通用了</mark>。

作者：Java全栈老猿  
链接：https://www.zhihu.com/question/443466900/answer/1724283014  
来源：知乎  
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

作者：小露分享吧  
链接：https://www.zhihu.com/question/443466900/answer/3123180025  
来源：知乎  
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。  

小朝：嘿，小露！最近我在学习Spring Boot，发现它提供了拦截器和过滤器这两个功能来处理请求。你能帮我总结一下它们的使用和区别吗？我有点分不清了。

[小露](https://www.zhihu.com/search?q=%E5%B0%8F%E9%9C%B2&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A3123180025%7D)：当然可以！拦截器和过滤器都是用于在请求到达控制器之前或之后执行一些逻辑。不过它们在实现方式和功能上存在一些差异。

小朝：哦，那它们之间具体有哪些**区别**呢？

小露：首先，拦截器是基于**Java反射机制**实现的，而过滤器是基于**Servlet规范**实现的。这意味着拦截器可以更方便地访问Spring容器和Spring的特性，而过滤器则更加独立，不依赖于Spring。

小朝：明白了，那在使用上有什么区别吗？

小露：在使用上，拦截器是通过**实现HandlerInterceptor接口**来创建的，并且可以细粒度地控制拦截路径。而过滤器是通过**实现javax.servlet.Filter接口**来创建的，并且对所有请求都生效。

在Spring Boot中，使用拦截器和过滤器非常简单。下面我将分别介绍如何在Spring Boot中使用拦截器和过滤器。

### **使用拦截器：**

```java
1.创建一个类实现HandlerInterceptor接口，该接口包含了三个方法：preHandle、postHandle和afterCompletion，分别对应请求的前置处理、后置处理和完成后的处理。
 import org.springframework.web.servlet.HandlerInterceptor;
 import org.springframework.web.servlet.ModelAndView;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 ​
 public class MyInterceptor implements HandlerInterceptor {
 ​
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
  // 在请求处理之前进行逻辑处理，返回true表示继续执行请求，返回false表示中断请求
  // 可以在此处进行认证、授权等操作
  return true;
     }
 ​
  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
    ModelAndView modelAndView) throws Exception {
  // 在请求处理之后进行逻辑处理，可以修改ModelAndView中的数据
     }
 ​
  @Override
  public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) 
  throws Exception {
  // 在请求完成后进行逻辑处理，可以处理一些资源清理操作
     }
 }

2.在配置类中注册拦截器。
 import org.springframework.context.annotation.Configuration;
 import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
 import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
 ​
 @Configuration
 public class AdminWebConfig implements WebMvcConfigurer {
 ​
  @Override
  public void addInterceptors(InterceptorRegistry registry) {
  registry.addInterceptor(new LoginInterceptor())
                 .addPathPatterns("/**")  //所有请求都被拦截包括静态资源
                 .excludePathPatterns("/","/login""); //放行的请求
     }
 }
这里我们将自定义的拦截器添加到了所有请求路径上，你可以根据需求自行配置。
```

### **使用过滤器：**

```java
1.创建一个类实现javax.servlet.Filter接口，该接口包含了一个doFilter方法，用于处理请求。
 import javax.servlet.*;
 import javax.servlet.annotation.WebFilter;
 import java.io.IOException;
 ​
 @WebFilter(urlPatterns = "/*")
 public class MyFilter implements Filter {
 ​
  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
  // 在请求处理之前进行逻辑处理
  // 可以在此处进行请求预处理、资源保护、请求转发等操作
  chain.doFilter(request, response);
  // 在请求处理之后进行逻辑处理
     }
 ​
  @Override
  public void init(FilterConfig filterConfig) throws ServletException {
  // 初始化操作，可选
     }
 ​
  @Override
  public void destroy() {
  // 销毁操作，可选
     }
 }

2.在启动类上添加注解@ServletComponentScan，以使过滤器生效。
 import org.springframework.boot.SpringApplication;
 import org.springframework.boot.autoconfigure.SpringBootApplication;
 import org.springframework.boot.web.servlet.ServletComponentScan;
 ​
 @ServletComponentScan
 @SpringBootApplication
 public class Application {
 ​
  public static void main(String[] args) {
  SpringApplication.run(Application.class, args);
     }
 }
这样，你就可以在Spring Boot中使用拦截器和过滤器了。
```

小朝：那么，他们的执行顺序呢？

小露：拦截器是在进入控制器[之前和之后](https://www.zhihu.com/search?q=%E4%B9%8B%E5%89%8D%E5%92%8C%E4%B9%8B%E5%90%8E&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A3123180025%7D)执行的，可以对请求进行前置处理和后置处理。而过滤器是在请求进入Servlet容器之前和之后执行的，对请求进行预处理和后处理。

小朝：我明白了，那么在实际应用中，我们应该如何选择拦截器和过滤器呢？

小露：一般来说，如果只是需要对请求进行简单的预处理或后处理，可以选择使用过滤器。而如果需要更加**细粒度**的控制，并且需要使用**Spring容器的特性**，可以选择使用拦截器。

小朝：好的，我大概明白了，门清。

# 常见问题

## 前端鉴权必须了解的5个兄弟：cookie、session、token、jwt、单点登录

- 基于 HTTP 的前端鉴权背景

- cookie 为什么是最方便的存储方案，有哪些操作 cookie 的方式

- session 方案是如何实现的，存在哪些问题

- token 方案是如何实现的，如何进行编码和防篡改？jwt 是做什么的？refresh token 的实现和意义

- session 和 token 有什么异同和优缺点

- 单点登录是什么？实现思路和在浏览器下的处理

---

### 从状态说起

「HTTP 无状态」**我们知道，HTTP 是无状态的。也就是说，HTTP 请求方和响应方间无法维护状态，都是一次性的，它不知道前后的请求都发生了什么。但有的场景下，我们需要维护状态。最典型的，一个用户登陆微博，发布、关注、评论，都应是在登录后的用户状态下的。**「标记」那解决办法是什么呢？::标记::。

> 在学校或公司，入学入职那一天起，会录入你的身份、账户信息，然后给你发个卡，今后在园区内，你的门禁、打卡、消费都只需要刷这张卡。

**「前端存储」**这就涉及到一发、一存、一带，发好办，登陆接口直接返回给前端，存储就需要前端想办法了。

> 前提是，你要把卡带在身上。

前端的存储方式有很多。

- 最矬的，挂到全局变量上，但这是个「体验卡」，一次刷新页面就没了

- 高端点的，存到 cookie、localStorage 等里，这属于「会员卡」，无论怎么刷新，只要浏览器没清掉或者过期，就一直拿着这个状态。

前端存储这里不展开了。有地方存了，请求的时候就可以拼到参数里带给接口了。

### 基石：cookie

> 可是前端好麻烦啊，又要自己存，又要想办法带出去，有没有不用操心的？

有，cookie。cookie 也是前端存储的一种，但相比于 localStorage 等其他方式，借助 HTTP 头、浏览器能力，cookie 可以做到前端无感知。一般过程是这样的：

- 在提供标记的接口，通过 HTTP 返回头的 Set-Cookie 字段，直接「种」到浏览器上

- 浏览器发起请求时，会自动把 cookie 通过 HTTP 请求头的 Cookie 字段，带给接口

**「配置：Domain / Path」**

> 你不能拿清华的校园卡进北大。

cookie 是要限制::「空间范围」::的，通过 Domain（域）/ Path（路径）两级。

> Domain属性指定浏览器发出 HTTP 请求时，哪些域名要附带这个 Cookie。如果没有指定该属性，浏览器会默认将其设为当前 URL 的一级域名，比如 www.example.com 会设为 example.com，而且以后如果访问example.com的任何子域名，HTTP 请求也会带上这个 Cookie。如果服务器在Set-Cookie字段指定的域名，不属于当前域名，浏览器会拒绝这个 Cookie。Path属性指定浏览器发出 HTTP 请求时，哪些路径要附带这个 Cookie。只要浏览器发现，Path属性是 HTTP 请求路径的开头一部分，就会在头信息里面带上这个 Cookie。比如，PATH属性是/，那么请求/docs路径也会包含该 Cookie。当然，前提是域名必须一致。—— Cookie — JavaScript 标准参考教程（alpha）

**「配置：Expires / Max-Age」**

> 你毕业了卡就不好使了。

cookie 还可以限制::「时间范围」::，通过 Expires、Max-Age 中的一种。

> Expires属性指定一个具体的到期时间，到了指定时间以后，浏览器就不再保留这个 Cookie。它的值是 UTC 格式。如果不设置该属性，或者设为null，Cookie 只在当前会话（session）有效，浏览器窗口一旦关闭，当前 Session 结束，该 Cookie 就会被删除。另外，浏览器根据本地时间，决定 Cookie 是否过期，由于本地时间是不精确的，所以没有办法保证 Cookie 一定会在服务器指定的时间过期。Max-Age属性指定从现在开始 Cookie 存在的秒数，比如60 * 60 * 24 * 365（即一年）。过了这个时间以后，浏览器就不再保留这个 Cookie。如果同时指定了Expires和Max-Age，那么Max-Age的值将优先生效。如果Set-Cookie字段没有指定Expires或Max-Age属性，那么这个 Cookie 就是 Session Cookie，即它只在本次对话存在，一旦用户关闭浏览器，浏览器就不会再保留这个 Cookie。—— Cookie — JavaScript 标准参考教程（alpha）

**「配置：Secure / HttpOnly」**

> 有的学校规定，不带卡套不让刷（什么奇葩学校，假设）；有的学校不让自己给卡贴贴纸。

cookie 可以限制::「使用方式」::。

> Secure属性指定浏览器只有在加密协议 HTTPS 下，才能将这个 Cookie 发送到服务器。另一方面，如果当前协议是 HTTP，浏览器会自动忽略服务器发来的Secure属性。该属性只是一个开关，不需要指定值。如果通信是 HTTPS 协议，该开关自动打开。HttpOnly属性指定该 Cookie 无法通过 JavaScript 脚本拿到，主要是Document.cookie属性、XMLHttpRequest对象和 Request API 都拿不到该属性。这样就防止了该 Cookie 被脚本读到，只有浏览器发出 HTTP 请求时，才会带上该 Cookie。—— Cookie — JavaScript 标准参考教程（alpha）

**「HTTP 头对 cookie 的读写」**回过头来，HTTP 是如何写入和传递 cookie 及其配置的呢？HTTP 返回的一个 Set-Cookie 头用于向浏览器写入「一条（且只能是一条）」cookie，格式为 cookie 键值 + 配置键值。例如：

```
Set-Cookie: username=jimu; domain=jimu.com; path=/blog; Expires=Wed, 21 Oct 2015 07:28:00 GMT; Secure; HttpOnly 
```

那我想一次多 set 几个 cookie 怎么办？多给几个 Set-Cookie 头（一次 HTTP 请求中允许重复）

```
Set-Cookie: username=jimu; domain=jimu.comSet-Cookie: height=180; domain=me.jimu.comSet-Cookie: weight=80; domain=me.jimu.com 
```

HTTP 请求的 Cookie 头用于浏览器把符合当前「空间、时间、使用方式」配置的所有 cookie 一并发给服务端。因为由浏览器做了筛选判断，就不需要归还配置内容了，只要发送键值就可以。

```
Cookie: username=jimu; height=180; weight=80 
```

**「前端对 cookie 的读写」**前端可以自己创建 cookie，如果服务端创建的 cookie 没加`HttpOnly`，那恭喜你也可以修改他给的 cookie。调用`document.cookie`可以创建、修改 cookie，和 HTTP 一样，一次`document.cookie`能且只能操作一个 cookie。

```
document.cookie = 'username=jimu; domain=jimu.com; path=/blog; Expires=Wed, 21 Oct 2015 07:28:00 GMT; Secure; HttpOnly'; 
```

调用`document.cookie`也可以读到 cookie，也和 HTTP 一样，能读到所有的非`HttpOnly` cookie。

```
console.log(document.cookie);// username=jimu; height=180; weight=80 
```

（就一个 cookie 属性，为什么读写行为不一样？get / set 了解下）「cookie 是维持 HTTP 请求状态的基石」了解了 cookie 后，我们知道 cookie 是最便捷的维持 HTTP 请求状态的方式，大多数前端鉴权问题都是靠 cookie 解决的。当然也可以选用别的存储方式（后面也会多多少少提到）。那有了存储工具，接下来怎么做呢？

### 应用方案：服务端 session

现在回想下，你刷卡的时候发生了什么？

> 其实你的卡上只存了一个 id（可能是你的学号），刷的时候物业系统去查你的信息、账户，再决定「这个门你能不能进」「这个鸡腿去哪个账户扣钱」。

这种操作，在前后端鉴权系统中，叫 session。典型的 session 登陆/验证流程：

![前端鉴权必须了解的图片](http://www.guilincode.com/uploads/allimg/210909/22502KD2-0.jpg)

- 浏览器登录发送账号密码，服务端查用户库，校验用户

- 服务端把用户登录状态存为 Session，生成一个 sessionId

- 通过登录接口返回，把 sessionId set 到 cookie 上

- 此后浏览器再请求业务接口，sessionId 随 cookie 带上

- 服务端查 sessionId 校验 session

- 成功后正常做业务处理，返回结果

**「Session 的存储方式」**显然，服务端只是给 cookie 一个 sessionId，而 session 的具体内容（可能包含用户信息、session 状态等），要自己存一下。存储的方式有几种：

- Redis（推荐）：内存型数据库，redis中文官方网站。以 key-value 的形式存，正合 sessionId-sessionData 的场景；且访问快。

- 内存：直接放到变量里。一旦服务重启就没了

- 数据库：普通数据库。性能不高。

「Session 的过期和销毁」**很简单，只要把存储的 session 数据销毁就可以。****「Session 的分布式问题」**通常服务端是集群，而用户请求过来会走一次负载均衡，不一定打到哪台机器上。那一旦用户后续接口请求到的机器和他登录请求的机器不一致，或者登录请求的机器宕机了，session 不就失效了吗？这个问题现在有几种解决方式。

- 一是从「存储」角度，把 session 集中存储。如果我们用独立的 Redis 或普通数据库，就可以把 session 都存到一个库里。

- 二是从「分布」角度，让相同 IP 的请求在负载均衡时都打到同一台机器上。以 nginx 为例，可以配置 ip_hash 来实现。

但通常还是采用第一种方式，因为第二种相当于阉割了负载均衡，且仍没有解决「用户请求的机器宕机」的问题。**「node.js 下的 session 处理」**前面的图很清楚了，服务端要实现对 cookie 和 session 的存取，实现起来要做的事还是很多的。在`npm`中，已经有封装好的中间件，比如 express-session - npm，用法就不贴了。这是它种的 cookie：

![图片前端鉴权必须了解的](http://www.guilincode.com/uploads/allimg/210909/22502J442-1.jpg)

express-session - npm 主要实现了：

- 封装了对cookie的读写操作，并提供配置项配置字段、加密方式、过期时间等。

- 封装了对session的存取操作，并提供配置项配置session存储方式（内存/redis）、存储规则等。

- 给req提供了session属性，控制属性的set/get并响应到cookie和session存取上，并给req.session提供了一些方法。

---

#### 应用方案：token

session 的维护给服务端造成很大困扰，我们必须找地方存放它，又要考虑分布式的问题，甚至要单独为了它启用一套 Redis 集群。有没有更好的办法？

> 我又想到学校，在没有校园卡技术以前，我们都靠「学生证」。门卫小哥直接对照我和学生证上的脸，确认学生证有效期、年级等信息，就可以放行了。

回过头来想想，一个登录场景，也不必往 session 存太多东西，那为什么不直接打包到 cookie 中呢？这样服务端不用存了，每次只要核验 cookie 带的「证件」有效性就可以了，也可以携带一些轻量的信息。这种方式通常被叫做 token。

![前端鉴权必须了解的图片](http://www.guilincode.com/uploads/allimg/210909/22502HK1-2.jpg)

token 的流程是这样的：

- 用户登录，服务端校验账号密码，获得用户信息

- 把用户信息、token 配置编码成 token，通过 cookie set 到浏览器

- 此后用户请求业务接口，通过 cookie 携带 token

- 接口校验 token 有效性，进行正常业务接口处理

**「客户端 token 的存储方式」****在前面 cookie 说过，cookie 并不是客户端存储凭证的唯一方式。token 因为它的「无状态性」，有效期、使用限制都包在 token 内容里，对 cookie 的管理能力依赖较小，客户端存起来就显得更自由。但 web 应用的主流方式仍是放在 cookie 里，毕竟少操心。****「token 的过期」**那我们如何控制 token 的有效期呢？很简单，把「过期时间」和数据一起塞进去，验证时判断就好。

### token 的编码

编码的方式丰俭由人。**「base64」**比如 node 端的 cookie-session - npm 库

> 不要纠结名字，其实是个 token 库，但保持了和 express-session - npm 高度一致的用法，把要存的数据挂在 session 上

默认配置下，当我给他一个 userid，他会存成这样：

![图片](http://www.guilincode.com/uploads/allimg/210909/22502H463-3.jpg)

这里的 `eyJ1c2VyaWQiOiJhIn0=`，就是 `{"userid":"abb”}` 的 base64 而已。**「防篡改」**

> 那问题来了，如果用户 cdd 拿`{"userid":"abb”}`转了个 base64，再手动修改了自己的 token 为 `eyJ1c2VyaWQiOiJhIn0=`，是不是就能直接访问到 abb 的数据了？

是的。所以看情况，如果 token 涉及到敏感权限，就要想办法避免 token 被篡改。解决方案就是给 token 加签名，来识别 token 是否被篡改过。例如在 cookie-session - npm 库中，增加两项配置：

```
secret: 'iAmSecret',signed: true, 
```

这样会多种一个 .sig cookie，里面的值就是 `{"userid":"abb”}` 和 `iAmSecret`通过加密算法计算出来的，常见的比如HMACSHA256 类 (System.Security.Cryptography) | Microsoft Docs。

![图片](http://www.guilincode.com/uploads/allimg/210909/22502I409-4.jpg)

好了，现在 cdd 虽然能伪造出`eyJ1c2VyaWQiOiJhIn0=`，但伪造不出 sig 的内容，因为他不知道 secret。**「JWT」**但上面的做法额外增加了 cookie 数量，数据本身也没有规范的格式，所以 JSON Web Token Introduction - jwt.io 横空出世了。

> JSON Web Token (JWT) 是一个开放标准，定义了一种传递 JSON 信息的方式。这些信息通过数字签名确保可信。

它是一种成熟的 token 字符串生成方案，包含了我们前面提到的数据、签名。不如直接看一下一个 JWT token 长什么样：

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiJhIiwiaWF0IjoxNTUxOTUxOTk4fQ.2jf3kl_uKWRkwjOP6uQRJFqMlwSABcgqqcJofFH5XCo 
```

这串东西是怎么生成的呢？看图：

![图片](http://www.guilincode.com/uploads/allimg/210909/22502J634-5.jpg)

类型、加密算法的选项，以及 JWT 标准数据字段，可以参考 RFC 7519 - JSON Web Token (JWT)node 上同样有相关的库实现：express-jwt - npm koa-jwt - npm

### refresh token

token，作为权限守护者，最重要的就是「安全」。业务接口用来鉴权的 token，我们称之为 access token。越是权限敏感的业务，我们越希望 access token 有效期足够短，以避免被盗用。但过短的有效期会造成 access token 经常过期，过期后怎么办呢？一种办法是，让用户重新登录获取新 token，显然不够友好，要知道有的 access token 过期时间可能只有几分钟。另外一种办法是，再来一个 token，一个专门生成 access token 的 token，我们称为 refresh token。

- access token 用来访问业务接口，由于有效期足够短，盗用风险小，也可以使请求方式更宽松灵活

- refresh token 用来获取 access token，有效期可以长一些，通过独立服务和严格的请求方式增加安全性；由于不常验证，也可以如前面的 session 一样处理

有了 refresh token 后，几种情况的请求流程变成这样：

![图片](http://www.guilincode.com/uploads/allimg/210909/22502G1R-6.jpg)

如果 refresh token 也过期了，就只能重新登录了。

### session 和 token

session 和 token 都是边界很模糊的概念，就像前面说的，refresh token 也可能以 session 的形式组织维护。狭义上，我们通常认为 session 是「种在 cookie 上、数据存在服务端」的认证方案，token 是「客户端存哪都行、数据存在 token 里」的认证方案。对 session 和 token 的对比本质上是「客户端存 cookie / 存别地儿」、「服务端存数据 / 不存数据」的对比。**「客户端存 cookie / 存别地儿」**存 cookie 固然方便不操心，但问题也很明显：

- 在浏览器端，可以用 cookie（实际上 token 就常用 cookie），但出了浏览器端，没有 cookie 怎么办？

- cookie 是浏览器在域下自动携带的，这就容易引发 CSRF 攻击（前端安全系列（二）：如何防止CSRF攻击？- 美团技术团队）

存别的地方，可以解决没有 cookie 的场景；通过参数等方式手动带，可以避免 CSRF 攻击。**「服务端存数据 / 不存数据」**

- 存数据：请求只需携带 id，可以大幅缩短认证字符串长度，减小请求体积

- 不存数据：不需要服务端整套的解决方案和分布式处理，降低硬件成本；避免查库带来的验证延迟

---

### 单点登录

前面我们已经知道了，在同域下的客户端/服务端认证系统中，通过客户端携带凭证，维持一段时间内的登录状态。但当我们业务线越来越多，就会有更多业务系统分散到不同域名下，就需要「一次登录，全线通用」的能力，叫做「单点登录」。

#### “虚假”的单点登录（主域名相同）

简单的，如果业务系统都在同一主域名下，比如`wenku.baidu.com` `tieba.baidu.com`，就好办了。可以直接把 cookie domain 设置为主域名 `baidu.com`，百度也就是这么干的。

![图片](http://www.guilincode.com/uploads/allimg/210909/22502J5Z-7.jpg)

#### “真实”的单点登录（主域名不同）

比如滴滴这么潮的公司，同时拥有`didichuxing.com` `xiaojukeji.com` `didiglobal.com`等域名，种 cookie 是完全绕不开的。这要能实现「一次登录，全线通用」，才是真正的单点登录。这种场景下，我们需要独立的认证服务，通常被称为 SSO。**「一次「从 A 系统引发登录，到 B 系统不用登录」的完整流程」**

![图片](http://www.guilincode.com/uploads/allimg/210909/22502HQ1-8.jpg)

- 用户进入 A 系统，没有登录凭证（ticket），A 系统给他跳到 SSO

- SSO 没登录过，也就没有 sso 系统下没有凭证（注意这个和前面 A ticket 是两回事），输入账号密码登录

- SSO 账号密码验证成功，通过接口返回做两件事：一是种下 sso 系统下凭证（记录用户在 SSO 登录状态）；二是下发一个 ticket

- 客户端拿到 ticket，保存起来，带着请求系统 A 接口

- 系统 A 校验 ticket，成功后正常处理业务请求

- 此时用户第一次进入系统 B，没有登录凭证（ticket），B 系统给他跳到 SSO

- SSO 登录过，系统下有凭证，不用再次登录，只需要下发 ticket

- 客户端拿到 ticket，保存起来，带着请求系统 B 接口

**「完整版本：考虑浏览器的场景」**上面的过程看起来没问题，实际上很多 APP 等端上这样就够了。但在浏览器下不见得好用。看这里：

![图片](http://www.guilincode.com/uploads/allimg/210909/22502M1G-9.jpg)

对浏览器来说，SSO 域下返回的数据要怎么存，才能在访问 A 的时候带上？浏览器对跨域有严格限制，cookie、localStorage 等方式都是有域限制的。这就需要也只能由 A 提供 A 域下存储凭证的能力。一般我们是这么做的：

![图片](http://www.guilincode.com/uploads/allimg/210909/22502M0H-10.jpg)

图中我们通过颜色把浏览器当前所处的域名标记出来。注意图中灰底文字说明部分的变化。

- 在 SSO 域下，SSO 不是通过接口把 ticket 直接返回，而是通过一个带 code 的 URL 重定向到系统 A 的接口上，这个接口通常在 A 向 SSO 注册时约定

- 浏览器被重定向到 A 域下，带着 code 访问了 A 的 callback 接口，callback 接口通过 code 换取 ticket

- 这个 code 不同于 ticket，code 是一次性的，暴露在 URL 中，只为了传一下换 ticket，换完就失效

- callback 接口拿到 ticket 后，在自己的域下 set cookie 成功

- 在后续请求中，只需要把 cookie 中的 ticket 解析出来，去 SSO 验证就好

- 访问 B 系统也是一样

---

### 总结

- HTTP 是无状态的，为了维持前后请求，需要前端存储标记

- cookie 是一种完善的标记方式，通过 HTTP 头或 js 操作，有对应的安全策略，是大多数状态管理方案的基石

- session 是一种状态管理方案，前端通过 cookie 存储 id，后端存储数据，但后端要处理分布式问题

- token 是另一种状态管理方案，相比于 session 不需要后端存储，数据全部存在前端，解放后端，释放灵活性

- token 的编码技术，通常基于 base64，或增加加密算法防篡改，jwt 是一种成熟的编码方案

- 在复杂系统中，token 可通过 service token、refresh token 的分权，同时满足安全性和用户体验

- session 和 token 的对比就是「用不用cookie」和「后端存不存」的对比

- 单点登录要求不同域下的系统「一次登录，全线通用」，通常由独立的 SSO 系统记录登录状态、下发 ticket，各业务系统配合存储和认证 ticket

- 


## 重定向

302重定向又称之为暂时性转移(Temporarily Moved )，英文名称：302 redirect。 也被认为是暂时重定向（temporary redirect），一条对网站浏览器的指令来显示浏览器被要求显示的不同的URL，当一个网页经历过短期的URL的变化时使用。

还有一个 301 永久重定向

[springboot跳转到指定页面和（重定向，请求转发的写法）](https://blog.csdn.net/u011066470/article/details/115379182)

2.1 springboot重定向
方式一：使用 "redirect" 关键字（不是指java关键字），注意：类的注解不能使用@RestController，要用@Controller；因为@RestController内含@ResponseBody，解析返回的是json串。不是跳转页面

方式一：使用 "redirect" 关键字（不是指java关键字），注意：类的注解不能使用@RestController，要用@Controller
@RequestMapping(value="/test/test01/{name}" , method = RequestMethod.GET)
public String test(@PathVariable String name) {
  return "redirect:/ceng/hello.html";
}
方式二：使用servlet 提供的API，注意：类的注解可以使用@RestController，也可以使用@Controller 

方式二：使用servlet 提供的API，注意：类的注解可以使用@RestController，也可以使用@Controller
@RequestMapping(value="/test/test01/{name}" , method = RequestMethod.GET)
public void test(@PathVariable String name, HttpServletResponse response) throws IOException {
  response.sendRedirect("/ceng/hello.html");
}