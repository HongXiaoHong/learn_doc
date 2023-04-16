# structure

数据结构

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





### 红黑树

#### 入门

[喵的算法课】红黑树 插入【11期】](https://www.bilibili.com/video/BV1BB4y1X7u3/?vd_source=eabc2c22ae7849c2c4f31815da49f209)
