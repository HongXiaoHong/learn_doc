# python关键字

## in

[Python 中 in 的用法总结_python中in的用法_zhangvalue的博客-CSDN博客](https://blog.csdn.net/zhangvalue/article/details/94598781)

<table><tbody><tr><td>in</td><td>如果在指定的序列中找到值返回 True，否则返回 False。</td><td>x 在 y 序列中 , 如果 x 在 y 序列中返回 True。</td></tr><tr><td>not in</td><td>如果在指定的序列中没有找到值返回 True，否则返回 False。</td><td>x 不在 y 序列中 , 如果 x 不在 y 序列中返回 True。</td></tr></tbody></table>

<table><tbody><tr><td>is</td><td>is 是判断两个标识符是不是引用自一个对象</td><td><strong>x is y</strong>, 类似 <strong>id(x) == id(y)</strong> , 如果引用的是同一个对象则返回 True，否则返回 False</td></tr><tr><td>is not</td><td>is not 是判断两个标识符是不是引用自不同对象</td><td><strong>x is not y</strong> ， 类似 <strong>id(a) != id(b)</strong>。如果引用的不是同一个对象则返回结果 True，否则返回 False。</td></tr></tbody></table>

`in` 在 python 中的使用很常见，用处也很多，很强大，这里记录下几种常见的用法。

1. 在 for 循环中，获取列表或者元组的每一项：
   
   ```python
   for item in list:
   
   ```

2. 判断左边的元素是否包含于列表，类似 java 中的 List 的 contains 方法

```python

   if 1 in aa:
     print 'Very Good'
   else:
     print 'Not Bad'
```

 这里是判断 1 是否在 aa 内部

3. 可以用来判断字符串是否包含某一串, 可以用来筛选文件使用
   
   ```python
   
   ```

if 'a' in 'qa'
 print 'ok'

```
4.  比如判断 project_admin 是否是数字 1 或者字符串 “1”

```python

if project_admin in (1, "1")
```

注意：如果是想比较两个字符串是否相等，还是需要用 `==` 或者 `!=`