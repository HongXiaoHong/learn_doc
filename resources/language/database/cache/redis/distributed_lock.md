# redis 的分布式锁

## setnx 超时实现简单的 分布式锁

[【精选】redis分布式锁(一）set NX实现_心心念念的小鼠标的博客-CSDN博客](https://blog.csdn.net/huo065000/article/details/119970629)

或者直接使用 setnx 加上 ex 也行

```bash
#给lock设置了过期时间为60000毫秒(也可以用ex 6000,单位就变成了秒)，当用NX再次赋值，则返回nil,不能重入操作
127.0.0.1:6379> set lock true NX px 60000
OK
127.0.0.1:6379> set lock true NX px 6000
(nil)
127.0.0.1:6379> get lock
"true"
127.0.0.1:6379> ttl lock
(integer) 43
#时间过期后再次get,返回nil,表明key 为 lock的锁已经释放
127.0.0.1:6379> get lock
(nil)

```

但是仅仅加上超时还是有点问题



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_nn6V8Q3FvR.png)

可能会因为业务时间过长, 导致自己的锁被释放了, 

这个时间应该在代码中判断是否是最初设置到 redis 中的值, 则不进行删除

这里存在的问题是, 不能很好的根据业务的时间对锁进行延时,

当然我们可以通过 lua 脚本编写一个监听的任务, 看是否需要进行延时

## redssion 单节点 分布式可重入锁实现

[分布式锁之Redis实现 - 简书 (jianshu.com)](https://www.jianshu.com/p/47fd7f86c848)

## redssion 多节点 分布式可重入锁实现

## 为什么需要使用 RedLock

> 为什么需要 redis 分布式锁使用 RedLock, 原来的使用 SetNX 实现分布式锁有什么问题

在 Redis 中，使用 SETNX 命令可以实现基本的分布式锁，但是它存在以下问题：

1. SETNX 命令只能实现单节点的分布式锁，无法支持分布式部署的 Redis 集群。

2. SETNX 命令在锁释放时存在问题，例如锁的过期时间设置过短，可能会导致**锁被误释放**，多个客户端同时获取锁的情况也存在竞争问题。

3. SETNX 命令在锁释放时没有考虑当前持有锁的客户端与其他客户端的**时钟不一致问题**，这可能会导致锁被错误地释放或者无法被释放的情况。

为了解决上述问题，需要使用分布式锁的 RedLock 实现，它采用了多个 Redis 节点之间的协作来实现锁的分布式控制，更加可靠和健壮。

假设某个客户端获得锁后，在锁的有效期内，由于一些原因，其时钟与其他客户端的时钟不同步，或者与 Redis 服务器的时钟不同步。这时如果使用 SETNX 命令来尝试释放锁，就可能会出现以下两种情况：

1. 如果客户端的时钟比 Redis 服务器的时钟快，则客户端在尝试释放锁时，可能会误认为锁已经过期，从而错误地释放锁，导致其他客户端可以获得锁，从而可能会出现数据不一致等问题。

2. 如果客户端的时钟比 Redis 服务器的时钟慢，则客户端在尝试释放锁时，可能会因为认为锁还没有到期而不释放锁，从而导致其他客户端一直无法获得锁，从而可能会出现锁的“延迟释放”等问题。

### 锁被误释放

假设客户端 A 和客户端 B 都需要获取 Redis 中的同一个锁，并且客户端 A 的时钟比 Redis 服务器的时钟快 10 秒钟，而客户端 B 的时钟与 Redis 服务器的时钟保持一致。

1. 客户端 A 获取锁

客户端 A 使用 SETNX 命令获取了锁，并设置了过期时间为 30 秒。

2. 客户端 B 获取锁

由于客户端 B 的时钟与 Redis 服务器的时钟保持一致，因此客户端 B 获取锁时，发现锁已经被客户端 A 获取了，于是等待锁释放。

3. 客户端 A 释放锁

当锁的过期时间到达时，客户端 A 会尝试释放锁。由于客户端 A 的时钟比 Redis 服务器的时钟快 10 秒钟，客户端 A 会认为锁已经过期，从而错误地释放了锁。

4. 客户端 B 获取锁成功

由于客户端 A 错误地释放了锁，因此客户端 B 成功地获取了锁，并开始执行相应的业务逻辑。

这个例子说明了如果客户端的时钟比 Redis 服务器的时钟快，则可能会误释放锁，导致其他客户端可以获得锁，从而可能会出现数据不一致等问题。

### 时钟不一致问题

在使用 SETNX 实现 Redis 分布式锁时，确实可能因为客户端时钟与 Redis 服务器时钟不一致导致死锁等问题。死锁的原因主要是因为客户端在判断锁是否过期时，依赖于自己的时钟。如果客户端的时钟比 Redis 服务器的时钟慢，可能会出现客户端错误地认为锁未过期的情况。

以下是一个例子来说明这种情况：

1. 客户端 A 获得锁，设置锁的过期时间为 30 秒。
2. 客户端 A 的时钟比 Redis 服务器的时钟慢 10 秒。
3. 在锁过期之前的 20 秒时，客户端 A 完成任务，并尝试释放锁。
4. 由于客户端 A 的时钟慢，此时它认为锁还有 10 秒才过期，因此它不会释放锁。
5. 同时，客户端 B 试图获得锁，但由于客户端 A 尚未释放锁，客户端 B 无法获得锁。
6. 客户端 A 最终在自己的时钟上等待了 30 秒后释放锁，但此时已经过了 40 秒（Redis 服务器的时钟），导致客户端 B 等待了很长时间。

在这个例子中，我们可以看到，客户端 A 的时钟比 Redis 服务器慢，导致锁的释放时间被延迟。这可能会导致其他客户端（如客户端 B）长时间等待锁，从而影响整个系统的性能。

为了避免这种情况，可以考虑使用 Redlock 算法。Redlock 算法是 Redis 官方推荐的一种分布式锁实现，它可以在一定程度上解决客户端时钟与 Redis 服务器时钟不一致的问题。具体来说，Redlock 算法要求在多个独立的 Redis 实例上同时获得锁，并在大多数实例上成功获得锁时，才认为锁已成功获得。这种方式能够降低单个客户端时钟不同步的影响。

#### 锁的“延迟释放”而不是死锁

死锁是指多个进程（或线程）在争夺资源时相互等待的状态，导致整个系统无法继续进行。在您的问题中，虽然客户端 A 未正确释放锁导致客户端 B 无法获取锁，但最终客户端 A 还是会释放锁，所以不能严格地称为死锁。我们可以将这种情况称为**锁的“延迟释放”或“拖延”**，导致其他客户端需要等待更长时间才能获得锁。

判断死锁的必要条件通常包括以下几点：

1. 互斥条件：资源只能被一个进程（或线程）占有，无法被其他进程共享。
2. 请求与保持条件：一个进程在请求新资源的同时，保持对已分配资源的占有。
3. 不可剥夺条件：资源不能被强制从占有者手中回收，只能由占有者自愿释放。
4. 循环等待条件：存在一个进程（或线程）等待序列，其中每个进程都在等待下一个进程释放资源。

在您提到的场景中，尽管存在资源竞争和等待，但由于客户端 A 最终还是会释放锁，所以不满足死锁的循环等待条件。

## Redlock是啥

Redlock是Redis官方提供的一种分布式锁算法，它基于Paxos算法和Quorum原理，可以在Redis集群环境下保证互斥性和可用性。下面是Redlock算法的基本原理：

1. 获取当前时间戳T1。

2. 依次尝试在N个Redis节点上获取锁，并记录获取锁的节点数M和最小的锁超时时间min_expire_time。

3. 计算获取锁的时间cost_time，如果cost_time小于锁的超时时间，且M大于等于Q，则认为锁获取成功。

4. 如果锁获取成功，则返回锁的value值和锁的超时时间。

5. 如果锁获取失败，则依次在获取锁的节点上释放锁。

在上面的流程中，Redlock算法首先获取当前时间戳T1，然后在N个Redis节点上尝试获取锁，并记录获取锁的节点数M和最小的锁超时时间min_expire_time。如果获取锁的时间cost_time小于锁的超时时间，并且M大于等于Q，则认为锁获取成功，返回锁的value值和锁的超时时间；否则依次在获取锁的节点上释放锁。

在Redlock算法中，Q是一个足够大的数值，用于保证锁获取的节点数足够多，从而避免因为某些节点故障或网络分区等原因导致的锁失效。min_expire_time是获取锁的节点中锁超时时间最小的节点，用于保证锁超时时间的一致性。在实际使用中，可以通过调整N、Q、min_expire_time等参数来平衡锁的可用性和性能开销。

## redlock 存在什么问题

Redlock算法虽然能够在Redis集群环境下实现分布式锁，但它并不是一个完美的解决方案，仍然存在一些风险和限制。例如，Redlock算法无法避免“惊群效应”和“时钟漂移”等问题，因此在使用Redlock算法时需要根据具体情况进行评估和优化。

watchdog

业务延期

1. 容易受到网络分区的影响：如果多个 Redis 节点之间出现网络分区（即节点之间无法正常通信），则可能导致多个客户端同时持有锁，从而导致数据不一致等问题。

2. 实现困难：Redlock 的实现需要确保多个 Redis 节点之间的时钟同步，并且需要考虑各种异常情况，例如网络故障、节点故障等，这对于实现和维护来说都是一项比较困难的任务。

3. 性能问题：为了确保锁的可靠性，Redlock 需要在多个节点上进行多次锁定和解锁操作，这会导致一定的性能开销，特别是在高并发的场景下可能会影响系统的响应性能。

因此，在使用 Redlock 算法时需要认真评估其适用性，并根据实际情况选择合适的分布式锁实现方式。

### 惊群效应

“惊群效应”（Thundering Herd Effect）是指在并发请求下，由于访问同一个资源（例如数据库）而产生的一种现象，当这个资源处于繁忙状态时，多个并发请求同时到达，导致资源的过度竞争，进而导致大量的请求被延迟或者超时。

在 Redlock 算法中，由于在锁失效时需要去解锁，多个客户端会同时尝试解锁同一份数据，可能会导致类似的惊群效应，影响到 Redis 的性能。

### 时钟漂移

“时钟漂移”（Clock Drift）是指系统时钟因为硬件、温度等因素而导致的时间误差问题，也就是时钟的误差率。

在 Redlock 算法中，由于需要使用 Redis 服务器的时钟来计算锁的过期时间，而不同 Redis 服务器的时钟可能会有不同程度的误差，这会导致一些 Redis 节点计算的锁失效时间与其他节点不一致，进而导致锁被错误地释放或者未被释放，从而可能会出现数据不一致等问题。

## Redisson 实现 RedLock

### 在 Redisson 中, RedLock的实现类是哪一个类?

在 Redisson 中，RedLock 的实现类是 `org.redisson.RedissonRedLock`。该类是 Redisson 实现 RedLock 分布式锁算法的核心类，通过尝试获取多个独立的 Redis 实例上的锁来实现分布式锁的功能。具体实现方式是，使用多个 Redisson 的 `RedissonClient` 对象分别连接到不同的 Redis 实例上，并在每个实例上尝试获取相同名称的分布式锁。如果在大部分 Redis 实例上都成功获取到了锁，则认为获取分布式锁成功，否则认为获取分布式锁失败。

`RedissonRedLock` 类中的 `tryLock()` 方法是获取 RedLock 分布式锁的核心方法，该方法会依次尝试获取多个 Redis 实例上的锁，并在指定的等待时间内等待获取锁的过程。如果在指定的等待时间内获取到大部分 Redis 实例上的锁，则认为获取 RedLock 分布式锁成功，否则释放已经获取的锁。

在 `RedissonRedLock` 类的实现中，使用了多个 `RedissonClient` 对象来连接到不同的 Redis 实例上，同时使用了 `RPermitExpirableSemaphore` 类来实现分布式信号量，防止分布式锁过期时间内客户端宕机导致的死锁问题。

### 这一招叫抛砖引玉

如果您想使用 Redisson 实现分布式锁，可以使用 `org.redisson.Redisson` 类来创建 Redisson 客户端，并使用其 `getLock()` 方法获取分布式锁实例。以下是使用 Redisson 实现分布式锁的示例代码：

```java
import org.redisson.Redisson;
import org.redisson.api.RLock;

public class DistributedLockExample {
    public static void main(String[] args) {
        // 创建 Redisson 客户端
        Redisson redisson = Redisson.create();

        // 获取分布式锁实例
        RLock lock = redisson.getLock("myLock");

        try {
            // 尝试获取锁，等待时间为 10 秒，锁的过期时间为 60 秒
            boolean locked = lock.tryLock(10, 60, TimeUnit.SECONDS);
            if (locked) {
                // 获取锁成功，执行业务逻辑
                System.out.println("Lock acquired, executing critical section...");
            } else {
                // 获取锁失败，执行相应逻辑
                System.out.println("Lock not acquired, exiting...");
            }
        } catch (InterruptedException e) {
            // 线程被中断，执行相应逻辑
            e.printStackTrace();
        } finally {
            // 释放锁
            lock.unlock();
            redisson.shutdown();
        }
    }
}
```

在上面的代码中，我们使用 `Redisson.create()` 方法创建 Redisson 客户端，并使用其 `getLock()` 方法获取一个名为 "myLock" 的分布式锁实例。在 `tryLock()` 方法中，我们尝试获取该分布式锁，等待时间为 10 秒，锁的过期时间为 60 秒。如果获取锁成功，则执行业务逻辑，并在结束后调用 `unlock()` 方法释放锁。如果获取锁失败，则执行相应逻辑。最后在 finally 块中关闭 Redisson 客户端。

### springboot 中呢?

首先，需要在 pom.xml 文件中添加 Redisson 和 Jedis 的依赖：

```xml
<dependency>
    <groupId>org.redisson</groupId>
    <artifactId>redisson</artifactId>
    <version>3.16.1</version>
</dependency>
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>3.6.3</version>
</dependency>
```

然后，创建一个 Redisson 配置类 `RedissonConfig`，配置 Redisson 的连接信息和 RedLock 分布式锁的实现：

```java
import java.util.Arrays;
import java.util.List;

import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.redisson.config.ReadMode;
import org.redisson.config.RedissonNodeConfig;
import org.redisson.config.SubscriptionMode;
import org.redisson.connection.balancer.LoadBalancer;
import org.redisson.connection.balancer.RandomLoadBalancer;
import org.redisson.connection.balancer.RoundRobinLoadBalancer;
import org.redisson.connection.balancer.WeightedRoundRobinBalancer;
import org.redisson.connection.balancer.WeightedRoundRobinBalancer.WeightedRoundRobinEntry;
import org.redisson.connection.balancer.WeightedRoundRobinBalancer.WeightedRoundRobinLoadBalancerEntry;
import org.redisson.connection.balancer.WeightedRoundRobinBalancer.WeightedRoundRobinServers;
import org.redisson.connection.balancer.WeightedRoundRobinBalancer.WeightedRoundRobinServers.OrderType;
import org.redisson.spring.starter.RedissonAutoConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@AutoConfigureAfter(RedissonAutoConfiguration.class)
public class RedissonConfig {

    @Autowired
    private RedissonClient redissonClient;

    @Value("${redisson.redlock.addresses}")
    private String[] redlockAddresses;

    @Bean
    public RedissonClient redissonClient() {
        Config config = new Config();
        config.useClusterServers().addNodeAddress(redlockAddresses).setScanInterval(2000);
        return Redisson.create(config);
    }

    @Bean
    public RedissonRedLock redissonRedLock() {
        LoadBalancer loadBalancer = new RoundRobinLoadBalancer();
        List<String> nodeAddresses = Arrays.asList(redlockAddresses);
        List<RedissonNodeConfig> nodeConfigs = RedissonNodeConfig.fromAddresses(nodeAddresses);
        WeightedRoundRobinBalancer balancedLoadBalancer = new WeightedRoundRobinBalancer(loadBalancer, nodeConfigs);
        return new RedissonRedLock(balancedLoadBalancer);
    }
}
```

在上述配置类中，我们使用了 Redisson 的 `Config` 类来配置 Redisson 的连接信息和 `useClusterServers()` 方法来连接到 Redis Cluster。我们还定义了 `redissonRedLock()` 方法，使用 `RoundRobinLoadBalancer` 实现负载均衡，并将多个 Redis 实例传入 `RedissonRedLock` 类中，创建 RedLock 分布式锁实例。

然后，在 `application.properties` 文件中添加以下配置：

```properties
# Redis Cluster 地址
redisson.redlock.addresses=redis://localhost:7001,redis://localhost:7002,redis://localhost:7003

# RedLock 分布式锁名称
redlock.name=myLock
```

接下来，我们可以在一个 Spring Boot 的 Controller 类中使用 `@Autowired` 注解来注入 `RedissonRedLock` 实例，然后使用 `tryLock()` 方法获取分布式锁并执行业务逻辑：

```java
import java.util.concurrent.TimeUnit;

import org.redisson.RedissonRedLock;
import org.redisson.api.RLock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MyController {

    @Autowired
    private RedissonRedLock redissonRedLock;

    @GetMapping("/test")
    public String test() {
        RLock lock = redissonRedLock.getLock("myLock");
        try {
            // 尝试获取 RedLock 分布式锁，等待时间为 10 秒，锁的过期时间为 60 秒
            boolean locked = lock.tryLock(10, 60, TimeUnit.SECONDS);
            if (locked) {
                // 获取锁成功，执行业务逻辑
                System.out.println("Lock acquired, executing critical section...");
                // TODO: 执行业务逻辑
            } else {
                // 获取锁失败，执行相应逻辑
                System.out.println("Lock not acquired, exiting...");
            }
        } catch (InterruptedException e) {
            // 线程被中断，执行相应逻辑
            e.printStackTrace();
        } finally {
            // 释放锁
            lock.unlock();
        }
        return "Done";
    }
}
```

在上述示例代码中，我们使用 `@Autowired` 注解注入了 `RedissonRedLock` 实例，然后在 `test()` 方法中获取 RedLock 分布式锁并执行业务逻辑。在 `tryLock()` 方法中，我们尝试获取 RedLock 分布式锁，等待时间为 10 秒，锁的过期时间为 60 秒。如果获取锁成功，则执行业务逻辑，并在结束后调用 `unlock()` 方法释放锁。如果获取锁失败，则执行相应逻辑。

最后，启动 Spring Boot 应用程序，并访问 `http://localhost:8080/test` 路径，即可执行 RedLock 分布式锁实现的业务逻辑。

## 源码分析

```java
 /**
     * - 尝试获取红锁
     * <p>
     * - @param waitTime 最大等待时间
     * <p>
     * - @param leaseTime 锁持有时间
     * <p>
     * - @param unit 时间单位
     * <p>
     * - @return 是否成功获取到锁
     * <p>
     * - @throws InterruptedException 当线程被中断时抛出
     */
    public boolean tryLock(long waitTime, long leaseTime, TimeUnit unit) throws InterruptedException {
        // 如果是异步获取锁，则调用 tryLockAsync 方法，并等待返回结果
        //try {
        // return tryLockAsync(waitTime, leaseTime, unit).get();
        //} catch (ExecutionException e) {
        // throw new IllegalStateException(e);
        //}

        // 根据 leaseTime 计算新的锁持有时间
        long newLeaseTime = -1;
        if (leaseTime != -1) {
            newLeaseTime = unit.toMillis(waitTime) * 2;
        }

        // 获取当前时间和最大等待时间
        long time = System.currentTimeMillis();
        long remainTime = -1;
        if (waitTime != -1) {
            remainTime = unit.toMillis(waitTime);
        }

        // 计算获取锁的最大等待时间
        long lockWaitTime = calcLockWaitTime(remainTime);

        // 失败的锁个数限制
        int failedLocksLimit = failedLocksLimit();
        // 已获取到锁的集合
        List<RLock> acquiredLocks = new ArrayList<RLock>(locks.size());
        // 遍历锁集合，尝试获取锁
        for (ListIterator<RLock> iterator = locks.listIterator(); iterator.hasNext(); ) {
            RLock lock = iterator.next();
            boolean lockAcquired;
            try {
                // 如果最大等待时间和锁持有时间均为默认值，则使用 tryLock 方法获取锁
                if (waitTime == -1 && leaseTime == -1) {
                    lockAcquired = lock.tryLock();
                } else { // 否则使用带超时参数的 tryLock 方法获取锁
                    long awaitTime = Math.min(lockWaitTime, remainTime);
                    lockAcquired = lock.tryLock(awaitTime, newLeaseTime, TimeUnit.MILLISECONDS);
                }
            } catch (RedisResponseTimeoutException e) {
                // 如果获取锁超时，则释放已获取到的锁
                unlockInner(Arrays.asList(lock));
                lockAcquired = false;
            } catch (Exception e) {
                lockAcquired = false;
            }


            // 如果获取锁成功，则将锁添加到已获取锁的集合中 
            if (lockAcquired) {
                acquiredLocks.add(lock);
            } else { // 否则判断是否达到失败的锁个数限制，如果达到则直接退出循环 
                if (locks.size() - acquiredLocks.size() == failedLocksLimit()) {
                    break;
                }

                if (failedLocksLimit == 0) { // 重试次数已达到failedLocksLimit，释放已获取的锁并返回false 
                    unlockInner(acquiredLocks);
                    if (waitTime == -1 && leaseTime == -1) {
                        return false;
                    }
                    failedLocksLimit = failedLocksLimit();
                    acquiredLocks.clear(); // reset iterator 
                    while (iterator.hasPrevious()) {
                        iterator.previous();
                    }
                } else { // 减少重试次数并继续尝试获取锁 
                    failedLocksLimit--;
                }
            }
            if (leaseTime != -1) { // 如果设置了过期时间
                List<RFuture<Boolean>> futures = new ArrayList<RFuture<Boolean>>(acquiredLocks.size());
                for (RLock rLock : acquiredLocks) { // 遍历所有获取到的锁
                    RFuture<Boolean> future = rLock.expireAsync(unit.toMillis(leaseTime), TimeUnit.MILLISECONDS); // 为每个锁设置过期时间
                    futures.add(future);
                }

                for (RFuture<Boolean> rFuture : futures) { // 同步等待每个设置过期时间的操作完成
                    rFuture.syncUninterruptibly();
                }
            }

            return true; // 获取锁成功，返回true
        }

    }
```