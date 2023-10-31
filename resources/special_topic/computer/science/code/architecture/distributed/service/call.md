# 分布式

## 服务调用



[【Java面试】项目用的 Dubbo 还是 OpenFeign？Http 和 RPC 有什么区别？_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1MC4y1V7s7/?spm_id_from=333.1007.tianma.1-1-1.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

rpc 效率高, 但是兼容性不好

rest 性能差点, 但是兼容性更好



[6种微服务RPC框架，你知道几个？-微服务rpc框架 (51cto.com)](https://www.51cto.com/article/648311.html)

Dubbo：国内最早开源的 RPC 框架，由阿里巴巴公司开发并于 2011 年末对外开源，仅支持 Java 语言。

Motan：微博内部使用的 RPC 框架，于 2016 年对外开源，仅支持 Java 语言。

Tars：腾讯内部使用的 RPC 框架，于 2017 年对外开源，仅支持 C++ 语言。

Spring Cloud：国外 Pivotal 公司 2014 年对外开源的 RPC 框架，仅支持 Java 语言

而跨语言平台的开源 RPC 框架主要有以下几种。

gRPC：Google 于 2015 年对外开源的跨语言 RPC 框架，支持多种语言。

Thrift：最初是由 Facebook 开发的内部系统跨语言的 RPC 框架，2007 年贡献给了 Apache 基金，成为 Apache 开源项目之一，支持多种语言。

如果你的业务场景仅仅局限于一种语言的话，可以选择跟语言绑定的 RPC 框架中的一种;

如果涉及多个语言平台之间的相互调用，就应该选择跨语言平台的 RPC 框架。



## grpc 入门



grpc 需要结合 protobuf 序列化方式

```protobuf
syntax = "proto3";
 
option java_multiple_files = true;
package com.codenotfound.grpc.helloworld;
 
message Person {
  string first_name = 1;
  string last_name = 2;
}
 
message Greeting {
  string message = 1;
}
 
message A1 {
  int32  a = 1;
  int32  b = 2;
}
 
message A2 {
  int32  message = 1;
}
 
service HelloWorldService {
  rpc sayHello (Person) returns (Greeting);
  rpc addOperation (A1) returns (A2);
}
```

[springboot整合Grpc-protobuf实现通讯的方法_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1aS4y187ne/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[SpringBoot整合Grpc实现跨语言RPC通讯_io.github.lognet-CSDN博客](https://linuxstyle.blog.csdn.net/article/details/100727562?spm=1001.2101.3001.6650.3&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-3-100727562-blog-109050036.235%5Ev38%5Epc_relevant_anti_vip&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-3-100727562-blog-109050036.235%5Ev38%5Epc_relevant_anti_vip&utm_relevant_index=6)
