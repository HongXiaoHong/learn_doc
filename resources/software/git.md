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