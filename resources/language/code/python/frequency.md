# python
## 常用
### 执行脚本当前路径
[python获取程序执行文件路径方法](https://blog.csdn.net/py_tester/article/details/78954034)

```python

# sys.argv
# 一个传给Python脚本的指令参数列表。sys.argv[0]是脚本的名字。一般得到的是相对路径，用os.path.abspath(sys.argv[0])得到执行文件的绝对路径：
dirname, filename = os.path.split(os.path.abspath(sys.argv[0]))
```

### [Python格式化字符串的几种方法](http://blog.lujun9972.win/blog/2017/03/24/python%E6%A0%BC%E5%BC%8F%E5%8C%96%E5%AD%97%E7%AC%A6%E4%B8%B2%E7%9A%84%E5%87%A0%E7%A7%8D%E6%96%B9%E6%B3%95/index.html)

Formatted String Literals(Python3.6)
格式化字符串文字（Python3.6）
这种格式化字符串的方法是由Python3.6新加入的. 它允许你在字符串内内嵌Python运算式:
```python
# 11 + 2 = 13;11 - 2 = 9
a = 11
b = 2
return f'{a} + {b} = {a + b};{a} - {b} = {a - b}'
# 它也同时支持str.format()方法中的那些格式化符,且使用方法也一样:
# 222 的16进制表示是 0xde
num = 222
return f'{num} 的16进制表示是 {num:#x}'
```

### 文件
#### 删除
[Python有一些内置模块，可让您删除文件和目录。本教程说明了如何使用os，pathlib和shutil模块中的功能删除文件和目录](https://www.myfreax.com/python-delete-files-and-directories/)
```python
import shutil

dir_path = '/tmp/img'

try:
    shutil.rmtree(dir_path)
except OSError as e:
    print("Error: %s : %s" % (dir_path, e.strerror))
```

#### 递归复制
```python

import shutil

dst = shutil.copytree('dir1', 'dir2')

print(dst) # 返回dir2
```

#### 递归创建目录

```python
os.mkdir()可以创建指定的目录，但如果其上一级目录不存在，则无法创建成功。

os.makedirs()则可以实现递归创建目录的功能。
```


### 指令
#### 特定目录下执行
```python 
subprocess.check_call('gradle assembleRelease', shell=True, cwd='D:/ANDROID/test1/HBuilder-Integrate-AS')
```

### 执行程序
#### 后台运行
```python
subprocess.check_call('start nginx', shell=True, cwd='D:/app/code/nginx-1.24.0')
```

[windows中一个python脚本中打开一个新的cmd终端执行另一个脚本_windows执行py脚本,调用另一个脚本-CSDN博客](https://blog.csdn.net/s_daqing/article/details/104621198)
