# lombok

## lombok 我们到底应不应该使用

[spring - 迷茫了，我们到底该不该用lombok？ - 个人文章 - SegmentFault 思否](https://segmentfault.com/a/1190000038618224)

缺点大过优点吧

总体来说

如果是一个完全的新项目 又没什么依赖 还是可以使用的

### 缺点如下:

###### 1.强制要求队友安装idea插件

这点确实比较恶心，因为如果使用lombok注解编写代码，就要求参与开发的所有人都必须安装idea的lombok插件，否则代码编译出错。

###### 2.代码可读性变差

使用lombok注解之后，最后生成的代码你其实是看不到的，你能看到的是代码被修改之前的样子。如果要想查看某个getter或setter方法的引用过程，是非常困难的。

###### 3.升级JDK对功能有影响

有人把JDK从Java 8升级到Java 11时，我发现Lombok不能正常工作了。

###### 4.有一些坑

1. 使用@Data时会默认使用@EqualsAndHashCode(callSuper=false)，这时候生成的equals()方法只会比较子类的属性，不会考虑从父类继承的属性，无论父类属性访问权限是否开放。
2. 使用@Builder时要加上@AllArgsConstructor，否则可能会报错。

###### 5.不便于调试

我们平时大部分人都喜欢用debug调试定位问题，但是使用lombok生成的代码不太好调试。

###### 6.上下游系统强依赖

如果上游系统中提供的fegin client使用了lombok，那么下游系统必须也使用lombok，否则会报错，上下游系统构成了强依赖。

## 常用注解

### @Data | 复合注解

@Data相当于@Getter、@Setter、@ToString、@EqualsAndHashCode、@RequiredArgsConstructor的集合。

### @Slf4j | 注入 log 日志对象

[果冻的猿宇宙 – Just Do IT，放胆做挨踢](https://xiaogd.net/md/use-lombok-slf4j-annotation-for-log)



### @Accessors

[lombok @Accessors用法详解（一看就能懂） - 简书](https://www.jianshu.com/p/67a15b2e4a92)

#### @Accessors(chain=true) | 流式调用

链式访问，该注解设置chain=true，生成setter方法返回this（***也就是返回的是对象***），代替了默认的返回void。

```java
package com.pollyduan;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
public class User {
    private Integer id;
    private String name;
    private Integer age;

    public static void main(String[] args) {
        //开起chain=true后可以使用链式的set
        User user=new User().setAge(31).setName("pollyduan");//返回对象
        System.out.println(user);
    }

}
```

#### @Accessors(fluent = true) | 不带前缀的流式调用

与chain=true类似，区别在于getter和setter不带set和get前缀。

```java
package com.pollyduan;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(fluent=true)
public class User {
    private Integer id;
    private String name;
    private Integer age;

    public static void main(String[] args) {
        //fluent=true开启后默认chain=true，故这里也可以使用链式set
        User user=new User().age(31).name("pollyduan");//不需要写set
        System.out.println(user);
    }

}
```

#### @Accessors(prefix = "f") | 自定义set前缀

set方法忽略指定的前缀。不推荐大神们这样去命名。

```java
package com.pollyduan;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(prefix = "f")
public class User {
    private String fName = "Hello, World!";

    public static void main(String[] args) {
        User user=new User();
        user.setName("pollyduan");//注意方法名
        System.out.println(user);
    }

}
```


