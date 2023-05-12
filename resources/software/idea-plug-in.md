# idea 插件推荐

## .NR Null Object

让 null 变的有意义

> 返回一个空对象（而非 null 对象），比如 NO_ACTION 是特殊的 Action，那么我们就定义一个 ACTION。下面举个 “栗子”，假设有如下代码

```java
public interface Action {
  void doSomething();}

public interface Parser {
  Action findAction(String userInput);
}
```

其中，Parse 有一个接口 FindAction，这个接口会依据用户的输入，找到并执行对应的动作。假如用户输入不对，可能就找不到对应的动作（Action），因此 findAction 就会返回 null，接下来 action 调用 doSomething 方法时，就会出现空指针。

解决这个问题的一个方式，就是使用 Null Object pattern（空对象模式）

> NullObject 模式首次发表在 “程序设计模式语言” 系列丛书中。一般的，在面向对象语言中，对对象的调用前需要使用判空检查，来判断这些对象是否为空，因为在空引用上无法调用所需方法。

![](https://pdai.tech/images/develop/refactor/dev-refactor-notnull-1.png)

我们来改造一下

类定义如下，这样定义 findAction 方法后，确保无论用户输入什么，都不会返回 null 对象：

```java
public class MyParser implements Parser {
  private static Action NO_ACTION = new Action() {
    public void doSomething() {  }
  };

  public Action findAction(String userInput) {

    if ( userInput == null ) {
      return NO_ACTION;
    }
  }
}
```

对比下面两份调用实例

1. 冗余: 每获取一个对象，就判一次空

```java
Parser parser = ParserFactory.getParser();
if (parser == null) {


}
Action action = parser.findAction(someInput);
if (action == null) {

else {
  action.doSomething();
}
```

2. 精简

```java
ParserFactory.getParser().findAction(someInput).doSomething();
```

因为无论什么情况，都不会返回空对象，因此通过 findAction 拿到 action 后，可以放心地调用 action 的方法。

顺便再提下一个插件：

> <mark>.NR Null Object</mark> 插件 NR Null Object 是一款适用于 Android Studio、IntelliJ IDEA、PhpStorm、WebStorm、PyCharm、RubyMine、AppCode、CLion、GoLand、DataGrip 等 IDEA 的 Intellij 插件。其可以根据现有对象，便捷快速生成其空对象模式需要的组成成分，其包含功能如下：

- 分析所选类可声明为接口的方法；
- 抽象出公有接口；
- 创建空对象，自动实现公有接口；
- 对部分函数进行可为空声明；
- 可追加函数进行再次生成；
- 自动的函数命名规范
