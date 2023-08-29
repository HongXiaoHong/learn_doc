# 异步 IO

## 协程

这两个视频, 一个介绍了 线程与协程

一个介绍了 io多路复用中的 select poll 以及 epoll

还有 io 多路复用与 协程之间的关系

[【协程第一话】协程到底是怎样的存在？_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1b5411b7SD/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[【协程第二话】协程和IO多路复用更配哦~_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1a5411b7aZ/?spm_id_from=333.788.recommend_more_video.-1&vd_source=eabc2c22ae7849c2c4f31815da49f209)


### java中的协程
https://zhuanlan.zhihu.com/p/579732019

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230826210544.png)
Virtual Thread 将会在性能上带来的巨大提高，不过，目前业界 80~90%的代码还跑在 Java 8 上，等 JDK19 投入实际生产环境，可能需要一个漫长的过程；
虚拟线程高度复用了现有的 Thread 线程的功能，方便现有方式平滑迁移到虚拟线程；
虚拟线程是将 Thread 作为载体线程，它并没有改变原来的线程模型；
虚拟线程是 JVM 调度的，而不是操作系统调度；
使用虚拟线程可以显著提高程序吞吐量；
虚拟线程适合 并发任务数量很高 或者 IO 密集型的场景，对于 计算密集型任务还需通过过增加 CPU 核心解决，或者利用分布式计算资源来来解决；
虚拟线程目前只是一个预览功能，只能从源码和简单的测试来分析，并无真实生产环境的验证；
曾一段时间内，JDK 一直致力于 Reactor 响应式编程，试图从这条路子来提升 Java 的性能，但是最终发现：响应式编程难理解，难调试，难使用，因此又把焦点转向了同步编程，为了改善性能，虚拟线程诞生了。或许虚拟线程很难在短时间内运用到实际生产中，但是通过官方的 JDK 版本发布，我们可以看到：尽管是 Oracle 这样的科技型巨头也会走弯路，了解 JDK 的动态，可以帮助我们更好的把握学习 Java 的重心以及后面的发展趋势。

https://segmentfault.com/a/1190000005342905#item-3
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230826211232.png)

java 中协程叫做 虚拟线程
jdk19已经有对应的预览功能
jdk21 会正式上线, 也就是 23 年 9 月会正式上线

通过 ForkJoinPool 实现
会在线程阻塞的时候, 让出线程, 让其他任务先执行