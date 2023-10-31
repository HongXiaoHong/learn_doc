# javascript 常用代码

## 下载 音乐磁场 音乐


a 标签的 download 属性, 可以用来下载同源的文件
因为 a 标签的 download 属性不支持跨域的文件
我这里请求的 url 虽然跟音乐磁场同源, 但是这里会进行 302 暂时重定向到另一个界面
所以得先用 fetch 进行获取文件的内容
转换为 blob 对象之后

1. 使用浏览器默认的路径下载
2. 弹出文件路径进行选择后下载
### 使用浏览器默认的路径下载
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


### 弹出文件路径进行选择后下载

参考: https://juejin.cn/post/7057802776805392392

包含选项的可选对象，如下所示：

excludeAcceptAllOption： Boolean 默认 false。默认情况下，选择器应包含一个选项以不应用任何文件类型过滤器（由下面的类型选项发起）。将此选项设置为true意味着该选项_不可_用。

suggestedName： String 建议的文件名。

startIn： String  可选值 

desktop: 桌面
documents: 文档
downloads: 下载
music: 音乐
pictures: 图像
videos: 视频

types：Array 允许保存的文件类型。每个项目都是具有以下选项的对象 

description：允许的文件类型类别的可选描述。

accept:Object键设置为MIME 类型，值设置Array为文件扩展名（参见下面的示例）。
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
async function download(blob, filename) {
    const pickerOpts = {
  types: [
    {
      description: "Musics",
      accept: {
        "image/*": [".m4a", ".mp3"],
      },
    },
  ],
  excludeAcceptAllOption: true,
  multiple: false,
  suggestedName: filename,
};
  // 创建一个新句柄
  const newHandle = await window.showSaveFilePicker(pickerOpts);

  // 创建一个 FileSystemWritableFileStream 用于写入
  const writableStream = await newHandle.createWritable();

  // 写入我们的文件
  await writableStream.write(blob);

  // 关闭文件并将内容写入到磁盘
  await writableStream.close();
}
downloadFile(ap4.music.url, `${ap4.music.title}-${ap4.music.author}`)
```


## 剪切板

[js复制方法navigator.clipboard兼容性处理，控制台直接执行报错 DOMException: Document is not focused](https://blog.csdn.net/qq_32442967/article/details/125612971)