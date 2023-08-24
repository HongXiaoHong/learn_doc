# 编程语言语法对比

## 异常
### python

以下是Python中异常处理的基本概念和常用代码的总结：

#### 异常处理的几种方式

1. **Try, Except**
2. **Try, Except, Finally**
3. **Try, Except, Except, Finally**
4. **用户定义的异常**

#### 详细说明和代码示例

##### Try, Except

这是处理异常的基本结构。在try块中，你将编写可能会抛出异常的代码。在except块中，你将编写处理异常的代码。

```python
import traceback
try:
    i = 10
    j = i/0
except ZeroDivisionError:
    traceback.print_exc()
print("Program Proceeds!")
```

##### Try, Except, Finally

在这种情况下，无论try块中是否发生异常，finally块中的代码都将被执行。这通常用于确保资源（如文件或数据库连接）在程序结束时被正确关闭。

```python
import traceback
fi = None
try:
    fi = open("godzilla.txt", "rb")
    i = 0
    j = i/0
except:
    traceback.print_exc()
finally:
    if fi:
        fi.close()
```

##### Try, Except, Except, Finally

有时可能需要将多个except语句附加到同一个try块中。你应确保按异常层次结构的降序使用异常，因为将首先检查第一个catch块。

```python
import traceback
try:
    i = 10
    j = i/0
    i = [1,2,3]
    print(i[10])
except ZeroDivisionError:
    traceback.print_exc()
except IndexError:
    traceback.print_exc()
except:
    traceback.print_exc()
finally:
    print("Break the rules!")
print("Program Proceeds!")
```

##### 用户定义的异常

有时，Python库提供的异常可能不足以满足我们的应用程序。在这种情况下，我们可以定义自己的异常。

```python
class CosmicException(Exception):
    pass

validPlanets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
def helloPlanet(planetName):
    if planetName not in validPlanets:
        raise CosmicException("Invalid Planet - {}".format(planetName))
    print("Hello {}".format(planetName))

helloPlanet("Earth")
helloPlanet("Pluto")
```

### js

在 ES6，可以使用 `try-catch` 结构来处理异常。`try` 代码块包含可能抛出异常的代码，而 `catch` 代码块则用于处理这些异常。这里有一些常见的使用示例：

```javascript
try {
    // 可能会抛出异常的代码
    const a = JSON.parse(someInvalidJSONString);
} catch (e) {
    // 处理异常的代码
    console.error("Parsing error:", e.message);
}
```

如果你想要在发生异常后再抛出异常，你可以使用 `throw`：

```javascript
try {
    // 可能会抛出异常的代码
    const a = JSON.parse(someInvalidJSONString);
} catch (e) {
    // 处理异常的代码
    console.error("Parsing error:", e.message);

    // 抛出异常
    throw new Error('Something went wrong');
}
```

`finally` 语句块是无论是否发生异常，都会执行的代码：

```javascript
try {
    // 可能会抛出异常的代码
    const a = JSON.parse(someInvalidJSONString);
} catch (e) {
    // 处理异常的代码
    console.error("Parsing error:", e.message);
} finally {
    // 无论是否发生异常，都会执行的代码
    console.log("This will always run");
}
```

这就是在 ES6 中处理异常的一些基本示例。请注意，`catch` 语句块只会捕获 `try` 语句块中抛出的异常。

### java
在 Java 中，异常处理是通过使用 try-catch-finally 语句块和 throws 关键字完成的。下面是一些常见的用法。

1. **Try-Catch-Finally**

在 try 块中，你将尝试可能抛出异常的代码。在 catch 块中，你将处理特定类型的异常。在 finally 块中，你将编写无论是否发生异常都需要执行的代码。

```java
try {
    // 可能会抛出异常的代码
    int division = 10 / 0;
} catch (ArithmeticException e) {
    // 处理异常的代码
    System.out.println("Caught ArithmeticException: " + e.getMessage());
} finally {
    // 无论是否发生异常，都会执行的代码
    System.out.println("This will always run");
}
```

2. **Throws**

如果你不想在当前方法中处理异常，你可以使用 throws 关键字将异常传递给上一级调用该方法的代码处理。这需要在方法签名后添加 throws 关键字，后面跟异常类名。

```java
public void methodThrowingException() throws IOException {
    // 抛出异常
    throw new IOException("Exception thrown");
}
```

然后，你可以在调用该方法的代码中使用 try-catch 结构处理该异常：

```java
try {
    methodThrowingException();
} catch (IOException e) {
    System.out.println("Caught IOException: " + e.getMessage());
}
```

3. **自定义异常**

你还可以创建自定义异常类，以便根据自己的需求抛出特定类型的异常。自定义异常类应该是 Throwable 类或其子类（如 Exception 或 RuntimeException）的子类。

```java
public class CustomException extends Exception {
    public CustomException(String message) {
        super(message);
    }
}
```

然后你可以像这样抛出自定义异常：

```java
throw new CustomException("This is a custom exception");
```

这就是在 Java 中处理异常的一些基本示例。

## 遍历可迭代对象

### java
Java 中的增强型 for 循环（也称为 for-each 循环）。它可以简化遍历数组、集合或其他可遍历对象的操作。在使用增强型 for 循环时，对象必须是一个可遍历对象，也就是需要实现 `java.lang.Iterable` 接口。

`java.lang.Iterable` 接口是 Java 中用于支持增强型 for 循环的核心接口。它包含一个抽象方法 `iterator()`，该方法返回一个迭代器对象，用于遍历可迭代的元素。

在实现可遍历对象时，通常需要实现以下两个步骤：

1. 实现 `java.lang.Iterable` 接口：该接口包含一个抽象方法 `iterator()`，需要返回一个实现了 `java.util.Iterator` 接口的迭代器对象。

2. 实现 `java.util.Iterator` 接口：该接口定义了迭代器的行为，包含方法 `hasNext()` 判断是否有下一个元素，以及 `next()` 返回下一个元素的方法。

下面是一个示例，展示了如何在自定义的可遍历对象中使用增强型 for 循环：

```java
import java.util.Iterator;

public class MyIterableCollection<T> implements Iterable<T> {

    private T[] elements;
    private int size;

    public MyIterableCollection(T[] elements) {
        this.elements = elements;
        this.size = elements.length;
    }

    // 实现 Iterable 接口，返回自定义的迭代器对象
    @Override
    public Iterator<T> iterator() {
        return new MyIterator();
    }

    // 自定义迭代器类，实现 Iterator 接口
    private class MyIterator implements Iterator<T> {
        private int currentIndex = 0;

        @Override
        public boolean hasNext() {
            return currentIndex < size;
        }

        @Override
        public T next() {
            return elements[currentIndex++];
        }
    }

    public static void main(String[] args) {
        // 使用增强型 for 循环遍历自定义的可遍历对象
        Integer[] numbers = {1, 2, 3, 4, 5};
        MyIterableCollection<Integer> collection = new MyIterableCollection<>(numbers);
        for (Integer num : collection) {
            System.out.print(num + " ");
        }
    }
}
```

上面的例子中，我们创建了一个自定义的可遍历对象 `MyIterableCollection`，并使用增强型 for 循环遍历其中的元素。请注意，为了支持增强型 for 循环，我们实现了 `Iterable` 接口，并在其中提供了自定义的迭代器类 `MyIterator`，该迭代器类实现了 `Iterator` 接口。

总结一下，如果你想在 Java 中使用增强型 for 循环遍历对象，你需要确保对象实现了 `java.lang.Iterable` 接口，并返回一个迭代器对象，在该迭代器对象中实现迭代逻辑。

### python
在 Python 中，没有严格意义上的 "foreach" 循环，但是有一种与 Java 中的增强型 for 循环类似的遍历方式，即使用 `for` 循环结合 `in` 关键字来遍历可迭代对象。这种遍历方式更为简洁和灵活，让代码更易读和编写。

在 Python 中，几乎所有的集合对象（例如列表、元组、集合、字典等）都是可迭代的。你可以使用 `for` 循环遍历它们的元素，不需要像 Java 中实现特定的接口。

下面是 Python 中常见的遍历方式示例：

1. 遍历列表：

```python
my_list = [1, 2, 3, 4, 5]
for num in my_list:
    print(num)
```

2. 遍历元组：

```python
my_tuple = (10, 20, 30)
for item in my_tuple:
    print(item)
```

3. 遍历集合：

```python
my_set = {100, 200, 300}
for value in my_set:
    print(value)
```

4. 遍历字典的键：

```python
my_dict = {'a': 1, 'b': 2, 'c': 3}
for key in my_dict:
    print(key)
```

如果你需要同时遍历字典的键和值，可以使用 `items()` 方法：

```python
for key, value in my_dict.items():
    print(key, value)
```

注意，在 Python 中，这种遍历方式适用于所有可迭代对象，而不需要实现类似 Java 中的 `Iterable` 接口。这是 Python 的一大优势之一，让代码更加简洁和直观。

在 Python 中，几乎所有的容器类型都是可迭代对象。可迭代对象是指那些可以通过迭代来访问其元素的对象。以下是 Python 中常见的可迭代对象类型：

1. 列表（List）: 使用方括号 `[]` 表示，例如 `[1, 2, 3]`。
2. 元组（Tuple）: 使用圆括号 `()` 表示，例如 `(1, 2, 3)`。
3. 集合（Set）: 使用花括号 `{}` 表示，例如 `{1, 2, 3}`。
4. 字典（Dictionary）: 使用花括号 `{}` 表示，例如 `{'a': 1, 'b': 2, 'c': 3}`。
5. 字符串（String）: 使用单引号或双引号括起来，例如 `'Hello'` 或 `"World"`。
6. 范围（Range）: 使用 `range()` 函数创建的序列，例如 `range(0, 10)`。
7. 文件对象（File Object）: 使用 `open()` 函数打开文件后返回的文件对象。

除了这些内置的数据结构，还有一些其他类型也是可迭代对象，例如：

8. 自定义类的实例：通过在类中实现 `__iter__()` 方法和 `__next__()`（在 Python 2 中为 `__iter__()` 和 `next()`）方法，可以让自定义类的实例变成可迭代对象。
9. 生成器（Generator）：通过函数中的 `yield` 语句创建的生成器对象是可迭代的。

Python 中的可迭代对象可以通过 `for` 循环来遍历其元素，也可以使用 `iter()` 函数获取一个迭代器对象，然后使用 `next()` 函数逐个访问元素。例如：

```python
# 遍历列表
my_list = [1, 2, 3]
for item in my_list:
    print(item)

# 使用迭代器遍历字符串
my_string = "Hello"
my_iterator = iter(my_string)
print(next(my_iterator))  # 输出 'H'
print(next(my_iterator))  # 输出 'e'
print(next(my_iterator))  # 输出 'l'
print(next(my_iterator))  # 输出 'l'
print(next(my_iterator))  # 输出 'o'
```

总结：在 Python 中，可迭代对象包括列表、元组、集合、字典、字符串、范围、文件对象以及自定义的可迭代类型（通过实现特定的方法）。这种可迭代性使得 Python 的循环非常灵活和方便。

### JavaScript
for...in 语句以任意顺序迭代对象的可枚举属性。
https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for...in#array_iteration_and_for...in

for...of 语句遍历可迭代对象定义要迭代的数据。
https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for...of

```javascript
var iterable = {
  [Symbol.iterator]() {
    return {
      i: 0,
      next() {
        if (this.i < 3) {
          return { value: this.i++, done: false };
        }
        return { value: undefined, done: true };
      },
    };
  },
};

for (var value of iterable) {
  console.log(value);
}
// 0
// 1
// 2

```


在 JavaScript 中，遍历可迭代对象可以使用不同的方式，取决于对象的类型和开发者的需求。以下是 JavaScript 中常见的遍历可迭代对象的方式：

1. 使用 for...of 循环：`for...of` 循环是 ES6 中引入的一种语法，用于遍历可迭代对象的元素。它可以直接遍历数组、字符串、Set、Map 等可迭代对象的元素。

```javascript
// 遍历数组
const myArray = [1, 2, 3];
for (const item of myArray) {
  console.log(item);
}

// 遍历字符串
const myString = "Hello";
for (const char of myString) {
  console.log(char);
}

// 遍历 Set
const mySet = new Set([10, 20, 30]);
for (const value of mySet) {
  console.log(value);
}

// 遍历 Map
const myMap = new Map([
  ["a", 1],
  ["b", 2],
  ["c", 3],
]);
for (const [key, value] of myMap) {
  console.log(key, value);
}
```

2. 使用 forEach 方法：数组对象有一个 `forEach` 方法，它接受一个回调函数作为参数，并且可以遍历数组的每个元素。

```javascript
const myArray = [1, 2, 3];
myArray.forEach((item) => {
  console.log(item);
});
```

3. 使用 for 循环：对于普通的数组，你也可以使用传统的 for 循环来遍历它。

```javascript
const myArray = [1, 2, 3];
for (let i = 0; i < myArray.length; i++) {
  console.log(myArray[i]);
}
```

4. 使用 Object.keys、Object.values、Object.entries：对于普通对象，你可以使用这些方法来遍历其键、值或键值对。

```javascript
const myObject = { a: 1, b: 2, c: 3 };

// 遍历键
for (const key of Object.keys(myObject)) {
  console.log(key);
}

// 遍历值
for (const value of Object.values(myObject)) {
  console.log(value);
}

// 遍历键值对
for (const [key, value] of Object.entries(myObject)) {
  console.log(key, value);
}
```

总结：JavaScript 中可以使用 `for...of` 循环、`forEach` 方法、传统的 for 循环以及 `Object.keys`、`Object.values`、`Object.entries` 方法来遍历可迭代对象。这些方法能够满足不同场景下的遍历需求。


## in

### js
for in
用来遍历对象的属性

prop in object
用来判断属性是否是对象的一个属性

这里还发现了一个神奇的点

delete 删除数组的时候, 删除索引, 但是没有把数组的其他索引重新编排
array.splice 方法可以将数组的索引重新编排

```JavaScript
var mycar = { make: "Honda", model: "Accord", year: 1998 };
delete mycar.make;
"make" in mycar; // 返回 false

var trees = new Array("redwood", "bay", "cedar", "oak", "maple");
delete trees[3];
3 in trees; // 返回 false
false
trees
(5) ['redwood', 'bay', 'cedar', 空, 'maple']
0
: 
"redwood"
1
: 
"bay"
2
: 
"cedar"
4
: 
"maple"
length
: 
5
[[Prototype]]
: 
Array(0)
var mycar = { make: "Honda", model: "Accord", year: 1998 };
delete mycar.make;
"make" in mycar; // 返回 false

var trees = new Array("redwood", "bay", "cedar", "oak", "maple");
trees.splice(3, 1);
3 in trees; // 返回 false
true
trees
(4) ['redwood', 'bay', 'cedar', 'maple']
0
: 
"redwood"
1
: 
"bay"
2
: 
"cedar"
3
: 
"maple"
length
: 
4
[[Prototype]]
: 
Array(0)
```

### python


在Python中，`in`是一个成员运算符，用于检查一个值是否存在于一个容器（如字符串、列表、元组、集合、字典等）中。`in`返回一个布尔值，表示待检查的值是否存在于容器中。

下面是`in`运算符在不同容器类型中的使用示例：

1. 在列表中检查元素是否存在：

```python
my_list = [1, 2, 3, 4, 5]
print(3 in my_list)  # True
print(6 in my_list)  # False
```

2. 在字符串中检查子串是否存在：

```python
my_string = "Hello, world!"
print("Hello" in my_string)  # True
print("Python" in my_string)  # False
```

3. 在元组中检查元素是否存在：

```python
my_tuple = (10, 20, 30, 40, 50)
print(20 in my_tuple)  # True
print(60 in my_tuple)  # False
```

4. 在集合中检查元素是否存在：

```python
my_set = {1, 2, 3, 4, 5}
print(3 in my_set)  # True
print(6 in my_set)  # False
```

5. 在字典中检查键是否存在：

```python
my_dict = {"name": "Alice", "age": 30, "city": "New York"}
print("age" in my_dict)  # True
print("gender" in my_dict)  # False
```

`in`运算符对于容器类型在Python中非常有用，它可以用来检查元素、子串或键是否存在于容器中，从而方便地进行数据查找和判断。注意在使用`in`运算符时，容器类型必须是支持成员关系测试的类型，否则会导致TypeError异常。


## 私有属性
- JavaScript | #
- java | private

### 私有静态变量引用

#### JavaScript | #

会有语法错误提醒

```JavaScript
class ClassWithPrivateField {
  #privateField;

  constructor() {
    this.#privateField = 42;
    delete this.#privateField;   // 语法错误
    this.#undeclaredField = 444; // 语法错误
  }
}

const instance = new ClassWithPrivateField()
instance.#privateField === 42;   // 语法错误

```

#### java | private

```java
public class Main {
    public static void main(String []args) {
       int value = Child.getStaticValue(); // Calling the static method from Child class
        System.out.println("Value from Child: " + value);
    }
}

class Parent {
    private static int staticValue = 10;

    static int getStaticValue() {
        return this.staticValue;
    }
}

class Child extends Parent {
    // No need to override the static method, just inherit it
    // Child class cannot directly access private staticValue
}



```

java 中无法在静态方法中使用 this
编译期间就会报错

编译错误：Main.java:12: error: non-static variable this cannot be referenced from a static context
        return this.staticValue;
               ^
1 error
