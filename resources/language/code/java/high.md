# java 高级

## 字节码

### ASM | 通过适配器读取生成字节码[文件]

https://blog.csdn.net/zhuoxiuwu/article/details/78619645

改写构造方法

```java
class ChangeToChildConstructorMethodAdapter extends MethodAdapter { 
    private String superClassName; 
 
    public ChangeToChildConstructorMethodAdapter(MethodVisitor mv, 
        String superClassName) { 
        super(mv); 
        this.superClassName = superClassName; 
    } 
 
    public void visitMethodInsn(int opcode, String owner, String name, 
        String desc) { 
        // 调用父类的构造函数时
        if (opcode == Opcodes.INVOKESPECIAL && name.equals("<init>")) { 
            owner = superClassName; 
        } 
        super.visitMethodInsn(opcode, owner, name, desc);// 改写父类为 superClassName 
    } 
}

```

## 注解
### @Inherit | 子类继承父类的注解
限制: 子类的方法无法直接拿到 父类的 注解
但是可以使用 spring 的工具类拿到 
JAVA中的注解可以继承吗？
https://developer.aliyun.com/article/1115828

### 组合注解
https://segmentfault.com/a/1190000021223108

例如 spring 中的 Controller 注解 就跟 Component 一样
只是换了个名字而已
或者我可以理解为 java 中的注解可以进行 多继承

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface Controller {

	/**
	 * The value may indicate a suggestion for a logical component name,
	 * to be turned into a Spring bean in case of an autodetected component.
	 * @return the suggested component name, if any (or empty String otherwise)
	 */
	@AliasFor(annotation = Component.class)
	String value() default "";

}
```

## 类加载

自定义类加载器是为了解决当.class文件不在classpath路径中时，寻找加载.class而存在的

[JVM解决不同classloader装载的类不能互相访问](https://www.cnblogs.com/cnndevelop/p/12193169.html)
### 类加载实例

#### 热加载


##### SPI 
视频讲解:
[一看就懂，详解Java中的类加载器机制，附热加载示例代码演示](https://www.bilibili.com/video/BV1ZY4y1n7tg/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)
[java-classloader-sample](https://gitee.com/cnmemset/java-classloader-sample/blob/master/app-service/src/main/java/cn/memset/app/CompanyService.java)

使用 SPI 进行热加载

```java
package cn.memset.sample;

import cn.memset.sample.classloaders.MyCommonClassLoader;
import cn.memset.service.api.Service;

import java.util.Scanner;

/**
 * 简单的热加载示例
 */
public class ReloadableApplication {
    /**
     * Service类型的全局变量
     */
    private static Service service;

    /**
     * 加载指定目录中的 Service
     */
    private static void loadService() throws Exception {
        // 首先创建一个全新的 ClassLoader 对象
        ClassLoader myLoader = new MyCommonClassLoader(
                "D:\\anyuanwai\\common-sdk");
        // 调用 Class.forName 加载指定的 Service 类
        Class<?> serviceCls = Class.forName(
                "cn.memset.app.CompanyService",
                false,
                myLoader);

        if (service != null) {
            service.stop();
        }

        // 创建 Service 对象，然后运行它
        service = (Service) serviceCls.newInstance();
        service.start();
    }

    public static void main(String[] args) throws Exception {
        loadService();

        Scanner scanner = new Scanner(System.in);
        while (true) {
            String command = scanner.nextLine();
            if ("reload".equalsIgnoreCase(command)) {
                // 重新加载服务
                // 在不停止当前进程的前提下，加载最新版本的类
                loadService();
            } else if ("exit".equalsIgnoreCase(command)) {
                // 停止服务
                if (service != null) {
                    service.stop();
                }
                break;
            } else {
                System.out.println(command);
            }
        }
    }
}

```


更改 CompanyService 的 start 方法之后, 使用上面的reload 进行加载, 重新调用方法之后生效
```java
package cn.memset.app;

import cn.memset.app.entities.Employee;
import cn.memset.app.entities.Manager;
import cn.memset.service.api.Service;

public class CompanyService implements Service {
    @Override
    public void start() {
        System.out.println("start Service[" + this + ']');
        Employee employee = new Employee("张三");
        Manager manager = new Manager("李四");

        String employeeStr = employee.toString().toLowerCase();
        String managerStr = manager.toString().toLowerCase();

        System.out.println("公司员工: " + employeeStr);
        System.out.println("公司经理: " + managerStr);
    }

    @Override
    public void stop() {
        System.out.println("stop Service[" + this + ']');
    }
}

```

###### SPI 与 jdbc
spi 加到 jdbc 以后, 各大数据库厂商只需要在 Men-inf/services 目录下放置对应的实现类, 就可以获取到驱动
不需要我们自己使用 Class.forname 进行加载

思想
- 使用约定的位置存放配置文件, 提供实现的同时提供配置文件
- 实现类必须持有一个无参构造器, 用于对接口的实例化
- class 放置在可以被加载的地方
  - classpath, 例如 maven pom.xml 进行配置
  - java 扩展路径
  - 自定义 classloader


###### spi 与 springboot 自动加载
springboot 的自动装载 依靠的原理也跟上面 spi jdbc 类似
只不过存放的地方变了, springboot 2.0 是 spring.factories
springboot 3.0 则是另一个配置文件了

