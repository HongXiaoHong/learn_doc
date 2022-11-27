# docker

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


