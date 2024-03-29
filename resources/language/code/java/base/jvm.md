# jvm

jvm:  java 虚拟机

## jvm 调优

#### Java虚拟机线上问题排查的2个基本操作

##### CPU 飚高

线上 CPU 飚高问题大家应该都遇到过，那么如何定位问题呢？

思路：首先找到 CPU 飚高的那个 Java 进程，因为你的服务器会有多个 JVM 进程。然后找到那个进程中的 “问题线程”，最后根据线程堆栈信息找到问题代码。最后对代码进行排查。

如何操作呢？

1. 通过 top 命令找到 CPU 消耗最高的进程，并记住进程 ID。
2. 再次通过 top -Hp [进程 ID] 找到 CPU 消耗最高的线程 ID，并记住线程 ID.
3. 通过 JDK 提供的 jstack 工具 dump 线程堆栈信息到指定文件中。具体命令：jstack -l [进程 ID] >jstack.log。
4. 由于刚刚的线程 ID 是十进制的，而堆栈信息中的线程 ID 是16进制的，因此我们需要将10进制的转换成16进制的，并用这个线程 ID 在堆栈中查找。使用 printf "%x\n" [十进制数字] ，可以将10进制转换成16进制。
5. 通过刚刚转换的16进制数字从堆栈信息里找到对应的线程堆栈。就可以从该堆栈中看出端倪。

从楼主的经验来看，一般是某个业务死循环没有出口，这种情况可以根据业务进行修复。还有 C2 编译器执行编译时也会抢占 CPU，什么是 C2编译器呢？当 Java 某一段代码执行次数超过10000次（默认）后，就会将该段代码从解释执行改为编译执行，也就是编译成机器码以提高速度。而这个 C2编译器就是做这个的。如何解决呢？项目上线后，可以先通过压测工具进行预热，这样，等用户真正访问的时候，C2编译器就不会干扰应用程序了。如果是 GC 线程导致的，那么极有可能是 Full GC ，那么就要进行 GC 的优化。

##### 内存问题排查

说完了 CPU 的问题排查，再说说内存的排查，通常，内存的问题就是 GC 的问题，因为 Java 的内存由 GC 管理。有2种情况，一种是内存溢出了，一种是内存没有溢出，但 GC 不健康。

内存溢出的情况可以通过加上 -XX:+HeapDumpOnOutOfMemoryError 参数，该参数作用是：在程序内存溢出时输出 dump 文件。

有了 dump 文件，就可以通过 dump 分析工具进行分析了，比如常用的MAT，Jprofile，jvisualvm 等工具都可以分析，这些工具都能够看出到底是哪里溢出，哪里创建了大量的对象等等信息。

第二种情况就比较复杂了。GC 的健康问题。

通常一个健康的 GC 是什么状态呢？根据楼主的经验，YGC 5秒一次左右，每次不超过50毫秒，FGC 最好没有，CMS GC 一天一次左右。

而 GC 的优化有2个维度，一是频率，二是时长。

我们看YGC，首先看频率，如果 YGC 超过5秒一次，甚至更长，说明系统内存过大，应该缩小容量，如果频率很高，说明 Eden 区过小，可以将 Eden 区增大，但整个新生代的容量应该在堆的 30% - 40%之间，eden，from 和 to 的比例应该在 8：1：1左右，这个比例可根据对象晋升的大小进行调整。

如果 YGC 时间过长呢？YGC 有2个过程，一个是扫描，一个是复制，通常扫描速度很快，复制速度相比而言要慢一些，如果每次都有大量对象要复制，就会将 STW 时间延长，还有一个情况就是 StringTable ，这个数据结构中存储着 String.intern 方法返回的常连池的引用，YGC 每次都会扫描这个数据结构（HashTable），如果这个数据结构很大，且没有经过 FGC，那么也会拉长 STW 时长，还有一种情况就是操作系统的虚拟内存，当 GC 时正巧操作系统正在交换内存，也会拉长 STW 时长。

再来看看FGC，实际上，FGC 我们只能优化频率，无法优化时长，因为这个时长无法控制。如何优化频率呢？

首先，FGC 的原因有几个，

1 是 Old 区内存不够，

2 是元数据区内存不够，

3 是 System.gc()，

4 是 jmap 或者 jcmd，

5 是CMS Promotion failed 或者 concurrent mode failure，

6 JVM 基于悲观策略认为这次 YGC 后 Old 区无法容纳晋升的对象，因此取消 YGC，提前 FGC。

通常优化的点是 Old 区内存不够导致 FGC。如果 FGC 后还有大量对象，说明 Old 区过小，应该扩大 Old 区，如果 FGC 后效果很好，说明 Old 区存在了大量短命的对象，优化的点应该是让这些对象在新生代就被 YGC 掉，通常的做法是增大新生代，如果有大而短命的对象，通过参数设置对象的大小，不要让这些对象进入 Old 区，还需要检查晋升年龄是否过小。如果 YGC 后，有大量对象因为无法进入 Survivor 区从而提前晋升，这时应该增大 Survivor 区，但不宜太大。

上面说的都是优化的思路，我们也需要一些工具知道 GC 的状况。

JDK 提供了很多的工具，比如 jmap ，jcmd 等，oracle 官方推荐使用 jcmd 代替 jmap，因为 jcmd 确实能代替 jmap 很多功能。jmap 可以打印对象的分布信息，可以 dump 文件，注意，jmap 和 jcmd dump 文件的时候会触发 FGC ，使用的时候注意场景。

还有一个比较常用的工具是 jstat，该工具可以查看GC 的详细信息，比如eden ，from，to，old 等区域的内存使用情况。

还有一个工具是 jinfo，该工具可以查看当前 jvm 使用了哪些参数，并且也可以在不停机的情况下修改参数。

包括我们上面说的一些分析 dump 文件的可视化工具，MAT，Jprofile，jvisualvm 等，这些工具可以分析 jmap dump 下来的文件，看看哪个对象使用的内存较多，通常是能够查出问题的。

还有很重要的一点就是，线上环境一定要带上 GC 日志！！！

#### jvm 监控

##### Arthas | Java诊断工具

`Arthas` 是Alibaba开源的*Java诊断工具*，深受开发者喜爱。在线排查问题，无需重启；动态跟踪Java代码；实时监控JVM状态

在线教程 [Arthas Tutorials (aliyun.com)](https://arthas.aliyun.com/doc/arthas-tutorials.html?language=cn&id=arthas-basics)

[arthas/README_CN.md at master · alibaba/arthas (github.com)](https://github.com/alibaba/arthas/blob/master/README_CN.md)

## OOM
### 线程池相关的

https://blog.csdn.net/liuchangjie0112/article/details/90698401
https://blog.csdn.net/weixin_37968613/article/details/104490441
https://blog.csdn.net/qing040513/article/details/111667627
https://www.cnblogs.com/jxxblogs/p/11882381.html
[常用线程池及使用场景](https://blog.csdn.net/qq_39992056/article/details/86499176#:~:text=%E5%90%84%E4%B8%AA%E7%BA%BF%E7%A8%8B%E6%B1%A0%E7%9A%84%E5%8C%BA%E5%88%AB%E5%92%8C%E4%BD%BF%E7%94%A8%E5%9C%BA%E6%99%AF%EF%BC%9A%201%20%E5%9C%BA%E6%99%AF%EF%BC%9A%E6%89%A7%E8%A1%8C%E5%BE%88%E5%A4%9A%E7%9F%AD%E6%9C%9F%E5%BC%82%E6%AD%A5%E7%9A%84%E5%B0%8F%E7%A8%8B%E5%BA%8F%E6%88%96%E8%80%85%E8%B4%9F%E8%BD%BD%E8%BE%83%E8%BD%BB%E7%9A%84%E6%9C%8D%E5%8A%A1%E5%99%A8%20newFixedThreadPool%EF%BC%9A%20%E5%BB%BA%E5%8F%AF%E5%AE%B9%E7%BA%B3%E5%9B%BA%E5%AE%9A%E6%95%B0%E9%87%8F%E7%BA%BF%E7%A8%8B%E7%9A%84%E6%B1%A0%E5%AD%90%EF%BC%8C%E6%AF%8F%E9%9A%94%E7%BA%BF%E7%A8%8B%E7%9A%84%E5%AD%98%E6%B4%BB%E6%97%B6%E9%97%B4%E6%98%AF%E6%97%A0%E9%99%90%E7%9A%84%EF%BC%8C%E5%BD%93%E6%B1%A0%E5%AD%90%E6%BB%A1%E4%BA%86%E5%B0%B1%E4%B8%8D%E5%9C%A8%E6%B7%BB%E5%8A%A0%E7%BA%BF%E7%A8%8B%E4%BA%86%EF%BC%9B%E5%A6%82%E6%9E%9C%E6%B1%A0%E4%B8%AD%E7%9A%84%E6%89%80%E6%9C%89%E7%BA%BF%E7%A8%8B%E5%9D%87%E5%9C%A8%E7%B9%81%E5%BF%99%E7%8A%B6%E6%80%81%EF%BC%8C%E5%AF%B9%E4%BA%8E%E6%96%B0%E4%BB%BB%E5%8A%A1%E4%BC%9A%E8%BF%9B%E5%85%A5%E9%98%BB%E5%A1%9E%E9%98%9F%E5%88%97%E4%B8%AD%202%20%E5%9C%BA%E6%99%AF%EF%BC%9A%E6%89%A7%E8%A1%8C%E9%95%BF%E6%9C%9F%E7%9A%84%E4%BB%BB%E5%8A%A1%EF%BC%8C%E6%80%A7%E8%83%BD%E5%A5%BD%E5%BE%88%E5%A4%9A%20newSingleThreadExecutor%3A,3%20%E5%9C%BA%E6%99%AF%EF%BC%9A%E4%B8%80%E4%B8%AA%E4%BB%BB%E5%8A%A1%E4%B8%80%E4%B8%AA%E4%BB%BB%E5%8A%A1%E6%89%A7%E8%A1%8C%E7%9A%84%E5%9C%BA%E6%99%AF%20NewScheduledThreadPool%3A%20...%204%20%E5%9C%BA%E6%99%AF%EF%BC%9A%E5%91%A8%E6%9C%9F%E6%80%A7%E6%89%A7%E8%A1%8C%E4%BB%BB%E5%8A%A1%E7%9A%84%E5%9C%BA%E6%99%AF%20%E4%BD%BF%E7%94%A8%E7%BA%BF%E7%A8%8B%E6%B1%A0%E7%9A%84%E4%BC%98%E7%82%B9%EF%BC%9A%20)


[十分钟带你了解 Oracle 最新的 JVM 技術——GraalVM](https://zhuanlan.zhihu.com/p/106555993)