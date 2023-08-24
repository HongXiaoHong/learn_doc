# nginx 案例

为什么配置
location / {
            root E:/github/show_time/dist; # 路径改成自己的dist路径
            try_files $uri $uri/ /index.html;
            index index.html index.htm;
        }
就可以找到dist路径下的index.html

location /show_time {
            root E:/github/show_time/dist; # 路径改成自己的dist路径
            try_files $uri $uri/ /index.html;
            index index.html index.htm;
        }
但是这么配置就找不到呢

```nginx
location /show_time {
            alias E:/github/show_time/dist; # 路径改成自己的dist路径
            try_files $uri $uri/ /index.html;
            index index.html index.htm;
        }
```
alias 不会帮我们加上请求的路径

这是因为 Nginx 的 `root` 指令和 `location` 指令的工作方式。当你设置 `root` 和 `location` 时，Nginx 会将它们拼接在一起来确定最终的文件路径。

在你的第一个配置中：

```nginx
location / {
    root E:/github/show_time/dist;
    try_files $uri $uri/ /index.html;
    index index.html index.htm;
}
```

当你访问 `http://yourserver/`（即 URI 是 `/`）时，Nginx 会将 `root` 的值（`E:/github/show_time/dist`）和 `$uri` 的值（`/`）拼接在一起，得到 `E:/github/show_time/dist/`，然后尝试在这个目录下查找文件。由于 `index.html` 是默认的索引文件，所以 Nginx 会返回 `E:/github/show_time/dist/index.html` 文件。

然而，在你的第二个配置中：

```nginx
location /show_time {
    root E:/github/show_time/dist;
    try_files $uri $uri/ /index.html;
    index index.html index.htm;
}
```

当你访问 `http://yourserver/show_time`（即 URI 是 `/show_time`）时，Nginx 会将 `root` 的值（`E:/github/show_time/dist`）和 `$uri` 的值（`/show_time`）拼接在一起，得到 `E:/github/show_time/dist/show_time`，然后尝试在这个目录下查找文件。由于 `index.html` 是默认的索引文件，所以 Nginx 会尝试返回 `E:/github/show_time/dist/show_time/index.html` 文件。但是，这个文件可能并不存在，因此你会得到一个 404 错误。

如果你想在访问 `http://yourserver/show_time` 时返回 `E:/github/show_time/dist/index.html` 文件，你可以使用 `alias` 指令代替 `root` 指令：

```nginx
location /show_time {
    alias E:/github/show_time/dist;
    try_files $uri $uri/ /index.html;
    index index.html index.htm;
}
```

`alias` 指令的工作方式与 `root` 指令不同。当你设置 `alias` 时，Nginx 不会将 `location` 的值添加到文件路径中，而是直接使用 `alias` 的值作为文件路径。因此，当你访问 `http://yourserver/show_time` 时，Nginx 会返回 `E:/github/show_time/dist/index.html` 文件。


> 因为 alias 没有帮我们加上 uri的关系
> GET http://localhost:9000/assets/index-d0df9e17.js net::ERR_ABORTED 404 (Not Found)
> GET http://localhost:9000/assets/index-d0df9e17.js net::ERR_ABORTED 404 (Not Found)


所以还是换回

```nginx
location / {
    root E:/github/show_time/dist;
    try_files $uri $uri/ /index.html;
    index index.html index.htm;
}
```