# spring 源码 第二次分析

步骤:

1. 注册 Beandefinition 处理器
2. 触发/调用 Beandefinition 处理器
3. 扫描 Beandefinition, 
4. 通过 Beandefinition 加载 class
5. 实例化前
6. 实例化
   1. 推导合适的构造器
      1. 处理 @LookUp 方法
7. BD 的后置处理
8. 实例化后
9. 自动注入
10. 属性注入
11. Aware 回调
12. 初始化前
    1. BeanPostProcessor postProcessBeforeInitialization
13. 初始化
    1. InitializingBean afterPropertiesSet
    2. BeanDefinition中指定的初始化方法
14. 初始化后
    1. BeanPostProcessor postProcessAfterInitialization

[Spring依赖注入之@Lookup注解 - Hello_xzy_World - 博客园 (cnblogs.com)](https://www.cnblogs.com/XiaoZhengYu/p/15732023.html)

## springboot 启动啦

### 初始化  springbootApplication

```java
public SpringApplication(ResourceLoader resourceLoader, Class<?>... primarySources) {
        this.resourceLoader = resourceLoader;
        Assert.notNull(primarySources, "PrimarySources must not be null");
        this.primarySources = new LinkedHashSet<>(Arrays.asList(primarySources));
        // 根据类可否可以加载得到来获取网络类型
        this.webApplicationType = WebApplicationType.deduceFromClasspath();
        this.bootstrapRegistryInitializers = new ArrayList<>(
                getSpringFactoriesInstances(BootstrapRegistryInitializer.class));
        setInitializers((Collection) getSpringFactoriesInstances(ApplicationContextInitializer.class));
        setListeners((Collection) getSpringFactoriesInstances(ApplicationListener.class));
        this.mainApplicationClass = deduceMainApplicationClass();
    }
```

## 未归档

@order 注解用法
一、观察@order源码
二、@order实战
三、@order失效原因
四、@DependsOn控制加载顺序
五、springboot提供的注解
六、排序源码分析
七、@AutoConfigureOrder
https://blog.csdn.net/weixin_43888891/article/details/127481825?spm=1001.2101.3001.6650.5&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-5-127481825-blog-86649072.235%5Ev38%5Epc_relevant_anti_vip&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-5-127481825-blog-86649072.235%5Ev38%5Epc_relevant_anti_vip&utm_relevant_index=8
上面这篇博文提到 @Order 并不会影响到 单例启动的顺序
而是会影响到 单例注入的顺序

官方:
https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/core/annotation/Order.html
注意：从Spring 4.0开始，Spring中的许多组件都支持基于注释的排序，即使是在考虑目标组件的顺序值（来自其目标类或 @Bean 方法）的集合注入中也是如此。虽然此类顺序值可能会影响注入点的优先级，但请注意，它们不会影响单例启动顺序，这是由依赖关系和 @DependsOn 声明确定的正交问题（影响运行时确定的依赖关系图）。