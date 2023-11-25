# 分布式
## skywalking

### [MDC全局链路追踪原理与实现](https://juejin.cn/post/6901227625188950030)
skywalking 的原理以及 集成 elk 的原理
这里暂时只讨论直接调用的原理

通过 mdc 以及 在配置格式日志字符串加上 X{traceId}
集成 traceId

### 父子线程 线程池传递
[TransmittableThreadLocal详解](https://cloud.tencent.com/developer/article/1484420)
[全链路追踪必备组件之 TransmittableThreadLocal 详解](https://zhuanlan.zhihu.com/p/146124826)
TransmittableThreadLocal


### sleuth＋zipkin 与 skywalking 区别

[SpringCloud Alibaba实战第五课 链路追踪sleuth与skywalking](https://blog.csdn.net/fegus/article/details/124643581)
查看上述链接的图片需要魔法
Sleuth+Zipkin 侵入性强, 需要 在 pom.xml 文件中加入对应的 依赖才行
而 skywalking 是通过 java agent 探针的方式, 侵入性更小, 而且 直接提供界面查看, 不需要结合两个软件

### skywalking 结合 elk
#### [分布式日志系统ELK+skywalking分布式链路完整搭建流程](https://juejin.cn/post/7012877514787799071)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_AzKhn4kecv.png)

1.skywalking：分布式链路解决方案，可记录整条链路的调用详情，含所有下游服务，TID贯穿整条链路
2.elasticsearch1:用来存储skywalking的链路数据
3.filebeat：见名知意，文件心跳，用来收集springboot的日志文件，原理就是可指定log未知，开启收割机定时收集日志
4.logstash:用来过滤有效的日志信息，比如收集IP、TID等信息，定义索引规范，数据存储对接es
5.elasticsearch2：用来存储logstash过滤后的日志信息，本文主要存储错误日志
6.kibana：读取elasticsearch2的错误日志，UI页面

#### [ELK 日志系统集成 Skywalking 调用链 ID](https://cloud.tencent.com/developer/article/1696699)

Logstash 解析 Trace ID

```yaml
input {
    beats {
        port => 5044
        codec => "json"
    }
}

filter {
    grok {
        match => {
            # 从原始日志中解析出 trace_id 等其它需要的字段
            "message" => "^(?<timestamp>\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}\.\d{3})\s(?<level>\w{4,5})\s+\T\I\D\:\s*(?<trace_id>[0-9a-f.]{54})\s%{DATA:thread}\s%{DATA:class}\:%{GREEDYDATA:content}$"
        }
    }
    mutate {
        remove_field => "message" # 删除原始日志内容节省存储和带宽
    }
}

output {
    elasticsearch {
        hosts => ["http://xxx.xxx.xxx.xxx:9200"]
        index => "bms-log" # ES 重建立索引
    }
}
```

### 告警

分布式日志追踪组件
[SkyWalking - 实现微服务监控告警](https://www.jianshu.com/p/5cc42569af6f)

需要配置 
- 报警规则
- 触发报警后回调的接口 也就是 webhooks

报警规则示例:
```yaml
rules:
  # Rule unique name, must be ended with `_rule`.
  service_resp_time_rule:
    metrics-name: service_resp_time
    op: ">"
    threshold: 1000
    period: 10
    count: 3
    silence-period: 5
    message: Response time of service {name} is more than 1000ms in 3 minutes of last 10 minutes.
  service_sla_rule:
    # Metrics value need to be long, double or int
    metrics-name: service_sla
    op: "<"
    threshold: 8000
    # The length of time to evaluate the metrics
    period: 10
    # How many times after the metrics match the condition, will trigger alarm
    count: 2
    # How many times of checks, the alarm keeps silence after alarm triggered, default as same as period.
    silence-period: 3
    message: Successful rate of service {name} is lower than 80% in 2 minutes of last 10 minutes
  service_p90_sla_rule:
    # Metrics value need to be long, double or int
    metrics-name: service_p90
    op: ">"
    threshold: 1000
    period: 10
    count: 3
    silence-period: 5
    message: 90% response time of service {name} is more than 1000ms in 3 minutes of last 10 minutes
  service_instance_resp_time_rule:
    metrics-name: service_instance_resp_time
    op: ">"
    threshold: 1000
    period: 10
    count: 2
    silence-period: 5
    message: Response time of service instance {name} is more than 1000ms in 2 minutes of last 10 minutes
```

webhooks 只是说单纯调用接口
如果我们需要邮件的话, 需要结合 spring-boot-starter-mail 才可以发送邮件
或者你可以结合  -微信- 或者其他提醒方式 
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```