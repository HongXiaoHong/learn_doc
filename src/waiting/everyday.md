## day day up good good learn
tirtle is a joke  
it is funny ? hhh

- 起床便看一道leetcode题目 目标如果在20分钟内没有思路 直接看答案
    - 之后自己敲一遍
    - 看讨论区
    - 写下笔记 总结
- 复习Java的基础内容 
    - 主要是看博客
    - 加上对应的Java编程思想
    - 以及练习 笔记
    
- 锻炼
    - 研究理论知识养生相关
    - 记下笔记 以及研究如何付诸实践
    


1. 20200914 完成题目的录入功能

了解Java解析各种格式（json xml yml）的工具
java 解析json

[JAVA中的四种JSON解析方式详解](https://blog.csdn.net/xingfei_work/article/details/76572550)
[JSON三种数据解析方法](https://blog.csdn.net/oman001/article/details/79063278?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)

复习一下spring
[SpringInterviewQuestions.md](https://github.com/Snailclimb/JavaGuide/blob/master/docs/system-design/framework/spring/SpringInterviewQuestions.md)
[必知](https://github.com/Snailclimb/JavaGuide#%E5%BF%85%E7%9F%A5)

##### waiting
验证log4j2 是否支持多环境日志输出
多环境日志输出
据不同环境（prod:生产环境，test:测试环境，dev:开发环境）来定义不同的日志输出，在 logback-spring.xml中使用 springProfile 节点来定义，方法如下：

文件名称不是logback.xml，想使用spring扩展profile支持，要以logback-spring.xml命名

Spring Boot干货系列：（七）默认日志框架配置

可以启动服务的时候指定 profile （如不指定使用默认），如指定prod 的方式为：

java -jar xxx.jar --spring.profiles.active=prod