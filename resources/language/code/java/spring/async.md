# spring 异步

- @EnableAsync
- @Async



[SpringBoot使用@Async异步注解 - 简书 (jianshu.com)](https://www.jianshu.com/p/49b9d15456d9)

AsyncConfigurer

一个是执行的线程池，一个是异常处理

**@Async有两个使用的限制**

1. 它必须仅适用于 public 方法
2. 在同一个类中调用异步方法将无法正常工作(self-invocation)



自定义线程池

如果不自定义线程池, 则使用默认单线程操作

[SpringBoot异步使用@Async原理及线程池配置 - 掘金 (juejin.cn)](https://juejin.cn/post/7007706086954237965)



之前我们简要说过`@Async`和`[@Scheduled](https://zhuanlan.zhihu.com/p/80235700)`的用法，这俩注解会帮你完成异步任务和定时任务的需求。不知道你有没有想过，这些异步任务和定时任务都是在哪个线程执行的？Spring Boot肯定在背后做了很多工作，本文就来说说框架都为我们做了什么。

首先肯定是有线程池的。Spring Boot已经帮你创建并配置好了，还配了两个，一个供`@Async`使用，一个供`@Scheduled`使用。

[Spring Boot教程(21) – 默认线程池 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/85855282)



# @Async原理

使用 aop 

直接调用则会失效





同时调用三个异步接口



```java
        log.info("---主线程开始");
        List<Future> futureList = new ArrayList<>();
 
        List<VideoInfoDTO> videos = specsConfig.getVideos();
        if (CollectionUtils.isNotEmpty(videos)) {
            videos.forEach(video ->{
                Future future = videoCheckService.videoCheck(video,jsonVO.get());
                futureList.add(future);
            });
        }
        Set<String> msgResult = new HashSet<>();
        while (true) {
            if (CollectionUtils.isNotEmpty(futureList)) {
                boolean isAllDone = true;
                for (Future future : futureList) {
                    if (null == future || !future.isDone()) {
                        isAllDone = false;
                    }else {
                        try {
                            String msg =  (String) future.get();
                            if (StringUtils.isNotEmpty(msg)) {
                                msgResult.add(msg);
                            }
                        } catch (Exception e) {
                            log.info("---视频校验线程池处理单个视频校验出错！error:{}",ErrorUtils.errInfo(e));
                        }
                    }
                }
                if (isAllDone) {
                    break;
                }
            }
        }
        log.info("---主线程结束");
```



[SpringBoot异步使用@Async原理及线程池配置 - 掘金 (juejin.cn)](https://juejin.cn/post/7007706086954237965)

[(20条消息) SpringBoot线程池，@Async 注解。实现主线程等待所有子线程执行完毕再结束。_springboot等待线程池结束_着实着迷的博客-CSDN博客](https://blog.csdn.net/sgl520lxl/article/details/119757232)

[Spring Boot 中的线程池，这也太好用了！ - Java技术栈 - 博客园 (cnblogs.com)](https://www.cnblogs.com/javastack/p/14858652.html)


