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