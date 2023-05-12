# elk

## 入门

elk 大概流程

[(25条消息) ELK日志管理系统图示全过程详解_羌俊恩的博客-CSDN博客](https://blog.csdn.net/ximenjianxue/article/details/100655154)

Filebeat一个典型的应用场景：

Filebeat从nignx读取日志文件，将过滤后的数据传给Logstash。
Logstash收集到Filebeat传来的数据后格式化输出到 Elasticsearch。
最后再由Kibana 访问Elasticsearch提供的比较友好的 Web 界面进行汇总、分析、搜索。
因logstash是jvm跑的，资源消耗比较大，启动一个logstash就需要消耗500M左右的内存，而filebeat只需要10来M内存资源。常用的ELK日志采集方案中，大部分的做法就是将所有节点的日志内容通过filebeat送到kafka消息队列，然后使用logstash集群读取消息队列内容，根据配置文件进行过滤。然后将过滤之后的文件输送到elasticsearch中，通过kibana去展示。

日志链路跟踪

[(25条消息) 日志排查问题困难？分布式日志链路跟踪来帮你_ttl 解决日志子线程_zlt2000的博客-CSDN博客](https://blog.csdn.net/zlt2000/article/details/99641821?spm=1001.2101.3001.6650.9&utm_medium=distribute.pc_relevant.none-task-blog-2~default~OPENSEARCH~default-9.highlightwordscore&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~OPENSEARCH~default-9.highlightwordscore)
