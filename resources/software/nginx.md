# nginx

## 入门

[dunwu/nginx-tutorial: 这是一个 Nginx 极简教程，目的在于帮助新手快速入门 Nginx。 (github.com)](https://github.com/dunwu/nginx-tutorial)

[尚硅谷nginx](https://www.bilibili.com/video/BV1yS4y1N76R/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[Nginx学习 | 何叨叨的个人博客 (heyingjiee.github.io)](https://heyingjiee.github.io/otherLanguage/Nginx%E5%AD%A6%E4%B9%A0.html#%E5%89%8D%E6%8F%90%E5%87%86%E5%A4%87)


[Nginx location匹配规则](https://www.cnblogs.com/woshimrf/p/nginx-config-location.html)

## 端口规划
> 左不包括, 右包括
> ( ]
后端 开发
测试 8001-9000

发布 9001 - 10000
show_time: 9001
   
软件安装 11001 - 12000
Jenkins: 11080
zookeeper: 11181
gitea: 12000
nacos: 11848
mongodb: 11017
前端 开发
测试:
12001 - 13000
发布:
13001 - 14000


## 正向代理 反向代理 本质区别？

https://www.zhihu.com/question/36412304

> 正向代理是客户端和其他所有服务器（重点：所有）的代理者，而反向代理是客户端和所要代理的服务器之间的代理。

其实我觉得这个正向/反向 是相对于客户端来说
我对于正向代理的理解是
正向代理指的是代理客户端, 帮我们客户端把请求递交给服务器, 如果没有正向代理一般是完不成请求的

反向代理则是相对服务器来说, 用来代理服务器, 本来我们可以直接访问众多服务器, 但是可是要有诸多配置
但是有了反向代理之后, 我们就可以更简单的调用服务器的资源

## 如何使用 nginx 调试部署在服务器上的前端页面的接口

使用nginx设置代理调试本地接口

### 搭建 nginx

官网下载

```bash
start nginx
```

问题: 80 端口被占用

> 2023/06/08 18:37:29 [emerg] 17312#14704: bind() to 0.0.0.0:80 failed (10013: An attempt was made to access a socket in a way forbidden by its access permissions)

参考:

[解决windows系统80端口被占用问题 - Selier - 博客园 (cnblogs.com)](https://www.cnblogs.com/selier/p/9514426.html)

[windows下快速安装nginx 并配置 开机自启动-腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1888447)

[nginx启动失败（bind() to 0.0.0.0:80 failed (10013: An attempt was made to access a socket...permissions) - 渐若窥宏大 - 博客园 (cnblogs.com)](https://www.cnblogs.com/liuawen/p/12310616.html)

[(10条消息) windows下使用nginx调试简介_weixin_33754913的博客-CSDN博客](https://blog.csdn.net/weixin_33754913/article/details/88571713)

解决:

在<mark>管理者权限</mark>下运行

```bash
C:\Windows\System32>net stop http
下面的服务依赖于 HTTP Service 服务。
停止 HTTP Service 服务也会停止这些服务。

   World Wide Web 发布服务
   SSDP Discovery
   Print Spooler

你想继续此操作吗? (Y/N) [N]: Y
World Wide Web 发布服务 服务正在停止.
World Wide Web 发布服务 服务已成功停止。

SSDP Discovery 服务正在停止.
SSDP Discovery 服务已成功停止。

Print Spooler 服务正在停止.
Print Spooler 服务已成功停止。


HTTP Service 服务已成功停止。
```

重新运行  start  nginx 

浏览器运行 [localhost](localhost)



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_yQhFZMTXRh.png)

返回信息

> **Welcome to nginx!**
> 
> If you see this page, the nginx web server is successfully installed and working. Further configuration is required.
> 
> For online documentation and support please refer to [nginx.org](http://nginx.org/).  
> Commercial support is available at [nginx.com](http://nginx.com/).
> 
> *Thank you for using nginx.*



### 部署一个简单的web服务

用 python 搭建一个简单的 web 服务, 提供一个 get 请求的 json 接口

[python3之http.server模块](https://chenchena.blog.csdn.net/article/details/118099689?spm=1001.2101.3001.6650.6&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-6-118099689-blog-124218348.235%5Ev38%5Epc_relevant_anti_vip&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-6-118099689-blog-124218348.235%5Ev38%5Epc_relevant_anti_vip&utm_relevant_index=13)

```python
from http.server import HTTPServer, BaseHTTPRequestHandler

host = ('localhost', 8888)

class Resquest(BaseHTTPRequestHandler):
    timeout = 5
    server_version = "Apache"  # 设置服务器返回的的响应头

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")  # 设置服务器响应头
        self.end_headers()
        buf = '''{
                    "wapPopAdvert": {
                        "open": true
                    }
                }'''
        self.wfile.write(buf.encode())  # 里面需要传入二进制数据，用encode()函数转换为二进制数据   #设置响应body，即前端页面要展示的数据


if __name__ == '__main__':
    server = HTTPServer(host, Resquest)
    print("Starting server, listen at: %s:%s" % host)
    server.serve_forever()

```

测试一下 [localhost:8888](http://localhost:8888/)

```json
{
    "wapPopAdvert": {
        "open": true
    }
}
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_ktE55HAEF6.png)



### 配置 nginx

[(10条消息) 使用nginx设置代理调试本地接口_nginx调用本机接口_泳装魔王的博客-CSDN博客](https://blog.csdn.net/jingzuangod/article/details/84921975)

```roboconf
# 代理 test 路径, 转发到 http://127.0.0.1:8888
        #
        location /test {
           proxy_pass   http://127.0.0.1:8888;
        }
```

### 重新加载 nginx 配置

```bash
D:\app\code\nginx-1.24.0>nginx -s reload
```



### 测试

访问 [localhost/test](http://localhost/test)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/msedge_YKNOEhORuU.png)

```json
{
    "wapPopAdvert": {
        "open": true
    }
}
```
## 启停 nginx
nginx启动命令和停止命令
```bash
1.start nginx  //启动nginx的命令。
2.nginx -s quit  //此方式停止步骤是待nginx进程处理任务完毕进行停止。
3.nginx -s stop  //此方式相当于先查出nginx进程id再使用kill命令强制杀掉进程。
4.nginx -s reload  //重新加载配置文件：当 nginx的配置文件 nginx.conf 修改后，要想让配置生效需要重启 nginx，
使用-s reload不用先停止 nginx再启动 nginx 即可将配置信息在 nginx 中生效

```