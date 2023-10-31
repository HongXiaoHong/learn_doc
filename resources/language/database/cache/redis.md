# redis
官网:
https://redis.com.cn/

还不错的学习资料:
[Redis思维导图分享（包含详细知识点](https://blog.csdn.net/xujunkai66/article/details/123329476)
[对应的思维导图](https://www.processon.com/view/link/6225a488637689538923e034)
## 学习大纲

1. Redis的基础知识
- Redis的简介和概念
- Redis的数据类型：String，Hash，List，Set，Sorted Set
- Redis的常用命令
2. Redis的高级应用
- Redis的发布订阅模式
- Redis的Lua脚本
- Redis的事务
3. Redis的持久化
- Redis的RDB持久化
- Redis的AOF持久化
4. Redis的集群
- Redis的主从复制
- Redis的哨兵模式
- Redis的集群模式
5. Redis的性能优化
- Redis的连接池
- Redis的数据压缩
- Redis的数据分片

## Redis的基础知识

### 数据结构

Redis是一种基于内存的数据结构存储系统，它支持多种数据类型，包括字符串（String）、哈希（Hash）、列表（List）、集合（Set）和有序集合（Sorted Set）。每种数据类型都有其自身的特点和使用场景。
常用数据结构讲解: 
[请说说Redis的常用数据结构与使用场景？](https://www.bilibili.com/video/BV1rZ4y1S7Ct/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

#### 字符串（String）

字符串是Redis最基本的数据类型，它可以存储任意类型的数据，包括数字、文本、二进制数据等。在Redis中，字符串是以二进制形式进行存储的，而且它是不可变的，也就是说，一旦字符串被设置，就无法修改。

常见应用场景：

- 缓存数据

- 计数器

- 存储序列化后的对象

#### 哈希（Hash）

哈希是一种存储键值对的数据结构，其中的键和值都是字符串类型的。哈希可以看做是一个集合，每个元素都是由一个键和一个值组成的。哈希类型在Redis中是非常实用的，因为它可以存储和读取复杂的数据结构，例如存储一个用户的信息（包括用户名、密码、邮箱等）。

常见应用场景：

- 存储对象

- 存储用户信息

- 存储配置信息

#### 列表（List）

列表是一种有序的数据结构，它可以存储一个有序的字符串列表。Redis中的列表是支持插入和删除操作的，而且它也支持从两端插入和删除数据。Redis的列表类型是一个双向链表，因此它可以用来实现队列和栈等数据结构。

常见应用场景：

- 消息队列
https://www.bilibili.com/video/BV1Y14y1H71x/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209
lpush ＋ brpop
- 日志记录

- 循环列表

>  redis 如何实现消息队列

Redis可以很容易地实现消息队列，通过使用Redis的List数据类型，我们可以把Redis当作一个轻量级的消息队列来使用。以下是Redis实现消息队列的基本流程：

1. 创建一个List数据类型作为消息队列。

`redis-cli> LPUSH my_queue message1 redis-cli> LPUSH my_queue message2 redis-cli> LPUSH my_queue message3`

2. 消费消息。

消费者从List的右端弹出消息，可以使用`RPOP`命令来获取队列中的最后一个元素。

`redis-cli> RPOP my_queue`

3. 生产消息。

生产者可以使用`LPUSH`命令向队列的左端插入消息。

`redis-cli> LPUSH my_queue message4`

4. 监听消息。

使用`BLPOP`命令可以在没有消息时将客户端阻塞，直到有消息为止。

`redis-cli> BLPOP my_queue 0`

以上是最基本的Redis消息队列的实现方式，当然在实际使用中，还可以结合Redis的发布/订阅机制或者使用Redis的Stream数据类型来实现更加复杂的消息队列，以满足不同的业务需求。另外，在生产环境中，还需要考虑消息的持久化、消息确认、消息重试等问题，以确保消息队列的可靠性。

> springboot 中如何通过redis 实现消息队列

#### 集合（Set）

集合是一种无序的数据结构，它可以存储多个不同的元素。集合的每个元素都是唯一的，因此它可以用来存储一些不重复的数据。集合类型支持集合运算，例如并集、交集、差集等操作。

常见应用场景：

- 存储唯一数据

- 排行榜

- 共同好友

#### 有序集合（Sorted Set）

有序集合是一种有序的数据结构，它类似于集合，但每个元素都会关联一个分数，分数可以用来对元素进行排序。有序集合在Redis中的实现是一个跳表（Skip List），因此它可以支持快速的插入、删除和查询操作。

常见应用场景：

- 排行榜
- 范围查询
- 去重计数

总的来说，Redis的五种数据类型各有不同的特点和使用场景，应用时需要结合具体业务场景和需求来进行选择和使用。

### Redis的常用命令

Redis是一个高性能的NoSQL数据库，支持多种数据结构和多种命令操作。以下是Redis的一些常用命令：

1. 数据类型相关操作
   
   1. String类型命令：
      
      - SET key value：设置key的值为value
      - GET key：获取key的值
      - INCR key：将key的值增加1
      - DECR key：将key的值减少1
      - APPEND key value：将value追加到key的值末尾
      2. Hash类型命令：
      - HSET key field value：设置key中的field字段值为value
      - HGET key field：获取key中field字段的值
      - HGETALL key：获取key中所有字段的值
      - HDEL key field [field ...]：删除key中指定的一个或多个字段
      3. List类型命令：
      - LPUSH key value [value ...]：将一个或多个value值插入到key列表的头部
      - RPUSH key value [value ...]：将一个或多个value值插入到key列表的尾部
      - LPOP key：删除并获取key列表的头部元素
      - RPOP key：删除并获取key列表的尾部元素
      - LRANGE key start stop：获取key列表指定范围内的元素
      4. Set类型命令：
      - SADD key member [member ...]：将一个或多个member加入到key的集合中
      - SMEMBERS key：获取key的所有成员
      - SISMEMBER key member：判断member是否在key的集合中
      - SPOP key [count]：随机地移除并返回key集合中一个或多个元素
      5. Zset类型命令：
      - ZADD key score member [score member ...]：将一个或多个member加入到key的有序集合中，指定分数score
      - ZRANGE key start stop [WITHSCORES]：获取key的有序集合指定范围内的元素，如果使用了WITHSCORES选项则同时返回分数score
      - ZRANK key member：获取key的有序集合中member元素的排名，按照分数score从小到大排列

2. Redis事务操作
   
   - `MULTI`：标记事务的开始。
   - `EXEC`：执行所有的Redis事务命令。
   - `DISCARD`：取消事务。

3. Redis的发布订阅模式
   
   - `SUBSCRIBE channel`：订阅一个或多个频道。
   - `UNSUBSCRIBE channel`：取消订阅一个或多个频道。
   - `PUBLISH channel message`：向指定频道发送一条消息。

4. Redis的其他命令
   
   - `FLUSHALL`：清空整个Redis服务器的数据。
   - `INFO`：获取Redis服务器的一些统计信息。
   - `PING`：测试Redis服务器是否正常连接。

### Redis的数据压缩

**虽然Redis的数据压缩可以减小内存占用和网络传输数据的大小，提高Redis的性能和稳定性，但也会带来一定的额外CPU开销**。因此，在启用数据压缩时需要根据具体情况进行权衡和选择

>  Redis的数据压缩默认是开启的吗

Redis的数据压缩是默认关闭的。在Redis中，启用数据压缩需要进行配置。具体来说，需要在Redis的配置文件redis.conf中添加以下配置：

```properties
# 启用数据压缩
# 开启数据压缩会对Redis的CPU资源造成一定的额外负担，需要根据具体情况进行权衡
rdbcompression yes

# 数据压缩的压缩比率，值越大表示压缩得越充分，但也会带来更大的CPU开销
rdbcompressionratio 0.5
```

其中，rdbcompression参数用于启用或禁用RDB文件的压缩，将其设置为yes即可启用数据压缩。rdbcompressionratio参数用于设置压缩比率，值越大表示压缩得越充分，但也会带来更大的CPU开销。

## Redis的内存管理

### 持久化

> 如何利用RDB和AOF更好的持久化数据

Redis提供了两种持久化方式：RDB和AOF。这两种方式都有各自的优点和适用场景。

1. RDB持久化

RDB是Redis默认的持久化方式。当开启了RDB持久化之后，Redis会周期性地将内存中的数据保存到磁盘中，形成一个RDB文件。RDB文件是一个二进制文件，包含了Redis在某一时间点上的所有数据。

RDB持久化的优点：

- RDB文件非常紧凑，可以保存大量数据；
- RDB文件可以定期备份，方便数据的迁移和备份；
- RDB文件加载速度快，适合用于数据恢复和快速启动Redis。

RDB持久化的缺点：

- RDB文件是快照方式，只能恢复最后一次快照的数据；

- RDB持久化对Redis的性能有影响，因为每次进行RDB快照时，Redis会fork出一个子进程来处理持久化操作，这会导致Redis的主进程阻塞一段时间；

- RDB持久化需要将整个数据库写入磁盘，如果数据量很大，可能会导致磁盘IO压力过大。
2. AOF持久化

AOF持久化是将Redis执行的每一条写命令记录到一个文件中，当Redis重启时，可以通过读取AOF文件来重建数据。

AOF持久化的优点：

- AOF文件是一个文本文件，易于查看和修改；
- AOF持久化可以记录每一次写命令，因此可以保证数据的完整性和持久性；
- AOF文件是增量方式写入的，因此对性能的影响较小。

AOF持久化的缺点：

- AOF文件较大，可能会占用大量磁盘空间；
- AOF文件的恢复速度较慢；
- AOF文件需要定期重写，否则会导致文件过大。

综合来看，可以使用RDB持久化来进行定期备份和快速恢复，使用AOF持久化来确保数据的完整性和持久性。可以将RDB持久化设置为每个小时备份一次，AOF持久化设置为每秒钟同步一次。这样可以保证数据的安全性和性能。

可以通过Redis的配置文件进行设置，具体步骤如下：

1. 打开Redis的配置文件，可以通过以下命令打开：

```bash
sudo vi /etc/redis/redis.conf
```

2. 找到如下配置项并修改：

```yaml
# RDB持久化设置为每小时备份一次
save 3600 1

# AOF持久化设置为每秒钟同步一次
appendonly yes
appendfsync everysec
```

`save 3600 1` 表示当1个小时内至少有1个键值对被修改，就执行一次RDB持久化操作。

`appendonly yes` 表示开启AOF持久化。

`appendfsync everysec` 表示每秒钟执行一次AOF同步操作。

3. 保存修改并重启Redis服务：

```bash
sudo systemctl restart redis.service
```

设置完成后，Redis将每个小时备份一次RDB文件，并每秒钟执行一次AOF同步操作，保证数据的安全性和可靠性

### 淘汰机制

>  redis 的内存淘汰机制

Redis是一种基于内存的数据库，数据存储在内存中，因此内存管理是Redis中非常重要的一个问题。当内存空间不足时，需要对数据进行淘汰，以释放内存空间。Redis提供了多种内存淘汰机制，包括以下几种：

1. noeviction（不淘汰）：当内存空间不足时，Redis直接返回错误信息，不进行淘汰操作。这种淘汰机制仅在特定场景下使用，例如对于需要保证数据完整性的应用。

2. allkeys-lru（LRU算法）：该淘汰机制会根据键的最近访问时间来淘汰数据。当内存空间不足时，Redis会淘汰最近最少使用的数据，即最久未被访问的数据。

3. allkeys-lfu（LFU算法）：该淘汰机制会根据键的访问频率来淘汰数据。当内存空间不足时，Redis会淘汰访问频率最低的数据。

4. volatile-lru：该淘汰机制只对过期的键进行淘汰，淘汰策略使用LRU算法。

5. volatile-lfu：该淘汰机制只对过期的键进行淘汰，淘汰策略使用LFU算法。

6. volatile-random：该淘汰机制随机淘汰过期的键。

7. volatile-ttl：该淘汰机制根据键的剩余存活时间来淘汰过期的键。

在Redis中，可以通过maxmemory和maxmemory-policy参数来设置内存限制和淘汰策略。当内存空间超出限制时，Redis就会根据设置的淘汰策略进行淘汰，释放一定量的内存空间。需要注意的是，当Redis进行内存淘汰时，可能会对应用造成一定的影响，因此需要根据具体情况进行设置和调整。

>  如何配置redis的淘汰机制

Redis的淘汰机制可以通过以下两个配置项进行配置：

1. `maxmemory-policy`：用于设置达到最大内存限制时的内存淘汰策略。可选的策略包括：
- `noeviction`：不进行淘汰，直接返回错误。

- `allkeys-lru`：在所有的键空间中使用LRU算法进行淘汰。

- `volatile-lru`：在设置过期时间的键空间中使用LRU算法进行淘汰。

- `allkeys-lfu`：在所有的键空间中使用LFU算法进行淘汰。

- `volatile-lfu`：在设置过期时间的键空间中使用LFU算法进行淘汰。

- `allkeys-random`：在所有的键空间中随机淘汰键。

- `volatile-random`：在设置过期时间的键空间中随机淘汰键。

- `volatile-ttl`：在设置过期时间的键空间中，根据键的过期时间进行淘汰。越早过期的键越先被淘汰。
2. `maxmemory`：用于设置Redis最大的可用内存，单位为字节。当Redis的内存占用超过该值时，会根据`maxmemory-policy`配置项进行内存淘汰。

以下是一个示例配置，表示最大内存为1GB，超过限制时使用LFU算法进行淘汰：

arduinoCopy code

`maxmemory 1gb maxmemory-policy volatile-lfu`

需要注意的是，配置`maxmemory`时需要考虑到Redis进程使用的内存以及操作系统本身的内存占用，以免出现内存不足的情况。同时，不同的淘汰策略适用于不同的应用场景，需要根据实际情况进行选择。

> LRU算法会最先淘汰过期的键吗

LRU算法不一定会最先淘汰过期的键，它的淘汰顺序是按照键的最近访问时间来决定的，即最近最少使用的键会被最先淘汰。因此，如果某个键虽然未过期但是已经很久没有被访问了，也有可能会被LRU算法淘汰掉。在Redis中，如果需要在键过期后立即删除该键，可以使用带有EX和NX选项的SET命令来实现，这样可以将键的过期时间和删除操作原子地执行，确保不会出现过期键未被删除的情况。

## java 客户端

- jedis

- lettuce

> 🍔 Redis客户端 jedis lettuce有什么区别, 什么场景用那种

Jedis和Lettuce是两个常用的Redis客户端，它们都可以用于在Java应用程序中连接和操作Redis。它们的主要区别如下：

1. 连接方式

Jedis使用阻塞式IO，也就是说当执行一个IO操作时，线程会一直阻塞，直到操作完成。而Lettuce则使用非阻塞式IO，它会将IO操作提交给Netty的EventLoop执行，同时不会阻塞主线程，从而提高了并发性能。

2. 线程安全性

Jedis在单个连接上是线程安全的，但在多个线程间共享同一个连接时就需要进行线程同步。而Lettuce在多个线程间共享同一个连接时是线程安全的，不需要进行额外的线程同步。

3. 可扩展性

Lettuce支持Redis Sentinel和Redis Cluster等Redis高可用方案，能够自动进行节点的发现和故障转移。而Jedis虽然也支持Redis Sentinel和Redis Cluster，但需要手动处理节点的发现和故障转移。

4. 性能表现

Lettuce在高并发场景下性能更好，因为它使用了异步、非阻塞的IO方式，能够更好地利用系统资源。而Jedis在低并发场景下性能更好，因为它使用阻塞式IO，能够更好地利用线程资源。

基于上述区别，可以考虑以下场景使用哪种Redis客户端：

1. 高并发场景下，建议使用Lettuce，能够更好地利用系统资源，提高性能。

2. 低并发场景下，建议使用Jedis，能够更好地利用线程资源，提高性能。

3. 需要使用Redis Sentinel和Redis Cluster等高可用方案时，建议使用Lettuce，能够自动进行节点的发现和故障转移。

4. 对线程安全性要求较高时，建议使用Lettuce，能够避免多线程共享连接时的线程同步问题。

## Redis的高级应用

### Redis的发布订阅模式

Redis 的发布订阅（Pub/Sub）模式是一种消息传递机制，它使得不同的客户端能够订阅一些频道，并接收发送到这些频道的消息。

在 Pub/Sub 模式中，有两个角色：发布者和订阅者。发布者将消息发送到指定的频道，而订阅者则监听这些频道，并接收发送到这些频道的消息。

具体地，订阅者通过执行 SUBSCRIBE 命令来订阅一个或多个频道，而发布者则通过执行 PUBLISH 命令来向指定的频道发送消息。当一个消息发送到一个频道时，所有订阅该频道的客户端都会收到这个消息。

Redis 的发布订阅模式是一种基于消息的解耦方式，它可以使得不同的应用组件之间通过 Redis 进行通信，而不需要直接依赖于彼此。此外，由于 Redis 的性能很高，所以 Pub/Sub 模式也可以用于实现实时消息推送、聊天室、日志收集等场景。

>   Redis 的发布订阅模式和使用数据结构中的 list 在实现消息队列方面也有很大的区别。

使用 list 来实现消息队列，通常需要先将消息插入到队列的尾部，然后再从队列的头部取出消息进行处理。这种方式是一种 FIFO（先进先出）的方式，即先进入队列的消息会先被处理。可以使用 lpush 和 rpop 命令分别在队列的头部和尾部进行插入和删除操作。

而 Redis 的发布订阅模式则不同，它是一种基于消息的解耦方式。在发布订阅模式中，发布者将消息发送到指定的频道，而订阅者则监听这些频道，并接收发送到这些频道的消息。这种方式是一种发布-订阅的方式，即发布者发送消息，订阅者接收并处理消息。可以使用 publish 和 subscribe 命令进行发布和订阅操作。

因此，使用 list 实现消息队列更加适合需要按照一定顺序处理消息的场景，而发布订阅模式则更适合需要实现广播或者解耦的场景

1. 订阅频道：

```bash
SUBSCRIBE channel_name
```

2. 发布消息：

```shell
PUBLISH channel_name message
```

其中，`channel_name`是频道名称，可以是任何字符串；`message`是要发送的消息，可以是任何类型的数据。

当某个客户端订阅了某个频道后，就可以接收到该频道上的所有消息。当有新消息发布到该频道上时，所有订阅该频道的客户端都会收到该消息。

例如，以下是一个使用Redis的发布订阅模式的示例：

```bash
# 客户端1订阅了一个名为test的频道
SUBSCRIBE test

# 客户端2向test频道发布了一条消息
PUBLISH test "hello, world!"

# 客户端1收到了来自test频道的消息
1) "message"
2) "test"
3) "hello, world!"
```

上述示例中，客户端1订阅了名为test的频道，客户端2向test频道发布了一条消息，最后客户端1收到了该消息。

### Redis的Lua脚本
[颠覆你的认知，Redis的Lua脚本，到底能不能保证原子性？？？](https://www.bilibili.com/video/BV1V84y1e76A/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

> Redis的Lua脚本入门案例 springboot 版本

1. 添加 Redis 相关依赖：

在 `pom.xml` 文件中添加 Redis 相关依赖：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-pool2</artifactId>
    <version>2.11.2</version>
</dependency>
```

2. 编写 Lua 脚本文件：
   在 src/main/resources 目录下创建 counter.lua 文件，内容与前面的示例相同。

```lua
-- 获取计数器的当前值
local counter = redis.call('get', KEYS[1])
if counter == nil then
    counter = 0
else
    counter = tonumber(counter)
end

-- 更新计数器的值
counter = counter + tonumber(ARGV[1])
redis.call('set', KEYS[1], counter)

-- 返回计数器的值
return counter
```

3. 编写 Spring Boot 应用程序：
   创建一个 Spring Boot 应用程序，并在 application.properties 文件中配置 Redis 连接信息：

```properties
spring.redis.host=localhost
spring.redis.port=6379
```

在应用程序中定义一个 RedisTemplate 和一个 RedisScript 对象：

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisConfig {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Bean
    public RedisTemplate<String, Object> redisTemplate() {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(redisConnectionFactory());
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(new StringRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(new StringRedisSerializer());
        return template;
    }

    @Bean
    public DefaultRedisScript<Long> redisScript() {
        DefaultRedisScript<Long> script = new DefaultRedisScript<>();
        script.setLocation(new ClassPathResource("counter.lua"));
        script.setResultType(Long.class);
        return script;
    }

    @Bean
    public RedisConnectionFactory redisConnectionFactory() {
        RedisStandaloneConfiguration config = new RedisStandaloneConfiguration();
        config.setHostName("localhost");
        config.setPort(6379);
        return new LettuceConnectionFactory(config);
    }

    @Bean
    public StringRedisTemplate stringRedisTemplate() {
        return new StringRedisTemplate(redisConnectionFactory());
    }
}
```

这里使用 RedisTemplate 来操作 Redis，配置了 key 和 value 的序列化方式为字符串。同时定义了一个 RedisScript 对象，用于调用 Lua 脚本。

在应用程序的某个地方使用 RedisScript 调用 Lua 脚本：

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.RedisScript;
import org.springframework.stereotype.Component;

@Component
public class CounterService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private RedisScript<Long> redisScript;

    public Long incrementCounter(String key, long delta) {
        return redisTemplate.execute(redisScript, Collections.singletonList(key), delta);
    }
}
```

这个 CounterService 类中定义了一个 `incrementCounter` 方法，用于增加计数器的值。在方法中使用 RedisTemplate 执行 RedisScript 对象，传入键名和增量参数，并返回计数器的新值。

需要注意的是，这个方法返回的是一个 Long 类型的值，表示计数器的新值。如果方法执行成功，则说明 RedisScript 调用 Lua 脚本成功。

以上就是使用 Spring Boot 和 Redis 调用 Lua 脚本的基本步骤。在实际应用中，可以根据需要编写更复杂的 Lua 脚本，并在应用程序中调用。

需要注意的是，Lua 脚本的编写和调试需要一定的技能和经验。如果不熟悉 Lua 语言或 Redis 的 Lua API，可能会遇到一些问题。建议在编写和调试 Lua 脚本时，参考 Redis 官方文档和 Lua 语言的相关资料，以及借助在线工具进行调试

### 事务

[不支持原子性的 Redis 事务也叫事务吗？-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/771674)

edis事务的成功或失败取决于事务中包含的所有命令是否成功执行。如果事务中的所有命令都成功执行，那么事务就会被视为成功，否则就会被视为失败。

在Redis事务中，事务中的所有命令都会被添加到一个命令队列中，直到EXEC命令被调用时才会执行它们。如果事务中的所有命令都成功执行，那么EXEC命令将返回一个包含每个命令执行结果的数组，其中每个命令的执行结果都是一个字符串类型的回复。如果事务中有任何命令执行失败，EXEC命令将返回一个空回复，表示整个事务执行失败。

除了EXEC命令之外，还可以使用DISCARD命令取消事务。如果在事务执行期间，出现了无法恢复的错误或异常情况，可以使用DISCARD命令取消事务，放弃所有未执行的命令。

此外，Redis还提供了WATCH命令来监视一个或多个键，如果在事务执行期间监视的键发生了变化，则事务将被取消。因此，监视事务的返回值也可以用于判断事务是否执行成功。

| 命令      | 描述                                                |
| ------- | ------------------------------------------------- |
| MULTI   | 标记一个事务块的开始                                        |
| EXEC    | 执行所有事务块内的命令                                       |
| DISCARD | 取消事务，放弃执行事务块内的所有命令                                |
| WATCH   | 监视一个（或多个）key，如果在事务执行之前这个（或多个）key被其他命令所改动，那么事务将被打断 |
| UNWATCH | 取消 WATCH 命令对所有 keys 的监视                           |

**watch指令，类似乐观锁**

[SpringBoot中使用redis事务 - 简书 (jianshu.com)](https://www.jianshu.com/p/c9f5718e58f0)

在spring中要使用Redis注解式事务，首先要设置RedisTemplate的enableTransactionSupport属性为true，然后配置一个jdbc的事务管理器。

建议
升级到springboot 2.0以上版本，如果因为项目原因无法升级看下面的建议
如果使用Redis事务的场景不多，完全可以自己管理，不需要使用spring的注解式事务。如下面这样使用：
List<Object> txResults = redisTemplate.execute(new SessionCallback<List<Object>>() {
  public List<Object> execute(RedisOperations operations) throws DataAccessException {
    operations.multi();
    operations.opsForSet().add("key", "value1");
    // This will contain the results of all ops in the transaction
    return operations.exec();
  }
});
如果一定要使用spring提供的注解式事务，建议初始化两个RedisTemplate Bean，分别设置enableTransactionSupport属性为true和false。针对需要事务和不需要事务的操作使用不同的template。
从个人角度，我不建议使用redis事务，因为redis对于事务的支持并不是关系型数据库那样满足ACID。Redis事务只能保证ACID中的隔离性和一致性，无法保证原子性和持久性。而我们使用事务最重要的一个理由就是原子性，这一点无法保证，事务的意义就去掉一大半了。所以事务的场景可以尝试通过业务代码来实现


[官方文档-Redis 事务](https://redis.com.cn/redis-transaction.html)
事务是指一个完整的动作，要么全部执行，要么什么也没有做。

Redis 事务不是严格意义上的事务，只是用于帮助用户在一个步骤中执行多个命令。单个 Redis 命令的执行是原子性的，但 Redis 没有在事务上增加任何维持原子性的机制，所以 Redis 事务的执行并不是原子性的。

Redis 事务可以理解为一个打包的批量执行脚本，但批量指令并非原子化的操作，中间某条指令的失败不会导致前面已做指令的回滚，也不会造成后续的指令不做。

Redis 事务
事务是指一个完整的动作，要么全部执行，要么什么也没有做。

Redis 事务不是严格意义上的事务，只是用于帮助用户在一个步骤中执行多个命令。单个 Redis 命令的执行是原子性的，但 Redis 没有在事务上增加任何维持原子性的机制，所以 Redis 事务的执行并不是原子性的。

Redis 事务可以理解为一个打包的批量执行脚本，但批量指令并非原子化的操作，中间某条指令的失败不会导致前面已做指令的回滚，也不会造成后续的指令不做。

Redis 事务可以一次执行多个命令， 并且带有以下三个重要的保证：

批量操作在发送 EXEC 命令前被放入队列缓存。
收到 EXEC 命令后进入事务执行，事务中任意命令执行失败，其余的命令依然被执行。
在事务执行过程，其他客户端提交的命令请求不会插入到事务执行命令序列中。
一个事务从开始到执行会经历以下三个阶段：

开始事务。
命令入队。
执行事务。
MULTI、EXEC、DISCARD、WATCH 这四个指令构成了 redis 事务处理的基础。

MULTI 用来组装一个事务；
EXEC 用来执行一个事务；
DISCARD 用来取消一个事务；
WATCH 用来监视一些 key，一旦这些 key 在事务执行之前被改变，则取消事务的执行。
在 Redis 中，通过使用MULTI命令启动事务，然后需要传递应在事务中执行的命令列表，之后整个事务由EXEC命令执行。

Redis交易1\

Redis交易2

例子
如何启动和执行 Redis 事务。

redis 127.0.0.1:6379> MULTI  
OK  
redis 127.0.0.1:6379> EXEC  
(empty list or set)  
redis 127.0.0.1:6379> MULTI  
OK  
redis 127.0.0.1:6379> SET rediscomcn redis  
QUEUED  
redis 127.0.0.1:6379> GET rediscomcn  
QUEUED  
redis 127.0.0.1:6379> INCR visitors  
QUEUED  
redis 127.0.0.1:6379> EXEC  
1) OK  
2) "redis"  
3) (integer) 1  
在上面的例子中，我们看到了 QUEUED 的字样，这表示我们在用 MULTI 组装事务时，每一个命令都会进入到内存队列中缓存起来，如果出现 QUEUED 则表示我们这个命令成功插入了缓存队列，在将来执行 EXEC 时，这些被 QUEUED 的命令都会被组装成一个事务来执行。

对于事务的执行来说，如果 redis 开启了 AOF 持久化的话，那么一旦事务被成功执行，事务中的命令就会通过 write 命令一次性写到磁盘中去，如果在向磁盘中写的过程中恰好出现断电、硬件故障等问题，那么就可能出现只有部分命令进行了 AOF 持久化，这时 AOF 文件就会出现不完整的情况，这时，我们可以使用 redis-check-aof 工具来修复这一问题，这个工具会将 AOF 文件中不完整的信息移除，确保 AOF 文件完整可用。

Redis 事务错误
有关事务，大家经常会遇到的是两类错误：

调用 EXEC 之前的错误
调用 EXEC 之后的错误
调用 EXEC 之前的错误，有可能是由于语法有误导致的，也可能时由于内存不足导致的。只要出现某个命令无法成功写入缓冲队列的情况，redis 都会进行记录，在客户端调用 EXEC 时，redis 会拒绝执行这一事务。（这是 2.6.5 版本之后的策略。在 2.6.5 之前的版本中，redis 会忽略那些入队失败的命令，只执行那些入队成功的命令）。我们来看一个这样的例子：

127.0.0.1:6379> multi
OK
127.0.0.1:6379> haha //一个明显错误的指令
(error) ERR unknown command 'haha'
127.0.0.1:6379> ping
QUEUED
127.0.0.1:6379> exec
//redis无情的拒绝了事务的执行，原因是“之前出现了错误”
(error) EXECABORT Transaction discarded because of previous errors.
而对于调用 EXEC 之后的错误，redis 则采取了完全不同的策略，即 redis 不会理睬这些错误，而是继续向下执行事务中的其他命令。这是因为，对于应用层面的错误，并不是 redis 自身需要考虑和处理的问题，所以一个事务中如果某一条命令执行失败，并不会影响接下来的其他命令的执行。我们也来看一个例子：

127.0.0.1:6379> multi
OK
127.0.0.1:6379> set age 23
QUEUED
//age不是集合，所以如下是一条明显错误的指令
127.0.0.1:6379> sadd age 15 
QUEUED
127.0.0.1:6379> set age 29
QUEUED
127.0.0.1:6379> exec //执行事务时，redis不会理睬第2条指令执行错误
1) OK
2) (error) WRONGTYPE Operation against a key holding the wrong kind of value
3) OK
127.0.0.1:6379> get age
"29" //可以看出第3条指令被成功执行了
最后，我们来说说最后一个指令WATCH，这是一个很好用的指令，它可以帮我们实现类似于“乐观锁”的效果，即CAS（check and set）。

WATCH 本身的作用是监视 key 是否被改动过，而且支持同时监视多个 key，只要还没真正触发事务，WATCH 都会尽职尽责的监视，一旦发现某个 key 被修改了，在执行 EXEC 时就会返回 nil，表示事务无法触发。

127.0.0.1:6379> set age 23
OK
127.0.0.1:6379> watch age //开始监视age
OK
127.0.0.1:6379> set age 24 //在EXEC之前，age的值被修改了
OK
127.0.0.1:6379> multi
OK
127.0.0.1:6379> set age 25
QUEUED
127.0.0.1:6379> get age
QUEUED
127.0.0.1:6379> exec //触发EXEC
(nil) //事务无法被执行
### 集群

#### 主从复制 | 集群

Redis主从复制是一种Redis数据库的高可用性解决方案，它可以实现在多个Redis服务器之间同步数据，从而使得整个系统更加稳定和可靠。Redis主从复制的原理比较简单，主要分为以下几个步骤：

1. 建立主从关系

在Redis主从复制中，需要首先建立主从关系。当从服务器启动时，它会连接到主服务器，并发送SYNC命令请求主服务器发送完整的数据集。主服务器接收到SYNC命令后，会开启后台进程，将自己的数据集发送给从服务器。

2. 数据同步

在主服务器发送完整的数据集之后，从服务器会执行一遍完整的数据集，将自己的数据集更新到与主服务器一致的状态。这个过程中，主服务器会将自己的命令发送给从服务器，从服务器也会将自己的命令发送给主服务器，以保证双方数据的一致性。

3. 增量同步

在主从关系建立之后，主服务器会将自己的写命令发送给从服务器，从服务器也会将自己的写命令发送给主服务器。这个过程中，主从服务器之间的数据同步是增量的。主服务器将写命令发送给从服务器的过程中，从服务器可以选择接收或者拒绝命令，从而实现数据的同步。

4. 自动故障转移

在Redis主从复制中，如果主服务器出现故障，从服务器可以自动接管主服务器的工作。在这种情况下，Redis会自动选举一个从服务器作为新的主服务器，其他从服务器会自动将自己的主从关系切换到新的主服务器上，从而实现系统的高可用性。

总的来说，Redis主从复制是一种简单而有效的数据同步方式，它可以提高系统的可靠性和稳定性，并且可以在主服务器出现故障时实现自动故障转移。

##### 主从复制原理

Redis主从复制是指将一台Redis服务器的数据复制到其他Redis服务器上的过程。主Redis服务器作为数据源，从Redis服务器作为数据备份和扩展。主从复制有助于提高Redis的可扩展性和可用性，同时还可以用于读写分离和数据备份。

Redis主从复制的原理如下：

1. Slave连接Master：从服务器向主服务器发送SYNC命令，请求复制主服务器的数据。

2. Master执行BGSAVE：当Master接收到Slave的SYNC命令后，会执行BGSAVE命令，在后台生成一个RDB快照文件。

3. Master将快照文件发送给Slave：BGSAVE命令生成RDB快照文件后，Master会将该文件发送给Slave。

4. Master将命令缓存发送给Slave：Master会将在生成快照文件期间接收到的所有命令缓存起来，发送给Slave，Slave会执行这些命令，保证复制数据的完整性。

5. Slave完成初始化：Slave完成初始化后，会向Master发送一个SYNC命令，Master会将从上次复制之后的所有命令发送给Slave。

6. Slave开始同步数据：Master接收到Slave发送的SYNC命令后，会将从上次复制之后的所有命令发送给Slave，Slave会执行这些命令，以保证数据的一致性。

7. 数据同步完成：当Slave执行完Master发送过来的所有命令后，就完成了数据同步。

在主从复制的过程中，Redis会记录Master执行的所有写命令，Slave会在初始化完成后执行这些写命令，以保证数据的一致性。

需要注意的是，主从复制是异步的，即从服务器的数据不是实时更新的，而是有一定的延迟。因此，主从复制适用于读多写少的场景，对于写入频繁的场景需要采用其他方案，如集群或哨兵模式

#### Redis Sentinel | 哨兵模式

##### 基本使用

Redis Sentinel 的部署需要在 Redis 主从复制的基础上进行配置。下面是 Redis Sentinel 部署的基本步骤：

1. 安装 Redis
   首先需要在服务器上安装 Redis，可以使用包管理器或手动安装的方式进行。

2. 配置 Redis 主从复制
   在 Redis 主从复制中，一个 Redis 服务器（主服务器）将数据同步到另一个或多个 Redis 服务器（从服务器）。在配置主从复制时，需要设置主服务器的 IP 和端口号，并将从服务器配置为复制主服务器。这样从服务器会自动将主服务器的数据同步到自己本地。

3. 配置 Redis Sentinel
   为了实现 Redis 的高可用性，需要配置 Redis Sentinel。需要在 Sentinel 的配置文件中指定主服务器的 IP 和端口号，以及至少 3 个 Sentinel 的 IP 和端口号。这样 Sentinel 之间可以互相监控，同时监测主服务器和从服务器的状态，确保 Redis 服务的可用性。

4. 启动 Redis Sentinel
   在配置好 Redis Sentinel 后，需要启动 Sentinel 进程，让其开始监测 Redis 服务器的状态。可以使用以下命令启动 Sentinel：

`redis-sentinel /path/to/sentinel.conf`

5. 测试 Redis Sentinel
   启动 Sentinel 后，可以使用 Redis 的命令行工具 redis-cli 来测试 Redis Sentinel 是否正常工作。可以使用以下命令检查 Sentinel 是否发现了主服务器和从服务器：

`SENTINEL MASTERS // 查看主服务器信息 SENTINEL SLAVES <master-name> // 查看从服务器信息`

在实际部署中，需要根据实际情况进行调整。例如，可以在多台服务器上部署多个 Sentinel，以提高可用性和容错性；也可以使用 Redis Cluster 来代替 Redis Sentinel 实现高可用性。

#### redis cluster | redis 集群

[【IT老齐028】大厂必备技能，白话Redis Cluster集群模式_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1F44y1C7N8/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

Redis Cluster是Redis官方提供的分布式方案，它将数据分散到多个节点上，每个节点可以存储多个槽位（slot），每个槽位可以存储一个key-value对。Redis Cluster会自动将数据分散到各个节点上，并且能够自动检测节点的故障，进行数据迁移和重新分配，从而实现了数据的高可用性和负载均衡。

节点间通过 gossip 进行交互, 16384刚好是16k , 压缩过后就是2k

Redis Cluster的实现原理如下：

1. 槽位分配：Redis Cluster将所有的槽位分为16384个，每个节点负责一部分槽位。当有新节点加入集群时，Redis Cluster会将一部分槽位从现有节点中迁移到新节点中。

2. 节点间通信：Redis Cluster中的节点通过Gossip协议进行通信，每个节点定期向其他节点发送信息，更新集群状态和节点信息。当一个节点发现其他节点不可用时，它会将不可用节点标记为FAIL，并将其槽位重新分配给其他可用节点。

3. 客户端请求路由：当一个客户端需要读写一个key时，它会首先根据key计算出对应的槽位，然后向负责该槽位的节点发送请求。如果负责该槽位的节点不可用，客户端会自动将请求路由到其他可用节点。

##### 好奇

> 在 redis cluster 集群的情况下, 使用有序集合进行范围查询, 刚好范围落在两个主节点或者多个节点上, 这个时候可以查询出来吗

在 Redis Cluster 集群中使用有序集合进行范围查询，如果查询的范围恰好跨越了多个节点，那么 Redis 会自动将查询请求发送到包含有相关数据的节点上进行查询，然后将查询结果合并后返回给客户端。

在有序集合的范围查询中，如果需要查询的范围跨越多个节点，Redis 会将查询请求发送到每个包含有相关数据的节点上，然后将查询结果合并后返回给客户端。如果范围查询涉及到的节点较多，可能会对 Redis 集群的性能造成一定的影响，因此需要注意合理使用范围查询和进行集群分片，以确保查询性能和集群的可扩展性。

## 布隆过滤器

解决缓存穿透

https://www.bilibili.com/video/BV1zK4y1h7pA/?vd_source=eabc2c22ae7849c2c4f31815da49f209

redis只能缓存一部分数据，数据不在redis有可能在数据库，布隆过滤器保存了全部的数据，数据不在布隆过滤器就大概率不在数据库。这样当有大量不在数据库里的查询时就不用再查数据库了，没有布隆过滤器的话就是先查redis再查数据库，但是这些数据都不在数据库里，所以每次都要查数据库，这种情况相当于缓存失效了，所以叫缓存穿透

## 数据分片和负载均衡

Redis的数据分片和负载均衡实现方案有哪些

1. 客户端分片方案

这种方案是基于客户端的数据分片，每个Redis实例只存储部分数据。客户端需要负责计算数据所属的分片，将数据发送到对应的Redis实例。客户端可以使用一致性哈希算法等方式计算分片，并根据分片情况向不同的Redis实例发送请求。这种方案的优点是简单易用，可以方便地实现水平扩展，但缺点是需要客户端负责维护数据的分片和路由，增加了客户端的复杂度。

2. Redis Sentinel

Redis Sentinel是Redis官方提供的高可用性方案，它可以监控Redis实例的状态，并在发生故障时自动切换到备用实例。Redis Sentinel可以通过将多个Redis实例组成一个主从集群，从而实现负载均衡。客户端只需要连接到Sentinel，并指定要连接的Redis实例的名称，Sentinel会自动将请求路由到可用的实例。Redis Sentinel是一个轻量级的方案，可以快速部署和维护，但是它不支持数据分片，因此不适用于大规模的数据存储。

3. Redis Cluster

Redis Cluster是Redis官方提供的分布式方案，它将数据分散到多个节点上，每个节点可以存储多个槽位（slot），每个槽位可以存储一个key-value对。Redis Cluster会自动将数据分散到各个节点上，并且能够自动检测节点的故障，进行数据迁移和重新分配，从而实现了数据的高可用性和负载均衡。Redis Cluster的优点是数据分散到多个节点上，实现了横向扩展，可以支持大规模的数据存储。但是，Redis Cluster需要至少三个节点才能工作，而且需要客户端支持Cluster协议才能访问。**

## 号外

### mysql与redis

>  如何分批次存储将一个千万级的mysql表数据加载到redis中

将一个千万级的MySQL表数据加载到Redis中，可以采用以下的分批次存储策略：

1. 根据主键或者其他唯一标识字段进行分页查询，每次查询一定数量的数据，比如每次查询1000条。

2. 将每一批次查询到的数据转化为Redis数据结构，然后通过Redis客户端将数据批量写入Redis中。

下面是一个简单的Java代码示例：

```kotlin
// 1. 分批次查询MySQL数据
int pageSize = 1000;
int pageNum = 1;
List<Data> dataList = new ArrayList<>();
while (true) {
    List<Data> pageData = getDataFromMysql(pageSize, pageNum);
    if (pageData == null || pageData.isEmpty()) {
        break;
    }
    dataList.addAll(pageData);
    pageNum++;
}

// 2. 将数据写入Redis
Jedis jedis = new Jedis("localhost");
for (Data data : dataList) {
    // 根据具体需求选择合适的Redis数据结构
    jedis.hset("data:" + data.getId(), "name", data.getName());
    jedis.hset("data:" + data.getId(), "value", data.getValue());
}
```

在实际应用中，还需要考虑以下几个问题：

1. 内存占用：批量加载大量数据到Redis中，可能会占用大量的内存资源。可以采用增量式加载，或者使用Redis Cluster等方式来减少内存占用。

2. 数据同步：在MySQL表中的数据发生变化时，需要及时同步到Redis中。可以采用定时同步或者异步同步的方式来实现。

3. 数据查询：在Redis中查询数据时，需要考虑Redis数据结构的特点和查询方式，以保证查询效率和性能。可以结合具体场景选择合适的查询策略。

> 如何在MySQL表中的数据发生变化时，及时同步到Redis中

实时同步MySQL表中的数据到Redis中，可以采用以下几种方式：

1. 数据库触发器：可以在MySQL表上创建触发器，在数据发生变化时自动将数据同步到Redis中。触发器可以监控数据的插入、更新、删除等操作，并通过Redis客户端将数据同步到Redis中。需要注意的是，使用触发器可能会对数据库性能产生一定的影响。

2. 数据同步工具：可以使用一些数据同步工具，如Canal、Maxwell等，监控MySQL表的变化，并将变化的数据实时同步到Redis中。这些工具可以配置过滤条件，只同步指定的表、字段或者数据行，以减少不必要的数据传输和存储。

3. 定时同步：可以定时从MySQL中读取数据，并将数据同步到Redis中。定时同步可以使用定时任务或者定时脚本来实现。需要注意的是，定时同步可能会存在数据不一致的问题，例如在同步过程中MySQL表发生了变化，但是还未同步到Redis中。

在实际应用中，可以根据业务需求和数据同步的实时性要求，选择合适的同步方式。同时，为了确保数据一致性，可以采用数据缓存和异步写入等技术来保证数据的完整性和准确性。

如果是异步的情况下 我们可以在改动数据的时候, 将改动发送到 mq 中, 通过异步增加系统的响应速度

### redis 为什么这么快

- 基于内存进行查询

- 使用优化过后的数据结构, 包括跳表等

- 使用 reactor 模式, 实现异步IO

#### Reactor 模式是什么, redis是如何利用Reactor 模式提高访问速度的

Reactor模式是一种基于事件驱动的设计模式，它将事件的处理过程分为两个阶段：事件的分发和事件的处理。当一个事件发生时，Reactor模式将该事件分发给相应的处理器进行处理。而处理器则是通过回调函数或者Future对象等方式来处理事件的。

在Redis中，Reactor模式被广泛地应用于网络通信模块中，通过使用NIO技术，使得Redis能够支持高并发的网络通信。具体地，Redis使用Netty作为其底层的网络通信框架，Netty底层则是基于Reactor模式实现的。

Redis在使用Reactor模式时，主要采用了以下的优化策略：

1. 异步IO：通过使用异步IO的方式，Redis能够将IO操作提交给操作系统异步执行，从而避免了线程的阻塞等待，提高了并发性能。

2. Reactor线程池：在Redis中，Reactor模式所使用的线程池主要是为了提高事件分发的效率。当一个事件发生时，它将被分发到Reactor线程池中的某个线程进行处理，这些线程的数量可以根据系统负载情况进行动态调整。

3. Pipeline技术：Redis使用Pipeline技术可以将多个命令打包在一起进行批量处理，从而减少了IO操作的次数，提高了Redis的处理效率。

4. 数据结构的优化：Redis的数据结构采用了一些高效的算法和数据结构，例如跳表、哈希表等，这些数据结构能够提高Redis的数据查询和存储效率。

综上所述，Redis利用Reactor模式可以提高访问速度的原因主要是通过异步IO、Reactor线程池、Pipeline技术以及数据结构的优化等方式来提高Redis的处理效率和并发性能，从而减少了用户请求的响应时间，提高了Redis的访问速度。

### Redis的连接池在springboot如何应用

在Spring Boot应用程序中使用Redis连接池，通常需要使用Spring Data Redis这个库来进行操作。Spring Data Redis提供了一个RedisTemplate类，它是一个用于执行Redis操作的通用模板类。要使用连接池，只需要配置RedisTemplate中的连接工厂即可。

以下是在Spring Boot中配置Redis连接池的步骤：

1. 在pom.xml中添加Spring Data Redis依赖。

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

2. 在application.properties或application.yml中添加Redis连接池相关配置信息。

```properties
spring.redis.host=127.0.0.1
spring.redis.port=6379
spring.redis.password= #如果有密码需要填写
spring.redis.database=0

# 配置连接池
spring.redis.jedis.pool.max-active=8
spring.redis.jedis.pool.max-wait=5000ms
spring.redis.jedis.pool.max-idle=8
spring.redis.jedis.pool.min-idle=0
```

3. 在Spring Boot配置类中创建RedisTemplate对象并设置连接工厂。

```java
@Configuration
public class RedisConfig {

    @Value("${spring.redis.host}")
    private String redisHost;

    @Value("${spring.redis.port}")
    private int redisPort;

    @Value("${spring.redis.password}")
    private String redisPassword;

    @Value("${spring.redis.database}")
    private int redisDatabase;

    @Value("${spring.redis.jedis.pool.max-active}")
    private int maxActive;

    @Value("${spring.redis.jedis.pool.max-wait}")
    private long maxWait;

    @Value("${spring.redis.jedis.pool.max-idle}")
    private int maxIdle;

    @Value("${spring.redis.jedis.pool.min-idle}")
    private int minIdle;

    @Bean
    public JedisConnectionFactory jedisConnectionFactory() {
        JedisConnectionFactory jedisConnectionFactory = new JedisConnectionFactory();
        jedisConnectionFactory.setHostName(redisHost);
        jedisConnectionFactory.setPort(redisPort);
        jedisConnectionFactory.setPassword(redisPassword);
        jedisConnectionFactory.setDatabase(redisDatabase);
        jedisConnectionFactory.setPoolConfig(jedisPoolConfig());
        return jedisConnectionFactory;
    }

    @Bean
    public JedisPoolConfig jedisPoolConfig() {
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxTotal(maxActive);
        jedisPoolConfig.setMaxIdle(maxIdle);
        jedisPoolConfig.setMinIdle(minIdle);
        jedisPoolConfig.setMaxWaitMillis(maxWait);
        return jedisPoolConfig;
    }

    @Bean
    public RedisTemplate<String, Object> redisTemplate() {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(jedisConnectionFactory());
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setValueSerializer(new GenericJackson2JsonRedisSerializer());
        return redisTemplate;
    }
}
```

在上面的代码中，我们创建了一个JedisConnectionFactory对象，这个对象使用了配置文件中的Redis连接信息和连接池配置信息。然后，我们将这个对象设置到了RedisTemplate中，并为RedisTemplate设置了Key和Value的序列化方式。

最后，在使用RedisTemplate时，只需要将它注入到需要使用Redis的类中即可。

以上就是在Spring Boot中使用Redis连接池的基本步骤，可以根据具体的需要使用Redis的功能来使用RedisTemplate执行Redis操作。

例如，假设我们需要在Spring Boot应用程序中使用Redis来缓存一些数据，可以创建一个缓存管理类，如下所示：

```java
@Service
public class RedisCacheManager {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    public void put(String key, Object value) {
        redisTemplate.opsForValue().set(key, value);
    }

    public Object get(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    public void remove(String key) {
        redisTemplate.delete(key);
    }
}
```

在上面的代码中，我们使用@Autowired注解将RedisTemplate注入到RedisCacheManager类中，然后使用opsForValue()方法获取Value操作对象，从而执行Redis操作。在put()方法中，我们将key和value存储到Redis中；在get()方法中，我们从Redis中获取指定key的value；在remove()方法中，我们从Redis中删除指定key的数据。

需要注意的是，RedisTemplate支持多种Redis数据类型的操作，包括字符串、哈希、列表、集合、有序集合等，可以根据具体需求选择相应的操作对象执行Redis操作。

除了RedisTemplate，还有一些其他的Redis客户端库也可以用于在Spring Boot中使用Redis连接池，例如Lettuce。在使用这些库时，需要根据具体的文档进行配置和使用。

### 键值 序列化需要注意什么问题

在使用Redis时，需要将数据存储到Redis中，这就涉及到了键值序列化。键值序列化是将Java对象序列化为二进制格式或字符串格式，以便在Redis中存储。在进行键值序列化时，需要注意以下几个问题：

1. 序列化方式

Java对象可以使用多种序列化方式进行序列化，例如Java自带的序列化方式、JSON序列化、XML序列化等。不同的序列化方式具有不同的性能和存储空间占用情况，需要根据实际情况选择合适的序列化方式。在Spring Boot中，常用的序列化方式有Jackson、FastJson、Gson等。

2. 序列化格式

序列化方式可以生成多种不同的序列化格式，例如JSON格式、XML格式、二进制格式等。不同的序列化格式具有不同的特点，需要根据实际需求选择合适的序列化格式。在Spring Boot中，常用的序列化格式有JSON格式、XML格式、二进制格式等。

3. 序列化兼容性

在使用键值序列化时，需要注意不同版本的序列化库之间的兼容性问题。如果不同版本的序列化库生成的序列化格式不兼容，那么在读取数据时可能会出现反序列化失败的情况。为了避免这种情况，需要尽可能使用稳定的序列化库和序列化格式，同时进行版本控制，以确保不同版本之间的兼容性。

4. 序列化性能

键值序列化的性能对于Redis的读写效率有很大的影响。如果序列化方式和格式选择不当，会导致序列化性能较低，从而影响Redis的读写性能。为了提高序列化性能，可以选择高性能的序列化库和格式，同时进行合适的配置和优化。

总之，键值序列化在使用Redis时非常重要，需要仔细考虑序列化方式、序列化格式、序列化兼容性和序列化性能等方面的问题，以确保Redis的正常运行和高效使用。

>  键值 序列化有哪些方案

在Redis中，可以使用多种序列化方案对键值进行序列化，常见的序列化方案有以下几种：

1. String序列化：

String序列化是Redis默认的序列化方式，它将键值序列化为二进制字符串。String序列化方案简单、快速，但只适用于键值是简单字符串的情况。

2. JSON序列化：

JSON序列化是将键值序列化为JSON格式的字符串，这种方案适用于键值包含复杂的数据结构，如Map、List等。JSON序列化方案具有良好的可读性和可扩展性，但序列化和反序列化的性能较差。

3. Jackson序列化：

Jackson序列化是将键值序列化为JSON格式的二进制数据，这种方案适用于需要高效传输数据的情况。Jackson序列化方案采用基于字节的数据压缩方式，可以提高序列化和反序列化的性能。

4. **Protobuf序列化**：

Protobuf是一种高效的二进制数据序列化方案，它将键值序列化为二进制数据。

> 在springboot 项目中 键值 序列化有什么方案

在Spring Boot项目中，可以使用多种序列化方案对键值进行序列化，常见的序列化方案有以下几种：

1. Jackson序列化：

Spring Boot默认使用Jackson序列化方案对Java对象进行序列化和反序列化。可以使用`@JsonSerialize`和`@JsonDeserialize`注解来指定序列化和反序列化的方式。

2. Gson序列化：

Gson是Google提供的一种轻量级的Java序列化库，它可以将Java对象序列化为JSON格式的字符串，并可以反序列化为Java对象。在Spring Boot项目中，可以通过在`application.properties`文件中添加配置来启用Gson序列化。

3. FastJson序列化：

FastJson是阿里巴巴提供的一种高性能的Java序列化库，它可以将Java对象序列化为JSON格式的字符串，并可以反序列化为Java对象。在Spring Boot项目中，可以通过在`application.properties`文件中添加配置来启用FastJson序列化。

4. Protobuf序列化：

Protobuf是一种高效的二进制数据序列化方案，它将键值序列化为二进制数据。在Spring Boot项目中，可以使用Google提供的Protobuf插件来生成Java对象，并通过在`application.properties`文件中添加配置来启用Protobuf序列化。

需要注意的是，选择序列化方案应该根据实际的业务场景和性能需求进行选择。如果需要高性能的序列化和反序列化，可以选择Protobuf或FastJson；如果需要良好的可读性和可扩展性，可以选择JSON序列化方案。

> 在springboot 项目中 为什么需要在创建RedisTemplate, 自定义键值 序列化方案

在Spring Boot项目中，RedisTemplate是用来操作Redis数据库的核心组件，它可以实现对Redis的各种操作，如插入、查询、更新和删除等。而自定义键值序列化方案，则是为了解决默认的Redis序列化方案不够灵活、性能不佳的问题，可以更好地适应业务需求。

具体来说，Spring Boot默认使用JdkSerializationRedisSerializer序列化方案，这种方案虽然使用方便，但它的序列化效率比较低，序列化后的数据也不够紧凑，会占用更多的内存空间。而使用自定义的序列化方案，则可以根据具体业务场景和性能需求，选择更加高效、紧凑的序列化方案。

例如，使用JSON序列化方案可以将Java对象序列化为紧凑的JSON字符串，这样可以减少序列化后的数据占用的存储空间。而使用Protobuf序列化方案则可以更加高效地序列化和反序列化数据，提高Redis操作的性能。

因此，在创建RedisTemplate时，自定义键值序列化方案可以帮助我们更好地适应业务需求，提高Redis操作的性能和效率。可以通过实现RedisSerializer接口来自定义键值序列化方案，并将其设置到RedisTemplate中。例如，通过实现JsonRedisSerializer或者ProtobufRedisSerializer来实现自定义的序列化方案。