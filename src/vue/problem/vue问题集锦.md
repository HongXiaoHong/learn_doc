vue问题集锦

[vue报错之Duplicate keys detected: '0'. This may cause an update error.](https://www.cnblogs.com/songForU/p/10551037.html)



遍历过程中只显示一张图片

怀疑是没有时间戳的关系 然后从缓存中直接拿了图片 而没有从后台再次请求

导致只有一张图片显示的问题

[SpringBoot Controller接收参数的几种常用方式](https://blog.csdn.net/suki_rong/article/details/80445880)

[Vue获取DOM元素并修改属性](https://blog.csdn.net/m0_37686205/article/details/96130534)

之后实现每次跳过一张图片的时候更新下一张图片

不过这里的实现方法方法有待改进 

因为控制台出现错误了

```javascript
vue.esm.js?efeb:628 [Vue warn]: Avoid mutating a prop directly since the value will be overwritten whenever the parent component re-renders. Instead, use a data or computed property based on the prop's value. Prop being mutated: "src"

found in

---> <ElImage> at packages/image/src/main.vue
       <ElCarouselItem> at packages/carousel/src/item.vue
         <ElCarousel> at packages/carousel/src/main.vue
           <SearchFile> at src/components/pages/File/SearchFile.vue
             <ElMain> at packages/main/src/main.vue
               <ElContainer> at packages/container/src/main.vue... (1 recursive calls)
                 <App> at src/App.vue
                   <Root>
```

这里报错的原因是
传入的prop中的值是不允许改变的

直接我想修改图片的url 这里我直接使用修改el-image的属性 结果出现该错误 
```javascript
this.$refs.randomImage[(val+1)%5].$children[0].src = "/api/image/random/memory/" + new Date().getTime();
```

后面看到一个博客
[[Vue warn]: Avoid mutating a prop directly since the value will be overwritten](https://blog.csdn.net/u014520745/article/details/75455979)

里面提到的就是我们最好不要直接修改页面元素的属性值

而是最好绑定一个变量 
然后我们修改该变量的值

紧接着图片的url就会随之改变
一开始我试着这么做 结果发现并没有成功
```javascript
let urls = [];
let index = 0;
for (; index < 6; index++) {
urls.push("/api/image/random/memory/" + index);
}


this.urls[(val+1)%5] = "/api/image/random/memory/" + new Date().getTime();
```
后面值改变了也没用

之后我将放进去的变为映射（字典） 就可以了

```javascript
let urls = [];
let index = 0;
for (; index < 6; index++) {
let imgUrl = {"url": "/api/image/random/memory/" + index}
urls.push(imgUrl);
}

this.urls[(val+1)%5].url = "/api/image/random/memory/" + new Date().getTime();
```

## vue跨域

[vue跨域解决方法](https://www.cnblogs.com/wangyongcun/p/7665687.html)



## axios get方式请求

[vue+axios中的get请求传参，post请求头（form/json）不一样的传参的处理](https://blog.csdn.net/weixin_39701533/article/details/83744448?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-3.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-3.channel_param)

## 
### 错误信息
(Emitted value instead of an instance of Error) <el-collapse-item v-for="question in questions">: component lists render
ed with v-for should have explicit keys. See https://vuejs.org/guide/list.html#key for more info.

修改前
```html
<template>
  <div class="block" id="brush">
    <el-collapse v-model="activeName" accordion>
      <el-collapse-item v-for="(question, index) in questions" :title="question.title" :name="index" >
        <div v-for="content in question.contents">{{content}}</div>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>
```
加上:key="index"
修改后

```html
<template>
  <div class="block" id="brush">
    <el-collapse v-model="activeName" accordion>
      <el-collapse-item v-for="(question, index) in questions" :title="question.title" :name="index" :key="index">
        <div v-for="content in question.contents">{{content}}</div>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>
```
### vue中使用element-ui组件中的el-button时，@click事件点击无效
[vue中使用element-ui组件中的el-button时，@click事件点击无效](https://blog.csdn.net/weixin_39378691/article/details/88795900?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param)

### loader解析

```html
Module parse failed: Unexpected character ' ' (1:0) You may need an appropriate loader to handle this file type. (Source code omitted for this binary file)
```

#### 解决
[You may need an appropriate loader to handle this file type](https://blog.csdn.net/qq_34817440/article/details/105113836?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)

### 更换浏览器icon
[VUE设置浏览器icon图标](https://blog.csdn.net/brain_bo/article/details/80645971)

### cli 如何从2升级到3
[Vue-cli 如何从2.9.6 版本升级至3.0](https://segmentfault.com/q/1010000016687692)
[vue-cli3.0升级失败，vue-cli卸载不掉，vue-cli升级不了3.0_路径](https://juejin.im/post/6844903720954626056)

[npm 安装yarn](https://blog.csdn.net/qq_36838191/article/details/98038890)

*important*
[安装官网vue-cli的方式竟然真的可以安装成功](https://vuetifyjs.com/en/getting-started/installation/)

[Webpack4 升级全教程](https://blog.csdn.net/qq_25243451/article/details/80331269?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)

[创建基于webpack打包的vue项目](https://blog.csdn.net/qq_35393869/article/details/83090578)