# spring

原理
todo

- [ ] WebMvcRegistrations 
- [ ] 🍕 spring 创建类 + 生命周期 + 循环依赖

### 循环依赖

[面试必杀技，讲一讲Spring中的循环依赖-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/766880#slide-9)

[【子路聊Java】阿里一面：如何满分回答Spring的循环依赖？_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Ga4y1E7Br/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

spring进行扫描->反射后封装成beanDefinition对象->放入beanDefinitionMap->遍历map->验证（是否单例、是否延迟加载、是否抽象）->推断构造方法->准备开始进行实例->去单例池中查，没有->去二级缓存中找，没有提前暴露->生成一个objectFactory对象暴露到二级缓存中->属性注入，发现依赖Y->此时Y开始它的生命周期直到属性注入，发现依赖X->X又走一遍生命周期，当走到去二级缓存中找的时候找到了->往Y中注入X的objectFactory对象->完成循环依赖。  
1、为什么要使用X的objectFacory对象而不是直接使用X对象？  
利于拓展，程序员可以通过beanPostProcess接口操作objectFactory对象生成自己想要的对象  
2、是不是只能支持单例(scope=singleton)而不支持原型(scope=prototype)？  
是。因为单例是spring在启动时进行bean加载放入单例池中，在依赖的bean开始生命周期后，可以直接从二级缓存中取到它所依赖的bean的objectFactory对象从而结束循环依赖。而原型只有在用到时才会走生命周期流程，但是原型不存在一个已经实例化好的bean，所以会无限的创建->依赖->创建->依赖->...。  
3、循环依赖是不是只支持非构造方法？  
是。类似死锁问题

## 重要注解

### @ControllerAdvice | 增强Controller

[(26条消息) SpringMVC重要注解（二）@ControllerAdvice_Franco蜡笔小强的博客-CSDN博客](https://blog.csdn.net/w372426096/article/details/78429141)

- @ControllerAdvice是一个@Component，用于定义@ExceptionHandler，@InitBinder和@ModelAttribute方法，适用于所有使用@RequestMapping方法。

- Spring4之前，@ControllerAdvice在同一调度的Servlet中协助所有控制器。Spring4已经改变：@ControllerAdvice支持配置控制器的子集，而默认的行为仍然可以利用。

- 在Spring4中， @ControllerAdvice通过annotations(), basePackageClasses(), basePackages()方法定制用于选择控制器子集

### @Scope("prototype") | 多例

[@Scope("prototype")的正确用法——解决Bean的多例问题 - adaandy - 博客园 (cnblogs.com)](https://www.cnblogs.com/heyanan/p/12054840.html)

- 单例（ Singleton）：在整个应用中，只创建bean的一个实例。
- 原型（ Prototype）：每次注入或者通过Spring应用上下文获取的时候，都会创建一个新的bean实例。

## 常见问题

### bean 的生命周期

[史上最完整的Spring Bean的生命周期_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1584y1r7n6/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

#### **Spring Bean 的生命周期**

##### **1.加载Bean定义**

通过 loadBeanDefinitions 扫描所有xml配置、注解将Bean记录在beanDefinitionMap中

##### **2.创建Bean对象**

通过 createBean 遍历 beanDefinitionMap 创建bean

###### **2.1.构建对象**

1. 容器通过 createBeanInstance 进行对象构造
2. 获取构造方法：@Autowired
3. 准备参数 根据类查找>参数名查找
4. 构造对象
5. 无参对象直接实例化

###### **2.2.填充属性**

通过populateBean方法为Bean内部所需的属性进行赋值

- 通常是 @Autowired 注解的变量

###### **2.3.初始化Bean对象**

通过initializeBean对填充后的实例进行初始化

###### **填充初始化容器相关信息**

通过 **invokeAwareMethods** 方法：为实现aware接口【信息感知接口】的Bean 设置注入beanName、beanFactory等容器信息

###### **初始化构造方法**

通过 **invokeInitMethods** 方法进行初始化：

如果Bean实现InitializingBean接口进行处理【未实现则不进行】

- afterPropertiesSet方法【bean填充属性后执行】
- initMethod 方法

###### **Bean的后置处理**

在**invokeInitMethods** 的前后进行

- applyBeanPostProcessorsBeforeInitialization
- **invokeInitMethods**
- applyBeanPostProcessorsAfterInitialization

在后置处理中处理了包括：AOP【AnnotationAwareAspectJAutoProxyCreator】

负责 **构造后@PostConstruct** 和 **销毁前@PreDestroy** 的 InitDestoryAnnotationBeanPostProcessor 等

###### **注册销毁**

通过reigsterDisposableBean处理实现了DisposableBean接口的Bean的注册

##### **3.添加到单例池**

通过 addSingleton 方法，将Bean 加入到单例池 **singleObjects**

##### **4.销毁**

###### **4.1.销毁前**

调用 bean中@PreDestory 注解的方法

通过 postProcessBeforeDestruction 方法调用destoryBean逐一销毁Bean

###### **4.2.销毁**

调用 destoryBeans

###### **4.3.执行客户自定义销毁**

调用 invokeCustomDestoryMethod

<img title="生命周期" src="https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_x86PYgj8iS.png" alt="" width="797">

#### aware 接口 | 回调获取容器的信息

[Spring Aware接口详解-云社区-华为云 (huaweicloud.com)](https://bbs.huaweicloud.com/blogs/353243)

> 【摘要】 若 Spring 检测到 bean 实现了 Aware 接口，则会为其注入相应的依赖。所以通过让bean 实现 Aware 接口，则能在 bean 中获得相应的 Spring 容器资源。Aware接口是回调，监听器和观察者设计模式的混合，它表示bean有资格通过回调方式被Spring容器通知。有时，我们得在 Bean 的初始化中使用 Spring 框架自身的一些对象来执行一些操作，比如获取 ...
> 若 Spring 检测到 bean 实现了 Aware 接口，则会为其注入相应的依赖。所以通过让bean 实现 Aware 接口，则能在 bean 中获得相应的 Spring 容器资源。

Aware接口是回调，监听器和观察者设计模式的混合，它表示bean有资格通过回调方式被Spring容器通知。

有时，我们得在 Bean 的初始化中使用 Spring 框架自身的一些对象来执行一些操作，比如

- 获取 ServletContext 的一些参数

- 获取 ApplicaitionContext 中的 BeanDefinition 的名字

- 获取 Bean 在容器中的名字等等。

- 为了让 Bean 可以获取到框架自身的一些对象，Spring 提供了一组Aware接口。

这些接口均继承自org.springframework.beans.factory.Aware标记接口，并提供一个将由 Bean 实现的set方法，Spring通过基于setter的依赖注入方式使相应的对象可以被Bean使用。

Spring框架提供了多种Aware接口，包括：

1. ApplicationContextAware：让对象能够获取到Spring应用上下文的引用，从而可以在运行时动态获取Bean实例和其他资源。

2. BeanNameAware：让对象能够获取到自己在容器中的Bean名称。

3. BeanFactoryAware：让对象能够获取到Spring容器的引用，从而可以在运行时动态获取Bean实例和其他资源。

4. MessageSourceAware：让对象能够获取到Spring国际化资源的引用，从而可以在运行时动态获取国际化消息。

5. ResourceLoaderAware：让对象能够获取到Spring资源加载器的引用，从而可以在运行时动态加载资源。

### Spring的循环依赖

spring进行扫描->反射后封装成beanDefinition对象->放入beanDefinitionMap->遍历map->验证（是否单例、是否延迟加载、是否抽象）->推断构造方法->准备开始进行实例->去单例池中查，没有->去二级缓存中找，没有提前暴露->生成一个objectFactory对象暴露到二级缓存中->属性注入，发现依赖Y->此时Y开始它的生命周期直到属性注入，发现依赖X->X又走一遍生命周期，当走到去二级缓存中找的时候找到了->往Y中注入X的objectFactory对象->完成循环依赖。  

#### 1、为什么要使用X的objectFacory对象而不是直接使用X对象？

利于拓展，程序员可以通过beanPostProcess接口操作objectFactory对象生成自己想要的对象  

#### 2、是不是只能支持单例(scope=singleton)而不支持原型(scope=prototype)？

是。因为单例是spring在启动时进行bean加载放入单例池中，在依赖的bean开始生命周期后，可以直接从二级缓存中取到它所依赖的bean的objectFactory对象从而结束循环依赖。而原型只有在用到时才会走生命周期流程，但是原型不存在一个已经实例化好的bean，所以会无限的创建->依赖->创建->依赖->...。  

#### 3、循环依赖是不是只支持非构造方法？

是。类似死锁问题

### 过滤器、监听器和拦截器的区别

todo

- 原理: [老生常谈：你真的理解过滤器、拦截器、ControllerAdvice和AOP了吗 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/615374021)

api 拦截方式 [4.SpringBoot 拦截器Fliter，Interceptor，Controller…… - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/148174642)

在网上查询的过滤器和拦截器的区别，基本都是以下一模一样的5行话。

  1、拦截器是基于Java的反射机制的，而过滤器是基于函数回调  
  2、过滤器依赖与servlet容器，而拦截器不依赖与servlet容器  
  3、拦截器只能对action请求起作用，而过滤器则可以对几乎所有的请求起作用  
  4、拦截器可以访问action上下文、值栈里的对象，而过滤器不能  
  5、在action的生命周期中，拦截器可以多次被调用，而过滤器只能在容器初始化时被调用一次

执行顺序：过滤前 - 拦截前 - Action处理 - 拦截后 -过滤后。个人认为过滤是一个横向的过程，首先把客户端提交的内容进行过滤(例如未登录用户不能访问内部页面的处理)；过滤通过后，拦截器将校验用户提交的数据，做一些前期的数据处理；接着把处理后的数据发给对应的Action，Action处理完成返回后Model 和 View，拦截器还可以做其它过程，再向上返回到过滤器的后续操作

过滤器（Filter）：当你有一堆东西的时候，你只希望选择符合你要求的某一些东西。定义这些要求的工具，就是过滤器。就是对请求起到过滤的作用：在监听器之后servlet之前对请求进行过滤。常见应用常见：如用户是否已经登陆、有没有权限访问该页面等等工作。

  servlet：就是对request和response进行处理的容器，它在filter之后执行，servlet其中的一部分就是controller层（标记为servlet_2），还包括渲染视图层(标记为servlet_3)和进入controller之前系统的一些处理部分(servlet_1)，另外我们把servlet开始的时刻标记为servlet_0，servlet结束的时刻标记为servlet_4。

  拦截器（Interceptor）：在一个流程正在进行的时候，你希望干预它的进展，甚至终止它进行，这就是拦截器做的事情。常见应用常见是面向切面编程，即Spring AOP。它作用在servlet的内部，具体来说有三个地方：  
  1）servlet_1和servlet_2之间，即请求还没有到controller层；  
  2）servlet_2和servlet_3之间，即请求走出controller层次，还没有到渲染时图层；  
  3）servlet_3和servlet_4之间，即结束视图渲染，但是还没有到servlet的结束。

  监听器（Listener）：当一个事件发生的时候，你希望获得这个事件发生的详细信息，而并不想干预这个事件本身的进程，这就要用到监听器。就是对项目起到监听的作用，它能感知到包括request(请求域)，session(会话域)和applicaiton(应用程序)的初始化和属性的变化。

  从其应用场景来看，如果把Listener翻译为**窃听**，似乎更切合实际。

![](https://img2020.cnblogs.com/blog/1208468/202104/1208468-20210417150134435-1436712714.png)

使用原则

对整个流程清楚之后，然后就是各自的使用，在使用之前应该有一个使用规则，为什么这么说？因为有些功能比如判断用户是否登录，既可以用过滤器，也可以用拦截器，用哪一个才是合理的呢？那么如果有一个原则，使用起来就会更加合理。实际上这个原则是有的：把整个项目的流程比作一条河，那么监听器的作用就是能够听到河流里的所有声音，过滤器就是能够过滤出其中的鱼，而拦截器则是拦截其中的部分鱼，并且作标记。所以当需要监听到项目中的一些信息，并且不需要对流程做更改时，用监听器；当需要过滤掉其中的部分信息，只留一部分时，就用过滤器；当需要对其流程进行更改，做相关的记录时用拦截器

#### 监听器

##### 监听器种类

在 Spring Boot 应用中，可以使用以下监听器：

1. ApplicationStartingEvent：Spring Boot 应用刚启动时触发的事件。这个事件是在 ConfigurableApplicationContext 被创建之前触发的，因此不能够使用 Spring 容器或者应用上下文中的其他 Bean。

2. ApplicationEnvironmentPreparedEvent：Spring Boot 应用刚启动时，在 ConfigurableEnvironment 准备好之后触发的事件。

3. ApplicationPreparedEvent：Spring Boot 应用启动之后，在 ConfigurableApplicationContext 准备好之后触发的事件。

4. ApplicationStartedEvent：Spring Boot 应用启动完成之后触发的事件。此时 Spring Boot 应用已经启动完成，但是可能还没有完成应用上下文中 Bean 的加载和初始化。

5. AvailabilityChangeEvent：应用程序的可用性发生变化时触发的事件。通过在代码中调用 HealthIndicator 的实现，可以检测应用程序的健康状况并生成 AvailabilityChangeEvent。

6. ApplicationReadyEvent：Spring Boot 应用完全启动并准备好处理请求时触发的事件。

7. ServletWebServerInitializedEvent：Servlet 容器初始化完成时触发的事件。此事件在 WebServer 实例准备好处理请求之后触发。

8. ContextRefreshedEvent：Spring 应用上下文被完全初始化并刷新时触发的事件。

9. ContextClosedEvent：Spring 应用上下文被关闭时触发的事件。

##### 使用

在 Spring Boot 应用中，可以通过两种方式来应用监听器：

1. 通过 @Component 注解将监听器注册为 Bean：可以将监听器类标注为 @Component 或其子注解（如 @Service、@Controller 等），然后在 Spring Boot 启动时会自动将其注册为 Bean。例如：
   
   javaCopy code
   
   ```java
   @Component public class MyListener implements ApplicationListener<ApplicationEvent> { //... }
   ```

2. 通过配置类手动注册监听器：可以通过创建一个配置类来手动注册监听器。在配置类中通过实现 ApplicationListener 接口来实现监听器，然后在配置类中使用 @Bean 注解将其注册。例如：
   
   javaCopy code
   
   ```java
   @Configuration public class MyConfig { @Bean public MyListener myListener() { return new MyListener(); } }
   ```

无论是哪种方式，Spring Boot 启动时都会自动扫描并注册监听器。当应用中的事件被触发时，监听器会执行相应的回调方法进行处理。例如，如果要监听 Servlet 容器中的事件，可以创建一个实现 ServletContextListener 接口的监听器，并在 Spring Boot 应用启动时将其注册为 Bean 或者在配置类中手动注册。然后，在 Servlet 容器中相关事件发生时，监听器会自动执行对应的回调方法，进行相应的处理。例如：

javaCopy code

```java
@Component public class MyServletContextListener implements ServletContextListener { @Override public void contextInitialized(ServletContextEvent sce) { // ServletContext 初始化事件触发时执行的操作 } @Override public void contextDestroyed(ServletContextEvent sce) { // ServletContext 销毁事件触发时执行的操作 } }
```

需要注意的是，在 Spring Boot 应用中使用监听器时，要避免监听器的执行顺序对应用产生影响。可以通过在配置类中使用 @Order 注解来指定监听器的执行顺序。

##### 监听器的应用

可以监听容器启动成功之后 做一些程序的初始化动作

zookeeper 通过监听器实现对客户端的动作进行回调

#### 过滤器

springboot 中过滤器的使用

在 Spring Boot 应用中，可以使用 Servlet 规范中定义的 Filter 接口来实现过滤器。可以通过实现 Filter 接口，并将它注册到 Servlet 容器中来对请求进行过滤。

在 Spring Boot 中，可以通过注解的方式来注册过滤器。以下是实现过滤器的步骤：

1. 创建一个实现 Filter 接口的类，例如：

javaCopy code

`public class MyFilter implements Filter {     @Override     public void init(FilterConfig filterConfig) throws ServletException {         // 过滤器初始化操作     }       @Override     public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)             throws IOException, ServletException {         // 过滤器处理请求         chain.doFilter(request, response);     }       @Override     public void destroy() {         // 过滤器销毁操作     } }`

2. 在应用的启动类上使用 @ServletComponentScan 注解，以扫描该包下的过滤器类：

javaCopy code

`@SpringBootApplication @ServletComponentScan(basePackages = {"com.example.filter"}) public class Application {     public static void main(String[] args) {         SpringApplication.run(Application.class, args);     } }`

3. 在过滤器类上添加 @WebFilter 注解，并设置过滤器的顺序：

javaCopy code

`@WebFilter(filterName = "myFilter", urlPatterns = "/*") public class MyFilter implements Filter {     // ... }`

在以上代码中，@WebFilter 注解用于指定该过滤器的名称、过滤路径和过滤器的执行顺序。可以使用 filterName 属性指定过滤器名称，urlPatterns 属性指定过滤路径，数字越小表示执行顺序越早。

需要注意的是，如果过滤器需要对请求进行修改或重定向，应该在 doFilter() 方法中进行相应的操作。如果不对请求进行修改或重定向，则直接调用 FilterChain 对象的 doFilter() 方法将请求传递给下一个过滤器或 Servlet。

以上是在 Spring Boot 应用中实现过滤器的基本步骤。通过添加多个过滤器，并在 @WebFilter 注解中指定它们的执行顺序，可以实现复杂的请求过滤逻辑。

#### 拦截器

##### 应用

springboot中拦截器的使用

在 Spring Boot 应用中，可以使用 Spring 框架提供的拦截器（Interceptor）来对请求进行拦截和处理。相比于过滤器，拦截器能够更加细粒度地对请求进行控制，比如对不同的请求路径进行不同的处理。

以下是在 Spring Boot 中使用拦截器的步骤：

1. 创建一个实现 HandlerInterceptor 接口的拦截器类，例如：

javaCopy code

`public class MyInterceptor implements HandlerInterceptor {     @Override     public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)             throws Exception {         // 在请求处理之前进行拦截操作         return true;     }       @Override     public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,             ModelAndView modelAndView) throws Exception {         // 在请求处理之后进行拦截操作     }       @Override     public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,             Exception ex) throws Exception {         // 在请求完成之后进行拦截操作     } }`

2. 在配置类中添加一个 InterceptorRegistry bean，用于注册拦截器：

javaCopy code

`@Configuration public class WebConfig implements WebMvcConfigurer {     @Override     public void addInterceptors(InterceptorRegistry registry) {         registry.addInterceptor(new MyInterceptor()).addPathPatterns("/**");     } }`

在以上代码中，通过调用 InterceptorRegistry 对象的 addInterceptor() 方法注册了一个名为 MyInterceptor 的拦截器，并使用 addPathPatterns() 方法指定了拦截的请求路径。如果希望该拦截器对所有请求进行拦截，则可以使用“/**”来表示。

需要注意的是，拦截器可以对请求进行修改或重定向，因此如果需要修改请求的处理结果，可以在拦截器中进行相应的操作。

以上是在 Spring Boot 应用中实现拦截器的基本步骤。通过注册多个拦截器，并设置它们的执行顺序，可以实现复杂的请求拦截和处理逻辑。

### Spring事件驱动模型

跟设计模式中的观察者模式差不多

## aop

在 Spring Boot 中，AOP 的实现主要有以下几种：

1. 基于 AspectJ 的 AOP：这是一种基于 Java 语言扩展（Java Language Extension，JLE）的 AOP 实现方式，支持静态织入和动态织入两种方式。

2. Spring AOP：这是 Spring 框架自带的 AOP 实现方式，基于动态代理机制实现，只支持方法级别的切面。

3. 自定义注解实现 AOP：通过自定义注解和 AOP 技术实现业务逻辑和切面逻辑的分离，便于代码的维护和扩展。

其中，基于 AspectJ 的 AOP 功能最为强大，但使用难度较大；Spring AOP 简单易用，但功能有一定限制；自定义注解实现 AOP 灵活性较高，但需要自行实现 AOP 切面逻辑。在实际开发中，应根据项目需要选择合适的 AOP 实现方式。

> Spring AOP 是基于代理的 AOP，而 AspectJ 是基于字节码的 AOP

Spring AOP 和 AspectJ 都是 Spring Framework 中的 AOP 实现方式。Spring AOP 是基于代理的 AOP，而 AspectJ 是基于字节码的 AOP。

在 Spring Boot 中，默认情况下使用的是 Spring AOP。如果需要使用 ，可以通过在启动类上添加 `@EnableAspectJAutoProxy(proxyTargetClass = true)` 注解来开启。

如果需要使用 AspectJ, 需要引入 AspectJ jar包

> @EnableAspectJAutoProxy 不是用来开启 AspectJ 的吗

配置 @EnableAspectJAutoProxy, 不引入 AspectJ jar包的情况下就使用 Spring AOP

`@EnableAspectJAutoProxy` 注解可以用来开启 AspectJ 的支持，但是它也是用来开启 Spring AOP 的。

在 Spring 中，Spring AOP 和 AspectJ 都是实现 AOP 的方式之一。`@EnableAspectJAutoProxy` 注解用来开启 Spring AOP 的支持，如果在注解中设置 `proxyTargetClass=true`，则会使用 CGLIB 来创建代理对象，否则会使用 JDK 的动态代理。

当然，在 Spring Boot 中，如果需要使用 AspectJ，也可以在启动类上添加 `@EnableAspectJAutoProxy(proxyTargetClass = true)` 注解来开启 AspectJ 支持

#### AspectJ | 高级但是难用

> AspectJ中的静态织入和动态织入

AspectJ 是一个基于 Java 语言的切面编程框架，它提供了两种切面织入方式：静态织入和动态织入。

静态织入是指在编译期间将切面代码织入到目标类中，生成一个新的字节码文件。在运行期间，JVM 加载这个字节码文件，并且这个字节码文件包含了目标类和切面代码，从而实现对目标类的增强。静态织入的优点是织入后的代码执行效率高，缺点是需要在编译期间进行织入，增加了额外的工作量和复杂度。

动态织入是指在运行期间将切面代码织入到目标类中，不需要在编译期间进行修改。在运行期间，通过 JVM 提供的动态代理技术或字节码生成技术，将切面代码织入到目标类中，从而实现对目标类的增强。动态织入的优点是织入更加灵活，可以在运行期间进行修改，缺点是织入后的代码执行效率相对较低。

在 AspectJ 中，静态织入和动态织入可以通过不同的方式实现。静态织入可以使用 AspectJ 编译器，将切面代码编译成字节码文件，并将其与目标类一起打包成一个 jar 包或 war 包，从而在运行期间加载这个包，实现对目标类的增强。动态织入可以使用 AspectJ 提供的 Runtime 织入功能，或者使用 Spring AOP 框架提供的动态代理技术，实现对目标类的增强。

AspectJ 支持更加灵活的切面编程，可以拦截不仅仅是方法级别的切面，还可以拦截字段、构造方法、类等级别的切面。

1. 字段级别

要拦截字段级别的切面，可以使用 AspectJ 提供的 field 切点匹配器，例如：

javaCopy code

```java
@Aspect
public class FieldAspect {

    @Before("get(* com.example.demo.model.User.name)")
    public void beforeFieldAccess(JoinPoint joinPoint) {
        // 拦截 User 类中的 name 字段的 getter 方法
    }

}
```

在上面的示例中，使用 get 切点匹配器匹配 User 类中的 name 字段的 getter 方法，实现对字段级别的拦截。

2. 构造方法级别

要拦截构造方法级别的切面，可以使用 AspectJ 提供的 initialization 切点匹配器，例如：

```java
@Aspect
public class ConstructorAspect {

    @Before("execution(com.example.demo.model.User.new())")
    public void beforeConstructorExecution(JoinPoint joinPoint) {
        // 拦截 User 类的构造方法
    }

}
```

在上面的示例中，使用 execution 切点匹配器匹配 User 类的构造方法，实现对构造方法级别的拦截。

3. 类级别

要拦截类级别的切面，可以使用 AspectJ 提供的 type 切点匹配器，例如：

```java
@Aspect
public class ClassAspect {

    @Before("execution(* com.example.demo.service.*.*(..)) && type(service)")
    public void beforeServiceMethodExecution(JoinPoint joinPoint) {
        // 拦截 com.example.demo.service 包下的所有方法，并且方法所属的类必须被 @Service 注解标注
    }

}
```

在上面的示例中，使用 execution 切点匹配器匹配 com.example.demo.service 包下的所有方法，并且方法所属的类必须被 @Service 注解标注，实现对类级别的拦截。

需要注意的是，AspectJ 的切面匹配器比 Spring AOP 更加灵活，可以匹配更多的切点。但是，AspectJ 的使用需要在编译期间进行织入，因此相对来说也更加复杂和耗费资源。在实际使用中，需要根据实际需求选择使用 Spring AOP 还是 AspectJ。

> 使用 AspectJ, 要引入什么jar包

Spring Boot 默认使用 Spring AOP，如果要使用 AspectJ，需要手动引入 AspectJ 相关的依赖。

可以在 `pom.xml` 文件中添加以下依赖：

```xml
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.9.7</version>
</dependency>
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjrt</artifactId>
    <version>1.9.7</version>
</dependency>
```

其中，`aspectjweaver` 依赖是必须的，它包含了 AspectJ 的运行时环境；`aspectjrt` 依赖是可选的，它包含了 AspectJ 的运行时库，如果使用了 AspectJ 的注解，建议添加该依赖。

在添加了依赖后，可以在启动类上添加 `@EnableAspectJAutoProxy` 注解开启 AspectJ 支持，或者在切面类上使用 `@Aspect` 注解定义切面类。

#### Spring AOP | 易用但仅支持方法

> Spring AOP 只支持方法级别的切面

Spring AOP 只支持方法级别的切面指的是，Spring AOP 只能拦截方法的执行，而不能拦截其他级别的切面，例如字段级别、构造方法级别、类级别等。

这是因为 Spring AOP 的实现方式是基于 JDK 动态代理或 CGLIB 字节码生成技术的，而 JDK 动态代理和 CGLIB 都是基于方法级别的。在使用 JDK 动态代理时，代理对象必须实现一个或多个接口，而接口是方法集合的抽象，因此只能对接口中定义的方法进行拦截；在使用 CGLIB 字节码生成技术时，会生成一个新的类作为代理类，该类是原始类的子类，因此只能拦截原始类中的方法，无法拦截字段、构造方法等。

不过，Spring AOP 还提供了其他的一些拦截点，例如：

1. Bean 生命周期事件：可以在 Bean 初始化前后、销毁前后等事件中执行通知。

2. AspectJ 注解：可以使用 @AspectJ 注解来实现更为灵活的切面拦截，支持字段级别、构造方法级别、类级别等切入点。

需要注意的是，使用 AspectJ 注解时，需要添加相应的 AspectJ 依赖，并配置 AspectJ 编译器，以支持注解的解析和织入。

#### aop 原理

通过 @EnableAspectJAutoProxy 将aop的功能通过bean后置处理器, 关联到我们的IOC容器中

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/Snipaste_AlqX9CV8up.png)

EnableAspectJAutoProxy 的目的是为了导入 AnnotationAwareAspectJAutoProxyCreator

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_Bs18k7zAWk.png)

AnnotationAwareAspectJAutoProxyCreator 又是bean后置处理器, 这不就挂钩上了吗

[史上最完整的AOP底层原理_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1SY41117zq/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[一文吃透spring aop底层原理_spring aop的底层原理_吴法刚的博客-CSDN博客](https://blog.csdn.net/wufagang/article/details/121450308)

那么AOP具体是如何在我体内运行的呢？在我启动时会创建IOC容器, 同时将我体内的bean进行三个连续的动作, 

1. 构造

2. 填充

3. 属性初始化

AOP功能就是通过我体内一个专门处理AOP的<mark>bean后置处理器 </mark>DefaultAdvisorAutoProxyCreator 进行方法增强的, 

可以算作IOC容器的附加功能, 所有的后置处理器都在bean构造完, 并且填充了属性之后执行

1. 填充了属性之后执行

2. 在每一个bean初始化之后都会调用这个后置处理器的postProcessorAfterInitialization 方法, 在这个方法里为需要使用AOP的**bean创建代理对象**。

3. 先通过getAdvicesAndAdvisorsForBean方法, 获取所有的增强Advice, 同时判断当前bean是否满足我们配置的切面条件
   如果满足条件的话, 就会为这个bean构造代理对象来实现AOP  
   为了更统一更方便的构造代理对象, 我会先搭建一个专门用来构造生产代理对象的工厂, proxyFactory, 我会告诉这个工厂具体选择哪种方式进行代理, 分别是cglib和jdkProxy。  

通过添加@EnableAspectJAutoProxy注解, 并且将其中proxyTargetClass配置改为 true 强制使用cglib。  
当然啦在spring boot中默认就是使用cglib, 不过只有这个配置为false, 同时该类实现了任意接口才会使用jdkProxy, 否则还是会使用cglib方式。  
ProxyFactory知道使用哪种方式之后, 就会构造jdkDynamicAopProxy或者cglibAopProxy, 然后就可以通过他们的getProxy方法获得真正的代理对象。 

>  jdkDynamicAopProxy

先说相对简单, 而且即将被我无情放弃的jdkDynamicAopProxy, 在getProxy中会构造一个实现同样bean接口的代理对象, 将真实bean作为代理, 对象中的一个成员变量。  
在调用bean方法的时候就会执行代理对象中的 invoke 方法  
这个 invoke 方法只有两步, 

1. 我会通过之前提到的execution表达式, 获取所有与该方法匹配的所有增强方法, 并将它们组成调用链同时进行排序

2. 开始按顺序执行这些调用链, 这里的调用方式就是经典的责任链模式, 在调用中间会插入bean 执行bean真实的方法

> cglibAopProxy

最为常用的cglibAopProxy, 同样会在getProxy方法中构造代理对象  

用增强器 Enhancer 来设置代理基本信息以及增强方法的调用链  
接着执行 Enhancer create方法来生成代理对象  

和jdkDynamicAopProxy不同的是cglib是基于jdk rt jar包中的asm来生成一组新的class文件, 然后实例化它的对象, 所以对于没有实现接口的bean也可以生成代理对象

在调用bean方法的时候, 会先执行代理对象的intercept方法, 与jdkProxy一样, 也会通过责任链来执行所有的方法增强。

BeanFactory与ApplicationContext有什么区别

BeanFactory和ApplicationContext都是Spring框架中的核心接口，用于管理和提供Spring容器中的Bean对象，但它们之间有一些区别。

1. 配置资源加载方式不同：

BeanFactory只有在第一次获取Bean时才会对配置文件进行解析，Bean的创建和初始化也只会在第一次获取时进行。而ApplicationContext在启动时就会对所有的Bean进行创建和初始化，提前缓存好Bean的实例。

2. Bean的实例化方式不同：

BeanFactory是通过延迟初始化（Lazy Initialization）的方式来创建和管理Bean对象的，也就是说只有在第一次获取Bean时才会创建该对象。而ApplicationContext则是在启动时就创建所有的Bean对象。

3. 容器销毁时的行为不同：

当容器关闭时，BeanFactory并不会自动清理容器中的Bean对象，而是需要手动调用registerShutdownHook()方法来注册一个关闭Hook。而ApplicationContext则是在关闭时自动清理容器中的Bean对象。

4. 扩展点支持不同：

ApplicationContext接口比BeanFactory接口多了一些扩展点的支持，例如事件发布、国际化信息处理、资源文件加载等。而BeanFactory只是提供了基础的Bean管理功能。

综上所述，ApplicationContext在功能上比BeanFactory更加强大，但同时也会占用更多的系统资源，所以在实际应用中需要根据具体情况选择使用哪一个接口。

实际应用中，我们可以根据以下几个因素来判断使用哪一个接口：

1. 功能需求：如果需要使用到事件发布、国际化信息处理、资源文件加载等扩展点功能，那么应该选择ApplicationContext接口。

2. 资源消耗：如果系统资源比较紧张，需要尽量减少内存和CPU占用，那么可以选择BeanFactory接口。因为BeanFactory只有在需要的时候才会进行Bean的初始化和创建，因此能够更加节省系统资源。

3. 开发者自身经验：如果对Spring框架比较熟悉，已经有一定的开发经验，并且没有特别的功能需求，那么可以优先选择BeanFactory接口。

需要注意的是，虽然ApplicationContext的功能比BeanFactory更加强大，但是并不是所有场景都需要使用ApplicationContext，因为ApplicationContext占用的系统资源比较多，对于一些小型应用来说可能会导致资源浪费，所以需要根据具体情况进行选择。

## 事务

入门:  [Spring 事务 -- @Transactional的使用 - 简书 (jianshu.com)](https://www.jianshu.com/p/befc2d73e487)



## spring 高级

源码可参另一个文件 spring-source-code.md