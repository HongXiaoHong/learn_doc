
# linux
## 指令
### 软件安装

#### yum | centos 自带
yum是centos自带的；centos系统默认情况下会自带一些yum仓库，仓库所在的目录为“/etc/yum.repos.d/”，yum配置文件必须使用“repo”为结尾，系统也会自动生成一个本地yum的挂载名和几个自带的网上的yum源。

ubuntu 20.04安装yum
在 Ubuntu 20.04 中，你可以使用 apt 命令来管理软件包。如果你想要在 Ubuntu 中使用 yum，那么你需要先安装 yum 的依赖包 python-setuptools。你可以在终端中输入以下命令来安装 python-setuptools：

sudo apt update sudo apt install python-setuptools

然后，你可以使用 easy_install 命令来安装 yum。输入以下命令：

sudo easy_install yum

#### apt | 推荐使用

APT （Advanced Package Tool) 是 Linux 下的一款 包管理工具 。其最早来源于 Ubuntu 的前身 Debian

apt 和 APT 是两个完全不同的东西，前者是命令行工具（面向用户），后者是系统的一部分（不面向用户）

现在大多数 Linux 发行商都推荐 apt，尽管在短时间内， apt-get 等工具还没有被完全取缔的迹象。

常用的 apt 命令
apt 命令	命令功能
apt install	安装软件包
apt remove	移除软件包
apt purge	移除软件包及配置文件
apt update	刷新存储库索引
apt upgrade	升级所有可升级的软件包
apt autoremove	自动删除不需要的包
apt full-upgrade	在升级软件包时自动处理依赖关系
apt search	搜索应用程序
apt list	列出包含条件的包（已安装，可升级等）
apt edit-sources	编辑源列表
apt show	显示安装细节


Ubuntu下的软件管理方式主要包括如下几种：

apt 命令
dpkg 命令
make

## 接口测试
### curl

##  下载
### wget 

```bash
/ # wget --help
BusyBox v1.36.1 (2023-07-27 17:12:24 UTC) multi-call binary.

Usage: wget [-cqS] [--spider] [-O FILE] [-o LOGFILE] [--header STR]
        [--post-data STR | --post-file FILE] [-Y on/off]
        [-P DIR] [-U AGENT] [-T SEC] URL...

Retrieve files via HTTP or FTP

        --spider        Only check URL existence: $? is 0 if exists
        --header STR    Add STR (of form 'header: value') to headers
        --post-data STR Send STR using POST method
        --post-file FILE        Send FILE using POST method
        -c              Continue retrieval of aborted transfer
        -q              Quiet
        -P DIR          Save to DIR (default .)
        -S              Show server response
        -T SEC          Network read timeout is SEC seconds
        -O FILE         Save to FILE ('-' for stdout)
        -o LOGFILE      Log messages to FILE
        -U STR          Use STR for User-Agent header
        -Y on/off       Use proxy

```