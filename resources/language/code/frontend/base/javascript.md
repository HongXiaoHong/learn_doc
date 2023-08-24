# javascript

## 常用 api

### 剪切板
剪贴板操作 Clipboard API 教程
https://www.ruanyifeng.com/blog/2021/01/clipboard-api.html

兼容性:
https://blogger.tigernaxo.com/post/javascript/copy_text/

## 重要概念
### 事件循环
https://segmentfault.com/a/1190000040014996#item-3-1
首先大家都知道JS是一门单线程的语言，所有的任务都是在一个线程上完成的。而我们知道，有一些像I/O，网络请求等等的操作可能会特别耗时，如果程序使用"同步模式"等到任务返回再继续执行，就会使得整个任务的执行特别缓慢，运行过程大部分事件都在等待耗时操作的完成，效率特别低。

为了解决这个问题，于是就有了事件循环（Event Loop）这样的概念，简单来说就是在程序本身运行的主线程会形成一个"执行栈"，除此之外，设立一个"任务队列",每当有异步任务完成之后，就会在"任务队列"中放置一个事件，当"执行栈"所有的任务都完成之后，会去"任务队列"中看有没有事件，有的话就放到"执行栈"中执行。

这个过程会不断重复，这种机制就被称为事件循环（Event Loop）机制。

我对于事件循环的理解是
为了协调浏览器中对于任务的调度进行协调的一套机制

### 事件流
https://www.bilibili.com/video/BV1m7411L7YW/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209

1．事件捕获阶段

2．处于目标阶段

3．事件冒泡阶段

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230819115046.png)

#### 事件捕获
#### 事件冒泡

