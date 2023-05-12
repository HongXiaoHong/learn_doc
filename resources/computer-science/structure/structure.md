# structure

数据结构

## 队列

### java 中的实现

接口: Queue Deque

实现: LinkedList、ArrayDeque、PriorityQueue

常用方法 offer()、poll()、peek()、element()

Queue 接口是一个标准的队列接口，它定义了队列的基本操作方法，如添加元素、删除元素、查看队头元素、获取队列大小等方法。除了这些基本方法，Queue 接口还提供了一些其他的方法，如 offer()、poll()、peek()、element() 等方法，用于支持不同的队列实现类。

Queue 接口是一个很好的抽象，它可以被许多实现类来实现不同的队列结构，例如 LinkedList、ArrayDeque、PriorityQueue 等。这些实现类各自具有不同的特点，可以根据业务需求和性能要求来选择不同的实现类。

需要注意的是，Queue 接口本身并不包含栈的操作方法，如果需要实现栈的操作，可以使用 Deque（双端队列）接口，它扩展了 Queue 接口，并提供了栈的操作方法

## 栈

java中 <mark>Deque（双端队列）</mark>

常用方法: push(E e)、pop()、peek()

## 数

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

### 红黑树

#### 入门

[喵的算法课】红黑树 插入【11期】](https://www.bilibili.com/video/BV1BB4y1X7u3/?vd_source=eabc2c22ae7849c2c4f31815da49f209)





## 跳表

[Skip List--跳表（全网最详细的跳表文章没有之一） - 简书 (jianshu.com)](https://www.jianshu.com/p/9d8296562806)



可以进行二分查找的链表

空间换时间
