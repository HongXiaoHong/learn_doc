> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/Youth_lql/article/details/115734142)

> 文章目录Netty 概述原生 NIO 存在的问题Netty 官网说明Netty 的优点Netty 版本说明Netty 高性能架构设计线程模型基本介绍传统阻塞 I/O 服务模型工作原理图模型特点问题分析Reactor 模式针对传统阻塞 I/O 服务模型的 2 个缺点，解决方案：I/O 复用结合线程池，就是 Reactor 模式基本设计思想，如图Reactor 模式中核心组成Reactor 模式分类单 Reactor 单线程方案说明方案优缺点分析单 Reactor 多线程方案说明方案优缺点分析主从 Reacto