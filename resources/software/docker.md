# docker

## 指令

### 进入容器

#### docker attach跟exec区别

[(243条消息) docker exec 和 docker attach的作用与区别，docker run -it 的联系， exit后容器停止？_zhangxiao123qqq的博客-CSDN博客](https://blog.csdn.net/zhangxiao123qqq/article/details/105343115)

## 部署练习

### nginx

```bash
C:\Users\hong>docker search nginx
NAME                                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
nginx                                             Official build of Nginx.                        17746     [OK]       
linuxserver/nginx                                 An Nginx container, brought to you by LinuxS…   182
bitnami/nginx                                     Bitnami nginx Docker Image                      143                  [OK]
ubuntu/nginx                                      Nginx, a high-performance reverse proxy & we…   69
bitnami/nginx-ingress-controller                  Bitnami Docker Image for NGINX Ingress Contr…   22                   [OK]
rancher/nginx-ingress-controller                                                                  11
ibmcom/nginx-ingress-controller                   Docker Image for IBM Cloud Private-CE (Commu…   4
bitnami/nginx-exporter                                                                            3
bitnami/nginx-ldap-auth-daemon                                                                    3
kasmweb/nginx                                     An Nginx image based off nginx:alpine and in…   3
rancher/nginx                                                                                     2
rancher/nginx-ingress-controller-defaultbackend                                                   2
circleci/nginx                                    This image is for internal use                  2
rapidfort/nginx                                   RapidFort optimized, hardened image for NGINX   2
vmware/nginx                                                                                      2                    
bitnami/nginx-intel                                                                               1
wallarm/nginx-ingress-controller                  Kubernetes Ingress Controller with Wallarm e…   1
vmware/nginx-photon                                                                               1
ibmcom/nginx-ppc64le                              Docker image for nginx-ppc64le                  0
rancher/nginx-conf                                                                                0
rapidfort/nginx-ib                                RapidFort optimized, hardened image for NGIN…   0
rancher/nginx-ssl                                                                                 0
ibmcom/nginx-ingress-controller-ppc64le           Docker Image for IBM Cloud Private-CE (Commu…   0
continuumio/nginx-ingress-ws                                                                      0
rapidfort/nginx-official                          RapidFort optimized, hardened image for NGIN…   0

C:\Users\hong>docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
a603fa5e3b41: Pull complete
c39e1cda007e: Pull complete
90cfefba34d7: Pull complete
a38226fb7aba: Pull complete
62583498bae6: Pull complete
9802a2cfdb8d: Pull complete
Digest: sha256:e209ac2f37c70c1e0e9873a5f7231e91dcd83fdf1178d8ed36c2ec09974210ba
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest

C:\Users\hong>docker run -it -d nginx
36362be7819b45bae25a8797c344ffcc9660dbb3f95b6f32a4adfe2c33429aad

C:\Users\hong>docker ps -a
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS                       PORTS                                                                                            
                                                       NAMES
36362be7819b   nginx                   "/docker-entrypoint.…"   11 seconds ago   Up 10 seconds                80/tcp                                                                                           
                                                       eager_feynman
fd4dab860182   centos                  "/bin/bash"              2 days ago       Exited (0) 2 days ago                                                                                                         
                                                       zen_greider
8275cfe93c6e   centos                  "/bin/sh -c 'while t…"   2 days ago       Exited (137) 2 days ago                                                                                                       
                                                       vigilant_brahmagupta
54d7bbdba4eb   rabbitmq:3-management   "docker-entrypoint.s…"   15 months ago    Exited (255) 15 months ago   4369/tcp, 5671/tcp, 15671/tcp, 15691-15692/tcp, 25672/tcp, 0.0.0.0:15672->15672/tcp, :::15672->15672/tcp, 0.0.0.0:11344->5672/tcp, :::11344->5672/tcp   rabbitmq
1c1a87868ee2   5c62e459e087            "docker-entrypoint.s…"   16 months ago    Exited (255) 16 months ago   33060/tcp, 0.0.0.0:13306->3306/tcp, :::13306->3306/tcp                                           
                                                       container-mysql
ddd6dbc36bd8   mongo                   "docker-entrypoint.s…"   17 months ago    Exited (0) 17 months ago                                                                                                      
                                                       mongo
9736b12132f5   redis:alpine3.13        "docker-entrypoint.s…"   17 months ago    Exited (0) 10 months ago                                                                                                      
                                                       redis
41fd1029c58c   18e46be2e14b            "java -jar /app.jar"     17 months ago    Exited (143) 17 months ago                                                                                                    
                                                       du
c20909aabb63   hello-world             "/hello"                 17 months ago    Exited (0) 17 months ago                                                                                                      
                                                       dreamy_borg

C:\Users\hong>docker logs -tf 36362be7819b
2022-11-27T07:45:49.217817300Z /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
2022-11-27T07:45:49.218148300Z /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
2022-11-27T07:45:49.218933600Z /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
2022-11-27T07:45:49.227319000Z 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
2022-11-27T07:45:49.233139900Z 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
2022-11-27T07:45:49.233225500Z /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
2022-11-27T07:45:49.235817200Z /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
2022-11-27T07:45:49.237407000Z /docker-entrypoint.sh: Configuration complete; ready for start up
2022-11-27T07:45:49.242811800Z 2022/11/27 07:45:49 [notice] 1#1: using the "epoll" event method
2022-11-27T07:45:49.242828500Z 2022/11/27 07:45:49 [notice] 1#1: nginx/1.23.2
2022-11-27T07:45:49.242832800Z 2022/11/27 07:45:49 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6)
2022-11-27T07:45:49.242836700Z 2022/11/27 07:45:49 [notice] 1#1: OS: Linux 5.4.72-microsoft-standard-WSL2
2022-11-27T07:45:49.242841100Z 2022/11/27 07:45:49 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022-11-27T07:45:49.242992000Z 2022/11/27 07:45:49 [notice] 1#1: start worker processes
2022-11-27T07:45:49.243227500Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 29
2022-11-27T07:45:49.243503500Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 30
2022-11-27T07:45:49.243515800Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 31
2022-11-27T07:45:49.243828800Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 32
2022-11-27T07:45:49.244018200Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 33
2022-11-27T07:45:49.244241000Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 34
2022-11-27T07:45:49.244553200Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 35
2022-11-27T07:45:49.244707800Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 36
2022-11-27T07:45:49.245114700Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 37
2022-11-27T07:45:49.245463800Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 38
2022-11-27T07:45:49.245859000Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 39
2022-11-27T07:45:49.246335800Z 2022/11/27 07:45:49 [notice] 1#1: start worker process 40
^C
C:\Users\hong>docker exec -hekp
Flag shorthand -h has been deprecated, please use --help

Usage:  docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

Run a command in a running container

Options:
  -d, --detach               Detached mode: run command in the background
      --detach-keys string   Override the key sequence for detaching a
                             container
  -e, --env list             Set environment variables (default )
      --env-file list        Read in a file of environment variables
  -i, --interactive          Keep STDIN open even if not attached
      --privileged           Give extended privileges to the command
  -t, --tty                  Allocate a pseudo-TTY
  -u, --user string          Username or UID (format:
                             <name|uid>[:<group|gid>])
  -w, --workdir string       Working directory inside the container

C:\Users\hong>
C:\Users\hong>docker exec -help
Flag shorthand -h has been deprecated, please use --help

Usage:  docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

Run a command in a running container

Options:
  -d, --detach               Detached mode: run command in the background
      --detach-keys string   Override the key sequence for detaching a
                             container
  -e, --env list             Set environment variables (default )
      --env-file list        Read in a file of environment variables
  -i, --interactive          Keep STDIN open even if not attached
      --privileged           Give extended privileges to the command
  -t, --tty                  Allocate a pseudo-TTY
  -u, --user string          Username or UID (format:
                             <name|uid>[:<group|gid>])
  -w, --workdir string       Working directory inside the container

C:\Users\hong>docker exec -it nginx 
"docker exec" requires at least 2 arguments.
See 'docker exec --help'.

Usage:  docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

Run a command in a running container

C:\Users\hong>docker exec -it nginx  /bin/bash
Error: No such container: nginx

C:\Users\hong>docker ps -a
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS                       PORTS                                                                                            
                                                       NAMES
36362be7819b   nginx                   "/docker-entrypoint.…"   10 minutes ago   Up 10 minutes                80/tcp                                                                                           
                                                       eager_feynman
fd4dab860182   centos                  "/bin/bash"              2 days ago       Exited (0) 2 days ago                                                                                                         
                                                       zen_greider
8275cfe93c6e   centos                  "/bin/sh -c 'while t…"   2 days ago       Exited (137) 2 days ago                                                                                                       
                                                       vigilant_brahmagupta
54d7bbdba4eb   rabbitmq:3-management   "docker-entrypoint.s…"   15 months ago    Exited (255) 15 months ago   4369/tcp, 5671/tcp, 15671/tcp, 15691-15692/tcp, 25672/tcp, 0.0.0.0:15672->15672/tcp, :::15672->15672/tcp, 0.0.0.0:11344->5672/tcp, :::11344->5672/tcp   rabbitmq
1c1a87868ee2   5c62e459e087            "docker-entrypoint.s…"   16 months ago    Exited (255) 16 months ago   33060/tcp, 0.0.0.0:13306->3306/tcp, :::13306->3306/tcp                                           
                                                       container-mysql
ddd6dbc36bd8   mongo                   "docker-entrypoint.s…"   17 months ago    Exited (0) 17 months ago                                                                                                      
                                                       mongo
9736b12132f5   redis:alpine3.13        "docker-entrypoint.s…"   17 months ago    Exited (0) 10 months ago                                                                                                      
                                                       redis
41fd1029c58c   18e46be2e14b            "java -jar /app.jar"     17 months ago    Exited (143) 17 months ago                                                                                                    
                                                       du
c20909aabb63   hello-world             "/hello"                 17 months ago    Exited (0) 17 months ago                                                                                                      
                                                       dreamy_borg

C:\Users\hong>docker exec -it 36362be7819b /bin/bash
root@36362be7819b:/#
```

> docker exec -it 36362be7819b /bin/bash

用 -it 交互模式运行容器并且执行bash指令

#### linux bash是什么

> Bash是**一个命令处理器，通常运行于文本窗口中，并能执行用户直接输入的命令**。 Bash还能从文件中读取命令，这样的文件称为脚本。 和其他Unix shell 一样，它支持文件名替换（通配符匹配）、管道、here文档、命令替换、变量，以及条件判断和循环遍历的结构控制语句。

引自 [linux bash是什么](https://www.google.com.hk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwietruK8837AhXE7GEKHVRSCSMQFnoECBQQAw&url=https%3A%2F%2Fbaike.baidu.com%2Fitem%2FBash%2F6367661&usg=AOvVaw0ICGU2xkcan59-pBa1oKIJ)

### Tomcat

```bash
C:\Users\hong>docker run  --name="tomcat01" -p 3355:8080 tomcat
Unable to find image 'tomcat:latest' locally
latest: Pulling from library/tomcat
e96e057aae67: Pull complete
014fa72e018d: Pull complete
06768b8afb03: Pull complete 
3c12ca51ab80: Pull complete
55a6d794ff88: Pull complete
c98105279431: Pull complete
b1ab501a2026: Pull complete
Digest: sha256:24617d8a035492d33a732dd6154cc64a86463a4d3157c67c6364b09141dc475a
Status: Downloaded newer image for tomcat:latest
docker: Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:3355 -> 0.0.0.0:0: listen tcp 0.0.0.0:3355: bind: An attempt was made to access a socket in a way forbidden by its access permissions.

C:\Users\hong>docker ps -a\
unknown shorthand flag: '\\' in -\
See 'docker ps --help'.

C:\Users\hong>docker ps -a # 不使用-d 没有在运行状态
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS                       PORTS                                                                                            
                                                       NAMES
857ca09da0a4   tomcat                  "catalina.sh run"        13 seconds ago   Created  


# 测试访问没有问题，但是找不到资源
# 进入容器，有一个webapps文件夹和webapps.dist文件夹
docker exec -it tomcat01 /bin/bash
# webapps文件夹下没有资源，资源都在webapp.dist文件夹下
root@35eb825661e0:/usr/local/tomcat# ls
BUILDING.txt  CONTRIBUTING.md  LICENSE  NOTICE  README.md  RELEASE-NOTES  RUNNING.txt  bin  conf  lib  logs  native-jni-lib  temp  webapps  webapps.dist  work
# 发现问题：（阿里云镜像的原因：默认是最小的镜像，所有不必要的都剔除掉）保证最小可运行的环境
# 1、Linux命令少了。
# 2、没有webapps文件夹。
# 没有webapps文件夹，发现有一个webapps.dist文件夹，资源在webapps.dist文件夹下；
# 把webapps.dist文件夹下的文件复制到webapps文件夹下，就可以访问成功。
root@35eb825661e0:/usr/local/tomcat# cp -r webapps.dist/* webapps
```

### 测试结果

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/msedge_OMfjuL7EcX.png)

### 部署ES+kibana

官方推荐

[elasticsearch - Official Image | Docker Hub](https://hub.docker.com/_/elasticsearch)

```console
$ docker run -d --name elasticsearch --net somenetwork -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:tag
```

太耗内存

赶紧关闭，增加内存的限制，修改配置文件-e环境配置修改

```bash

```

## 4. Docker镜像讲解

### 4.1. 镜像是什么

镜像相当于应用市场的软件 

用java中的class来对应正好合适

封装了应用,环境,环境变量

#### 4.1.1. 如何获取镜像

1. 从远程仓库

2. 朋友拷贝

3. 自己通过dockerfile打包

### 4.2. Docker镜像加速原理

#### 4.2.1. UnionFS（联合文件系统）

pull 镜像的时候 用的就是这种一层层的结构

联合文件系统 union文件系统 是一种分层轻量级高性能的文件系统 通过叠加的方式构成文件

#### 4.2.2. Docker镜像加载原型

##### bootfs

内核加载 bootloader主要是引导加载kernel 加载完即移除

##### rootfs

系统加载 就是各种不同的操作系统发行版，比如Ubuntu，Centos等等

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/msedge_f0Etmb0PtO.png)

#### 4.3. 分层理解

##### 4.3.1. 分层的镜像

我们拉取镜像的时候是一层(layer)层下载的

每一层都可以共享

例如: 我们拉取的时候 第一层是ubuntu

下次拉取另外一个镜像 如果一样的情况 就可以不用再次拉取

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/9863930d17ed4093b9183fa4bb7470e6.png)

##### 4.3.2. 特点

镜像都是只读的

当容器启动时，一个新的可写层被加载到镜像的顶部

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/8144d08138314609907009189cf18080.png)

##### 4.3.3. commit镜像

```bash
# 提交容器成为一个新的副本
docker commit
# 命令和git原理类似
docker commit -m="提交的描述信息" -a="作者" 容器id 目标镜像名:[TAG]
```

###### 4.3.3.1. 实战测试

```bash
C:\Users\hong>docker run -d -p 18080:8080 tomcat
4518f05c8f9ed13dadefb0d6120948b1887840d7fe8f1c375b10d9a09303f73c

C:\Users\hong>docker exec -it 4518f05c8f9ed13dadefb0d6120948b1887840d7fe8f1c375b10d9a09303f73c /bin/bash
root@4518f05c8f9e:/usr/local/tomcat# ls
bin  BUILDING.txt  conf  CONTRIBUTING.md  lib  LICENSE  logs  native-jni-lib  NOTICE  README.md  RELEASE-NOTES  RUNNING.txt  temp  webapps  webapps.dist  work
root@4518f05c8f9e:/usr/local/tomcat# cp webapps.dist/* webapps
cp: -r not specified; omitting directory 'webapps.dist/docs'
cp: -r not specified; omitting directory 'webapps.dist/examples'
cp: -r not specified; omitting directory 'webapps.dist/host-manager'
cp: -r not specified; omitting directory 'webapps.dist/manager'
cp: -r not specified; omitting directory 'webapps.dist/ROOT'
root@4518f05c8f9e:/usr/local/tomcat# cd webapps
root@4518f05c8f9e:/usr/local/tomcat/webapps# ls
root@4518f05c8f9e:/usr/local/tomcat/webapps# cp -r webapps.dist/* webapps
cp: cannot stat 'webapps.dist/*': No such file or directory
root@4518f05c8f9e:/usr/local/tomcat/webapps# cd ..
root@4518f05c8f9e:/usr/local/tomcat# cp -r webapps.dist/* webapps 

# -R/r：递归处理，将指定目录下的所有文件与子目录一并处理；
root@4518f05c8f9e:/usr/local/tomcat# cd webapps
root@4518f05c8f9e:/usr/local/tomcat/webapps# ls
docs  examples  host-manager  manager  ROOT
root@4518f05c8f9e:/usr/local/tomcat/webapps# exit
exit

C:\Users\hong>docker commit -a="hong" -m="add webapps" 4518f05c8f9ed13dadefb0d6120948b1887840d7fe8f1c375b10d9a09303f73c tomcat_with_webapps:v1.0
sha256:040d58777afacb77d38e21dfee944c198a95d712de707453a52e80862d6efe90

C:\Users\hong>docker images -a|find tomcat
FIND: 参数格式不正确

C:\Users\hong>docker images -a|find "tomcat"
tomcat_with_webapps                                       v1.0                                                                         040d58777afa   28 seconds ago   478MB
tomcat                                                    latest                                                                       1ca69d1bf49a   13 days ago      474MB
```

## 五、容器数据卷

### 5.1. 什么是容器数据卷

容器数据卷 用户容器中数据的持久化

例如 部署MySQL的时候如果不使用容器卷 删除了容器 数据也没了

真正意义的删库跑路了

### 5.2. 使用数据卷

   直接使用命令来挂载：-v

```bash
docker run -v 本地目录:容器目录


# 测试，查看容器信息
docker inspect 容器id
```

mounts就是我们绑定的信息![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/msedge_E6m7SRazIE.png)

本地目录与容器目录是双向绑定的

就算停止容器再次启动也会使用

### 5.3. 实战：安装mysql

可参[(243条消息) Docker - Docker挂载mysql_MinggeQingchun的博客-CSDN博客_docker 挂载mysql](https://blog.csdn.net/MinggeQingchun/article/details/123880624?spm=1001.2101.3001.6650.8&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-8-123880624-blog-112154454.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-8-123880624-blog-112154454.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=16)



```bash
# 查找Docker内，MySQL配置文件my.cnf的位置
mysql --help | grep my.cnf

mysql -u root -p
Enter password:******
# 会输出数据文件的存放路径 /var/lib/mysql/
show variables like '%datadir%';
```



在官方hub中搜索 看到建议通过此部署

```bash
# 官方建议加上密码设置
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
```

```bash
docker run -d -p 17777:3306 
-v /E/documents/temp/mysql/conf:/etc/mysql/conf.d 
-v /E/documents/temp/mysql:/var/lib/mysql 
-e MYSQL_ROOT_PASSWORD=123456 
--name mysql01 mysql
```

出现问题

```bash

C:\Users\hong>docker run -d -p 17777:3306 -v /E/documents/temp/mysql/conf:/etc/mysql/conf.d -v /E/documents/temp/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql
6fa65e2619304091a8dc259be1b63d3935fc6b9a80c8969f88992457e040edeb

C:\Users\hong>docker logs 6fa65e2619304091a8dc259be1b63d3935fc6b9a80c8969f88992457e040edeb
2022-11-30 02:02:23+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.31-1.el8 started.
2022-11-30 02:02:23+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2022-11-30 02:02:23+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.31-1.el8 started.
2022-11-30 02:02:23+00:00 [Note] [Entrypoint]: Initializing database files
2022-11-30T02:02:23.967087Z 0 [Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed in a future release. Please use SET GLOBAL host_cache_size=0 instead.
2022-11-30T02:02:23.967434Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.31) initializing of server in progress as process 80
2022-11-30T02:02:23.971349Z 0 [ERROR] [MY-010457] [Server] --initialize specified but the data directory has files in it. Aborting.
2022-11-30T02:02:23.971355Z 0 [ERROR] [MY-013236] [Server] The designated data directory /var/lib/mysql/ is unusable. You can remove all files that the server added to it.
2022-11-30T02:02:23.971417Z 0 [ERROR] [MY-010119] [Server] Aborting
2022-11-30T02:02:23.971513Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.31)  MySQL Community Server - GPL.
```

```bash
docker run -d -p 17777:3306 
-v /E/documents/temp/mysql/conf:/etc/mysql/conf.d 
-v /E/documents/temp/mysql/data:/var/lib/mysql 
-e MYSQL_ROOT_PASSWORD=123456 
--name mysql01 mysql
```

这里挂载数据的路径加上了/data 就可以了...

```bash
C:\Users\hong>docker run -d -p 17777:3306 -v /E/documents/temp/mysql/conf:/etc/mysql/conf.d -v /E/documents/temp/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql
9f93330283c55f55cdda57955632569103094e644c190a67e328ab30843dd2f6

C:\Users\hong>docker logs 9f93330283c55f55cdda57955632569103094e644c190a67e328ab30843dd2f6
2022-11-30 02:07:05+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.31-1.el8 started.
2022-11-30 02:07:05+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2022-11-30 02:07:05+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.31-1.el8 started.
2022-11-30 02:07:05+00:00 [Note] [Entrypoint]: Initializing database files
2022-11-30T02:07:05.845708Z 0 [Warning] [MY-011068] [Server] The syntax '--skip-host-cache' is deprecated and will be removed in a future release. Please use SET GLOBAL host_cache_size=0 instead.
2022-11-30T02:07:05.846144Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.31) initializing of server in progress as process 81
2022-11-30T02:07:05.855503Z 0 [Warning] [MY-010159] [Server] Setting lower_case_table_names=2 because file system for /var/lib/mysql/ is case insensitive
2022-11-30T02:07:05.889503Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2022-11-30T02:07:14.637114Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
```

#### 使用db连接

出现错误

> Public Key Retrieval is not allowed



解决

[(243条消息) MySQL 8.0 Public Key Retrieval is not allowed 错误的解决方法_呜呜呜啦啦啦的博客-CSDN博客](https://blog.csdn.net/u013360850/article/details/80373604)

```chinese
最简单的解决方法是在连接后面添加 allowPublicKeyRetrieval=true

文档中(https://mysql-net.github.io/MySqlConnector/connection-options/)给出的解释是：

如果用户使用了 sha256_password 认证，密码在传输过程中必须使用 TLS 协议保护，但是如果 RSA 公钥不可用，可以使用服务器提供的公钥；可以在连接中通过 ServerRSAPublicKeyFile 指定服务器的 RSA 公钥，或者AllowPublicKeyRetrieval=True参数以允许客户端从服务器获取公钥；但是需要注意的是 AllowPublicKeyRetrieval=True可能会导致恶意的代理通过中间人攻击(MITM)获取到明文密码，所以默认是关闭的，必须显式开启

```



[解决mysql8 Public Key Retrieval is not allowed 问题_51CTO博客_Public Key Retrieval is not allowed](https://blog.51cto.com/u_15155077/2716369)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/msedge_FpGdP1CKzm.png)







5.4. 匿名和具名挂载

5.5. 初识Dockerfile

5.6. 数据卷容器

## 参考

1. [cp 命令，Linux cp 命令详解：将源文件或目录复制到目标文件或目录中 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/cp.html)

2. [(243条消息) winodws下cmd对结果进行筛选_SHUIPING_YANG的博客-CSDN博客_cmd 筛选](https://blog.csdn.net/zhezhebie/article/details/79590730)
