# css 重要/常用属性

### box-sizing | 计算元素的总宽度和高度

[box-sizing - CSS: Cascading Style Sheets | MDN --- 框大小调整 - CSS：级联样式表 |多核 (mozilla.org)](https://developer.mozilla.org/en-US/docs/Web/CSS/box-sizing)

```css
box-sizing: content-box;
width: 100%;
border: solid #5B6DCD 10px;
padding: 5px;
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_KcdylWwJ3M.png)

```css
box-sizing: border-box;
width: 100%;
border: solid #5B6DCD 10px;
padding: 5px;
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_xCdPEEJ6ae.png)

## https://www.jianshu.com/p/3a5bbfbf5957

## linear-gradient | 颜色渐变

### 

### 字体颜色渐变

[CSS 实现文字渐变色 - 简书 (jianshu.com)](https://www.jianshu.com/p/3a5bbfbf5957)

#### 方案1 背景设置渐变

background-clip: text 设置不显示背景, 显示有文字的部分
color 字体使用 transparent 沿用背景的颜色

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <style>
    .text-gradient {
      background-image: linear-gradient(to right, orange, purple);
      -webkit-background-clip: text;
      color: transparent;
      font-size: 30px;
    }
  </style>
</head>
<body>
  <span class="text-gradient">文字渐变</span>
</body>
</html>
```



#### 方案2 mask

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .text-gradient {
            position: relative;
            color: blue;
            font-size: 30px;
        }
        .text-gradient:before {
            content: attr(text);
            position: absolute;
            z-index: 10;
            color: orange;
            -webkit-mask: linear-gradient(to right, transparent, orange);
        }
    </style>
</head>
<body>
    <div text="文字渐变" class="text-gradient">文字渐变</div>
</body>
</html>
```

`-webkit-mask: linear-gradient(to right, transparent, orange)`为新元素添加了一个从左到右，从透明到橙色的渐变遮罩，`before`元素中与mask的`transparent`的重叠部分也变成了透明


## 元数


```html
<meta name="viewport" content="width=device-width,initial-scale=1" />
```

这个元标签告诉移动端浏览器，它们应该将视口宽度设定为设备的宽度，将文档放大到其预期大小的 100%，在移动端以你所希望的为移动优化的大小展示文档。

为何需要这个？因为移动端浏览器倾向于在它们的视口宽度上说谎。

这个元标签的存在，是由于原来 iPhone 发布以后，人们开始在小的手机屏幕上阅览网页，而大多数站点未对移动端做优化的缘故。移动端浏览器因此会把视口宽度设为 960 像素，并以这个宽度渲染页面，结果展示的是桌面布局的缩放版本。其他的移动端浏览器（例如谷歌安卓上的）也是这么做的。用户可以在站点中放大、移动，查看他们感兴趣的那部分，但是这看起来很不舒服。如果你不幸遇到了一个没有响应式设计的网站，今天你还会看到这种情况。

麻烦的是，你的带断点和媒介查询的响应式设计不会在移动端浏览器上像预期那样工作。如果你有个窄屏布局，在 480 像素及以下的视口宽度下生效，但是视口是按 960 像素设定的，你将不会在移动端看到你的窄屏布局。通过设定width=device-width，你用设备的实际宽度覆写了苹果默认的width=960px，然后你的媒介查询就会像预期那样生效。

所以你应该在你的文档头部总是包含上面那行 HTML。

和视口元标签一起，你可以使用另外几个设定，但大体说来，上面那行就是你想要使用的。

initial-scale：设定了页面的初始缩放，我们设定为 1。
height：特别为视口设定一个高度。
minimum-scale：设定最小缩放级别。
maximum-scale：设定最大缩放级别。
user-scalable：如果设为no的话阻止缩放。
你应该避免使用minimum-scale、maximum-scale，尤其是将user-scalable设为no。用户应该有权力尽可能大或小地进行缩放，阻止这种做法会引起访问性问题。