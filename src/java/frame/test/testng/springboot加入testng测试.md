## springboot加入testng测试

### 操作方法

1. 修改pom.xml 增加 testng依赖
```xml

<dependency>
    <groupId>org.testng</groupId>
    <artifactId>testng</artifactId>
    <version>7.4.0</version>
</dependency>
```
2. 编写测试类
使用@Test进行测试 记住这里引用的是testng的测试类
```java
import org.testng.annotations.Test;

class HongArrayListTest {

    @Test
    void add() {
    }
}

```

### 期间遇到的问题

第一次测试无法运行 第一我怀疑是idea的问题 原因一、 我使用了2021.1的idea社区版本 结果一直出现找不到spring某些类 一直无法运行

后面换了2020.3 idea 专业版 右键运行xml文件之后可以运行 但是说类不是公共类 还不行

```java
class HongArrayListTest {

    @Test
    void add() {
    }
}
```

后面改成public 可以运行了

```java
public class HongArrayListTest {

    @Test
    void add() {
    }
}
```

### 参考

[SpringBoot 中借助 TestNG/SpringBootTest 实现测试](https://blog.viakiba.cn/2018/07/21/TestNG-SpringBootTest/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io#class%E6%8C%87%E5%AE%9Aapplication)