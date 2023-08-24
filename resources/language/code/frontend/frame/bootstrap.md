# bootrap

Bootstrap是一个非常流行的前端框架，它的网格系统是其核心特性之一，它提供了一种快速、灵活、响应式的布局系统。这种布局系统是基于行（row）和列（column）的，允许开发者轻松地创建结构化的页面布局。

Bootstrap网格系统的基本元素如下：

1. Container：这是网格系统的最外层元素，用于包含和限制网格系统的宽度。Bootstrap提供了`.container`（固定宽度）和`.container-fluid`（100%宽度）两种容器。

2. Row：行是包含列的水平元素。Bootstrap的行使用CSS类名`.row`，它为了消除外边距，会自动应用负的左/右边距。

3. Column：列是实际包含内容的元素。列必须位于行中，并可以跨越1到12个网格单位。Bootstrap提供了一组响应式的CSS类，如`.col-`、`.col-sm-`、`.col-md-`、`.col-lg-`和`.col-xl-`，可以分别用于不同的屏幕尺寸。

这是一个基本的Bootstrap网格布局示例：

```html
<div class="container">
  <div class="row">
    <div class="col-md-8">.col-md-8</div>
    <div class="col-md-4">.col-md-4</div>
  </div>
</div>
```

在这个例子中，我们有一个`.container`元素包含一个`.row`元素，这个`.row`元素有两个列元素：`.col-md-8`和`.col-md-4`。这意味着，在中等尺寸（md）的设备和更大的设备上，这个行将被分成12个网格单位，`.col-md-8`将占据8个单位，`.col-md-4`将占据4个单位。在小于中等尺寸的设备上，这两个列将堆叠起来，各自占据100%的宽度。

Bootstrap的网格系统是响应式的，这意味着它会根据设备的屏幕尺寸自动调整布局。开发者可以使用这个系统来创建复杂的布局，它们在不同尺寸的屏幕上看起来都很好。

### 如果我要使用 css中的grid布局做到类似一行8:4响应式的效果, 我应该怎么写, 举一个例子说明一下

CSS Grid 是一种强大的布局系统，可以用于创建复杂的二维布局。与 Bootstrap 网格系统相似，你也可以使用 CSS Grid 创建响应式布局。让我们看一个创建一行8:4的例子：

```html
<div class="grid-container">
  <div class="grid-item">.grid-item 8</div>
  <div class="grid-item">.grid-item 4</div>
</div>
```

然后在 CSS 中，你可以像下面这样定义你的布局：

```css
.grid-container {
  display: grid;
  grid-template-columns: 8fr 4fr;
}

.grid-item {
  border: 1px solid black;
  padding: 10px;
}
```

在上面的 CSS 中，`display: grid;`使容器变为一个 grid 容器，然后`grid-template-columns: 8fr 4fr;`定义了两列，宽度比为 8:4。`fr` 是 CSS Grid 中的一个单位，表示可用空间的一个比例。

为了实现响应式设计，你可以使用 CSS 中的媒体查询。例如，如果你希望在较小的屏幕上让每个网格项目占据一整行，你可以这样做：

```css
@media (max-width: 768px) {
  .grid-container {
    grid-template-columns: 1fr;
  }
}
```

上面的代码意味着当屏幕宽度小于或等于 768px 时，`.grid-container`的列数会变成 1，这样每个 `.grid-item` 会自动占据一整行。

###  bootstrap中的 col-md-8 col-md-4是如何实现8比4比例显示的呢?
Bootstrap的网格系统基于弹性盒布局（Flexbox）模型和CSS媒体查询。这个网格系统将页面水平分割成12个等宽的列，然后开发者可以使用Bootstrap的CSS类来决定元素应该占据多少列。对于响应式布局，Bootstrap为不同的屏幕尺寸定义了一组CSS类。

Bootstrap网格系统的核心CSS可能看起来大致如下：

```css
.col-md-4 {
  flex: 0 0 33.333333%; /* flex-grow, flex-shrink, flex-basis */
  max-width: 33.333333%;
}

.col-md-8 {
  flex: 0 0 66.666667%;
  max-width: 66.666667%;
}

@media (max-width: 768px) {
  .col-md-4, .col-md-8 {
    flex-basis: 0;
    flex-grow: 1;
    max-width: 100%;
  }
}
```

如上所示，`.col-md-8`类使元素占据父元素宽度的66.666%（即8/12），而`.col-md-4`类使元素占据父元素宽度的33.333%（即4/12）。

在媒体查询中，当屏幕宽度小于或等于768px（假设这是Bootstrap中"md"断点的定义）时，`.col-md-4`和`.col-md-8`类将修改`flex-basis`为0，`flex-grow`为1，以及`max-width`为100%。这会使元素宽度变为100%，因此它们会在小屏幕设备上垂直堆叠。

这就是Bootstrap如何使用CSS和Flexbox来实现其响应式网格系统的大致方式。在实际的Bootstrap代码中，还会有更多的细节和优化，以处理各种复杂的用例和边界情况。