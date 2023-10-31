# react

双向绑定 https://www.jb51.net/article/239966.htm

### hello world
见 另一文件 /frame/react/hello_world.md




### JSX

由于 JSX 不是有效的 JavaScript，因此必须将 JSX 代码编译为 JavaScript。转译器 Babel 是这个过程的流行工具

### 生命周期

componentWillMount 生命周期方法将在 16.X 的未来版本中弃用，并在版本 17 中删除。在本文中了解更多信息

#### componentDidMount

- 调用 api

- 添加事件侦听器

React 的最佳实践是在生命周期方法 componentDidMount() 中对服务器进行 API 调用或任何调用。在将组件挂载到 DOM 后调用此方法。对此处的任何 setState() 调用都将触发组件的重新渲染。当您在此方法中调用 API 并使用 API 返回的数据设置状态时，它将在您收到数据后自动触发更新。

如果任何组件收到新的或新的 `state` `props` ，它会重新渲染自身及其所有子组件。这通常是可以的。但是 React 提供了一个生命周期方法，您可以在子组件收到新的 `state` 或 `props` 时调用，并明确声明组件是否应该更新。该方法为 `shouldComponentUpdate()` ，它采用 `nextProps` 和 `nextState` 作为参数。

此方法是优化性能的有用方法。例如，默认行为是组件在收到新的 `props` 时重新渲染，即使 没有 `props` 更改。您可以通过 `shouldComponentUpdate()` 比较 . `props` 该方法必须返回一个 `boolean` 值，该值告诉 React 是否更新组件。您可以将当前道具 （ ） 与下一个道具 （ `this.props` `nextProps` ） 进行比较，以确定是否需要更新，并相应地返回 `true` 或 `false` 。

### 样式

- className

- style

您可以使用该 `className` 特性将类应用于 JSX 元素，并将样式应用于样式表中的类。另一种选择是应用内联样式，这在 ReactJS 开发中非常常见。

#### style

下面是 HTML 中内联样式的示例：

```html
<div style="color: yellow; font-size: 16px">Mellow Yellow</div>

```

JSX 元素使用该 `style` 属性，但由于 JSX 的转译方式，您无法将该值设置为 `string` .相反，您将其设置为等于 JavaScript `object` 。下面是一个示例：

```jsx

```


## hook | React 钩子
[轻松学会 React 钩子：以 useEffect() 为例](https://www.ruanyifeng.com/blog/2020/09/react-hooks-useeffect-tutorial.html)

钩子到底是什么？

一句话，钩子（hook）就是 React 函数组件的副效应解决方案，用来为函数组件引入副效应。 函数组件的主体只应该用来返回组件的 HTML 代码，所有的其他操作（副效应）都必须通过钩子引入。

由于副效应非常多，所以钩子有许多种。React 为许多常见的操作（副效应），都提供了专用的钩子。

useState()：保存状态
useContext()：保存上下文
useRef()：保存引用
......
上面这些钩子，都是引入某种特定的副效应，而 useEffect()是通用的副效应钩子 。找不到对应的钩子时，就可以用它。其实，从名字也可以看出来，它跟副效应（side effect）直接相关。

```jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [data, setData] = useState({ hits: [] });

  useEffect(() => {
    const fetchData = async () => {
      const result = await axios(
        'https://hn.algolia.com/api/v1/search?query=redux',
      );

      setData(result.data);
    };

    fetchData();
  }, []);

  return (
    <ul>
      {data.hits.map(item => (
        <li key={item.objectID}>
          <a href={item.url}>{item.title}</a>
        </li>
      ))}
    </ul>
  );
}

export default App;
```

### 四个最常用的钩子
useState()
useContext()
useReducer()
useEffect()
[React Hooks 入门教程](https://www.ruanyifeng.com/blog/2019/09/react-hooks.html)