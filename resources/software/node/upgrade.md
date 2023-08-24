# node 升级

### 1.NPM 如何升级？

  1.1. 可以使用 NPM 自带的命令进行升级：

```cmd
npm install -g npm
```

 注：这个命令会安装最新的，安装到全局。

### 2. 查看 NPM 版本

```bash
npm -v
```

  注：要是版本过低，可使用上面所说命令进行升级。

### 3. 怎么把 node.js 升级到最新版？

 3.1. 这里使用 nvm，nvm 是 node.js 版本管理的工具。

 3.2. 要是没有 nvm，按如下步骤：

   3.2.1. 这是 GitHub 地址下载 Windows 版本：[nvm-releases](https://github.com/coreybutler/nvm-windows/releases "https://github.com/coreybutler/nvm-windows/releases")

   3.2.2. 下载 .exe 后缀名的，下载完成之后直接安装即可。 

![](https://img-blog.csdnimg.cn/e5d40d4abfce4760b1b2e71a23951eb8.png)

 3.3. 安装完成之后，检查你当前 node.js 的版本

  命令：

```
node -v
```

![](https://img-blog.csdnimg.cn/690102c5b14a4013910d4ef9941b44d6.png)

3.4. 指定版本进行升级，可以去 node.js 官网查看当前稳定的版本进行升级，不建议升级到最新的，有可能会造成冲突或者其他问题。

3.5. 这里去官网看了，最新而且稳定的是 18.16.0，那就安装这个版本。

![](https://img-blog.csdnimg.cn/1408bcc693ef4e00ae4ec9568d9ba376.png)

使用如下命令：

```
nvm install 18.16.0
```

 ![](https://img-blog.csdnimg.cn/e9ea0b6f487d4db8a1b3a66d0e441e1d.png)

3.6. 安装成功之后， 使用 node -v 查看当前 node.js 版本还是之前的老版本，因为你没有切换进行使用，为什么要使用 nvm 进行版本管理，就是怕版本不一致，导致冲突可以切换进行使用。

使用如下命令切换到安装最新的版本：

```
nvm use 18.16.0
```

![](https://img-blog.csdnimg.cn/18a794b4aa4a456db942625f360a2c21.png)

3.7. 到这里就把 nvm 安装，升级 nodejs 完成了。