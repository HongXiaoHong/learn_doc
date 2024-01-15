# 自动化
自动部署 迭代 发布
不需要人工进行干预

- git 服务器
  - gogs 轻量
  - gitlab 功能多 但是 比较占资源
  - 备份
    - 这里使用百度网盘
    - 同时使用移动硬盘进行备份
    - 以及使用 GitHub/gitee 进行备份
- ci/cd
  - Jenkins 太重
  - drone 轻量级 足够个人小型公司使用


## gogs
https://hub.docker.com/r/gogs/gogs

部署 gogs
```bash
E:\BaiduSyncdisk\backup\softwares\blibli>docker pull gogs/gogs
Using default tag: latest
latest: Pulling from gogs/gogs
1207c741d8c9: Pull complete
f6d0bc289bd1: Pull complete
ffcf93ebe546: Pull complete
ef47a0134386: Pull complete
11db1bd6e300: Pull complete
d768c60ea5e0: Pull complete
7b2d9082f869: Pull complete
Digest: sha256:a79112b800b3daba5d3e0e569734abc88e59120e012b34a25d532b00c2ab0a9b
Status: Downloaded newer image for gogs/gogs:latest
docker.io/gogs/gogs:latest

What's Next?
  View a summary of image vulnerabilities and recommendations → docker scout quickview gogs/gogs

E:\BaiduSyncdisk\backup\softwares\blibli>docker run --name=gogs -p 10022:22 -p 10880:3000 -v /E/BaiduSyncdisk/backup/git/gogs:/data gogs/gogs
```

> docker run --name=gogs -p 10022:22 -p 10880:3000 -v /E/BaiduSyncdisk/backup/git/gogs:/data gogs/gogs


![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_GeTcfijocA.png)

在 git bash 中执行
```bash
hong@DESKTOP-6ANCF3P MINGW64 /d/app/code/gogs
$ ./gogs.exe web
2023/12/15 20:48:51 [ WARN] Custom config "D:\\app\\code\\gogs\\custom\\conf\\app.ini" not found. Ignore this warning if you're running for the first time
2023/12/15 20:48:51 [TRACE] Log mode: Console (Trace)
2023/12/15 20:48:51 [ INFO] Gogs 0.13.0
2023/12/15 20:48:51 [TRACE] Work directory: D:\app\code\gogs
2023/12/15 20:48:51 [TRACE] Custom path: D:\app\code\gogs\custom
2023/12/15 20:48:51 [TRACE] Custom config: D:\app\code\gogs\custom\conf\app.ini
2023/12/15 20:48:51 [TRACE] Log path: D:\app\code\gogs\log
2023/12/15 20:48:51 [TRACE] Build time: 2023-02-26 03:25:53 UTC
2023/12/15 20:48:51 [TRACE] Build commit: 8c21874c00b6100d46b662f65baeb40647442f42
2023/12/15 20:48:51 [ INFO] Run mode: Development
2023/12/15 20:48:51 [ INFO] Available on http://localhost:3000/
2023/12/15 20:48:56 [TRACE] Session ID: 260de448c01c7718
2023/12/15 20:48:56 [TRACE] CSRF Token: CvdTA_uf7P0xDcZxhv97X7FAjl06MTcwMjY0NDUzNjQ2MTcyMTYwMA
2023/12/15 20:48:56 [TRACE] Session ID: 260de448c01c7718
2023/12/15 20:48:56 [TRACE] CSRF Token: CvdTA_uf7P0xDcZxhv97X7FAjl06MTcwMjY0NDUzNjQ2MTcyMTYwMA
2023/12/15 20:48:56 [TRACE] Template: install
2023/12/15 20:54:13 [TRACE] Session ID: 260de448c01c7718
2023/12/15 20:54:13 [TRACE] CSRF Token: CvdTA_uf7P0xDcZxhv97X7FAjl06MTcwMjY0NDUzNjQ2MTcyMTYwMA
2023/12/15 20:54:20 [TRACE] Template: install
2023/12/15 20:54:25 [TRACE] Session ID: 260de448c01c7718
2023/12/15 20:54:25 [TRACE] CSRF Token: CvdTA_uf7P0xDcZxhv97X7FAjl06MTcwMjY0NDUzNjQ2MTcyMTYwMA
2023/12/15 20:54:25 [TRACE] Log mode: File (Info)
[git-module] [timeout: 1m0s] git version
git version 2.21.0.windows.1

```


## Jenkins
安装 官网 下载 https://www.jenkins.io/
安装教程: https://www.cnblogs.com/wml-it/p/16534706.html

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20231216130552.png)

其实是你的登录名才对
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20231216130747.png)


![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20231216132806.png)

如何备份:
https://blog.csdn.net/kouryoushine/article/details/100075629
其实就是备份整个目录
这里是
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_4vOYUx27Fn.png)


```bash
sc.exe create gitea start= auto binPath= "\"D:\app\code\gitea\gitea-1.21.2-gogit-windows-4.0-amd64.exe\" web --config \"D:\app\code\gitea\custom\conf\app.ini\""
```

配置凭证:
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/msedge_G9HWGyqgsR.png)

## gitea


windows 安装 
下载 安装包
https://dl.gitea.com/gitea/

gitea oauth:
01d8c37f84455b8618f9759122fe410a1cde6fdd

Jenkins 用户
0f2bc1cd93882150e219a550a7071f8120d348e2

GitHub:
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

docker-compose.yml

```yaml
version: "3"

networks:
  gitea:
    external: false

services:
  server:
    image: gitea/gitea:1.21.1
    container_name: gitea
    environment:
      - USER_UID=1000
      - USER_GID=1000
    restart: always
    networks:
      - gitea
    volumes:
      - /E/BaiduSyncdisk/backup/git/gitea/data:/data
      - /E/BaiduSyncdisk/backup/git/gitea/etc/timezone:/etc/timezone:ro
      - /E/BaiduSyncdisk/backup/git/gitea/etc/localtime:/etc/localtime:ro
    ports:
      - "10880:3000"
      - "10220:22"
```




运行日志:
```bash
E:\BaiduSyncdisk\backup\git\gitea>docker-compose up -d
[+] Running 8/8
 ✔ server 7 layers [⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                                                                                                      57.7s 
   ✔ 96526aa774ef Already exists                                                                                                                                                                          0.0s 
   ✔ 7dc518b025ef Pull complete                                                                                                                                                                          16.2s 
   ✔ 8407be5af69c Pull complete                                                                                                                                                                           1.9s 
   ✔ 08bcc64e4913 Pull complete                                                                                                                                                                           1.6s 
   ✔ 0a61c6327b4b Pull complete                                                                                                                                                                          38.7s 
   ✔ 1449c9789bd6 Pull complete                                                                                                                                                                           8.5s 
   ✔ c9b07ad1459c Pull complete                                                                                                                                                                          10.0s 
[+] Building 0.0s (0/0)                                                                                                                                                                         docker:default
[+] Running 2/2
 ✔ Network gitea_gitea  Created                                                                                                                                                                           0.1s 
 ✔ Container gitea      Started 
```

## drone

```sh
docker run \
  --volume=/E/BaiduSyncdisk/backup/softwares/drone:/data \
  --env=DRONE_GITEA_SERVER=http://192.168.137.1:10880 \
  --env=DRONE_GITEA_CLIENT_ID=30926972-b21f-4136-9cbd-82faf73d9834 \
  --env=DRONE_GITEA_CLIENT_SECRET=gto_bebpwyzsqftsfu2hpesk4miwaqpmjzwflwfxrsdstybnveifyyba \
  --env=DRONE_RPC_SECRET=13c1e6e02fd18c79b4925abeef3e64eb \
  --env=DRONE_SERVER_HOST=192.168.137.1 \
  --env=DRONE_SERVER_PROTO=http \
  --publish=10080:80 \
  --publish=10443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone

docker run   --volume=/E/BaiduSyncdisk/backup/softwares/drone:/data   --env=DRONE_GITEA_SERVER=http://192.168.137.1:10880   --env=DRONE_GITEA_CLIENT_ID=30926972-b21f-4136-9cbd-82faf73d9834   --env=DRONE_GITEA_CLIENT_SECRET=gto_bebpwyzsqftsfu2hpesk4miwaqpmjzwflwfxrsdstybnveifyyba   --env=DRONE_RPC_SECRET=13c1e6e02fd18c79b4925abeef3e64eb   --env=DRONE_SERVER_HOST=192.168.137.1:10080   --env=DRONE_SERVER_PROTO=http   --publish=10080:80   --publish=10443:443   --restart=always   --detach=true   --name=drone   drone/drone
```

https://docs.drone.io/server/provider/gitea/

尝试过的方案:
直接用 docker 启动 不行
```bash
docker run \
  --volume=/E/BaiduSyncdisk/backup/softwares/drone:/data \
  --volume=/E/BaiduSyncdisk/temp/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_GITEA_SERVER=http://192.168.137.1:10880 \
  --env=DRONE_GITEA_CLIENT_ID=30926972-b21f-4136-9cbd-82faf73d9834 \
  --env=DRONE_GITEA_CLIENT_SECRET=gto_7iondcfl4pwnnzpfjt7haihkzsn6odjgt7vq7ti76prg5nv76jpa \
  --env=DRONE_RPC_SECRET=13c1e6e02fd18c79b4925abeef3e64eb \
  --env=DRONE_SERVER_HOST=192.168.137.1:19000 \
  --env=DRONE_SERVER_PROTO=http \
  --publish=19000:80 \
  --publish=10443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone

  docker run --detach \
  --volume=/E/BaiduSyncdisk/backup/softwares/drone-runner/pipe/docker_engine://./pipe/docker_engine \
  --env=DRONE_RPC_PROTO=http \
  --env=DRONE_RPC_HOST=192.168.137.1:19000 \
  --env=DRONE_RPC_SECRET=13c1e6e02fd18c79b4925abeef3e64eb \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_RUNNER_NAME=my-first-runner \
  --publish=13300:3000 \
  --restart=always \
  --name=runner \
  drone/drone-runner-docker

  

```

直接用 docker-compose 启动 不行

docker-compose.yaml

```yaml

version: "3.7"

services:
  drone-server:
    container_name: drone-server
    image: drone/drone:latest
    ports:
      - "19000:80"
      - "14443:443"
    volumes:
      - /E/BaiduSyncdisk/temp/var/run/docker.sock:/var/run/docker.sock
      - /E/BaiduSyncdisk/backup/softwares/drone/:/var/lib/drone/:rw
    restart: always
    environment:
      - DRONE_GITEA_SERVER=http://192.168.137.1:10880
      - DRONE_GIT_ALWAYS_AUTH=false
      - DRONE_RUNNER_CAPACITY=2
      - DRONE_SERVER_HOST=localhost:19000
      - DRONE_SERVER_PROTO=http
      - DRONE_TLS_AUTOCERT=false
      - DRONE_RPC_SECRET=185adbaebdec83daa7708f9fbcf3f9d9
      - DRONE_GITHUB_CLIENT_ID=30926972-b21f-4136-9cbd-82faf73d9834
      - DRONE_GITHUB_CLIENT_SECRET=gto_7iondcfl4pwnnzpfjt7haihkzsn6odjgt7vq7ti76prg5nv76jpa
      - DRONE_LOGS_DEBUG=true
  drone-runner:
    container_name: drone-runner
    image: drone/drone-runner-docker:latest
    depends_on:
      - drone-server
    volumes:
      - /E/BaiduSyncdisk/temp/var/run/docker.sock:/var/run/docker.sock
    restart: always
    environment:
      - DRONE_RPC_HOST=drone-server
      - DRONE_RPC_PROTO=http
      - DRONE_RPC_SECRET=185adbaebdec83daa7708f9fbcf3f9d9
      - DRONE_RUNNER_CAPACITY=2
      - DRONE_RUNNER_NAME=runner-centos
```

然后使用 docker + drone-runner-exec 也不行
https://www.ningtaostudy.cn/articles/bpl
docker:
```bash
docker run \
  --volume=/E/BaiduSyncdisk/backup/softwares/drone:/data \
  --volume=/E/BaiduSyncdisk/temp/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_GITEA_SERVER=http://192.168.137.1:10880 \
  --env=DRONE_GITEA_CLIENT_ID=30926972-b21f-4136-9cbd-82faf73d9834 \
  --env=DRONE_GITEA_CLIENT_SECRET=gto_7iondcfl4pwnnzpfjt7haihkzsn6odjgt7vq7ti76prg5nv76jpa \
  --env=DRONE_RPC_SECRET=13c1e6e02fd18c79b4925abeef3e64eb \
  --env=DRONE_SERVER_HOST=192.168.137.1:19000 \
  --env=DRONE_SERVER_PROTO=http \
  --publish=19000:80 \
  --publish=10443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone
```


drone-runner-exec config 配置:

```properties
DRONE_RPC_PROTO=http
DRONE_RPC_HOST=192.168.137.1:19000
DRONE_RPC_SECRET=13c1e6e02fd18c79b4925abeef3e64eb
```