# html web worker

[Web Worker API](https://developer.mozilla.org/zh-CN/docs/Web/API/Web_Workers_API)
Worker 类型
有许多不同类型的 worker：

专用 worker 是由单个脚本使用的 worker。该上下文由 DedicatedWorkerGlobalScope 对象表示。
Shared worker 是可以由在不同窗口、IFrame 等中运行的多个脚本使用的 worker，只要它们与 worker 在同一域中。它们比专用的 worker 稍微复杂一点——脚本必须通过活动端口进行通信。
Service Worker 基本上是作为代理服务器，位于 web 应用程序、浏览器和网络（如果可用）之间。它们的目的是（除开其他方面）创建有效的离线体验、拦截网络请求，以及根据网络是否可用采取合适的行动并更新驻留在服务器上的资源。它们还将允许访问推送通知和后台同步 API。


## 专用 worker
## Shared worker
## Service Worker

https://developer.mozilla.org/zh-CN/docs/Web/API/Service_Worker_API
Service worker 本质上充当 Web 应用程序、浏览器与网络（可用时）之间的代理服务器。这个 API 旨在创建有效的离线体验，它会拦截网络请求并根据网络是否可用来采取适当的动作、更新来自服务器的的资源。它还提供入口以推送通知和访问后台同步 API。
可以在网站断网或者弱网的时候充当缓存

学习视频:
【PWA】什么是 PWA （progressive web app）
https://www.bilibili.com/video/BV19Y411C79s/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209
【PWA 教程】Service Worker 初探

https://www.bilibili.com/video/BV1it411U7Fz/?spm_id_from=333.788.recommend_more_video.0

【PWA 教程】Service Worker 应用 
https://www.bilibili.com/video/BV1Bt411U7xj/?spm_id_from=autoNext&vd_source=eabc2c22ae7849c2c4f31815da49f209