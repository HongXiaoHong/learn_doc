# JavaScript 进阶

## 标签页 通信

### 直接使用 window 对象的 postMessage 进行通信

使用 window 的 postMessage 方法进行通信, 使用 window 的 message 进行监听

https://developer.mozilla.org/zh-CN/docs/Web/API/Window/postMessage

```javascript
/*
 * A 窗口的域名是<http://example.com:8080>，以下是 A 窗口的 script 标签下的代码：
 */

var popup = window.open(...popup details...);

// 如果弹出框没有被阻止且加载完成

// 这行语句没有发送信息出去，即使假设当前页面没有改变 location（因为 targetOrigin 设置不对）
popup.postMessage("The user is 'bob' and the password is 'secret'",
                  "https://secure.example.net");

// 假设当前页面没有改变 location，这条语句会成功添加 message 到发送队列中去（targetOrigin 设置对了）
popup.postMessage("hello there!", "http://example.com");

function receiveMessage(event)
{
  // 我们能相信信息的发送者吗？(也许这个发送者和我们最初打开的不是同一个页面).
  if (event.origin !== "http://example.com")
    return;

  // event.source 是我们通过 window.open 打开的弹出页面 popup
  // event.data 是 popup 发送给当前页面的消息 "hi there yourself!  the secret response is: rheeeeet!"
}
window.addEventListener("message", receiveMessage, false);

```

### BroadcastChannel

发送

```JavaScript
const channel = new BroadcastChannel("example-channel");
const messageControl = document.querySelector("#message");
const broadcastMessageButton = document.querySelector("#broadcast-message");

broadcastMessageButton.addEventListener("click", () => {
  channel.postMessage(messageControl.value);
});


```

接受

```JavaScript

const channel = new BroadcastChannel("example-channel");
channel.addEventListener("message", (event) => {
  received.textContent = event.data;
});
```

## 多线程

### worker

同源的情况下, 开启多线程进行计算

示例:

下载 https://github.com/mdn/simple-web-worker.git

本地开启

```bash
E:\github\simple-web-worker\web-workers\simple-web-worker>python -m http.server 8999
```

访问 http://localhost:8999/index.html

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230820103950.png)

代码:
main.js:

```JavaScript
const first = document.querySelector('#number1');
const second = document.querySelector('#number2');

const result = document.querySelector('.result');

if (window.Worker) {
  const myWorker = new Worker("worker.js");

  first.onchange = function() {
    myWorker.postMessage([first.value, second.value]);
    console.log('Message posted to worker');
  }

  second.onchange = function() {
    myWorker.postMessage([first.value, second.value]);
    console.log('Message posted to worker');
  }

  myWorker.onmessage = function(e) {
    result.textContent = e.data;
    console.log('Message received from worker');
  }
} else {
  console.log('Your browser doesn\'t support web workers.');
}

```

worker.js:

```JavaScript
onmessage = function(e) {
  console.log('Worker: Message received from main script');
  const result = e.data[0] * e.data[1];
  if (isNaN(result)) {
    postMessage('Please write two numbers');
  } else {
    const workerResult = 'Result: ' + result;
    console.log('Worker: Posting message back to main script');
    postMessage(workerResult);
  }
}

```

onmessage 是固定的
用来交互数据的方法

https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise#promise_%E5%B9%B6%E5%8F%91

Promise 类提供了四个静态方法来促进异步任务的并发：

Promise.all()
在所有传入的 Promise 都被兑现时兑现；在任意一个 Promise 被拒绝时拒绝。

Promise.allSettled()
在所有的 Promise 都被敲定时兑现。

Promise.any()
在任意一个 Promise 被兑现时兑现；仅在所有的 Promise 都被拒绝时才会拒绝。

Promise.race()
在任意一个 Promise 被敲定时敲定。换句话说，在任意一个 Promise 被兑现时兑现；在任意一个的 Promise 被拒绝时拒绝。

所有这些方法都接受一个 Promise（确切地说是 thenable）的可迭代对象，并返回一个新的 Promise。它们都支持子类化，这意味着它们可以在 Promise 的子类上调用，结果将是一个属于子类类型的 Promise。为此，子类的构造函数必须实现与 Promise() 构造函数相同的签名——接受一个以 resolve 和 reject 回调函数作为参数的单个 executor 函数。子类还必须有一个 resolve 静态方法，可以像 Promise.resolve() 一样调用，以将值解析为 Promise。

Promise.all  就是基于 worker 进行并发的

JavaScript 的本质上是单线程的，因此在任何时刻，只有一个任务会被执行，尽管控制权可以在不同的 Promise 之间切换，从而使 Promise 的执行看起来是并发的。

> 在 JavaScript 中，并行执行只能通过 worker 线程实现。

### 为什么 JavaScript 是单线程

https://www.jianshu.com/p/5c23bdcf2a11

多个线程会有同步的问题
如果此时两个进程同时操作一个dom
将无法决定使用哪个进程的动作

上面的worker可以解决多线程的问题
不过也只是同源的情况下

同步任务/异步任务
事件循环就是为了解决异步任务的问题

### 异步

Promise.all 就是为了解决 多个 promise 互相不依赖,
也就是 promise 的调用参数不需要依赖其他 promise 的执行
于是我们可以直接使用 all 或者 allSettled 进行调用

第一次在 js 中看到了 并发跟并行

```javascript
function resolveAfter2Seconds() {
  console.log("starting slow promise");
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve("slow");
      console.log("slow promise is done");
    }, 2000);
  });
}

function resolveAfter1Second() {
  console.log("starting fast promise");
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve("fast");
      console.log("fast promise is done");
    }, 1000);
  });
}

async function sequentialStart() {
  console.log("==SEQUENTIAL START==");

  // 1. Execution gets here almost instantly
  const slow = await resolveAfter2Seconds();
  console.log(slow); // 2. this runs 2 seconds after 1.

  const fast = await resolveAfter1Second();
  console.log(fast); // 3. this runs 3 seconds after 1.
}

async function concurrentStart() {
  console.log("==CONCURRENT START with await==");
  const slow = resolveAfter2Seconds(); // starts timer immediately
  const fast = resolveAfter1Second(); // starts timer immediately

  // 1. Execution gets here almost instantly
  console.log(await slow); // 2. this runs 2 seconds after 1.
  console.log(await fast); // 3. this runs 2 seconds after 1., immediately after 2., since fast is already resolved
}

// 并发
function concurrentPromise() {
  console.log("==CONCURRENT START with Promise.all==");
  return Promise.all([resolveAfter2Seconds(), resolveAfter1Second()]).then(
    (messages) => {
      console.log(messages[0]); // slow
      console.log(messages[1]); // fast
    },
  );
}

// 并行
async function parallel() {
  console.log("==PARALLEL with await Promise.all==");

  // Start 2 "jobs" in parallel and wait for both of them to complete
  await Promise.all([
    (async () => console.log(await resolveAfter2Seconds()))(),
    (async () => console.log(await resolveAfter1Second()))(),
  ]);
}

sequentialStart(); // after 2 seconds, logs "slow", then after 1 more second, "fast"

// wait above to finish
setTimeout(concurrentStart, 4000); // after 2 seconds, logs "slow" and then "fast"

// wait again
setTimeout(concurrentPromise, 7000); // same as concurrentStart

// wait again
setTimeout(parallel, 10000); // truly parallel: after 1 second, logs "fast", then after 1 more second, "slow"

```

#### async

##### 原理分析

使用 生成器跟自动执行器 

类似 co 模块 自动帮我们执行 生成器

简单实现代码如下

就是通过递归调用我们的 promise 最后通过solve来返回我们最后调用的值

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230826164812.png)

#### await

await 总会同步地对表达式求值并处理，处理的行为与 Promise.resolve() 一致，不属于原生 Promise 的值全都会被隐式地转换为 Promise 实例后等待。处理的规则为，若表达式：

是一个原生 Promise（原生Promise 的实例或其派生类的实例，且满足 expression.constructor === Promise），会被直接用于等待，等待由原生代码实现，该对象的 then() 不会被调用。
是 thenable 对象（包括非原生的 Promise 实例、polyfill、Proxy、派生类等），会构造一个新 Promise 用于等待，构造时会调用该对象的 then() 方法。
不是 thenable 对象，会被包装进一个已兑现的 Promise 用于等待，其结果就是表达式的值。

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/8170006cf5a5c37d311dc3059155e4b.jpg)

## API

### MutationObserver

注册一个监听器
监听元素 属性或者子元素或者其他变化

https://developer.mozilla.org/zh-CN/docs/Web/API/MutationObserver

```javascript
// 选择需要观察变动的节点
const targetNode = document.getElementById("some-id");

// 观察器的配置（需要观察什么变动）
const config = { attributes: true, childList: true, subtree: true };

// 当观察到变动时执行的回调函数
const callback = function (mutationsList, observer) {
  // Use traditional 'for loops' for IE 11
  for (let mutation of mutationsList) {
    if (mutation.type === "childList") {
      console.log("A child node has been added or removed.");
    } else if (mutation.type === "attributes") {
      console.log("The " + mutation.attributeName + " attribute was modified.");
    }
  }
};

// 创建一个观察器实例并传入回调函数
const observer = new MutationObserver(callback);

// 以上述配置开始观察目标节点
observer.observe(targetNode, config);

// 之后，可停止观察
observer.disconnect();

```

## 内存机制

栈和堆:
简单的说
基本类型存栈
对象类型存堆

执行栈存储当前执行的变量/方法
先进后出

https://juejin.cn/post/6844903618999500808

## 原型链

### __proto__ prototype constructor

http://dennisgo.cn/Articles/JavaScript/myPrototype.html
JS中的函数可以作为函数使用，也可以作为类使用
作为类使用的函数实例化时需要使用new
为了让函数具有类的功能，函数都具有prototype属性。
为了让实例化出来的对象能够访问到prototype上的属性和方法，实例对象的__proto__指向了类的prototype。所以prototype是函数的属性，不是对象的。对象拥有的是__proto__，是用来查找prototype的。
prototype.constructor指向的是构造函数，也就是类函数本身。改变这个指针并不能改变构造函数。
对象本身并没有constructor属性，你访问到的是原型链上的prototype.constructor。
函数本身也是对象，也具有__proto__，他指向的是JS内置对象Function的原型Function.prototype。所以你才能调用func.call,func.apply这些方法，你调用的其实是Function.prototype.call和Function.prototype.apply。
prototype本身也是对象，所以他也有__proto__，指向了他父级的prototype。__proto__和prototype的这种链式指向构成了JS的原型链。原型链的最终指向是Object的原型。Object上面原型链是null，即Object.prototype.__proto__ === null。
另外要注意的是Function.__proto__ === Function.prototype，这是因为JS中所有函数的原型都是Function.prototype，也就是说所有函数都是Function的实例。Function本身也是可以作为函数使用的----Function()，所以他也是Function的一个实例。类似的还有Object，Array等，他们也可以作为函数使用:Object(), Array()。所以他们本身的原型也是Function.prototype，即Object.__proto__ === Function.prototype。换句话说，这些可以new的内置对象其实都是一个类，就像我们的Puppy类一样。
ES6的class其实是函数类的一种语法糖，书写起来更清晰，但原理是一样的。
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230821164126.png)

## this

this 介绍 https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/this

JavaScript 的 this 确实让人困惑

要弄懂 this 还必须弄懂 执行上下文
执行上下文又分为

- 全局上下文 浏览器 => window  node => global
- 函数上下文
- eval 上下文

在创建执行上下文的时候, 也就是说运行时才会去绑定 this

我认为当前的 this 会去上下文中寻找到第一个不为空的 this 属性

从这个结果来看

```JavaScript
var obj = {
  bar: function () {
    var x = () => this;
    return x;
  },
    car:()=>this,
};
undefined
obj.bar()()
{bar: ƒ, car: ƒ}
obj.car()
Window {0: global, window: Window, self: Window, document: document, name: '', location: Location, …}
obj.this
undefined
```

而箭头函数, 或者说叫做 lambda 表达式
是没有 this 一说的, 具体的 this 指向取决于当前所处的位置
也就是<mark>语法作用域</mark>内没有 this, 就会指向全局的了

参考

[[译] 理解 JavaScript 中的执行上下文和执行栈 - 掘金 (juejin.cn)](https://juejin.cn/post/6844903682283143181#heading-3)
