# mysql
## 常用
### 分组前几行

[mysql按组区分后获取每组前几名的sql写法（以及学生各科成绩大于多少分的总结）](https://blog.csdn.net/qq_21187515/article/details/109902427)


```sql
###每科成绩前三名
SELECT
	* 
FROM
	score s1 
WHERE
	( SELECT count( * ) FROM score s2 
	           WHERE s1.`subject` = s2.`subject` AND s1.score < s2.score 
	) < 3 
ORDER BY
	SUBJECT,
	score DESC


```

这个 SQL 是真诡异
如果是Oracle或者是 mysql 8.0 及以上 就可以使用 分析函数进行优化