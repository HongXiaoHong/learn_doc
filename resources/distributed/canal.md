# canal

[canal](https://github.com/alibaba/canal)

canal 用来解决数据一致性的问题

可以将 mysql 的数据同步到 redis/kafka/rabbitmq 等其他数据源

## 原理

mysql 具有 二步提交 的特性
在 mysql 提交数据开启事务的时候, 会先记录 binlog 等日志, 然后再更改数据

MySQL master 将数据变更写入二进制日志( binary log, 其中记录叫做二进制日志事件binary log events，可以通过 show binlog events 进行查看)
MySQL slave 将 master 的 binary log events 拷贝到它的中继日志(relay log)
MySQL slave 重放 relay log 中事件，将数据变更反映它自己的数据

canal 模拟 MySQL slave 的交互协议，伪装自己为 MySQL slave ，向 MySQL master 发送dump 协议
MySQL master 收到 dump 请求，开始推送 binary log 给 slave (即 canal )
canal 解析 binary log 对象(原始为 byte 流)

## 示例

来自官网的简单示例 
https://github.com/alibaba/canal/wiki/ClientExample

上面例子的讲解:
【IT老齐132】写了份傻瓜文档，20分钟上手阿里Canal数据同步中间件