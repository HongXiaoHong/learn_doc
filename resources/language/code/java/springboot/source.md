# springboot 源码分析

[138-第卅九讲-boot执行流程-小结](https://www.bilibili.com/video/BV1P44y1N7QG/?p=139&spm_id_from=pageDriver&vd_source=eabc2c22ae7849c2c4f31815da49f209)


## 自动加载原理
[EnableAutoConfiguration注解的工作原理](https://www.jianshu.com/p/464d04c36fb1)

springboot 2.0 是从 
META-INF/spring.factories 下面进行加载

springboot 3.0 ＋ 不好意思哈, 改了

```java
protected List<String> getCandidateConfigurations(AnnotationMetadata metadata, AnnotationAttributes attributes) {
		List<String> configurations = ImportCandidates.load(AutoConfiguration.class, getBeanClassLoader())
			.getCandidates();
		Assert.notEmpty(configurations,
				"No auto configuration classes found in "
						+ "META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports. If you "
						+ "are using a custom packaging, make sure that file is correct.");
		return configurations;
	}
```

在 META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports 下面了呢

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230912173436.png)

## 核心方法 run

```java
public ConfigurableApplicationContext run(String... args) {
		if (this.registerShutdownHook) {
			SpringApplication.shutdownHook.enableShutdowHookAddition();
		}
		long startTime = System.nanoTime();
		DefaultBootstrapContext bootstrapContext = createBootstrapContext();
		ConfigurableApplicationContext context = null;
		configureHeadlessProperty();
		// 1. 创建启动事件发布器, 这里写着监听器, 其实是用来做事件发布的
		SpringApplicationRunListeners listeners = getRunListeners(args);
		// 1.1 启动事件
		listeners.starting(bootstrapContext, this.mainApplicationClass);
		try {
			// 2. 对 mian 方法进行包装, 提供方法将 --xxx=yyy zzz 这两种不同配置进行区分
			ApplicationArguments applicationArguments = new DefaultApplicationArguments(args);
			// 3. 环境准备, 包括系统属性(java 或者说 jvm 的属性) 系统环境变量(操作系统的环境变量),
			// 3.1. 注册属性命名 小驼峰/下划线分隔/短横线分隔 => 短横线分隔 都可以拿到
			// 3.2. 事件发布: 环境初始化完成事件
			//   3.2.1. 注册资源处理, 加载我们的 application.properties 等配置
			ConfigurableEnvironment environment = prepareEnvironment(listeners, bootstrapContext, applicationArguments);
			// 4. 打印 banner
			// 4.1. 可以通过 banner.txt 或者 spring.banner.location 进行配置
			Banner printedBanner = printBanner(environment);
			// 5. 根据 网络类型 webApplicationType 创建 application-context 容器
			context = createApplicationContext();
			context.setApplicationStartup(this.applicationStartup);
			prepareContext(bootstrapContext, context, environment, listeners, applicationArguments, printedBanner);
			refreshContext(context);
			afterRefresh(context, applicationArguments);
			Duration timeTakenToStartup = Duration.ofNanos(System.nanoTime() - startTime);
			if (this.logStartupInfo) {
				new StartupInfoLogger(this.mainApplicationClass).logStarted(getApplicationLog(), timeTakenToStartup);
			}
			listeners.started(context, timeTakenToStartup);
			callRunners(context, applicationArguments);
		}
		catch (Throwable ex) {
			if (ex instanceof AbandonedRunException) {
				throw ex;
			}
			handleRunFailure(context, ex, listeners);
			throw new IllegalStateException(ex);
		}
		try {
			if (context.isRunning()) {
				Duration timeTakenToReady = Duration.ofNanos(System.nanoTime() - startTime);
				listeners.ready(context, timeTakenToReady);
			}
		}
		catch (Throwable ex) {
			if (ex instanceof AbandonedRunException) {
				throw ex;
			}
			handleRunFailure(context, ex, null);
			throw new IllegalStateException(ex);
		}
		return context;
	}
```

### banner | 图标
[banner 在线生成工具](https://www.bootschool.net/ascii)


我们可以通过配置 spring.banner.location 来配置图标的本地位置
或者是在 resource 路径下配置一个叫 banner.txt 的文件就可以了

org.springframework.boot.SpringApplicationBannerPrinter#getTextBanner

```java
static final String BANNER_LOCATION_PROPERTY = "spring.banner.location";

static final String DEFAULT_BANNER_LOCATION = "banner.txt";

private Banner getTextBanner(Environment environment) {
		String location = environment.getProperty(BANNER_LOCATION_PROPERTY, DEFAULT_BANNER_LOCATION);
		Resource resource = this.resourceLoader.getResource(location);
		try {
			if (resource.exists() && !resource.getURL().toExternalForm().contains("liquibase-core")) {
				return new ResourceBanner(resource);
			}
		}
		catch (IOException ex) {
			// Ignore
		}
		return null;
	}
```



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230921163046.png)

在 resource 目录下放了 一个 banner.txt 文件
也就是下面的 mybatis banner	
结果:

```log

D:\app\code\java\jdk-17.0.6\bin\java.exe -XX:TieredStopAtLevel=1 -Dspring.output.ansi.enabled=always -Dcom.sun.management.jmxremote -Dspring.jmx.enabled=true -Dspring.liveBeansView.mbeanDomain -Dspring.application.admin.enabled=true "-Dmanagement.endpoints.jmx.exposure.include=*" "-javaagent:D:\app\code\idea\202302\IntelliJ IDEA 2023.2.1\lib\idea_rt.jar=12125:D:\app\code\idea\202302\IntelliJ IDEA 2023.2.1\bin" -Dfile.encoding=UTF-8 -classpath E:\github\demo\mybatis\target\classes;D:\app\code\maven\repository\org\springframework\boot\spring-boot-starter\3.1.3\spring-boot-starter-3.1.3.jar;D:\app\code\maven\repository\org\springframework\boot\spring-boot\3.1.3\spring-boot-3.1.3.jar;D:\app\code\maven\repository\org\springframework\spring-context\6.0.11\spring-context-6.0.11.jar;D:\app\code\maven\repository\org\springframework\spring-aop\6.0.11\spring-aop-6.0.11.jar;D:\app\code\maven\repository\org\springframework\spring-beans\6.0.11\spring-beans-6.0.11.jar;D:\app\code\maven\repository\org\springframework\spring-expression\6.0.11\spring-expression-6.0.11.jar;D:\app\code\maven\repository\org\springframework\boot\spring-boot-autoconfigure\3.1.3\spring-boot-autoconfigure-3.1.3.jar;D:\app\code\maven\repository\org\springframework\boot\spring-boot-starter-logging\3.1.3\spring-boot-starter-logging-3.1.3.jar;D:\app\code\maven\repository\ch\qos\logback\logback-classic\1.4.11\logback-classic-1.4.11.jar;D:\app\code\maven\repository\ch\qos\logback\logback-core\1.4.11\logback-core-1.4.11.jar;D:\app\code\maven\repository\org\apache\logging\log4j\log4j-to-slf4j\2.20.0\log4j-to-slf4j-2.20.0.jar;D:\app\code\maven\repository\org\apache\logging\log4j\log4j-api\2.20.0\log4j-api-2.20.0.jar;D:\app\code\maven\repository\org\slf4j\jul-to-slf4j\2.0.7\jul-to-slf4j-2.0.7.jar;D:\app\code\maven\repository\jakarta\annotation\jakarta.annotation-api\2.1.1\jakarta.annotation-api-2.1.1.jar;D:\app\code\maven\repository\org\springframework\spring-core\6.0.11\spring-core-6.0.11.jar;D:\app\code\maven\repository\org\springframework\spring-jcl\6.0.11\spring-jcl-6.0.11.jar;D:\app\code\maven\repository\org\yaml\snakeyaml\1.33\snakeyaml-1.33.jar;D:\app\code\maven\repository\org\mybatis\spring\boot\mybatis-spring-boot-starter\3.0.2\mybatis-spring-boot-starter-3.0.2.jar;D:\app\code\maven\repository\org\springframework\boot\spring-boot-starter-jdbc\3.1.3\spring-boot-starter-jdbc-3.1.3.jar;D:\app\code\maven\repository\com\zaxxer\HikariCP\5.0.1\HikariCP-5.0.1.jar;D:\app\code\maven\repository\org\springframework\spring-jdbc\6.0.11\spring-jdbc-6.0.11.jar;D:\app\code\maven\repository\org\springframework\spring-tx\6.0.11\spring-tx-6.0.11.jar;D:\app\code\maven\repository\org\mybatis\spring\boot\mybatis-spring-boot-autoconfigure\3.0.2\mybatis-spring-boot-autoconfigure-3.0.2.jar;D:\app\code\maven\repository\org\mybatis\mybatis\3.5.13\mybatis-3.5.13.jar;D:\app\code\maven\repository\org\mybatis\mybatis-spring\3.0.2\mybatis-spring-3.0.2.jar;D:\app\code\maven\repository\org\xerial\sqlite-jdbc\3.43.0.0\sqlite-jdbc-3.43.0.0.jar;D:\app\code\maven\repository\org\springframework\boot\spring-boot-devtools\3.1.3\spring-boot-devtools-3.1.3.jar;D:\app\code\maven\repository\org\springframework\boot\spring-boot-configuration-processor\3.1.3\spring-boot-configuration-processor-3.1.3.jar;D:\app\code\maven\repository\org\slf4j\slf4j-api\2.0.7\slf4j-api-2.0.7.jar me.yi.hong.mybatis.MybatisApplication
          _____                _____                    _____                    _____                _____                    _____                    _____          
         /\    \              |\    \                  /\    \                  /\    \              /\    \                  /\    \                  /\    \         
        /::\____\             |:\____\                /::\    \                /::\    \            /::\    \                /::\    \                /::\    \        
       /::::|   |             |::|   |               /::::\    \              /::::\    \           \:::\    \               \:::\    \              /::::\    \       
      /:::::|   |             |::|   |              /::::::\    \            /::::::\    \           \:::\    \               \:::\    \            /::::::\    \      
     /::::::|   |             |::|   |             /:::/\:::\    \          /:::/\:::\    \           \:::\    \               \:::\    \          /:::/\:::\    \     
    /:::/|::|   |             |::|   |            /:::/__\:::\    \        /:::/__\:::\    \           \:::\    \               \:::\    \        /:::/__\:::\    \    
   /:::/ |::|   |             |::|   |           /::::\   \:::\    \      /::::\   \:::\    \          /::::\    \              /::::\    \       \:::\   \:::\    \   
  /:::/  |::|___|______       |::|___|______    /::::::\   \:::\    \    /::::::\   \:::\    \        /::::::\    \    ____    /::::::\    \    ___\:::\   \:::\    \  
 /:::/   |::::::::\    \      /::::::::\    \  /:::/\:::\   \:::\ ___\  /:::/\:::\   \:::\    \      /:::/\:::\    \  /\   \  /:::/\:::\    \  /\   \:::\   \:::\    \ 
/:::/    |:::::::::\____\    /::::::::::\____\/:::/__\:::\   \:::|    |/:::/  \:::\   \:::\____\    /:::/  \:::\____\/::\   \/:::/  \:::\____\/::\   \:::\   \:::\____\
\::/    / ~~~~~/:::/    /   /:::/~~~~/~~      \:::\   \:::\  /:::|____|\::/    \:::\  /:::/    /   /:::/    \::/    /\:::\  /:::/    \::/    /\:::\   \:::\   \::/    /
 \/____/      /:::/    /   /:::/    /          \:::\   \:::\/:::/    /  \/____/ \:::\/:::/    /   /:::/    / \/____/  \:::\/:::/    / \/____/  \:::\   \:::\   \/____/ 
             /:::/    /   /:::/    /            \:::\   \::::::/    /            \::::::/    /   /:::/    /            \::::::/    /            \:::\   \:::\    \     
            /:::/    /   /:::/    /              \:::\   \::::/    /              \::::/    /   /:::/    /              \::::/____/              \:::\   \:::\____\    
           /:::/    /    \::/    /                \:::\  /:::/    /               /:::/    /    \::/    /                \:::\    \               \:::\  /:::/    /    
          /:::/    /      \/____/                  \:::\/:::/    /               /:::/    /      \/____/                  \:::\    \               \:::\/:::/    /     
         /:::/    /                                 \::::::/    /               /:::/    /                                 \:::\    \               \::::::/    /      
        /:::/    /                                   \::::/    /               /:::/    /                                   \:::\____\               \::::/    /       
        \::/    /                                     \::/____/                \::/    /                                     \::/    /                \::/    /        
         \/____/                                       ~~                       \/____/                                       \/____/                  \/____/         

2023-09-21T16:40:32.896+08:00  INFO 3172 --- [  restartedMain] me.yi.hong.mybatis.MybatisApplication    : Starting MybatisApplication using Java 17.0.6 with PID 3172 (E:\github\demo\mybatis\target\classes started by hong in E:\github\demo)
2023-09-21T16:40:32.916+08:00  INFO 3172 --- [  restartedMain] me.yi.hong.mybatis.MybatisApplication    : No active profile set, falling back to 1 default profile: "default"
2023-09-21T16:40:33.027+08:00  INFO 3172 --- [  restartedMain] .e.DevToolsPropertyDefaultsPostProcessor : Devtools property defaults active! Set 'spring.devtools.add-properties' to 'false' to disable
2023-09-21T16:40:35.577+08:00  INFO 3172 --- [  restartedMain] o.s.b.d.a.OptionalLiveReloadServer       : LiveReload server is running on port 35729
2023-09-21T16:40:35.600+08:00  INFO 3172 --- [  restartedMain] me.yi.hong.mybatis.MybatisApplication    : Started MybatisApplication in 3.672 seconds (process running for 8.497)

Process finished with exit code 0

```


### 创建 applicationContext
根据 web 类型创建
- None
- reactive
- servlet


servlet 创建的 context 类型是 AnnotationConfigServletWebServerApplicationContext

![ApplicationContextFactory配置](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230922162409.png)

```java
for (ApplicationContextFactory candidate : SpringFactoriesLoader.loadFactories(ApplicationContextFactory.class,
				getClass().getClassLoader())) {
			T result = action.apply(candidate, webApplicationType);
			if (result != null) {
				return result;
			}
		}

@Override
	public ConfigurableApplicationContext create(WebApplicationType webApplicationType) {
		return (webApplicationType != WebApplicationType.SERVLET) ? null : createContext();
	}

	private ConfigurableApplicationContext createContext() {
		if (!AotDetector.useGeneratedArtifacts()) {
			return new AnnotationConfigServletWebServerApplicationContext();
		}
		return new ServletWebServerApplicationContext();
	}
```

## 类的生命周期

### 创建
#### 依赖
##### AutoWired
在 refresh 的 finishBeanFactoryInitialization 阶段
创建 bean
后置 bean 处理器 AutowiredAnnotationBeanPostProcessor 帮忙, 解决 @AutoWired 注入依赖
其实还有一个 CommonAnnotationBeanPostProcessor 用来处理 @Resource 注解进行注入
```log
lambda$doGetBean$0:326, AbstractBeanFactory (org.springframework.beans.factory.support)
getObject:-1, AbstractBeanFactory$$Lambda$332/0x0000000800dca1d8 (org.springframework.beans.factory.support)
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
getObject:-1, AbstractBeanFactory$$Lambda$332/0x0000000800dca1d8 (org.springframework.beans.factory.support)
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

org.springframework.beans.factory.support.DefaultListableBeanFactory#resolveDependency

```java
@Override
	@Nullable
	public Object resolveDependency(DependencyDescriptor descriptor, @Nullable String requestingBeanName,
			@Nullable Set<String> autowiredBeanNames, @Nullable TypeConverter typeConverter) throws BeansException {

		descriptor.initParameterNameDiscovery(getParameterNameDiscoverer());
		if (Optional.class == descriptor.getDependencyType()) {
			return createOptionalDependency(descriptor, requestingBeanName);
		}
		else if (ObjectFactory.class == descriptor.getDependencyType() ||
				ObjectProvider.class == descriptor.getDependencyType()) {
			return new DependencyObjectProvider(descriptor, requestingBeanName);
		}
		else if (javaxInjectProviderClass == descriptor.getDependencyType()) {
			return new Jsr330Factory().createDependencyProvider(descriptor, requestingBeanName);
		}
		else {
			Object result = getAutowireCandidateResolver().getLazyResolutionProxyIfNecessary(
					descriptor, requestingBeanName);
			if (result == null) {
				result = doResolveDependency(descriptor, requestingBeanName, autowiredBeanNames, typeConverter);
			}
			return result;
		}
	}
```