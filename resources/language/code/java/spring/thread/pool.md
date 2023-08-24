# spring 线程池



[Spring自带的线程池ThreadPoolTaskExecutor - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/346086161)

## Spring默认线程池simpleAsyncTaskExecutor

Spring异步线程池的接口类是TaskExecutor，本质还是java.util.concurrent.Executor，没有配置的情况下，默认使用的是simpleAsyncTaskExecutor。





### ThreadPoolTaskExecutor



### 默认线程池

[Spring Boot教程(21) – 默认线程池 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/85855282)

Spring Boot已经帮你创建并配置好了，还配了两个，一个供`@Async`使用，一个供`@Scheduled`使用。
