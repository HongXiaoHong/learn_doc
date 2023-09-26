# java 基础 api



## 集合



Collection



### Map

#### computeIfAbsent | 没有就通过函数计算

[HashMap (Java SE 17 & JDK 17) --- HashMap （Java SE 17 & JDK 17） (oracle.com)](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/HashMap.html#computeIfAbsent(K,java.util.function.Function))



```java

```



## System

[System (Java SE 17 & JDK 17) --- 系统（Java SE 17 和 JDK 17） (oracle.com)](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/System.html#method-summary)

- 获取系统时间

- 获取系统属性/环境变量

- 复制数组

- 加载文件和库的方法

- 标准输入、标准输出和错误输出流



### arraycopy | 复制数组

[Java中System.arraycopy()和Arrays.copyOf()的区别 - 简书 (jianshu.com)](https://www.jianshu.com/p/840976f14950)

- arraycopy()需要目标数组，将原数组拷贝到你自己定义的数组里，而且可以选择拷贝的起点和长度以及放入新数组中的位置
- copyOf()是系统自动在内部新建一个数组，调用arraycopy()将original内容复制到copy中去，并且长度为newLength。返回copy; 即将原数组拷贝到一个长度为newLength的新数组中，并返回该数组。





### getProperty | 获取 java 相关信息以及系统一些信息

https://blog.csdn.net/WTUDAN/article/details/102550184

java.version    Java 运行时环境版本
java.vendor    Java 运行时环境供应商
java.vendor.url    Java 供应商的 URL
java.home    Java 安装目录
java.vm.specification.version    Java 虚拟机规范版本
java.vm.specification.vendor    Java 虚拟机规范供应商
java.vm.specification.name    Java 虚拟机规范名称
java.vm.version    Java 虚拟机实现版本
java.vm.vendor    Java 虚拟机实现供应商
java.vm.name    Java 虚拟机实现名称
java.specification.version    Java 运行时环境规范版本
java.specification.vendor    Java 运行时环境规范供应商
java.specification.name    Java 运行时环境规范名称
java.class.version    Java 类格式版本号
java.class.path    Java 类路径
java.library.path    加载库时搜索的路径列表
java.io.tmpdir    默认的临时文件路径
java.compiler    要使用的 JIT 编译器的名称
java.ext.dirs    一个或多个扩展目录的路径
os.name    操作系统的名称
os.arch    操作系统的架构
os.version    操作系统的版本
file.separator    文件分隔符（在 UNIX 系统中是“/”）
path.separator    路径分隔符（在 UNIX 系统中是“:”）
line.separator    行分隔符（在 UNIX 系统中是“/n”）
user.name    用户的账户名称
user.home    用户的主目录
user.dir    用户的当前工作目录


使用:



```java
public class TestSystemGetSet {  
    static{  
        System.setProperty("DB", "mysql");//可以作为全局变量，在任何地方使用  
    }  
    public static void main(String[] args) {  
        System.out.println(System.getProperty("os.version"));  
        System.out.println(System.getProperty("java.library.path"));  
        System.out.println(System.getProperty("DB"));  
    }  
}  

```

### load | 加载本地文件用于 native 方法调用

[java如何加载系统类库 java加载so库_footballboy的技术博客_51CTO博客](https://blog.51cto.com/u_12196/6580717)

JDK提供给了用户两个方法用于装载库文件，不论是JNI库文件还是非JNI库文件。一个是System.load(String fileName)方法，另一个是System.loadLibrary(String libname)方法，在任何本地方法被调用之前必须先用这两个方法之一把相应的JNI库文件装载。

 System.load（带文件后缀名）
System.load参数必须为库文件的绝对路径，可以是任意路径，例如：

   System.load("C:\\Documents and Settings\\TestJNI.dll"); //Windows

   System.load("/usr/lib/TestJNI.so"); //Linux

System.loadLibrary （不带文件后缀名）
System.loadLibrary 参数为库文件名，不包含库文件的扩展名，例如：

   System.loadLibrary ("TestJNI"); //加载Windows下的TestJNI.dll本地库

   System.loadLibrary ("TestJNI"); //加载Linux下的libTestJNI.so本地库

注意：TestJNI.dll 或 libTestJNI.so 必须是在JVM属性java.library.path所指向的路径中

java如何加载系统类库 java加载so库
https://blog.51cto.com/u_12196/6580717

## 正则

### 基础使用
[Java进阶——使用正则表达式检索、替换String中的特定字符和关于正则表达式的一切](https://blog.csdn.net/CrazyMo_/article/details/67634590)
去掉字符串中的空格和换行符

```java
public static String getNonBlankStr(String str) {      
     if(str!=null && !"".equals(str)) {      
         Pattern pattern = Pattern.compile("\\s*|\t|\r|\n"); //去掉空格符合换行符     
         Matcher matcher = pattern.matcher(str);      
         String result = matcher.replaceAll("");      
         return result;      
     }else {      
         return str;      
     }           
 }   

```

### Java正则表达式Regex 后向引用$1, \\1
[Java正则表达式Regex 后向引用$1, \\1](https://blog.csdn.net/ljyljyok/article/details/123876952)

```java

"abc def".replaceFirst("(\\w+)\\s+(\\w+)", "$2 $1");  // 结果为 def abc

"abc def aaa bbb".replaceAll("(\\w+)\\s+(\\w+)", "$2 $1");  // 结果是 def abc bbb aaa
```