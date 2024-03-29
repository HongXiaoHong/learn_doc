# docker

## 学习链接

gitbook 手册

[[译] Docker 的学习和应用 - 掘金 (juejin.cn)](https://juejin.cn/post/6844903925674426382)

[前言 - Docker — 从入门到实践](https://yeasy.gitbook.io/docker_practice/)

[docker_practice/README.md at master · yeasy/docker_practice · GitHub](https://github.com/yeasy/docker_practice/blob/master/README.md)

狂神带我们学习 docker

[1、Docker学习大纲_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1og4y1q7M4?p=1&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[《狂神说Java》docker教程通俗易懂-KuangStudy-文章](https://www.kuangstudy.com/bbs/1552836707509223426#header78)

官网:

[Dockerfile reference | Docker Documentation](https://docs.docker.com/engine/reference/builder/)

虚拟机与容器docker的区别，在于**vm多了一层guest OS，虚拟机的Hypervisor会对硬件资源也进行虚拟化，而容器Docker会直接使用宿主机的硬件资源**。

## 指令

[(125条消息) Docker容器的创建、启动、和停止_weixin_33943836的博客-CSDN博客](https://blog.csdn.net/weixin_33943836/article/details/85977604?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-85977604-blog-106943301.pc_relevant_recovery_v2&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-85977604-blog-106943301.pc_relevant_recovery_v2&utm_relevant_index=1)

[docker容器启动后自动停止，dockerfile编写的容器启动后也是自动停止 - 峰哥ge - 博客园 (cnblogs.com)](https://www.cnblogs.com/FengGeBlog/p/12085276.html)

1、docker容器启动后自动停止

　　自动停止的因素有很多，比如启动后命令有问题就停止了，这类容器在启动后是可以看到容器的启动日志的，比如使用docker logs命令即可

　　不过还有的容器意外停止是因为当前容器没有要运行的任务，比如centos镜像，它默认没有运行的任务，如果没有任务就会自动停止，这种不是意外停止，这点要注意

因此需要注意一点就是：在制作dockerfile的时候，要有一个运行在前台的任务，因此那些运行在后台的参数最好是不要加上去，也就是让程序运行在前台。

2、dockerfile案例演示

```dockerfile
FROM centos7.5
WORKDIR /usr/local/src
COPY elasticsearch-7.4.0-linux-x86_64.tar.gz ./
RUN tar xf elasticsearch-7.4.0-linux-x86_64.tar.gz \ && mv elasticsearch-7.4.0 /usr/local/elastic7.4 \ && useradd -s /bin/bash -U elastic \ && echo 'elastic soft memlock unlimited' >> /etc/security/limits.conf \ && echo 'elastic hard memlock unlimited' >> /etc/security/limits.conf
USER elastic
RUN /usr/local/elastic7.4/bin/elasticsearch --daemonize --pidfile /usr/local/elastic7.4/run/elastic7.4.pid
```

这个脚本的问题就在于，--daemonize这个参数表示程序运行在后台，此时启动制作出来的容器是不会一直运行的，也就是启动后就停止了

解决方法就是将--daemonize这个参数去掉，此时镜像在启动后直接执行此命令，程序就运行在前台，日志也打印在前台了。

还有一个就是docker run -it --name=centos centos7.5:1.0 /bin/bash这种命令运行时默认执行/bin/bash，这个bash命令会覆盖dockfile中的CMD指令，这点需要注意。

最后就是容器执行的用户，可以在docker run 启动时指定--name=chaofeng这样的参数指定容器运行的用户。

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

### 5.4. 匿名和具名挂载

#### windows下docker文件挂载方式

```bash
-e D:\docker\volumes\**:/home/admin/canal-server/conf/canal.properties
应该写成
-v //d/docker/volumes/canal/1.1.5/conf/canal.properties:/home/admin/canal-server/conf/canal.properties
```

5.5. 初识Dockerfile

使用dockerfile构建镜像

dockerfile

这里我使用 -d 启动 因为centos没有前台任务 会退出

所以这里启动 run 要使用 -dt 用 -t 启动一个前台任务不让centos退出

```dockerfile
FROM centos
CMD echo "hello docker file"
CMD /bin/bash
```

```bash
E:\docker>docker build -f ./dockerfile -t myos:1.0 .
[+] Building 0.2s (5/5) FINISHED
 => [internal] load build definition from dockerfile                                                                                                                                                      0.0s
 => => transferring dockerfile: 95B                                                                                                                                                                       0.0s 
 => [internal] load .dockerignore                                                                                                                                                                         0.0s 
 => => transferring context: 2B                                                                                                                                                                           0.0s 
 => [internal] load metadata for docker.io/library/centos:latest                                                                                                                                          0.0s 
 => [1/1] FROM docker.io/library/centos                                                                                                                                                                   0.0s
 => exporting to image                                                                                                                                                                                    0.0s 
 => => exporting layers                                                                                                                                                                                   0.0s 
 => => writing image sha256:7d6b67167d4a51fdcade100ae46f8a7b28b7a05afd1c09c3353ec55b71699526                                                                                                              0.0s 
 => => naming to docker.io/library/myos:1.0                                                                                                                                                               0.0s 

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```

### 5.6. 数据卷容器

被引用的容器称为父容器

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_T60ULor7Zo.png)

使用 --volume-from 部署多个自定义centos 实现数据共享

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_twsuGgWwwq.png)

使用 --volume-from 拷贝其他容器的挂载地址

让容器间共享数据

删除父容器 不影响数据共享

这里我的理解是

跟java中堆中地址一样

删除父容器 就是只删除了引用 但是原来的对象还在

不影响别人继续使用

```bash
docker run -d -p 3355:8080 --name sywltomcat 
-v /home/sywl/build/tomcat/test:/usr/local/apache-tomcat-9.0.5/webapps/test 
-v /home/sywl/build/tomcat/tomcatlog:/usr/local/apache-tomcat-9.0.5/logs 
diytomcat
```

```docker
docker run -d -p 3355:8080 --name my_tomcat 
my_tomcat:1.0
```

## 6. DockerFile

### 6.1. 各种指令

官方文档

[Dockerfile reference | Docker Documentation](https://docs.docker.com/engine/reference/builder/)

#### EXPOSE 暴露端口

EXPOSE 指令是声明容器运行时提供服务的端口，这只是一个声明，在容器运行时并不会因为这个声明应用就会开启这个端口的服务。在 Dockerfile 中写入这样的声明有两个好处，一个是帮助镜像使用者理解这个镜像服务的守护端口，以方便配置映射；另一个用处则是在运行时使用随机端口映射时，也就是 docker run -P 时，会自动随机映射 EXPOSE 的端口。
要将 EXPOSE 和在运行时使用 -p <宿主端口>:<容器端口> 区分开来。-p，是映射宿主端口和容器端口，换句话说，就是将容器的对应端口服务公开给外界访问，而 EXPOSE 仅仅是声明容器打算使用什么端口而已，并不会自动在宿主进行端口映射

### 6.2. 自制 Tomcat 镜像

```dockerfile
# 基础镜像
FROM centos:7

# 元数据
LABEL author="1908711045"

# 说明书
COPY readme.txt /usr/local/readme.txt

# ADD 会自动解压到指定路径
ADD apache-tomcat-9.0.71.tar.gz /usr/local/
ADD jdk-8u351-linux-x64.tar.gz /usr/local/

RUN yum -y install vim

# 定义工作目录
ENV MYPATH /usr/local
WORKDIR $MYPATH

# 定义环境变量
ENV JAVA_HOME /usr/local/jdk1.8.0_351
ENV CLASS_PATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.71
ENV CATALINA_BASH /usr/local/apache-tomcat-9.0.71
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

# 导出端口
EXPOSE 8080

# 启动Tomcat
CMD /usr/local/apache-tomcat-9.0.71/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.71/bin/logs/catalina.out
```

```bash
E:\docker\my_tomcat>docker build -t my_tomcat:1.0 .
[+] Building 210.1s (11/11) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                      0.0s
 => => transferring dockerfile: 846B                                                                                                                                                                      0.0s 
 => [internal] load .dockerignore                                                                                                                                                                         0.0s 
 => => transferring context: 2B                                                                                                                                                                           0.0s 
 => [internal] load metadata for docker.io/library/centos:7                                                                                                                                               4.2s
 => [1/6] FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4                                                                                        68.4s
 => => resolve docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4                                                                                         0.0s 
 => => sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4 1.20kB / 1.20kB                                                                                                            0.0s 
 => => sha256:dead07b4d8ed7e29e98de0f4504d87e8880d4347859d839686a31da35a3b532f 529B / 529B                                                                                                                0.0s 
 => => sha256:eeb6ee3f44bd0b5103bb561b4c16bcb82328cfe5809ab675bb17ab3a16c517c9 2.75kB / 2.75kB                                                                                                            0.0s 
 => => sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc 76.10MB / 76.10MB                                                                                                         63.3s 
 => => extracting sha256:2d473b07cdd5f0912cd6f1a703352c82b512407db6b05b43f2553732b55df3bc                                                                                                                 4.5s 
 => [internal] load build context                                                                                                                                                                         2.5s 
 => => transferring context: 161.35MB                                                                                                                                                                     2.5s
 => [2/6] COPY readme.txt /usr/local/readme.txt                                                                                                                                                           0.3s
 => [3/6] ADD apache-tomcat-9.0.71.tar.gz /usr/local/                                                                                                                                                     0.3s
 => [4/6] ADD jdk-8u351-linux-x64.tar.gz /usr/local/                                                                                                                                                      6.1s
 => [5/6] RUN yum -y install vim                                                                                                                                                                        128.8s
 => [6/6] WORKDIR /usr/local                                                                                                                                                                              0.0s
 => exporting to image                                                                                                                                                                                    1.8s
 => => exporting layers                                                                                                                                                                                   1.8s
 => => writing image sha256:ef1e0f453148d1c01dac7f1c745d9c2360b6a95cb3a4685fae818fd92bc9bcd5                                                                                                              0.0s
 => => naming to docker.io/library/my_tomcat:1.0                                                                                                                                                          0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```

直接访问  [Apache Tomcat Examples](http://localhost:3355/examples/) 

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/msedge_5n5pueVMcU.png)

### 6.3. 推送到 docker.io

```bash
# 构建镜像
docker build -t gabrieldeoliveiraest/projetofinal2_web:latest -f Dockerfile .
# 登录到 docker.io
docker login -u "gabrieldeoliveiraest" -p "password" docker.io
#  docker 镜像创建一个 [tag]，然后将其推送到您的 docker 中心
# 先要建立 tag 才能进行 推送
docker tag projetofinal2_web gabrieldeoliveiraest/projetofinal2_web:version1
# 推送
docker push gabrieldeoliveiraest/projetofinal2_web:version1
```

#### 结果

```bash
E:\docker\my_tomcat>docker push hongxiaohong/my_tomcat:1.0
The push refers to repository [docker.io/hongxiaohong/my_tomcat]
5f70bf18a086: Pushed
17187833c980: Pushed
389b254399b7: Pushed
5b4798f83887: Pushed
ed632b6abb69: Pushed
174f56854903: Pushed
1.0: digest: sha256:6e54e3683a9f2c85d9e8de95ee75667eab7ba1aa8be3c7420614b0349123efe2 size: 1579
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/w7g6UmPPY3.png)

## Docker 网络

部署 redis 集群

[Docker部署redis集群及数据迁移（生产实战）_年轻是好事的技术博客_51CTO博客](https://blog.51cto.com/ycloud/5734170)

```shell
＃ 通过脚本创建六个redis配置

for port in $(seq 1 6); \ do\

mkdir -p/mydata/redis/node-${port}/conf

touch /mydata/redis/node-${port}/conf/redis.conf cat<<EO>/mydata/redis/node-${port}/conf/redis.conf port 6379

bind 0.0.0.0

cluster-enabled yes

cluster-config-file nodes.conf cluster-node-timeout 5000

cluster-announce-ip 172.38.0.1${port} cluster-announce-port 6379

cluster-announce-bus-port 16379 appendonly yes

EOF done 
```

### 容器互访的三种方式

[Docker: 容器互访的三种方式 - 活到老学到老 - SegmentFault 思否](https://segmentfault.com/a/1190000018014534)

- link

- network

- docker-compose

## docker-compose

[Docker Compose 简介 | 叶良辰の学习笔记](https://yangzhiwen911.github.io/ludi/DockerCompose/)

### 网络

[Docker Compose 网络设置 | 叶良辰の学习笔记](https://yangzhiwen911.github.io/ludi/DockerCompose/031.%5B%E6%9D%8E%E5%8D%AB%E6%B0%91%5D%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F%E6%9E%B6%E6%9E%84%E5%B7%A5%E7%A8%8B%E5%B8%88-DockerCompose-%E7%BD%91%E7%BB%9C%E8%AE%BE%E7%BD%AE.html#%E6%A6%82%E8%BF%B0)

默认情况下，Compose 会为我们的应用创建一个网络，服务的每个容器都会加入该网络中。这样，容器就可被该网络中的其他容器访问，不仅如此，**该容器还能以服务名称作为 Hostname 被其他容器访问**

### 网络模式

bridge

桥接模式

使用 veth-pair 技术(虚拟设备技术) [Linux 虚拟网络设备 veth-pair 详解，看这一篇就够了 - bakari - 博客园](https://www.cnblogs.com/bakari/p/10613710.html)

host 跟主机共享网络设备

none 不配置网络

### docker 容器每次启动 IP都会变化吗

在docker中，重启后ip是会变的；docker默认采用bridge连接，启动容器的时候会按照顺序来获取对应ip地址，这就导致**容器每次重启后ip都会发生变化**

#### 解决

- 设置固定 IP 解决 [docker设置容器固定ip_51CTO博客_docker固定容器ip](https://blog.51cto.com/u_15338614/3622908)

### DNS

[DNS 与 Docker 容器 - yexiaoxiaobai - SegmentFault 思否](https://segmentfault.com/a/1190000000629231?utm_source=sf-similar-article)

[配置 DNS - Docker — 从入门到实践 (gitbook.io)](https://yeasy.gitbook.io/docker_practice/network/dns)

配置 DNS 服务器帮助我们解析 域名

[Docker配置DNS-菜鸟笔记 (coonote.com)](https://www.coonote.com/docker-note/docker-configuration-dns.html)

主机 映射 dns 我们直接用 network 就可以解决

如果要配置 非主机 的dns 才需要配置 dns

windows desktop 如何设置

[Docker设置DNS - 掘金 (juejin.cn)](https://juejin.cn/post/7058821204915781669)

- todo [容器DNS介绍 - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1825506)

#### DHCP 协议

**DHCP（Dynamic Host Configuration Protocol，动态主机配置协议），前身是BOOTP协议，是一个局域网的网络协议，使用UDP协议工作，统一使用两个IANA分配的端口：67（服务器端），68（客户端）。DHCP通常被用于局域网环境，主要作用是集中的管理、分配IP地址，使client动态的获得IP地址、Gateway地址、DNS服务器地址等信息，并能够提升地址的使用率**

了解DHCP或**动态主机配置协议**. DHCP是动态主机配置协议的缩写。. 它是一种存在于应用层的网络管理协议。. 在DHCP的帮助下，可以动态地给网络上的任何设备或节点分配一个互联网协议IP地址，使它们可以使用这个IP进行通信。. 网络管理员的任务是将大量的IP地址手动分配给网络中的所有设备。. 然而，在DHCP中，这个任务是自动化的，是集中管理，而不是手工管理。. 无论是小型本地网络还是大型企业网络都实现了DHCP。. DHCP的基本目标是为主机分配一个唯一的IP地址

## 仓库 | 镜像管理

### Docker registry

### Harbor

具有 **用户安全机制**以及 **镜像同步**等企业级需要的功能

[Harbor功能特点看这一篇就够了_镜像](https://www.sohu.com/a/459303453_609552)

[为什么有了Docker registry还需要Harbor？ - 腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1080444)

## 参考

1. [cp 命令，Linux cp 命令详解：将源文件或目录复制到目标文件或目录中 - Linux 命令搜索引擎 (wangchujiang.com)](https://wangchujiang.com/linux-command/c/cp.html)

2. [(243条消息) winodws下cmd对结果进行筛选_SHUIPING_YANG的博客-CSDN博客_cmd 筛选](https://blog.csdn.net/zhezhebie/article/details/79590730)
