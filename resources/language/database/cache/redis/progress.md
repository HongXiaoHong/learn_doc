# redis 演进

## 单体

宕机了, 系统出现错误

## 主从复制

解决读多写少的问题
但是主节点出现错误, 写无法进行, 系统仍然会错误

## 哨兵模式

解决 redis 宕机系统错误的问题, 帮助我们重新选出主节点进行缓存
但是呢
数据都存放到主节点, 数据量太大, 已经无法容纳太大的数据量

## 集群模式

引入集群模式是为了解决上面只能进行 redis 主节点单点存储数据问题的问题

引入多个 redis 节点 ＋ 哈希槽 来增加写入

通过引入 哈希槽 来解决数据都存放到一个节点中, 
key  通过哈希计算应该存放到哪个节点
而不是都放置到同一个节点

> hash(key) % redis 节点数量
> 这样以后 redis 中可以存放的数据量可以急剧增加了

但是还是有问题
如果我们需要进行过扩容
这个时候, 增加一个节点, 哈希槽重新计算, 这个时候原先的缓存基本都会失效
造成 缓存雪崩
系统容易崩溃

## 一致性 hash 算法

解决方法:
使用 [一致性 hash 算法](https://www.bilibili.com/video/BV1Hs411j73w/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

也就是使用一个 哈希环 对存储节点进行计算

把节点映射到哈希环上

> hash(节点) % 2^32

然后计算

> hash(key) % 2^32

通过顺时针找到最近的节点进行存放

这里还有问题
那就是 如果第一个映射节点的时候, 节点基本集中在一起
这个时候
我们可以使用 <mark>虚拟节点</mark> 将节点更均匀地把节点分布到哈希环上
虚拟节点的另外一个用处，是当某个机器因为扛不住崩溃了，可以防止环上的下个机器需要扛住2倍的流量

## 参考

[趣话Redis：Redis集群是如何工作的？_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1ge411L7Sh/?spm_id_from=333.788&vd_source=eabc2c22ae7849c2c4f31815da49f209)