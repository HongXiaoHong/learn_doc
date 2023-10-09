# typescript

[typescript史上最强学习入门文章(2w字) - 掘金 (juejin.cn)](https://juejin.cn/post/7018805943710253086?share_token=c4029c41-9cc7-4e39-9e2d-c57b6617d2d8#heading-82)

在线练习

[TypeScript: 演练场 - 一个用于 TypeScript 和 JavaScript 的在线编辑器 (typescriptlang.org)](https://www.typescriptlang.org/zh/play?ssl=19&ssc=42&pln=10&pc=1#code/PTAEiJrQ5+MU3NAYlUAqBPADgUwMoGMBOBLFAF1EBR7QYb9AudUBh-gKBFEE34wejNAAOUCo5QTb9ADeUAXjQbPlAaP6BMxSqAwJUDVcoBiVQGbagAzlEqTLgLFAIW6BFf0CbXoCAGGnTCAKg0D3yoFO5E4CDNQNBygSDlAs56BO00Dw+oH95QBSugYO1AWP-79oUAFpQdkBYOUAseUAWD0B5dUBvuUBVeUAcOUB-SNU5BXRsfCJQVUAGdXtdegCgtkBleUAYrLSlTOJAW+jAVZtANz1AODlAaojALrkJXPzfIvZXQDi5QGlbQFXo4MAYFUqMlVABQEXowHxzQHylQF+A1UBMm0BG710aQkVKgGdQAF5QADsAVwBbACM0HFAAH1B9wnxTgHM9ADNz06xCPAAe1OoAAhgATcEAClBAC5kOh9gAaUDXeGKfYASlAAG8aH48F9QFDduhAUTQccjicAOQvN7vGmPJ6ktDk1FU2n0vAfGnYvF+Pw4NCEc44EGggB0hEBGFePPeUOxAGpUdLZfKPkqANz40AAXz1wtF4rBoFV111hqwwJeoGF+3OABtiCcIdCaRg0JcnTyANZ3GkopkAaVBfvOAEdAXzdTbTvtAU60JKnYDFQAiB3OwgZlHZl2S-YoX2EKFMvmY3V6eimQCdDoBvxUAUHL2VSgQA4BIAuT0A0fKAXAJQIA0Iw7gAbTQDfqb2qCZAGFygGPIwAvZoAsTUAzor9GqAACjVIBD+UA9gbaDO+AeAUADAARKgBM0hiAbLlABc2gCnEhqAFDlAAD6gGnNNxUQAupmxyBRVIA0OUAMq6AL8JgB6Ov0XC6H4QA)

## 学习途径

博客:
[小满大神的 typeScript](https://blog.csdn.net/qq1195566313/category_11559497.html?spm=1001.2014.3001.5482)



## typescript 初识

全局安装
> npm install typescript -g

监听文件改变 
> tsc -w tsName.ts

此时这个监听终端不要关闭, 继续开启一个终端进行测试

在终端输入
记住这里是 js
```bash
node tsName.js
```

### 🌰.栗子
index.ts

```typescript
const myName : string = "hong"
console.log(`name is ${myName}`)
```

node index.js
```bash
PS E:\github\demo\typescript> node .\index.js
name is hong
```

#### 直接执行 ts 文件, 不需先执行编译

```bash
PS E:\github\demo\typescript> npm install ts-node -g

added 19 packages in 4s
```

创建一个 node 工程

```bash
PS E:\github\demo\typescript> npm init -y
Wrote to E:\github\demo\typescript\package.json:

{
  "name": "typescript",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

安装 @types/node

```bash
PS E:\github\demo\typescript> npm i @types/node -D

added 1 package in 2s
```

## tsconfig.json

创建 tsconfig.json 文件
这个文件中可以设置 ts 的各种编译配置
例如: 设置严格模式为 true, 可以让类型的赋值可以有不同的表现

```bash
PS E:\github\demo\typescript> tsc --init

Created a new tsconfig.json with:                                                         
                                                                                       TS 
  target: es2016
  module: commonjs
  strict: true
  esModuleInterop: true
  skipLibCheck: true
  forceConsistentCasingInFileNames: true


You can learn more at https://aka.ms/tsconfig
```

## 类型

```typescript
//any 任意类型 unknown 不知道的类型

//1．top type 顶级类型 any unknown 

//2.Object

//3.Number·String·Boolean 

//4.number string boolean 

//5.·1·小满..false 

//6.never


```

### unknown 与 any 区别

unknown 无法赋值给其他类型, 但是 any 可以
unknown 无法调用对象的属性 方法, any 可以
由此看来 unknown 比 any 安全
在我们不知道是什么类型的时候, 定义为 unknown 会更好

### interface | 类似于 C＋＋ 中的结构体定义
```typescript

interface Person {
    readonly id: string
    name: string
    age?: number
    [p:string]: any
}

const person: Person = {
    id: "007",
    name: "hong",
    age: 29,
}

// person.id = "aaa"
console.log(`interface test result : person -> ${person}`)

// 定义方法参数/返回值类型
interface Search {
    (keyword: string):string
}

const search: Search = (keyword: string) => {
    return `intput is ${keyword}`
}
console.log(`interface test function result : search -> ${search("林俊杰")}`)
```

结果:

```log

interface test result : person -> [object Object]
interface test function result : search -> intput is 林俊杰
```

### 数组定义

```typescript
// 数组定义
const a0:number[] = [1, 2, 3]
const a1:Array<number> = [1, 2, 3]
// 与 interface 组成对象数组类型
const people: Person[] = [{
    id: "007",
    name: "hong",
    age: 29,
}]
interface NumberArray {
    [index: number]: number;
}
let fibonacci: NumberArray = [1, 1, 2, 3, 5];
//表示：只要索引的类型是数字时，那么值的类型必须是数字。
console.log(`数组定义 fibonacci is  ${fibonacci}`)
// 数组定义
```

结果:
> 数组定义 fibonacci is  1,1,2,3,5


## 函数定义

### 函数重载
重载是为了在返回类型不同的时候, 可以更好的做类型检查
如果不使用类型重载也可以做, 
不过就要自己对类型进行强转了
不甚优雅

```typescript
function fn(params: number): string 
function fn(params: string, params2: number): void
function fn(params: any, params2?: any): void | string {
    console.log(params)
    console.log(params2)
    if (typeof params == "number") {
        return "test 类型检查"
    }
}
 
 
 
// const testFn1: string = fn('123',456)
/**
 * 
 * 已声明“testFn1”，但从未读取其值。ts(6133)
不能将类型“void”分配给类型“string”。ts(2322)
const testFn1: string
 */


const testFn: string = fn(123)
log("类型检查 testFn 没问题" + testFn)

```