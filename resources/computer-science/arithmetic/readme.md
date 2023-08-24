## 算法快速入门

⭐[GitHub - youngyangyang04/leetcode-master: 《代码随想录》LeetCode 刷题攻略：200道经典题目刷题顺序，共60w字的详细图解，视频难点剖析，50余张思维导图，支持C++，Java，Python，Go，JavaScript等多语言版本，从此算法学习不再迷茫！🔥🔥 来看看，你会发现相见恨晚！🚀](https://github.com/youngyangyang04/leetcode-master)

🍚[看动画，拿 Offer-剑指offer](https://blog.algomooc.com/)

🥜[Introduction - algorithm-pattern](https://greyireland.gitbook.io/algorithm-pattern/)

## 数组

### 二分法

适用于已经排好序的数组 且元素不重复 查询元素位置

注意判断的边界 这种左闭右闭区间

[leetcode-master/0704.二分查找.md at master · youngyangyang04/leetcode-master · GitHub](https://github.com/youngyangyang04/leetcode-master/blob/master/problems/0704.%E4%BA%8C%E5%88%86%E6%9F%A5%E6%89%BE.md)

```java
public int search(int[] nums, int target) {
        int left = 0;
        int right = nums.length - 1;

        int middle = 0;
        while (left <= right) {
            middle = (left + right) / 2;
            if (nums[middle] > target) {
                right = middle - 1;
            } else if (nums[middle] < target) {
                left = middle + 1;
            } else {
                return middle;
            }
        }
        return -1;
    }
```

### 双指针

## 贪心算法

贪心算法讲解

https://www.bilibili.com/video/BV1WK4y1R71x/?vd_source=eabc2c22ae7849c2c4f31815da49f209

贪心算法 -> 通过局部最优退出全局最优

通过反证法 无法推翻

## 动态规划

https://www.bilibili.com/video/BV1AB4y1w7eT/?vd_source=eabc2c22ae7849c2c4f31815da49f209


## 喷泉码
https://juejin.cn/post/6844903896834375694