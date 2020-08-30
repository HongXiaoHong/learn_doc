## 环境说明

1. 系统环境： Windows10专业版
2. MySQL版本： mysql-8.0.16-winx64

## 操作说明

### 划重点了

<u>**打开cmd的时候记得使用操作员权限打开**</u>

### 操作过程

#### 关闭本地的MySQL服务

#### 使用操作员权限打开第一个cmd

1. 先进入MySQL安装目录的bin目录下 
2. 输入指令 mysqld --shared-memory --user=mysql --skip-grant-tables --skip-networking
3. 请记住先不要关 先不要关 先不要关 重要的事情说三遍

```cmd
C:\WINDOWS\system32>d:

D:\>cd D:\app\code\mysql\mysql-8.0.16-winx64\bin
D:\app\code\mysql\mysql-8.0.16-winx64\bin>mysqld --shared-memory --user=mysql --skip-grant-tables --skip-networking
```



#### 使用操作员权限打开第二个cmd

修改密码过程如下

1. 先进入bin目录
2. 使用mysql指令进入对话模式
3. 使用update语句修改密码为空 
4. 使用flush指令刷新授权
5. 退出
6. 重新用mysql -uroot 进入对话模式
7. 切换数据库use mysql
8. 查询一下select user,host from user; 如果host是localhost 下面就用localhost 如果是% 下面就用 %
9. 这里是% 所以这里用ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123'; 修改密码
10. 使用flush刷新权限 flush privileges;
11. 退出
12. 使用mysql -uroot -p验证修改密码是否正确
13. 退出 这时方可关闭第一个cmd

正确方式：

```sql
C:\WINDOWS\system32>d:

D:\>cd D:\app\code\mysql\mysql-8.0.16-winx64\bin

D:\app\code\mysql\mysql-8.0.16-winx64\bin>mysql -u root mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 8.0.16 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> update user set authentication_string='' where user='root';--将字段置为空
Query OK, 1 row affected (0.10 sec)
Rows matched: 1  Changed: 1  Warnings: 0

    -> ;

mysql> select user,authentication_string from mysql.user\G
*************************** 1. row ***************************
                 user: root
authentication_string:
*************************** 2. row ***************************
                 user: mysql.infoschema
authentication_string: $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED
*************************** 3. row ***************************
                 user: mysql.session
authentication_string: $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED
*************************** 4. row ***************************
                 user: mysql.sys
authentication_string: $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED
4 rows in set (0.00 sec)

mysql> exit
Bye

D:\app\code\mysql\mysql-8.0.16-winx64\bin>mysql -uroot
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.16 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| foctool_sunriver   |
| foctool_yext       |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test               |
+--------------------+
7 rows in set (0.05 sec)

mysql> use mysql
Database changed
mysql> select user,host from user;
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| root             | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
+------------------+-----------+
4 rows in set (0.00 sec)

mysql> ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123';
Query OK, 0 rows affected (0.07 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.08 sec)

mysql> quit
Bye

D:\app\code\mysql\mysql-8.0.16-winx64\bin>mysql -uroot -p
Enter password: ***
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.16 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit
Bye
```







### 错误的方式

```cmd
C:\WINDOWS\system32>d:

D:\>cd D:\app\code\mysql\mysql-8.0.16-winx64\bin

D:\app\code\mysql\mysql-8.0.16-winx64\bin>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 8.0.16 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> update mysql.user set authentication_string=password('825z.jkc76') where user='root' and Host = 'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '('825z.jkc76') where user='root' and Host = 'localhost'' at line 1
mysql> update mysql.user set authentication_string=password('82576') where user='root' and Host = 'localhost';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '('82576') where user='root' and Host = 'localhost'' at line 1
mysql> update mysql.user set authentication_string="825z.jkc76" where user="root";
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select user,authentication_string from mysql.user\G
*************************** 1. row ***************************
                 user: root
authentication_string: 825z.jkc76
*************************** 2. row ***************************
                 user: mysql.infoschema
authentication_string: $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED
*************************** 3. row ***************************
                 user: mysql.session
authentication_string: $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED
*************************** 4. row ***************************
                 user: mysql.sys
authentication_string: $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED
4 rows in set (0.00 sec)

mysql> flush privileges;
Query OK, 0 rows affected (0.10 sec)
```

## 参见地址

错误示范：

[mysql8 windows版密码忘记如何重新设置？](https://www.codenong.com/cs107043741/)

使用localhost还是使用%更新的原因：

[ERROR 1396 (HY000): Operation ALTER USER failed for 'root'@'localhost'](https://blog.csdn.net/q258523454/article/details/84555847)

修改密码 前提是知道自己的密码 不过不知道也没关系 我们可以先进入安全模式将自己的密码设置为空

[Mysql 8.0修改密码](https://blog.csdn.net/lxlong89940101/article/details/80246675?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param)

mysql 5.7.9以后废弃了password字段和password()函数

[MySql8.0修改root密码](https://blog.csdn.net/wolf131721/article/details/93004013)