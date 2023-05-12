# 设计模式

## todo

- [ ] 强烈推荐 ⭐ [mifengjun/java-design-patterns: 设计模式专题，共 23 种设计模式。GOF design patterns，implement of Java。 (github.com)](https://github.com/mifengjun/java-design-patterns)

- [ ] 不止23种设计模式 其实 [iluwatar/java-design-patterns: Design patterns implemented in Java (github.com)](https://github.com/iluwatar/java-design-patterns)

## 入门

[图说设计模式  Graphic Design Patterns](https://design-patterns.readthedocs.io/zh_CN/latest/index.html)

强烈推荐 ⭐ [mifengjun/java-design-patterns: 设计模式专题，共 23 种设计模式。GOF design patterns，implement of Java。 (github.com)](https://github.com/mifengjun/java-design-patterns)

## 升级

全英 害怕

[iluwatar/java-design-patterns: Design patterns implemented in Java (github.com)](https://github.com/iluwatar/java-design-patterns)

## 六大原则

https://www.bilibili.com/video/BV1eG411H7Jk/?spm_id_from=333.788&vd_source=eabc2c22ae7849c2c4f31815da49f209

- 一、单一职责原则
- 二、里式替换原则
- 三、依赖倒置原则
- 四、接口隔离原则
- 五、迪米特法则
- 六、开闭原则


如果子类的方法重写了父类的方法，那么子类中该方法的访问级别不允许低于父类的访问级别。这是为了确保可以使用父类实例的地方都可以使用子类实例，也就是确保满足里氏替换原则。

### 单例模式 | 全世界只有一个你

平行宇宙同时出现两个你可是会坍塌的

在系统来说 内存等资源是宝贵的！要合理的分配使用！

#### 实现

通过私有化构造器实现

最好的方式 我认为是通过内部类实现

既可以懒加载 又可以不用考虑多线程的问题

### 原型模式 | 真是一个模子刻出来的

手拉壶通过师傅的手工进行生产, 样子那叫一个千差万别

一个瓷器的生产, 每种样式只要我们规定好模具, 做出来的样子就是大同小异的

#### 实现

通过 Cloneable 接口, 告诉程序我们这个类可以克隆

虽然是简单的浅克隆

如果我们需要深克隆, 就需要把可变换属性也实现一遍 Cloneable 了

##### 好处嘛

自然是我们不用直到原来的对象是怎么来的, 可以更快去创建我们的对象

### 工厂模式 | 手机制造

你要用手机难道还要自己造一个手机吗

当然是买 买 买 啦

还有就是买不同的小商品去找不同的加工厂帮我们生产

#### 实现

通过传入参数 告诉工厂你具体要的是什么

或者你可以将工厂抽象成一个接口

我们需要什么就实例化一个什么样的工厂, 让工厂给我们造,

当然我们取一元店就什么都可以买到啦

### 抽象工厂模式 | 你要的我全都

生产一类产品的工厂

例如小米从手机做到手机周边再到智能家居

那简直是超级工厂

可以说你要的电子产品 你说的出 他就有

当然只生产一种就会退化成我们的工厂模式

### 建造者模式 | 一砖一瓦砌成墙

相同的建筑团队, 有不同的设计图纸, 我们可以建造出千变万化的房子

将复杂的构建 拆成一步一步的构建

例如我们可以使用 链式调用来不停设置某些值

Stringbuilder 

#### 实现

改造好后返回当前对象, 进行链路调用

例如我们可以通过lombok的@Accessor 注解帮我们自动生成可以链路调用的set方法

### 代理模式 | 小秘书

董事长要去出席某某会议, 小秘书提前帮我们的董事长整理好了材料,

会后帮我们的董事长处理会议记录

增强了我们的主题功能

#### 实现

通过静态代理 即实现对应的接口

动态代理

通过代理来增强我们的对象以及

控制对象的访问, 同时达到一定的目的

### 装饰器模式 | 化妆粉墨登场

过年用的花, 我们可以通过挂上各种小灯笼进行装饰,

让我们的花更加好看

花还是那个花, 只是更好看了

#### 实现

通过集成原来的类或者实现对应的接口, 通过引用/组合原来的类

在对应方法中强化我们的功能

例如 io流中 的 装饰器

```java
import java.io.*;

public class DecoratorExample {
    public static void main(String[] args) throws Exception {
        // 创建一个文件输入流
        InputStream input = new FileInputStream("input.txt");

        // 通过缓冲区装饰文件输入流
        input = new BufferedInputStream(input);

        // 通过DataInputStream装饰缓冲区输入流，以便读取Java基本类型数据
        DataInputStream dataInput = new DataInputStream(input);

        // 读取数据
        int intValue = dataInput.readInt();
        double doubleValue = dataInput.readDouble();

        // 输出数据
        System.out.println("int value: " + intValue);
        System.out.println("double value: " + doubleValue);

        // 关闭流
        dataInput.close();
    }
}
```

在上面的示例中，我们使用了三个装饰器来装饰文件输入流。首先，我们通过BufferedInputStream装饰文件输入流，以便读取数据时能够提高效率。然后，我们通过DataInputStream装饰缓冲区输入流，以便读取Java基本类型数据。最后，我们使用了readInt和readDouble方法从数据输入流中读取整数和双精度浮点数，并将它们输出到控制台上。最后，我们关闭了DataInputStream，这也将关闭底层的BufferedInputStream和FileInputStream。

### 桥接模式 | 通过桥梁我们可以到达更远的远方

修桥铺路 造福子孙

海峡两岸有一座桥 或者是有一个地下通道

那对于海峡两岸的居民来说都是及其便利的

我们的接口就相当于桥梁, 打通我们类跟类之间的任督二脉

这个桥梁的意思相当于说是一种沟通类与类之间的通道

> 蓝色の圆形
> 蓝色の长方形
> 红色の圆形
> 红色の长方形

通过组合 形状类拥有这个颜色的通道

我们可以通过注入不同的颜色, 来实现不同颜色的各种形状

#### 实现

我们可以通过组合的方式替换原来的继承

比如有颜色的方块 我们可以把颜色抽取出来成一个接口 然后通过组合的方式实现多个颜色的方块

我们原先用的 log4j 的接口

这个时候我们底层想用 slf4j 接口进行调用

这个时候我们把原先的log4j包去掉 替换成桥接包 

然后使用slf4j对接上各种日志实现即可

### 适配器模式 | 插座

扩展坞, USB转 HDMI,turboc...

#### 实现

slf4j 定义了一套接口, 我们想用已经实现了日志记录的日志记录器

我们可以使用适配器, 各个日志记录记录器厂商实现了 slf4j 接口适配到原先的日志框架

原先我们的系统中有旧的实现已经实现了功能, 但是现在想用新的接口了

这个时候我们通过实现接口调回我们之前实现的类即可

### 外观模式 | 我只关注结果

以前的人呀 之间传递信息通过书信 要经过漫长的等待

现在我们只需要把邮件写好,登录邮箱账号, 发送即可

这个邮箱或者叫电子邮局就是我们看到的外观

我们只需要点击发送就可以把我们的信件传递到大洋彼岸

不用关心底层用的什么 POP3 SMTP协议

#### 实现

代码中我们常常使用接口, 我们并不关心底层如何实现,我们只关心这个接口能帮我们做什么

就像 slf4j 中打印日志一样, 我们只需要调用接口的方法就可以打印日志

不用关系底层用的什么输入输出流

### 享元模式 | 魔法口袋

共享资源, 池化技术

共享充电宝, 我们只需要扫码支付, 就可以与他人一起共享一个充电宝

#### 实现

通过 map 存放我们曾经使用同时也是可以重复使用的资源

IOC 容器其实也可以算是一个大大池子了

### 组合模式 | 1 + 1 > 2

龙珠超中 孙悟饭跟特兰克斯合体

todo

此处可以有一张合体的插图

他俩合体可厉害可厉害了 1 + 1 > 2

当然悟空也可以跟贝吉塔合体啦

#### 实现

我们知道每种排序算法在不同的数据量面前是会有不同的表现的

我们可以根据数据集在不同数量级的时候采用不同的排序算法,

排序时同时使用两种排序算法或者多种排序算法

达到组合 1 + 1 > 2的效果

例如我们刚好有一个用户推荐商品的场景

我们可以将推荐商品的组合写好 然后通过判断组合列表中是否是当前满足条件的组合

是就返回

![composite-code](https://camo.githubusercontent.com/3dd46e6e5a25c431d662851a25c9f90798a11cb768d1707b46a36afd313fb746/68747470733a2f2f692e6c6f6c692e6e65742f323032302f31312f31382f505259677a6574724f6431754239702e706e67)

大概是这样

```java
 /**
     * 决策
     *
     * @param user 用户信息
     * @return 决策结果
     */
    protected DecisionComponent decision(User user) {
        if (judge(user)) {
            logger.info("进入 {} 决策分支", getName());
            for (DecisionComponent decisionComponent : decisionComponents) {
                if (decisionComponent.judge(user)) {
                    return decisionComponent.decision(user);
                }
            }
        }
        return null;
    }
```

### 策略模式 | 这一步不算,重来哈(下棋ing)

下棋, 每个人面对同样的棋局, 可能下的每一步都不一样吧

#### 实现

我们可以把相应的算法提取成一个接口, 实现各个算法

例如排序算法有那么多种

我们知道每种排序算法在不同的数据量面前是会有不同的表现的

我们可以在数据集少的时候用冒泡排序

多的时候时候用快速排序

需要前后顺序不变的时候使用不同的排序

### 模板方法模式 | 流水线作业

我们要去刷抖音

1. 拿出手机

2. 解锁

3. 打开抖音

4. 一点都不好玩

例如第一步, 不论你是从口袋,沙发还是哪里的找到手机, 第一步总得去找到手机吧

#### 实现

我们可以定义一个抽象类, 定义几个方法,

一个方法把流程都规定好

按部就班就行生产

### 观察者模式 | 别怕,有我是你的福气

地震仪, 如果某个指标超过了, 就通知我们说要地震了

#### 实现

监听器一样

我们把我们需要监听的事件,需要回调的动作告诉监听者,

让他状态改变了就通知我们

zookeeper中的监听器通过监听器也就是观察者模式

znode的节点状态改变就通知我们的程序做相应的动作

### 责任链模式 | 多层过滤

我们养金鱼的时候, 需要给水过滤,

按水流的方向，过滤系统的滤材的设置顺序为：进水口→(水泵)→物理过滤→化学过滤→生物过滤→(水泵)→出水口 [养金鱼的过滤系统 - 金鱼饲养 - 金鱼 - 观赏鱼百科 (longdian.com)](http://jinyu.longdian.com/baike/view-2695.html)

![](http://static2.longyu.longdear.net/baike/201408/01/172326itwjoppyowwr3r5o.jpg.thumb.jpg)

#### 实现

我们可以通过持有下一级对象, 把资源传递到下一级,最后得到我们最终的结果

就想我们的filter chain 过滤器的调用链一样, 一级一级过滤, 最后到达我们业务的时候帮我们已经帮我们做好了很多事情了

### 备忘录模式 | 存档

游戏存档

关机重启后, 我们可以从读档继续游戏

不用重头开始刷关卡

#### 实现

mysql中读分为快照读跟当前读

快照读相当于我们存档了, 读取我们之前已经存档的记录了

得益于我们的序列化接口 Serializable, 我们可以通过将我们的对象存放到我们本地,

以及我们的 ObjectOutputStream 对象输出流

不用我们一个一个属性用输出流持久化到本地

### 迭代器模式 | 数绵羊

睡觉时 数绵羊

#### 实现

通过增强for 其实我们用的就是迭代器

大数据量还是用数组下标索引为好

### 命令模式 | 遥控器

可再参读 [行为型 - 命令模式(Command) | Java 全栈知识体系 (pdai.tech)](https://pdai.tech/md/dev-spec/pattern/18_command.html)

Linux 中有很多命令

例如删除文件 rm -rf

有了这个指令, 我们就可以不用像打孔做数据的时代一样

亲自到磁盘去消除这个文件

本来我们要遥控到下一个台 需要到电视机的按钮点击

现在有了有遥控器 我们可以远程进行操控 更加方便

#### 实现

我们请求一个网页, 我输入一个网址到浏览器, 这个网址就相当于发了一个遥控信号,

我们给浏览器一个网址

使用Runnable 我们将命令包装好丢给线程池 让线程池帮我们处理

### 状态模式 | 脉动回来

饿货 来根士力架 

呃 来劲了

通过士力架, 改变了我们的状态, 不饿了

同时也改变了我们的行为

#### 实现

我们可以把类中状态改变之后设置新的行为

### 中介者模式 | 没有中间商赚差价

boss 直聘

找工作, 直接跟老板沟通

我们办档案的时候, 需要去跑各个局之类的

我们可以找到我们的中间商帮我们去帮我们把调档案给我们办下来

#### 实现

通过增加一个类, 把我们复杂的操作都放到一个类里面

我们只需要组装好数据就能马上得到我们的结果

我们原先操作jdbc去crud 数据库

现在我们可以通过mybatis jpa帮我们去操作数据库

节省了我们的操作

### 访问者模式 | 是谁来找过我

[行为型 - 访问者(Visitor) | Java 全栈知识体系 (pdai.tech)](https://pdai.tech/md/dev-spec/pattern/20_visitor.html)

> 将作用于某种数据结构中的各元素的操作分离出来封装成独立的类，使其在不改变数据结构的前提下可以添加作用于这些元素的新的操作，为数据结构中的每个元素提供多种访问方式。它将对数据的操作与数据结构进行分离

#### 实现

通过借助 回调 达到统计不同访问者的数量

```java
public class Item implements Element {

    private String name;

    Item(String name) {
        this.name = name;
    }

    String getName() {
        return name;
    }

    public void accept(Visitor visitor) {
        visitor.visit(this);
    }
}visitor.html
```

```java
public interface Visitor {
    void visit(Customer customer);
    void visit(Order order);
    void visit(Item item);
}
```

```java
public class GeneralReport implements Visitor {

    private int customersNo;
    private int ordersNo;
    private int itemsNo;

    public void visit(Customer customer) {
       System.out.println(customer.getName());
        customersNo++;
    }

    public void visit(Order order) {
        System.out.println(order.getName());
        ordersNo++;
    }

    public void visit(Item item) {
        System.out.println(item.getName());
        itemsNo++;
    }

    public void displayResults() {
        System.out.println("Number of customers: " + customersNo);
        System.out.println("Number of orders:    " + ordersNo);
        System.out.println("Number of items:     " + itemsNo);
    }
}
```

### 解释器模式 | 创造另一种语言

我觉得没什么用呀

#### 实现