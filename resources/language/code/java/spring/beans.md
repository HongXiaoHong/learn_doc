# spring 中重要的类

## FactoryBean | 自定义复杂的 bean
https://www.jianshu.com/p/d6c42d723464

beanfactory 与 FactoryBean 关系
context 其实就是一个高级的 beanfactory

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230911150154.png)

## ClassPathBeanDefinitionScanner | 类扫描器
https://fangjian0423.github.io/2017/06/11/spring-custom-component-provider/

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230911163257.png)

与之相关的类 有:
- ComponentScanAnnotationParser
- ScannedGenericBeanDefinition
- ClassPathScanningCandidateComponentProvider

我们要实现 自己的类扫描器 只需要
继承 ClassPathScanningCandidateComponentProvider

然后覆盖 ClassPathScanningCandidateComponentProvider 的过滤器就可以了

这里用的应该就是模板模式了

