# js api

js api 包括像 
- dom
- 音视频 HTMLmediaelement 
- navigator 获取系统浏览器信息
- 绘制和操作图形 canvas
- 客户端存储

## 音视频 HTMLmediaelement 

HTMLmediaelement api: https://developer.mozilla.org/zh-CN/docs/Web/API/HTMLMediaElement

音视频 api 
例如 video audio 元素
api 都是继承 自 HTMLmediaelement 所以方法基本也都差不多

```JavaScript
// 循环播放
audioElement.loop = nextPlayOrder === "infinity";

// 静音
audioElement.muted = false;

// 音量
audioElement.volume = doms.voiceRange.value / 100;

// 当前时间
audioElement.currentTime = audioElement.duration * e.target.value / 100;

// 播放结束事件
$(audioElement).on("ended", () => {

}

// 播放源
audioElement.src = `http://localhost:8891/audio/${songName}?suffix=${datas.currentPlaylist[songName]}&currentPlaylistChoose=${datas.currentPlaylistChoose}`;

// 暂停
audioElement.pause();

// 播放
audioElement.play();

// 跟进播放进度事件
doms.audio.addEventListener('timeupdate', setOffset);

```

可参见 https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Client-side_web_APIs/Video_and_audio_APIs


## 客户端存储

cookie 存储数据已经不再安全
像 CSRF

我们应该使用 localstorage 或者 sessionstorage 存储一些简单的数据
复杂一点的数据使用 indexeddb

IndexedDB是浏览器提供的一个本地数据库，允许我们在浏览器端存储和操作大量复杂数据。以下是一个简单的示例代码，演示了如何在JavaScript中使用IndexedDB存储和检索复杂数据：

```html
<!DOCTYPE html>
<html>
<head>
  <title>IndexedDB 示例</title>
</head>
<body>
  <button onclick="addItem()">添加数据</button>
  <button onclick="readData()">读取数据</button>
  <div id="output"></div>

  <script>
    // 打开或创建IndexedDB数据库
    const dbName = "myDatabase";
    const dbVersion = 1;

    let db;
    const request = window.indexedDB.open(dbName, dbVersion);

    // 数据库打开成功的回调
    request.onsuccess = function(event) {
      db = event.target.result;
      console.log("数据库打开成功");
    };

    // 数据库打开失败的回调
    request.onerror = function(event) {
      console.error("数据库打开失败：" + event.target.error);
    };

    // 数据库升级（创建存储对象）的回调
    request.onupgradeneeded = function(event) {
      db = event.target.result;

      // 创建存储对象（表），名为dataStore
      if (!db.objectStoreNames.contains("dataStore")) {
        const objectStore = db.createObjectStore("dataStore", { keyPath: "id", autoIncrement: true });
      }
    };

    // 添加数据到IndexedDB
    function addItem() {
      const data = { name: "John Doe", age: 30, email: "john@example.com" };

      const transaction = db.transaction(["dataStore"], "readwrite");
      const objectStore = transaction.objectStore("dataStore");

      const request = objectStore.add(data);

      request.onsuccess = function(event) {
        console.log("数据添加成功");
      };

      request.onerror = function(event) {
        console.error("数据添加失败：" + event.target.error);
      };
    }

    // 从IndexedDB读取数据
    function readData() {
      const transaction = db.transaction(["dataStore"], "readonly");
      const objectStore = transaction.objectStore("dataStore");

      const request = objectStore.getAll();

      request.onsuccess = function(event) {
        const data = event.target.result;
        const outputDiv = document.getElementById("output");
        outputDiv.innerHTML = JSON.stringify(data, null, 2);
      };

      request.onerror = function(event) {
        console.error("读取数据失败：" + event.target.error);
      };
    }
  </script>
</body>
</html>
```

在上述示例中，我们创建了一个名为"myDatabase"的IndexedDB数据库，并在数据库的"dataStore"存储对象中存储了一些数据。可以通过点击按钮来添加数据和读取数据。注意，由于IndexedDB是异步的，因此我们使用了回调函数来处理成功和失败的情况。

当运行这个示例代码时，IndexedDB会在浏览器中创建一个名为"myDatabase"的数据库，并在数据库中存储一些数据。你可以点击"添加数据"按钮来添加数据，然后点击"读取数据"按钮来读取并展示已添加的数据。

可以参见 https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Client-side_web_APIs/Client-side_storage

## 基本类型

### 数字
#### 进制转换


js任意进制转换（二进制，八进制，十进制...三十六进制）
https://blog.csdn.net/zy444263/article/details/84062438 

进制转换只能发生在数字上，也就是Number类型，所以要进行进制转换，那就是需要用到Number类型上的方法了，有两种方法：

parseInt(string , radix)或者parseInt(string , radix)，前者是全局的方法，是以前的规范，现在规范改了变成了Number下面的方法。
Number.toString(radix)

##### 字符串 ＋ 进制 => 数字

```JavaScript
Number.parseInt('010',8)//8
Number.parseInt('20',2)//NaN
String.fromCodePoint(Number.parseInt("1F600", 16)) // 😀
```
加上码点 String.fromCodePoint 转换可以得到 Unicode 编码表示的字符

#### 数字 => 进制的字符串

```JavaScript
(10).toString(2)//"1010"转2进制
(10).toString(16)//"a" 转16进制
(1000).toString(36)//"rs" 转36进制

```

## 监听器
### MutationObserver | 监听 dom 树修改

> MutationObserver 接口提供了监视对 DOM 树所做更改的能力。它被设计为旧的 Mutation Events 功能的替代品，该功能是 DOM3 Events 规范的一部分。

可以用来追踪 页面中 dom 节点属性/子节点修改(增加节点/删除节点)

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

参:
[javascript 监听DOM内容改变事件](https://blog.csdn.net/u013350495/article/details/90755115)
[MutationObserver](https://developer.mozilla.org/zh-CN/docs/Web/API/MutationObserver#%E7%A4%BA%E4%BE%8B)

## worker
- [Web Workers](https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Workers_API/Using_web_workers#%E5%85%B6%E4%BB%96%E7%B1%BB%E5%9E%8B%E7%9A%84_worker)
- ServiceWorkers 基本上是作为代理服务器，位于 web 应用程序、浏览器和网络（如果可用）之间。它们的目的是（除开其他方面）创建有效的离线体验，拦截网络请求，以及根据网络是否可用采取合适的行动并更新驻留在服务器上的资源。它们还将允许访问推送通知和后台同步 API。
- Audio Worklet 提供了在 worklet（轻量级的 web worker）上下文中直接完成脚本化音频处理的可能性。