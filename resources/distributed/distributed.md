# 分布式

## todo

---

[[译] 我们是如何高效实现一致性哈希的 - 掘金 (juejin.cn)](https://juejin.cn/post/6844903641808109581#heading-6)

分布式一致性 哈希环

- 在分布式系统中，在公共目录读取文件到数据库中

## 分布式 id

全局 ID 唯一

[一口气说出9种分布式ID生成方式，面试官有点懵了 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/107939861)

[分布式 - 面试官：讲讲雪花算法，越详细越好 - 秦怀杂货店 - SegmentFault 思否](https://segmentfault.com/a/1190000040964518)

[[译] 把 UUID 或者 GUID 作为主键？你得小心啦！ - 掘金 (juejin.cn)](https://juejin.cn/post/6844903485872275463#heading-11)

**zookeeper是可以做分布式的命名服务**

## 分布式锁

互斥机制来控制共享资源

[(28条消息) Redis（三十二）-用Redis做分布式锁_码农飞哥的博客-CSDN博客](https://feige.blog.csdn.net/article/details/125209962)

### 几种主流的分布式锁

1. 基于数据库实现分布式锁
2. 基于缓存（Redis等）
3. 基于Zookeeper

#### 数据库

#### redis

Redis 可以通过 SETNX 和 EXPIRE 命令实现分布式锁。分布式锁是一种在分布式系统中实现资源互斥的方法，即在多个进程或者多台机器上对共享资源进行加锁，确保同一时刻只有一个进程或者机器能够访问该资源。

Redis 的分布式锁实现原理如下：

1. 通过 SETNX 命令设置一个特定的 key，如果该 key 不存在，则成功获取到锁；否则说明锁已经被其他进程或者机器占用，获取锁失败。

2. 如果获取到锁，则设置一个过期时间，保证即使该进程或机器出现异常导致没有释放锁，也不会一直占用该锁。

3. 当进程或机器使用完该锁后，通过 DEL 命令删除该 key，释放锁。

在实际应用中，为了避免由于 Redis 宕机导致锁失效而产生的竞争问题，可以使用 RedLock 算法。RedLock 算法是由 Redis 官方提供的一种高可用的分布式锁实现方案，它可以确保在大多数 Redis 实例正常工作的情况下，分布式锁能够正常运行。RedLock 算法的核心思想是在多个 Redis 实例上分别获取锁，确保在大多数实例上都成功获取到锁才算获取成功，这样可以大大提高分布式锁的可靠性。

总之，Redis 的分布式锁实现原理基于 SETNX 和 EXPIRE 命令，通过在多个进程或者机器上对同一 key 进行操作来实现资源互斥，避免并发问题的出现。

##### 如果超时 业务还没执行完呢

[redisson中的看门狗机制总结](https://www.cnblogs.com/jelly12345/p/14699492.html)

**1:普通的Redis分布式锁的缺陷**  
我们在网上看到的redis分布式锁的工具方法，大都满足互斥、防止死锁的特性，有些工具方法会满足可重入特性。如果只满足上述3种特性会有哪些隐患呢？redis分布式锁无法自动续期，比如，一个锁设置了1分钟超时释放，如果拿到这个锁的线程在一分钟内没有执行完毕，那么这个锁就会被其他线程拿到，可能会导致严重的线上问题，我已经在秒杀系统故障排查文章中，看到好多因为这个缺陷导致的超卖了。

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/816762-20210425105548419-1714180337.jpg)

Redisson 锁的加锁机制如上图所示，线程去获取锁，获取成功则执行lua脚本，保存数据到redis数据库。如果获取失败: 一直通过while循环尝试获取锁(可自定义等待时间，超时后返回失败)，获取成功后，执行lua脚本，保存数据到redis数据库。Redisson提供的分布式锁是支持锁自动续期的，也就是说，如果线程仍旧没有执行完，那么redisson会自动给redis中的目标key延长超时时间，这在Redisson中称之为 Watch Dog 机制。同时 redisson 还有公平锁、读写锁的实现。

```java
public void test() throws Exception{
    RLock lock = redissonClient.getLock("guodong");    // 拿锁失败时会不停的重试        // 具有Watch Dog 自动延期机制 默认续30s 每隔30/3=10 秒续到30s
    lock.lock();        // 尝试拿锁10s后停止重试,返回false 具有Watch Dog 自动延期机制 默认续30s
    boolean res1 = lock.tryLock(10, TimeUnit.SECONDS);         // 没有Watch Dog ，10s后自动释放
    lock.lock(10, TimeUnit.SECONDS);        // 尝试拿锁100s后停止重试,返回false 没有Watch Dog ，10s后自动释放
    boolean res2 = lock.tryLock(100, 10, TimeUnit.SECONDS);
    Thread.sleep(40000L);
    lock.unlock();
}
```

**2.Wath Dog的自动延期机制**  
如果拿到分布式锁的节点宕机，且这个锁正好处于锁住的状态时，会出现锁死的状态，为了避免这种情况的发生，锁都会设置一个过期时间。这样也存在一个问题，加入一个线程拿到了锁设置了30s超时，在30s后这个线程还没有执行完毕，锁超时释放了，就会导致问题，Redisson给出了自己的答案，就是 watch dog 自动延期机制。  
Redisson提供了一个监控锁的看门狗，它的作用是在Redisson实例被关闭前，不断的延长锁的有效期，也就是说，如果一个拿到锁的线程一直没有完成逻辑，那么看门狗会帮助线程不断的延长锁超时时间，锁不会因为超时而被释放。  
默认情况下，看门狗的续期时间是30s，也可以通过修改Config.lockWatchdogTimeout来另行指定。另外Redisson 还提供了可以指定leaseTime参数的加锁方法来指定加锁的时间。超过这个时间后锁便自动解开了，不会延长锁的有效期。  
**3.源码解读**  
其实要想对一个框架深刻的了解，主要还是多看源码，目前的Redisson的源码版本基于：3.16.4，同时需要注意的是：

- watchDog 只有在未显示指定加锁时间（leaseTime）时才会生效。（这点很重要）
- lockWatchdogTimeout设定的时间不要太小 ，比如我之前设置的是 100毫秒，由于网络直接导致加锁完后，watchdog去延期时，这个key在redis中已经被删除了。

在调用lock方法时，会最终调用到tryAcquireAsync。调用链为：lock()->tryAcquire->tryAcquireAsync,详细解释如下：

```java
private <T> RFuture<Long> tryAcquireAsync(long waitTime, long leaseTime, TimeUnit unit, long threadId) {
        RFuture<Long> ttlRemainingFuture;
        //如果指定了加锁时间，会直接去加锁
        if (leaseTime != -1) {
            ttlRemainingFuture = tryLockInnerAsync(waitTime, leaseTime, unit, threadId, RedisCommands.EVAL_LONG);
        } else {
            //没有指定加锁时间 会先进行加锁，并且默认时间就是 LockWatchdogTimeout的时间
            //这个是异步操作 返回RFuture 类似netty中的future
            ttlRemainingFuture = tryLockInnerAsync(waitTime, internalLockLeaseTime,
                    TimeUnit.MILLISECONDS, threadId, RedisCommands.EVAL_LONG);
        }

        //这里也是类似netty Future 的addListener，在future内容执行完成后执行
        ttlRemainingFuture.onComplete((ttlRemaining, e) -> {
            if (e != null) {
                return;
            }

            // lock acquired
            if (ttlRemaining == null) {
                // leaseTime不为-1时，不会自动延期
                if (leaseTime != -1) {
                    internalLockLeaseTime = unit.toMillis(leaseTime);
                } else {
                    //这里是定时执行 当前锁自动延期的动作,leaseTime为-1时，才会自动延期
                    scheduleExpirationRenewal(threadId);
                }
            }
        });
        return ttlRemainingFuture;
    }
```

scheduleExpirationRenewal 中会调用renewExpiration。 这里我们可以看到是,启用了一个timeout定时，去执行延期动作

```java
private void renewExpiration() {
    ExpirationEntry ee = EXPIRATION_RENEWAL_MAP.get(getEntryName());        if (ee == null) {            return;
    }
    Timeout task = commandExecutor.getConnectionManager().newTimeout(new TimerTask() {
        @Override            public void run(Timeout timeout) throws Exception {
            ExpirationEntry ent = EXPIRATION_RENEWAL_MAP.get(getEntryName());                if (ent == null) {                    return;
            }
            Long threadId = ent.getFirstThreadId();                if (threadId == null) {                    return;
            }
            RFuture<Boolean> future = renewExpirationAsync(threadId);
            future.onComplete((res, e) -> {                    if (e != null) {
                    log.error("Can't update lock " + getRawName() + " expiration", e);
                    EXPIRATION_RENEWAL_MAP.remove(getEntryName());                        return;
                }                    if (res) {                        //如果 没有报错，就再次定时延期                        // reschedule itself
                    renewExpiration();
                } else {
                    cancelExpirationRenewal(null);
                }
            });
        }            // 这里我们可以看到定时任务 是 lockWatchdogTimeout 的1/3时间去执行 renewExpirationAsync
    }, internalLockLeaseTime / 3, TimeUnit.MILLISECONDS);
    ee.setTimeout(task);
}
```

最终 scheduleExpirationRenewal会调用到 renewExpirationAsync，执行下面这段 lua脚本。他主要判断就是 这个锁是否在redis中存在，如果存在就进行 pexpire 延期。

```java
protected RFuture<Boolean> renewExpirationAsync(long threadId) {        return evalWriteAsync(getRawName(), LongCodec.INSTANCE, RedisCommands.EVAL_BOOLEAN,                "if (redis.call('hexists', KEYS[1], ARGV[2]) == 1) then " +
                    "redis.call('pexpire', KEYS[1], ARGV[1]); " +
                    "return 1; " +
                    "end; " +
                    "return 0;",
            Collections.singletonList(getRawName()),
            internalLockLeaseTime, getLockName(threadId));
}
```

**4.结论**

- watch dog 在当前节点存活时每10s给分布式锁的key续期 30s；
- watch dog 机制启动，且代码中没有释放锁操作时，watch dog 会不断的给锁续期；
- 如果程序释放锁操作时因为异常没有被执行，那么锁无法被释放，所以释放锁操作一定要放到 finally {} 中；
- 要使 watchLog机制生效 ，lock时 不要设置 过期时间
- watchlog的延时时间 可以由 lockWatchdogTimeout指定默认延时时间，但是不要设置太小。如100
- watchdog 会每 lockWatchdogTimeout/3时间，去延时。
- watchdog 通过 类似netty的 Future功能来实现异步延时
- watchdog 最终还是通过 lua脚本来进行延时

###### 看门狗底层代码实现

[Redis（三十四）-Redisson分布式锁看门狗-云社区-华为云 (huaweicloud.com)](https://bbs.huaweicloud.com/blogs/359638)

就是通过 lua 脚本实现

#### zookeeper



## 分布式事务

### XA

XA 协议是**由X/Open 组织提出的分布式事务处理规范，主要定义了事务管理器TM 和局部资源管理器RM 之间的接口**。 目前主流的数据库，比如oracle、DB2 都是支持XA 协议的。 XA 协议是由X/Open 组织提出的分布式事务处理规范，主要定义了事务管理器TM 和局部资源管理器RM 之间的接口

[DTP模型之一：（XA协议之一）XA协议、二阶段2PC、三阶段3PC提交 - duanxz - 博客园 (cnblogs.com)](https://www.cnblogs.com/duanxz/p/4672708.html)