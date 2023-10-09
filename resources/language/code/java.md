# java

todo
-

[Java 缺失的特性：扩展方法-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/1135549)

### 官方文档

jdk 17 https://docs.oracle.com/en/java/javase/17/

java 17 api search https://docs.oracle.com/en/java/javase/17/docs/api/index.html

javac 17 https://docs.oracle.com/en/java/javase/17/docs/specs/man/javac.html#option-source

### 学习路线
http://svip.iocoder.cn/Learn/tutorials/

### jdk

#### 商用

[Oracle JDK究竟从哪个版本开始收费？ - 岁月已走远 - 博客园](https://www.cnblogs.com/xuruiming/p/12881503.html)

那么Oracle JDK的最后一个免费版本是哪个呢？

是2019年1月15日发布的Oracle JDK 8u201和8u202！

*JDK17*之后的版本可以免费分发和*商用*，但是仅有3年时间，3年后无法免费*商用*

不过你要实在是想在商用环境用新特性 可以使用开源的 open jdk

## 多线程

[一文秒懂 Java java.util.concurrent.Future - Java 一文秒懂 - 简单教程，简单编程](https://www.twle.cn/c/yufei/javatm/javatm-basic-future.html)

## lampda 流处理

[在 Java 中将 Integer 集合转换为 int 数组](https://www.techiedelight.com/zh/convert-set-of-integer-to-array-of-int-in-java/)

```java

```

## 编程模式

### 回调

回调是一种常用的编程模式，在 Java 中也有广泛的应用。它的基本思想是：一个方法在执行过程中，可以调用另外一个对象的方法来完成某个功能，这个被调用的方法就是回调方法，而调用回调方法的方法就是回调函数。

在 Java 中，回调可以通过接口实现。具体地，可以定义一个接口，其中包含一个或多个回调方法。然后，在需要回调的地方，可以将实现了该接口的对象传递给该方法，让该方法在适当的时候调用该对象的回调方法。这样，该对象就可以在回调方法中完成自己的任务了。

下面给出一个简单的示例：

javaCopy code

`// 定义一个回调接口 public interface Callback {     public void onSuccess(String result);     public void onFailure(String error); }  // 定义一个执行任务的类 public class Task {     private Callback callback;      public Task(Callback callback) {         this.callback = callback;     }      public void execute() {         // 执行某些操作，然后根据结果调用回调方法         if (执行成功) {             callback.onSuccess("成功结果");         } else {             callback.onFailure("失败原因");         }     } }  // 定义一个实现了回调接口的类 public class MyCallback implements Callback {     public void onSuccess(String result) {         System.out.println("任务执行成功，结果为：" + result);     }      public void onFailure(String error) {         System.out.println("任务执行失败，原因为：" + error);     } }  // 在主函数中使用回调 public static void main(String[] args) {     // 创建一个实现了回调接口的对象     Callback callback = new MyCallback();      // 创建一个任务，并将回调对象传递给任务     Task task = new Task(callback);      // 执行任务     task.execute(); }`

在上面的示例中，我们首先定义了一个回调接口 Callback，其中包含了两个回调方法 onSuccess 和 onFailure。然后，我们定义了一个执行任务的类 Task，其中包含了一个 Callback 类型的成员变量，用于存储回调对象。在执行任务时，我们根据执行结果调用回调对象的回调方法。

接着，我们定义了一个实现了回调接口的类 MyCallback，其中实现了 onSuccess 和 onFailure 两个回调方法。在主函数中，我们首先创建了一个实现了回调接口的对象 callback，然后创建了一个任务 task，并将回调对象传递给任务。最后，我们执行任务，并观察回调方法的输出结果。

需要注意的是，回调是一种异步编程的方式，它可以大大提高程序的灵活性和可扩展性，但也需要注意回调方法的执行顺序和线程安全等问题。在实际应用中，需要根据具体的需求来选择合适的回调方式



### java新特征

[10 大 Java 语言特性 - 掘金 (juejin.cn)](https://juejin.cn/post/7140097107000000520#heading-8)
