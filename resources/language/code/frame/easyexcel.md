# java 框架

## easyExcel

官网: 
https://easyexcel.opensource.alibaba.com/docs/current/quickstart/read#%E6%9C%80%E7%AE%80%E5%8D%95%E7%9A%84%E8%AF%BB%E7%9A%84%E7%9B%91%E5%90%AC%E5%99%A8

讲解:
https://www.bilibili.com/video/BV1Sx4y1R76F/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209
https://www.bilibili.com/video/BV1rT411874e/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209

```java
invoke:46, PageReadListener (com.alibaba.excel.read.listener)
dealData:104, DefaultAnalysisEventProcessor (com.alibaba.excel.read.processor)
endRow:51, DefaultAnalysisEventProcessor (com.alibaba.excel.read.processor)
endElement:66, RowTagHandler (com.alibaba.excel.analysis.v07.handlers)
endElement:99, XlsxRowHandler (com.alibaba.excel.analysis.v07.handlers.sax)
endElement:618, AbstractSAXParser (com.sun.org.apache.xerces.internal.parsers)
scanEndElement:1728, XMLDocumentFragmentScannerImpl (com.sun.org.apache.xerces.internal.impl)
next:2899, XMLDocumentFragmentScannerImpl$FragmentContentDriver (com.sun.org.apache.xerces.internal.impl)
next:605, XMLDocumentScannerImpl (com.sun.org.apache.xerces.internal.impl)
scanDocument:542, XMLDocumentFragmentScannerImpl (com.sun.org.apache.xerces.internal.impl)
parse:889, XML11Configuration (com.sun.org.apache.xerces.internal.parsers)
parse:825, XML11Configuration (com.sun.org.apache.xerces.internal.parsers)
parse:141, XMLParser (com.sun.org.apache.xerces.internal.parsers)
parse:1224, AbstractSAXParser (com.sun.org.apache.xerces.internal.parsers)
parse:637, SAXParserImpl$JAXPSAXParser (com.sun.org.apache.xerces.internal.jaxp)
parseXmlSource:239, XlsxSaxAnalyser (com.alibaba.excel.analysis.v07)
execute:260, XlsxSaxAnalyser (com.alibaba.excel.analysis.v07)
analysis:124, ExcelAnalyserImpl (com.alibaba.excel.analysis)
read:66, ExcelReader (com.alibaba.excel)
read:56, ExcelReader (com.alibaba.excel)
doRead:65, ExcelReaderSheetBuilder (com.alibaba.excel.read.builder)
simpleRead:40, TestExcel (me.yi.hong.excel)
```



![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/OdNbnb3xQ4.png)



原理是 通过 回调 对已经读取的数据进行处理
其实画一个 时序图 或者什么其他调用关系来梳理会更好
下次有时间再说吧