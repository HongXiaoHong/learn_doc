# python 常用

## 命令行交互
### subprocess
[6个例子快速学会python中subprocess库的使用](https://blog.csdn.net/Light2077/article/details/110913337)


## python 获取索引

[python找到匹配字符串的下标_mob64ca12e10b51的技术博客_51CTO博客](https://blog.51cto.com/u_16213367/7079445?u_atoken=a263cdb5-193d-449a-930a-a26ebf81f4b9&u_asession=01gKpGvzZH_OmtCdDsHJrnvEaxfpoqvWo3vDKz8s2WJsGFSYOIVRORv9bjOstb4-p9X0KNBwm7Lovlpxjd_P_q4JsKWYrT3W_NKPr8w6oU7K89CcNrFxNKovazwBIoPreB0m7LH8O4V0ZTTM4JLKkrLmBkFo3NEHBv0PZUm6pbxQU&u_asig=05f-Duj2m8axJxW3LYYvXLZQrrSiV1cM5PAgqLq3JHRkKh_1SFFDQiIGq2m-G3efuOlJEpNsMBWyuolGWD3cqQ76sdj64SaN3jxYayOHia2QGtEE5EOloDGT6teLyl2_QkVBmQOMSkNqao3bFY9C5c2kJ4EIZ4kwUITYaHI16pz7z9JS7q8ZD7Xtz2Ly-b0kmuyAKRFSVJkkdwVUnyHAIJzf7HfqT-HES1gDU1Uigrx8ukve4I1q44L_0fKgpLL4hTDXb2VccbfKnXF2pqjvMlv-3h9VXwMyh6PgyDIVSG1W-_HgCgt39x5pQVehR1-IqcUa23l0f3L1wibGI-E2ARH6J-_bCoTW2azAKjGUipBwniNSsG666ETMQbtQAOZXstmWspDxyAEEo4kbsryBKb9Q&u_aref=2yptvFxvKTL%2B%2BqZI%2BjJU3qg7NlA%3D)

- string
  
  - find
  
  - index

- re search



```python
import re

str = "Hello, World!"
pattern = r"o"
match = re.search(pattern, str)
if match:
    print(match.start())  # 输出 4
```
