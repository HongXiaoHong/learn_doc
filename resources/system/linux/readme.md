# linux

todo

- [ ] [理解Linux的进程，线程，PID，LWP，TID，TGID - wipan - 博客园](https://www.cnblogs.com/wipan/p/9488318.html)
- [ ] [strace 简明教程 - voidint - 个人博客](https://voidint.github.io/post/tool/strace/) 
  - [ ] strace 是 Linux 系统下的一个用于诊断、调试和指导用户空间的实用程序。它用于监视和篡改进程与 Linux 内核之间的交互，包括系统调用、信号传递和进程状态的更改

## 挂载硬盘

[linux如何挂载硬盘linux服务器上挂载磁盘（图文详解）_服务器_C18298182575-DevPress官方社区](https://huaweicloud.csdn.net/6356037cd3efff3090b58abf.html?spm=1001.2101.3001.6650.6&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Eactivity-6-125271540-blog-116904428.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Eactivity-6-125271540-blog-116904428.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=13)

[Linux 下挂载新硬盘方法_linux 挂载硬盘_zqixiao_09的博客-CSDN博客](https://blog.csdn.net/zqixiao_09/article/details/51417432)

[如何给Linux挂载数据盘_有数据的硬盘挂载到linux_ShuSheng007的博客-CSDN博客](https://blog.csdn.net/ShuSheng0007/article/details/116904428)

## 容器相关

目前我们所提到的容器技术、虚拟化技术（不论何种抽象层次下的虚拟化技术）都能做到资源层面上的隔离和限制。

对于容器技术而言，它实现资源层面上的限制和隔离，依赖于 Linux 内核所提供的 cgroup 和 namespace 技术。

- cgroup 的主要作用：管理资源的分配、限制；
- namespace 的主要作用：封装抽象，限制，隔离，使命名空间内的进程看起来拥有他们自己的全局资源；

[linux - 彻底搞懂容器技术的基石： namespace （下） - K8S生态 - SegmentFault 思否](https://segmentfault.com/a/1190000041114149)

[Linux Namespace : 简介 - sparkdev - 博客园](https://www.cnblogs.com/sparkdev/p/9365405.html)

[Linux Namespace机制简介 - 腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/2129136)

[Linux资源管理之cgroups简介 - 美团技术团队](https://tech.meituan.com/2015/03/31/cgroups.html)

## sudo | 短暂提升用户权限为超级用户

秒懂Linux的sudo命令

https://zhuanlan.zhihu.com/p/137332644

## chmod | 为文件赋权

[秒懂Linux文件权限及chmod命令_linux nonexistent_ShuSheng007的博客-CSDN博客](https://blog.csdn.net/ShuSheng0007/article/details/105343009)

## 指令

---

🍿 **命令大全**: [Linux 命令大全 | 菜鸟教程](https://www.runoob.com/linux/linux-command-manual.html)

### 网络

#### ping | 查看与某台机器的连接情况

netstat | 查看当前系统的端口使用

#### curl | http 请求工具

[curl 的用法指南 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2019/09/curl-reference.html)    

URL 客户端（client）, 用来请求 Web 服务器。

它的功能非常强大，命令行参数多达几十种。如果熟练的话，完全可以取代 Postman 这一类的图形界面工具

##### **cURL 是什么意思？**

cURL 意思是客户端的 URL 工具，是用于在服务器之间传输数据的开源命令行工具和跨平台的库（*libcurl*），几乎所有新操作系统中都有它。cURL 用途广泛，可以在任何地方接收和发送基于互联网协议的数据。

*cURL 支持几乎各种互联网协议（DICT、FILE、FTP、FTPS、 GOPHER、HTTP、HTTPS、IMAP、IMAPS、LDAP、LDAPS、 MQTT、POP3、POP3S、RTMP、RTMPS、RTSP、SCP、SFTP、SMB、SMBS、SMTP、SMTPS、TELNET 和 TFTP）。*

##### **cURL 的起源和发展历史**

在上个世纪 90 年代，人人都在用命令行工具，Daniel Sterberg 想开发一款简单好用的 IRC 脚本来帮助聊天室网友兑换货币。在 1997 年，为互联网协议数据传输基础的选择并不多 ，因此，*Httpget*（基于 HTTP 传输的数百行代码）便成为 cURL 最初的选择。为了纪念这段基础代码，取名为 HTTPGET 1.0。 

几个月后，因开发出了支持 FTP 的客户端而弃用之前的名字，更名为 url2.0。几度更新后，于 1998 年 3 月30 日，再次更名为如今大名鼎鼎的 cURL3.0。

在 cURL 之前也有过类似的工具 wget。详情我们就不赘述了，wget 和 cURL 的主要差别就在于下载能力，wget 可以断点续传。 

##### **cURL 有什么用途？**

cURL 的作用就是通过互联网协议传输数据。它的用途仅限于此，甚至不处理传输的数据，只起传输作用。 

cURL 可用于调试，例如：使用 “curl -v [https://oxylabs.cn](https://oxylabs.cn/)” 就会输出冗长的连接请求信息，包括用户代理、握手数据、端口等详细信息。

cURL 命令及其说明可谓不胜枚举。所幸可以通过 “curl-help” 选项可以查看所有可能性和简短备注列表。但如果缺乏对 cURL 用法的了解，这个列表帮助不大。

##### **cURL 怎么用？**

使用相对较新操作系统的用户，几乎人人都可能在使用 cURL，因为它是 Windows、MacOS 和大多数 Linux 系统的默认配置。如果是较老的操作系统，例如 Windows 10 以前的系统，可能需要[下载](https://everything.curl.dev/get)并安装 cURL。

要使用 cURL，只需打开终端输入 “curl” 即可。正常情况下，系统会调出 “curl –help”。正如前文提到过的，“Help” 会列出所有可能的命令。通过添加列出的参数并输入 URL 便可以组成 cURL 命令。参数可短（例如 -o、-L 等）可长（例如 –verbose）。这些参数可以通过使用单破折号或双破折号来加以区别。

##### **cURL 的使用**

###### **发送请求**

cURL 是一款基于互联网协议数据传输的强大工具。cURL 的用法不胜枚举，但我们可以介绍几个常见用例。

cURL 最初就是针对 HTTP 开发的，因此我们可以发送所有常规请求（POST、GET、PUT 等）。要发送 POST 请求到 URL，可以使用 -d（或 –data) 参数。大多数网站都会拒绝这类来自未经授权用户的请求，所以我们将使用[虚假 API 进行测试](https://jsonplaceholder.typicode.com/)。

```
curl -d “name=something&value=somethingelse” https://jsonplaceholder.typicode.com/posts/
```

cURL 发送请求后会返回如下信息：

```
{
  "name": "something",
  "value": "somethingelse",
  "id": 101
}
```

它们是这样运作的：

- curl 启动命令

- -d 参数用于发送 POST 请求的“数据”

- 双引号（“”）用于内容声明注意，有的操作系统仅接受单引号，有的则接受双引号。

- 最后是目标。URL 语法必须准确，因为 cURL 默认不会自动跟随重定向。

我们也可以以 JSON 格式发送 POST 请求，但必须提供更多选项才能告诉服务器我们在发送 JSON。cURL 几乎不会为用户解读，而只是发送 *application/text* 的 *Content-Type* 标头，因此，我们必须添加标头 *Content-Type: application/json ourselves。*

```
curl -H "Content-Type: application/json" --data "{\"data\":\"some data\"}"  https://jsonplaceholder.typicode.com/posts/
```

###### **跟随重定向**

cURL 默认不会自动跟随重定向。如果我们想要它跟随重定向，必须额外添加参数。请看下面的例子：

```
curl https://books.toscrape.com
```

我们的浏览器可以自动重定向，因此我们可能不会注意到这样的请求有什么问题。但是，如果我们发送 cURL 来跟随重定向，就会收到提示：在尝试连接时文档已被移动。要让 cURL 跟随重定向，必须添加特殊参数 “-L”（参数区分大小写）。

```
curl -L https://books.toscrape.com
```

现在我们应该可以收到来自 books.toscrape 返回的常规结果，因为 cURL 跟随从 http://books.toscrape.com/ 到 [http://books.toscrape.com/](http://books.toscrape.com/) 的重定向。

###### **使用代理连接**

cURL 使用代理可以连接任何目标。和其他 cURL 语句一样，除添加的参数及其属性外，URL 、语法和其他所有内容都保持一样。

```
curl --proxy proxyaddress:port https://jsonplaceholder.typicode.com/
```

在 “–proxy” 后面输入代理和端口就会通过输入的地址路由连接。代理往往要求通过 -U 参数发送登录凭证详细信息。

```
curl --proxy proxy:port -U “username:password” https://jsonplaceholder.typicode.com/
```

有的网站要求首先通过它的身份验证后，才能接受连接请求。可以使用类似参数进行服务器身份验证：“-u”。

```
curl -u username:password https://jsonplaceholder.typicode.com/
```

##### 总结

cURL 是互联网协议数据传输的强大工具。要掌握它的用法的确难度较大，但对任何开发者来说，cURL 都是一款不可或缺的工具包。坦率地说，解释所有的 cURL 用例可能要花很长时间

#### telnet | 远端登入/端口通不通

telnet ip port 判断端口通不通

#### netstat | 显示网络状态

#### 网络总结

##### 如何测试端口通不通

[如何测试端口通不通(四种方法）_怎么测端口通不通_zafer的博客-CSDN博客](https://blog.csdn.net/swazer_z/article/details/64442730)

Linux系统对应：有1、2、3、4四种方法

Windows系统对应：有2、5两种通用方法

###### 1、使用telnet判断

telnet是windows标准服务，可以直接用；如果是linux机器，需要安装telnet.

用法: telnet ip port

##### 2、使用ssh判断

ssh是linux的标准配置并且最常用，可以用来判断端口吗？

用法: ssh -v -p port username@ip

-v 调试模式(会打印日志).

-p 指定端口

username可以随意

##### 3、使用wget判断

wget是linux下的下载工具，需要先安装.

用法: wget ip:port

##### 4、使用端口扫描工具

##### 5、使用专用工具tcping进行访问

### 系统

#### top | 显示进程信息

```bash
$ top

top - 09:01:20 up 16:44,  0 users,  load average: 0.13, 0.10, 0.13
Tasks:   3 total,   1 running,   2 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.0 us,  1.0 sy,  0.0 ni, 97.8 id,  0.0 wa,  0.0 hi,  0.2 si,  0.0 st
KiB Mem :  8071336 total,   477216 free,  1845332 used,  5748788 buff/cache
KiB Swap:  2097152 total,  2091724 free,     5428 used.  5921948 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                    
    1 mongodb   20   0 1605776 132512  41256 S   0.0  1.6   1:50.57 mongod                                                                     
   97 root      20   0    4632    896    828 S   0.0  0.0   0:00.10 sh                                                                         
  106 root      20   0   38716   3172   2728 R   0.0  0.0   0:00.01 top
```

##### top命令按内存和cpu排序

[top命令按内存和cpu排序_topcpu排序_带鱼兄的博客-CSDN博客](https://blog.csdn.net/daiyudong2020/article/details/52760846)

**一、按进程的CPU使用率排序**

运行top命令后，键入大写P。

有两种途径：

a) 打开大写键盘的情况下，直接按P键

b) 未打开大写键盘的情况下，Shift+P键

**二、按进程的内存使用率排序**

运行top命令后，键入大写M。

有两种途径：

a) 打开大写键盘的情况下，直接按M键

b) 未打开大写键盘的情况下，Shift+M键

### 系统总结

#### 查看内存

查看内存使用排行 使用 top 并且使用加上大写的 M 

[top命令按内存和cpu排序_topcpu排序_带鱼兄的博客-CSDN博客](https://blog.csdn.net/daiyudong2020/article/details/52760846)

特定的app 可以使用 ps

### 文件

#### touch | 创建一个没有任何内容的文件

[Linux 中的 touch 命令示例 - GeeksforGeeks](https://www.geeksforgeeks.org/touch-command-in-linux-with-examples/)

#### cat | 创建、查看、连接包含内容的文件

[Linux 中的 Cat 命令及其示例 - GeeksforGeeks](https://www.geeksforgeeks.org/cat-command-in-linux-with-examples/)

#### cat <<EOF | 输出多行字符串到变量 文件 管道

[linux - How does "cat << EOF" work in bash? - Stack Overflow](https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash)

The `cat <<EOF` syntax is very useful when working with multi-line text in Bash, eg. when assigning multi-line string to a shell variable, file or a pipe.

##### Examples of `cat <<EOF` syntax usage in Bash:

###### 1. Assign multi-line string to a shell variable

```bash
$ sql=$(cat <<EOFSELECT foo, bar FROM dbWHERE foo='baz'EOF
)
```

*The `$sql` variable now holds the new-line characters too. You can verify with `echo -e "$sql"`.*

###### 2. Pass multi-line string to a file in Bash

```bash
$ cat <<EOF > print.sh#!/bin/bashecho \$PWDecho $PWDEOF
```

*The `print.sh` file now contains:*

```bash
#!/bin/bash
echo $PWD
echo /home/user
```

###### 3. Pass multi-line string to a pipe in Bash

```bash
$ cat <<EOF | grep 'b' | tee b.txtfoobarbazEOF
```

*The `b.txt` file contains `bar` and `baz` lines. The same output is printed to `stdout`.*

[Linux—shell中$(( ))、$( )、``与${ }的区别 - chengd - 博客园](https://www.cnblogs.com/chengd/p/7803664.html)

[测试Linux端口的连通性的四种方法_lzxomg的博客-CSDN博客_查看端口是否连通](https://blog.csdn.net/lzxomg/article/details/76349887)

方法一、telnet法

 telnet为用户提供了在本地计算机上完成远程主机工作的能力，因此可以通过telnet来测试端口的连通性，具体用法格式：

telnet ip port

说明：

ip：是测试主机的ip地址

port：是端口，比如80

如果telnet连接不存在的端口，那会如下图所示。

如果telnet 连接存在端口会出现如下图所示的内容，下图中以80端口为例。

方法二、ssh法

SSH 是目前较可靠，专为远程登录会话和其他网络服务提供安全性的协议,在linux上可以通过ssh命令来测试端口的连通性，具体用法格式如下：

用法: ssh -v -p port username@ip

说明：

-v 调试模式(会打印日志).

-p 指定端口

username:远程主机的登录用户

ip:远程主机

如果远程主机开通了相应的端口，会有如下图所示的建立成功的提示。

如果远程主机没有开通相应的端口，则如下图所示

方法三、curl法

curl是利用URL语法在命令行方式下工作的开源文件传输工具。也可以用来测试端口的连通性，具体用法:

curl ip:port

说明：

ip：是测试主机的ip地址

port：是端口，比如80

如果远程主机开通了相应的端口，都会输出信息，如果没有开通相应的端口，则没有任何提示，需要CTRL+C断开。

方法四、wget方法

wget是一个从网络上自动下载文件的自由工具，支持通过HTTP、HTTPS、FTP三个最常见的TCP/IP协议下载，并可以使用HTTP代理。wget名称的由来是“World Wide Web”与“get”的结合，它也可以用来测试端口的连通性具体用法:

wget ip:port

说明：

ip：是测试主机的ip地址

port：是端口，比如80

如果远程主机不存在端口则会一直提示连接主机。

### 磁盘

#### df | 文件系统磁盘使用情况统计

显示文件系统的磁盘使用情况统计：

```bash
$ df 
Filesystem     1K-blocks    Used     Available Use% Mounted on 
/dev/sda6       29640780 4320704     23814388  16%     / 
udev             1536756       4     1536752    1%     /dev 
tmpfs             617620     888     616732     1%     /run 
none                5120       0     5120       0%     /run/lock 
none             1544044     156     1543888    1%     /run/shm 
```

第一列指定文件系统的名称，第二列指定一个特定的文件系统1K-块1K是1024字节为单位的总内存。用和可用列正在使用中，分别指定的内存量。

使用列指定使用的内存的百分比，而最后一栏"安装在"指定的文件系统的挂载点
