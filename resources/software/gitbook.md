# gitbook



## 遇到的问题

### 1. [TypeError [ERR_INVALID_ARG_TYPE] when execute gitbook init]([TypeError [ERR_INVALID_ARG_TYPE] when execute gitbook init · Issue #108 · GitbookIO/gitbook-cli · GitHub](https://github.com/GitbookIO/gitbook-cli/issues/108))

现象:

```bash
$gitbook init
warn: no summary file in this book
info: create README.md
info: create SUMMARY.md

TypeError [ERR_INVALID_ARG_TYPE]: The "data" argument must be of type string or an instance of Buffer, TypedArray, or DataView. Received an instance of Promise
```



原因:

node版本问题 执行git book init 报错



解决:

使用低版本的node即可

[Index of /download/release/v12.22.12/](https://nodejs.org/download/release/v12.22.12/)[Index of /download/release/v12.22.12/](https://nodejs.org/download/release/v12.22.12/)

各个版本的node下载界面

[Previous Releases | Node.js](https://nodejs.org/en/download/releases/)


