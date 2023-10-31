# pinia

支持 vue2 和 vue3，两者都可以使用 pinia；
语法简洁，支持 vue3 中 setup 的写法，不必像 vuex 那样定义 state、mutations、actions、getters 等，可以按照 setup Composition API  的方式返回状态和改变状态的方法，实现代码的扁平化；
支持 vuex 中 state、actions、getters 形式的写法，丢弃了 mutations，开发时候不用根据同步异步来决定使用 mutations 或 actions，pinia 中只有 actions；
对 TypeScript 支持非常友好。

## 入门
[Vue3中的pinia使用方法总结(建议收藏版)](https://www.jb51.net/article/282396.htm#_label5)

[Vue3 Vite3 状态管理 pinia 基本使用、持久化、在路由守卫中的使用](https://juejin.cn/post/7152774411571953677)

## 持久化插件

[pinia-plugin-persistedstate](https://prazdevs.github.io/pinia-plugin-persistedstate/zh/)

## 使用
### 安装
```bash
npm install pinia -S
```

### 配置
```javascript
//引入stores暴露出的pinia的实例
import pinia from './stores'

createApp(App).use(pinia).mount('#app')


```
创建stores文件夹和index.js文件

```javascript
import { createPinia } from "pinia";
const pinia = createPinia()
export default pinia

```
### 组件中使用

在stores文件夹下创建counter.js文件
```javascript
//定义关于counter的store
import {defineStore} from 'pinia'

/*defineStore 是需要传参数的，其中第一个参数是id，就是一个唯一的值，
简单点说就可以理解成是一个命名空间.
第二个参数就是一个对象，里面有三个模块需要处理，第一个是 state，
第二个是 getters，第三个是 actions。
*/
const useCounter = defineStore("counter",{
    state:() => ({
        count:66,
    }),
    
    getters: {

  	},

  	actions: {

  	}
})

//暴露这个useCounter模块
export default useCounter

```

xxx.vue 使用上面定义的 hook

```vue
<template>
	<!-- 在页面中直接使用就可以了 不用 .state-->
  <div>展示pinia的counter的count值：{{counterStore.count}}</div>

</template>

<script setup>
// 首先需要引入一下我们刚刚创建的store
import useCounter from '../stores/counter'
// 因为是个方法，所以我们得调用一下
const counterStore = useCounter()

</script>

```

如果需要解构, 仍然需要响应式则需要使用 storeToRefs

