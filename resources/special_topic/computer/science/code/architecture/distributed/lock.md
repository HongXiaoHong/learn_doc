# 分布式锁

[MySQL 也可以实现分布式锁的,乐观锁演示](https://www.bilibili.com/video/BV1Me4y1F7xW/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

通过 version 来实现我们的分布式锁

但是这种方式对于 数据库压力还是蛮大的
毕竟又要查询又要更新的
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_M5O31GNBMp.png)