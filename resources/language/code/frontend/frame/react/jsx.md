# jsx

不用npm,webpack的情况下, 可以使用react的jsx吗?

在没有使用npm和webpack的情况下，你仍然可以使用React和JSX，但是需要通过在HTML文件中引入React和ReactDOM库，并使用Babel库来转换JSX语法。以下是一个示例：

```
html<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello React!</title>
    <script src="https://unpkg.com/react@17/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
  </head>
  <body>
    <div id="root"></div>
    <script type="text/babel">
      class Hello extends React.Component {
        render() {
          return <h1>Hello, world!</h1>;
        }
      }

      ReactDOM.render(
        <Hello />,
        document.getElementById('root')
      );
    </script>
  </body>
</html>

```

在这个示例中，我们通过`<script>`标签从unpkg.com CDN引入了React、ReactDOM和Babel库。然后，我们在`<script type="text/babel">`标签中编写了使用JSX语法的React组件。Babel库会在浏览器中实时地将JSX语法转换为普通的JavaScript。

然而，这种方法主要用于学习和演示目的，因为在生产环境中，实时转换JSX会带来性能问题。在生产环境中，我们通常会使用工具（如Babel CLI、webpack等）预先将JSX转换为JavaScript，然后再部署到服务器。


