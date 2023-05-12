# 日志打印

## todo

- [SpringBoot 整合 log4j2 使用yml的配置 - 掘金 (juejin.cn)](https://juejin.cn/post/7123954724419665950)

- 

slf4j
slf4j从LoggerFactory.getLogger()说起
https://blog.csdn.net/gs_albb/article/details/110285543

log4j2 之前有一个漏洞

[集成了 log4j 的 SpringBoot 下的漏洞复现 - 链滴 (ld246.com)](https://ld246.com/article/1639235464846)

## 入门

入门这篇完全够够的

[深入掌握Java日志体系，再也不迷路了 - 掘金](https://juejin.cn/post/6905026199722917902#heading-29)

## 桥接模式

https://design-patterns.readthedocs.io/zh_CN/latest/structural_patterns/bridge.html

## slf4j 怎么找到对应的实现类的

findServiceProvide 找到对应的实现类

通过在 classpath 中寻找到对应的 实现类 多个就使用第一个

```java
private static final void bind() {
        try {
            List<SLF4JServiceProvider> providersList = findServiceProviders();
            reportMultipleBindingAmbiguity(providersList);
            if (providersList != null && !providersList.isEmpty()) {
                PROVIDER = (SLF4JServiceProvider)providersList.get(0);
                PROVIDER.initialize();
                INITIALIZATION_STATE = 3;
                reportActualBinding(providersList);
            } else {
                INITIALIZATION_STATE = 4;
                Util.report("No SLF4J providers were found.");
                Util.report("Defaulting to no-operation (NOP) logger implementation");
                Util.report("See https://www.slf4j.org/codes.html#noProviders for further details.");
                Set<URL> staticLoggerBinderPathSet = findPossibleStaticLoggerBinderPathSet();
                reportIgnoredStaticLoggerBinders(staticLoggerBinderPathSet);
            }

            postBindCleanUp();
        } catch (Exception var2) {
            failedBinding(var2);
            throw new IllegalStateException("Unexpected initialization failure", var2);
        }
    }
```

```java
private static ServiceLoader<SLF4JServiceProvider> getServiceLoader(ClassLoader classLoaderOfLoggerFactory) {
        SecurityManager securityManager = System.getSecurityManager();
        ServiceLoader serviceLoader;
        if (securityManager == null) {
            serviceLoader = ServiceLoader.load(SLF4JServiceProvider.class, classLoaderOfLoggerFactory);
        } else {
            PrivilegedAction<ServiceLoader<SLF4JServiceProvider>> action = () -> {
                return ServiceLoader.load(SLF4JServiceProvider.class, classLoaderOfLoggerFactory);
            };
            serviceLoader = (ServiceLoader)AccessController.doPrivileged(action);
        }

        return serviceLoader;
    }
```



## 各种转换关系 SLF4J 的 🤔桥接器和适配器

![SLF4J桥接包关系图](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/879f572c91a345849aba912326dc40ae~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?)



## SPI机制

[Java常用机制 - SPI机制详解 | Java 全栈知识体系 (pdai.tech)](https://pdai.tech/md/java/advanced/java-advanced-spi.html)