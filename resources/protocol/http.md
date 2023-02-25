# http



## 请求头

### Accept | 告知（服务器）客户端可以处理的内容类型

[Accept - HTTP | MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Accept)

Accept 请求头用来告知（服务器）客户端可以处理的内容类型，这种内容类型用MIME 类型来表示。借助内容协商机制, 服务器可以从诸多备选项中选择一项进行应用，并使用 Content-Type 应答头通知客户端它的选择。浏览器会基于请求的上下文来为这个请求头设置合适的值，比如获取一个 CSS 层叠样式表时值与获取图片、视频或脚本文件时的值是不同的。


