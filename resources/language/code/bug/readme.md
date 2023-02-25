# 常见bug

## idea 引用文件飘红找不到 | maven 新建项目配置

现象:
idea spring 启动类 各种注解类找不到

原因:
idea新建项目使用了他自己的maven配置
我们需要配置自己的maven配置
也要在 setting 中配置新建项目的maven

搜索 maven配置即可



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/db/idea64_D0IhWpocQJ.png)

可参
https://blog.csdn.net/realize_dream/article/details/105441534





# spring 3+ jdk 必须 17以上 | 降低spring版本



[How do I successfully change the Java version in a Spring Boot project? - Stack Overflow](https://stackoverflow.com/questions/74894299/how-do-i-successfully-change-the-java-version-in-a-spring-boot-project)