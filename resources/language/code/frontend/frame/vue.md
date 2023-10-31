# vue

## todo

vue2/vue3

- [x] 虚拟 dom
  - [x]  [Vue的diff算法之50k前端大牛教你面试_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1XL411o7md/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)
 
具体的diff算法有空再了解一下吧
## 正文


[vue怎么在新窗口打开页面或者弹出新页面](https://www.cnblogs.com/yysbolg/p/13539036.html)

我是这么做的

```html
<a :href="project.link" target="_blank">
                <v-btn color="orange-lighten-2" variant="text"> Explore</v-btn>
              </a>
```



### nginx 部署 vue

[利用nginx部署vue项目的全过程_vue.js_脚本之家 (jb51.net)](https://www.jb51.net/article/241964.htm)



通过 build 得到 dist 网站的静态资源

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/webstorm64_49OAOKKz1Q.png)



配置nginx.conf

```properties

```

### 原理
#### 虚拟 dom
https://juejin.cn/post/6844903870229905422#heading-21
虚拟 DOM 到底是什么？
虚拟 DOM （Virtual DOM ）这个概念相信大家都不陌生，从 React 到 Vue ，虚拟 DOM 为这两个框架都带来了跨平台的能力（React-Native 和 Weex）。因为很多人是在学习 React 的过程中接触到的虚拟 DOM ，所以为先入为主，认为虚拟 DOM 和 JSX 密不可分。其实不然，虚拟 DOM 和 JSX 固然契合，但 JSX 只是虚拟 DOM 的充分不必要条件，Vue 即使使用模版，也能把虚拟 DOM 玩得风生水起，同时也有很多人通过 babel 在 Vue 中使用 JSX。
很多人认为虚拟 DOM 最大的优势是 diff 算法，减少 JavaScript 操作真实 DOM 的带来的性能消耗。虽然这一个虚拟 DOM 带来的一个优势，但并不是全部。虚拟 DOM 最大的优势在于抽象了原本的渲染过程，实现了跨平台的能力，而不仅仅局限于浏览器的 DOM，可以是安卓和 IOS 的原生组件，可以是近期很火热的小程序，也可以是各种GUI。
回到最开始的问题，虚拟 DOM 到底是什么，说简单点，就是一个普通的 JavaScript 对象，包含了 tag、props、children 三个属性。


## 项目创建

### vue-cli 与 create-vue
[Vue CLI](https://cli.vuejs.org/zh/guide/creating-a-project.html)

[create-vue](https://github.com/vuejs/create-vue)
 Vue CLI 现已处于维护模式!

现在官方推荐使用 create-vue 来创建基于 Vite 的新项目。 另外请参考 Vue 3 工具链指南 以了解最新的工具推荐。

```bash
npm create vue@latest
```