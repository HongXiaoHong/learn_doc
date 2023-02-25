# restful

restful 架构



## Restful API 如何进行版本控制



https://zhuanlan.zhihu.com/p/479528949



[注解版：如何优雅的设计 Restful API 实现 API 版本控制！_oh LAN的博客-CSDN博客_api接口版本控制](https://blog.csdn.net/weixin_39255905/article/details/110391515)



[理解RESTful架构 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2011/09/restful.html)



rest 表示层状态转换

资源 uri

服务器 客户端 传递这种资源的表示层

通过http四操作对资源进行操作 实现表示层状态修改



具体表示

我认为URI中应该只包含名词 动作由http协议规定

uri 版本号应该放到http 的 accept中最好
