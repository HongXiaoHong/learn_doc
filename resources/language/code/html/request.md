# html 请求

## fetch

[当 fetch 遇到 302 状态码，会发生什么？ ](https://blog.csdn.net/VhWfR2u02Q/article/details/86671482)

我下载音乐磁场 音乐的时候碰到一个下载的问题

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

先请求音乐磁场这个链接,

```log
请求 URL:
https://www.hifini.com/get_music.php?key=iiUaP70ICa8R1WKdQ05AVnUJyB5uxahUp2CocCvzUG/bsdauCYYwQla0QiWn3O5gW3qOfRMdzfS9Cl7+nFc
请求方法:
GET
状态代码:
302 Found
远程地址:
127.0.0.1:8080
引用者策略:
strict-origin-when-cross-origin
```

然后请求 QQ 音乐的链接

```log

请求 URL:
https://ws.stream.qqmusic.qq.com/C400004a4j2U3sKS8K.m4a?guid=625711938&vkey=834441DC707DA15BB938DC0C2DB350D77A1A2C50BB197872147F70134A362D7BEE48C69BDF204C3304221B52C04771827C1D0D178AFF31BE&uin=626567678&fromtag=103032
请求方法:
GET
状态代码:
200 OK
远程地址:
113.219.183.187:443
引用者策略:
strict-origin-when-cross-origin
```

fetch 遇到 302 是透明的, fetch 可以拿到 302 重定向之后接口的数据

### fetch 如何处理 302？

#### 配置 fetch 的 redirect

fetch 的 options 配置项`redirect`，用于配置可用的 redirect 模式。

redirect 的值有:

- follow：默认, 自动重定向；
- error：如果产生重定向将自动终止并且抛出一个错误；
- manual：手动处理重定向；

[前端 - fetch 如何处理 302？ - 个人文章 - SegmentFault 思否](https://segmentfault.com/a/1190000041300989#item-4-1)
