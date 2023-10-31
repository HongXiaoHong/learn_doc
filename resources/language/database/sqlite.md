# sqlite

## 入门
https://www.cnblogs.com/desireyang/p/13234985.html
https://www.sqlitetutorial.net/
https://www.twle.cn/l/yufei/sqlite/sqlite-basic-operators.html

## 常用SQL

列出所有表格 

```sql
SELECT name FROM sqlite_master WHERE type='table' order by name
```