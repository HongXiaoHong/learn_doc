https://blog.csdn.net/seasonsbin/article/details/79093647?spm=1001.2101.3001.6650.12&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-12-79093647-blog-57428763.pc_relevant_multi_platform_whitelistv3&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-12-79093647-blog-57428763.pc_relevant_multi_platform_whitelistv3&utm_relevant_index=13

[高效使用Java构建工具｜Maven篇](https://mp.weixin.qq.com/s/Wvq7t2FC58jaCh4UFJ6GGQ)

## 常见问题

#### maven 中的 packageing pom 是作何用

POM是最简单的打包类型。不像一个JAR，SAR，或者EAR，它生成的构件只是它本身
没有代码需要测试或者编译，也没有资源需要处理。打包类型为POM的项目的默认目标生命周期阶段

目标 package

site:attach-descriptor install

install:install deploy

deploy:deploy

pom项目里没有java代码，也不执行任何代码，只是为了聚合工程或传递依赖用的。


### IDEA使用maven自定义archetype生成项目骨架
https://blog.csdn.net/qq_37345604/article/details/100581940