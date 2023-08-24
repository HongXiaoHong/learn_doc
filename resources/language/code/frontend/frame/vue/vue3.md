# vue3

[(39条消息) vue3的setup函数中定义data数据，使用data数据_vue3 data_半里_辰昏的博客-CSDN博客](https://blog.csdn.net/weixin_46764819/article/details/128275312)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_JbTY9Lr13w.png)



### vue3 vite 引入图片

[(39条消息) vue3+vite assets动态引入图片的几种方式，解决打包后图片路径错误不显示的问题_Young丶的博客-CSDN博客](https://andyoung.blog.csdn.net/article/details/125894867?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-125894867-blog-119816311.235%5Ev38%5Epc_relevant_anti_vip&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-125894867-blog-119816311.235%5Ev38%5Epc_relevant_anti_vip&utm_relevant_index=1)

>  vite 官方默认的配置，如果资源文件在assets文件夹打包后会把图片名加上 hash值，但是直接通过 :src="imgSrc"方式引入并不会在打包的时候解析，导致开发环境可以正常引入，打包后却不能显示的问题
> 
> 这里我们先看看vite官方文档的解释：
> https://vitejs.bootcss.com/guide/assets.html
> 
> 我们看到实际上我们不希望资源文件被wbpack编译可以把图片放到public 目录会更省事，不管是开发环境还是生产环境，可以始终以根目录保持图片路径的一致，这点跟webpack是一致的
> 



实测放到 public 中是可以的, 不会帮我加上一串数字, 

build 之后也是直接放到 dist 目录下

通过 nginx 代理也可以直接访问到了, nice


## 异步组件

vue异步组件(高级异步组件)使用场景及实践
https://segmentfault.com/a/1190000012138052

Vue.js 异步组件在以下场景中非常有用：

1. **延迟加载大型组件**：如果你的应用有一些比较大的组件，可能会影响初始加载时间，你可以将它们设置为异步组件。这样，在初始加载时，这些组件不会被立即加载，只有当需要使用它们时才会进行加载。

2. **按需加载路由组件**：当使用 Vue Router 管理路由时，你可以使用异步组件来按需加载特定路由的组件。这可以有效地减少初始页面加载时间，只有在用户导航到某个特定路由时才会加载该路由的组件。

3. **模态框和对话框**：如果你有一些模态框、对话框或弹出窗口，你可以将它们设置为异步组件。这样可以避免在初始加载时就加载这些不常用的组件，从而提高页面加载性能。

4. **Tab 组件或选项卡**：类似于模态框，如果你有一个包含多个选项卡的组件，你可以将每个选项卡的内容设置为异步组件。这样用户只有在切换到某个选项卡时才会加载该选项卡的内容。

5. **动态数据获取组件**：有些组件可能需要根据不同的数据源进行渲染。在这种情况下，你可以将组件的渲染逻辑设置为异步组件，以便根据数据源的变化动态加载不同的组件内容。

6. **条件渲染组件**：如果你有一些在特定条件下才会显示的组件，你可以将它们设置为异步组件。这样可以避免在不需要显示它们的情况下加载不必要的组件。

需要注意的是，异步组件在某些情况下可能会引入一些代码拆分和加载的复杂性。确保你在使用异步组件时考虑好组件之间的依赖关系，以及在需要时进行适当的代码拆分和加载控制，以避免不必要的性能问题。