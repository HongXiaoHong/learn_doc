# k8s

## todo

- 腾讯云 实操 Kubernetes (K8S) 3 小时快速上手 + 实践，无废话纯干货
  
  - https://www.bilibili.com/video/BV1Tg411P7EB?p=9&spm_id_from=pageDriver&vd_source=eabc2c22ae7849c2c4f31815da49f209

- [K8s 集群使用 ConfigMap 优雅加载 Spring Boot 配置文件 - 腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1433236)

- 教程  云原生Java架构师的第一课K8s+Docker+KubeSphere+DevOps
  
  - https://www.bilibili.com/video/BV13Q4y1C7hS/?vd_source=eabc2c22ae7849c2c4f31815da49f209

## 横空出世

[容器技术Docker、Docker-Compose、k8s的演变 - 掘金](https://juejin.cn/post/6844904046025768974)

## Kubernetes 概念篇：基本概念和术语

[从零开始入门 K8s：详解 K8s 核心概念_云计算_李响_InfoQ精选文章](https://www.infoq.cn/article/knmavdo3jxs3qpkqtzbw)

<iframe  
 height=850 
 width=90% 
 src="https://www.infoq.cn/article/knmavdo3jxs3qpkqtzbw"  
 frameborder=0  
 allowfullscreen>
 </iframe>

## 读取环境变量

https://www.jianshu.com/p/4166f05f68a4

## k8s-(七）暴露服务的三种方式

[k8s-(七）暴露服务的三种方式_新林。-DevPress官方社区](https://huaweicloud.csdn.net/63311d99d3efff3090b52ac9.html?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Eactivity-1-112363072-blog-108200034.pc_relevant_recovery_v2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Eactivity-1-112363072-blog-108200034.pc_relevant_recovery_v2&utm_relevant_index=2)

### 健康检查

当应用部署到kubernetes，kubernetes提供了两种探测机制

- Liveness探测(存活探针)：Liveness探测让用户可以自定义判断容器是否健康的条件。如果探测失败，Kubernetes就会重启容器

- Readiness探测(就绪探针)：Readiness探测则是告诉Kubernetes什么时候可以将容器加入到Service负载均衡池中，对外提供服务

[配置 Pod 的 liveness 和 readiness 探针 · Kubernetes 中文指南——云原生应用架构实战手册](https://jimmysong.io/kubernetes-handbook/guide/configure-liveness-readiness-probes.html)

[K8S 三种探针 ReadinessProbe、LivenessProbe和StartupProbe 之探索 - 掘金](https://juejin.cn/post/7163135179177852936)

## 持久化存储

[(13条消息) k8s 持久化存储-常见的存储卷介绍_k8s持久卷一般用什么_笨小孩@GF 知行合一的博客-CSDN博客](https://blog.csdn.net/gaofei0428/article/details/121227840?spm=1001.2101.3001.6650.11&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-11-121227840-blog-121870597.pc_relevant_aa2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-11-121227840-blog-121870597.pc_relevant_aa2&utm_relevant_index=17)

[PV、PVC和StorageClass_云容器引擎 CCE_Kubernetes基础知识_持久化存储_华为云 (huaweicloud.com)](https://support.huaweicloud.com/basics-cce/kubernetes_0030.html)

[持久卷 | Kubernetes](https://kubernetes.io/zh-cn/docs/concepts/storage/persistent-volumes/)

## 灵魂拷问

[23 个必知必会的 Kubernetes 高频面试题-51CTO.COM](https://www.51cto.com/article/706611.html)
