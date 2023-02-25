# html

## 重识html

**万维网用url统一资源定位符标识分布因特网上的各种文档**

### 各种概念

URL:

统一资源定位器 它是WWW的统一资源定位标志，就是指网络地址 

在WWW上，每一信息资源都有统一的且在网上唯一的地址

网页:

    由文字 图片 视频 音乐各种元素排列组合而成的超文本页面

常用浏览器:

- Chrome

- Edge

- Firefox

HTML:

    超文本标记语言 非编程语言

HTML 属性:

  HTML属性是在元素的开始标记中使用的关键字，用于控制元素的行为

浏览器内核:

    用于渲染网页

| 浏览器     | 内核             | 备注                                                                                                   |
| ------- | -------------- | ---------------------------------------------------------------------------------------------------- |
| IE      | Trident        | IE                                                                                                   |
| firefox | Gecko          | 可惜这几年已经没落了，打开速度慢、升级频繁、猪一样的队友flash、神一样的对手chrome。                                                      |
| Safari  | webkit         | 现在很多人错误地把 webkit 叫做 chrome内核（即使 chrome内核已经是 blink 了）。苹果感觉像被别人抢了媳妇，都哭晕在厕所里面了。                         |
| chrome  | Chromium/Blink | 在 Chromium 项目中研发 Blink 渲染引擎（即浏览器核心），内置于 Chrome 浏览器之中。Blink 其实是 WebKit 的分支。大部分国产浏览器最新版都采用Blink内核。二次开发 |
| Opera   | blink          | 现在跟随chrome用blink内核。                                                                                  |

web标准

有W3C(万维网)组织及组织制定

防止因为不同厂家的浏览器而让网页出现不同的表现

组成:

结构 -> HTML

表现 -> CSS

行为 -> JavaScript

单位

高度

vh vh单位代表视口高度，相对于视口高度的1%。



## 格式

缩进 空格比父标签缩进两格



## 元数据

### Viewport

[HTML meta viewport属性说明(mark) - 穆乙 - 博客园 (cnblogs.com)](https://www.cnblogs.com/pigtail/archive/2013/03/15/2961631.html)

> ## 什么是Viewport
> 
> 手机浏览器是把页面放在一个虚拟的“窗口”（viewport）中，通常这个虚拟的“窗口”（viewport）比屏幕宽，这样就不用把每个网页挤到很小的窗口中（这样会破坏没有针对手机浏览器优化的网页的布局），用户可以通过平移和缩放来看网页的不同部分。移动版的 Safari 浏览器最新引进了 viewport 这个 meta tag，让网页开发者来控制 viewport 的大小和缩放，其他手机浏览器也基本支持。
> 
> ## Viewport 基础
> 
> 一个常用的针对移动网页优化过的页面的 viewport meta 标签大致如下：
> 
> <meta name=”viewport” content=”width=device-width, initial-scale=1, maximum-scale=1″>
> 
> width：控制 viewport 的大小，可以指定的一个值，如果 600，或者特殊的值，如 device-width 为设备的宽度（单位为缩放为 100% 时的 CSS 的像素）。  
> height：和 width 相对应，指定高度。  
> initial-scale：初始缩放比例，也即是当页面第一次 load 的时候缩放比例。  
> maximum-scale：允许用户缩放到的最大比例。  
> minimum-scale：允许用户缩放到的最小比例。  
> user-scalable：用户是否可以手动缩放



## 标签

HTML 超文本标记语言 用什么标记

😏 **标签** :)

标签通常是闭合的 标签内包含文本

例如

```html
<h1>h1标题</h1>
```

#### 全局属性

id 用于标识一个元素 一个页面需唯一

### class | 类

使用类可以标识一类表现一致的元素 用于css中选择

```css
.class { }
```

多个 class 用空格隔开

```html
<div class="class1 class2"></div>
```

### 结构标签

html的结构组成如下:

```html
<!-- 这个特殊字符串被称为声明，它确保浏览器尝试满足行业规范 -->
<!DOCTYPE html>
<html>
<head>
    <title>网页标题-显示在浏览器上</title>
</head>
<body>

</body>
</html>
```

#### html | 容器

> <html> 标签告知浏览器这是一个 HTML 文档。
> 
> <html> 标签是 HTML 文档中最外层的元素。
> 
> <html> 标签是所有其他 HTML 元素（除了 [<!DOCTYPE>](https://www.runoob.com/tags/tag-doctype.html) 标签）的容器

#### body | 网页内容/主体

#### head | 网页设置

放置设置网页重要的设置 或者引入其他资源包括 css js

元数据(metadata content包括: base,link,meta,noscript,style,script,title等

##### title | 网页标题

##### meta | 浏览器行为

```html
<meta charset="UTF-8">
```

##### link | 外部资源链接

[<link>：外部资源链接元素 - HTML（超文本标记语言） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/link)

> **HTML 外部资源链接元素** (**`<link>`**) 规定了当前文档与外部资源的关系。该元素最常用于链接[样式表](https://developer.mozilla.org/zh-CN/docs/Glossary/CSS)，此外也可以被用来创建站点图标 (比如 PC 端的“favicon”图标和移动设备上用以显示在主屏幕的图标)

栗子

```html
<link href="/media/examples/link-element-example.css" rel="stylesheet">
```

rel 表示与html的关系 样式表用 stylesheet

href 表示资源的URL链接地址

### h1 - h6 | 标题

h1 -> h6 六个标题标签 数字越大级别越低 字体越小

每一个网页只用一个 h1 标签

### div | 页面布局

### p | 文本一段

p 标签用于创建一段文本

### \<!\-\- \-\-\> | 注释

\<\!\-\- \-\-\> 注释不会影响页面布局 

```html
<!--
🤣 这是一段有感情的注释
-->
```

### img | 图片

没有必要使用结束标签

**没有结束标记的元素的标记称为自结束标记**

#### 属性

| 属性  | 作用               |
| --- | ---------------- |
| src | 图片源              |
| alt | 图片加载失败提示文字 ✨推荐加上 |
|     |                  |

### a |  链接

链接到其他网页 网址

闭合标签 标签内的文本展示链接的提示信息

#### 属性

| 属性     | 作用                 |
| ------ | ------------------ |
| href   | 链接地址               |
| target | {_blank-打开一个新网页, } |
|        |                    |

#### 锚伪类

在支持 css 的浏览器中，链接的不同状态都可以不同的方式显示，这些状态包括：**活动状态**，**已被访问状态**，**未被访问状态和鼠标悬停状态**。用来表示链接不同状态的伪类就是锚伪类。

```css
a:link {color: green;} /* 未访问的链接 */
a:visited {color: blue;} /* 已访问的链接 */
a:hover {color:orange;} /* 鼠标移动到链接上 */
a:active {color: yellow;} /* 选定的链接 */
```

- 几个伪类必须按照一定的顺序(l-v-h-a)，a:hover必须被置于a:link和a:visited之后，才是有效的；a:active必须被置于a:hover之后，才是有效的。
- 书写顺序很重要：a:link - a:visited - a:hover - a:actived。

### form | 表单

表单 用于收集用户信息

#### 属性

action 提交表单的URL

method URL请求通过什么方式请求

    get | 查询

    post | 修改

    delete | 删除

#### input | 收集数据

##### 属性

有多种类型在表单中收集数据

包括 密码 文件 重置按钮

name 属性用于表单提交时区别不同的表单项

placeholder 输入提示信息

required 要求用户录入信息

type radio单选

minlength | 限制输入长度

pattern | 正则表达式限制输入格式

###### type

指定表单元素的type属性对于浏览器了解它应该期望的数据类型非常重要。如果未指定类型，浏览器将默认为text

##### 单选

radio 单选 name属性相同 实现单选效果

value 保证传给后台有值

checked 默认选中

###### label | 单选按钮与对应文本享受同一个点击

方式1 将 input 与文本放在同一个 label 中

```html
<label><input id="indoor" type="radio" name="indoor-outdoor" value="indoor"> Indoor</label>
```

方式2 使用 label 的 for 属性

```html
<label for="loving">Loving</label>
```

##### 多选

checkbox

🎯name加上 后台才知道这是哪个字段

推荐加上value

checked 默认选中

### textarea | 多行文本

```html
<textarea id="bio" rows="3" cols="30" placeholder="I like coding on the beach..."></textarea>
```

placeholder 提示用户输入内容 直到用户输入 才会消失 

#### button | 按钮

默认行为: 提交form表单到action

按钮要提交表单 最好还是加上 type = "submit"

```html
<button type="submit">Submit</button>
```

#### fieldset | 结合输入与文本

元用于对表单中的控制元素进行分组（也包括 label 元素）

```html
<form>
  <fieldset>
    <legend>Choose your favorite monster</legend>

    <input type="radio" id="kraken" name="monster" value="K">
    <label for="kraken">Kraken</label><br>

    <input type="radio" id="sasquatch" name="monster" value="S">
    <label for="sasquatch">Sasquatch</label><br>

    <input type="radio" id="mothman" name="monster" value="M" />
    <label for="mothman">Mothman</label>
  </fieldse
t>
</form>
```

```
legend {
    background-color: #000;
    color: #fff;
    padding: 3px 6px;
}

input {
    margin: 0.4rem;
}
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_6q6yloxIO3.png)

##### legend | 标题

```html
<fieldset>
            <legend>Is your cat an indoor or outdoor cat?</legend>
            <label><input id="indoor" type="radio" name="indoor-outdoor" value="indoor"> Indoor</label>
            <label><input id="outdoor" type="radio" name="indoor-outdoor" value="outdoor"> Outdoor</label>
          </fieldset>
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/kDd6wBbgwb.png)

### ul | 无序列表

列表元素使用li

```html
<ul>
  <li>milk</li>
  <li>cheese</li>
</ul>
```

### ol | 有序列表

```html
<ol>
          <li>flea treatment</li>
          <li>thunder</li>
          <li>other cats</li>
        </ol>
```

### figure | 可附标题内容元素

**`<figure>`** 元素代表一段独立的内容，可能包含 [`<figcaption>`](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/figcaption) 元素定义的说明元素。该插图、标题和其中的内容通常作为一个独立的引用单元

#### figcaption | figure 下图片标题说明

```html
<figure>
          <img src="https://cdn.freecodecamp.org/curriculum/cat-photo-app/lasagna.jpg" alt="A slice of lasagna on a plate.">
          <figcaption>Cats love lasagna.</figcaption>
        </figure>
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_cdVhXp86Du.png)

Cats love lasagn. 就是所谓的图片标题说明

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/97nh9m6fr4.png)

### em | 强调

em 对文本进行强调显示

```html
<em>love</em>
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/DiurHcoIxB.png)

### strong | 强调

```html
<strong>hate</strong>
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_jt2l31DR42.png)

### 语义标签-H5

#### 内容区域

标识不同的内容区域

| 标签         | 语义                       |
| ---------- | ------------------------ |
| article    | 定义文章                     |
| aside      | 定义页面内容以外的内容              |
| details    | 定义用户能够查看或隐藏的额外细节         |
| figcaption | 定义 figure 元素的标题          |
| figure     | 规定自包含内容，比如图示、图表、照片、代码清单等 |
| footer     | 定义文档或节的页脚                |
| header     | 规定文档或节的页眉                |
| main       | 规定文档的主内容                 |
| mark       | 定义重要的或强调的文本              |
| nav        | 定义导航链接                   |
| section    | 定义文档中的节                  |
| summary    | 定义 details 元素的可见标题       |

#### article | 文章

元素表示文档、页面、应用或网站中的独立结构，其意在成为可独立分配的或可复用的结构，如在发布中，它可能是论坛帖子、杂志或新闻文章、博客、用户提交的评论、交互式组件，或者其他独立的内容项目

## H5新特征

- Canvas、SVG -- 用于绘画的元素，canvas绘制的图片会失真而SVG绘制的不会失真。
- video、audio -- 用于播放视频和音频的媒体。
- Drag 、Drop -- 用于拖放的 。
- Geolocation -- 用于获取地理位置。
- localStorage、sessionStorage -- 用于本地离线存储。
- webSQL、IndexDB -- 前端数据库操作，由于安全性极低，目前h5已放弃。
- web Worker -- 独立于其他脚本，不影响页面性能运行在后台的javascript。
- webSocket -- 单个TCP连接上进行全双工通讯的协议。
- 新的特殊内容元素 -- 如：article、footer、header、nav、section。
- 新的表单控件 -- 如：date、time、email、url、search。

### 新的语义标签

🤔TODO

语义标签 -> 标签可以看出其作用

例如 img table form

新的标签包括:

| 标签         | 语义                       |
| ---------- | ------------------------ |
| article    | 定义文章                     |
| aside      | 定义页面内容以外的内容              |
| details    | 定义用户能够查看或隐藏的额外细节         |
| figcaption | 定义 figure 元素的标题          |
| figure     | 规定自包含内容，比如图示、图表、照片、代码清单等 |
| footer     | 定义文档或节的页脚                |
| header     | 规定文档或节的页眉                |
| main       | 规定文档的主内容                 |
| mark       | 定义重要的或强调的文本              |
| nav        | 定义导航链接                   |
| section    | 定义文档中的节                  |
| summary    | 定义 details 元素的可见标题       |
| time       | 定义日期/时间                  |

### 好处

- 代码结构得到了优化，使结构完整、清晰，更加方便阅读和理解
- 有利于搜索引擎的优化
- 爬虫依赖标签确定关键字的权重，可以帮助爬虫爬出更多有效信息

### 怎么语义化

- 少用无语义的标签, 例如标签 div、span
- 用对有语义的标签 可参上面的新的 -> 新的标签

[Semantics（语义） - 术语表 | MDN](https://developer.mozilla.org/zh-CN/docs/Glossary/Semantics)

[HTML5 语义元素](https://www.w3school.com.cn/html/html5_semantic_elements.asp)

[什么是 HTML 语义化，有什么好处 - 肥晨 - 博客园](https://www.cnblogs.com/naitang/p/15737057.html)

[什么是语义化标签，常见的语义化标签介绍_.慢慢亦漫漫的博客-CSDN博客_语义化标签

](https://blog.csdn.net/weixin_43183219/article/details/122392412)

[HTML5新增了哪些特性？ - 掘金](https://juejin.cn/post/6988039257587712008)

### manifest 应用缓存机制

虽然 manifest 已经被web标准弃用 但是还是值得了解一下

使用 manifest 进行缓存

#### 好处

- 离线访问: 即使服务器挂了, 或者没有网络, 用户依然可以正常浏览网页内容.
- 访问更快: 数据存在于本地, 省去了浏览器发起http请求的时间, 因此访问更快, 移动端效果更为明显.
- 降低负载: 浏览器只在manifest文件改动时才去服务器下载需要缓存的资源, 大大降低了服务器负载.

#### 编写 manifest 缓存清单

```appcache
CACHE MANIFEST
# v1.0.0
content.css

NETWORK:
app.js

FALLBACK:
/other 404.html
```

由 CACHE, NETWORK 和 FALLBACK 组成

其中第一行必须以 CACHE MANIFEST 开头, 后可跟若干字符注释, 注释从#号开始. 跟在 CACHE MANIFEST 行后的文件, 每行列出一个, 这些文件是需要缓存的文件. 因此 content.css 会被缓存, 不需要访问网络.

第二段内容以 NETWORK: 开始, 跟在该行后的文件表示需要访问网络. 如: app.js 将直接从网络上下载, 并不走manifest cache, 如果除了第一段中缓存的文件以外, 其他文件都从网络上获取, 那么此时可将 app.js 改为 * (通配符).

第三段内容以 FALLBACK: 开始, 跟在该行后的文件表示会有一个替代方案. 如: 当访问 /other 路径时, 如果访问失败, 那么将自动加载 404.html 作为替代.

## 正则

可以用于输入的格式限制

#### 参考

[聊一聊H5应用缓存-Manifest | louis blog (louiszhai.github.io)](https://louiszhai.github.io/2016/11/25/manifest/)
