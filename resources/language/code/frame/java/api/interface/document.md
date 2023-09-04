# java 接口文档管理

接口生成工具:

- Swagger 
  - Knife4j 
  - YApi 
- smart-doc 

Knife4j/YApi 与 swagger 类似, 增强了 swagger 的功能

对比:

swagger 系列, 易用但是倾入性强, 

需要使用对应的 [ApiModel和ApiModelProperty等注解](https://m.imooc.com/wiki/swaggerlesson-apimodelproperty) 进行标注

---

[smart-doc](https://smart-doc-group.github.io/#/zh-cn/) 无倾入性, 需要调用功能需要另外部署例如 torna 工具

只需要使用 java 中的文档标注就可以了, 对于类来说, 我们可以直接在 idea 的提示中看到对应的注释信息, 不用跳到对应的类进行查看

接口调试工具:

- Torna 
- Postman 
- Apifox 

本来 我对 [Apifox](https://apifox.com/#pricing) 心有所属
可是私服要米, 算了算了

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230902165827.png)

postman 我习惯在本地用了
虽然 postman 也可以开启私服

直到我发现了 [Torna](https://torna.cn/) 

可以导入 smart-doc 文档, 可以 [tanghc/torna 自己定制化 - 码云](https://gitee.com/durcframework/torna/tree/master)
界面还清爽, 太舒服了

如果让我选, 我会选择 smart-doc 跟 torna 的结合来定制自己的 文档管理

当然 使用 smart-doc 结合 apifox 也不是不行 [Springboot项目使用smart-doc+Apifox 便捷生成管理接口文档_springboot apifox_Gangbb的博客-CSDN博客](https://blog.csdn.net/qq_37132495/article/details/122569906)

smart-doc 与 swagger 对比使用:

[真的别再用Swagger了，你知道为什么吗？-51CTO.COM](https://www.51cto.com/article/758581.html)

文档涉及工具对比:

[这些年我用过的API文档工具，个个是精品！-腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1919600)

## swagger 使用

[ApiModel和ApiModelProperty_Swagger 入门教程-慕课网 (imooc.com)](https://m.imooc.com/wiki/swaggerlesson-apimodelproperty)

参考:

[真的别再用Swagger了，你知道为什么吗？-51CTO.COM](https://www.51cto.com/article/758581.html)

[这些年我用过的API文档工具，个个是精品！-腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/article/1919600)

[Springboot项目使用smart-doc+Apifox 便捷生成管理接口文档_springboot apifox_Gangbb的博客-CSDN博客](https://blog.csdn.net/qq_37132495/article/details/122569906)

[Document --- 公文 (smart-doc-group.github.io)](https://smart-doc-group.github.io/#/zh-cn/)

[ApiModel和ApiModelProperty_Swagger 入门教程-慕课网 (imooc.com)](https://m.imooc.com/wiki/swaggerlesson-apimodelproperty)
