# bat

windows编程语言

cmd

todo 

[(243条消息) winodws下cmd对结果进行筛选_SHUIPING_YANG的博客-CSDN博客_cmd 筛选](https://blog.csdn.net/zhezhebie/article/details/79590730)

## 常用指令
### dir | 列举目录的子文件

https://cloud.tencent.com/developer/article/1908580

```bash
E:\documents\notes\learn_doc\resources\language\code\java\base>dir /s
 驱动器 E 中的卷是 experiment
 卷的序列号是 02B9-A5C7

 E:\documents\notes\learn_doc\resources\language\code\java\base 的目录

2023/09/08  09:26    <DIR>          .
2023/09/04  16:00    <DIR>          ..
2023/09/08  11:19             4,385 api.md
2023/05/27  11:27             1,296 function_interface.md
2023/03/10  15:01               267 juc.md
2023/04/05  15:54    <DIR>          jvm
2023/03/17  20:41             6,372 jvm.md
               4 个文件         12,320 字节

 E:\documents\notes\learn_doc\resources\language\code\java\base\jvm 的目录

2023/04/05  15:54    <DIR>          .
2023/09/08  09:26    <DIR>          ..
2023/04/05  15:54    <DIR>          performance
2023/03/27  16:35             3,204 summary.md
               1 个文件          3,204 字节

 E:\documents\notes\learn_doc\resources\language\code\java\base\jvm\performance 的目录

2023/04/05  15:54    <DIR>          .
2023/04/05  15:54    <DIR>          ..
2023/05/30  18:10             9,141 monitor.md
               1 个文件          9,141 字节

     所列文件总数:
               6 个文件         24,665 字节
               8 个目录 237,763,870,720 可用字节

E:\documents\notes\learn_doc\resources\language\code\java\base>dir /s /b
E:\documents\notes\learn_doc\resources\language\code\java\base\api.md
E:\documents\notes\learn_doc\resources\language\code\java\base\function_interface.md
E:\documents\notes\learn_doc\resources\language\code\java\base\juc.md
E:\documents\notes\learn_doc\resources\language\code\java\base\jvm
E:\documents\notes\learn_doc\resources\language\code\java\base\jvm.md
E:\documents\notes\learn_doc\resources\language\code\java\base\jvm\performance
E:\documents\notes\learn_doc\resources\language\code\java\base\jvm\summary.md
E:\documents\notes\learn_doc\resources\language\code\java\base\jvm\performance\monitor.md

E:\documents\notes\learn_doc\resources\language\code\java\base>help dir
显示目录中的文件和子目录列表。

DIR [drive:][path][filename] [/A[[:]attributes]] [/B] [/C] [/D] [/L] [/N]
  [/O[[:]sortorder]] [/P] [/Q] [/R] [/S] [/T[[:]timefield]] [/W] [/X] [/4]

  [drive:][path][filename]
              指定要列出的驱动器、目录和/或文件。

  /A          显示具有指定属性的文件。
  属性         D  目录                R  只读文件
               H  隐藏文件            A  准备存档的文件
               S  系统文件            I  无内容索引文件
               L  重新分析点          O  脱机文件
               -  表示“否”的前缀
  /B          使用空格式(没有标题信息或摘要)。
  /C          在文件大小中显示千位数分隔符。这是默认值。用 /-C 来
              禁用分隔符显示。
  /D          跟宽式相同，但文件是按栏分类列出的。
  /L          用小写。
  /N          新的长列表格式，其中文件名在最右边。
  /O          用分类顺序列出文件。
  排列顺序     N  按名称(字母顺序)     S  按大小(从小到大)
               E  按扩展名(字母顺序)   D  按日期/时间(从先到后)
               G  组目录优先           -  反转顺序的前缀
  /P          在每个信息屏幕后暂停。
  /Q          显示文件所有者。
  /R          显示文件的备用数据流。
  /S          显示指定目录和所有子目录中的文件。
```