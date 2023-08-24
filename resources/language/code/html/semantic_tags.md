# html5 语义化标签

[HTML：无障碍的良好基础 - 学习 Web 开发 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Learn/Accessibility/HTML)

[<section>: The Generic Section element - HTML: HyperText Markup Language | MDN --- <section>：通用节元素 - HTML：超文本标记语言 |多核 (mozilla.org)](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/section#usage_notes)



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_yaZRisj4kf.png)

```html

<!DOCTYPE html>
<html lang="en-us">
  <head>
    <meta charset="utf-8">

    <title>My page title</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300|Sonsie+One" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="style.css">
  </head>

  <body>
    <!-- Here is our main header that is used across all the pages of our website -->

    <header>
      <h1>Header</h1>
    </header>

    <nav>
      <ul>
        <li><a href="#">Home</a></li>
        <li><a href="#">Our team</a></li>
        <li><a href="#">Projects</a></li>
        <li><a href="#">Contact</a></li>
      </ul>

      <!-- A Search form is another common non-linear way to navigate through a website. -->

      <form>
        <input type="search" name="q" placeholder="Search query">
        <input type="submit" value="Go!">
      </form>
    </nav>

    <!-- Here is our page's main content -->
    <main>

      <!-- It contains an article -->
      <article>
        <h2>Article heading</h2>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Donec a diam lectus. Set sit amet ipsum mauris. Maecenas congue ligula as quam viverra nec consectetur ant hendrerit. Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut porta lorem lacinia consectetur.</p>

        <h3>subsection</h3>

        <p>Donec ut librero sed accu vehicula ultricies a non tortor. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aenean ut gravida lorem. Ut turpis felis, pulvinar a semper sed, adipiscing id dolor.</p>

        <p>Pelientesque auctor nisi id magna consequat sagittis. Curabitur dapibus, enim sit amet elit pharetra tincidunt feugiat nist imperdiet. Ut convallis libero in urna ultrices accumsan. Donec sed odio eros.</p>

        <h3>Another subsection</h3>

        <p>Donec viverra mi quis quam pulvinar at malesuada arcu rhoncus. Cum soclis natoque penatibus et manis dis parturient montes, nascetur ridiculus mus. In rutrum accumsan ultricies. Mauris vitae nisi at sem facilisis semper ac in est.</p>

        <p>Vivamus fermentum semper porta. Nunc diam velit, adipscing ut tristique vitae sagittis vel odio. Maecenas convallis ullamcorper ultricied. Curabitur ornare, ligula semper consectetur sagittis, nisi diam iaculis velit, is fringille sem nunc vet mi.</p>
      </article>

      <!-- the aside content can also be nested within the main content -->
      <aside>
        <h2>Related</h2>

        <ul>
          <li><a href="#">Oh I do like to be beside the seaside</a></li>
          <li><a href="#">Oh I do like to be beside the sea</a></li>
          <li><a href="#">Although in the North of England</a></li>
          <li><a href="#">It never stops raining</a></li>
          <li><a href="#">Oh well...</a></li>
        </ul>
      </aside>

    </main>

    <!-- And here is our main footer that is used across all the pages of our website -->

    <footer>
      <p>©Copyright 2050 by nobody. All rights reversed.</p>
    </footer>

  </body>
</html>

```

style.css

```css
/* || General setup */
html, body {
  margin: 0;
  padding: 0;
}
html {
  font-size: 10px;
  background-color: #a9a9a9;
}
body {
  width: 70%;
  margin: 0 auto;
}
/* || typography */
h1, h2, h3 {
  font-family: 'Sonsie One', cursive;
  color: #2a2a2a;
}
p, input, li {
  font-family: 'Open Sans Condensed', sans-serif;
  color: #2a2a2a;
}
h1 {
  font-size: 4rem;
  text-align: center;
  color: white;
  text-shadow: 2px 2px 10px black;
}
h2 {
  font-size: 3rem;
  text-align: center;
}
h3 {
  font-size: 2.2rem;
}
p, li {
  font-size: 1.6rem;
  line-height: 1.5;
}
/* || header layout */
nav, article, aside, footer {
  background-color: white;
  padding: 1%;
}
nav {
  height: 50px;
  background-color: #ff80ff;
  display: flex;
  margin-bottom: 10px;
}
nav ul {
  padding: 0;
  list-style-type: none;
  flex: 2;
  display: flex;
}
nav li {
  display: inline;
  text-align: center;
  flex: 1;
}
nav a {
  display: inline-block;
  font-size: 2rem;
  text-transform: uppercase;
  text-decoration: none;
  color: black;
}
nav form {
  flex: 1;
  display: flex;
  align-items: center;
  height: 100%;
  padding: 0 2em;
}
input {
  font-size: 1.6rem;
  height: 32px;
}
input[type="search"] {
  flex: 3;
}
input[type="submit"] {
  flex: 1;
  margin-left: 1rem;
  background: #333;
  border: 0;
  color: white;
}
/* || main layout */
main {
  display: flex;
}
article {
  flex: 4;
}
aside {
  flex: 1;
  margin-left: 10px;
  background-color: #ff80ff;
}
aside li {
  padding-bottom: 10px;
}
footer {
  margin-top: 10px;
}
```





### 使用说明

来自 [section: The Generic Section element - HTML: HyperText Markup Language | MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/section#usage_notes)

section是一个通用的切片元素，只有在没有更具体的元素来表示它时才应使用。例如，导航菜单应包装在元素中，但搜索结果列表或地图显示及其控件没有特定 `nav` 元素，可以放在 `section` .

如果元素的内容表示一个独立的原子内容单元，可以作为独立的部分（例如博客文章或博客评论，或报纸文章）联合使用，则该 `<article>` 元素将是更好的选择。

如果内容表示与主要内容并列的有用切线信息，但不是主要内容直接的一部分（如相关链接或作者简介），请使用 `<aside>` .

如果内容表示文档的主要内容区域，请使用 `<main>` 。

如果仅将元素用作样式包装器，请改用 。 `<div>`

重申一下， `<section>` 应尽可能通过包括一个标题（h1 - h6 元素）作为元素的子元素来标识每个 `<section>` 元素。有关您可能会看到 `<section>` 没有标题的示例，请参阅下文。
