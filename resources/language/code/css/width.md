# 宽度

> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.cnblogs.com](https://www.cnblogs.com/zhuzhenwei918/p/6389567.html)

> 深入理解父元素与子元素的width关系 对于这一部分内容，如果理解准确，可以更容易控制布局，节省不必要的代码，这里将简单研究。 第一部分：父子元素都是内联元素 代码演示如下： 这时，我们在审查元素时可以发现，span和a的width（和height）的宽度是auto，即宽度是由其内容撑起来的，故为a

深入理解父元素与子元素的 width 关系
=====================

　　对于这一部分内容，如果理解准确，可以更容易控制布局，节省不必要的代码，这里将简单研究。

第一部分：父子元素都是内联元素
---------------

　　代码演示如下：

```
<!DOCTYPE html>
<html>
<head>
    <title>fortest</title>
    <style>
        /*第一种情况：父元素与子元素均为内联元素时*/
        span{
            width:200px; /*失效，因为内联元素不可设置width和height*/
        }
        a{
            width: 100%; /*失效，内联元素设置100%也是毫无意义的*/
        }
    </style>
</head>
<body>
    <span><a href="">父子元素width关系</a></span>
</body>
</html>

```

　　这时，我们在审查元素时可以发现，span 和 a 的 width（和 height）的宽度是 auto，即宽度是由其内容撑起来的，故为 auto。

第二部分：父子元素都是块级元素
---------------

　　代码如下：

```
<!DOCTYPE html>
<html>
<head>
    <title>fortest</title>
    <style>
        div.parent{
            width: 500px;
            height: 300px;
            background: #ccc;
        }
        div.son{
            width: 100%;
            height: 200px;
            background: green;
        }
    </style>
</head>
<body>
    <div>
        <div></div>
    </div>
</body>
</html>

```

　　这时，子元素设置为了父元素 width 的 100%，那么子元素的宽度也是 500px；

　　但是如果我们把子元素的 width 去掉之后，就会发现子元素还是等于父元素的 width。**也就是说，对于块级元素，子元素的宽度默认为父元素的 100%。**

> **补充：这里解释的不够清楚。实际上，当我们给子元素添加 padding 和 margin 时，可以发现宽度 width 是父元素的宽度减去子元素的 margin 值和 padding 值，下面的例子亦是如此。感谢博友 [laden666666](http://www.cnblogs.com/laden666666/) 的建议。**

 **毫无疑问，如果去掉子元素的 height，就会发先子元素的高度为 0，故 height 是不会为 100% 的，**一般我们都是通过添加内容（子元素）将父元素撑起来。

第三部分：父元素是块级元素、子元素是内联元素
----------------------

　　　**第一种情况**：内联元素是一般的类型（img、input 除外）

　　　　　毫无疑问，这种情况下，同样子元素是没有办法设置宽度的，也就谈不上 100% 的问题了。 即内联元素必须依靠其内部的内容才能撑开。

　　　**第二种情况：内联元素是 input 和 img 这样的可以设置 width 和 height 的类型**

 对于这种情况可能稍显复杂，首先应当明白：为什么 img 是内联元素还可以设置它的宽和高呢？因为除了我们常常理解的块级元素和内联元素的分类方法，还有一种替换元素和不可替换元素的分类方法，可以将之分为替换元素和不可替换元素。

#### 　　　　a) 替换元素：替换元素就是浏览器根据元素的标签和属性，来决定元素的具体显示内容的元素。

　　　　　例如浏览器会根据 <img> 标签的 src 属性的值来读取图片信息并显示出来，而如果查看 (X)HTML 代码，则看不到图片的实际内容；又例如根据 < input > 标签的 type 属性来决定是显示输入框，还是单选按钮等。(X)HTML 中的　　　　<img>、<input>、<textarea>、<select>、<object > 都是替换元素。这些元素往往没有实际的内容，即是一个空元素，例如：<img src=”cat.jpg” />  <input type="submit"  />  浏览器会根据元素的标签类型和属性来显示这些元素。可替换元素也在其显示中生成了框。

#### 　　　　b) 不可替换元素 (X)HTML 的大多数元素是不可替换元素，即其内容直接表现给用户端（例如浏览器）。

　　　　<p> 这是一个段落 </p>，这个段落 p 就是一个不可替换元素，那么其中这是一个段落会被全部显示。

　　　　**当时 img 这种元素时，不管我们怎么设置父元素的宽度和高度，而不设置 img 的宽和高时，img 总是表现为其原始的宽和高。**

 而如果我们只设置了其高度，不设置宽度看看其表现时怎么样的吧，如下所示（原始图片的大小为 1920X1080 的图片）：

```
<!DOCTYPE html>
<html>
<head>
    <title>fortest</title>
    <style>
        div.parent{
            width: 500px;
            height: 300px;
            background: #ccc;
        }
        img{
            height: 100px;
            background: green;
        }
    </style>
</head>
<body>
    <div>
        <img src="http://img2.3lian.com/2014/c7/12/d/77.jpg"></img>
    </div>
</body>
</html>

```

　　　　效果如下所示：

　　![](https://images2015.cnblogs.com/blog/1044137/201702/1044137-20170211184212385-1105323675.png)

　　由此我们可以发现，虽然没有设置宽度，但是表现在浏览器上为 160px，**它并没有继承父元素的 100% 得到 500px，而是根据既定的高度来等比例缩小宽度。  同样， 如果只设置 width，那么 height 也会等比例改变。** **如果我们把 img 的 width 设置为 100%，就可以发现其宽度这时就和父元素的宽度一致了，如下所示：**

 **![](https://images2015.cnblogs.com/blog/1044137/201702/1044137-20170211184634354-734645165.png)** 

 **而我们一般的做法时，首先确定 img 的父元素的宽度和高度，然后再将 img 的宽度和高度设置位 100%，这样，图片就能铺满父元素了。**

第四部分：同为块级元素的父元素与脱离文档流的子元素
-------------------------

　 **第一种情况：float:left 和 float:right**

 **如果将子元素设置为 float:left 或 float：right，这时它就脱离了文档流，代码如下：**

```
<!DOCTYPE html>
<html>
<head>
    <title>fortest</title>
    <style>
        div.parent{
            width: 500px;
            height: 300px;
            background: #ccc;
        }
        div.son{
            float: right;            
            height: 100px;
            background: red;　　
        }
    </style>
</head>
<body>
    <div>
        <div></div>
    </div>
</body>
</html>

```

　　这时，我们就只能看到父元素，而通过审查元素可知，子元素为 0X100，浮动在父元素的最右边。

　　**第二种情况：position:absolute 或 position:fixed**

 **同样，这种情况也是脱离正常文档流，导致 width 为 0。**

 **第三种情况: positon:relative**

 **这种情况下，子元素并没有脱离文档流，所以此时 width 就成了默认的 100%, 宽度为 500px。**

第五部分：同为块级元素的子元素和脱离文档流的父元素
-------------------------

　　第一种情况：position:absolute 或 position:fixed

　　　　代码如下：

```
<!DOCTYPE html>
<html>
<head>
    <title>fortest</title>
    <style>
        div.grand{
            position: relative;
            width: 1000px;
            height: 600px;
            background:pink;
        }
        div.parent{
            position: absolute;
            top:50px;
            left: 50px;
            width: 500px;
            height: 300px;
            background: #ccc;
        }
        div.son{
            right: 10px;
            height: 100px;
            background: red;
        }
    </style>
</head>
<body>
    <div>
      <div>
          <div></div>
      </div>
    </div>
    
</body>
</html>

```

　　效果如下：

![](https://images2015.cnblogs.com/blog/1044137/201702/1044137-20170211190320354-683716549.png)　　

　　也就是说，这时，子元素同样是默认的 100% 相对与父元素，fixed 时情况相同。

**第二种情况: float:right 或 float:left**

　　同上一种情况。

**第三种情况: position:relative**

　　同上面两种情况。

 **也就是说，父元素脱离文档流对子元素没有影响。**
