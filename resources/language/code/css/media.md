# @media | 兼容不同设备样式

`@media` 是 CSS 中的一个功能，它被称为媒体查询（Media Query）。媒体查询允许你根据设备的特定特性（如视口宽度，设备类型等）来应用不同的 CSS 规则。这使得你可以根据设备的环境来设计和调整你的网页样式，使其在不同的设备和屏幕尺寸上都能有良好的显示效果，这通常被称为响应式设计（Responsive Design）。

以下是一个简单的 `@media` 使用示例，这个示例中的 CSS 规则会在视口宽度小于或等于 600px 时生效：

```css
@media (max-width: 600px) {
  body {
    background-color: lightblue;
  }
}
```

在这个示例中，我们使用了 `max-width` 这个媒体特性。当视口的宽度小于或等于 600px 时，`body` 的背景颜色将会变为浅蓝色。

除了 `max-width` 外，还有很多其他的媒体特性，如 `min-width`（最小宽度）、`orientation`（设备方向）等，你可以根据需要使用它们。

你也可以使用逗号分隔的列表来组合多个媒体查询，这样，只要列表中的任何一个媒体查询为真，就会应用这个媒体查询块中的 CSS 规则。例如：

```css
@media (max-width: 600px), (orientation: portrait) {
  body {
    background-color: lightblue;
  }
}
```

在上面的例子中，只要视口宽度小于或等于 600px，或者设备的方向为纵向（portrait），`body` 的背景颜色就会变为浅蓝色。