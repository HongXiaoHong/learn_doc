# html

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

#### 参考

[聊一聊H5应用缓存-Manifest | louis blog (louiszhai.github.io)](https://louiszhai.github.io/2016/11/25/manifest/)


