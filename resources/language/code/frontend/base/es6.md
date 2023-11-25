# es6

[新特性](https://blog.csdn.net/asd577007722/article/details/115190895#:~:text=es6%E6%96%B0%E5%A2%9E%E7%89%B9%E6%80%A7%201.let%E5%92%8Cconst%E5%85%B3%E9%94%AE%E5%AD%97,2.%E8%A7%A3%E6%9E%84%E8%B5%8B%E5%80%BC%203.%E7%AE%AD%E5%A4%B4%E5%87%BD%E6%95%B0%204.%E6%A8%A1%E6%9D%BF%E5%AD%97%E7%AC%A6%E4%B8%B2%EF%BC%9A%E4%BD%BF%E7%94%A8%E5%8F%8D%E5%BC%95%E5%8F%B7%60%60%E4%BB%A3%E6%9B%BF%E5%8F%8C%E5%BC%95%E5%8F%B7%E5%88%9B%E5%BB%BA%E5%AD%97%E7%AC%A6%E4%B8%B2)

## 导入导出
在 ES6 中，有一种新的导入导出模块的语法。这让你能更方便地将代码分割成可复用的模块。下面是如何在 ES6 中导入导出模块的一些基本方法：

**导出模块**

- \*\*命名导出（Named export）：\*\*你可以导出一个或多个具体的功能或值。
  
  ```
  javascript// myfile.js
  export const myVariable = "I am exported!";
  export function myFunction() {
    return "I am also exported!";
  }
  ```
  
- \*\*默认导出（Default export）：\*\*每个模块都可以有一个默认导出。默认导出可以是任何类型的值（函数、对象、字符串等）。一个模块只能有一个默认导出。
  
  ```
  javascript// myfile.js
  const myVariable = "I am exported!";
  export default myVariable;
  ```
  
  或者直接这样写：
  
  ```
  javascript// myfile.js
  export default "I am exported!";
  ```
  

**导入模块**

- \*\*导入命名导出：\*\*要导入命名导出的值，你需要在 `import` 语句中使用大括号 `{}` 包裹它们的名称。
  
  ```javascript
  // anotherfile.js
  import { myVariable, myFunction } from './myfile.js';
  console.log(myVariable); // "I am exported!"
  console.log(myFunction()); // "I am also exported!"
  ```
  
- \*\*导入默认导出：\*\*导入默认导出的值时，你可以给它们任何你想要的名称，而且不需要使用大括号 `{}`。
  
  ```javascript
  // anotherfile.js
  import myVariable from './myfile.js';
  console.log(myVariable); // "I am exported!"
  ```
  
- **同时导入默认导出和命名导出：**
  
  ```javascript
  // anotherfile.js
  import myDefault, { myVariable, myFunction } from './myfile.js';
  console.log(myDefault); // "I am exported!"
  console.log(myVariable); // "I am exported!"
  console.log(myFunction()); // "I am also exported!"
  ```
  

这就是如何在 ES6 中使用导入导出模块的基本语法。注意，你的环境需要支持 ES6 模块语法，否则你可能需要使用一些工具（如 Babel 和 Webpack）来转译和打包你的代码。

import 之后出现 Uncaught SyntaxError: Cannot use import statement outside a module (at scripts.js:1:1)import 之后出现 未捕获的语法错误：无法在模块外部使用导入语句（在脚本.js：1：1）

出现 "Uncaught SyntaxError: Cannot use import statement outside a module" 这个错误，往往是因为你正在试图在一个脚本中使用 ES6 的 `import` 语句，但是这个脚本并没有被当做模块去处理。

在HTML中，所有的 `<script>` 标签默认情况下都被当做脚本去处理，而不是模块。如果你想使用 `import` 语句，你需要将你的 `<script>` 标签的 `type` 属性设为 `"module"`。例如：

```html
<script type="module" src="scripts.js"></script>
```

这样就告诉浏览器，`scripts.js` 是一个 ES6 模块，应该允许使用 `import` 和 `export` 语句。

另一点需要注意的是，ES6 模块在浏览器中默认使用严格模式（strict mode），并且有自己的独立的作用域。也就是说，在一个模块中定义的变量，除非被明确地导出，否则不会污染全局作用域。

还有一个注意点是，模块通过 CORS（跨源资源共享）策略加载，这意味着如果你在本地开发，你可能需要设置一个本地服务器来托管你的文件，而不能直接从文件系统打开HTML文件，否则可能会遇到跨源问题。对于简单的本地开发，你可以使用像是 [http-server](https://www.npmjs.com/package/http-server) 或 [live-server](https://www.npmjs.com/package/live-server) 这样的工具。

### 模块
ES6模块和CommonJS模块有哪些差异
https://github.com/YvetteLau/Step-By-Step/issues/43

  CommonJS
        var a = {age:12}; a.age = 13 b = a;
        对于基本数据类型，属于复制。即会被模块缓存。同时，在另一个模块可以对该模块输出的变量重新赋值。
        对于复杂数据类型，属于浅拷贝。由于两个模块引用的对象指向同一个内存空间，因此对该模块的值做修改时会影响另一个模块。
        当使用require命令加载某个模块时，就会运行整个模块的代码。
        当使用require命令加载同一个模块时，不会再执行该模块，而是取到缓存之中的值。也就是说，CommonJS模块无论加载多少次，都只会在第一次加载时运行一次，以后再加载，就返回第一次运行的结果，除非手动清除系统缓存。
        运行时加载。


    ES6
        ES6模块中的值属于【动态只读引用】。
        对于只读来说，即不允许修改引入变量的值，import的变量是只读的，不论是基本数据类型还是复杂数据类型。当模块遇到import命令时，就会生成一个只读引用。等到脚本真正执行时，再根据这个只读引用，到被加载的那个模块里面去取值。
        对于动态来说，原始值发生变化，import加载的值也会发生变化。不论是基本数据类型还是复杂数据类型。
        编译时输出接口。

CommonJS模块输出的是一个值的复制，ES6模块输出的是值的引用
CommonJS模块是运行时加载，ES6模块是编译时输出接口
第二个差异是因为CommonJS加载的是一个对象，即module.export属性，该对象只有在脚本运行结束时才会生成。而ES6模块不是对象，它的对外接口只是一种静态定义，在代码静态解析阶段就会生成。
下面重点解释第一个差异。
CommonJS模块输出的是值的复制，一旦输出这个值，模块内部的变化就影响不到这个值。
//lib.js  一个commonJS模块
var counter = 3
function incCounter() {
    counter++
}
module.exports = {
    counter : counter,
    incCounter : incCounter,
}
//main.js 在这个函数里加载这个模块
var mod = require ('./lib')
console.log(mod.counter)
mod.incCounter()
console.log(mod.counter)
3
3
上面的代码说明，lib.js模块加载后，它的内部变化就影响不到输出的mod.counter 了。
这是因为mod.counter是一个原始类型，会被缓存。除非写成一个函数，否则得不到内部变动后的值。

//lib.js 
var counter = 3
function incCounter() {
    counter++
}
module.exports = {
    get counter(){ //输出的counter属性实际上是个取值器函数。
        return counter
    },
    incCounter: incCounter
}
main.js
var mod = require ('./lib')
console.log(mod.counter)
mod.incCounter()
console.log(mod.counter)//现在再执行就能正确读取内部变量counter的变动了。
3
4
ES6模块的运行机制与CommonJS不一样。JS引擎对脚本静态分析的时候，遇到模块加载命令import就会生成一个只读引用。等到脚本真正执行的时候，再根据这个只读引用到被加载的模块中取值。因此，ES6模块是动态引用，并且不会缓存值，模块里的变量绑定其所在的模块。

// lib.js
export let counter = 3
export function incCounter() {
    counter++
}

//main.js
import { counter, incCounter } from './lib'
console.log(counter)
incCounter()
console.log(counter)

3
4
上面的代码说明，ES6模块输入的变量counter是活的，完全反应其所在模块lib.js内部的变化。
再如：

//m1.js
export var foo = 'bar'
setTimeout(()=>foo='baz',500)
//m2.js
import {foo} from './m1.js'
console.log(foo)
setTimeout(()=>console.log(foo),500)

bar
baz
上面的代码表明，ES6模块不会缓存运行结果，而是动态地去被加载的模块取值，并且变量总是绑定其所在的模块。
由于ES6输入的模块变量只是一个“符号连接”，所以这个变量是只读的，对它重新赋值会报错。

//lib.js
export let obj = {}

//main.js
import {obj} from './lib'
obj.prop=123 //OK
obj = {} //TypeError
main.js 从 lib.js 输入变量obj，可以对obj添加属性，但是重新赋值就会报错。因为变量obj指向的地址是只读的，不能重新赋值，这就好比main.js创造了一个名为obj的const变量。

//mod.js
function C(){
   this.sum = 0
   this.add = function(){
        this.sum += 1
  }
  this.show = function(){
       console.log(this.sum)
  }
}
export let c = new C()
//x.js
import {c} from './mod'
c.add()
//y.js
import {c} from './mod'
c.show()
//main.js
import './x'
import './y'

1
这就证明了x.js和y.js加载都是C的同一实例

摘抄自：
阮一峰-ES6标准入门-第六章-Module的加载实现


### 异常
在 ES6，可以使用 `try-catch` 结构来处理异常。`try` 代码块包含可能抛出异常的代码，而 `catch` 代码块则用于处理这些异常。这里有一些常见的使用示例：

```javascript
try {
    // 可能会抛出异常的代码
    const a = JSON.parse(someInvalidJSONString);
} catch (e) {
    // 处理异常的代码
    console.error("Parsing error:", e.message);
}
```

如果你想要在发生异常后再抛出异常，你可以使用 `throw`：

```javascript
try {
    // 可能会抛出异常的代码
    const a = JSON.parse(someInvalidJSONString);
} catch (e) {
    // 处理异常的代码
    console.error("Parsing error:", e.message);

    // 抛出异常
    throw new Error('Something went wrong');
}
```

`finally` 语句块是无论是否发生异常，都会执行的代码：

```javascript
try {
    // 可能会抛出异常的代码
    const a = JSON.parse(someInvalidJSONString);
} catch (e) {
    // 处理异常的代码
    console.error("Parsing error:", e.message);
} finally {
    // 无论是否发生异常，都会执行的代码
    console.log("This will always run");
}
```

这就是在 ES6 中处理异常的一些基本示例。请注意，`catch` 语句块只会捕获 `try` 语句块中抛出的异常。

## 箭头/lambda 函数
[JavaScript 箭头函数（Lambda表达式）](https://blog.csdn.net/cuit/article/details/53200335)
```javascript
// Arrow function:
[5, 8, 9].map(item => item + 1); // -> [6, 9, 10]

// Classic function equivalent:
[5, 8, 9].map(function(item) {
  return item + 1;
}); // -> [6, 9, 10]
```