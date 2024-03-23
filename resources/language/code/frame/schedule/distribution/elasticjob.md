## 定时任务
### 分布式
####  [elasticjob](https://shardingsphere.apache.org/elasticjob/current/cn/overview/)

[使用 springboot 进行搭建](https://shardingsphere.apache.org/elasticjob/current/cn/user-manual/usage/job-api/spring-boot-starter/)



### zookeeper 入门

[ZooKeeper: Because Coordinating Distributed Systems is a Zoo --- ZooKeeper：因为协调分布式系统是一个动物园 (apache.org)](https://zookeeper.apache.org/doc/current/zookeeperStarted.html)



##### 高级
###### [动态任务](https://cloud.tencent.com/developer/news/697962)
https://cloud.tencent.com/developer/news/697962
> 最近公司的项目需要用到分布式任务调度，在结合多款开源框架后决定使用当当的Elastic-job。不知道大家有没有这样的需求，就是动态任务。之前比较了xxl-job和elastic-job发现，都只是支持注解或者配置以及后台添加现有的任务，不支持动态添加。比如：类似订单半小时后自动取消的场景。

> xxl-job理论上来说是可以支持的，但是需要高度整合admin端的程序，然后开放对应的接口才可以给其他服务调用，这样本质直接改源码对后期的升级十分不便，最后放弃了xxl-job。elastic-job在移交Apache后的版本规划中，有提到API的开放，但是目前还没有稳定版，所以只能使用之前的2.1.5的版本来做。在Github搜了很多整合方案，最后决定选择下面的来实现。