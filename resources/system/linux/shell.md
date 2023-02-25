# shell

[簡明 Linux Shell Script 入門教學](https://blog.techbridge.cc/2019/11/15/linux-shell-script-tutorial/)

```bash
# cat test.sh
#!/bin/bash

a=expr 1 + 2
echo $a
# /bin/bash test.sh
test.sh: line 3: 1: command not found
没有使用反引号会报错

加上反引号之后就可以了
# vim test.sh
# /bin/bash test.sh
3
```

## 流程控制

```bash
if condition
then
    command1 
    command2
    ...
    commandN 
fi
```

condition可以使用

1. [...]

2. ((...))

3. test ...

if else 的 [...] 判断语句中大于使用 -gt，小于使用 -lt。

if [ "\$a" -gt "\$b" ]; then
    ...
fi

如果使用 ((...)) 作为判断语句，大于和小于可以直接使用 > 和 <。

if (( a > b )); then
    ...
fi





[shell中if条件字符串、数字比对，\[\[\]\]和\[\]区别_weixin_34355881的博客-CSDN博客](https://blog.csdn.net/weixin_34355881/article/details/94624318?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-94624318-blog-102833792.pc_relevant_aa&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-94624318-blog-102833792.pc_relevant_aa&utm_relevant_index=5)



[Linux 中shell 脚本if判断多个条件_一路奔跑94的博客-CSDN博客_shellif判断多个条件](https://blog.csdn.net/weixin_37569048/article/details/80039941?spm=1001.2101.3001.6650.15&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-15-80039941-blog-102833792.pc_relevant_aa&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-15-80039941-blog-102833792.pc_relevant_aa&utm_relevant_index=21)
