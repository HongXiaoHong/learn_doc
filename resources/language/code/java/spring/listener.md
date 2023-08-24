# spring 监听器

[Spring Boot 启动事件和监听器，太强大了！-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/835817)



不同阶段有不同的事件

通过新建监听器, 可以获取不同阶段的事件

```java
@Slf4j
public class JavastackListener implements ApplicationListener<AvailabilityChangeEvent> {

    @Override
    public void onApplicationEvent(AvailabilityChangeEvent event) {
        log.info("监听到事件：" + event);
        if (ReadinessState.ACCEPTING_TRAFFIC == event.getState()){
            log.info("应用启动完成，可以请求了……");
        }
    }

}
```





[Springboot启动之后立即执行某些方法可以怎么做？Springboot监听器，Springboot生命周期钩子函数总结大全_51CTO博客_springboot 启动执行方法](https://blog.51cto.com/u_13540373/6025830)



```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.availability.AvailabilityChangeEvent;
import org.springframework.boot.context.event.*;
import org.springframework.boot.web.context.WebServerInitializedEvent;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.env.ConfigurableEnvironment;

/**
 * 接收任意事件的回调，共有9大事件
 */
public class TestApplicationListener implements ApplicationListener<ApplicationEvent> {

    @Override
    public void onApplicationEvent(ApplicationEvent event) {
        if(event instanceof ApplicationStartingEvent){
            // 1.ApplicationStartingEvent在运行开始时发送，但在任何处理之前发送，侦听器和初始化器的注册除外。
            SpringApplication springApplication = ((ApplicationStartingEvent) event).getSpringApplication();
            System.out.println("ApplicationListener================ApplicationStartingEvent");
        }

        if(event instanceof ApplicationEnvironmentPreparedEvent){
            // 2.当要在上下文中使用的Environment 已知但在创建上下文之前，将发送ApplicationEnvironmentPreparedEvent。
            SpringApplication springApplication = ((ApplicationEnvironmentPreparedEvent ) event).getSpringApplication();
            ConfigurableEnvironment environment = ((ApplicationEnvironmentPreparedEvent) event).getEnvironment();
            System.out.println("ApplicationListener================ApplicationEnvironmentPreparedEvent");
        }

        if(event instanceof ApplicationContextInitializedEvent){
            // 3.ApplicationContextInitializedEvent 在prepared  ApplicationContext 并且调用了ApplicationContextInitializers之后，但在加载任何bean定义之前发送。
            SpringApplication springApplication = ((ApplicationContextInitializedEvent ) event).getSpringApplication();
            ConfigurableApplicationContext applicationContext = ((ApplicationContextInitializedEvent) event).getApplicationContext();
            System.out.println("ApplicationListener================ApplicationContextInitializedEvent");
        }

        if(event instanceof ApplicationPreparedEvent){
            // 4.ApplicationPreparedEvent在refresh 开始之前发送，但在加载bean定义之后发送。
            SpringApplication springApplication = ((ApplicationPreparedEvent ) event).getSpringApplication();
            ConfigurableApplicationContext applicationContext = ((ApplicationPreparedEvent) event).getApplicationContext();
            System.out.println("ApplicationListener================ApplicationPreparedEvent");
        }

        if(event instanceof ApplicationStartedEvent){
            // 5.在refreshed上下文之后，调用任何应用程序和命令行运行程序之前，发送ApplicationStartedEvent。
            SpringApplication springApplication = ((ApplicationStartedEvent ) event).getSpringApplication();
            ConfigurableApplicationContext applicationContext = ((ApplicationStartedEvent) event).getApplicationContext();
            System.out.println("ApplicationListener================ApplicationStartedEvent");
        }

        if(event instanceof AvailabilityChangeEvent){
            // 6.AvailabilityChangeEvent在LivenessState.CORRECT之后立即发送。更正以表明应用程序被视为活动的。
            Object payload = ((AvailabilityChangeEvent) event).getPayload();
            System.out.println("ApplicationListener================AvailabilityChangeEvent");
        }

        if(event instanceof ApplicationReadyEvent){
            // 7.在调用任何应用程序和命令行运行程序后，将发送ApplicationReadyEvent。
            SpringApplication springApplication = ((ApplicationReadyEvent ) event).getSpringApplication();
            ConfigurableApplicationContext applicationContext = ((ApplicationReadyEvent) event).getApplicationContext();
            System.out.println("ApplicationListener================ApplicationReadyEvent");
        }

        if(event instanceof AvailabilityChangeEvent){
            // 8.AvailabilityChangeEvent在ReadinessState.ACCEPTING_TRAFFIC之后立即发送。表示应用程序已准备好为请求提供服务。
            Object payload = ((AvailabilityChangeEvent) event).getPayload();
            System.out.println("ApplicationListener================AvailabilityChangeEvent2");
        }

        if(event instanceof ApplicationFailedEvent){
            // 9.如果启动时出现异常，将发送ApplicationFailedEvent。
            SpringApplication springApplication = ((ApplicationFailedEvent ) event).getSpringApplication();
            ConfigurableApplicationContext applicationContext = ((ApplicationFailedEvent) event).getApplicationContext();
            System.out.println("ApplicationListener================ApplicationFailedEvent");
        }

        /**
         * 上面的列表只包括绑定到SpringApplication的SpringApplicationEvents。除此之外，还会在ApplicationPreparedEvent之后和ApplicationStartedEvent之前发布以下事件:
         */
        if(event instanceof WebServerInitializedEvent){
            // web服务器准备就绪后，将发送WebServerInitializedEvent。
            // ServletWebServerInitializedEvent 和ReactiveWebServerInitializedEvent分别是servlet和reactive变量。
            System.out.println("ApplicationListener================WebServerInitializedEvent");
        }

        if(event instanceof ContextRefreshedEvent){
            // 刷新ApplicationContext时，将发送ContextRefreshedEvent。
            System.out.println("ApplicationListener================ContextRefreshedEvent");
        }

    }
}

```



### springboot  event 监听



[SpringBoot事件监听机制,并实现业务解耦 - 掘金 (juejin.cn)](https://juejin.cn/post/7034494768977707045)



```java
@Getter
public class UserRegisterEvent extends ApplicationEvent {

    private User user;

    public UserRegisterEvent(Object source,User user) {
        super(source);
        this.user = user;
    }
}

```





```java
@Slf4j
@Service
public class UserService {

    @Autowired
    ApplicationContext applicationContext;

    @Autowired
    private AsyncService asyncService;

    public void registerUser(User user) {
        log.info("执行业务代码!");
        applicationContext.publishEvent(new UserRegisterEvent(this, user));

        applicationContext.publishEvent(new UserMailEvent(this, user));

        asyncService.testAsync(user);
    }
}

```

监听处理



```java
@Component
@Slf4j
public class AnnotationRegisterListener {

    @Async
    @EventListener(UserRegisterEvent.class)
    public void register(UserRegisterEvent userRegisterEvent) {
        User user = userRegisterEvent.getUser();
        log.info("监听注册,{}", user);
    }

    @Async
    @EventListener(UserMailEvent.class)
    public void sendMail(UserMailEvent userMailEvent) {
        User user = userMailEvent.getUser();
        log.info("监听发送邮件,{}", user);
    }

}

```
