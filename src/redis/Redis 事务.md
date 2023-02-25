### redis 事务

Redis的事务只能算是批量执行 

不能算是我们理解的事务 因为就算前面执行失败
之前的语句不会被回退 还有之后的语句还会
被执行

#### 李子
```shell
127.0.0.1:6379> multi
OK
127.0.0.1:6379> set book-name "halipote"
QUEUED
127.0.0.1:6379> get book-name
QUEUED
127.0.0.1:6379> sadd book-name "bird"
QUEUED
127.0.0.1:6379> get book-name
QUEUED
127.0.0.1:6379> exec
1) OK
2) "halipote"
3) (error) WRONGTYPE Operation against a key holding the wrong kind of value
4) "halipote"
```