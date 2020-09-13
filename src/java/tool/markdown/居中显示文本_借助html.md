### problem
markdown中没有快捷方式可以居中文本

这里我们只能借助html中的层叠样式表居中文本

### solve
```html
<div style='text-align:center'>
<h4>那些你所不知道的大事</h4>
<i>李月亮</i>
</div>
```

关键点在于使用css的**text-align**进行居中
当然我们可以使用其他属性控制样式 
```css
color:green;font-size:16px
```

#### 参考

[此文作者用了另一个标签center解决的-markdown让文字居中和带颜色](https://www.cnblogs.com/bigmagic/p/3301b25e8b0b8ef8b9415379385a798c.html)