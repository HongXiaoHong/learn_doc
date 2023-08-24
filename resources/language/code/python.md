# python

## 变量

### 局部变量

#### 全局局部变量

可以使用 locals() 在模块中返回 全部的全局变量

```python
> locals()
```

##### \_\_FILE\_\_ | 当前文件的全路径

```python
print(__file__)
print(path.dirname(__file__)

""" 
e:\python\file__.py
e:\python 
"""

```

## 函数

### 😏locals | 函数更新并以字典形式返回当前全部局部变量

- 如果locals()出现在函数模块主体中,则会返回模块的默认局部变量
- locals() 会返回直到函数本身位置的所有局部变量,local本行后面的变量不会被返回
- 如果locals()只出现在模块中的某个函数定义中, 当声明此函数时,返回此函数中的局部变量与函数输入参数

```python
# locals() 测试
# 在模块中 则返回所有全局局部变量
print(locals())
def locals_in_function():
    a = 10
    print(__file__)
    # 在函数中 则只返回参数跟局部变量
    print(locals())
    print(__file__ in locals())

locals_in_function()
```

### 😬运行结果:

```bash
{'__name__': '__main__', '__doc__': ' \ne:\\python\x0cile__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n', '__package__': None, '__loader__': None, '__spec__': None, '__builtin__': <module 'builtins' (built-in)>, '__builtins__': <module 'builtins' (built-in)>, '_ih': ['', 'from os import path\n\n\nprint(__file__)\n\nprint(locals())\n\nprint(path.dirname(__file__))\n\nprint("Pylance")\n\nprint(path.abspath(__file__))', 'from os import path\n\n# __file__ 测试\nprint(__file__)\nprint(path.dirname(__file__))\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(locals())\n\nlocals_in_function()', 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n\nlocals_in_function()', 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n    print(__file__ in locals())\n\nlocals_in_function()'], '_oh': {}, '_dh': [WindowsPath('e:/python'), WindowsPath('e:/python')], 'In': ['', 'from os import path\n\n\nprint(__file__)\n\nprint(locals())\n\nprint(path.dirname(__file__))\n\nprint("Pylance")\n\nprint(path.abspath(__file__))', 'from os import path\n\n# __file__ 测试\nprint(__file__)\nprint(path.dirname(__file__))\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(locals())\n\nlocals_in_function()', 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n\nlocals_in_function()', 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n    print(__file__ in locals())\n\nlocals_in_function()'], 'Out': {}, 'get_ipython': <function get_ipython at 0x000002BC64376670>, 'exit': <IPython.core.autocall.ZMQExitAutocall object at 0x000002BC662FFD90>, 'quit': <IPython.core.autocall.ZMQExitAutocall object at 0x000002BC662FFD90>, 'open': <function open at 0x000002BC64751040>, '_': '', '__': '', '___': '', '_VSCODE_types': <module 'types' from 'd:\\app\\code\\python\\python-3.9.5\\lib\\types.py'>, 'os': <module 'os' from 'd:\\app\\code\\python\\python-3.9.5\\lib\\os.py'>, '_VSCODE_hashlib': <module 'hashlib' from 'd:\\app\\code\\python\\python-3.9.5\\lib\\hashlib.py'>, '__VSCODE_wrapped_run_cell': False, '__VSCODE_compute_hash': <function __VSCODE_compute_hash at 0x000002BC66339AF0>, '__VSCODE_wrap_run_cell': <function __VSCODE_wrap_run_cell at 0x000002BC66339160>, 'sys': <module 'sys' (built-in)>, '__vsc_ipynb_file__': 'e:\\python\\file__.py', '__file__': 'e:\\python\\file__.py', '_i': 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n\nlocals_in_function()', '_ii': 'from os import path\n\n# __file__ 测试\nprint(__file__)\nprint(path.dirname(__file__))\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(locals())\n\nlocals_in_function()', '_iii': 'from os import path\n\n\nprint(__file__)\n\nprint(locals())\n\nprint(path.dirname(__file__))\n\nprint("Pylance")\n\nprint(path.abspath(__file__))', '_i1': 'from os import path\n\n\nprint(__file__)\n\nprint(locals())\n\nprint(path.dirname(__file__))\n\nprint("Pylance")\n\nprint(path.abspath(__file__))', 'path': <module 'ntpath' from 'd:\\app\\code\\python\\python-3.9.5\\lib\\ntpath.py'>, '_i2': 'from os import path\n\n# __file__ 测试\nprint(__file__)\nprint(path.dirname(__file__))\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(locals())\n\nlocals_in_function()', 'locals_in_function': <function locals_in_function at 0x000002BC6638F3A0>, '_i3': 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n\nlocals_in_function()', '_i4': 'from os import path\n\n# __file__ 测试\n""" \ne:\\python\\file__.py\ne:\\python \n\nprint(__file__)\nprint(path.dirname(__file__))\n"""\n\n# locals() 测试\nprint(locals())\ndef locals_in_function():\n    a = 10\n    print(__file__)\n    print(locals())\n    print(__file__ in locals())\n\nlocals_in_function()'}
e:\python\file__.py
{'a': 10}
False
```

## 使用vscode

右键运行

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/Code_iR8Z5E9vwW.png)

**python.exe -m pip install ipykernel -U --user --force-reinstall**

### 升级pip

```bash
E:\documents\notes\learn_doc>python.exe -m pip install --upgrade pip
Requirement already satisfied: pip in d:\app\code\python\python-3.9.5\lib\site-packages (21.1.2)
Collecting pip
  Downloading pip-22.3.1-py3-none-any.whl (2.1 MB)
     |████████████████████████████████| 2.1 MB 10 kB/s
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 21.1.2
    Uninstalling pip-21.1.2:
      Successfully uninstalled pip-21.1.2
Successfully installed pip-22.3.1
```

## Python带条件判断的赋值语句

Python 的赋值语句，有一种带条件判断的语法，将赋值和条件判断融为一行代码，使需要条件判断的赋值代码写起来更加简练高效，与 Java 语言中的三元表达式 ?: 语法一样。

### 🫡赋值语句中的if

```python
>>> a = 123 if True else 321
>>> a
123
>>> a = 123 if False else 321
>>> a
321
```

以上代码，给变量 a 赋值，如果 if 条件为真，a 的取值就是 if 前面的那个值，如果if 的条件为假，a 的取值就是 else 后面的值。

### 🤔复杂的例子

上面例子代码写的比较简单，

实际情况下if判断可以写的很复杂，而且还可以嵌套：

```python
>>> a = 1
>>> b = 2
>>> c = 2 if a==2 else 3 if b==2 else 4
>>> c
3
>>> c = 2 if a==2 else 3 if b!=2 else 4
>>> c
4
>>> c = 2 if a==1 else 3 if b!=2 else 4
>>> c
2
```

## 包的使用

### wordcloud | 词云

> 赢在起跑线上

词云是关键词的视觉化描述，用于汇总用户生成的标签或一个网站的文字内容。标签一般是独立的词汇，常常按字母顺序排列，其重要程度又能通过改变字体大小或颜色来表现，所以标签云可以灵活地依照字序或热门程度来检索一个标签。 大多数标签本身就是超级链接，直接指向与标签相联的一系列条目

#### 词云的历史

在标签云以权重表的形态出现之前，传统纸质地图早已使用不同大小或粗细的字体来表示城镇的相对面积或重要性。

在英文出版物里，标签云的概念首次以“潜意识文档”（subconscious files）的名字出现在1995年出版的道格拉斯·柯普兰（Douglas Coupland）的《微软信徒》（Microserfs）一书中。

照片分享社区Flickr是首个使用标签云的知名网站，其标签云由网站共同创立者、界面交互设计师斯图尔特·巴特菲尔德（Stewart Butterfield）设计创造，基于Jim Flanagan的Search Referral Zeitgeist，一个分析整理网站参考日志（HTTP referrer）的可视化应用实现。Del.icio.us和Technorati等网站也为标签云的普及起了推动作用。

2009年3月24日，CNN为当晚的安德森库珀360度（Anderson Cooper 360°）节目制作了一个声称是世界最大的文字云，文字云内容来源于当天奥巴马对新闻界发布的声明

#### 安装 wordcloud 包

```bash
pip install wordcloud
```

#### 官方文档

[简单的例子](http://amueller.github.io/word_cloud/auto_examples/index.html)

[wordcloud python in GitHub](https://github.com/amueller/word_cloud)

#### 一个最简单的例子

入门来说够用了

```python
#!/usr/bin/env python
"""
最简单的例子
===============

使用默认参数从编程语言生成一个方形词云
"""

import os

from os import path
from wordcloud import WordCloud

# 获取数据路径
# 在 IPython notebook 下则使用 getcwd()
d = path.dirname(__file__) if "__file__" in locals() else os.getcwd()


# 读取 constitution.txt 的文本
text = open(path.join(d, 'code_language.txt')).read()

# 生成一个词云图片
wordcloud = WordCloud().generate(text)

# 使用 matplotlib 展示生成图片
import matplotlib.pyplot as plt
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")

# 没有 matplotlib 也可以使用 pil 展示图片
# image = wordcloud.to_image()
# image.show()
```

code_language.txt

```context
Java Java Java Java Java Java 
Spring
SpringBoot
Mybatis
Oracle
MySQL
Python
C C++ 
JavaScript 
CSS
HTML
```

#### 运行结果

在 vscode 中展示词云结果

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/Code_3Y97vRGD6s.png)

生成的图片

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/output_wordcloud.png)

### Faker

Faker是一个Python包，主要用来创建伪数据，使用Faker包，无需再手动生成或者手写随机数来生成数据，只需要调用Faker提供的方法，即可完成数据的生成。

[推荐一款Python开源库，技术人必备的造数据神器！ (qq.com)](https://mp.weixin.qq.com/s?__biz=MzA4NDUyNzA0Ng==&mid=2247486145&idx=1&sn=4d309ad345174c63c9855501ae10c883&chksm=9fe49868a893117e917b241df9883c9b2c11374457162d88beba49960ced833a8a89d7ca1784&scene=21#wechat_redirect)


## 异常

### 常用
https://www.cosmiclearn.com/lang-cn/python-exceptions.php

以下是Python中异常处理的基本概念和常用代码的总结：

## 异常处理的几种方式

1. **Try, Except**
2. **Try, Except, Finally**
3. **Try, Except, Except, Finally**
4. **用户定义的异常**

## 详细说明和代码示例

### Try, Except

这是处理异常的基本结构。在try块中，你将编写可能会抛出异常的代码。在except块中，你将编写处理异常的代码。

```python
import traceback
try:
    i = 10
    j = i/0
except ZeroDivisionError:
    traceback.print_exc()
print("Program Proceeds!")
```

### Try, Except, Finally

在这种情况下，无论try块中是否发生异常，finally块中的代码都将被执行。这通常用于确保资源（如文件或数据库连接）在程序结束时被正确关闭。

```python
import traceback
fi = None
try:
    fi = open("godzilla.txt", "rb")
    i = 0
    j = i/0
except:
    traceback.print_exc()
finally:
    if fi:
        fi.close()
```

### Try, Except, Except, Finally

有时可能需要将多个except语句附加到同一个try块中。你应确保按异常层次结构的降序使用异常，因为将首先检查第一个catch块。

```python
import traceback
try:
    i = 10
    j = i/0
    i = [1,2,3]
    print(i[10])
except ZeroDivisionError:
    traceback.print_exc()
except IndexError:
    traceback.print_exc()
except:
    traceback.print_exc()
finally:
    print("Break the rules!")
print("Program Proceeds!")
```

### 用户定义的异常

有时，Python库提供的异常可能不足以满足我们的应用程序。在这种情况下，我们可以定义自己的异常。

```python
class CosmicException(Exception):
    pass

validPlanets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
def helloPlanet(planetName):
    if planetName not in validPlanets:
        raise CosmicException("Invalid Planet - {}".format(planetName))
    print("Hello {}".format(planetName))

helloPlanet("Earth")
helloPlanet("Pluto")
```


### python主动抛出异常
https://www.cnblogs.com/aaronthon/p/15103274.html
一、主动抛出异常 raise

Python 使用 raise 语句抛出一个指定的异常。

raise 唯一的一个参数指定了要被抛出的异常。

它必须是一个异常的实例或者是异常的类（也就是 Exception 的子类）。

如下：
```python

x = 10
if x > 5:
    raise Exception('x 不能大于 5。x 的值为: {}'.format(x))
```
结果如下：

Traceback (most recent call last):
  File "test.py", line 3, in <module>
    raise Exception('x 不能大于 5。x 的值为: {}'.format(x))
Exception: x 不能大于 5。x 的值为: 10
如果你只想知道这是否抛出了一个异常，并不想去处理它，那么一个简单的 raise 语句就可以再次把它抛出。

```python
try:
    raise NameError('HiThere')
except NameError:
    print('An exception flew by!')
    raise
```

## 常用模块
### os
#### 文件操作
##### 文件遍历
###### walk  | 递归遍历子目录
https://blog.csdn.net/mighty13/article/details/77995857
```python
os.walk(top[, topdown=True[, onerror=None[, followlinks=False]]])

#conding=utf8  
import os 

g = os.walk(r"e:\test")  

for path,dir_list,file_list in g:  
    for file_name in file_list:  
        print(os.path.join(path, file_name) )
```
###### listdir | 遍历子目录
