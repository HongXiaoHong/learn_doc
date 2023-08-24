# JavaScript 问题

import 之后出现 Uncaught SyntaxError: Cannot use import statement outside a module (at scripts.js:1:1)import 之后出现 未捕获的语法错误：无法在模块外部使用导入语句（在脚本.js：1：1）

出现 "Uncaught SyntaxError: Cannot use import statement outside a module" 这个错误，往往是因为你正在试图在一个脚本中使用 ES6 的 `import` 语句，但是这个脚本并没有被当做模块去处理。

在HTML中，所有的 `<script>` 标签默认情况下都被当做脚本去处理，而不是模块。如果你想使用 `import` 语句，你需要将你的 `<script>` 标签的 `type` 属性设为 `"module"`。例如：

```html
<script type="module" src="scripts.js"></script>
```

这样就告诉浏览器，`scripts.js` 是一个 ES6 模块，应该允许使用 `import` 和 `export` 语句。

另一点需要注意的是，ES6 模块在浏览器中默认使用严格模式（strict mode），并且有自己的独立的作用域。也就是说，在一个模块中定义的变量，除非被明确地导出，否则不会污染全局作用域。

还有一个注意点是，模块通过 CORS（跨源资源共享）策略加载，这意味着如果你在本地开发，你可能需要设置一个本地服务器来托管你的文件，而不能直接从文件系统打开HTML文件，否则可能会遇到跨源问题。对于简单的本地开发，你可以使用像是 [http-server](https://www.npmjs.com/package/http-server) 或 [live-server](https://www.npmjs.com/package/live-server) 这样的工具。