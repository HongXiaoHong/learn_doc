# springboot 结合 mybatis 原理

## 问题

- [ ] 如果不配置数据源会怎么样
- [ ] mybatis 自动配置/装载做了什么
- [ ] @MapperScan 做了什么
  - [ ] mybatis 如何将 mapper 等配置加载到 spring 容器中
  - [ ] MapperFactoryBean 怎么注入 SqlSessionTemplate
- [ ] 接口又是如何查询的
  - [ ] 如何通过动态代理创建我们的 crud 操作
- [ ] 懒加载又是如何实现的


## 关键的类/概念有哪些

SqlSession 会话
每个 mapper 都会有一个 会话

每一条 Sql 对应一个 MapperStatement

每一个 Mapper 都会用 MapperProxy 创建代理类


## mapper/MapperProxy 如何与 MapperStatement 关联到一起的

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/idea64_IaP8q6azXN.jpg)

```log
buildStatementFromContext:147, XMLMapperBuilder (org.apache.ibatis.builder.xml)
buildStatementFromContext:136, XMLMapperBuilder (org.apache.ibatis.builder.xml)
configurationElement:126, XMLMapperBuilder (org.apache.ibatis.builder.xml)
parse:100, XMLMapperBuilder (org.apache.ibatis.builder.xml)
buildSqlSessionFactory:698, SqlSessionFactoryBean (org.mybatis.spring)
afterPropertiesSet:577, SqlSessionFactoryBean (org.mybatis.spring)
getObject:720, SqlSessionFactoryBean (org.mybatis.spring)
sqlSessionFactory:189, MybatisAutoConfiguration (org.mybatis.spring.boot.autoconfigure)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
instantiate:139, SimpleInstantiationStrategy (org.springframework.beans.factory.support)
instantiate:655, ConstructorResolver (org.springframework.beans.factory.support)
instantiateUsingFactoryMethod:647, ConstructorResolver (org.springframework.beans.factory.support)
instantiateUsingFactoryMethod:1332, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
createBeanInstance:1162, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
doCreateBean:560, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
createBean:520, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
lambda$doGetBean$0:326, AbstractBeanFactory (org.springframework.beans.factory.support)
getObject:-1, AbstractBeanFactory$$Lambda$332/0x0000000800dca518 (org.springframework.beans.factory.support)
getSingleton:234, DefaultSingletonBeanRegistry (org.springframework.beans.factory.support)
doGetBean:324, AbstractBeanFactory (org.springframework.beans.factory.support)
getBean:200, AbstractBeanFactory (org.springframework.beans.factory.support)
resolveCandidate:254, DependencyDescriptor (org.springframework.beans.factory.config)
doResolveDependency:1417, DefaultListableBeanFactory (org.springframework.beans.factory.support)
resolveDependency:1337, DefaultListableBeanFactory (org.springframework.beans.factory.support)
autowireByType:1498, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
populateBean:1407, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
doCreateBean:597, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
createBean:520, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
lambda$doGetBean$0:326, AbstractBeanFactory (org.springframework.beans.factory.support)
getObject:-1, AbstractBeanFactory$$Lambda$332/0x0000000800dca518 (org.springframework.beans.factory.support)
getSingleton:234, DefaultSingletonBeanRegistry (org.springframework.beans.factory.support)
doGetBean:324, AbstractBeanFactory (org.springframework.beans.factory.support)
getBean:200, AbstractBeanFactory (org.springframework.beans.factory.support)
resolveCandidate:254, DependencyDescriptor (org.springframework.beans.factory.config)
doResolveDependency:1417, DefaultListableBeanFactory (org.springframework.beans.factory.support)
resolveDependency:1337, DefaultListableBeanFactory (org.springframework.beans.factory.support)
resolveFieldValue:713, AutowiredAnnotationBeanPostProcessor$AutowiredFieldElement (org.springframework.beans.factory.annotation)
inject:696, AutowiredAnnotationBeanPostProcessor$AutowiredFieldElement (org.springframework.beans.factory.annotation)
inject:145, InjectionMetadata (org.springframework.beans.factory.annotation)
postProcessProperties:483, AutowiredAnnotationBeanPostProcessor (org.springframework.beans.factory.annotation)
populateBean:1416, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
doCreateBean:597, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
createBean:520, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
lambda$doGetBean$0:326, AbstractBeanFactory (org.springframework.beans.factory.support)
getObject:-1, AbstractBeanFactory$$Lambda$332/0x0000000800dca518 (org.springframework.beans.factory.support)
getSingleton:234, DefaultSingletonBeanRegistry (org.springframework.beans.factory.support)
doGetBean:324, AbstractBeanFactory (org.springframework.beans.factory.support)
getBean:200, AbstractBeanFactory (org.springframework.beans.factory.support)
preInstantiateSingletons:973, DefaultListableBeanFactory (org.springframework.beans.factory.support)
finishBeanFactoryInitialization:942, AbstractApplicationContext (org.springframework.context.support)
refresh:608, AbstractApplicationContext (org.springframework.context.support)
refresh:734, SpringApplication (org.springframework.boot)
refreshContext:436, SpringApplication (org.springframework.boot)
run:312, SpringApplication (org.springframework.boot)
run:1306, SpringApplication (org.springframework.boot)
run:1295, SpringApplication (org.springframework.boot)
main:13, MybatisApplication (me.yi.hong.mybatis)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
run:50, RestartLauncher (org.springframework.boot.devtools.restart)
```

## 如果不配置数据源会怎么样

## mybatis 自动配置/装载做了什么

jetbrains://idea/navigate/reference?project=demo&path=D:/app/code/maven/repository/org/mybatis/spring/boot/mybatis-spring-boot-autoconfigure/3.0.2/mybatis-spring-boot-autoconfigure-3.0.2.jar!/META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports

```bash
org.mybatis.spring.boot.autoconfigure.MybatisLanguageDriverAutoConfiguration
org.mybatis.spring.boot.autoconfigure.MybatisAutoConfiguration

```


配置 
```java
@Bean
  @ConditionalOnMissingBean
  public SqlSessionFactory sqlSessionFactory(DataSource dataSource)


  @Bean
  @ConditionalOnMissingBean
  public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) 
```


同时 也会注册 扫描 @Mapper 接口 的 MapperScannerConfigurer

```java

@Override
    public void registerBeanDefinitions(AnnotationMetadata importingClassMetadata, BeanDefinitionRegistry registry) {

      if (!AutoConfigurationPackages.has(this.beanFactory)) {
        logger.debug("Could not determine auto-configuration package, automatic mapper scanning disabled.");
        return;
      }

      logger.debug("Searching for mappers annotated with @Mapper");

      List<String> packages = AutoConfigurationPackages.get(this.beanFactory);
      if (logger.isDebugEnabled()) {
        packages.forEach(pkg -> logger.debug("Using auto-configuration base package '{}'", pkg));
      }

      BeanDefinitionBuilder builder = BeanDefinitionBuilder.genericBeanDefinition(MapperScannerConfigurer.class);
      builder.addPropertyValue("processPropertyPlaceHolders", true);
      builder.addPropertyValue("annotationClass", Mapper.class);
```

## 注册 mapper 可以有多少种方式

1. 使用 @MapperScan

2. 使用 @Mapper
```java
@org.springframework.context.annotation.Configuration(proxyBeanMethods = false)
  @Import(AutoConfiguredMapperScannerRegistrar.class)
  @ConditionalOnMissingBean({ MapperFactoryBean.class, MapperScannerConfigurer.class })
  public static class MapperScannerRegistrarNotFoundConfiguration implements InitializingBean {

```
我们没有配置 @MapperScan 的时候 不会有 MapperScannerConfigurer, 
所以这里进入我们这个分支

从而 引入 扫描 @Mapper  的 扫描

```java
@Override
    public void registerBeanDefinitions(AnnotationMetadata importingClassMetadata, BeanDefinitionRegistry registry) {

      if (!AutoConfigurationPackages.has(this.beanFactory)) {
        logger.debug("Could not determine auto-configuration package, automatic mapper scanning disabled.");
        return;
      }

      logger.debug("Searching for mappers annotated with @Mapper");

      List<String> packages = AutoConfigurationPackages.get(this.beanFactory);
      if (logger.isDebugEnabled()) {
        packages.forEach(pkg -> logger.debug("Using auto-configuration base package '{}'", pkg));
      }

      BeanDefinitionBuilder builder = BeanDefinitionBuilder.genericBeanDefinition(MapperScannerConfigurer.class);
      builder.addPropertyValue("processPropertyPlaceHolders", true);
      builder.addPropertyValue("annotationClass", Mapper.class);
      builder.addPropertyValue("basePackage", StringUtils.collectionToCommaDelimitedString(packages));
      BeanWrapper beanWrapper = new BeanWrapperImpl(MapperScannerConfigurer.class);
```

3. 直接配置 MapperScannerConfigurer ...

## @MapperScan 做了什么

```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
@Import(MapperScannerRegistrar.class)
@Repeatable(MapperScans.class)
public @interface MapperScan {
  @AliasFor("basePackages")
  String[] value() default {};
  @AliasFor("value")
  String[] basePackages() default {};
 Class<? extends MapperFactoryBean> factoryBean() default MapperFactoryBean.class;
```

import MapperScannerRegistrar
-> 

注册 MapperScannerConfigurer BeanDefinition

```java


@Override
  public void registerBeanDefinitions(AnnotationMetadata importingClassMetadata, BeanDefinitionRegistry registry) {
    AnnotationAttributes mapperScanAttrs = AnnotationAttributes
        .fromMap(importingClassMetadata.getAnnotationAttributes(MapperScan.class.getName()));
    if (mapperScanAttrs != null) {
      registerBeanDefinitions(importingClassMetadata, mapperScanAttrs, registry,
          generateBaseBeanName(importingClassMetadata, 0));
    }
  }

  void registerBeanDefinitions(AnnotationMetadata annoMeta, AnnotationAttributes annoAttrs,
      BeanDefinitionRegistry registry, String beanName) {

    BeanDefinitionBuilder builder = BeanDefinitionBuilder.genericBeanDefinition(MapperScannerConfigurer.class);
    builder.addPropertyValue("processPropertyPlaceHolders", true);

```

```java
@Override
  public void postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry) {
    if (this.processPropertyPlaceHolders) {
      processPropertyPlaceHolders();
    }

    ClassPathMapperScanner scanner = new ClassPathMapperScanner(registry);
    scanner.setAddToConfig(this.addToConfig);
    scanner.setAnnotationClass(this.annotationClass);
    scanner.setMarkerInterface(this.markerInterface);
    scanner.setSqlSessionFactory(this.sqlSessionFactory);
    scanner.setSqlSessionTemplate(this.sqlSessionTemplate);
    scanner.setSqlSessionFactoryBeanName(this.sqlSessionFactoryBeanName);
    scanner.setSqlSessionTemplateBeanName(this.sqlSessionTemplateBeanName);
    scanner.setResourceLoader(this.applicationContext);
    scanner.setBeanNameGenerator(this.nameGenerator);
    scanner.setMapperFactoryBeanClass(this.mapperFactoryBeanClass);
    if (StringUtils.hasText(lazyInitialization)) {
      scanner.setLazyInitialization(Boolean.valueOf(lazyInitialization));
    }
    if (StringUtils.hasText(defaultScope)) {
      scanner.setDefaultScope(defaultScope);
    }
    scanner.registerFilters();
    scanner.scan(
        StringUtils.tokenizeToStringArray(this.basePackage, ConfigurableApplicationContext.CONFIG_LOCATION_DELIMITERS));
  }
```

扫描我们配置的 basePackage 最后 beanclass 设置为 
> Class<? extends MapperFactoryBean> factoryBean() default MapperFactoryBean.class

```java
private void processBeanDefinitions(Set<BeanDefinitionHolder> beanDefinitions) {
    AbstractBeanDefinition definition;
    BeanDefinitionRegistry registry = getRegistry();
    for (BeanDefinitionHolder holder : beanDefinitions) {
      definition = (AbstractBeanDefinition) holder.getBeanDefinition();
      boolean scopedProxy = false;
      if (ScopedProxyFactoryBean.class.getName().equals(definition.getBeanClassName())) {
        definition = (AbstractBeanDefinition) Optional
            .ofNullable(((RootBeanDefinition) definition).getDecoratedDefinition())
            .map(BeanDefinitionHolder::getBeanDefinition).orElseThrow(() -> new IllegalStateException(
                "The target bean definition of scoped proxy bean not found. Root bean definition[" + holder + "]"));
        scopedProxy = true;
      }
      String beanClassName = definition.getBeanClassName();
      LOGGER.debug(() -> "Creating MapperFactoryBean with name '" + holder.getBeanName() + "' and '" + beanClassName
          + "' mapperInterface");

      // the mapper interface is the original class of the bean
      // but, the actual class of the bean is MapperFactoryBean
      definition.getConstructorArgumentValues().addGenericArgumentValue(beanClassName); // issue #59
      try {
        // for spring-native
        definition.getPropertyValues().add("mapperInterface", Resources.classForName(beanClassName));
      } catch (ClassNotFoundException ignore) {
        // ignore
      }

      definition.setBeanClass(this.mapperFactoryBeanClass);

      definition.getPropertyValues().add("addToConfig", this.addToConfig);

      // Attribute for MockitoPostProcessor
      // https://github.com/mybatis/spring-boot-starter/issues/475
      definition.setAttribute(FACTORY_BEAN_OBJECT_TYPE, beanClassName);

      boolean explicitFactoryUsed = false;
      if (StringUtils.hasText(this.sqlSessionFactoryBeanName)) {
        definition.getPropertyValues().add("sqlSessionFactory",
            new RuntimeBeanReference(this.sqlSessionFactoryBeanName));
        explicitFactoryUsed = true;
      } else if (this.sqlSessionFactory != null) {
        definition.getPropertyValues().add("sqlSessionFactory", this.sqlSessionFactory);
        explicitFactoryUsed = true;
      }

      if (StringUtils.hasText(this.sqlSessionTemplateBeanName)) {
        if (explicitFactoryUsed) {
          LOGGER.warn(
              () -> "Cannot use both: sqlSessionTemplate and sqlSessionFactory together. sqlSessionFactory is ignored.");
        }
        definition.getPropertyValues().add("sqlSessionTemplate",
            new RuntimeBeanReference(this.sqlSessionTemplateBeanName));
        explicitFactoryUsed = true;
      } else if (this.sqlSessionTemplate != null) {
        if (explicitFactoryUsed) {
          LOGGER.warn(
              () -> "Cannot use both: sqlSessionTemplate and sqlSessionFactory together. sqlSessionFactory is ignored.");
        }
        definition.getPropertyValues().add("sqlSessionTemplate", this.sqlSessionTemplate);
        explicitFactoryUsed = true;
      }

      if (!explicitFactoryUsed) {
        LOGGER.debug(() -> "Enabling autowire by type for MapperFactoryBean with name '" + holder.getBeanName() + "'.");
        definition.setAutowireMode(AbstractBeanDefinition.AUTOWIRE_BY_TYPE);
      }

      definition.setLazyInit(lazyInitialization);

      if (scopedProxy) {
        continue;
      }

      if (ConfigurableBeanFactory.SCOPE_SINGLETON.equals(definition.getScope()) && defaultScope != null) {
        definition.setScope(defaultScope);
      }

      if (!definition.isSingleton()) {
        BeanDefinitionHolder proxyHolder = ScopedProxyUtils.createScopedProxy(holder, registry, true);
        if (registry.containsBeanDefinition(proxyHolder.getBeanName())) {
          registry.removeBeanDefinition(proxyHolder.getBeanName());
        }
        registry.registerBeanDefinition(proxyHolder.getBeanName(), proxyHolder.getBeanDefinition());
      }

    }
  }
```
### MapperFactoryBean 怎么注入 SqlSessionTemplate

我调试的时候已经找到了
会在创建 MapperFactoryBean 的时候 注入 PropertyValues 里面设置的属性

其中就包括 sqlsessiontemplate

不过我没找到是在哪里 把 这个 SqlSessionTemplate 放置到 PropertyValues 列表里面的
估计就是在某个 BeanFactoryPostProcessor 里面吧
这里先留个坑吧, 后面再看了

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/idea64_HgY8WFbFs6.jpg)

```log

setSqlSessionTemplate:93, SqlSessionDaoSupport (org.mybatis.spring.support)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
setValue:273, BeanWrapperImpl$BeanPropertyHandler (org.springframework.beans)
processLocalProperty:462, AbstractNestablePropertyAccessor (org.springframework.beans)
setPropertyValue:279, AbstractNestablePropertyAccessor (org.springframework.beans)
setPropertyValue:267, AbstractNestablePropertyAccessor (org.springframework.beans)
setPropertyValues:104, AbstractPropertyAccessor (org.springframework.beans)
setPropertyValues:79, AbstractPropertyAccessor (org.springframework.beans)
applyPropertyValues:1715, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
populateBean:1431, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
doCreateBean:597, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
createBean:520, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
lambda$doGetBean$0:326, AbstractBeanFactory (org.springframework.beans.factory.support)
getObject:-1, AbstractBeanFactory$$Lambda$327/0x0000000800dc9868 (org.springframework.beans.factory.support)
getSingleton:234, DefaultSingletonBeanRegistry (org.springframework.beans.factory.support)
doGetBean:324, AbstractBeanFactory (org.springframework.beans.factory.support)
getBean:200, AbstractBeanFactory (org.springframework.beans.factory.support)
resolveCandidate:254, DependencyDescriptor (org.springframework.beans.factory.config)
doResolveDependency:1417, DefaultListableBeanFactory (org.springframework.beans.factory.support)
resolveDependency:1337, DefaultListableBeanFactory (org.springframework.beans.factory.support)
resolveFieldValue:713, AutowiredAnnotationBeanPostProcessor$AutowiredFieldElement (org.springframework.beans.factory.annotation)
inject:696, AutowiredAnnotationBeanPostProcessor$AutowiredFieldElement (org.springframework.beans.factory.annotation)
inject:145, InjectionMetadata (org.springframework.beans.factory.annotation)
postProcessProperties:483, AutowiredAnnotationBeanPostProcessor (org.springframework.beans.factory.annotation)
populateBean:1416, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
doCreateBean:597, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
createBean:520, AbstractAutowireCapableBeanFactory (org.springframework.beans.factory.support)
lambda$doGetBean$0:326, AbstractBeanFactory (org.springframework.beans.factory.support)
getObject:-1, AbstractBeanFactory$$Lambda$327/0x0000000800dc9868 (org.springframework.beans.factory.support)
getSingleton:234, DefaultSingletonBeanRegistry (org.springframework.beans.factory.support)
doGetBean:324, AbstractBeanFactory (org.springframework.beans.factory.support)
getBean:200, AbstractBeanFactory (org.springframework.beans.factory.support)
preInstantiateSingletons:973, DefaultListableBeanFactory (org.springframework.beans.factory.support)
finishBeanFactoryInitialization:942, AbstractApplicationContext (org.springframework.context.support)
refresh:608, AbstractApplicationContext (org.springframework.context.support)
refresh:734, SpringApplication (org.springframework.boot)
refreshContext:436, SpringApplication (org.springframework.boot)
run:312, SpringApplication (org.springframework.boot)
run:1306, SpringApplication (org.springframework.boot)
run:1295, SpringApplication (org.springframework.boot)
main:13, MybatisApplication (me.yi.hong.mybatis)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
run:50, RestartLauncher (org.springframework.boot.devtools.restart)
```

### MapperFactoryBean 的参数 真实 Mapper class 如何获得

当我们去创建 MapperFactoryBean 的时候, 我们需要去获取 Mapper  真实接口的 class 传递给 MapperFactoryBean
用来创建实例

其实就是在 Beandefinition 扫描的时候 将参数设置到了 Beandefinition 中了
从 getConstructorArgumentValues 就可以了

org.springframework.beans.factory.support.AbstractBeanDefinition#getConstructorArgumentValues
D:/app/code/maven/repository/org/springframework/spring-beans/6.0.11/spring-beans-6.0.11-sources.jar!/org/springframework/beans/factory/support/ConstructorResolver.java:203
```java
int minNrOfArgs;
			if (explicitArgs != null) {
				minNrOfArgs = explicitArgs.length;
			}
			else {
				ConstructorArgumentValues cargs = mbd.getConstructorArgumentValues();
				resolvedValues = new ConstructorArgumentValues();
				minNrOfArgs = resolveConstructorArguments(beanName, mbd, bw, cargs, resolvedValues);
			}
```


```java
scanCandidateComponents:422, ClassPathScanningCandidateComponentProvider (org.springframework.context.annotation)
findCandidateComponents:317, ClassPathScanningCandidateComponentProvider (org.springframework.context.annotation)
doScan:276, ClassPathBeanDefinitionScanner (org.springframework.context.annotation)
doScan:230, ClassPathMapperScanner (org.mybatis.spring.mapper)
scan:254, ClassPathBeanDefinitionScanner (org.springframework.context.annotation)
postProcessBeanDefinitionRegistry:381, MapperScannerConfigurer (org.mybatis.spring.mapper)
invokeBeanDefinitionRegistryPostProcessors:344, PostProcessorRegistrationDelegate (org.springframework.context.support)
invokeBeanFactoryPostProcessors:145, PostProcessorRegistrationDelegate (org.springframework.context.support)
invokeBeanFactoryPostProcessors:771, AbstractApplicationContext (org.springframework.context.support)
refresh:589, AbstractApplicationContext (org.springframework.context.support)
refresh:734, SpringApplication (org.springframework.boot)
refreshContext:436, SpringApplication (org.springframework.boot)
run:312, SpringApplication (org.springframework.boot)
run:1306, SpringApplication (org.springframework.boot)
run:1295, SpringApplication (org.springframework.boot)
main:13, MybatisApplication (me.yi.hong.mybatis)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
run:50, RestartLauncher (org.springframework.boot.devtools.restart)
```

> Resource[] resources = getResourcePatternResolver().getResources(packageSearchPath);

通过执行  getResourcePatternResolver() 得到 AnnotationConfigApplicationContext

执行 getResources 调用的时候 调用的是父类的方法

```java
@Override
    public Resource[] getResources(String locationPattern) throws IOException {
        if (this.resourceLoader instanceof ResourcePatternResolver resourcePatternResolver) {
            return resourcePatternResolver.getResources(locationPattern);
        }
        return super.getResources(locationPattern);
    }
```

这里使用的 正则进行匹配 ResourcePatternResolver
进入 if 分支
resourcePatternResolver.getResources(locationPattern);

D:/app/code/maven/repository/org/springframework/spring-core/6.0.11/spring-core-6.0.11-sources.jar!/org/springframework/core/io/support/PathMatchingResourcePatternResolver.java:329



```java
if (locationPattern.startsWith(CLASSPATH_ALL_URL_PREFIX)) {
			// a class path resource (multiple resources for same name possible)
			String locationPatternWithoutPrefix = locationPattern.substring(CLASSPATH_ALL_URL_PREFIX.length());
			// Search the module path first.
			Set<Resource> resources = findAllModulePathResources(locationPatternWithoutPrefix);
			// Search the class path next.
			if (getPathMatcher().isPattern(locationPatternWithoutPrefix)) {
				// a class path resource pattern
				Collections.addAll(resources, findPathMatchingResources(locationPattern));
			}
```

org.springframework.core.io.support.PathMatchingResourcePatternResolver#doFindPathMatchingFileResources



```java
result.addAll(doFindPathMatchingFileResources(rootDirResource, subPattern));
```



追到 
org.springframework.core.io.support.PathMatchingResourcePatternResolver#doFindPathMatchingFileResources

```java
Set<Resource> result = new LinkedHashSet<>();
        try (Stream<Path> files = Files.walk(rootPath)) {
            files.filter(isMatchingFile).sorted().map(FileSystemResource::new).forEach(result::add);
        }
```

PS: Files.walk 深度优先遍历 或者说递归遍历返回一个流对象

注册 BeanDefinitionRegistry 处理器
调用 BeanDefinitionRegistry 处理器
注册 Beandefinition

### 注册 BeanDefinitionRegistry 处理器

BeanDefinitionRegistryPostProcessor

### 调用 BeanDefinitionRegistry 处理器
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230905001741.png)

是 BeanDefinitionRegistryPostProcessor

调用 postProcessBeanDefinitionRegistry

```java
scanner.scan(
        StringUtils.tokenizeToStringArray(this.basePackage, ConfigurableApplicationContext.CONFIG_LOCATION_DELIMITERS));


```
扫描注册 Beandefinition



#### 注册 Beandefinition
```java

lambda$registerFilters$0:214, ClassPathMapperScanner (org.mybatis.spring.mapper)
match:-1, ClassPathMapperScanner$$Lambda$441/0x0000000800e63d50 (org.mybatis.spring.mapper)
isCandidateComponent:500, ClassPathScanningCandidateComponentProvider (org.springframework.context.annotation)
scanCandidateComponents:436, ClassPathScanningCandidateComponentProvider (org.springframework.context.annotation)
findCandidateComponents:317, ClassPathScanningCandidateComponentProvider (org.springframework.context.annotation)
doScan:276, ClassPathBeanDefinitionScanner (org.springframework.context.annotation)
doScan:230, ClassPathMapperScanner (org.mybatis.spring.mapper)
scan:254, ClassPathBeanDefinitionScanner (org.springframework.context.annotation)
postProcessBeanDefinitionRegistry:381, MapperScannerConfigurer (org.mybatis.spring.mapper)
invokeBeanDefinitionRegistryPostProcessors:344, PostProcessorRegistrationDelegate (org.springframework.context.support)
invokeBeanFactoryPostProcessors:145, PostProcessorRegistrationDelegate (org.springframework.context.support)
invokeBeanFactoryPostProcessors:771, AbstractApplicationContext (org.springframework.context.support)
refresh:589, AbstractApplicationContext (org.springframework.context.support)
refresh:734, SpringApplication (org.springframework.boot)
refreshContext:436, SpringApplication (org.springframework.boot)
run:312, SpringApplication (org.springframework.boot)
run:1306, SpringApplication (org.springframework.boot)
run:1295, SpringApplication (org.springframework.boot)
main:13, MybatisApplication (me.yi.hong.mybatis)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
run:50, RestartLauncher (org.springframework.boot.devtools.restart)

```
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230904235842.png)

通过 
```java
    if (acceptAllInterfaces) {
      // default include filter that accepts all classes
      addIncludeFilter((metadataReader, metadataReaderFactory) -> true);
    }

    // exclude package-info.java
    addExcludeFilter((metadataReader, metadataReaderFactory) -> {
      String className = metadataReader.getClassMetadata().getClassName();
      return className.endsWith("package-info");
    });
```



### mybatis 如何将 mapper 等配置加载到 spring 容器中

通过 MapperFactoryBean 创建 Mapper

```java
@Override
  public T getObject() throws Exception {
    return getSqlSession().getMapper(this.mapperInterface);
  }
```


### SqlSessionTemplate 如何保证线程安全

归根结底 ThreadLocal 通过每一个线程跟一个 SQLsession 进行绑定来解决线程安全的问题
[Mybatis-Spring：SqlSessionTemplate](https://www.jianshu.com/p/dfd07cb91c8f)


```java

public static SqlSession getSqlSession(SqlSessionFactory sessionFactory, ExecutorType executorType,
      PersistenceExceptionTranslator exceptionTranslator) {

    notNull(sessionFactory, NO_SQL_SESSION_FACTORY_SPECIFIED);
    notNull(executorType, NO_EXECUTOR_TYPE_SPECIFIED);

    SqlSessionHolder holder = (SqlSessionHolder) TransactionSynchronizationManager.getResource(sessionFactory);

    SqlSession session = sessionHolder(executorType, holder);
    if (session != null) {
      return session;
    }

    LOGGER.debug(() -> "Creating a new SqlSession");
    session = sessionFactory.openSession(executorType);

    registerSessionHolder(sessionFactory, executorType, exceptionTranslator, session);

    return session;
  }

  @Nullable
	public static Object getResource(Object key) {
		Object actualKey = TransactionSynchronizationUtils.unwrapResourceIfNecessary(key);
		return doGetResource(actualKey);
	}

	/**
	 * Actually check the value of the resource that is bound for the given key.
	 */
	@Nullable
	private static Object doGetResource(Object actualKey) {
		Map<Object, Object> map = resources.get();
		if (map == null) {
			return null;
		}
		Object value = map.get(actualKey);
		// Transparently remove ResourceHolder that was marked as void...
		if (value instanceof ResourceHolder resourceHolder && resourceHolder.isVoid()) {
			map.remove(actualKey);
			// Remove entire ThreadLocal if empty...
			if (map.isEmpty()) {
				resources.remove();
			}
			value = null;
		}
		return value;
	}

  private static final ThreadLocal<Map<Object, Object>> resources =
			new NamedThreadLocal<>("Transactional resources");
```

## mapper 的一生
### mapper 是如何被创建出来的
FactoryBean getObject 获取对象
mapperInterface 才是我们真正的类型
```java
public class MapperFactoryBean<T> extends SqlSessionDaoSupport implements FactoryBean<T> {

@Override
  public T getObject() throws Exception {
    return getSqlSession().getMapper(this.mapperInterface);
  }
  public SqlSession getSqlSession() {
    return this.sqlSessionTemplate;
  }
  private SqlSessionTemplate sqlSessionTemplate;
  }
```

SqlSessionTemplate

```java
@Override
  public <T> T getMapper(Class<T> type) {
    return getConfiguration().getMapper(type, this);
  }
```

Configuration

```java
public <T> T getMapper(Class<T> type, SqlSession sqlSession) {
    return mapperRegistry.getMapper(type, sqlSession);
  }
```

MapperRegistry
```java
public <T> T getMapper(Class<T> type, SqlSession sqlSession) {
    final MapperProxyFactory<T> mapperProxyFactory = (MapperProxyFactory<T>) knownMappers.get(type);
    if (mapperProxyFactory == null) {
      throw new BindingException("Type " + type + " is not known to the MapperRegistry.");
    }
    try {
      return mapperProxyFactory.newInstance(sqlSession);
    } catch (Exception e) {
      throw new BindingException("Error getting mapper instance. Cause: " + e, e);
    }
  }
```
MapperProxyFactory

```java
public class MapperProxyFactory<T> {

  private final Class<T> mapperInterface;
  private final Map<Method, MapperMethodInvoker> methodCache = new ConcurrentHashMap<>();

  public MapperProxyFactory(Class<T> mapperInterface) {
    this.mapperInterface = mapperInterface;
  }

  public Class<T> getMapperInterface() {
    return mapperInterface;
  }

  public Map<Method, MapperMethodInvoker> getMethodCache() {
    return methodCache;
  }

  @SuppressWarnings("unchecked")
  protected T newInstance(MapperProxy<T> mapperProxy) {
    return (T) Proxy.newProxyInstance(mapperInterface.getClassLoader(), new Class[] { mapperInterface }, mapperProxy);
  }

  public T newInstance(SqlSession sqlSession) {
    final MapperProxy<T> mapperProxy = new MapperProxy<>(sqlSession, mapperInterface, methodCache);
    return newInstance(mapperProxy);
  }

}
```

最终得到一个代理对象, 通过 MapperProxy 进行代理

### 接口又是如何查询的

#### 如何通过动态代理创建我们的 crud 操作
当我们从 spring 中获取到 mapper 后, 
调用对应的方法查询数据库的时候

其实是调用到了 代理的方法

```java
public class MapperProxy<T> implements InvocationHandler, Serializable {
@Override
  public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
    try {
      if (Object.class.equals(method.getDeclaringClass())) {
        return method.invoke(this, args);
      }
      return cachedInvoker(method).invoke(proxy, method, args, sqlSession);
    } catch (Throwable t) {
      throw ExceptionUtil.unwrapThrowable(t);
    }
  }

  private MapperMethodInvoker cachedInvoker(Method method) throws Throwable {
    try {
      return MapUtil.computeIfAbsent(methodCache, method, m -> {
        if (!m.isDefault()) {
          return new PlainMethodInvoker(new MapperMethod(mapperInterface, method, sqlSession.getConfiguration()));
        }
}}}}

interface MapperMethodInvoker {
    Object invoke(Object proxy, Method method, Object[] args, SqlSession sqlSession) throws Throwable;
  }

  private static class PlainMethodInvoker implements MapperMethodInvoker {
    private final MapperMethod mapperMethod;

    public PlainMethodInvoker(MapperMethod mapperMethod) {
      this.mapperMethod = mapperMethod;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args, SqlSession sqlSession) throws Throwable {
      return mapperMethod.execute(sqlSession, args);
    }
  }
```

#### 代理是如何帮我们跟 SQL 关联查询数据库的

最终还是执行到了 我们熟悉 的 Connnection

从下往上看的话, 
从 MapperMethod 一步一步 调用 最后 mybatis 还是帮我们封装好了 一个 对应的 

```log
prepareStatement:89, SimpleExecutor (org.apache.ibatis.executor)
doQuery:64, SimpleExecutor (org.apache.ibatis.executor)
queryFromDatabase:333, BaseExecutor (org.apache.ibatis.executor)
query:158, BaseExecutor (org.apache.ibatis.executor)
query:110, CachingExecutor (org.apache.ibatis.executor)
query:90, CachingExecutor (org.apache.ibatis.executor)
selectList:154, DefaultSqlSession (org.apache.ibatis.session.defaults)
selectList:147, DefaultSqlSession (org.apache.ibatis.session.defaults)
selectList:142, DefaultSqlSession (org.apache.ibatis.session.defaults)
invoke0:-1, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:77, NativeMethodAccessorImpl (jdk.internal.reflect)
invoke:43, DelegatingMethodAccessorImpl (jdk.internal.reflect)
invoke:568, Method (java.lang.reflect)
invoke:425, SqlSessionTemplate$SqlSessionInterceptor (org.mybatis.spring)
selectList:-1, $Proxy52 (jdk.proxy2)
selectList:224, SqlSessionTemplate (org.mybatis.spring)
executeForMany:147, MapperMethod (org.apache.ibatis.binding)
execute:80, MapperMethod (org.apache.ibatis.binding)
```

最终得到的
statement

```java
private Statement prepareStatement(StatementHandler handler, Log statementLog) throws SQLException {
    Statement stmt;
    Connection connection = getConnection(statementLog);
    stmt = handler.prepare(connection, transaction.getTimeout());
    handler.parameterize(stmt);
    return stmt;
  }
```


#### 如何关联数据库 database 以及 spring 事务
org.apache.ibatis.session.defaults.DefaultSqlSessionFactory#openSessionFromDataSource

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/idea64_pnDgZWl9nY.png)
```java

private SqlSession openSessionFromDataSource(ExecutorType execType, TransactionIsolationLevel level,
      boolean autoCommit) {
    Transaction tx = null;
    try {
      final Environment environment = configuration.getEnvironment();
      final TransactionFactory transactionFactory = getTransactionFactoryFromEnvironment(environment);
      tx = transactionFactory.newTransaction(environment.getDataSource(), level, autoCommit);
      final Executor executor = configuration.newExecutor(tx, execType);
      return new DefaultSqlSession(configuration, executor, autoCommit);
    } catch (Exception e) {
      closeTransaction(tx); // may have fetched a connection so lets call close()
      throw ExceptionFactory.wrapException("Error opening session.  Cause: " + e, e);
    } finally {
      ErrorContext.instance().reset();
    }
  }
``` 

关联 spring 事务

```java

public class SpringManagedTransactionFactory implements TransactionFactory {

  /**
   * {@inheritDoc}
   */
  @Override
  public Transaction newTransaction(DataSource dataSource, TransactionIsolationLevel level, boolean autoCommit) {
    return new SpringManagedTransaction(dataSource);
  }
  }
```


## 懒加载又是如何实现的

## 一二级缓存实现
[你凭什么说Spring会导致MyBatis的一级缓存失效！](https://cloud.tencent.com/developer/article/1697591)
上面这个博主说的还是有点小问题, 因为开启事务之后还是会把 SQLsession 关闭
无法实现一个 sqlsession 了呢

https://blog.csdn.net/qq_40399646/article/details/127934996

默认情况下 缓存是会失效的
```java
System.out.println(mapper.findById("1"));
        System.out.println(mapper.findById("1"));
```

运行过后的日志

```java
Java HotSpot(TM) 64-Bit Server VM warning: Sharing is only supported for boot loader classes because bootstrap classpath has been appended
Creating a new SqlSession
SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@d2708a7] was not registered for synchronization because synchronization is not active
2023-10-28T09:32:53.931+08:00  INFO 20224 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
2023-10-28T09:32:54.204+08:00  INFO 20224 --- [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection org.sqlite.jdbc4.JDBC4Connection@7841bd30
2023-10-28T09:32:54.206+08:00  INFO 20224 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
JDBC Connection [HikariProxyConnection@957559364 wrapping org.sqlite.jdbc4.JDBC4Connection@7841bd30] will not be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Closing non transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@d2708a7]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}
Creating a new SqlSession
SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@7d25913] was not registered for synchronization because synchronization is not active
JDBC Connection [HikariProxyConnection@202696101 wrapping org.sqlite.jdbc4.JDBC4Connection@7841bd30] will not be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Closing non transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@7d25913]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}

```


使用 service 调用 mapper 的查找
```java
System.out.println(service.findCompany("1"));
        System.out.println(service.findCompany("1"));
```

运行后
```log
Java HotSpot(TM) 64-Bit Server VM warning: Sharing is only supported for boot loader classes because bootstrap classpath has been appended
Creating a new SqlSession
SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@538a2f0e] was not registered for synchronization because synchronization is not active
2023-10-28T09:35:33.007+08:00  INFO 18592 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
2023-10-28T09:35:33.136+08:00  INFO 18592 --- [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection org.sqlite.jdbc4.JDBC4Connection@1c6a0103
2023-10-28T09:35:33.138+08:00  INFO 18592 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
JDBC Connection [HikariProxyConnection@2124688514 wrapping org.sqlite.jdbc4.JDBC4Connection@1c6a0103] will not be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Closing non transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@538a2f0e]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}
Creating a new SqlSession
SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@103c97ff] was not registered for synchronization because synchronization is not active
JDBC Connection [HikariProxyConnection@131225875 wrapping org.sqlite.jdbc4.JDBC4Connection@1c6a0103] will not be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Closing non transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@103c97ff]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}

```


在 service 的方法加上了 @Transaction 后

得到日志如下

```java
Java HotSpot(TM) 64-Bit Server VM warning: Sharing is only supported for boot loader classes because bootstrap classpath has been appended
2023-10-28T10:01:44.082+08:00  INFO 19808 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
2023-10-28T10:01:44.226+08:00  INFO 19808 --- [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection org.sqlite.jdbc4.JDBC4Connection@477523ba
2023-10-28T10:01:44.228+08:00  INFO 19808 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
Creating a new SqlSession
Registering transaction synchronization for SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@289f15e9]
JDBC Connection [HikariProxyConnection@535361000 wrapping org.sqlite.jdbc4.JDBC4Connection@477523ba] will be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Releasing transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@289f15e9]
2023-10-28T10:21:20.234+08:00  WARN 19808 --- [l-1 housekeeper] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Thread starvation or clock leap detected (housekeeper delta=20m6s6ms604µs800ns).
Transaction synchronization committing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@289f15e9]
Transaction synchronization deregistering SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@289f15e9]
Transaction synchronization closing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@289f15e9]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}
Creating a new SqlSession
Registering transaction synchronization for SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
JDBC Connection [HikariProxyConnection@229483317 wrapping org.sqlite.jdbc4.JDBC4Connection@477523ba] will be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Releasing transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
Transaction synchronization committing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
Transaction synchronization deregistering SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
Transaction synchronization closing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}
Creating a new SqlSession
Registering transaction synchronization for SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@716f94c1]
JDBC Connection [HikariProxyConnection@1879644274 wrapping org.sqlite.jdbc4.JDBC4Connection@477523ba] will be managed by Spring
==>  Preparing: select * from company where id = ?
==> Parameters: 1(String)
<==    Columns: ID, NAME, AGE, ADDRESS, SALARY
<==        Row: 1, Paul, 32, California, 20000.0
<==      Total: 1
Releasing transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@716f94c1]
Transaction synchronization committing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@716f94c1]
Transaction synchronization deregistering SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@716f94c1]
Transaction synchronization closing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@716f94c1]
Company{id=1, name='Paul', age='32', address='California', salary='20000.0'}

```

关键是这几行日志

> Releasing transactional SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
> Transaction synchronization committing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
> Transaction synchronization deregistering SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]
> Transaction synchronization closing SqlSession [org.apache.ibatis.session.defaults.DefaultSqlSession@61a87366]

通过  Transaction synchronization committing 搜索日志发现
事务管理器会帮助我们把 session 给关了
下一次还是创建新的 sqlsession
所以 一级缓存其实是没有的


从堆栈来看是 进入了 transaction aop 的代理类中
然后帮我们关闭了 SQLsession

```log
beforeCommit:288, SqlSessionUtils$SqlSessionSynchronization (org.mybatis.spring)
triggerBeforeCommit:97, TransactionSynchronizationUtils (org.springframework.transaction.support)
triggerBeforeCommit:916, AbstractPlatformTransactionManager (org.springframework.transaction.support)
processCommit:727, AbstractPlatformTransactionManager (org.springframework.transaction.support)
commit:711, AbstractPlatformTransactionManager (org.springframework.transaction.support)
commitTransactionAfterReturning:660, TransactionAspectSupport (org.springframework.transaction.interceptor)
invokeWithinTransaction:410, TransactionAspectSupport (org.springframework.transaction.interceptor)
invoke:119, TransactionInterceptor (org.springframework.transaction.interceptor)
proceed:184, ReflectiveMethodInvocation (org.springframework.aop.framework)
proceed:756, CglibAopProxy$CglibMethodInvocation (org.springframework.aop.framework)
intercept:708, CglibAopProxy$DynamicAdvisedInterceptor (org.springframework.aop.framework)
findCompany:-1, CompanyService$$SpringCGLIB$$0 (me.yi.hong.mybatis.service)
contextLoads:29, MybatisApplicationTests (me.yi.hong.mybatis)
```

## 如何寻找日志

在 org.apache.ibatis.logging.LogFactory 中

```java
static {
    tryImplementation(LogFactory::useSlf4jLogging);
    tryImplementation(LogFactory::useCommonsLogging);
    tryImplementation(LogFactory::useLog4J2Logging);
    tryImplementation(LogFactory::useLog4JLogging);
    tryImplementation(LogFactory::useJdkLogging);
    tryImplementation(LogFactory::useNoLogging);
  }
private static void tryImplementation(Runnable runnable) {
    if (logConstructor == null) {
      try {
        runnable.run();
      } catch (Throwable t) {
        // ignore
      }
    }
  }

  public static synchronized void useSlf4jLogging() {
    setImplementation(org.apache.ibatis.logging.slf4j.Slf4jImpl.class);
  }
```

### 如何开启 mybatis 日志
[mybatis-日志](https://mybatis.org/mybatis-3/zh/logging.html)

因为 mybatis 会优先使用 slf4j 的日志
所以我们可以配置 slf4j 的日志进行日志的配置 
> 你可以对包、映射类的全限定名、命名空间或全限定语句名开启日志功能来查看 MyBatis 的日志语句。

再次说明下，具体怎么做，由使用的日志工具决定，这里以 SLF4J(Logback) 为例。配置日志功能非常简单：添加一个或多个配置文件（如 logback.xml），有时需要添加 jar 包。下面的例子将使用 SLF4J(Logback) 来配置完整的日志服务，共两个步骤：

步骤 1：添加 SLF4J + Logback 的 jar 包 
因为我们使用的是 SLF4J(Logback)，就要确保它的 jar 包在应用中是可用的。要启用 SLF4J(Logback)，只要将 jar 包添加到应用的类路径中即可。SLF4J(Logback) 的 jar 包可以在上面的链接中下载。

对于 web 应用或企业级应用，则需要将 logback-classic.jar, logback-core.jar and slf4j-api.jar 添加到 WEB-INF/lib 目录下；对于独立应用，可以将它添加到JVM 的 -classpath 启动参数中。

如果你使用 maven, 你可以通过在 pom.xml 中添加下面的依赖来下载 jar 文件。

<dependency>
  <groupId>ch.qos.logback</groupId>
  <artifactId>logback-classic</artifactId>
  <version>1.x.x</version>
</dependency>
步骤 2：配置 Logback 
配置 Logback 比较简单，假如你需要记录这个映射器接口的日志：

package org.mybatis.example;
public interface BlogMapper {
  @Select("SELECT * FROM blog WHERE id = #{id}")
  Blog selectBlog(int id);
}
在应用的类路径中创建一个名称为 logback.xml 的文件，文件的具体内容如下：

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration>
<configuration>

  <appender name="stdout" class="ch.qos.logback.core.ConsoleAppender">
    <encoder>
      <pattern>%5level [%thread] - %msg%n</pattern>
    </encoder>
  </appender>

  <logger name="org.mybatis.example.BlogMapper">
    <level value="trace"/>
  </logger>
  <root level="error">
    <appender-ref ref="stdout"/>
  </root>

</configuration>
添加以上配置后，SLF4J(Logback) 就会记录 org.mybatis.example.BlogMapper 的详细执行操作，且仅记录应用中其它类的错误信息（若有）。

你也可以将日志的记录方式从接口级别切换到语句级别，从而实现更细粒度的控制。如下配置只对 selectBlog 语句记录日志：

<logger name="org.mybatis.example.BlogMapper.selectBlog">
  <level value="trace"/>
</logger>
与此相对，可以对一组映射器接口记录日志，只要对映射器接口所在的包开启日志功能即可：

<logger name="org.mybatis.example">
  <level value="trace"/>
</logger>
某些查询可能会返回庞大的结果集，此时只想记录其执行的 SQL 语句而不想记录结果该怎么办？为此，Mybatis 中 SQL 语句的日志级别被设为DEBUG（JDK 日志设为 FINE），结果的日志级别为 TRACE（JDK 日志设为 FINER)。所以，只要将日志级别调整为 DEBUG 即可达到目的：

<logger name="org.mybatis.example">
  <level value="debug"/>
</logger>
要记录日志的是类似下面的映射器文件而不是映射器接口又该怎么做呢？

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "https://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="org.mybatis.example.BlogMapper">
  <select id="selectBlog" resultType="Blog">
    select * from Blog where id = #{id}
  </select>
</mapper>
如需对 XML 文件记录日志，只要对命名空间增加日志记录功能即可：

<logger name="org.mybatis.example.BlogMapper">
  <level value="trace"/>
</logger>
要记录具体语句的日志可以这样做：

<logger name="org.mybatis.example.BlogMapper.selectBlog">
  <level value="trace"/>
</logger>

mybatis
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl 

这是因为 debug 方法就直接输出了 , 并没有做什么判断
```java
/*
 *    Copyright 2009-2022 the original author or authors.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *       https://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.apache.ibatis.logging.stdout;

import org.apache.ibatis.logging.Log;

/**
 * @author Clinton Begin
 */
public class StdOutImpl implements Log {

  public StdOutImpl(String clazz) {
    // Do Nothing
  }

  @Override
  public boolean isDebugEnabled() {
    return true;
  }

  @Override
  public boolean isTraceEnabled() {
    return true;
  }

  @Override
  public void error(String s, Throwable e) {
    System.err.println(s);
    e.printStackTrace(System.err);
  }

  @Override
  public void error(String s) {
    System.err.println(s);
  }

  @Override
  public void debug(String s) {
    System.out.println(s);
  }

  @Override
  public void trace(String s) {
    System.out.println(s);
  }

  @Override
  public void warn(String s) {
    System.out.println(s);
  }
}

```




## 参考
[MyBatis 执行原理，源码解读，基于SpringBoot讲解](https://www.bilibili.com/video/BV1sP4y1o7kB/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)
[MyBatis 执行原理，源码解读，基于SpringBoot讲解](https://blog.csdn.net/Tomwildboar/article/details/126908578)
