# 如何在springboot中使用redis

## todo

- 源码分析 - aop [Spring cache原理详解 - 掘金 (juejin.cn)](https://juejin.cn/post/6959002694539444231#heading-5)



### springboot使用redis缓存mysql数据的示例

好的，下面是一个使用 Spring Boot 和 Redis 缓存 MySQL 数据的示例：

1. 配置 Redis 和 MySQL 数据库

首先，您需要在您的项目中配置 Redis 和 MySQL 数据库。您可以使用 `application.properties` 或 `application.yml` 文件来配置这些数据库，例如：

```properties
# Redis 配置
spring.redis.host=localhost
spring.redis.port=6379

# MySQL 配置
spring.datasource.url=jdbc:mysql://localhost:3306/test?useSSL=false
spring.datasource.username=root
spring.datasource.password=123456

```

2. 添加 Redis 和 MySQL 的依赖

接下来，您需要在您的项目中添加 Redis 和 MySQL 的依赖，例如：

```xml
<dependencies>
    <!-- Redis 依赖 -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-redis</artifactId>
    </dependency>

    <!-- MySQL 依赖 -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
    </dependency>
</dependencies>

```

xmlCopy code

然后，您需要创建一个实体类来映射 MySQL 数据库中的表，例如：

```java
@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    // getters 和 setters
}

```

4. 创建 UserRepository 接口

接下来，您需要创建一个 `UserRepository` 接口，用于访问 MySQL 数据库。您可以使用 Spring Data JPA 提供的 `CrudRepository` 接口来简化 CRUD 操作，例如：

```java
public interface UserRepository extends CrudRepository<User, Long> {
    User findByUsername(String username);
}

```

5. 创建 UserService 类

然后，您需要创建一个 `UserService` 类，用于访问 MySQL 数据库和 Redis 缓存。在 `UserService` 类中，您需要使用 `@Cacheable` 注解将查询结果缓存到 Redis 中。例如：

```java
@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RedisTemplate<String, User> redisTemplate;

    @Cacheable(value = "user", key = "#username")
    public User getUserByUsername(String username) {
        User user = userRepository.findByUsername(username);
        return user;
    }
}

```

在这个例子中，我们使用了 `@Cacheable` 注解将 `getUserByUsername()` 方法的查询结果缓存到 Redis 中。`@Cacheable` 注解的 `value` 属性指定了缓存的名称，而 `key` 属性则指定了缓存的键。在本例中，我们使用了 `"user"` 作为缓存的名称，使用 `username` 作为缓存的键。

6. 配置 RedisCacheManager

最后，您需要在配置文件中配置 `RedisCacheManager`。您可以使用以下配置：

```java
@Configuration
@EnableCaching
public class CacheConfig {
    @Bean
    public RedisCacheManager cacheManager(RedisConnectionFactory connectionFactory) {
        return RedisCacheManager.builder(connectionFactory)
                .cacheDefaults(RedisCacheConfiguration.defaultCacheConfig().entryTtl(Duration.ofMinute
            .build();
}

@Bean
public RedisTemplate<String, User> redisTemplate(RedisConnectionFactory connectionFactory) {
    RedisTemplate<String, User> redisTemplate = new RedisTemplate<>();
    redisTemplate.setConnectionFactory(connectionFactory);
    redisTemplate.setKeySerializer(new StringRedisSerializer());
    redisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<>(User.class));
    return redisTemplate;
}
s(5)))

```

在这个配置类中，我们首先使用 `@EnableCaching` 注解启用缓存功能。然后，我们创建了一个 `RedisCacheManager` Bean，并设置了缓存的默认过期时间为 5 分钟。最后，我们创建了一个 `RedisTemplate` Bean，并设置了键的序列化器为 `StringRedisSerializer`，值的序列化器为 `Jackson2JsonRedisSerializer`。

需要注意的是，`Jackson2JsonRedisSerializer` 序列化器需要配置 `ObjectMapper`，以控制序列化和反序列化行为。您可以参考之前的回答，了解如何配置 `ObjectMapper`。

至此，您已经成功地创建了一个使用 Spring Boot 和 Redis 缓存 MySQL 数据的示例。在 `UserService` 类中，我们使用了 `@Cacheable` 注解将查询结果缓存到 Redis 中，以加快查询速度。在 Redis 中，缓存的键为 `username`，缓存的值为 User 对象。需要注意的是，在使用 Redis 缓存时，您需要注意缓存的过期时间和缓存的大小，以避免缓存过期或者内存溢出等问题。

>  jackson2JsonRedisSerializer的objectMapper要注意什么



在配置 `Jackson2JsonRedisSerializer` 序列化器时，`ObjectMapper` 是一个非常重要的配置项，它控制着 Java 对象和 JSON 字符串之间的序列化和反序列化行为。因此，在配置 `ObjectMapper` 时，需要注意以下几点：

1. 序列化和反序列化的行为：`ObjectMapper` 控制着 Java 对象和 JSON 字符串之间的序列化和反序列化行为，您需要确保 `ObjectMapper` 的行为符合您的预期。例如，您可以配置 `ObjectMapper` 来控制属性的序列化顺序、日期格式、空值的处理方式等。

2. 注册模块：`ObjectMapper` 支持模块的注册，您可以使用模块来扩展序列化和反序列化的行为。例如，您可以使用 `JavaTimeModule` 模块来支持 `java.time` 包中的日期和时间类的序列化和反序列化。

3. 类型信息：在序列化和反序列化时，`ObjectMapper` 可以包含类型信息，以便您可以正确地反序列化对象。如果您希望将类型信息包含在序列化后的 JSON 字符串中，可以使用 `ObjectMapper` 的 `activateDefaultTyping()` 方法。

以下是一个示例代码，它配置了 `ObjectMapper`，以控制 `Jackson2JsonRedisSerializer` 序列化器的行为：

```java
@Configuration
public class RedisConfig {
    @Bean
    public RedisTemplate<String, Object> redisTemplate(LettuceConnectionFactory lettuceConnectionFactory) {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(lettuceConnectionFactory);

        // 配置 Jackson2JsonRedisSerializer 序列化器
        Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer<>(Object.class);
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        objectMapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance, ObjectMapper.DefaultTyping.NON_FINAL);
        jackson2JsonRedisSerializer.setObjectMapper(objectMapper);

        // 设置 RedisTemplate 的值序列化器为 Jackson2JsonRedisSerializer
        redisTemplate.setValueSerializer(jackson2JsonRedisSerializer);
        redisTemplate.setHashValueSerializer(jackson2JsonRedisSerializer);

        return redisTemplate;
    }
}

```

在这个示例中，我们首先创建了一个 `ObjectMapper`，并设置了一些行为，例如设置所有属性可见、激活默认的类型信息。然后，我们将 `ObjectMapper` 设置到 `Jackson2JsonRedisSerializer` 中，并将 `Jackson2JsonRedisSerializer` 设置为 RedisTemplate 的默认值序列化器和哈希值序列化器，以确保所有的 Java 对象都可以被正确地序列化和反序列化。需要注意的是，`activateDefaultTyping()` 方法可以包含类型信息，在序列化和反序列化时非常有用。但是，这可能会导致潜在的安全问题，因此您需要仔细考虑是否需要包含类型信息。

`objectMapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY)` 和 `objectMapper.activateDefaultTyping(LaissezFaireSubTypeValidator.instance, ObjectMapper.DefaultTyping.NON_FINAL)` 是在配置 `ObjectMapper` 时设置的两个重要选项。

`setVisibility()` 方法设置了 Java 对象属性的可见性，以及在序列化和反序列化过程中应将哪些属性包含在内。在本例中，我们将 `setVisibility()` 方法设置为 `PropertyAccessor.ALL` 和 `JsonAutoDetect.Visibility.ANY`。这意味着序列化和反序列化器将包括所有属性（包括私有属性）以及所有类型的访问器，例如 getter 和 setter 方法。

`activateDefaultTyping()` 方法是用于序列化和反序列化 Java 对象时包含类型信息的方法。这对于反序列化具有多态类型的对象非常有用。例如，在反序列化时，如果您希望反序列化一个 `List`，并且该列表中包含多种类型的对象，则需要使用 `activateDefaultTyping()` 方法来包含类型信息，以便反序列化器可以正确地恢复对象的类型。在本例中，我们将 `activateDefaultTyping()` 方法设置为 `LaissezFaireSubTypeValidator.instance` 和 `ObjectMapper.DefaultTyping.NON_FINAL`。这意味着序列化器将包含任何非最终类的类型信息，例如抽象类、接口和普通类等。

总之，通过这两个方法，我们可以配置 `ObjectMapper` 的序列化和反序列化行为，以便适应不同的数据类型和对象类型。需要注意的是，这些方法可能会影响序列化和反序列化的性能和安全性，因此在使用时需要仔细考虑。



### 缓存的重要注解

在 Spring Boot 中，使用缓存的重要注解包括：

1. `@Cacheable`：将方法的返回值缓存到指定的缓存中，下次调用相同的方法时可以直接从缓存中获取结果，避免重复计算。

2. `@CachePut`：将方法的返回值更新到指定的缓存中，通常用于更新缓存中的数据。

3. `@CacheEvict`：从指定的缓存中删除一个或多个缓存项，通常用于删除缓存中的数据。

4. `@Caching`：可以同时应用多个缓存注解，包括 `@Cacheable`、`@CachePut` 和 `@CacheEvict`。

这些缓存注解使得在应用程序中使用缓存变得非常方便，可以大大提高应用程序的性能和响应速度。下面我们来详细介绍一下这些注解的使用方法：

1. `@Cacheable` 注解

`@Cacheable` 注解可以将方法的返回值缓存到指定的缓存中，通常用于查询操作。当下次调用相同的方法时，如果缓存中存在相同的缓存项，则直接从缓存中获取结果，避免重复计算。

使用 `@Cacheable` 注解时，需要指定缓存的名称和缓存的键。缓存的名称是一个字符串，用于唯一标识一个缓存；缓存的键是一个表达式，用于计算缓存的键值。例如：

```java
@Cacheable(value = "user", key = "#id")
public User getUserById(Long id) {
    // 查询数据库
    ...
    return user;
}

```

在这个例子中，我们将方法的返回值缓存到名为 `"user"` 的缓存中，缓存的键值为方法的参数 `id`。



>  @Cacheable 中的value 有什么用

`@Cacheable` 注解中的 `value` 属性用于指定缓存的名称，表示该方法的返回值需要缓存到哪一个缓存中。缓存名称是一个字符串，可以是任何合法的字符串，通常是用于标识缓存的名字，以便于区分不同的缓存。

在使用 Spring Boot 进行缓存时，通常会使用缓存管理器（如 Ehcache、Redis 等）来管理缓存。每一个缓存管理器都可以管理多个缓存，而每一个缓存都有一个唯一的名称，可以通过这个名称来访问缓存中的数据。

在 `@Cacheable` 注解中，可以使用 `value` 属性指定缓存的名称，如果没有指定缓存的名称，则会使用默认的缓存名称。例如：

```java
@Cacheable(value = "user", key = "#id")
public User getUserById(Long id) {
    // 查询数据库
    ...
    return user;
}

```

在这个例子中，我们使用了 `@Cacheable` 注解，并将缓存的名称设置为 `"user"`，表示该方法的返回值需要缓存到名为 `"user"` 的缓存中。当下次调用 `getUserById()` 方法时，如果缓存中已经存在了键值为 `id` 的缓存项，则会直接从缓存中获取结果，而不需要再次查询数据库。

> 缓存到redis 键会带上value的值

对于 Redis 缓存，`@Cacheable` 注解中的 `value` 属性表示缓存的名称，`key` 属性表示缓存的键。在 Redis 中，缓存的键是由缓存名称和缓存键组成的，例如：

```bash
user:1

```

其中，`user` 是缓存名称，`1` 是缓存键。当我们使用 `@Cacheable` 注解缓存数据到 Redis 时，缓存的键就会自动添加上缓存名称前缀。

因此，对于下面的代码：

```java
@Cacheable(value = "user", key = "#id")
public User getUserById(Long id) {
    // 查询数据库
    ...
    return user;
}

```

在 Redis 中，如果缓存了一个 `id` 值为 `1` 的 `User` 对象，那么它的键名就会是 `user:1`。因为我们在 `@Cacheable` 注解中指定了缓存的名称为 `"user"`，所以 Redis 中缓存的键就会带上 `"user"` 的前缀。

> 指定多个键

`@Cacheable` 注解可以指定多个键来生成缓存键。通常情况下，多个键可以组合在一起生成缓存键，以便更精确地匹配缓存项。

可以使用 SpEL 表达式来指定多个键，每个键之间用 `+` 连接。例如：

```java
@Cacheable(value = "user", key = "#id + '-' + #name")
public User getUserByIdAndName(Long id, String name) {
    // 查询数据库
    ...
    return user;
}

```

在这个例子中，我们使用了 `@Cacheable` 注解，并使用 SpEL 表达式指定了两个键，即 `id` 和 `name`。两个键之间使用 `-` 连接，最终生成的缓存键为 `id-name`。当调用 `getUserByIdAndName()` 方法时，会使用 `id-name` 作为缓存的键，如果缓存中已经存在了对应的缓存项，则直接返回缓存中的数据，否则会查询数据库，并将查询结果缓存到缓存中。

需要注意的是，使用多个键时，需要确保生成的缓存键是唯一的。如果生成的缓存键不唯一，则可能会导致缓存数据被覆盖或者查询结果不准确等问题。



2. `@CachePut` 注解

`@CachePut` 注解可以将方法的返回值更新到指定的缓存中，通常用于更新操作。当调用带有 `@CachePut` 注解的方法时，Spring 会先调用方法，然后将方法的返回值更新到指定的缓存中。

使用 `@CachePut` 注解时，需要指定缓存的名称和缓存的键。缓存的名称和缓存的键与 `@Cacheable` 注解的使用方法相同。例如：

```java
@CachePut(value = "user", key = "#user.id")
public User updateUser(User user) {
    // 更新数据库
    ...
    return user;
}

```

在这个例子中，我们将方法的返回值更新到名为 `"user"` 的缓存中，缓存的键值为方法的参数 `user.id`。



>  @CachePut 重复设置一样的key会覆盖原来的值

> @Cacheable 和 @CachePut 有什么区别, 都可以把结果放到缓存吗

`@Cacheable` 和 `@CachePut` 注解都可以将方法的返回结果放到缓存中，但是它们的使用场景和作用是不同的。

- `@Cacheable` 注解用于查询缓存数据，如果缓存中存在数据，则直接返回缓存数据，否则执行方法体中的代码，并将返回结果存储到缓存中。`@Cacheable` 注解适用于读取数据的场景，例如查询用户信息、查询商品价格等操作。

- `@CachePut` 注解用于更新缓存数据，每次方法执行都会将方法的返回结果存储到缓存中，可以用于更新缓存数据或者初始化缓存数据。`@CachePut` 注解适用于写入数据的场景，例如新增用户信息、修改商品价格等操作。

需要注意的是，当使用 `@Cacheable` 注解时，如果缓存中存在数据，则直接返回缓存数据，不会执行方法体中的代码。而当使用 `@CachePut` 注解时，每次方法执行都会将方法的返回结果存储到缓存中，无论缓存中是否已经存在数据。

综上所述，`@Cacheable` 和 `@CachePut` 注解都可以将方法的返回结果放到缓存中，但是它们的作用和使用场景是不同的，需要根据具体的业务需求来选择合适的注解。



3. `@CacheEvict` 注解

`@CacheEvict` 注解可以从指定的缓存中删除一个或多个缓存项，通常用于删除操作。当调用带有 `@CacheEvict` 注解的方法时，Spring会从指定的缓存中删除一个或多个缓存项。

使用 `@CacheEvict` 注解时，需要指定缓存的名称和缓存的键。缓存的名称和缓存的键与 `@Cacheable` 和 `@CachePut` 注解的使用方法相同。例如：

```java

@CacheEvict(value = "user", key = "#id")
public void deleteUserById(Long id) {
    // 删除数据库中的记录
    ...
}

```

在这个例子中，我们从名为 `"user"` 的缓存中删除键值为 `id` 的缓存项。

4. `@Caching` 注解

`@Caching` 注解可以同时应用多个缓存注解，包括 `@Cacheable`、`@CachePut` 和 `@CacheEvict`。使用 `@Caching` 注解时，需要使用 `@Cacheable`、`@CachePut` 和 `@CacheEvict` 注解分别定义缓存的名称和缓存的键。例如：

```java
@Caching(
    cacheable = {
        @Cacheable(value = "user", key = "#username"),
        @Cacheable(value = "user", key = "#id")
    },
    put = {
        @CachePut(value = "user", key = "#user.id"),
        @CachePut(value = "user", key = "#user.username")
    },
    evict = {
        @CacheEvict(value = "user", key = "#id")
    }
)
public User updateUserByIdAndUsername(Long id, String username, User user) {
    // 更新数据库
    ...
    return user;
}

```

在这个例子中，我们使用了 `@Caching` 注解同时应用了多个缓存注解，包括 `@Cacheable`、`@CachePut` 和 `@CacheEvict`。其中，`@Cacheable` 注解用于查询缓存，`@CachePut` 注解用于更新缓存，`@CacheEvict` 注解用于删除缓存。需要注意的是，使用 `@Caching` 注解时，缓存的名称和缓存的键需要分别在不同的注解中指定。



>  @Caching中cacheable put evict的执行顺序是怎样的

在使用 `@Caching` 注解时，可以同时定义多个缓存注解，包括 `@Cacheable`、`@CachePut` 和 `@CacheEvict` 等。`@Caching` 注解的执行顺序是先执行 `@Cacheable` 注解，然后执行 `@CachePut` 注解，最后执行 `@CacheEvict` 注解。

具体来说，当使用 `@Caching` 注解时，会先执行 `cacheable` 属性指定的 `@Cacheable` 注解，尝试从缓存中读取数据。如果从缓存中读取到了数据，则直接返回数据，不再执行 `put` 和 `evict` 属性指定的注解。

如果从缓存中没有读取到数据，则会执行 `put` 属性指定的 `@CachePut` 注解，将查询到的数据写入缓存中。最后，会执行 `evict` 属性指定的 `@CacheEvict` 注解，删除不需要缓存的数据。需要注意的是，`@CachePut` 注解和 `@CacheEvict` 注解的执行顺序是按照注解在 `put` 和 `evict` 属性中定义的顺序执行的。

综上所述，`@Caching` 注解的执行顺序是先读取缓存数据，然后写入缓存数据，最后删除不需要缓存的数据





### springboot 如何通过aop拦截@Cacheable

在 Spring Boot 中，可以通过 AOP（Aspect Oriented Programming，面向切面编程）来拦截 `@Cacheable` 注解，以实现缓存的自动化管理和使用。具体来说，可以通过以下步骤来实现：

1. 添加 AOP 依赖：在 pom.xml 文件中添加 Spring AOP 依赖，例如：
   
   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-aop</artifactId>
   </dependency>
   
   ```
2. 编写切面类：在切面类中，使用 `@Around` 注解来拦截 `@Cacheable` 注解，并实现缓存的逻辑。例如：
   
   在上述代码中，首先通过 `@Autowired` 注解注入了缓存管理器（`CacheManager`）实例，并使用 `@Around` 注解来拦截 `@Cacheable` 注解。在 `cacheable` 方法中，通过 `joinPoint` 对象获取被拦截方法的注解信息和返回值，然后根据缓存名称和键值从缓存中查找对应的数据。如果缓存中存在对应的数据，则直接返回缓存数据；否则执行方法体中的代码，并将返回结果存储到缓存中。
   
   ```java
   @Component
   @Aspect
   public class CacheAspect {
       @Autowired
       private CacheManager cacheManager;
   
       @Around("@annotation(org.springframework.cache.annotation.Cacheable)")
       public Object cacheable(ProceedingJoinPoint joinPoint) throws Throwable {
           MethodSignature signature = (MethodSignature) joinPoint.getSignature();
           Cacheable cacheable = signature.getMethod().getAnnotation(Cacheable.class);
           String cacheName = cacheable.value();
           String key = cacheable.key();
           Cache cache = cacheManager.getCache(cacheName);
           ValueWrapper valueWrapper = cache.get(key);
           if (valueWrapper != null) {
               return valueWrapper.get();
           }
           Object result = joinPoint.proceed();
           cache.put(key, result);
           return result;
       }
   }
   
   ```
   3. 开启 AOP 支持：在启动类中，添加 `@EnableAspectJAutoProxy` 注解，开启 AOP 支持。例如：
      
      ```java
      @SpringBootApplication
      @EnableAspectJAutoProxy
      public class MyApp {
          public static void main(String[] args) {
              SpringApplication.run(MyApp.class, args);
          }
      }
      
      ```

通过以上步骤，就可以使用 AOP 技术来拦截 `@Cacheable` 注解，实现缓存的自动化管理和使用。当方法被调用时，AOP 会根据注解的配置，自动从缓存中读取数据或将数据存储到缓存中，从而提高应用的性能和可维护性。

> aop也可以拦截注解吗

是的，AOP（Aspect Oriented Programming，面向切面编程）可以拦截注解。在 Spring Framework 中，可以使用 `@Around` 注解来拦截带有指定注解的方法，并在方法执行前后进行增强处理。

具体来说，可以使用 `@Around` 注解和 `ProceedingJoinPoint` 类型的参数来定义切面方法，并在方法中使用 `@annotation()` 表达式来指定需要拦截的注解类型。例如：

```java
@Around("@annotation(MyAnnotation)")
public Object myAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
    // 增强处理代码
    // ...
    Object result = joinPoint.proceed(); // 调用被拦截方法
    // 增强处理代码
    // ...
    return result;
}

```

在上述代码中，使用 `@Around` 注解和 `@annotation()` 表达式来拦截带有 `@MyAnnotation` 注解的方法，使用 `ProceedingJoinPoint` 类型的参数来调用被拦截方法，并在方法中添加增强处理代码。

通过使用 AOP 拦截注解，可以实现各种功能，例如日志记录、安全控制、缓存管理等，提高应用的性能和可维护性。