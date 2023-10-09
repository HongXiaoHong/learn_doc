>   我新建了一个项目后, 我已经在GitHub新建了一个rep, 我想把项目跟我的GitHub上的项目关联起来, 我应该如何操作

要将你的本地项目与 GitHub 上的仓库关联起来，你可以按照以下步骤操作：

1. **初始化本地 Git 仓库**：首先，你需要在你的项目目录中初始化一个新的 Git 仓库。在你的终端中，切换到你的项目目录，然后运行以下命令：

2. **添加所有文件到 Git 仓库**：然后，你需要将你的项目文件添加到 Git 仓库。你可以使用以下命令来添加所有文件：

3. **提交你的更改**：接下来，你需要提交你的更改。你可以使用以下命令来提交你的更改，并添加一个提交消息：

```
bashgit commit -m "Initial commit"

```

4. **添加远程仓库**：然后，你需要将你的 GitHub 仓库添加为你的本地 Git 仓库的远程仓库。你可以使用以下命令来添加远程仓库，其中 `https://github.com/username/repository.git` 是你的 GitHub 仓库的 URL：

```
bashgit remote add origin https://github.com/username/repository.git

```

5. **推送你的更改到 GitHub**：最后，你可以将你的更改推送到 GitHub。你可以使用以下命令来推送你的更改：

```
bashgit push -u origin master

```

现在，你的本地项目应该已经与你的 GitHub 仓库关联起来了。你可以在你的 GitHub 仓库中看到你的项目文件。

>   master has no tracked branch 拉代码的时候出现这个错误

这个错误通常发生在你尝试从一个没有被跟踪的分支（在这种情况下是 `master`）拉取代码时。这可能是因为你的本地仓库还没有与远程仓库建立链接，或者你尝试拉取的分支在远程仓库中不存在。

你可以尝试以下步骤来解决这个问题：

1. **检查远程仓库**：首先，你需要确认你的远程仓库是否存在，并且包含你想要拉取的分支。你可以使用以下命令来查看你的远程仓库：

这将显示你的远程仓库的 URL。你可以访问这个 URL 来确认你的远程仓库是否存在，并且包含你想要拉取的分支。

2. **设置追踪分支**：如果你的远程仓库存在，并且包含你想要拉取的分支，你可能需要设置你的本地分支来追踪远程分支。你可以使用以下命令来设置追踪分支：

```
bashgit branch --set-upstream-to=origin/master master

```

这将设置你的本地 `master` 分支来追踪远程 `master` 分支。

3. **拉取代码**：现在，你应该能够从你的远程分支拉取代码了。你可以使用以下命令来拉取代码：

>   git pull 的时候出现一个错误 fatal: refusing to merge unrelated histories git pull 的时候出现一个错误 致命：拒绝合并不相关的历史

这个错误通常发生在尝试合并两个没有共同提交历史的 Git 仓库时。这可能是因为你的本地仓库和远程仓库在初始化时是独立的，没有共同的基础。

如果你确定要合并这两个仓库，你可以使用 `--allow-unrelated-histories` 选项来强制 Git 合并它们。你可以使用以下命令来拉取代码：

```
bashgit pull origin master --allow-unrelated-histories

```

然后，你可能需要解决合并冲突。你可以使用 `git status` 命令来查看哪些文件有冲突，然后手动编辑这些文件来解决冲突。解决冲突后，你可以使用 `git add .` 命令来添加你的更改，然后使用 `git commit` 命令来提交你的更改。

请注意，`--allow-unrelated-histories` 选项应该谨慎使用，因为它可能会导致你丢失一些历史记录。在使用这个选项之前，你应该确保这是你想要的结果。

没有使用上面的解决

用了这个

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/webstorm64_vbdTtKMUsw.png)

>   解释一下 git -c credential.helper= -c core.quotepath=false -c log.showSignature=false fetch origin --recurse-submodules=no --progress --prune解释一下 git -c credential.helper= -c core.quotepath=false -c log.showSignature=false fetch origin --recurse-submodules=no --progress --prune

这个命令是用来从远程仓库获取（fetch）最新的代码。下面是对命令中各部分的解释：

- `git`：这是 Git 命令行工具的主命令。

- `-c credential.helper=`：这个选项是用来设置 Git 的配置变量。在这里，它设置 `credential.helper` 为空，这意味着 Git 不会使用任何凭证助手来获取或保存你的凭证。

- `-c core.quotepath=false`：这个选项设置 `core.quotepath` 为 `false`。`quotepath` 是一个 Git 配置变量，当设置为 `true` 时，它会使 Git 在输出路径名时引用非 ASCII 字符。设置为 `false` 时，Git 将直接输出这些字符。

- `-c log.showSignature=false`：这个选项设置 `log.showSignature` 为 `false`。`showSignature` 是一个 Git 配置变量，当设置为 `true` 时，它会使 Git 在显示提交日志时显示 GPG 签名。设置为 `false` 时，Git 将不显示 GPG 签名。

- `fetch origin`：这是 Git 的 fetch 命令，用来从名为 `origin` 的远程仓库获取最新的代码。

- `--recurse-submodules=no`：这个选项告诉 Git 不要递归地获取子模块的最新代码。

- `--progress`：这个选项使 Git 在获取代码时显示进度信息。

- `--prune`：这个选项告诉 Git 在获取代码后删除远程仓库中已经删除的分支的本地引用。

总的来说，这个命令是用来从远程仓库获取最新的代码，同时设置一些 Git 的配置选项。

fetch pull区别

`git fetch` 和 `git pull` 都是用于从远程仓库获取最新的代码。但是，它们的工作方式有一些重要的区别：

- `git fetch`：这个命令会从远程仓库获取最新的提交和分支，但是它不会改变你的本地工作目录。换句话说，它不会自动合并或者更新你的当前分支。这使得你可以在获取最新的代码后，查看或者比较它们，然后决定是否要合并到你的当前分支。

- `git pull`：这个命令实际上是 `git fetch` 和 `git merge` 的组合。它会从远程仓库获取最新的提交和分支，然后自动将远程仓库的更改合并到你的当前分支。这使得你可以一步获取和更新你的代码。

总的来说，`git fetch` 是一个安全的命令，它允许你查看远程仓库的更改，而不会改变你的本地代码。而 `git pull` 是一个更方便的命令，它允许你一步获取和更新你的代码。你应该根据你的需求来选择使用哪个命令。ch`


## fork 模式

https://www.cnblogs.com/zyumeng/p/3442263.html

github上有个很方便的功能叫fork，将别人的工程一键复制到自己账号下。这个功能很方便，但有点不足的是，当源项目更新后，你fork的分支并不会一起更新，需要自己手动去更新。下面记录下网上找到的更新的方法

1、在本地装好github客户端，或者git客户端

2、clone 自己的fork分支到本地，可以直接使用github客户端，clone到本地，如果使用命令行，命令为：

   git clone git@github.com:break123/three.js.git three.js
3、增加源分支地址到你项目远程分支列表中(此处是关键)，先得将原来的仓库指定为upstream，命令为：

   git remote add upstream https://github.com/被fork的仓库.git
此处可使用git remote -v查看远程分支列表

4、fetch源分支的新版本到本地

   [master]> git fetch upstream
5、合并两个版本的代码

   [master]> git merge upstream/master
6、将合并后的代码push到github上去

   [master]> git push origin master

## git 客户端

https://zhuanlan.zhihu.com/p/144961175

1. GitHub Desktop
2. Fork
3. Tower
4. Sourcetree
5. SmartGit
6. Sublime Merge
7. GitKraken
8. GitUp
9. Ungit
10. Aurees Git customers
11. GitaHead
12. GitBlade


从知乎页面中提取对应的标题, 也就是 12 个 git 客户端
```JavaScript
document.querySelectorAll("h2")
NodeList(13) [h2, h2, h2, h2, h2, h2, h2, h2, h2, h2, h2, h2, h2.ContentItem-title]
init.js:1 
        
        
        POST https://zhihu-web-analytics.zhihu.com/api/v3inv2/za/logs/batch net::ERR_BLOCKED_BY_CLIENT
(匿名) @ init.js:1
n.send @ zap.js:1
d @ zap.js:1
(匿名) @ zap.js:1
(匿名) @ zap.js:1
o.onmessage @ zap.js:1
document.querySelectorAll("article h2")
NodeList(12) 
document.querySelectorAll("article h2")[0].textContent
'1. GitHub Desktop'
const gitClient = new Set();
undefined
document.querySelectorAll("article h2").forEach(item=>gitClient.add(item.textContent))
undefined
git
VM946:1 Uncaught ReferenceError: git is not defined
    at <anonymous>:1:1
(匿名) @ VM946:1
gitClient
Set(12) {'1. GitHub Desktop', '2.Fork', '3. Tower', '4. Sourcetree', '5. SmartGit', …}
[...gitClient]
(12) ['1. GitHub Desktop', '2.Fork', '3. Tower', '4. Sourcetree', '5. SmartGit', '6. Sublime Merge', '7. GitKraken', '8. GitUp', '9. Ungit', '10. Aurees Git customers', '11. GitaHead', '12. GitBlade']
[...gitClient].join("\n")
'1. GitHub Desktop\n2.Fork\n3. Tower\n4. Sourcetree\n5. SmartGit\n6. Sublime Merge\n7. GitKraken\n8. GitUp\n9. Ungit\n10. Aurees Git customers\n11. GitaHead\n12. GitBlade'
```

我已经尝试过的是 
GitHub Desktop
感觉还挺好用
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230824134317.png)


## gitignore
[Git忽略文件.gitignore详解](https://blog.csdn.net/ThinkWon/article/details/101447866)

在工程中，并不是所有文件都需要保存到版本库中的，例如“target”目录及目录下的文件就可以忽略。在Git工作区的根目录下创建一个特殊的.gitignore文件，然后把要忽略的文件名填进去，Git就会自动忽略这些文件或目录。

### Git 忽略规则优先级
在 .gitingore 文件中，每一行指定一个忽略规则，Git 检查忽略规则的时候有多个来源，它的优先级如下（由高到低）：

- 从命令行中读取可用的忽略规则
- 当前目录定义的规则
- 父级目录定义的规则，依次递推
- $GIT_DIR/info/exclude 文件中定义的规则
- core.excludesfile中定义的全局规则

### Git 忽略规则匹配语法
在 .gitignore 文件中，每一行的忽略规则的语法如下：

- 空格不匹配任意文件，可作为分隔符，可用反斜杠转义
- 开头的文件标识注释，可以使用反斜杠进行转义
- ! 开头的模式标识否定，该文件将会再次被包含，如果排除了该文件的父级目录，则使用 ! 也不会再次被包含。可以使用反斜杠进行转义
- / 结束的模式只匹配文件夹以及在该文件夹路径下的内容，但是不匹配该文件
- / 开始的模式匹配项目跟目录
- 如果一个模式不包含斜杠，则它匹配相对于当前 .gitignore 文件路径的内容，如果该模式不在 .gitignore 文件中，则相对于项目根目录
- ** 匹配多级目录，可在开始，中间，结束
- ? 通用匹配单个字符
- * 通用匹配零个或多个字符
- [] 通用匹配单个字符列表
### 常用匹配示例
bin/: 忽略当前路径下的bin文件夹，该文件夹下的所有内容都会被忽略，不忽略 bin 文件
/bin: 忽略根目录下的bin文件
/*.c: 忽略 cat.c，不忽略 build/cat.c
debug/*.obj: 忽略 debug/io.obj，不忽略 debug/common/io.obj 和 tools/debug/io.obj
**/foo: 忽略/foo, a/foo, a/b/foo等
a/**/b: 忽略a/b, a/x/b, a/x/y/b等
!/bin/run.sh: 不忽略 bin 目录下的 run.sh 文件
*.log: 忽略所有 .log 文件
config.php: 忽略当前路径的 config.php 文件

.gitignore规则不生效
.gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。

解决方法就是先把本地缓存删除（改变成未track状态），然后再提交:

```bash
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```
你想添加一个文件到Git，但发现添加不了，原因是这个文件被.gitignore忽略了：
```bash
$ git add App.class
The following paths are ignored by one of your .gitignore files:
App.class
Use -f if you really want to add them.
```
如果你确实想添加该文件，可以用-f强制添加到Git：
```bash
$ git add -f App.class
```
或者你发现，可能是.gitignore写得有问题，需要找出来到底哪个规则写错了，可以用git check-ignore命令检查：
```bash
$ git check-ignore -v App.class
.gitignore:3:*.class    App.class
```
Git会告诉我们，.gitignore的第3行规则忽略了该文件，于是我们就可以知道应该修订哪个规则。
Java项目中常用的.gitignore文件

```bash
# Compiled class file
*.class

# Eclipse
.project
.classpath
.settings/

# Intellij
*.ipr
*.iml
*.iws
.idea/

# Maven
target/

# Gradle
build
.gradle

# Log file
*.log
log/

# out
**/out/

# Mac
.DS_Store

# others
*.jar
*.war
*.zip
*.tar
*.tar.gz
*.pid
*.orig
temp/

```