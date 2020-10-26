## @Value 真是一个神奇的注解

### 变量直接赋值
```java
    /* 直接设置值 */
    @Value("25")
    private int hight;
    @Value("65")
    private Integer wight;
    @Value("human")
    private String species;
```
### Resource读取文件
注意 这里的Resource是spring的核心类 不是javax的Resource
```java
import org.springframework.core.io.Resource;

    // 设置系统文本内容
    @Value("classpath:mock/resume.txt")
    private Resource resume;
    // 设置url 调用后返回的值
    @Value("http://www.baidu.com")
    private Resource baidu;
```
### ${}
```java
    /* 使用$设置值 */
    @Value("${user.password}")
    private String password;
```

### #{}

```java
    /* 使用#设置值 */
    // 1. 使用systemProperties[‘xxx’]获取系统参数
    @Value("#{systemProperties['os.name']}")
    private String osName;
    // 2. 调用系统方法
    @Value("#{T(Math).random() * 100.0}")
    private double waterContent;
```

#### 链接参考

[Spring @Value 设置默认值](https://blog.csdn.net/vcfriend/article/details/79700048?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-4.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-4.channel_param)

[Spring Boot系列四 Spring @Value 属性注入使用总结一](https://blog.csdn.net/hry2015/article/details/72353994?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-7.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-7.channel_param)

[SpEL 表达式](https://fanxiaobin.blog.csdn.net/article/details/68942967?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-10.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-10.channel_param)

[SpEL 在注解中的使用-混合使用那种](https://blog.csdn.net/xgw1010/article/details/107591097)

[spring中的SpEL表达式](https://www.jianshu.com/p/61f7c6fe03ec)