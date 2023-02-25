# linux

todo

- [ ] [理解Linux的进程，线程，PID，LWP，TID，TGID - wipan - 博客园](https://www.cnblogs.com/wipan/p/9488318.html)

## 指令

### top | 显示进程信息

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

### touch | 创建一个没有任何内容的文件

[Linux 中的 touch 命令示例 - GeeksforGeeks](https://www.geeksforgeeks.org/touch-command-in-linux-with-examples/)

### cat | 创建、查看、连接包含内容的文件

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
