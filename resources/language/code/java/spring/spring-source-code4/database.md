# spring 源码分析

## database 源码分析

## 思路一 配置文件入手

从 application.yaml url Ctrl 左键 点击过去

```yaml
spring:
  datasource:
    url: jdbc:sqlite:E:/github/demo/mybatis/db/db.sqlite
    driver-class-name: org.sqlite.JDBC

```

DataSourceProperties 你会得到一个
鼠标左键点击 直接获取 引用 该类的
看到有一个

```java
@AutoConfiguration(before = SqlInitializationAutoConfiguration.class)
@ConditionalOnClass({ DataSource.class, EmbeddedDatabaseType.class })
@ConditionalOnMissingBean(type = "io.r2dbc.spi.ConnectionFactory")
@EnableConfigurationProperties(DataSourceProperties.class)
@Import(DataSourcePoolMetadataProvidersConfiguration.class)
public class DataSourceAutoConfiguration {

    @Configuration(proxyBeanMethods = false)
    @Conditional(EmbeddedDatabaseCondition.class)
    @ConditionalOnMissingBean({ DataSource.class, XADataSource.class })
    @Import(EmbeddedDataSourceConfiguration.class)
    protected static class EmbeddedDatabaseConfiguration {

    }

    @Configuration(proxyBeanMethods = false)
    @Conditional(PooledDataSourceCondition.class)
    @ConditionalOnMissingBean({ DataSource.class, XADataSource.class })
    @Import({ DataSourceConfiguration.Hikari.class, DataSourceConfiguration.Tomcat.class,
            DataSourceConfiguration.Dbcp2.class, DataSourceConfiguration.OracleUcp.class,
            DataSourceConfiguration.Generic.class, DataSourceJmxConfiguration.class })
    protected static class PooledDataSourceConfiguration {

```

DataSourceConfiguration.Hikari

```java
@Configuration(proxyBeanMethods = false)
    @ConditionalOnClass(HikariDataSource.class)
    @ConditionalOnMissingBean(DataSource.class)
    @ConditionalOnProperty(name = "spring.datasource.type", havingValue = "com.zaxxer.hikari.HikariDataSource",
            matchIfMissing = true)
    static class Hikari {

        @Bean
        static HikariJdbcConnectionDetailsBeanPostProcessor jdbcConnectionDetailsHikariBeanPostProcessor(
                ObjectProvider<JdbcConnectionDetails> connectionDetailsProvider) {
            return new HikariJdbcConnectionDetailsBeanPostProcessor(connectionDetailsProvider);
        }

        @Bean
        @ConfigurationProperties(prefix = "spring.datasource.hikari")
        HikariDataSource dataSource(DataSourceProperties properties, JdbcConnectionDetails connectionDetails) {
            HikariDataSource dataSource = createDataSource(connectionDetails, HikariDataSource.class,
                    properties.getClassLoader());
            if (StringUtils.hasText(properties.getName())) {
                dataSource.setPoolName(properties.getName());
            }
            return dataSource;
        }

    }
```

## 思路二 从 context 中 获取对应的 dataSource 类型, 然后还是

寻找到 对应的配置类
也可以先 从 beanFactory/applicationContext 中获取到对应的 datasource
先了解是哪一个数据源,
通过打断点之后就可以知道是
HikariDataSource

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/Code_1hHaXRmFGP.png)

## 思路三 直接在 spring.factory 那里找 jdbc 相关的自动配置类

org.springframework.boot.autoconfigure.AutoConfiguration.imports
我们也可

```bash
org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration
org.springframework.boot.autoconfigure.jdbc.JdbcTemplateAutoConfiguration
org.springframework.boot.autoconfigure.jdbc.JndiDataSourceAutoConfiguration
org.springframework.boot.autoconfigure.jdbc.XADataSourceAutoConfiguration
org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration
```

## 事务

```java
@AutoConfiguration(before = TransactionAutoConfiguration.class)
@ConditionalOnClass({ JdbcTemplate.class, TransactionManager.class })
@AutoConfigureOrder(Ordered.LOWEST_PRECEDENCE)
@EnableConfigurationProperties(DataSourceProperties.class)
public class DataSourceTransactionManagerAutoConfiguration {

    @Configuration(proxyBeanMethods = false)
    @ConditionalOnSingleCandidate(DataSource.class)
    static class JdbcTransactionManagerConfiguration {

        @Bean
        @ConditionalOnMissingBean(TransactionManager.class)
        DataSourceTransactionManager transactionManager(Environment environment, DataSource dataSource,
                ObjectProvider<TransactionManagerCustomizers> transactionManagerCustomizers) {
            DataSourceTransactionManager transactionManager = createTransactionManager(environment, dataSource);
            transactionManagerCustomizers.ifAvailable((customizers) -> customizers.customize(transactionManager));
            return transactionManager;
        }

        private DataSourceTransactionManager createTransactionManager(Environment environment, DataSource dataSource) {
            return environment.getProperty("spring.dao.exceptiontranslation.enabled", Boolean.class, Boolean.TRUE)
                    ? new JdbcTransactionManager(dataSource) : new DataSourceTransactionManager(dataSource);
        }

    }

}
```

## @Transactional 原理

### 如何扫描到 @Transactional 相关的 类

思路
通过在 @Transactional 点击得到 一个 解析的
直接打上断点

```java
public class SpringTransactionAnnotationParser implements TransactionAnnotationParser, Serializable {

    @Override
    public boolean isCandidateClass(Class<?> targetClass) {
        return AnnotationUtils.isCandidateClass(targetClass, Transactional.class);
    }
```

断点表达式安排上 

CompanyService.class == targetClass

在堆栈查看是如何扫描到我们这个 @Transactional 的类

在堆栈中你会发现创建过程与 aop 流程是那么的相似

org.springframework.aop.framework.autoproxy.BeanFactoryAdvisorRetrievalHelper#findAdvisorBeans

这里你会看到一个增强

org.springframework.transaction.config.internalTransactionAdvisor

通过 this.beanFactory.getBean("org.springframework.transaction.config.internalTransactionAdvisor") 你会发现

来自

```java

@Configuration(proxyBeanMethods = false)
@Role(BeanDefinition.ROLE_INFRASTRUCTURE)
@ImportRuntimeHints(TransactionRuntimeHints.class)
public class ProxyTransactionManagementConfiguration extends AbstractTransactionManagementConfiguration {

    @Bean(name = TransactionManagementConfigUtils.TRANSACTION_ADVISOR_BEAN_NAME)
    @Role(BeanDefinition.ROLE_INFRASTRUCTURE)
    public BeanFactoryTransactionAttributeSourceAdvisor transactionAdvisor(
            TransactionAttributeSource transactionAttributeSource, TransactionInterceptor transactionInterceptor) {

        BeanFactoryTransactionAttributeSourceAdvisor advisor = new BeanFactoryTransactionAttributeSourceAdvisor();
        advisor.setTransactionAttributeSource(transactionAttributeSource);
        advisor.setAdvice(transactionInterceptor);
        if (this.enableTx != null) {
            advisor.setOrder(this.enableTx.<Integer>getNumber("order"));
        }
        return advisor;
    }
```

### 如何加事务的功能加入到我们的 方法中

通过 aop 代理

org.springframework.aop.framework.DefaultAopProxyFactory#createAopProxy

```java

@Override
    public AopProxy createAopProxy(AdvisedSupport config) throws AopConfigException {
        if (config.isOptimize() || config.isProxyTargetClass() || hasNoUserSuppliedProxyInterfaces(config)) {
            Class<?> targetClass = config.getTargetClass();
            if (targetClass == null) {
                throw new AopConfigException("TargetSource cannot determine target class: " +
                        "Either an interface or a target is required for proxy creation.");
            }
            if (targetClass.isInterface() || Proxy.isProxyClass(targetClass) || ClassUtils.isLambdaClass(targetClass)) {
                return new JdkDynamicAopProxy(config);
            }
            return new ObjenesisCglibAopProxy(config);
        }
        else {
            return new JdkDynamicAopProxy(config);
        }
    }
```

在 config 中可以看到用到了 TransactionInterceptor

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/Ny7SDafnXF.png)

org.springframework.transaction.interceptor.TransactionAspectSupport#determineTransactionManager

一开始没有设置 TransactionManager 为 null

通过 在 beanFactory 中 getBean

```java
@Nullable
    protected TransactionManager determineTransactionManager(@Nullable TransactionAttribute txAttr) {
        // Do not attempt to lookup tx manager if no tx attributes are set
        if (txAttr == null || this.beanFactory == null) {
            return getTransactionManager();
        }

        String qualifier = txAttr.getQualifier();
        if (StringUtils.hasText(qualifier)) {
            return determineQualifiedTransactionManager(this.beanFactory, qualifier);
        }
        else if (StringUtils.hasText(this.transactionManagerBeanName)) {
            return determineQualifiedTransactionManager(this.beanFactory, this.transactionManagerBeanName);
        }
        else {
            TransactionManager defaultTransactionManager = getTransactionManager();
            if (defaultTransactionManager == null) {
                defaultTransactionManager = this.transactionManagerCache.get(DEFAULT_TRANSACTION_MANAGER_KEY);
                if (defaultTransactionManager == null) {
                    defaultTransactionManager = this.beanFactory.getBean(TransactionManager.class);
                    this.transactionManagerCache.putIfAbsent(
                            DEFAULT_TRANSACTION_MANAGER_KEY, defaultTransactionManager);
                }
            }
            return defaultTransactionManager;
        }
```

#### 在代理中如何使用事务

org.springframework.transaction.interceptor.TransactionAspectSupport#invokeWithinTransaction

```java
@Nullable
    protected Object invokeWithinTransaction(Method method, @Nullable Class<?> targetClass,
            final InvocationCallback invocation) throws Throwable {

        // If the transaction attribute is null, the method is non-transactional.
        TransactionAttributeSource tas = getTransactionAttributeSource();
        final TransactionAttribute txAttr = (tas != null ? tas.getTransactionAttribute(method, targetClass) : null);
        final TransactionManager tm = determineTransactionManager(txAttr);


        PlatformTransactionManager ptm = asPlatformTransactionManager(tm);
        final String joinpointIdentification = methodIdentification(method, targetClass, txAttr);

        if (txAttr == null || !(ptm instanceof CallbackPreferringPlatformTransactionManager cpptm)) {
            // Standard transaction demarcation with getTransaction and commit/rollback calls.
            TransactionInfo txInfo = createTransactionIfNecessary(ptm, txAttr, joinpointIdentification);

            Object retVal;
            try {
                // This is an around advice: Invoke the next interceptor in the chain.
                // This will normally result in a target object being invoked.
                retVal = invocation.proceedWithInvocation();
            }
            catch (Throwable ex) {
                // target invocation exception
                completeTransactionAfterThrowing(txInfo, ex);
                throw ex;
            }
            finally {
                cleanupTransactionInfo(txInfo);
            }

            if (retVal != null && vavrPresent && VavrDelegate.isVavrTry(retVal)) {
                // Set rollback-only in case of Vavr failure matching our rollback rules...
                TransactionStatus status = txInfo.getTransactionStatus();
                if (status != null && txAttr != null) {
                    retVal = VavrDelegate.evaluateTryFailure(retVal, txAttr, status);
                }
            }
// 提交 事务
            commitTransactionAfterReturning(txInfo);
            return retVal;
        }
```

# ![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/idea64_FT2uI5U1DZ.png)

### 事务增强的大概流程

很多事情其实断点就可以帮我们做到了, 

debug 调试真是一个好东西

事务用到的切点:

TransactionAttributeSourcePointcut

用到的增强:

BeanFactoryTransactionAttributeSourceAdvisor



我说呢?

原来是进入到了 aop 的流程了...

在 PostProcessor 中 对我们的 Transactional 修饰的功能进行增强

org.springframework.aop.framework.autoproxy.InfrastructureAdvisorAutoProxyCreator

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/MarkText_MGtjnJIT2x.png)



```java
protected Object wrapIfNecessary(Object bean, String beanName, Object cacheKey) {
		if (StringUtils.hasLength(beanName) && this.targetSourcedBeans.contains(beanName)) {
			return bean;
		}
		if (Boolean.FALSE.equals(this.advisedBeans.get(cacheKey))) {
			return bean;
		}
		if (isInfrastructureClass(bean.getClass()) || shouldSkip(bean.getClass(), beanName)) {
			this.advisedBeans.put(cacheKey, Boolean.FALSE);
			return bean;
		}

		// Create proxy if we have advice.
		Object[] specificInterceptors = getAdvicesAndAdvisorsForBean(bean.getClass(), beanName, null);
		if (specificInterceptors != DO_NOT_PROXY) {
			this.advisedBeans.put(cacheKey, Boolean.TRUE);
			Object proxy = createProxy(
					bean.getClass(), beanName, specificInterceptors, new SingletonTargetSource(bean));
			this.proxyTypes.put(cacheKey, proxy.getClass());
			return proxy;
		}

		this.advisedBeans.put(cacheKey, Boolean.FALSE);
		return bean;
	}
```

> 扫描到对应的 类的时候会帮助我们使用 
> 
> getAdvicesAndAdvisorsForBean 获取对应的增强类进行增强
> 
> 然后使用 ProxyFactory 工厂帮我们把我们的 代理创建出来



### 事务中直接在本类中直接调用方法, 会失效的根本原因是什么?

终究还是代理犯了错

代理使用了组合对原来的被代理的类进行增强

也就是在 被代理的类中进行调用的话, 调用的还是被代理自己类的方法

没用代理过的类进行调用, 是不会增强的

因为事务也是通过 aop 进行代理增强来 获取事务

从而得到一个事务增强的功能

[java 的三种代理模式 (二）——子函数切面_mb5ff2f2ed7d163的技术博客_51CTO博客](https://blog.51cto.com/u_15075520/4517066)