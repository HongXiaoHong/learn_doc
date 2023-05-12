# Oracle

[(25条消息) Oracle 在字符串中输入单引号或特殊字符_shangboerds的博客-CSDN博客](https://blog.csdn.net/shangboerds/article/details/46538579)
字符串是用单引号括起来的，如果想在字符串中输入单引号该怎么办呢？有两种方法。

方法一：是用两个单引号代表一个单引号

```sql
SELECT 'I''m Shangbo' FROM DUAL;
```

方法二：使用 Oracle 特殊语法

```sql
SELECT q'/I'm Shangbo/' FROM DUAL;
```

事实上，我们可以使用方法二输入任何特殊字符，包括换行。

```sql
SELECT q'/I'm 
Shangbo/' FROM DUAL;
```