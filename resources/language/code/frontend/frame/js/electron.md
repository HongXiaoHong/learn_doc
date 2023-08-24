# electron

https://front-end.toimc.com/notes-page/project/community-electron/#%E5%B8%B8%E8%A7%81%E7%9A%84gui%E5%B7%A5%E5%85%B7

## hello

[Electron 跨平台桌面应用开发与打包 – Jacky's Blog (jackyu.cn)](https://jackyu.cn/tech/electron-vue-app/)

这个博主说最好使用 yarn 

npm 可能有点问题, 待验证

但是本身在墙外应该就不怕吧

[Electron在Windows下打包不同平台应用_51CTO博客_electron 打包exe](https://blog.51cto.com/u_15127808/5510142)

```bash
electron-packager . app --win --out YourAppName --arch=x64 --electron-version 9.0.5 --overwrite --ignore=node_modules

```

不推荐使用​​electron-packager . --platform=win32 --arch=x64 --electron-version=9.0.5​​，因为这个命令会让打包出来的包很大。





## 核心概念

主进程与渲染进程

主进程：启动项目时运行的 main.js 脚本就是我们说的主进程。在主进程运行的脚本可以以创建 web 页面的形式展示 GUI，主进程只有一个
渲染进程： 每个 Electron 的页面都在运行着自己的进程，这样的进程称之为渲染进程（基于Chromium的多进程结构）。

## 常见的打包方案

electron-packager
electron-builder(推荐)
Electron-forge



#### forge

[Electron Forge 打包并分发您的应用程序 - zhang_you_wu - 博客园 (cnblogs.com)](https://www.cnblogs.com/zhangyouwu/p/17149767.html)

最快捷的打包方式是使用 [Electron Forge](https://www.electronforge.io/)。

文档地址

https://www.electronjs.org/zh/docs/latest/tutorial/quick-start

1.将 Electron Forge 添加到您应用的开发依赖中，并使用其"import"命令设置 Forge 的脚手架：

npm install --save-dev @electron-forge/cli
npx electron-forge import

2.使用 Forge 的 `make` 命令来创建可分发的应用程序

npm run make

Electron-forge 会创建 `out` 文件夹，您的软件包将在那里找到；

参考

[Electron 跨平台桌面应用开发与打包 – Jacky's Blog (jackyu.cn)](https://jackyu.cn/tech/electron-vue-app/)