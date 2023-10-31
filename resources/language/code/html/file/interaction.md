# html 文件交互



[🤩在 web 应用程序中使用文件 - Web API 接口参考 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/API/File_API/Using_files_from_web_applications#%E8%AE%BF%E9%97%AE%E8%A2%AB%E9%80%89%E6%8B%A9%E7%9A%84%E6%96%87%E4%BB%B6)

## 文件下载

### api 学习

#### File、Blob、FileReader、ArrayBuffer、Base64

[5.今天一次性给你讲清楚：File、Blob、FileReader、ArrayBuffer、Base64_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1q14y1876F/?spm_id_from=333.788&vd_source=eabc2c22ae7849c2c4f31815da49f209)

##### blob | 用来存储二进制大文件

blob: 用来存储二进制大文件, 不可读, 需要借助 filereader 转换成 base64/string/ArrayBuffer/二进制



可以使用 slice 对文件进行分片

##### file | blob 子类

file: blob 子类, 继承了 blob, 拥有更多方法

可以从 input 标签中或者 拖拽的 什么 trans 对象获取

###### input



file-input-element.files

###### DataTransfer



拖拽参考: [File drag and drop - Web API 接口参考 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/API/HTML_Drag_and_Drop_API/File_drag_and_drop)

> 释放事件
> 当用户释放文件时 drop 事件将会被触发。在下面的 drop 处理函数中，如果浏览器支持 DataTransferItemList 接口，则可以使用 getAsFile() 来获取每个文件；否则使用 DataTransfer 接口的 files 属性来获取每个文件。



```javascript
function dropHandler(ev) {
  console.log("File(s) dropped");

  // Prevent default behavior (Prevent file from being opened)
  ev.preventDefault();

  if (ev.dataTransfer.items) {
    // Use DataTransferItemList interface to access the file(s)
    for (var i = 0; i < ev.dataTransfer.items.length; i++) {
      // If dropped items aren't files, reject them
      if (ev.dataTransfer.items[i].kind === "file") {
        var file = ev.dataTransfer.items[i].getAsFile();
        console.log("... file[" + i + "].name = " + file.name);
      }
    }
  } else {
    // Use DataTransfer interface to access the file(s)
    for (var i = 0; i < ev.dataTransfer.files.length; i++) {
      console.log(
        "... file[" + i + "].name = " + ev.dataTransfer.files[i].name,
      );
    }
  }
}

```

#### 如何查看 blob



##### filereader | 阅读 blob arraybuffer

用来查看 blob



##### URL

[URL.createObjectURL() - Web API 接口参考 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/API/URL/createObjectURL_static)

```javascript
objectURL = URL.createObjectURL(object);

```

用来创建 blob 对象连接, 然后用来下载文件, 尤其是给 a 标签加上 download 属性就不会出现不用源的情况

### a 标签下载实例

参 [a标签设置下载设置文件名，并且设置无效的解决方法](https://www.cnblogs.com/sws-kevin/p/16416373.html)

    [前端如何通过a链接下载文件 - 掘金 (juejin.cn)](https://juejin.cn/post/7039109468080062500)

#### 同源

设置 a 标签的 download属性，可以重置 文件名。如下代码，文件名重置为 file.xlsx。

```html
<a href='http://192.168.1.1/abcd.xlsx' download='file.xlsx'>下载</a>
```

这种写法有个前提：href 的下载地址 和 当前网站地址 必须是 同源的，否则download不生效。

[使用了HTML<a>标签中的 download 属性，却出现了意外 - By DeathGhost-或者说a标签只能在同源中帮你下载就是了](http://www.deathghost.cn/article/html/94)



#### 跨域

如果不同源，还有一种方法，代码如下：

```javascript
// 封装一个download方法

const download = () => { const x = new window.XMLHttpRequest();
 x.open('GET', 'http://192.168.1.1/abcd.xlsx', true);
 x.responseType = 'blob';
 x.onload = () => { const url = window.URL.createObjectURL(x.response); const a = document.createElement('a');
 a.href = url;
 a.download = 'file.xlsx';
 a.click();
 };
 x.send();
}
```


点击下载的时候，调用以上的 download 方法即可。

还有另外一个下载音乐网站的示例

```javascript
function downloadFile(url, filename) {
    fetch(url, {
        headers: new Headers({
            Origin: location.origin,
        }),
        mode: 'cors',
    })
        .then(function (res) {
        if (res.status == 200) {
            // 返回的.blob()为promise，然后生成了blob对象，此方法获得的blob对象包含了数据类型，十分方便
            return res.blob();
        }
        throw new Error("status: ".concat(res.status, "."));
    })
        .then(function (blob) {
        download(blob, filename);
    });
}
function download(blob, filename) {
    var a = document.createElement('a');
    a.download = filename;
    var blobUrl = URL.createObjectURL(blob);
    a.href = blobUrl;
    document.body.appendChild(a);
    a.click();
    a.remove();
    URL.revokeObjectURL(blobUrl);
}
downloadFile(ap4.music.url, `${ap4.music.title}-${ap4.music.author}`)
```