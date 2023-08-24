# structure

数据结构

## 栈/队列

### Stack & Queue概述

Java里有一个叫做*Stack*的类，却没有叫做*Queue*的类(它是个接口名字)。当需要使用栈时，Java已不推荐使用*Stack*，而是推荐使用更高效的*ArrayDeque*；既然*Queue*只是一个接口，当需要使用队列时也就首选*ArrayDeque*了(次选是*LinkedList*)。

#### Queue

*Queue*接口继承自Collection接口，除了最基本的Collection的方法之外，它还支持额外的*insertion*, *extraction*和*inspection*操作。这里有两组格式，共6个方法，一组是抛出异常的实现；另外一组是返回值的实现(没有则返回null)。

|         | Throws exception | Returns special value |
| ------- | ---------------- | --------------------- |
| Insert  | add(e)           | offer(e)              |
| Remove  | remove()         | poll()                |
| Examine | element()        | peek()                |

#### Deque

`Deque`是"double ended queue", 表示双向的队列，英文读作"deck". Deque 继承自 Queue接口，除了支持Queue的方法之外，还支持`insert`, `remove`和`examine`操作，由于Deque是双向的，所以可以对队列的头和尾都进行操作，它同时也支持两组格式，一组是抛出异常的实现；另外一组是返回值的实现(没有则返回null)。共12个方法如下:

|         | First Element - Head |               | Last Element - Tail |               |
| ------- | -------------------- | ------------- | ------------------- | ------------- |
|         | Throws exception     | Special value | Throws exception    | Special value |
| Insert  | addFirst(e)          | offerFirst(e) | addLast(e)          | offerLast(e)  |
| Remove  | removeFirst()        | pollFirst()   | removeLast()        | pollLast()    |
| Examine | getFirst()           | peekFirst()   | getLast()           | peekLast()    |

当把`Deque`当做FIFO的`queue`来使用时，元素是从`deque`的尾部添加，从头部进行删除的； 所以`deque`的部分方法是和`queue`是等同的。具体如下:

| Queue Method | Equivalent Deque Method |
| ------------ | ----------------------- |
| add(e)       | addLast(e)              |
| offer(e)     | offerLast(e)            |
| remove()     | removeFirst()           |
| poll()       | pollFirst()             |
| element()    | getFirst()              |
| peek()       | peekFirst()             |

*Deque*的含义是“double ended queue”，即双端队列，它既可以当作栈使用，也可以当作队列使用。下表列出了*Deque*与*Queue*相对应的接口:

| Queue Method | Equivalent Deque Method | 说明                     |
| ------------ | ----------------------- | ---------------------- |
| `add(e)`     | `addLast(e)`            | 向队尾插入元素，失败则抛出异常        |
| `offer(e)`   | `offerLast(e)`          | 向队尾插入元素，失败则返回`false`   |
| `remove()`   | `removeFirst()`         | 获取并删除队首元素，失败则抛出异常      |
| `poll()`     | `pollFirst()`           | 获取并删除队首元素，失败则返回`null`  |
| `element()`  | `getFirst()`            | 获取但不删除队首元素，失败则抛出异常     |
| `peek()`     | `peekFirst()`           | 获取但不删除队首元素，失败则返回`null` |

下表列出了*Deque*与*Stack*对应的接口:

| Stack Method | Equivalent Deque Method | 说明                     |
| ------------ | ----------------------- | ---------------------- |
| `push(e)`    | `addFirst(e)`           | 向栈顶插入元素，失败则抛出异常        |
| 无            | `offerFirst(e)`         | 向栈顶插入元素，失败则返回`false`   |
| `pop()`      | `removeFirst()`         | 获取并删除栈顶元素，失败则抛出异常      |
| 无            | `pollFirst()`           | 获取并删除栈顶元素，失败则返回`null`  |
| `peek()`     | `getFirst()`            | 获取但不删除栈顶元素，失败则抛出异常     |
| 无            | `peekFirst()`           | 获取但不删除栈顶元素，失败则返回`null` |

上面两个表共定义了*Deque*的12个接口。添加，删除，取值都有两套接口，它们功能相同，区别是对失败情况的处理不同。**一套接口遇到失败就会抛出异常，另一套遇到失败会返回特殊值(`false`或`null`)**。除非某种实现对容量有限制，大多数情况下，添加操作是不会失败的。**虽然*Deque*的接口有12个之多，但无非就是对容器的两端进行操作，或添加，或删除，或查看**。明白了这一点讲解起来就会非常简单。

*ArrayDeque*和*LinkedList*是*Deque*的两个通用实现，由于官方更推荐使用*AarryDeque*用作栈和队列，加之上一篇已经讲解过*LinkedList*，本文将着重讲解*ArrayDeque*的具体实现。

从名字可以看出*ArrayDeque*底层通过数组实现，为了满足可以同时在数组两端插入或删除元素的需求，该数组还必须是循环的，即**循环数组(circular array)**，也就是说数组的任何一点都可能被看作起点或者终点。*ArrayDeque*是非线程安全的(not thread-safe)，当多个线程同时使用的时候，需要程序员手动同步；另外，该容器不允许放入`null`元素。

### 队列

#### java 中的实现

接口: Queue Deque

实现: LinkedList、ArrayDeque、PriorityQueue

常用方法 offer()、poll()、peek()、element()

Queue 接口是一个标准的队列接口，它定义了队列的基本操作方法，如添加元素、删除元素、查看队头元素、获取队列大小等方法。除了这些基本方法，Queue 接口还提供了一些其他的方法，如 offer()、poll()、peek()、element() 等方法，用于支持不同的队列实现类。

Queue 接口是一个很好的抽象，它可以被许多实现类来实现不同的队列结构，例如 LinkedList、ArrayDeque、PriorityQueue 等。这些实现类各自具有不同的特点，可以根据业务需求和性能要求来选择不同的实现类。

需要注意的是，Queue 接口本身并不包含栈的操作方法，如果需要实现栈的操作，可以使用 Deque（双端队列）接口，它扩展了 Queue 接口，并提供了栈的操作方法

### 栈

java中 <mark>Deque（双端队列）</mark>

常用方法: push(E e)、pop()、peek()

## 树

### 二叉树

[(2条消息) 二叉树遍历（前序、中序、后序、层次遍历、深度优先、广度优先）_Yadoer的博客-CSDN博客_二叉树的先序,中序,后序遍历](https://blog.csdn.net/My_Jobs/article/details/43451187)

#### 递归遍历

前中后 换一下处理的位置就可以了

前序遍历:

```java
class Solution {
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> result= new LinkedList<>();
        traverse(root, result);
        return result;
    }

    private void traverse(TreeNode cur, List<Integer> result) {
        if (cur == null) {
            return;
        }
        result.add(cur.val);
        traverse(cur.left, result);
        traverse(cur.right, result);
    }
}
```

#### 非递归方式

前序遍历:

```java
public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> result= new LinkedList<>();
        traverse(root, result);
        return result;
    }

    private void traverse(TreeNode cur, List<Integer> result) {
        Deque<TreeNode> cache = new ArrayDeque<>();
        cache.push(cur);
        while (!cache.isEmpty()) {
            TreeNode temp = cache.pop();
            result.add(temp.val);
            if (temp.right !=null) {
                cache.push(temp.right);
            }
            if (temp.left !=null) {
                cache.push(temp.left);
            }
        }
    }
```

后序遍历:

```java
public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> result= new LinkedList<>();
        traverse(root, result);
        return result;
    }

    private void traverse(TreeNode cur, List<Integer> result) {
        Deque<TreeNode> cache = new ArrayDeque<>();
        cache.push(cur);
        while (!cache.isEmpty()) {
            TreeNode temp = cache.pop();
            result.add(temp.val);
            if (temp.left !=null) {
                cache.push(temp.left);
            }
            if (temp.right !=null) {
                cache.push(temp.right);
            }
        }
        Collections.reverse(result);
    }
```

中序遍历:

```java

```

### 堆

相当于 完全二叉树

大根堆: 每颗子树 头结点都是最大的

小根堆: 每颗子树 头结点都是最小的

java中默认实现:  <mark>PriorityQueue 底层默认是小根堆</mark>

### B-树

[B-Tree_可视化_增删改查(usfca.edu)](https://www.cs.usfca.edu/~galles/visualization/BTree.html)

### 红黑树

#### 入门

[喵的算法课】红黑树 插入【11期】](https://www.bilibili.com/video/BV1BB4y1X7u3/?vd_source=eabc2c22ae7849c2c4f31815da49f209)

## 跳表

[Skip List--跳表（全网最详细的跳表文章没有之一） - 简书 (jianshu.com)](https://www.jianshu.com/p/9d8296562806)

可以进行二分查找的链表

空间换时间
