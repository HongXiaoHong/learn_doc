# css 案例

## 画出一个太极图

思路使用

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_Yzg079gImK.png)

通过边框画出一个圆

再使用 before after 伪元素画出两个圆

覆盖到中间, 通过重叠组合画出一个太极的图案

[前端太极图怎么用一个盒子写出？ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/386932078)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_piP0FtY5QB.png)

```html
<body>
    <div class="box"></div>
</body>
```

css

```css
body {
 background-color: #668;
        }

 .box {
 position: relative;
 margin: 0 auto;
 width: 100px;
 height: 200px;
 background-color: black;
 border-right: 100px solid white;
 border-radius: 50%;
        }

 .box::before {
 content: "";
 position: absolute;
 left: 45px;
 width: 10px;
 height: 10px;
 border-radius: 50%;
 background-color: white;
 border: 45px solid black;
        }

 .box::after {
 content: "";
 position: absolute;
 left: 45px;
 bottom: 0px;
 width: 10px;
 height: 10px;
 border-radius: 50%;
 background-color: black;
 border: 45px solid white;
        }
```

### flex布局下让元素右置
页面: https://markdown-previewer.freecodecamp.rocks/


![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_mCVc30N4wN.png)

父元素 html 结构以及 css 样式
```html
<div class="toolbar" data-immersive-translate-effect="1" data-immersive_translate_walked="94b78d13-05cd-4c7d-82ae-78190ed4d3ea"><i class="fa fa-free-code-camp" title="no-stack-dub-sack"></i>Editor<font class="notranslate immersive-translate-target-wrapper" lang="zh-CN" data-immersive-translate-translation-element-mark="1"><font class="notranslate" data-immersive-translate-translation-element-mark="1">&nbsp;</font><font class="notranslate immersive-translate-target-translation-theme-none immersive-translate-target-translation-inline-wrapper-theme-none immersive-translate-target-translation-inline-wrapper" data-immersive-translate-translation-element-mark="1"><font class="notranslate immersive-translate-target-inner immersive-translate-target-translation-theme-none-inner" data-immersive-translate-translation-element-mark="1">编辑 器</font></font></font><i class="fa fa-arrows-alt"></i></div>
```

```css
.toolbar {
    display: flex;
    align-items: center;
    background-color: #4aa3a3;
    padding: 0.3rem;
    border: 1px solid #1d2f2f;
    box-shadow: 1px 1px 10px 2px #3a5f5f;
    font-family: Russo One;
    font-size: 1rem;
    color: black;
}
```

全屏按钮 css 样式
```css
.toolbar .fa-arrows-alt, .toolbar .fa-compress {
    margin-left: auto;
}
```

依据 https://developer.mozilla.org/zh-CN/docs/Web/CSS/margin-left
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_2L74U0VoXi.png)