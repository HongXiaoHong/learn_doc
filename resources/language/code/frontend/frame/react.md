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