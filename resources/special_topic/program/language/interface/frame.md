# 各大语言接口框架对比

https://developer.mozilla.org/zh-CN/docs/Learn/Server-side/First_steps/Web_frameworks

一些影响你决定的因素有：

学习代价：学习一个 web 框架取决于你对底层语言的熟悉程度，它的 API 的一致性与否，文档质量，社区的体量和活跃程度。如果你完全没有编程基础的话，那就考虑 Django 吧（它是基于上面几条标准来看最容易学习的了）。如果你已经成为开发团队的一部分，而那个开发团队对某一种语言或者某一个框架有着很重要的开发经历，那么就坚持相关框架。
效率：效率是指一旦你熟悉某一个框架之后，你能够多块地创造一个新功能的衡量方式，包括编写和维护代码的代价（因为当前面的功能崩掉之后，你没法编写新的功能）。影响效率的大多数因素和学习代价是类似的——比如，文档，社区，编程经历等等。——其他因素还有：
框架目的/起源：一些框架最初是用来解决某一类特定问题的，并且最好在生成 app 的时候顾及到这些约束。比如，Django 是用来支持新闻网站的，因此非常适合博客或者其他包含发布内容的网站。相反的，Flask 是一个相对来说轻量级的框架，因此适合用来生成一些在嵌入式设备上运行的 app。
Opinionated vs unopinionated：一个 opinionated 的框架是说，解决某一个特定问题时，总有一个被推荐的最佳的解决方法。opinionated 的框架在你试图解决一些普通问题的时候，更加趋向于产品化，因为它们会将你引入正确的方向，尽管有些时候并不那么灵活。
一些 web 框架默认地包含了开发者们能遇到的任何一个问题的工具/库，而一些轻量级的框架希望开发者们自己从分离的库中选择合适的解决方式（Django 是其前者的一个实例，而 Flask 则是轻量级的一个实例）。包含了所有东西的框架通常很容易上手因为你已经有了你所需要的任何东西，并且很可能它已经被整合好了，并且文档也写得很完善。然而一个较小型的框架含有你所需要（或者以后需要）的各种东西，它将只能在受更多限制的环境中运行，并且需要学习更小的、更简单的子集学习。
是否选择一个鼓励良好开发实例的框架：比如，一个鼓励 Model-View-Controller 结构来将代码分离到逻辑函数上的框架将会是更加易于维护的代码，想比与那些对开发者没有此期待的框架而言。同样的，框架设计也深刻影响了测试和重复使用代码的难易程度。
框架/编程语言的表现：通常来讲，“速度”并不是选择中最重要的因素，甚至，相对而言，运行速度很缓慢的 Python 对于一个在中等硬盘上跑的中等大小的网站已经足够了。其他语言（C++/Javascript）的明显的速度优势很有可能被学习和维护的代价给抵消了。
缓存支持：当你的网站之间变得越来越成功之后，你可能会发现它已经无法妥善处理它收到的大量请求了。在这个时候，你可能会开始考虑添加缓存支持。缓存是一种优化，是指你将全部的或者大部分的网站请求保存起来，那么在后继请求中就不需要重新计算了。返回一个缓存请求比重新计算一次要快得多。缓存可以被植入你的代码里面，或者是服务器中（参见反向代理）。web 框架对于定义可缓存内容有着不同程度的支持。
可扩展性：一旦你的网站非常成功的时候，你会发现缓存的好处已经所剩无几了，甚至垂直容量到达了极限（将程序运行在更加有力的硬件上面）。在这个时候，你可能需要水平扩展（将你的网站分散到好几个服务器和数据库上来加载）或者“地理上地”扩展，因为你的一些客户距离你的服务器很远。你所选择的框架将会影响到扩展你的网站的难易程度。
网络安全：一些 web 框架对于解决常见的网络攻击提供更好的支持。例如，Django 消除所有用户从 HTML 输入的东西。因此从用户端输入的 Javascript 不会被运行。其他框架也提供相似的功能，但是通常在默认情况下是不直接开启的。
可能还有其他一些原因，包括许可证、框架是否处于动态发展过程中等等。

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230726163924.png)

java: springboot


## python

python flask/Django

## JavaScript

JavaScript: express

### express
基于 Express 框架，可以快速构建 Web 应用

https://www.expressjs.com.cn/starter/hello-world.html
创建过程:

```bash

D:\documents\projects\github\branch\front_road>mkdir express

D:\documents\projects\github\branch\front_road>cd express

D:\documents\projects\github\branch\front_road\express>npm init
This utility will walk you through creating a package.json file.
It only covers the most common items, and tries to guess sensible defaults.

See `npm help init` for definitive documentation on these fields
and exactly what they do.

Use `npm install <pkg>` afterwards to install a package and
save it as a dependency in the package.json file.

Press ^C at any time to quit.
package name: (express)
version: (1.0.0)
description: express learn
entry point: (index.js)
test command:
git repository:
keywords:
author: hong
license: (ISC)
About to write to D:\documents\projects\github\branch\front_road\express\package.json:

{
  "name": "express",
  "version": "1.0.0",
  "description": "express learn",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "hong",
  "license": "ISC"
}


Is this OK? (yes) yes

D:\documents\projects\github\branch\front_road\express>npm install express --save

added 58 packages in 3s

D:\documents\projects\github\branch\front_road\express>node app.js
Example app listening on port 10000

```