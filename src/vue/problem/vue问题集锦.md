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

## vue跨域

[vue跨域解决方法](https://www.cnblogs.com/wangyongcun/p/7665687.html)



## axios get方式请求

[vue+axios中的get请求传参，post请求头（form/json）不一样的传参的处理](https://blog.csdn.net/weixin_39701533/article/details/83744448?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-3.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-3.channel_param)