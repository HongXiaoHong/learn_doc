# 各个语言之间版本进行切换

## JavaScript

JavaScript 切换 node 版本
使用 nvm 进行切换

## python

使用 virtualenv 切换环境

可以在新建 python 项目的时候使用 virtualenv 切换环境
也可以先在本地环境中 首先创建虚拟环境后 在创建项目的时候选择不同虚拟环境

但我觉得还是直接在项目路径中直接创建一个虚拟环境最好了
用户只需要安装python  以及 virtualenv 就可以使用, 
不用本地切换到跟我们项目同一个版本

https://juejin.cn/post/7232658803446972475#heading-15

这个博客介绍了 如何使用 virtualenv 以及如何在 pycharm 中使用 virtualenv
涉及环境变量: WORKON_HOME

virtualenvwrapper

所有的操作请使用 cmd 终端执行，而不是powershell！
virtualenv最大的缺点就是：每次开启虚拟环境都要去找到虚拟环境所在的位置，然后启动activate，这问题就来了，如果虚拟环境多了，然后记性差的同学又忘记了虚拟环境所在的位置....怎么办呢？


将所有的虚拟环境全部都集中起来放到一个目录下进行集中管理。
使用virtualenvwrapper管理你的虚拟环境。

接下来，我们一起来看看如何使用virtualenvwrapper管理虚拟环境。
关于virtualenvwrapper
virtualenvwrapper是virtualenv的扩展包，丰富了virtualenv的功能，让我们更加方便的管理虚拟环境。
主要功能

将所有的虚拟环境整合到一个目录下
一键管理(add、remove、copy)虚拟环境
一键切换虚拟环境

## java

java 就没那么方便

需要自己先下载好 jdk 各个版本到本地

然后通过自己在本地编写 bat 脚本
https://blog.csdn.net/qq_21808961/article/details/102217844
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230727110438.png)

### maven
maven 切换脚本倒是简单一点

可以通过 maven wrapper 进行切换

https://springhow.com/maven-wrapper-explained/

```bash
mvn wrapper:wrapper -Dmaven=3.8.4
```