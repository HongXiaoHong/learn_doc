git 里的gitignore不生效的解决方案

原因2 缓存 gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的. 解决方案: 清理缓存

先后执行 ,记住有点

git rm -r --cached .
git add .
git commit -m 'update .gitignore'

如果你写的语法没有错误,那么你会在控制台里看到删除那些忽略文件,如果没有,那就可能是语法错误


### 参考
[git 里的gitignore不生效的解决方案](https://www.cnblogs.com/fancyblogs/p/12299731.html)