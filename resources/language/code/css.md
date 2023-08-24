# css

todo
-

- [ ]  [(39条消息) 黑马程序员pink老师_CSS学习笔记_半里_辰昏的博客-CSDN博客](https://blog.csdn.net/weixin_46764819/article/details/123336658)

## 改变页面的方式

### ✨css file| 文件引入

html 页面通过css文件 改变样式

```html
<link rel="stylesheet" href="styles.css">
```

css 文件中不需要html页面中的标签

直接用选择器改变页面样式即可

### style | 页面样式

```html
<head>
    <meta charset="utf-8" />
    <title>Cafe Menu</title>
    <style></style>
  </head>
```

形式如下:

```css
元素选择器 {
        text-align: center;
        样式属性: 样式
      }
```

### 选择器

#### element | 元素选择器

通过选择某个标签 改变标签的表现

```css
h1 {
        text-align: center;
      }
```

#### , | 组合选择器

拥有相同表现的选择器可以放到一起

```css
selector1, selector2 {
  property: value;
}
```

#### . | 类选择器

通过元素的class 属性选中元素

```css
.class-name {
  styles
}
```

#### 空格 | 下级选择器

通过空格选择 某个选择器下面的元素

```css
.item p { }
```

#### input[name="password"] | 属性选择器

```css
input[name="password"]
```

#### :last-of-type | 最后一个元素

```css
p:last-of-type { } /* 它会选择最后一个p元素 */
```

#### :not | 排除这些元素

:not伪选择器可以用来选择所有不匹配给定CSS规则的元素

```css
div:not(#example) {
  color: red;
}
```

## 常用属性

### background-color | 背景颜色

### background-image | 背景图片

```css
background-image: url(https://cdn.freecodecamp.org/curriculum/css-cafe/beans.jpg)
```

### text-align | 文本位置

居中 center

### width | 宽度

1. px 像素点

2. 80% 百分比

### margin | 外边距

#### 居中

```css
margin-left: auto;
margin-right: auto;
```

margin 简写包括

margin: 上下 左右;

margin: 上 右 下 左;

### border | 边框

border-width 默认为1px

#### border-color | 边框颜色

```css
 border-color: brown;
```

#### border-left | 设置一边

简写

```css
border-left: width style color;
```

#### border-radius | 外边框圆角

todo [border-radius - CSS（层叠样式表） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/border-radius)

### padding | 内边距

```css
padding: 20px;
/**
上下左右都加20px
**/
```

简写规则跟 margin一样

### max-width | 最大宽度限制

### box-shadow | 阴影

```css
box-shadow: offsetX offsetY blurRadius spreadRadius color;

/*
blurRadius spreadRadius 可选
blurRadius 默认为0 标识模糊半径
spreadRadius 默认为 0 扩散半径或者说厚度
 */
```

### font-family | 字体

```css
font-family:sans-serif; 
```

通过添加另一个用逗号分隔的字体名称，可以为字体族添加备用字体。备用字体用于找不到第一个字体/不可用的实例。

```css
font-family: Impact,serif;
```

#### CSS 使用 @font-face 引入外部字体

##### 字体

与WOFF 1.0 中使用的Flate 压缩相比，WOFF 2.0 是使用Brotli 方法进行的压缩，压缩率更高，所以文件体积更小。 TTF 的兼容性更好，但是其字体文件体积最大。 WOFF 字体比TTF 字体有更小的体积和更好的表现性。 WOFF 2 字体是对 WOFF 字体的升级

作者：匿名用户  
链接：https://www.zhihu.com/question/446082443/answer/1746998737  
来源：知乎  
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。  

一、如果要装给系统用的话，Windows目前可能不太支持woff或[woff2](https://www.zhihu.com/search?q=woff2&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)，其它系统我不是很晓得。建议装[ttf](https://www.zhihu.com/search?q=ttf&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)/otf。[前端开发](https://www.zhihu.com/search?q=%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)的话这几种都能用，一般考虑用woff或woff2，也就是现在常说的[webfont](https://www.zhihu.com/search?q=webfont&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)，体积较小。  
dpi的话，现在发布的字体绝大多数是纯矢量的（Emoji除外，点阵和矢量的都存在），像[中易宋体](https://www.zhihu.com/search?q=%E4%B8%AD%E6%98%93%E5%AE%8B%E4%BD%93&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)那样还嵌入点阵数据的极为罕见，所以在屏幕[dpi](https://www.zhihu.com/search?q=dpi&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)够高的条件下效果应该不会差太多；dpi比较低的情形，那不光是字体说了算，很大程度上依赖系统组件或者[开源组件](https://www.zhihu.com/search?q=%E5%BC%80%E6%BA%90%E7%BB%84%E4%BB%B6&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)对字体的渲染策略。

二、有static[子文件夹](https://www.zhihu.com/search?q=%E5%AD%90%E6%96%87%E4%BB%B6%E5%A4%B9&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)的，外层发布的应该是可变字体（Variable Font）。这类字体一般要求用户设定一个或多个参数，而字形可以随着参数的变化连续地变化。给个链接感受一下：

[Variable Fonts (v-fonts.com)​v-fonts.com/](https://link.zhihu.com/?target=https%3A//v-fonts.com/)

static子文件夹里发布的是这类变化被固化的结果，也就是传统上不同字重或不同斜率的字体构成的一整套字体族。

如果是Adobe等软件的用户的话，这类软件对[可变字体](https://www.zhihu.com/search?q=%E5%8F%AF%E5%8F%98%E5%AD%97%E4%BD%93&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)的支持不错；但Office等软件支持就很差，最好老老实实用字体族那套。前端的话，CSS `[font-variation-settings](https://www.zhihu.com/search?q=font-variation-settings&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)`是专门用来配置可变字体参数的一个属性。

---

根据最新的题目补充中的示例来解释：

- Fira Code发布了ttf/woff/woff2三种格式，其中所有[文件名后缀](https://www.zhihu.com/search?q=%E6%96%87%E4%BB%B6%E5%90%8D%E5%90%8E%E7%BC%80&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)为VF的是可变字体。
- Cascadia Code发布了ttf/otf/woff2三种格式（截图不全），其中[static文件夹](https://www.zhihu.com/search?q=static%E6%96%87%E4%BB%B6%E5%A4%B9&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A1746998737%7D)的是传统字体族，上层的是可变字体。  
  根据文档[Windows Terminal Cascadia Code | Microsoft Docs](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/terminal/cascadia-code)，Mono/Code分别为不带连字和带连字的字体；PL后缀代表该字体包括一些用于新版Windows Terminal的Powerline字符。Powerline的解释见[Windows Terminal Powerline Setup | Microsoft Doc](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup)。
- JetBrains Mono发布了ttf/woff2格式，其中ttf发布了可变字体版本和传统的字体族版本。

如果给代码编辑器使用的话，建议装传统的字体族ttf/otf格式。现在的代码编辑器可能还不能很好地支持可变字体，最多把它当成单一的普通字体来用。

##### 下载所需字体到本地

这里介绍一款不错的中文字体 得意黑

可以到 GitHub 下载 [Releases · atelier-anchor/smiley-sans (github.com)](https://github.com/atelier-anchor/smiley-sans/releases)

也可以到这里免费下载

[(118条消息) 前端-中文字体推荐-得意黑-HTML5文档类资源-CSDN文库](https://download.csdn.net/download/HongZeng_CSDN/87391460)

##### 把下载字体文件放入font文件夹里

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/idea64_5SKIJqwbMW.png)

##### 定义字体

使用 css 中的 @font-face 引入字体，分别是字体名字和路径

更多属性可参 [@font-face - CSS（层叠样式表） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/@font-face)

```css
@font-face {
    /* 得意黑 https://github.com/atelier-anchor/smiley-sans/releases */
    font-family: 'SmileySans';
    src:  url("./SmileySans-Oblique.otf.woff2") format('woff2');
}
```

##### 引用字体

```css
/* 标题 */
selector {
    /* 字体 */
    font-family:'与上面定义的字体名称一致即可', Haettenschweiler, 'Arial Narrow Bold', sans-serif;
}
```

##### 结果

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_Oo8R3hk0bk.png)

### font-style | 字体风格

字体风格 包括斜体

```css
font-style: italic;
```

### font-size | 字体大小

```css
font-size: 30px;
```

### hr | 分隔符

一个横线

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_3r07PHWRgl.png)

### height | 高度

```css
height: 3px;
```

### display | 布局

#### inline-block | 行内块

```css
display: inline-block;
/**
行内块只占用内容的宽度
**/
```

##### 为什么display：inline-block的元素之间会有空格

在页面布局中，我们需要将一些元素显示在同一行，其中一种方法就是设置display：inline-block，但是在这些同行显示的inline-block元素之间的会出现空隙。

###### 现象

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_v6ufkS1yWZ.png)原本两个p元素都设置成50%的宽度

应该是刚好占据一行的

但是p元素之间多了空格

```html
<section class="item">
            <!-- todo 这里如果不合并在一起 会出现一个空格 -->
            <p class="milk_tea">炭烤奶茶</p>
            <p class="price">3.00</p>
        </section>
```

###### 原因

原先块级元素的布局通过 display 设置为 inline-block,

元素被当成行内元素排版又或者本身就是行内块元素时，元素之间的空白符（空格、回车换行等）都会被浏览器处理

根据white-space的处理方式（默认是normal，空白会被浏览器忽略），HTML代码中的回车换行被转成一个空白符

在字体不为0 的情况下，空白符占据一定的宽度，所以inline-block元素之间就出现了空隙。

###### 解决方法

- 删除HTML中元素之间的空白符

```html
<section class="item">
            <p class="milk_tea">炭烤奶茶</p><p class="price">3.00</p>
        </section>
```

#### flex | 一维布局

Flexbox是一个一维的CSS布局，可以控制项目在容器内的间隔和对齐方式

#### 一维何解

我们说 flexbox 是一种一维的布局，是因为一个 flexbox 一次只能处理一个维度上的元素布局，一行或者一列

##### 入门

[flex 布局的基本概念 - CSS（层叠样式表） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox)

[A Complete Guide to Flexbox | CSS-Tricks - CSS-Tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/#top-of-site)

#### 属性

##### justify-content | 元素在主轴的分布表现

定义了浏览器之间，如何分配顺着弹性容器主轴 (或者网格行轴) 的元素之间及其周围的空间

```css
/* Positional alignment */
justify-content: center;     /* 居中排列 */
justify-content: start;      /* Pack items from the start */
justify-content: end;        /* Pack items from the end */
justify-content: flex-start; /* 从行首起始位置开始排列 */
justify-content: flex-end;   /* 从行尾位置开始排列 */
justify-content: left;       /* Pack items from the left */
justify-content: right;      /* Pack items from the right */

/* Baseline alignment */
justify-content: baseline;
justify-content: first baseline;
justify-content: last baseline;

/* Distributed alignment */
justify-content: space-between;  /* 均匀排列每个元素
                                   首个元素放置于起点，末尾元素放置于终点 */
justify-content: space-around;  /* 均匀排列每个元素
                                   每个元素周围分配相同的空间 */
justify-content: space-evenly;  /* 均匀排列每个元素
                                   每个元素之间的间隔相等 */
justify-content: stretch;       /* 均匀排列每个元素
                                   'auto'-sized 的元素会被拉伸以适应容器的大小 */

/* Overflow alignment */
justify-content: safe center;
justify-content: unsafe center;

/* Global values */
justify-content: inherit;
justify-content: initial;
justify-content: unset;
```

#### grid | 二维布局

[网格布局 - CSS（层叠样式表） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Grid_Layout)

### white-space | 空白

white-space 用来设置如何处理元素中的空白

示例可以参考 [white-space - CSS（层叠样式表） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/white-space#%E5%B0%9D%E8%AF%95%E4%B8%80%E4%B8%8B)

这个属性表明了两件事:

- 空白字符是否以及如何它们该如何合并
- 行是否采用软换行

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/idea64_scX03qlR4e.png)

这个属性被用来”告诉“html如何处理”空白“元素，但是这里的空白并不是你想象中的空格。这里的”空白“指的是用于显示正常字符之间的水平或者垂直的空格。所以你会发现在html中多个空格最后会被显示成一个空白，回车也会被显示成一个空白。

这个时候可以将 white-space 设置成：

- **pre-wrap** — 连续的空白符会被保留。在遇到换行符或者`<br>`元素，或者需要为了填充line盒子时才会换行。
- **pre-line** — 连续的空白符会被合并。在遇到换行符或者`<br>`元素，或者需要为了填充line盒子时会换行

### box-sizing

- content-box

- border-box

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_CkIpt25Lm8.png)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_ZTRc76ZwtX.png)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_23gaQ7Po1i.png)

在 CSS 盒子模型的默认定义里，你对一个元素所设置的 width 与 height 只会应用到这个元素的内容区。如果这个元素有任何的 border 或 padding ，绘制到屏幕上时的盒子宽度和高度会加上设置的边框和内边距值。这意味着当你调整一个元素的宽度和高度时需要时刻注意到这个元素的边框和内边距。当我们实现响应式布局时，这个特点尤其烦人。

box-sizing 属性可以被用来调整这些表现：

content-box 是默认值。如果你设置一个元素的宽为 100px，那么这个元素的内容区会有 100px 宽，并且任何边框和内边距的宽度都会被增加到最后绘制出来的元素宽度中。

border-box 告诉浏览器：你想要设置的边框和内边距的值是包含在 width 内的。也就是说，如果你将一个元素的 width 设为 100px，那么这 100px 会包含它的 border 和 padding，内容区的实际宽度是 width 减去 (border + padding) 的值。大多数情况下，这使得我们更容易地设定一个元素的宽高。
border-box不包含margin

## 注释

```css
/* comment here */
```

## 盒子模型

所有HTML元素可以看作盒子，在CSS中，"box model"这一术语是用来设计和布局时使用。

CSS盒模型本质上是一个盒子，封装周围的HTML元素，它包括：边距，边框，填充，和实际内容。

盒模型允许我们在其它元素和周围元素边框之间的空间放置元素。

下面的图片说明了盒子模型(Box Model)：

![CSS box-model](https://www.runoob.com/images/box-model.gif)

不同部分的说明：

- **Margin(外边距)** - 清除边框外的区域，外边距是透明的。
- **Border(边框)** - 围绕在内边距和内容外的边框。
- **Padding(内边距)** - 清除内容周围的区域，内边距是透明的。
- **Content(内容)** - 盒子的内容，显示文本和图像。

## 色彩模型

- 电子设备中使用的RGB(红、绿、蓝)模型

- 印刷中使用的CMYK(青、品红、黄、黑)模型

### RGB (red, green, blue)

颜色从黑色开始，随着不同级别的红、绿和蓝的引入而变化

```css
background: rgb(0,0,0);
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_ACZPE2eI7W.png)

色轮是一个圆圈，其中相似的颜色或色调彼此靠近，不同的颜色或色调相距更远。例如，纯红色介于玫瑰色和橙色之间。  

色轮上相反的两种颜色称为互补色。如果两种互补色结合在一起，就会产生灰色。但当它们并排放置时，这些颜色会产生强烈的视觉对比，看起来更亮。

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/annie-spratt-njsRI3pTB6g-unsplash.jpg)

Photo by [Annie Spratt](https://unsplash.com/@anniespratt?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/photos/njsRI3pTB6g?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

请注意，红色和青色相邻的颜色非常明亮。如果在网站上过度使用这种对比，会让人分心，如果文字放在互补色的背景上，会让人难以阅读。  

更好的做法是选择一种颜色作为主色，并使用其补色作为强调，以吸引人们对页面上某些内容的注意。

注意到你的眼睛是如何自然地被中间的红色吸引的吗?在设计网站时，您可以使用此效果将注意力吸引到重要的标题、按钮或链接上。  

除了互补色之外

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_eJpitxDyjQ.png)

用CSS将颜色应用到元素上的一种非常常见的方法是使用十六进制或十六进制值。虽然十六进制值听起来很复杂，但它们实际上只是RGB值的另一种形式。  

十六进制颜色值以#字符开始，从0-9和a - f中选取6个字符。第一对字符表示红色，第二对字符表示绿色，第三对字符表示蓝色。例如，**#4B5320**。

```css
background-color: #007F00;
```

#### 渐变

渐变是指一种颜色过渡到另一种颜色。CSS线性渐变函数允许您控制沿着直线的过渡方向，以及使用哪些颜色。  

需要记住的一件事是，线性梯度函数实际上创建了一个图像元素，并且通常与背景属性配对，后者可以接受图像作为值。

```css
background: linear-gradient(90deg, rgb(255, 0, 0), rgb(0, 255, 0));
```

gradientDirection 第一个参数是渐变的方向

 ![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_M5UvrpmuM9.png)

```css
background: linear-gradient(180deg, rgb(255, 0, 0) 75%, rgb(0, 255, 0), rgb(0, 0, 255));
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_TTgK8qYMX7.png)

##### 颜色刻度

颜色停止器允许你微调沿着梯度线放置的颜色。它们是一个长度单位，如px或百分比，在线性梯度函数中跟随颜色。  

例如，在这个红黑梯度中，从红色到黑色的过渡发生在梯度线上的90%点，因此红色占据了大部分可用空间:

```css
background: linear-gradient(90deg, rgb(255, 0, 0) 75%, rgb(0, 255, 0), rgb(0, 0, 255));
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_fdIgAjZE2Y.png)

### 

### HSL | 色相 饱和度 明度

如果你想象一个色轮，红色是0度，绿色是120度，蓝色是240度。  

饱和度是一种颜色的强度，从0%，或灰色，到100%的纯色。  

明度是一种颜色的亮度，从0%(完全黑)到100%(完全白)，50%(中性)。

```css
background-color: hsl(240, 100%, 50%);
```

## 单位

参考 [CSS 的值与单位 - 学习 Web 开发 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Values_and_units)

### 相对长度单位

| 单位      | 相对于                                                     |
| ------- | ------------------------------------------------------- |
| **em**  | 在 font-size 中使用是相对于父元素的字体大小，在其他属性中使用是相对于自身的字体大小，如 width |
| `ex`    | 字符“x”的高度                                                |
| `ch`    | 数字“0”的宽度                                                |
| **rem** | 根元素的字体大小                                                |
| `lh`    | 元素的 line-height                                         |
| **vw**  | 视窗宽度的 1%                                                |
| **vh**  | 视窗高度的 1%                                                |
| `vmin`  | 视窗较小尺寸的 1%                                              |
| `vmax`  | 视图大尺寸的 1%                                               |

## 全局变量

### unset

[unset - CSS（层叠样式表） | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/CSS/unset)

CSS 关键字 **`unset`** 可以分为两种情况，如果这个属性本来有从父级继承的值（这个属性默认可以继承，且父级有定义），则将该属性重新设置为继承的值，如果没有继承父级样式，则将该属性重新设置为初始值。换句话说，在第一种情况下（继承属性）它的行为类似于[`inherit`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/inherit) ，在第二种情况下（非继承属性）类似于[`initial`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/initial)。它可以应用于任何 CSS 属性，包括 CSS 简写属性 [`all`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/all) 。

## 特别注意

为了使页面的样式在移动设备上看起来与在台式机或笔记本电脑上相似

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```
