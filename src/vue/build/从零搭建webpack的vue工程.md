## 下载安装node.js



## 配置node.js

这里因为node.js用的是国外的服务器

所以如果不设置一下代理

下载包的时候 你会觉得奇慢无比

所以这里需要设置一下代理

当然如果你可以越过那墙 又是另当别论了

## 全局安装webpack/vue-cli

这里使用命令行进行全局安装

### 全局安装webpack

```cmd
npm install webpack -g
```

### 全局安装vue-cli

```cmd
npm install vue-cli -g

-- 验证脚手架安装成功 在命令行中输入

vue --version
```



## 使用脚手架建立webpack项目

```cmd
vue init webpack my_vue



? Project name my_vue
? Project description learn vue ing
? Author 'HongXiaoHong' <'1908711045@qq.com'>
? Vue build standalone
? Install vue-router? Yes
? Use ESLint to lint your code? No
? Set up unit tests No
? Setup e2e tests with Nightwatch? No
? Should we run `npm install` for you after the project has been created? (recommended) npm
```

这里我遇到一个问题 那就是我直接用这种方式新建的项目 到后面出现element侧边栏无法跳转

这里使用替代的方案

那就是 [使用离线方式进行搭建](https://blog.csdn.net/feinifi/article/details/104578546)

大致的步骤是下载[github仓库中的vue-templates/webpack](https://github.com/vuejs-templates/webpack)

然后放置到当前用户的.vue-templates\webpack目录下 

我的是 C:\Users\hong\\.vue-templates\webpack

解压后名字更改为 webpack

进行vue init webpack vuedemo命令的时候，需要带上参数--offline表示离线初始化

## 加入element

```node
npm install element-ui --dev-save
```

### 使用element-ui

```vue
import ElementUi from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUi)
```



PS: 使用 100vh 撑满整个屏幕 [七个你可能不了解的CSS单位](https://www.w3cplus.com/css/7-css-units-you-might-not-know-about.html)

响应式网页设计技术很大程度上依赖于比例规则。然而，CSS比例不总是每个问题的最佳解决方案。CSS宽度是相对于最近的包含父元素。如果你想使用显示窗口的宽度或高度而不是父元素的宽度将会怎么样？这正是`vh`和`vw`单位所提供的。

`vh`等于viewport高度的`1/100`.例如，如果浏览器的高是`900px`,`1vh`求得的值为`9px`。同理，如果显示窗口宽度为`750px`,`1vw`求得的值为`7.5px`。

## 加载图片

### 1.img标签

直接使用路径即可

### 2.css-url

直接使用路径即可

### 3.el-image

使用require 先加载 然后再通过 :src  属性进行绑定

```htm
<el-carousel :interval="4000" type="card" height="250px">
      <el-carousel-item v-for="item in 5" :key="item">
        <div class="block">
          <el-image :src="imgs[item]"></el-image>
        </div>
      </el-carousel-item>
    </el-carousel>
```

```javascript
export default {
    name: 'HelloWorld',
    data() {
      let imgs = []
      imgs.push(0)
      for (let i = 0; i < 5; i++) {
        imgs.push(require('../../static/img/' + i + '.jpg'))
      }
      return {
        src: logo,
        imgs: imgs,
      }
    }
  }
```

![](D:\learn\note\ui\vue\photo\Snipaste_2020-08-23_19-39-50.jpg)

如果是外部的图片直接使用url即可



## Vue.js 目录结构

### 目录解析

| 目录/文件    | 说明                                                         |
| :----------- | :----------------------------------------------------------- |
| build        | 项目构建(webpack)相关代码                                    |
| config       | 配置目录，包括端口号等。我们初学可以使用默认的。             |
| node_modules | npm 加载的项目依赖模块                                       |
| src          | 这里是我们要开发的目录，基本上要做的事情都在这个目录里。里面包含了几个目录及文件：assets: 放置一些图片，如logo等。components: 目录里面放了一个组件文件，可以不用。App.vue: 项目入口文件，我们也可以直接将组件写这里，而不使用 components 目录。main.js: 项目的核心文件。 |
| static       | 静态资源目录，如图片、字体等。                               |
| test         | 初始测试目录，可删除                                         |
| .xxxx文件    | 这些是一些配置文件，包括语法配置，git配置等。                |
| index.html   | 首页入口文件，你可以添加一些 meta 信息或统计代码啥的。       |
| package.json | 项目配置文件。                                               |
| README.md    | 项目的说明文档，markdown 格式                                |