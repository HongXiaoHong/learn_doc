# web 之 模板引擎

## [pug](https://www.pugjs.cn/) | 哈巴狗 前身是 jade

[pug模板引擎(原jade) hello world 案例](https://www.cnblogs.com/xiaohuochai/p/7222227.html)

### 安装[​](https://www.pugjs.cn/#%E5%AE%89%E8%A3%85 "安装的直接链接")

#### 软件包[​](https://www.pugjs.cn/#%E8%BD%AF%E4%BB%B6%E5%8C%85 "软件包的直接链接")

在 JavaScript 项目中使用 Pug：

```
$ npm install pug
```

#### 命令行[​](https://www.pugjs.cn/#%E5%91%BD%E4%BB%A4%E8%A1%8C "命令行的直接链接")

首先安装最新版本的 [Node.js](http://nodejs.org/)，然后安装 `pug-cli`：

```
$ npm install pug-cli -g
```

然后执行以下命令：

```
$ pug --help
```

### 语法[​](https://www.pugjs.cn/#%E8%AF%AD%E6%B3%95 "语法的直接链接")

Pug 具有简洁、对空格敏感的语法，用于输出 HTML。以下是一个简单的示例：

```pug
doctype html
html(lang="en")
  head
    title= pageTitle
    script(type='text/javascript').
      if (foo) bar(1 + 5);
  body
    h1 Pug - node template engine
    #container.col
      if youAreUsingPug
        p You are amazing
      else
        p Get on it!
      p.
        Pug is a terse and simple templating language with a
        strong focus on performance and powerful features.
```

Pug 将上面的代码转换为：

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Pug</title>
    <script type="text/javascript">
      if (foo) bar(1 + 5);
    </script>
  </head>
  <body>
    <h1>Pug - node template engine</h1>
    <div id="container" class="col">
      <p>You are amazing</p>
      <p>
        Pug is a terse and simple templating language with a strong focus on
        performance and powerful features.
      </p>
    </div>
  </body>
</html>
```

### 如何进行转换

```javascript

var pug = require('pug');

// compile
var fn = pug.compile('string of pug', options);
var html = fn(locals);

// render
var html = pug.render('string of pug', merge(options, locals));

// renderFile
var html = pug.renderFile('filename.pug', merge(options, locals));
```



## mustache

[janl/mustache.js: Minimal templating with {{mustaches}} in JavaScript --- janl/mustache.js： JavaScript 中的 {{mustaches}} 最小模板化 (github.com)](https://github.com/janl/mustache.js)

[WOW！这就是mustache.js！一个有灵魂的模板引擎 - 因卓诶-爱分享爱原创Blog (yinzhuoei.com)](https://www.yinzhuoei.com/index.php/archives/110/)

```bash
npm i mustache -s -d
```

package.json 的 build 脚本配置上, 使用 mustache 对模板中的模板执行格式化的字符串进行替换

```json
"scripts": {
    "build": "mustache dataView.json myTemplate.mustache>public/output.html",
  },
```

dataView.json:

```json
{
"name": "shenhao",
"age": "19",
"html": "<p>123</p>",
"isTrue": true,
"thisIsObject": {
    "name": "shenhao",
    "age": "19"
},
"isArray": [{
    "name" : "shenhao"
},{
    "name" : "shenhao"
},{
    "name" : "shenhao"
}]
}
```

myTemplate.mustache:

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Document</title>
</head>
<body>
{{name}} 有一个 {{&html}}  
<br>
<hr>
 {{thisIsObject.name}} {{thisIsObject.age}}
 <br>
<hr>
-webkit- {{#isTrue}} 如果是真就显示了 {{/isTrue}}
 <br>
<hr>
循环一下下面的内容, 如果是数组，可以用.来表示循环的每一个元素
{{#isArray}} {{name}} {{/isArray}}
<br>
<hr>
{{!^}}与{{!#}}相反，如果变量是null、undefined、 false、和空数组讲输出结果

</body>
</html>
```

> {{name}}：会在json中查询对应的值，并且渲染  
> {{&html}}: html在json中如果式一个html标签，可以用这样的方式进行转义 (类似vue中的v-html)  
> {{#boolean}} 和 {{/boolean}}: 是一个组合，如果boolean为真那么它们之间的内容会渲染，否则不会  
> {{^boolean}}: 和上面用法一样，只不过是上面的else  
> {{object.name}}: 同样支持对象键值对的方式获取  
> {{#array}} 和 {{/array}}: 如果这样写是一个数组，那么不仅有判断boolean的真假，它会迭代中间可以写迭代中的每一个元素，每一个元素可以用{{.}}来获取，如果要获取迭代中的内容是一个键值对，那么可以直接使用{{name}}



## [FreeMarker](https://github.com/apache/freemarker#apache-freemarker-version)

FreeMarker是一个“模板引擎”;一种通用工具，用于基于模板生成文本输出（从 HTML 到自动生成的源代码的任何内容）。它是一个Java包，一个Java程序员的类库。它本身不是最终用户的应用程序，而是程序员可以嵌入到他们的产品中的东西。FreeMarker被设计为适用于HTML网页的生成，特别是遵循MVC（模型视图控制器）模式的基于servlet的应用程序。



## [thymeleaf](https://github.com/thymeleaf/thymeleaf)

官网： [Documentation - Thymeleaf --- 文档 - 百里香叶](https://www.thymeleaf.org/documentation.html)

[Thymeleaf一篇就够了-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/769977)



```html
<!DOCTYPE html>
<html  xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>title</title>
</head>
<body>
hello 第一个Thymeleaf程序
<div th:text="${name}">name是bigsai(我是离线数据)</div>
</body>
</html>
```



themeleaf 支持 ognl/jstl



了解ognl/jstl 可参:

[jstl、EL跟OGNL-腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/2338615)

[JSTL核心标签超详细详解（学习笔记，一文看懂）_jstl标签的知识_小吕努力变强的博客-CSDN博客](https://blog.csdn.net/qq_48033003/article/details/117523795)

jstl 小栗子:

```jsonp
<c:set var="age" value="18" scope="page"> </c:set>

<c:if test="${pageScope.age>17}">我大于17</c:if>
<c:if test="${pageScope.age<=17}">我小于等于17</c:if>


```

[Ognl表达式基本原理和使用方法 - 洋葱源码 - 博客园 (cnblogs.com)](https://www.cnblogs.com/cenyu/p/6233942.html)

ognl 小栗子：

```jsonp
  <br/>1.list迭代<br/>
<s:iterator var="user" value="#request.list" status="st">
  <s:property value="#user.id"/>
  <s:property value="#user.name"/>
  <s:property value="#st.even"/><br/>
</s:iterator>

  <br/>2.map迭代<br/>
  <s:iterator var="en" value="#request.map" status="st">
      <s:property value="#en.key"/>
      <s:property value="#en.value.name"/>
  </s:iterator>

```