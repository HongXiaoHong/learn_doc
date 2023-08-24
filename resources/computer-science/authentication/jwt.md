# jwt 认证

jwt 包括三部分
header  头部信息jwt 加密算法
payload 负载 用户信息
signification 验证

header 跟 payload 都是使用 base64 进行编码
不要存放敏感信息

signification则是拿来验证前面信息的正确


在token前面加上Bearer是一种规范
https://blog.csdn.net/menghuannvxia/article/details/127516437?spm=1001.2101.3001.6650.8&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-8-127516437-blog-123033566.235%5Ev38%5Epc_relevant_anti_vip&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-8-127516437-blog-123033566.235%5Ev38%5Epc_relevant_anti_vip&utm_relevant_index=11