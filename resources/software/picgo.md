# Markdown 通过 picgo 使用 GitHub 图床

## 本地安装node

so easy

## 本地全局安装picgo

```bash
C:\Users\hong>npm install -g picgo
npm WARN deprecated @types/bson@4.2.0: This is a stub types definition. bson provides its own type definitions, so you do not need this installed.
C:\Users\hong\AppData\Roaming\npm\picgo -> C:\Users\hong\AppData\Roaming\npm\node_modules\picgo\bin\picgo

> ejs@2.7.4 postinstall C:\Users\hong\AppData\Roaming\npm\node_modules\picgo\node_modules\ejs
> node ./postinstall.js

Thank you for installing EJS: built with the Jake JavaScript build tool (https://jakejs.com/)

npm WARN notsup Unsupported engine for write-file-atomic@4.0.2: wanted: {"node":"^12.13.0 || ^14.15.0 || >=16.0.0"} (current: {"node":"12.9.1","npm":"6.14.5"})
npm WARN notsup Not compatible with your version of node/npm: write-file-atomic@4.0.2
npm WARN notsup Unsupported engine for @commonify/lowdb@3.0.0: wanted: {"node":"^12.20.0 || ^14.13.1 || >=16.0.0"} (current: {"node":"12.9.1","npm":"6.14.5"})
npm WARN notsup Not compatible with your version of node/npm: @commonify/lowdb@3.0.0
npm WARN notsup Unsupported engine for @commonify/steno@2.1.0: wanted: {"node":"^14.13.1 || >=16.0.0"} (current: {"node":"12.9.1","npm":"6.14.5"})
npm WARN notsup Not compatible with your version of node/npm: @commonify/steno@2.1.0

+ picgo@1.5.0
added 338 packages from 261 contributors in 31.94s
```

## 配置picgo

```bash
C:\Users\hong>picgo set uploader
? Choose a(n) uploader github
设定仓库名 格式：username/repo HongXiaoHong/images
设定分支名 例如：main main
? token: [hidden]
设定存储路径 例如：test/ picture/
设定自定义域名 例如：https://test.com
[PicGo SUCCESS]: Configure config successfully!
[PicGo INFO]: If you want to use this config, please run 'picgo use uploader'

C:\Users\hong>picgo use uploader
? Use an uploader github
[PicGo SUCCESS]: Configure config successfully!

C:\Users\hong>picgo upload "D:\documents\photo\secondary\20211204\wlop\test.jpg"
[PicGo INFO]: Before transform
[PicGo INFO]: Transforming... Current transformer is [path]
[PicGo INFO]: Before upload
[PicGo INFO]: Uploading... Current uploader is [github]
[PicGo SUCCESS]: 
https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/test.jpg

C:\Users\hong>npm remove picgo
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\hong\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\hong\package.json'
npm WARN hong No description
npm WARN hong No repository field.
npm WARN hong No README data
npm WARN hong No license field.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.1.3 (node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.3: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.13 (node_modules\watchpack-chokidar2\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.13: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.13 (node_modules\webpack-dev-server\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.13: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
Clink v1.2.9.329839
Copyright (c) 2012-2018 Martin Ridgers
Portions Copyright (c) 2020-2021 Christopher Antos
https://github.com/chrisant996/clink

C:\Users\hong>picgo
Usage: picgo [options] [command]

Options:
  -v, --version                        output the version number
  -d, --debug                          debug mode
  -s, --silent                         silent mode
  -c, --config <path>                  set config path
  -p, --proxy <url>                    set proxy for uploading
  -h, --help                           display help for command

Commands:
  install|add [options] <plugins...>   install picgo plugin
  uninstall|rm <plugins...>            uninstall picgo plugin
  update [options] <plugins...>        update picgo plugin
  set|config <module> [name]           configure config of picgo modules
  upload|u [input...]                  upload, go go go
  use [module]                         use modules of picgo
  init [options] <template> [project]  create picgo plugin's development templates
  i18n [lang]                          change picgo language
  help [command]                       display help for command

C:\Users\hong>picgo -v
1.5.0

C:\Users\hong>picgo set uploader
? Choose a(n) uploader github
设定仓库名 格式：username/repo HongXiaoHong/images # 这里用户名配置错误可能404
设定分支名 例如：main main
? token: [hidden]
设定存储路径 例如：test/ docker/
设定自定义域名 例如：https://test.com
[PicGo SUCCESS]: Configure config successfully!
[PicGo INFO]: If you want to use this config, please run 'picgo use uploader'

C:\Users\hong>picgo use uploader
? Use an uploader github
[PicGo SUCCESS]: Configure config successfully!

C:\Users\hong>picgo upload "D:\documents\photo\secondary\20211204\wlop\test2.jpg"
[PicGo INFO]: Before transform
[PicGo INFO]: Transforming... Current transformer is [path]
[PicGo INFO]: Before upload
[PicGo INFO]: Uploading... Current uploader is [github]
[PicGo SUCCESS]: 
https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/test2.jpg
```

## 设置Marktext

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/DO6C2RzZd6.png)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/MarkText_bwGy6XfZ0v.png)

## 下载sharex

下载sharex 的 原因是因为

不使用sharex的保存到本地 再复制到剪贴板

粘贴到Marktext 会出现一直**上传转圈**的情况

## 设置sharex

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/msedge_sPv1qK56Nl.png)

## 出现的问题

401错误

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/docker/msedge_9zvBS4tDIi.png)

## 参考

1. [MarkText + picgo图床选择（Halo） (zinzin.cc)](https://zinzin.cc/archives/marktextpicgo-tu-chuang-xuan-ze-halo)
2. [PicGo is Here | PicGo 官方文档](https://picgo.github.io/PicGo-Doc/zh/guide/)
