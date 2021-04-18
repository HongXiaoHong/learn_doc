### 方法

1. 增加test starter

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

2. 编写对应的测试方法 加上@Test注解即可使用
PS: 被测试类
```java
package person.hong.learn.util;

/**
 *
 * @author hong
 */

public class MathUtils {

    /**
     * 斐波那契数列
     * @param index
     * @return
     */
    public static int fibonacci(int index) {
        if (index==1 || index==2) {
            return 1;
        }
        return fibonacci(index-2) + fibonacci(index-1);
    }
}

```

测试类

```java
package person.hong.learn.util;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;


class MathUtilsTest {

    @Test
    void fibonacci() {
        int first = MathUtils.fibonacci(1);
        assert first == 1;

        int second = MathUtils.fibonacci(2);
        Assertions.assertEquals(1, second);

        int third = MathUtils.fibonacci(3);
        Assertions.assertEquals(2, third);

        Assertions.assertEquals(3, MathUtils.fibonacci(4));
        Assertions.assertEquals(5, MathUtils.fibonacci(5));
        Assertions.assertEquals(8, MathUtils.fibonacci(6));
    }
}
```

### 细节

#### 使用 fixture(参考 1)

事实上，@BeforeAll和@AfterAll也只能标注在静态方法上。

因此，我们总结出编写Fixture的套路如下：

对于实例变量，在@BeforeEach中初始化，在@AfterEach中清理，它们在各个@Test方法中互不影响，因为是不同的实例；

对于静态变量，在@BeforeAll中初始化，在@AfterAll中清理，它们在各个@Test方法中均是唯一实例，会影响各个@Test方法。

大多数情况下，使用@BeforeEach和@AfterEach就足够了。只有某些测试资源初始化耗费时间太长，以至于我们不得不尽量“复用”时才会用到@BeforeAll和@AfterAll。

最后，注意到每次运行一个@Test方法前，JUnit首先创建一个XxxTest实例，因此，每个@Test方法内部的成员变量都是独立的，不能也无法把成员变量的状态从一个@Test方法带到另一个@Test方法

使用这几个注解描述九品芝麻官中 周星驰殴打状师的一个桥段
```java
@BeforeAll
    public static void begin() {
        System.out.println("九品芝麻官公堂之上 殴打状师");
    }

    @BeforeEach
    public void in() {
        System.out.println("我进来了");
    }

    @AfterEach
    public void out(){
        System.out.println("我又出去了");
    }

    @AfterAll
    public static void hitMe() {
        System.out.println("打我啦本 最后状师就被打了");
    }

```

#### 条件测试
example
- @Disabled 可以让测试不执行 但是结果显示为skip
- @EnableOnOs 根据操作系统执行 @DisabledOnOs(OS.WINDOWS)
- @DisabledOnJre(JRE.JAVA_8) 只能在9及其更高版本执行
- @EnabledIfSystemProperty 只得在操作系统64位上执行
- @EnabledIfEnvironmentVariable 系统变量满足才可以执行

#### 参数化测试
```java
@ParameterizedTest
    @ValueSource(ints = {-1, -6, -1321})
    public void testAbs(int num) {
        assertEquals(-num, Math.abs(num));
    }

    @ParameterizedTest
    @MethodSource
    void testCapitalize(String input, String result) {
        assertEquals(result, StringUtils.capitalize(input));
    }
    static List<Arguments> testCapitalize() {
        return Arrays.asList(Arguments.arguments("abc", "Abc"), //
                Arguments.arguments("APPLE", "Apple"), //
                Arguments.arguments("gooD", "Good"));
    }

    @ParameterizedTest
    @CsvSource({ "abc, Abc", "APPLE, Apple", "gooD, Good" })
    public void testCapitalizeUsingCsv(String input, String result) {
        assertEquals(result, StringUtils.capitalize(input));
    }

    @ParameterizedTest
    @CsvFileSource(resources = { "/test-capitalize.csv" })
    void testCapitalizeUsingCsvFile(String input, String result) {
        assertEquals(result, StringUtils.capitalize(input));
    }
```
@ParameterizedTest 可以结合
1. @ValueSource(ints = {-1, -6, -1321}) 直接赋值
1. @MethodSource 从方法中获取
1. @CsvSource({ "abc, Abc", "APPLE, Apple", "gooD, Good" }) 直接赋值
1. @CsvFileSource(resources = { "/test-capitalize.csv" }) 从文件读取


### 参考

1. [使用Fixture](https://www.liaoxuefeng.com/wiki/1252599548343744/1304049490067490)
2. [条件测试](https://www.liaoxuefeng.com/wiki/1252599548343744/1304073489874978)