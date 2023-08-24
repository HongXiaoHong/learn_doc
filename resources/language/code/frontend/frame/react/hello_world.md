# react hello

### 不用npm,webpack的情况下, 可以使用react的jsx吗?

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


#### 创建 react 项目过程
参考  https://juejin.cn/post/7134314981515853831#heading-0

在使用Webpack搭建React应用之前，你需要确保你的系统已经安装了Node.js和npm。以下是使用Webpack和Babel搭建React应用的步骤：

##### 创建项目目录

在你的工作区域，创建一个新的项目目录，并进入该目录。例如：

```bash
mkdir simple_markdown_previewer && cd simple_markdown_previewer
```

![simple_markdown_previewer_new_directory](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/simple_markdown_previewer_new_directory.png)

##### 初始化项目

使用`npm init -y`命令初始化项目。这将创建一个新的`package.json`文件。

```json
{
  "name": "simple_markdown_previewer",
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

   日志:

```bash
D:\app\code\nodejs\node.exe D:\app\code\nodejs\node_modules\npm\bin\npm-cli.js test --scripts-prepend-node-path=auto

> simple_markdown_previewer@1.0.0 test
> echo "Error: no test specified" && exit 1

"Error: no test specified"

```

##### 安装React和ReactDOM

使用npm安装React和ReactDOM：

```bash
npm install --save react react-dom
```

   dependencies 增加了上面安装的两个包

```json
{
  "name": "simple_markdown_previewer",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}

```

##### 安装Webpack

webpack是一个现代JavaScript应用程序的静态模块打包器，现代前端应用很多都是用webpack打包，webpack详细使用请看[文档](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.js.org%2Fconcepts%2F "https://webpack.js.org/concepts/")

使用npm安装Webpack和Webpack的命令行接口：

```bash
npm install --save-dev webpack webpack-cli
```

   devDependencies 增加 webpack

```json
"devDependencies": {
    "webpack": "^5.88.1",
    "webpack-cli": "^5.1.4"
  }
```

安装 webpack-dev-server

```bash
npm i webpack-dev-server --save-dev

```

webpack-dev-server用来搭建一个本地服务，可以热加载前端项目，详细请看[文档](https://link.juejin.cn/?target=https%3A%2F%2Fwebpack.js.org%2Fconfiguration%2Fdev-server%2F "https://webpack.js.org/configuration/dev-server/")。

##### 安装Babel

babel是javascript编辑器，作用如下：

1. 负责把ES6、ES7等高版本js编译成低版本js，供浏览器运行。
2. 负责把react语法（jsx）编译成js。

babel详细使用请看[文档](https://link.juejin.cn/?target=https%3A%2F%2Fbabeljs.io%2Fdocs%2Fen%2F "https://babeljs.io/docs/en/")。

使用npm安装Babel及其相关的插件和预设：

```bash
npm install --save-dev @babel/core babel-loader @babel/preset-env @babel/preset-react
```

   devDependencies 又增加了 babel 用于编译 react 的 jsx语法

```json
"devDependencies": {
"@babel/core": "^7.22.8",
"@babel/preset-env": "^7.22.7",
"@babel/preset-react": "^7.22.5",
"babel-loader": "^9.1.3",
"webpack": "^5.88.1",
"webpack-cli": "^5.1.4"
}
```

##### 创建源代码文件

新建src文件夹、index.js文件、App.js(Hello.js)文件。完成后，文件结构如下：

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/webstorm64_7kpwZtrvhJ.png)

###### index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>React App</title>
</head>
<body>
<div id="root"></div>
</body>
</html>

```

###### index.js

在项目目录中，创建一个新的源代码目录（例如，`src`），并在其中创建一个新的JavaScript文件（例如，`index.js`）。在这个文件中，你可以开始编写你的React代码。

```js
import React from "react"
import {createRoot} from "react-dom/client";
import Hello from "./Hello";
import * as ReactDOM from "react-dom";


const root = createRoot(document.getElementById("root"));
root.render(<Hello name={"hong"}/>);

// ReactDOM.render(<Hello name={"hong"}/>, document.getElementById("root"))
```

###### Hello.js

```js
import React from "react"

class Hello extends React.Component {
    render() {
        return <h1>Hello, {this.props.name}</h1>;
    }
}

export default Hello
```

##### 配置Webpack

webpack集成babel还需要babel-loader，加载html文件还需要插件html-webpack-plugin

```bash

npm i babel-loader html-webpack-plugin --save-dev

```

在项目目录中，创建一个新的`webpack.config.js`文件，并在其中配置Webpack。以下是一个基本的Webpack配置，它配置了Babel加载器以处理JSX：

```javascript
const path = require('path');
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
   entry: {
      main: './src/index.js',
   },
   output: {
      path: path.resolve(__dirname, 'dist'),
      filename: 'bundle.js',
   },
   module: {
      rules: [
         {
            test: /\.(js|jsx)$/,
            exclude: /node_modules/,
            use: {
               loader: 'babel-loader',
            },
         },
      ],
   },
   plugins:[
      new HtmlWebpackPlugin({
         template: './public/index.html'
      })
   ],
   mode: "development"
};

```

##### 配置Babel

在项目目录中，创建一个新的`.babelrc`文件，并在其中配置Babel。以下是一个基本的Babel配置，它启用了React预设：

```json
{
  "presets": ["@babel/preset-env", "@babel/preset-react"]
}
```

##### 修改`package.json`

在`package.json`文件中，添加一个新的脚本来运行Webpack：

```json
"scripts": {
"test": "echo \"Error: no test specified\" && exit 1",
"start": "webpack serve --mode development --open --port 8890",
"build": "webpack"
},
```

##### 运行项目

Webpack将会编译你的代码，并生成一个新的`bundle.js`文件。

现在，你可以使用`npm start`命令来运行你的项目。

以上就是使用Webpack和Babel搭建React应用的基本步骤。请注意，这只是一个基本的配置，实际的项目可能需要更复杂的配置，例如处理CSS和图片文件、优化生产构建、配置热模块替换等。
