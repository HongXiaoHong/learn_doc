
##命令使用
### 登录
> redis-cli -h 127.0.0.1 -p 6379

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