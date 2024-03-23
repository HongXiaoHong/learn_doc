# java

## 源码分析

### 数据结构

#### map | 映射

#### hashmap | 哈希表

[解读HashMap中hash算法的巧妙设计](https://www.bilibili.com/video/BV1SA411E7T4/?spm_id_from=333.788.recommend_more_video.4&vd_source=eabc2c22ae7849c2c4f31815da49f209)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_PX5Six9vo2.png)

高低位混合运算

是为了更好利用所有数据位进行运算,减少哈希冲突

(len - 1) & hash 值 是为了给 hash 数组进行取模得到余数

len - 1 可以计算出数据, 算出长度减 1, 得到 2^n n-1 位都是 1 的数字

通过 & 就可以得到对应的 余数
