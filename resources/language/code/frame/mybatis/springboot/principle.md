# springboot 结合 mybatis 原理

## 问题

- [ ] 如果不配置数据源会怎么样
- [ ] mybatis 自动配置/装载做了什么
- [ ] @MapperScan 做了什么
  - [ ] mybatis 如何将 mapper 等配置加载到 spring 容器中
- [ ] 接口又是如何查询的
  - [ ] 如何通过动态代理创建我们的 crud 操作
- [ ] 懒加载又是如何实现的

## 如果不配置数据源会怎么样

## mybatis 自动配置/装载做了什么

## @MapperScan 做了什么

扫描我们配置的 basePackage

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





### mybatis 如何将 mapper 等配置加载到 spring 容器中

## 接口又是如何查询的

### 如何通过动态代理创建我们的 crud 操作

## 懒加载又是如何实现的