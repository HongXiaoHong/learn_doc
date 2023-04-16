# springboot

## yml

使用 ${} 可以引用 环境变量 或者定义在 yaml 中的数据

同时可以用使用默认值
${env_name:default_value}

## springboot 与 存活就绪探针

高版本的 spring boot 2.3.0.M4 + 支持我们的探针 

不用加入 Actuator

### k8s 健康检查

[配置 Pod 的 liveness 和 readiness 探针 · Kubernetes 中文指南——云原生应用架构实战手册](https://jimmysong.io/kubernetes-handbook/guide/configure-liveness-readiness-probes.html)

当应用部署到kubernetes，kubernetes提供了两种探测机制

- Liveness探测(存活探针)：Liveness探测让用户可以自定义判断容器是否健康的条件。如果探测失败，Kubernetes就会重启容器

- Readiness探测(就绪探针)：Readiness探测则是告诉Kubernetes什么时候可以将容器加入到Service负载均衡池中，对外提供服务

### Actuator

[深入研究下Spring Boot Actuator 在kubernetes中探针的应用（spring boot testng） | 半码博客](https://www.bmabk.com/index.php/post/29859.html)
