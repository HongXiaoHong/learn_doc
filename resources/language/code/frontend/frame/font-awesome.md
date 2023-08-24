
# font-awesome

<i class="fas fa-info-circle"></i> 你知道 类似 font-awesome 库,使用class就可以做出一个图标, 是如何做出来的呢? 也就是说显示出一个图标,对应的class会有一张矢量图的图片指向吗?

确实，像Font Awesome这样的库就是使用一种特殊的字体文件，如TTF, OTF, WOFF, SVG等等，这些字体文件实际上包含了一组预定义的矢量图形，每个图形都分配了一个Unicode字符。这就是我们在HTML文档中使用特殊的字符和CSS类来创建图标的方式。

让我们以Font Awesome为例，来具体说明一下这是如何工作的。当你在HTML文档中使用Font Awesome时，你可能会写出类似这样的代码：

```html
<i class="fas fa-info-circle"></i>
```

在这段代码中，“fas”和“fa-info-circle”都是CSS类，这两个类的定义来自Font Awesome的CSS文件。我们来看看这些类是如何在CSS中定义的：

```css
.fas {
  font-family: "Font Awesome 5 Free"; 
  font-weight: 900; 
}

.fa-info-circle:before {
  content: "\f05a";
}
```

`.fas`类定义了字体族名为"Font Awesome 5 Free"，以及字体粗细为900。而`.fa-info-circle:before`类则使用了CSS的`:before`伪元素来生成内容，内容就是Unicode字符"f05a"。这个Unicode字符"f05a"对应的就是Font Awesome字体中的一个特定的图标。

当浏览器渲染页面时，它将根据CSS的定义，使用"Font Awesome 5 Free"字体，将Unicode字符"f05a"渲染为对应的图标。

简而言之，Font Awesome以及其他类似的图标库，是通过创建特殊的字体文件，将矢量图像与Unicode字符对应，然后在HTML和CSS中引用这些字符和字体来实现图标的。这种方式的优点是，由于这些图标实际上是矢量图形，所以它们可以被任意缩放，而不会失去清晰度。同时，因为它们是通过字体来实现的，所以它们可以很容易地被样式化，比如改变颜色、大小等等。