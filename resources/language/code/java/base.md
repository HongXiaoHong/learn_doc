# 🚁 java 基础知识

api 官方文档: [Java Platform, Standard Edition Documentation - Releases (oracle.com)](https://docs.oracle.com/en/java/javase/)

## 基本概念

### immutable | 一旦创建就不能被修改的对象

在 Java 中，immutable 类型指的是一旦创建就不能被修改的对象

immutable 对象一般都是不可变的，它们的状态在创建后不会发生任何改变。

immutable 对象有很多优点，比如它们可以被安全地共享和重复使用，因为它们的状态不会被改变，也不会存在竞态条件。在多线程编程中，immutable 对象可以帮助减少同步开销，从而提高程序的性能。同时，immutable 对象也可以提供更好的安全性和可靠性，因为它们的状态不会被恶意代码修改。

在 Java 中，一些内置的类，比如 String 和基本数据类型的包装类（如 Integer、Double 等）都是 immutable 类型。此外，还可以通过在类中使用 final 关键字和不提供修改器方法（setter）来创建自定义的 immutable 类型。

需要注意的是，immutable 对象虽然不能被修改，但是它们可以被替换成一个新的 immutable 对象。这个新的 immutable 对象的状态可能和原始对象不同，但是它们都是不可变的。例如，在 Java 8 中， LocalDate 类是 immutable 类型，但是它提供了一些方法来创建新的 LocalDate 对象，如 plusDays()、withYear() 等方法。

## jdk

[SpringBoot 3.0 最低版本要求的JDK 17，这几个新特性不能不知道！-51CTO.COM](https://www.51cto.com/article/702715.html)

## 🐶泛型

### PECS原则

#### extends | 频繁往外读取内容的

```java
Plate<? extends Fruit> p = new Plate<Apple>(new Apple());
```

extends 之所以不能存放元素的原因, 

在于我赋值了一个 new Plate\<Apple\>

你想往Plate\<? extends Fruit\> 存放的时候, 你根本不知道new 出来的类型具体存放什么, 例如这里可以是 new Plate\<Apple\> 也可以是 new Plate\<Pear\>, 所以我们只能往外取出 Fruit及其父类

#### super | 经常往里插入

```java
Plate<? super Fruit> p = new Plate<Fruit>(new Fruit());
p.add(new Apple());
p.add(new Pear());
```

Plate<? super Fruit> p 可以赋予 Fruit 及其父类的容器

我们可以存放 Fruit 及其子类的对象

- **频繁往外读取内容的，适合用上界Extends。**
- **经常往里插入的，适合用下界Super。**

[【java】泛型中 extends 和 super 的区别？ | iTimeTraveler](https://itimetraveler.github.io/2016/12/27/%E3%80%90Java%E3%80%91%E6%B3%9B%E5%9E%8B%E4%B8%AD%20extends%20%E5%92%8C%20super%20%E7%9A%84%E5%8C%BA%E5%88%AB%EF%BC%9F/)

## 🌭 集合

### List

#### java中List遍历删除元素

[(23条消息) java中List遍历删除元素_java list 遍历删除元素_github_2011的博客-CSDN博客](https://blog.csdn.net/github_2011/article/details/54927531)

✔️ **List集合的遍历删除建议使用迭代器遍历删除操作**

在迭代器中使用 list 本身的remove 是会报错的

for (Student student : list) 一样也是用迭代器进行遍历 所以也会报错

```java
//准备数据
        List<Student> list = new ArrayList<>();
        list.add(new Student("male"));
        list.add(new Student("female"));
        list.add(new Student("female"));
        list.add(new Student("male"));

        //遍历删除,除去男生
        Iterator<Student> iterator = list.iterator();
        while (iterator.hasNext()) {
            Student student = iterator.next();
            if ("male".equals(student.getGender())) {
                iterator.remove();//使用迭代器的删除方法删除
            }
        }
```

用下标进行遍历 记得删除之后记得将索引前移一位 不然会有一些元素漏掉

```java
//准备数据
        List<Student> list = new ArrayList<>();
        list.add(new Student("male"));
        list.add(new Student("male"));
        list.add(new Student("female"));
        list.add(new Student("female"));
        list.add(new Student("male"));

        //普通for循环遍历删除
        for (int i = 0; i < list.size(); i++) {
            Student student = list.get(i);
            if ("male".equals(student.getGender())) {
                list.remove(i);//使用集合的删除方法删除
                i--;//★★★★★ 角标减一
            }
        }
        Log.d("普通for操作结果:", list.toString());
```

#### 线程安全

使用 CopyOnWriteArrayList### Set

#### 线程安全

CopyOnWriteArraySet

### Map

#### map初始化

HashMap的实例有两个参数影响其性能。
初始容量：哈希表中桶的数量
加载因子：哈希表在其容量自动增加之前可以达到多满，的一种尺度
当哈希表中条目数超出了当前容量*加载因子(其实就是HashMap的实际容量)时，则对该哈希表进行
rehash操作，将哈希表扩充至两倍的桶数。
Java中默认初始容量为16，加载因子为0.75。

```java
static final int DEFAULT_INITIAL_CAPACITY = 1 << 4; // aka 16
static final float DEFAULT_LOAD_FACTOR = 0.75f;
```

【loadFactor加载因子】
定义：loadFactor译为装载因子。装载因子用来衡量HashMap满的程度。loadFactor的默认值为0.75f。计算HashMap的实时装载因子的方法为：size/capacity，而不是占用桶的数量去除以capacity。
loadFactor加载因子是控制数组存放数据的疏密程度，loadFactor越趋近于1，那么数组中存放的数据(entry)也就越多，也就越密，也就是会让链表的长度增加，loadFactor越小，也就是趋近于0，那么数组中存放的数据也就越稀，也就是可能数组中每个位置上就放一个元素。那有人说，就把loadFactor变为1最好吗，存的数据很多，但是这样会有一个问题，就是我们在通过key拿到我们的value时，是先通过key的hashcode值，找到对应数组中的位置，如果该位置中有很多元素，则需要通过equals来依次比较链表中的元素，拿到我们的value值，这样花费的性能就很高，如果能让数组上的每个位置尽量只有一个元素
最好，我们就能直接得到value值了，所以有人又会说，那把loadFactor变得很小不就好了，但是如果变得太小，在数组中的位置就会太稀，也就是分散的太开，浪费很多空间，这样也不好，所以在hashMap中loadFactor的初始值就是0.75，一般情况下不需要更改它。

#### 线程安全

ConcurrentHashMap

## 🍿 加解密

[编码算法 - 廖雪峰的官方网站 (liaoxuefeng.com)](https://www.liaoxuefeng.com/wiki/1252599548343744/1304227703947297)

### 对称算法

AES

口令加密

pes 相当于 aes 加盐

### 非对称算法

rsa

用公钥加密 私钥解密 一般用于交换内容

用私钥加密 公钥解密 一般用于验证内容的合法性 是否经过修改 例如下载的文件是否安全

### 秘钥交换

DH

### 哈希算法

MD5

Hmac 相当于加盐的 md5 防止彩虹表攻击

springboot 中存放 私钥

看了 [SpringBoot整合Spring Security-开源基础软件社区-51CTO.COM](https://ost.51cto.com/posts/155)

我认为 还是用一个文件存放起来
使用AES加密下

私钥加密后存放到一个文件中

#### bcrypt
https://blog.csdn.net/Romona_J/article/details/113815161
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230723111508.png)

Bcrypt 是一种哈希加密算法。它是一种密码学安全的单向哈希函数，用于将密码或敏感信息转换成不可逆的哈希值。Bcrypt 专门用于密码存储，其目标是增加密码的安全性，防止被暴力破解。

Bcrypt 算法是由 Niels Provos 和 David Mazières 在 1999 年开发的，它基于 Blowfish 对称加密算法，但加入了一些针对密码哈希的特定改进，如自适应哈希函数和随机盐。

主要特点和优势：

1. 随机盐：Bcrypt 在生成哈希时会自动添加一个随机生成的盐值，每个密码都会有不同的盐值。这样即使两个用户使用相同的密码，其哈希值也不同，增加了破解的难度。

2. 自适应哈希函数：Bcrypt 使用一个内部循环来进行哈希计算，可以动态地调整循环的次数。这使得 Bcrypt 可以在硬件性能提升时自动增加计算量，从而保持密码的安全性。

3. 计算复杂度：Bcrypt 的哈希计算复杂度较高，使得暴力破解密码变得非常困难和耗时，提高了安全性。

由于 Bcrypt 算法具有上述特点，因此它是目前广泛用于存储密码的安全算法。在应用程序中，特别是涉及用户密码的存储和认证的场景，建议使用 Bcrypt 或其他现代的密码哈希算法来保护用户的密码安全。

## 多线程

#### 实现线程

##### Thread

##### Runable

##### Callable

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/SumatraPDF_AVD69VW2Vh.png)

实际上还是使用了runnable接口 

futuretask 实现了 runnable 接口

futuretask 可以通过 callable 构造

这里我认为加入了适配器模式

#### juc 常用的类

##### CountDownLatch | 计数器

```java
        // 模拟六个学生离开教室 保安大叔才关图书馆
        System.out.println("now is 10pm, it's time to leave library");
        CountDownLatch latch = new CountDownLatch(6);
        for (int i = 0; i < 6; i++) {
            new Thread(()->{
                latch.countDown();
                System.out.printf("person%s leave the library%n", Thread.currentThread().getName());
            }, String.valueOf(i)).start();
        }
        try {
            latch.await();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        System.out.println("close door");
```

##### CyclicBarrier | 加法计数器

```java
        CyclicBarrier barrier = new CyclicBarrier(7, () -> {
            System.out.println("凑齐七颗龙珠, 出来吧, 神龙, 实现我的愿望吧");
        });

        for (int i = 0; i < 7; i++) {
            new Thread(() -> {
                System.out.printf("%s 孙悟空得到了%s星龙珠%n", LocalDateTime.now(), Thread.currentThread().getName());
                try {
                    TimeUnit.SECONDS.sleep(5);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                try {
                    barrier.await();
                } catch (InterruptedException | BrokenBarrierException e) {
                    throw new RuntimeException(e);
                }
            }, String.valueOf(i + 1)).start();
        }
```

##### Semaphor | 信号量

```java
        // 通过信号量 模拟停车
        Semaphore sem = new Semaphore(3);
        for (int i = 0; i < 6; i++) {
            new Thread(()->{
                try {
                    sem.acquire(); // 会等待
                    System.out.println(Thread.currentThread().getName() + " 号车主停车了");
                    TimeUnit.SECONDS.sleep(5);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                } finally {
                    System.out.println(Thread.currentThread().getName() + " 号车主离开停车场");
                    sem.release(); // 释放给别人用
                }
            }, String.valueOf(i+1)).start();
        }
```

### 线程池

不用  Executors 提供的方法 要自己用 ThreadPoolExecutor 自己定义

线程池最大线程 通过 判断 是CPU密集型 还是io密集型进行优化设置

corePollSize：核心线程数。在创建了线程池后，线程中没有任何线程，等到有任务到来时才创建线程去执行任务。默认情况下，在创建了线程池后，线程池中的线程数为0，当有任务来之后，就会创建一个线程去执行任务，当线程池中的线程数目达到corePoolSize后，就会把到达的任务放到缓存队列当中。
maximumPoolSize：最大线程数。表明线程中最多能够创建的线程数量，此值必须大于等于1。
keepAliveTime：空闲的线程保留的时间。
TimeUnit：空闲线程的保留时间单位。

BlockingQueue< Runnable>：阻塞队列，存储等待执行的任务。参数有ArrayBlockingQueue、
LinkedBlockingQueue、SynchronousQueue可选。
ThreadFactory：线程工厂，用来创建线程，一般默认即可

RejectedExecutionHandler：队列已满，而且任务量大于最大线程的异常处理策略。有以下取值

```java
ThreadPoolExecutor.AbortPolicy:丢弃任务并抛出RejectedExecutionException异常。
ThreadPoolExecutor.DiscardPolicy：也是丢弃任务，但是不抛出异常。
ThreadPoolExecutor.DiscardOldestPolicy：丢弃队列最前面的任务，然后重新尝试执行任务
（重复此过程）
ThreadPoolExecutor.CallerRunsPolicy：由调用线程处理该任务
```

[CPU 密集型 和 IO密集型 的区别，如何确定线程池大小？ - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1806245)

执行过程

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/SumatraPDF_DbXmSOiNRt.png)

## 锁

### 自旋锁

通过循环判断是否获取锁

自己通过 原子引用/CAS 实现一个自旋锁

这里用 CAS 是直接修改内存 

如果使用普通的变量估计会因为内存互换的关系 导致判断不准确

```java
public class SpinLockDemo {
// 原子引用线程, 没写参数，引用类型默认为null
AtomicReference<Thread> atomicReference = new AtomicReference<>();
//上锁
public void myLock(){
Thread thread = Thread.currentThread();
System.out.println(Thread.currentThread().getName()+"==>mylock");
// 自旋
while (!atomicReference.compareAndSet(null,thread)){
}
}  

//解锁
public void myUnlock(){
Thread thread = Thread.currentThread();
atomicReference.compareAndSet(thread,null);
System.out.println(Thread.currentThread().getName()+"==>myUnlock");
}
// 测试
public static void main(String[] args) {
SpinLockDemo spinLockDemo = new SpinLockDemo();
new Thread(()->{
spinLockDemo.myLock();
try {
TimeUnit.SECONDS.sleep(5);
} catch (InterruptedException e) {
e.printStackTrace();
}
spinLockDemo.myUnlock();
},"T1").start();
try {
TimeUnit.SECONDS.sleep(1);
} catch (InterruptedException e) {
e.printStackTrace();
}
new Thread(()->{
spinLockDemo.myLock();
try {
TimeUnit.SECONDS.sleep(1);
} catch (InterruptedException e) {
e.printStackTrace();
}
spinLockDemo.myUnlock();
},"T2").start();
}
}
```

### 死锁

##### 怎么排除死锁

先找到java中进程列表找到对应的死锁进程

然后通过进程号找到对应的堆栈

jps + jstack

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/SumatraPDF_0nhluKg6bn.png)

### 分布式锁

[聊聊分布式锁的多种实现！-51CTO.COM](https://www.51cto.com/article/705985.html)

## IO

### NIO | 多路复用

全网讲的最好的 nio 没有之一

[小白也看得懂的 I/O 多路复用解析（超详细案例）_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1r54y1f7bU/?spm_id_from=333.788&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## 代理

### jdk动态代理和cglib代理的示例

以下是一个使用JDK动态代理和CGLIB代理的示例。我们首先创建一个接口和实现类，然后分别使用JDK动态代理和CGLIB代理来创建代理对象。

1. 接口：`UserService.java`

```java
public interface UserService {
    void addUser(String name);
}

```

2. 实现类：`UserServiceImpl.java`

```java
public class UserServiceImpl implements UserService {
    @Override
    public void addUser(String name) {
        System.out.println("Adding user: " + name);
    }
}

```

3. JDK动态代理：`JdkProxyHandler.java`

```java
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class JdkProxyHandler implements InvocationHandler {
    private Object target;

    public JdkProxyHandler(Object target) {
        this.target = target;
    }

    @SuppressWarnings("unchecked")
    public <T> T getProxyInstance() {
        return (T) Proxy.newProxyInstance(target.getClass().getClassLoader(),
                target.getClass().getInterfaces(),
                this);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("JDK Proxy - Before method execution");
        Object result = method.invoke(target, args);
        System.out.println("JDK Proxy - After method execution");
        return result;
    }
}

```

4. CGLIB代理：`CglibProxyHandler.java`

```java
import net.sf.cglib.proxy.Enhancer;
import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

public class CglibProxyHandler implements MethodInterceptor {
    private Object target;

    public CglibProxyHandler(Object target) {
        this.target = target;
    }

    @SuppressWarnings("unchecked")
    public <T> T getProxyInstance() {
        Enhancer enhancer = new Enhancer();
        enhancer.setSuperclass(target.getClass());
        enhancer.setCallback(this);
        return (T) enhancer.create();
    }

    @Override
    public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
        System.out.println("CGLIB Proxy - Before method execution");
        Object result = proxy.invokeSuper(obj, args);
        System.out.println("CGLIB Proxy - After method execution");
        return result;
    }
}

```

5. 测试类：`ProxyTest.java`

```java
public class ProxyTest {
    public static void main(String[] args) {
        UserService userService = new UserServiceImpl();

        // 使用JDK动态代理
        JdkProxyHandler jdkProxyHandler = new JdkProxyHandler(userService);
        UserService jdkProxy = jdkProxyHandler.getProxyInstance();
        jdkProxy.addUser("John");

        System.out.println("------------------------------------");

        // 使用CGLIB代理
        CglibProxyHandler cglibProxyHandler = new CglibProxyHandler(userService);
        UserService cglibProxy = cglibProxyHandler.getProxyInstance();
        cglibProxy.addUser("Jane");
    }
}

```

运行 `ProxyTest.java`，你将看到以下输出：

```log
JDK Proxy - Before method execution
Adding user: John
JDK Proxy - After method execution
------------------------------------
CGLIB Proxy - Before method execution
Adding user: Jane
CGLIB Proxy - After method execution

```

JDK动态代理和CGLIB代理都是AOP（面向切面编程）中的实现技术，它们可以在不修改目标类代码的情况下，为目标类添加一些额外的功能。

#### JDK动态代理原理

JDK动态代理是基于Java反射机制实现的。它主要使用了`java.lang.reflect.Proxy`类和`java.lang.reflect.InvocationHandler`接口。

JDK动态代理的核心思想是：为目标类创建一个代理对象，这个代理对象实现了目标类的接口。当代理对象的方法被调用时，实际上是调用了`InvocationHandler`的`invoke`方法。在`invoke`方法中，我们可以在调用目标类方法之前和之后执行一些自定义的逻辑。

要使用JDK动态代理，需要满足以下条件：

- 目标类必须实现一个或多个接口。
- 为目标类编写一个`InvocationHandler`实现类。

JDK动态代理的主要局限在于它只能代理实现了接口的类。如果一个类没有实现接口，就无法使用JDK动态代理。

#### CGLIB代理

CGLIB（Code Generation Library）是一个第三方代码生成库，它可以在运行时为目标类生成一个子类。CGLIB代理的核心思想是：为目标类创建一个子类，并覆盖目标类的方法。当代理类的方法被调用时，实际上是调用了`MethodInterceptor`的`intercept`方法。在`intercept`方法中，我们可以在调用父类（即目标类）方法之前和之后执行一些自定义的逻辑。

要使用CGLIB代理，需要满足以下条件：

- 目标类不能是final的，因为CGLIB需要生成目标类的子类。
- 为目标类编写一个`MethodInterceptor`实现类。

CGLIB代理的优势在于它不要求目标类实现接口，但是由于它是通过创建子类来实现代理的，所以目标类不能是final的。

> JDK动态代理基于Java反射机制，要求目标类实现接口。它创建的代理对象实现了目标类的接口，并通过`InvocationHandler`来实现方法拦截。
> 
> ---
> 
> CGLIB代理基于代码生成技术，不要求目标类实现接口。它创建的代理对象是目标类的子类，并通过`MethodInterceptor`来实现方法拦截。
> 
> **jdk动态代理是由java内部的反射机制来实现的，cglib动态代理底层则是借助asm来实现的**。 总的来说，反射机制在生成类的过程中比较高效，执行时候通过反射调用委托类接口方法比较慢；而asm在生成类之后的相关代理类执行过程中比较高效（可以通过将asm生成的类进行缓存，这样解决asm生成类过程低效问题）
> 
> [java - 动态代理及其实现原理 - 个人文章 - SegmentFault 思否](https://segmentfault.com/a/1190000037648064)

两者都可以实现在不修改目标类代码的情况下，为目标类添加额外功能。选择哪种代理方式取决于目标类是否实现了接口以及其他特殊需求。

[cglib动态代理、asm学习笔记 - 简书 (jianshu.com)](https://www.jianshu.com/p/a728dac249e1)

ASM

位于字节码之上、直接操作字节码的框架，

ASM是一个java字节码操控框架，可以以二进制的形式修改已有类，ASM可以直接生成二进制class文件，也可以在类被加载如java虚拟机之前改变类的行为，asm从类文件中读入信息，甚至可以根据用户要求生成新类

> Spring AOP 默认使用**JDK 动态代理**，如果对象没有实现接口，则使用CGLIB 代理。

#### final类又没实现接口应该用哪一种代理, jdk动态代理还是cglib代理

如果目标类是final类且没有实现接口，那么JDK动态代理和CGLIB代理都无法直接对其进行代理。JDK动态代理要求目标类实现一个或多个接口，而CGLIB代理需要生成目标类的子类，对于final类是无法创建子类的。

在这种情况下，你可以考虑以下解决方案：

1. 修改目标类，去除`final`修饰符，或为其实现一个接口。然后，你可以选择使用JDK动态代理或CGLIB代理。

2. 如果不能修改目标类，你可以尝试使用装饰器模式。创建一个新类，实现与目标类相同的接口（或扩展自目标类，如果目标类不是final的），并在新类中包装目标类。然后，在新类中实现代理逻辑。这种方式虽然不能直接代理目标类，但仍然可以在不修改目标类的情况下，为其添加额外的功能。

请注意，装饰器模式并非代理模式，但在某些情况下，它可以作为一种替代方案来实现类似的功能。