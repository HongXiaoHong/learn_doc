## spring 源码 原理

## todo

[(1条消息) Spring源码编译教程（自己复习） 作者 周瑜_周瑜语雀_weixin_41040132的博客-CSDN博客](https://blog.csdn.net/weixin_41040132/article/details/121977339)



[15、Spring之事务底层源码解析 (yuque.com)](https://www.yuque.com/renyong-jmovm/spring/vfg3g6)

- @Import 注解 https://blog.csdn.net/wufagang/article/details/121589729

### 如何阅读源码

阅读Spring源码需要一定的耐心和毅力，但是这对于理解Spring框架的工作原理以及提高自己的Java编程能力是非常有益的。为了更好地理解Spring Bean实例化的细节，可以从以下几个方面入手：

1. 准备工作：
   a. 在GitHub上下载Spring Framework源码：https://github.com/spring-projects/spring-framework b. 使用IDE（如IntelliJ IDEA或Eclipse）导入源码，并确保项目可以正常编译。
   c. 了解Spring框架的基本概念和组件，如IoC容器、Bean、BeanFactory、ApplicationContext等。

2. 从核心接口和实现类入手：
   a. 阅读`org.springframework.beans.factory.BeanFactory`接口，理解BeanFactory的基本功能。
   b. 阅读`org.springframework.beans.factory.config.BeanDefinition`接口，了解Bean定义的元数据。
   c. 阅读`org.springframework.beans.factory.support.AbstractBeanFactory`抽象类，了解BeanFactory的基本实现。
   d. 阅读`org.springframework.beans.factory.support.DefaultListableBeanFactory`类，理解BeanFactory的具体实现。
   e. 关注`getBean()`方法，理解Bean的获取过程。
   f. 关注`createBean()`方法，理解Bean的实例化、属性注入和初始化过程。

3. 研究Bean实例化的关键步骤：
   a. 分析`doGetBean()`方法，了解Bean实例化的主要流程。
   b. 分析`createBeanInstance()`方法，了解Bean对象是如何创建的。
   c. 分析`populateBean()`方法，了解Bean的属性是如何注入的。
   d. 分析`initializeBean()`方法，了解Bean的初始化过程。
   e. 关注`BeanPostProcessor`接口，了解Bean实例化过程中的扩展点。

4. 编写实例代码：
   a. 编写一个简单的Spring应用，以便在调试过程中观察Spring Bean实例化的具体细节。
   b. 在IDE中设置断点，调试Spring应用，逐步跟踪Bean实例化的过程。
   c. 分析每个关键步骤的输入和输出，理解每个步骤的具体作用。

阅读源码是一个反复的过程，不要期望一次就能完全理解。在阅读的过程中，可以不断尝试编写实例代码来验证自己的理解。通过多次实践，您将逐渐掌握Spring Bean实例化的具体细节。

## Spring中实例化类的具体流程

1. 加载配置文件：Spring容器首先解析XML配置文件、注解或Java配置类，以识别bean定义。

2. 创建BeanDefinition：将解析得到的bean定义转换为BeanDefinition对象。BeanDefinition包含了关于bean的详细信息，如bean的类名、构造函数参数、属性值等。

3. 注册BeanDefinition：Spring容器会将BeanDefinition对象注册到BeanDefinitionRegistry中。BeanDefinitionRegistry是一个数据结构，用于存储所有的BeanDefinition。

4. 请求Bean：当应用程序需要一个bean时，它会向Spring容器发出请求。

5. 获取BeanDefinition：Spring容器会在BeanDefinitionRegistry中查找请求的BeanDefinition。

6. 实例化Bean：根据BeanDefinition中的信息，Spring容器使用反射或CGLIB等技术创建bean实例。

7. 属性注入：Spring容器会根据BeanDefinition中的信息，为bean实例设置相应的属性值。

8. 处理依赖：如果bean有依赖关系，Spring容器会在BeanDefinitionRegistry中查找依赖的BeanDefinition，并递归地创建依赖的bean实例。然后将依赖的bean实例注入到当前bean实例中。

9. 初始化Bean：实例化完成后，Spring容器会为bean执行初始化方法，如afterPropertiesSet（如果bean实现了InitializingBean接口）和自定义的初始化方法。

10. 应用BeanPostProcessor：在初始化bean的过程中，Spring容器会应用已注册的BeanPostProcessor。BeanPostProcessor可以在bean初始化前后执行自定义逻辑，如AOP代理、事务处理等。

11. 缓存Bean：将创建好的bean实例缓存起来，以便后续请求直接使用。

12. 返回Bean：将创建好的bean实例返回给应用程序。

具体的流程图如下：

```lua
加载配置文件
      ↓
创建BeanDefinition
      ↓
注册BeanDefinition
      ↓
  请求Bean
      ↓
获取BeanDefinition
      ↓
  实例化Bean
      ↓
  属性注入
      ↓
  处理依赖
      ↓
  初始化Bean
      ↓
应用BeanPostProcessor
      ↓
  缓存Bean
      ↓
  返回Bean
```

BeanPostProcessor是Spring框架中提供的一个扩展点，允许在bean初始化的前后执行一些自定义操作。BeanPostProcessor接口定义了两个方法：`postProcessBeforeInitialization`和`postProcessAfterInitialization`。通过实现这个接口并注册到Spring容器中，你可以在bean实例化过程中执行一些特定逻辑。

1. `postProcessBeforeInitialization`：这个方法会在bean初始化（执行自定义的初始化方法、实现`InitializingBean`接口的`afterPropertiesSet`方法等）之前调用。你可以在这个方法中对bean进行一些预处理操作，如修改bean的属性值、添加验证逻辑等。

2. `postProcessAfterInitialization`：这个方法会在bean初始化完成之后调用。你可以在这个方法中对bean进行一些后处理操作，如包装bean为代理对象（AOP）、添加监控逻辑等。

要使用BeanPostProcessor，你需要实现该接口，并将实现类注册到Spring容器中。当Spring容器创建bean时，会自动应用所有已注册的BeanPostProcessor。

下面是一个简单的BeanPostProcessor示例：

```java
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

public class CustomBeanPostProcessor implements BeanPostProcessor {

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("Before initialization of bean: " + beanName);
        // 在这里可以进行预处理操作
        return bean;
    }

    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("After initialization of bean: " + beanName);
        // 在这里可以进行后处理操作
        return bean;
    }
}
```

现在，每当Spring容器创建一个bean时，都会调用`CustomBeanPostProcessor`的`postProcessBeforeInitialization`和`postProcessAfterInitialization`方法。在这些方法中，你可以添加任何自定义逻辑来改变bean的行为。

BeanPostProcessor在Spring框架中被广泛应用，例如AOP、事务处理、缓存、日志等都是通过BeanPostProcessor实现的。通过了解和使用BeanPostProcessor，你可以更好地控制和扩展Spring容器的行为。

org.springframework.context.annotation.ComponentScanAnnotationParser#parse

### 解析配置, 加入扫描包路径

```java
if (basePackages.isEmpty()) {
            basePackages.add(ClassUtils.getPackageName(declaringClass));
        }
```

#### 默认使用启动类路径

org.springframework.core.io.support.PathMatchingResourcePatternResolver#doRetrieveMatchingFiles

通过递归将我们自己配置的类扫描出来

```java
protected void doRetrieveMatchingFiles(String fullPattern, File dir, Set<File> result) throws IOException {
        if (logger.isTraceEnabled()) {
            logger.trace("Searching directory [" + dir.getAbsolutePath() + "] for files matching pattern [" + fullPattern + "]");
        }

        File[] var4 = this.listDirectory(dir);
        int var5 = var4.length;

        for(int var6 = 0; var6 < var5; ++var6) {
            File content = var4[var6];
            String currPath = StringUtils.replace(content.getAbsolutePath(), File.separator, "/");
            if (content.isDirectory() && this.getPathMatcher().matchStart(fullPattern, currPath + "/")) {
                if (!content.canRead()) {
                    if (logger.isDebugEnabled()) {
                        logger.debug("Skipping subdirectory [" + dir.getAbsolutePath() + "] because the application is not allowed to read the directory");
                    }
                } else {
                    this.doRetrieveMatchingFiles(fullPattern, content, result);
                }
            }

            if (this.getPathMatcher().match(fullPattern, currPath)) {
                result.add(content);
            }
        }

    }
```

### 生成 Beandefinition

普通类最后会生成一个 ScannedGenericBeanDefinition

### 扫描注册 BeanDefinition

#### 扫描

##### 设置scope的值

candidate.setScope(scopeMetadata.getScopeName());

```java
BeanDefinition candidate = (BeanDefinition)var8.next();
ScopeMetadata scopeMetadata = this.scopeMetadataResolver.resolveScopeMetadata(candidate);
candidate.setScope(scopeMetadata.getScopeName());
String beanName = this.beanNameGenerator.generateBeanName(candidate, this.registry);
```

##### 生成名字

org.springframework.context.annotation.AnnotationBeanNameGenerator#generateBeanName

注解没有配置, 就使用默认生成

默认生成 org.springframework.context.annotation.AnnotationBeanNameGenerator#buildDefaultBeanName(org.springframework.beans.factory.config.BeanDefinition)

```java
protected String buildDefaultBeanName(BeanDefinition definition) {
        String beanClassName = definition.getBeanClassName();
        Assert.state(beanClassName != null, "No bean class name set");
        String shortClassName = ClassUtils.getShortName(beanClassName);
        return Introspector.decapitalize(shortClassName);
    }
```

#### 注册 Beandefinition

```java
if (this.checkCandidate(beanName, candidate)) {
                    BeanDefinitionHolder definitionHolder = new BeanDefinitionHolder(candidate, beanName);
                    definitionHolder = AnnotationConfigUtils.applyScopedProxyMode(scopeMetadata, definitionHolder, this.registry);
                    beanDefinitions.add(definitionHolder);
                    this.registerBeanDefinition(definitionHolder, this.registry);
                }
```

加入到 BeanDefinitionMap 里

```java
synchronized (this.beanDefinitionMap) {
                    this.beanDefinitionMap.put(beanName, beanDefinition);
                    List<String> updatedDefinitions = new ArrayList<>(this.beanDefinitionNames.size() + 1);
                    updatedDefinitions.addAll(this.beanDefinitionNames);
                    updatedDefinitions.add(beanName);
                    this.beanDefinitionNames = updatedDefinitions;
                    removeManualSingletonName(beanName);
                }
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_3qw2NpulrG.png)

### 创建

实例化

单例的类在容器启动的时候就进行初始化

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_IvnVXIaBEN.png)

推测使用的构造方法

```java
// Candidate constructors for autowiring?
        Constructor<?>[] ctors = determineConstructorsFromBeanPostProcessors(beanClass, beanName);
        if (ctors != null || mbd.getResolvedAutowireMode() == AUTOWIRE_CONSTRUCTOR ||
                mbd.hasConstructorArgumentValues() || !ObjectUtils.isEmpty(args)) {
            return autowireConstructor(beanName, mbd, ctors, args);
}
// Preferred constructors for default construction?
        ctors = mbd.getPreferredConstructors();
        if (ctors != null) {
            return autowireConstructor(beanName, mbd, ctors, null);
        }
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_YRFmsNhI7u.png)

判断是否开启允许循环依赖

循环依赖就将 ObjectFactory 加入到我们的缓存中

```java
boolean earlySingletonExposure = (mbd.isSingleton() && this.allowCircularReferences &&
                isSingletonCurrentlyInCreation(beanName));
        if (earlySingletonExposure) {
            if (logger.isTraceEnabled()) {
                logger.trace("Eagerly caching bean '" + beanName +
                        "' to allow for resolving potential circular references");
            }
            addSingletonFactory(beanName, () -> getEarlyBeanReference(beanName, mbd, bean));
        }
```

加入到第三级缓存中

```java
protected void addSingletonFactory(String beanName, ObjectFactory<?> singletonFactory) {
        Assert.notNull(singletonFactory, "Singleton factory must not be null");
        synchronized (this.singletonObjects) {
            if (!this.singletonObjects.containsKey(beanName)) {
                this.singletonFactories.put(beanName, singletonFactory);
                this.earlySingletonObjects.remove(beanName);
                this.registeredSingletons.add(beanName);
            }
        }
    }
```

使用lambda表达式实现 ObjectFactory, 

```java
protected Object getEarlyBeanReference(String beanName, RootBeanDefinition mbd, Object bean) {
        Object exposedObject = bean;
        if (!mbd.isSynthetic() && hasInstantiationAwareBeanPostProcessors()) {
            for (SmartInstantiationAwareBeanPostProcessor bp : getBeanPostProcessorCache().smartInstantiationAware) {
                exposedObject = bp.getEarlyBeanReference(exposedObject, beanName);
            }
        }
        return exposedObject;
    }
```

这里的 getBeanPostProcessorCache().smartInstantiationAware 是

SmartInstantiationAwareBeanPostProcessor接口, 我们可以自己实现

但是前提还是得你开启允许循环依赖

### 填充属性

**populateBean(beanName, mbd, instanceWrapper);**

->

org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory#applyPropertyValues

```java
protected void applyPropertyValues(String beanName, BeanDefinition mbd, BeanWrapper bw, PropertyValues pvs) {
        if (pvs.isEmpty()) {
            return;
        }

        if (System.getSecurityManager() != null && bw instanceof BeanWrapperImpl) {
            ((BeanWrapperImpl) bw).setSecurityContext(getAccessControlContext());
        }

        MutablePropertyValues mpvs = null;
        List<PropertyValue> original;

        if (pvs instanceof MutablePropertyValues) {
            mpvs = (MutablePropertyValues) pvs;
            if (mpvs.isConverted()) {
                // Shortcut: use the pre-converted values as-is.
                try {
                    bw.setPropertyValues(mpvs);
                    return;
                }
                catch (BeansException ex) {
                    throw new BeanCreationException(
                            mbd.getResourceDescription(), beanName, "Error setting property values", ex);
                }
            }
            original = mpvs.getPropertyValueList();
        }
        else {
            original = Arrays.asList(pvs.getPropertyValues());
        }

        TypeConverter converter = getCustomTypeConverter();
        if (converter == null) {
            converter = bw;
        }
        BeanDefinitionValueResolver valueResolver = new BeanDefinitionValueResolver(this, beanName, mbd, converter);

        // Create a deep copy, resolving any references for values.
        List<PropertyValue> deepCopy = new ArrayList<>(original.size());
        boolean resolveNecessary = false;
        for (PropertyValue pv : original) {
            if (pv.isConverted()) {
                deepCopy.add(pv);
            }
            else {
                String propertyName = pv.getName();
                Object originalValue = pv.getValue();
                if (originalValue == AutowiredPropertyMarker.INSTANCE) {
                    Method writeMethod = bw.getPropertyDescriptor(propertyName).getWriteMethod();
                    if (writeMethod == null) {
                        throw new IllegalArgumentException("Autowire marker for property without write method: " + pv);
                    }
                    originalValue = new DependencyDescriptor(new MethodParameter(writeMethod, 0), true);
                }
                Object resolvedValue = valueResolver.resolveValueIfNecessary(pv, originalValue);
                Object convertedValue = resolvedValue;
                boolean convertible = bw.isWritableProperty(propertyName) &&
                        !PropertyAccessorUtils.isNestedOrIndexedProperty(propertyName);
                if (convertible) {
                    convertedValue = convertForProperty(resolvedValue, propertyName, bw, converter);
                }
                // Possibly store converted value in merged bean definition,
                // in order to avoid re-conversion for every created bean instance.
                if (resolvedValue == originalValue) {
                    if (convertible) {
                        pv.setConvertedValue(convertedValue);
                    }
                    deepCopy.add(pv);
                }
                else if (convertible && originalValue instanceof TypedStringValue &&
                        !((TypedStringValue) originalValue).isDynamic() &&
                        !(convertedValue instanceof Collection || ObjectUtils.isArray(convertedValue))) {
                    pv.setConvertedValue(convertedValue);
                    deepCopy.add(pv);
                }
                else {
                    resolveNecessary = true;
                    deepCopy.add(new PropertyValue(pv, convertedValue));
                }
            }
        }
        if (mpvs != null && !resolveNecessary) {
            mpvs.setConverted();
        }

        // Set our (possibly massaged) deep copy.
        try {
            bw.setPropertyValues(new MutablePropertyValues(deepCopy));
        }
        catch (BeansException ex) {
            throw new BeanCreationException(
                    mbd.getResourceDescription(), beanName, "Error setting property values", ex);
        }
    }
```

### 初始化

exposedObject = initializeBean(beanName, exposedObject, mbd);

#### Aware回调

invokeAwareMethods(beanName, bean);

回调注入各种容器相关的bean

Aware回调后，Spring会判断该对象中是否存在某个方法被**@PostConstruct**注解了，如果存在，Spring会调用当前对象的此方法（初始化前）
紧接着，Spring会判断该对象是否实现了InitializingBean接口，如果实现了，就表示当前对象必须实现该接口中的afterPropertiesSet()方法，那Spring就会调用当前对象中的afterPropertiesSet()方法（初始化）
最后，Spring会判断当前对象需不需要进行 AOP，如果不需要那么Bean就创建完了，如果需要进行AOP，则会进行动态代理并生成一个代理对象做为Bean（初始化后）

```java
Object wrappedBean = bean;
        if (mbd == null || !mbd.isSynthetic()) {
            wrappedBean = applyBeanPostProcessorsBeforeInitialization(wrappedBean, beanName);
        }

        try {
            invokeInitMethods(beanName, wrappedBean, mbd);
        }
        catch (Throwable ex) {
            throw new BeanCreationException(
                    (mbd != null ? mbd.getResourceDescription() : null),
                    beanName, "Invocation of init method failed", ex);
        }
        if (mbd == null || !mbd.isSynthetic()) {
            wrappedBean = applyBeanPostProcessorsAfterInitialization(wrappedBean, beanName);
        }
```

#### 初始化前

调用后置处理器的postProcessBeforeInitialization

```java
@Override
    public Object applyBeanPostProcessorsBeforeInitialization(Object existingBean, String beanName)
            throws BeansException {

        Object result = existingBean;
        for (BeanPostProcessor processor : getBeanPostProcessors()) {
            Object current = processor.postProcessBeforeInitialization(result, beanName);
            if (current == null) {
                return result;
            }
            result = current;
        }
        return result;
    }
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_N4W5rZXvMY.png)

自己不定义都这么多处理器呀

#### 初始化

判断是否实现 InitializingBean

实现了则执行 afterPropertiesSet();

```java
protected void invokeInitMethods(String beanName, Object bean, @Nullable RootBeanDefinition mbd)
            throws Throwable {

        boolean isInitializingBean = (bean instanceof InitializingBean);
        if (isInitializingBean && (mbd == null || !mbd.hasAnyExternallyManagedInitMethod("afterPropertiesSet"))) {
            if (logger.isTraceEnabled()) {
                logger.trace("Invoking afterPropertiesSet() on bean with name '" + beanName + "'");
            }
            if (System.getSecurityManager() != null) {
                try {
                    AccessController.doPrivileged((PrivilegedExceptionAction<Object>) () -> {
                        ((InitializingBean) bean).afterPropertiesSet();
                        return null;
                    }, getAccessControlContext());
                }
                catch (PrivilegedActionException pae) {
                    throw pae.getException();
                }
            }
            else {
                ((InitializingBean) bean).afterPropertiesSet();
            }
        }

        if (mbd != null && bean.getClass() != NullBean.class) {
            String initMethodName = mbd.getInitMethodName();
            if (StringUtils.hasLength(initMethodName) &&
                    !(isInitializingBean && "afterPropertiesSet".equals(initMethodName)) &&
                    !mbd.hasAnyExternallyManagedInitMethod(initMethodName)) {
                invokeCustomInitMethod(beanName, bean, mbd);
            }
        }
    }
```

#### 初始化后

postProcessAfterInitialization

```java
@Override
    public Object applyBeanPostProcessorsAfterInitialization(Object existingBean, String beanName)
            throws BeansException {

        Object result = existingBean;
        for (BeanPostProcessor processor : getBeanPostProcessors()) {
            Object current = processor.postProcessAfterInitialization(result, beanName);
            if (current == null) {
                return result;
            }
            result = current;
        }
        return result;
    }
```

### 加入单例池

```java
if (newSingleton) {
                    addSingleton(beanName, singletonObject);
    }  

protected void addSingleton(String beanName, Object singletonObject) {
        synchronized (this.singletonObjects) {
            this.singletonObjects.put(beanName, singletonObject);
            this.singletonFactories.remove(beanName);
            this.earlySingletonObjects.remove(beanName);
            this.registeredSingletons.add(beanName);
        }
    }
```

## beanname生成

spring beanname是如何生成的, 他的生成规则是什么?

debug 走起

org.springframework.context.annotation.ComponentScanAnnotationParser#parse

```java
Class<? extends BeanNameGenerator> generatorClass = componentScan.getClass("nameGenerator");
        boolean useInheritedGenerator = (BeanNameGenerator.class == generatorClass);
        scanner.setBeanNameGenerator(useInheritedGenerator ? this.beanNameGenerator :
                BeanUtils.instantiateClass(generatorClass));
```

org.springframework.context.annotation.ConfigurationClassParser#ConfigurationClassParser

->

org.springframework.context.annotation.ConfigurationClassPostProcessor#componentScanBeanNameGenerator

```java
@Override
    public String generateBeanName(BeanDefinition definition, BeanDefinitionRegistry registry) {
        if (definition instanceof AnnotatedBeanDefinition) {
            String beanName = determineBeanNameFromAnnotation((AnnotatedBeanDefinition) definition);
            if (StringUtils.hasText(beanName)) {
                // Explicit bean name found.
                return beanName;
            }
        }
        // Fallback: generate a unique default bean name.
        return buildDefaultBeanName(definition, registry);
    }
```

通过接口 AnnotatedBeanDefinition 判断是否是有注解的

我们这里是 ScannedGenericBeanDefinition

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_JN8LZcw2Lb.png)

**正是实现了 AnnotatedBeanDefinition 的类,**

**用接口判断这个真是妙呀,**

**不用再去通过反射获取注解信息判断, 真是强呀**

然后通过 determineBeanNameFromAnnotation 注解方法获取到component注解是否自定义了名字

其实只要定义以下标签都可以

```java
protected boolean isStereotypeWithNameValue(String annotationType,
            Set<String> metaAnnotationTypes, @Nullable Map<String, Object> attributes) {

        boolean isStereotype = annotationType.equals(COMPONENT_ANNOTATION_CLASSNAME) ||
                metaAnnotationTypes.contains(COMPONENT_ANNOTATION_CLASSNAME) ||
                annotationType.equals("javax.annotation.ManagedBean") ||
                annotationType.equals("javax.inject.Named");

        return (isStereotype && attributes != null && attributes.containsKey("value"));
    }
```

最后没办法没有配置, 默认使用 buildDefaultBeanName 生成默认的方法

```java
protected String buildDefaultBeanName(BeanDefinition definition) {
        String beanClassName = definition.getBeanClassName();
        Assert.state(beanClassName != null, "No bean class name set");
        String shortClassName = ClassUtils.getShortName(beanClassName);
        return Introspector.decapitalize(shortClassName);
    }
```

decapitalize 方法实现

```java
public static String decapitalize(String name) {
        if (name == null || name.length() == 0) {
            return name;
        }
        if (name.length() > 1 && Character.isUpperCase(name.charAt(1)) &&
                        Character.isUpperCase(name.charAt(0))){
            return name;
        }
        char chars[] = name.toCharArray();
        chars[0] = Character.toLowerCase(chars[0]);
        return new String(chars);
    }
```

获取字符串并将其转换为普通 Java 变量名称大写的实用程序方法。这通常意味着将第一个字符从大写转换为小写，但在特殊情况下，当有多个字符而且第一个和第二个字符都是大写时，类名就是BeanName。因此，“FooBah”变成了“fooBah”，“X”变成了“x”，但“URL”仍然是“URL”。





## 循环依赖

[Spring循环依赖冤冤相报何时了_洪宏鸿的博客-CSDN博客](https://blog.csdn.net/HongZeng_CSDN/article/details/129917360)