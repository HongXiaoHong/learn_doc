# zookeeper

## windows 安装

下载: [Apache Downloads](https://www.apache.org/dyn/closer.lua/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz)

参考 [Windows下Zookeeper安装使用 - 简书](https://www.jianshu.com/p/0447ab3dfd5b)

windows 搭建集群也可以参照上面那个

## 使用 docker 部署zookeeper

```bash
docker run --name my-zookeeper --restart always -d -v //E/zookeeper/data:/data -p 2181:2181 zookeeper
```

可以参考

[Docker(十一): 安装zookeeper - Chinda - 博客园](https://www.cnblogs.com/chinda/p/16440143.html)

[Docker 安装 zookeeper 及 常见错误_docker zookeeper 无法访问_三名的博客-CSDN博客](https://blog.csdn.net/qq_33339182/article/details/107145203)

部署过程中遇到一个问题

```log
/docker-entrypoint.sh: line 43: /conf/zoo.cfg: Is a directory
```

我之前是使用这个

-v //E/zookeeper/conf/zoo.cfg:/conf/zoo.cfg 挂载到本地

```bash
docker run --name my-zookeeper --restart always -d -v //E/zookeeper/conf/zoo.cfg:/conf/zoo.cfg -p 2181:2181 zookeeper
```

去掉文件 之后还是有问题 一样报错日志

挂载data 倒是没有问题

看了博客说是要赋权  我本地是windows11 

还是算了 之后再 Linux 系统有幸再尝试一下吧

## 客户端

### idea 使用 zoolytic  连接

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_6pr8OuSyZd.png)

PS: 另一个插件 zookeeper 有问题

zookeeper 版本: 0.0.14

idea 版本:

IntelliJ IDEA 2021.1.3 (Ultimate Edition)
Build #IU-211.7628.21, built on June 30, 2021
Licensed to IntelliJ IDEA Evaluator
Expiration date: April 3, 2023
Runtime version: 11.0.11+9-b1341.60 amd64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
Windows 10 10.0
GC: ParNew, ConcurrentMarkSweep
Memory: 2988M
Cores: 12
Non-Bundled Plugins: com.ky-proj.spjplugin (1.8.0), io.zhile.research.ide-eval-resetter (2.3.5), leetcode-editor (8.6), org.ice1000.a8translate (1.8), GrepConsole (12.15.211.6693.1), zookeeper (0.0.14), MavenRunHelper (4.13.203.000.0), cn.wuzhizhan.plugin.mybatis (2020.12.18), org.zoolytic (0.5.2)
Kotlin: 211-1.4.32-release-IJ7628.19

### 好看的客户端 PrettyZoo

下载地址: [Releases · vran-dev/PrettyZoo · GitHub](https://github.com/vran-dev/PrettyZoo/releases)

使用: [推荐一款神仙颜值的 ZooKeeper 客户端工具 - 腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1758584)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/prettyZoo_TX2vh9nLB4.png)