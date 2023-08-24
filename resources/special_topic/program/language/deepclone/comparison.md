# 各个语言深拷贝对比



## js

https://www.cnblogs.com/konglxblog/p/16644927.html

## 为什么要进行深拷贝

还是那个老生常谈的事情，要搞明白一个东西要怎么用之前，先要想清楚为什么我们需要它；

呃…在这里我就不啰嗦那么多了（🎈相信大家主要是过来看实现方法的🎈）

深拷贝就是相对与浅拷贝而言的，最主要的差异体现在引用类型上，从本质上讲就是浅拷贝只简简单单地把栈当中的引用地址拷贝了一份，所以当你修改新拷贝出来的值的时候，被拷贝的对象也会被你修改掉；而深拷贝是会在堆内存当中为新对象建立空间，所以被拷贝的对象就不会被无缘无故地被修改掉了。

那怎么实现深拷贝呢？ 请看下文👇👇👇

## 如何实现深拷贝

### `Object.assign`

`Object.assign`默认是对对象进行深拷贝的，但是我们需要注意的是，它只对最外层的进行深拷贝，也就是当对象内嵌套有对象的时候，被嵌套的对象进行的还是浅拷贝；

```js
function cloneDeepAssign(obj){
  return Object.assign({},obj)
  //Object.assign({},obj)
}
复制代码
```

（温馨提示：数组拷贝方法当中，使用`...`、`slice`、`concat`等进行拷贝也是一样的效果，只深拷贝最外层）

同时，我们知道`Object.assign`针对的是对象自身可枚举的属性，对于不可枚举的没有效果；

所以，当我们对于一个层次单一对象的时候，可以考虑这种方法，简单快捷。（试过了，也不支持`undefined`）

### `JSON`实现的深拷贝

这是我们最最最常提到的一种深拷贝的方式，一般大部分的深拷贝都可以用`JSON`的方式进行解决，本质是因为`JSON`会自己去构建新的内存来存放新对象。

```js
function cloneDeepJson(obj){
  return JSON.parse(JSON.stringify(obj))
}
复制代码
```

但是我们要注意的是：

- 会忽略 `undefined`和`symbol`；
- 不可以对`Function`进行拷贝，因为`JSON`格式字符串不支持`Function`，在序列化的时候会自动删除；
- 诸如 `Map`, `Set`, `RegExp`, `Date`, `ArrayBuffer`和其他内置类型在进行序列化时会丢失；
- 不支持循环引用对象的拷贝;（循环引用的可以大概地理解为一个对象里面的某一个属性的值是它自己）

### `jQuery`的`extend`

```js
var array = [1,2,3,4];
var newArray = $.extend(true,[],array);
复制代码
```

显而易见，最大的缺点就是我们还需要引入`jQuery`库了，所以也不太常用；感兴趣的友友，可以为您指路->[$.extend([d],tgt,obj1,[objN]) | jQuery API 3.2 中文文档 | jQuery API 在线手册 (cuishifeng.cn)](https://link.juejin.cn/?target=https%3A%2F%2Fjquery.cuishifeng.cn%2FjQuery.extend.html "https://jquery.cuishifeng.cn/jQuery.extend.html")

### `MessageChannel`

```javascript
function deepCopy(obj) {
  return new Promise((resolve) => {
    const {port1, port2} = new MessageChannel();
    port2.onmessage = ev => resolve(ev.data);
    port1.postMessage(obj);
  });
}
deepCopy(obj).then((copy) => {// 异步的

let copyObj = copy;

console.log(copyObj, obj)

console.log(copyObj == obj)

});

复制代码
```

（个人感觉这种方法还挺有意思的，如果面试的讲出来的话，应该会给面试官一个小惊喜🙌）

缺点：最大的缺点就是异步的，同时也无法支持`Function`

另外，如果对`MessageChannel`感兴趣的友友，为您推荐一篇简单易懂的小文章->[MessageChannel是什么，怎么使用？ - 简书 (jianshu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fwww.jianshu.com%2Fp%2F4f07ef18b5d7 "https://www.jianshu.com/p/4f07ef18b5d7")

### 递归实现

```js
function cloneDeepDi(obj){
  const newObj = {};
  let keys = Object.keys(obj);
  let key = null;
  let data = null;
  for(let i = 0; i<keys.length;i++){
    key = keys[i];
    data = obj[key];
    if(data && typeof data === 'object'){
      newObj[key] = cloneDeepDi(data)
    }else{
      newObj[key] = data;
    }
  }
  return newObj
}
复制代码
```

这也是我们最最最最常用的一种解决方案，面试必备，所以扪心自问，你把它写的滚瓜烂熟了嘛？

虽然但是，它也是有缺点的，就是不能解决循环引用的问题，一旦出现了循环引用，就死循环了！

### 解决循环引用的递归实现

```javascript
function deepCopy(obj, parent = null) {
    // 创建一个新对象
    let result = {};
    let keys = Object.keys(obj),
        key = null,
        temp = null,
        _parent = parent;
    // 该字段有父级则需要追溯该字段的父级
    while (_parent) {
        // 如果该字段引用了它的父级则为循环引用
        if (_parent.originalParent === obj) {
            // 循环引用直接返回同级的新对象
            return _parent.currentParent;
        }
        _parent = _parent.parent;
    }
    for (let i = 0; i < keys.length; i++) {
        key = keys[i];
        temp = obj[key];
        // 如果字段的值也是一个对象
        if (temp && typeof temp === 'object') {
            // 递归执行深拷贝 将同级的待拷贝对象与新对象传递给 parent 方便追溯循环引用
            result[key] = DeepCopy(temp, {
                originalParent: obj,
                currentParent: result,
                parent: parent
            });

    } <span class="hljs-keyword">else</span> {
        result[key] = temp;
    }
}
<span class="hljs-keyword">return</span> result;


    } <span class="hljs-keyword">else</span> {
        result[key] = temp;
    }
}
<span class="hljs-keyword">return</span> result;
}

复制代码
```

大致的思路是：判断一个对象的字段是否引用了这个对象或这个对象的任意父级，如果引用了父级，那么就直接返回同级的新对象，反之，进行递归的那套流程。

但其实，还有一种情况是没有解决的，就是子对象间的互相引用，不理解什么意思的友友，可以看->[Javascript之深拷贝 - 知乎 (zhihu.com)](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F23251162 "https://zhuanlan.zhihu.com/p/23251162")的后半部分的内容，对应也写给出来解决方案；（鄙人懒，就不赘述了🤶）

### [lodash](https://link.juejin.cn/?target=https%3A%2F%2Flodash.com%2F "https://lodash.com/")的`_.cloneDeep()`

```js
var _ = require('lodash');
var obj1 = {
    a: 1,
    b: { f: { g: 1 } },
    c: [1, 2, 3]
};
var obj2 = _.cloneDeep(obj1);
console.log(obj1.b.f === obj2.b.f);// false
复制代码
```

这是最最最最完美的深拷贝的方式，它已经将会出现问题的各种情况都考虑在内了，所以在日常项目开发当中，建议使用这种成熟的解决方案；关于原理分析，鄙人无能，只能为各位大佬指个路:

[Lodash](https://link.juejin.cn/?target=https%3A%2F%2Flodash.com%2F "https://lodash.com/")

[lodash.cloneDeep | Lodash 中文文档 | Lodash 中文网 (lodashjs.com)](https://link.juejin.cn/?target=https%3A%2F%2Fwww.lodashjs.com%2Fdocs%2Flodash.cloneDeep%2F "https://www.lodashjs.com/docs/lodash.cloneDeep/")

[BlogPosts/lodash深拷贝源码探究.md at master · moyui/BlogPosts · GitHub](https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fmoyui%2FBlogPosts%2Fblob%2Fmaster%2F2018%2Flodash%25E6%25B7%25B1%25E6%258B%25B7%25E8%25B4%259D%25E6%25BA%2590%25E7%25A0%2581%25E6%258E%25A2%25E7%25A9%25B6.md "https://github.com/moyui/BlogPosts/blob/master/2018/lodash%E6%B7%B1%E6%8B%B7%E8%B4%9D%E6%BA%90%E7%A0%81%E6%8E%A2%E7%A9%B6.md")

注：其实lodash解决循环引用的方式，就是用一个栈记录所有被拷贝的引用值，如果再次碰到同样的引用值的时候，不会再去拷贝一遍，而是利用之前已经拷贝好的。🖖🖖

## 总结

其实了解了以上的方式就已经非常够用了；重点记住，在日常生产环境当中，使用完美方案—`lodash.cloneDeep`，面试问起来的话，重点使用递归实现，JSON、Object.assgin、MessageChannel都可以作为补充，这基本上就已经回答的非常好了。

本文重点的内容其实到这里就结束了，后面是补充一些不太常用的方法，感兴趣的友友可以继续了解

## 补充一些不太主流的方法

### 对象各种方法的应用

```javascript
let deepClone = function (obj) {
    let copy = Object.create(Object.getPrototypeOf(obj));
    let propNames = Object.getOwnPropertyNames(obj);
    propNames.forEach(function (items) {
        let item = Object.getOwnPropertyDescriptor(obj, items);
        Object.defineProperty(copy, items, item);

});
<span class="hljs-keyword">return</span> copy;


});
<span class="hljs-keyword">return</span> copy;
};

复制代码
```

### `for..in.`与`Object.create`结合实现

```js
function deepClone(initalObj, finalObj) {   
    var obj = finalObj || {};   
    for(var i in initalObj) {       
    var prop = initalObj[i];        // 避免相互引用对象导致死循环，如initalObj.a = initalObj的情况
    if(prop === obj)  continue;      
    if(typeof prop === 'object') {
            obj[i] = (prop.constructor === Array) ? [] : Object.create(prop);
        } else {
          obj[i] = prop;
        }
    }   
    return obj;
}
复制代码
```

### History API

利用history.replaceState。这个api在做单页面应用的路由时可以做无刷新的改变url。这个对象使用结构化克隆，而且是同步的。但是我们需要注意，在单页面中不要把原有的路由逻辑搞乱了。所以我们在克隆完一个对象的时候，要恢复路由的原状。

```go
function structuralClone(obj) {
   const oldState = history.state;
   const copy;
   history.replaceState(obj, document.title);
   copy = history.state;
   history.replaceState(oldState, document.title); 
   return copy;
}


var obj = {};

var b = {obj};

obj.b = b


var copy = structuralClone(obj);

console.log(copy);

复制代码
```

这个方法的优点是。能解决循环对象的问题，也支持许多内置类型的克隆。并且是同步的。但是缺点就是有的浏览器对调用频率有限制。比如Safari 30 秒内只允许调用 100 次

### Notification API

这个api主要是用于桌面通知的。如果你使用Facebook的时候，你肯定会发现时常在浏览器的右下角有一个弹窗，对就是这家伙。我们也可以利用这个api实现js对象的深拷贝。

```javascript
function structuralClone(obj) { 
  return new Notification('', {data: obj, silent: true}).data;
}
var obj = {};
var b = {obj};
obj.b = b
var copy = structuralClone(obj);

console.log(copy)

复制代码
```

同样是优点和缺点并存，优点就是可以解决循环对象问题，也支持许多内置类型的克隆，并且是同步的。缺点就是这个需要api的使用需要向用户请求权限，但是用在这里克隆数据的时候，不经用户授权也可以使用。在http协议的情况下会提示你再https的场景下使用。

参考资料：

[壹.3.1 深拷贝与浅拷贝 - 前端内参 (gitbook.io)](https://link.juejin.cn/?target=https%3A%2F%2Fcoffe1891.gitbook.io%2Ffrontend-hard-mode-interview%2F1%2F1.3.1 "https://coffe1891.gitbook.io/frontend-hard-mode-interview/1/1.3.1")

[深拷贝的三种实现方式是什么-常见问题-PHP中文网](https://link.juejin.cn/?target=https%3A%2F%2Fwww.php.cn%2Ffaq%2F465102.html%23%3A~%3Atext%3D%25E6%25B7%25B1%25E6%258B%25B7%25E8%25B4%259D%25E7%259A%2584%25E4%25B8%2589%25E7%25A7%258D%25E5%25AE%259E%25E7%258E%25B0%2Cxtend%25E6%2596%25B9%25E6%25B3%2595%25E3%2580%2582 "https://www.php.cn/faq/465102.html#:~:text=%E6%B7%B1%E6%8B%B7%E8%B4%9D%E7%9A%84%E4%B8%89%E7%A7%8D%E5%AE%9E%E7%8E%B0,xtend%E6%96%B9%E6%B3%95%E3%80%82")





## java

- Cloneable

- 序列化跟反序列化

spring 的 beanutils 是使用浅拷贝

如果我们要实现深拷贝

要么实现 Cloneable 接口

然后重写 clone 方法

另外比较简单的方法那就是进行序列化跟反序列化

最简单那当然是继承 Serizable

或者使用  json 序列化

又或者使用 hessian2 或者 protobuf 进行序列化

这两个序列化方式都是采用二进制

比起 java 本身的序列化以及 json 序列化方式有更好的性能