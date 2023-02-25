
##命令使用
### 登录
> redis-cli -h 127.0.0.1 -p 6379

可以直接使用 redis-cli 直接连接本地的Redis 地址跟端口默认是127.0.0.1 6379

可以用 select 切换16个数据库中的一个 
auth用于验证密码
```shell
127.0.0.1:6379> select 1
OK
127.0.0.1:6379[1]> keys *
(empty list or set)
127.0.0.1:6379[1]> select 0
OK
127.0.0.1:6379> keys *
1) "\"listkey2\""
2) "book"
3) "\"listkey1\""
4) "role_list::cn.gd.cz.hong.springbootlearn.service.impl.RoleServiceImpl.findAll[]"
5) "\"role_0\""
6) "role_0"
7) "\"roles\""
8) "book-name"
9) "employee:\"com.hehui.service.EmployeeService.findAll[]\""
127.0.0.1:6379> auth ""
(error) ERR Client sent AUTH, but no password is set
```

### redis 五大类型
1. String 字符串
2. hash 哈希 映射对集合
3. list 列表
4. set 元素唯一无序集合
5. zset 元素唯一有序集合

#### 字符串
```shell
127.0.0.1:6379> set testkey hong EX 60
OK
127.0.0.1:6379> ttl testkey
(integer) 54
127.0.0.1:6379> set testkey xiao
OK
127.0.0.1:6379> ttl testkey
(integer) -1
127.0.0.1:6379> key testkey
(error) ERR unknown command 'key'
127.0.0.1:6379> keys test
(empty list or set)
127.0.0.1:6379> keys testkey
1) "testkey"
127.0.0.1:6379> get testkey
"xiao"
127.0.0.1:6379> del testkey
(integer) 1
127.0.0.1:6379> keys testkeys
(empty list or set)
```

#### 哈希
使用 hmset hget
```shell
127.0.0.1:6379> hmset favorite food "meet"
OK
127.0.0.1:6379> hget favorite
(error) ERR wrong number of arguments for 'hget' command
127.0.0.1:6379> hget favorite food
"meet"
127.0.0.1:6379> keys favorite
1) "favorite"
127.0.0.1:6379> get favorite
(error) WRONGTYPE Operation against a key holding the wrong kind of value
127.0.0.1:6379> del favorite
(integer) 1
```

#### 列表
使用lpush rpush lrange
```shell
127.0.0.1:6379> lpush mobilephones huawei #list
(integer) 2
127.0.0.1:6379> lrange mobilephones 0 2
1) "#list"
2) "huawei"
127.0.0.1:6379> rpush mobilephones iphone
(integer) 3
127.0.0.1:6379> lrange mobilephones 0 3
1) "#list"
2) "huawei"
3) "iphone"
127.0.0.1:6379> lrange mobilephones 0 2
1) "#list"
2) "huawei"
3) "iphone"
127.0.0.1:6379> lrange mobilephones 0 1
1) "#list"
2) "huawei"
127.0.0.1:6379> del mobilephones
(integer) 1
```

#### 无序集合
使用 sadd smembers
```shell
127.0.0.1:6379> sadd son ming
(integer) 1
127.0.0.1:6379> sadd son ru
(integer) 1
127.0.0.1:6379> smembers son
1) "ru"
2) "ming"
127.0.0.1:6379> del son
(integer) 1
```

#### 有序集合
使用 zadd zrange
```shell
127.0.0.1:6379> zadd book 0 java
(integer) 1
127.0.0.1:6379> zadd book 0 fish
(integer) 1
127.0.0.1:6379> zadd book 0 tea
(integer) 1
127.0.0.1:6379> zazrangebyscore book 0 1000
(error) ERR unknown command 'zazrangebyscore'
127.0.0.1:6379> zrange book 0 10
1) "fish"
2) "java"
3) "tea"
```

### 操作
```shell
C:\WINDOWS\system32>redis-cli -h 127.0.0.1 -p 6379
127.0.0.1:6379> keys *
1) "\"roles\""
2) "\"listkey2\""
3) "\"listkey1\""
4) "employee:\"com.hehui.service.EmployeeService.findAll[]\""
5) "role_list::cn.gd.cz.hong.springbootlearn.service.impl.RoleServiceImpl.findAll[]"
6) "\"role_0\""
7) "role_0"
127.0.0.1:6379> set testkey hong EX 60
OK
127.0.0.1:6379> ttl testkey
(integer) 54
127.0.0.1:6379> set testkey xiao
OK
127.0.0.1:6379> ttl testkey
(integer) -1
127.0.0.1:6379> key testkey
(error) ERR unknown command 'key'
127.0.0.1:6379> keys test
(empty list or set)
127.0.0.1:6379> keys testkey
1) "testkey"
127.0.0.1:6379> get testkey
"xiao"
127.0.0.1:6379> del testkey
(integer) 1
127.0.0.1:6379> keys testkeys
(empty list or set)
127.0.0.1:6379> hmset favorite food "meet"
OK
127.0.0.1:6379> hget favorite
(error) ERR wrong number of arguments for 'hget' command
127.0.0.1:6379> hget favorite food
"meet"
127.0.0.1:6379> keys favorite
1) "favorite"
127.0.0.1:6379> get favorite
(error) WRONGTYPE Operation against a key holding the wrong kind of value
127.0.0.1:6379> del favorite
(integer) 1
127.0.0.1:6379> lpush mobilephones huawei #list
(integer) 2
127.0.0.1:6379> lrange mobilephones 0 2
1) "#list"
2) "huawei"
127.0.0.1:6379> rpush mobilephones iphone
(integer) 3
127.0.0.1:6379> lrange mobilephones 0 3
1) "#list"
2) "huawei"
3) "iphone"
127.0.0.1:6379> lrange mobilephones 0 2
1) "#list"
2) "huawei"
3) "iphone"
127.0.0.1:6379> lrange mobilephones 0 1
1) "#list"
2) "huawei"
127.0.0.1:6379> del mobilephones
(integer) 1
127.0.0.1:6379> sadd son ming
(integer) 1
127.0.0.1:6379> sadd son ru
(integer) 1
127.0.0.1:6379> smembers son
1) "ru"
2) "ming"
127.0.0.1:6379> del son
(integer) 1
127.0.0.1:6379> zadd book 0 java
(integer) 1
127.0.0.1:6379> zadd book 0 fish
(integer) 1
127.0.0.1:6379> zadd book 0 tea
(integer) 1
127.0.0.1:6379> zazrangebyscore book 0 1000
(error) ERR unknown command 'zazrangebyscore'
127.0.0.1:6379> zrange book 0 10
1) "fish"
2) "java"
3) "tea"
```


| 类型               | 简介                                 | 特性                                                                          | 场景                                                        |
|------------------|------------------------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------|
| String(字符串)      | 二进制安全                              | 可以包含任何数据,比如jpg图片或者序列化的对象,一个键最大能存储512M                                       | ---                                                       |
| Hash(字典)         | 键值对集合,即编程语言中的Map类型                 | 适合存储对象,并且可以像数据库中update一个属性一样只修改某一项属性值(Memcached中需要取出整个字符串反序列化成对象修改完再序列化存回去) | 存储、读取、修改用户属性                                              |
| List(列表)         | 链表(双向链表)                           | 增删快,提供了操作某一段元素的API                                                          | 1,最新消息排行等功能(比如朋友圈的时间线) 2,消息队列                             |
| Set(集合)          | 哈希表实现,元素不重复                        | 1、添加、删除,查找的复杂度都是O(1) 2、为集合提供了求交集、并集、差集等操作                                   | 1、共同好友 2、利用唯一性,统计访问网站的所有独立ip 3、好友推荐时,根据tag求交集,大于某个阈值就可以推荐 |
| Sorted Set(有序集合) | 将Set中的元素增加一个权重参数score,元素按score有序排列 | 数据插入集合时,已经进行天然排序                                                            | 1、排行榜 2、带权重的消息队列                                          |


#### 参考
[Redis 教程](https://www.runoob.com/redis/redis-tutorial.html)