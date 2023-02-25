## 算法快速入门

[Introduction - algorithm-pattern](https://greyireland.gitbook.io/algorithm-pattern/)





## 数组

### 二分法

适用于已经排好序的数组 查询元素位置

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



## 贪心算法

贪心算法讲解

https://www.bilibili.com/video/BV1WK4y1R71x/?vd_source=eabc2c22ae7849c2c4f31815da49f209



贪心算法 -> 通过局部最优退出全局最优

通过反证法 无法推翻





## 动态规划

https://www.bilibili.com/video/BV1AB4y1w7eT/?vd_source=eabc2c22ae7849c2c4f31815da49f209
