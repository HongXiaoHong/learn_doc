stream.forEach()循环

- 处理集合时不能使用break和continue中止循环；
- 可以使用关键字return跳出本次循环，并执行下一次遍历。
- 不能跳出整个forEach的循环。

## lampda

### lampda 简写

```java
/**
 *
 */


@FunctionalInterface
interface LambdaInterface {
    void f();
}

class LambdaClassSuper {
    public LambdaClassSuper() {
        System.out.println("new LambdaClassSuper");
    }

    LambdaInterface sf(){
        System.out.println("what are doing in sf");
        return null;
    }
}

public class LambdaClass extends LambdaClassSuper {
    public static void staticF() {
        System.out.println("staticF");
    }

    public LambdaInterface f() {
        return null;
    }

    void show() {
        //1.调用静态函数，返回类型必须是functional-interface
        LambdaInterface t = LambdaClass::staticF;
        t.f();

        //2.实例方法调用
        LambdaClass lambdaClass = new LambdaClass();
        LambdaInterface lambdaInterface = lambdaClass::f;

        //3.超类上的方法调用
        LambdaInterface superf = super::sf;

        //4. 构造方法调用
        LambdaInterface tt = LambdaClassSuper::new;
        tt.f();
    }

    public static void main(String[] args) {
        LambdaClass test = new LambdaClass();
        test.show();
    }
}
```

可以使用 :: 简写

会将后面引用的方法作为 函数的方法给到函数式接口的方法

## optional

[还在使用If语句判空？快来试试Optional | 语法糖 | JDK8 新特性 | lambda 表达式 | 链式编程 | 高级玩法_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1H3411Q7q6/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## 常用

[聊聊工作中常用的Lambda表达式_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1JW4y1j7eU/?spm_id_from=333.788.recommend_more_video.6&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## Stream

### 常用api

#### Collectors.groupingBy

[java8中的Collectors.groupingBy用法_兴国First的博客-CSDN博客_collectors.groupingby](https://blog.csdn.net/u014231523/article/details/102535902)

组装数据

```java
public Product(Long id, Integer num, BigDecimal price, String name, String category) {
    this.id = id;
    this.num = num;
    this.price = price;
    this.name = name;
    this.category = category;
}

Product prod1 = new Product(1L, 1, new BigDecimal("15.5"), "面包", "零食");
Product prod2 = new Product(2L, 2, new BigDecimal("20"), "饼干", "零食");
Product prod3 = new Product(3L, 3, new BigDecimal("30"), "月饼", "零食");
Product prod4 = new Product(4L, 3, new BigDecimal("10"), "青岛啤酒", "啤酒");
Product prod5 = new Product(5L, 10, new BigDecimal("15"), "百威啤酒", "啤酒");
List<Product> prodList = Lists.newArrayList(prod1, prod2, prod3, prod4, prod5);
```

```java
Map<String, List<Product>> prodMap= prodList.stream().collect(Collectors.groupingBy(Product::getCategory));

//{"啤酒":[{"category":"啤酒","id":4,"name":"青岛啤酒","num":3,"price":10},{"category":"啤酒","id":5,"name":"百威啤酒","num":10,"price":15}],"零食":[{"category":"零食","id":1,"name":"面包","num":1,"price":15.5},{"category":"零食","id":2,"name":"饼干","num":2,"price":20},{"category":"零食","id":3,"name":"月饼","num":3,"price":30}]}
```