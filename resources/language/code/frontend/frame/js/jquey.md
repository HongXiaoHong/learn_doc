# jquey

## get 请求
请求接口 http://localhost:8888/random/lrcs get方式请求, 如何拿到返回的数据

要使用 jQuery 发送 GET 请求并获取返回的数据，你可以使用 `$.get()` 方法。这个方法会返回一个 Promise 对象，你可以使用 `.done()` 方法处理成功的响应，或者使用 `.fail()` 方法处理失败的响应。

以下是一个使用 `$.get()` 方法获取数据的示例：

```javascript
$.get('http://localhost:8888/random/lrcs')
  .done(function(data) {
    console.log(data); // 在这里处理返回的数据
  })
  .fail(function() {
    console.log('Error: Request failed.'); // 在这里处理请求失败的情况
  });
```

在上面的代码中，`$.get()` 方法向指定的 URL 发送 GET 请求。当请求成功时，返回的数据会被传递给 `.done()` 方法中的回调函数。在这个回调函数中，你可以处理返回的数据。如果请求失败，`.fail()` 方法中的回调函数会被调用。

注意，由于同源策略的限制，你可能无法向不同源的服务器发送请求，除非服务器支持 CORS 或 JSONP。另外，如果你的 jQuery 代码和服务器都在本地运行，你需要确保它们使用的是相同的端口，否则也可能由于同源策略的限制而无法发送请求。

在 ES6 中，你可以使用箭头函数来简化你的代码。箭头函数有更简洁的语法，并且它们没有自己的 `this` 值，`this` 的值会从它们的上下文中继承。

以下是使用箭头函数改造的请求代码：

```javascript
$.get('http://localhost:8888/random/lrcs')
  .done((data) => {
    console.log(data); // 在这里处理返回的数据
  })
  .fail(() => {
    console.log('Error: Request failed.'); // 在这里处理请求失败的情况
  });
```

在上面的代码中，我将 `.done()` 方法和 `.fail()` 方法中的回调函数都替换为了箭头函数。箭头函数的语法更简洁，它们没有自己的 `this` 值，所以在这种情况下使用它们可以使代码更易于阅读和理解。


## 使用 jQuery 来修改在 `:root` 中定义的 CSS 变量

首先，你需要使用 `:root` 选择器来选择根元素，然后使用 `css` 方法来修改 CSS 变量的值。

例如，如果你在 `:root` 中定义了一个变量 `--a`：

你可以使用以下的 jQuery 代码来修改这个变量的值：

```javascript
$(':root').css('--a', 'blue');
```

以上的 jQuery 代码将会把 `:root` 中的 `--a` 变量的值从 `red` 更改为 `blue`。这会立即更改网页中引用此变量的所有样式。

注意，jQuery 的 `css` 方法在处理 CSS 变量时并不会自动添加 `--` 前缀，所以你需要手动添加。也就是说，你应该写 `.css('--a', 'blue')` 而不是 `.css('a', 'blue')`。

## class
### 切换元素 class
https://www.runoob.com/jquery/html-toggleclass.html

```JavaScript
$("button").click(function(){
    $("p").toggleClass("main");
});
```

### addClass | 元素添加一个类

```JavaScript
$("button").click(function(){
  $("p:first").addClass("intro");
});
```