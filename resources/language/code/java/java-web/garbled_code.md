# 乱码

java web中的乱码问题集锦

## 请求

首先是请求的乱码问题，这个问题出现在Tomcat8以前的版本（不包括Tomcat8）。我们还是分情况来讨论，众所周知，我们现在使用的HTTP协议中的请求常用主流的方式有两种，一种是GET；另一种是POST。

我们就分别以GET和POST为例来说一下中文参数乱码的问题。

### POST

如果是POST方式请求，请求的参数会在HTTP协议的请求体中携带过来，而表单中的数据默认会以application/x-www-form-urlencoded的格式传输。而这种格式是用类似UrlEncoder.encode()的方式以UTF-8编码的。这样携带的参数会以流的方式直接到达服务器中放入request对象内部的缓冲区中，以二进制的方式存储，可以理解为一个byte数组来存储的0101的二进制数据。而调用request.getParameter()时会把缓冲区的数据拿出来用Url的格式构造成一个字符串，而构造时使用的默认编码就是request的默认编码，而<mark>request又是由Tomcat创建的，所以和Tomcat的默认编码一致，也就是ISO-8859-1</mark>。所以中文字符串直接乱码了。  

而解决的方式就显而易见了，由于request的默认编码是ISO-8859-1才导致这个问题，所以只要把默认编码改掉就行了。而request中正好有这个API。就是<mark>request.setCharacterEncoding("UTF-8")</mark>。所以直接一句话就能解决request的POST乱码了。  

### GET

接下来是request的GET方式的请求。GET方式请求略微复杂一些，我们用画图的方式分析。

由于GET请求的参数是从URL上拼接，在地址栏上传输的。也就是在HTTP协议的请求行上传输的，所以在这要提一下HTTP协议的规则。HTTP协议中的请求行上是不允许出现中文字符的，所以浏览器对GET请求传递的中文参数做了默认处理，也就是把中文字符转换成了非中文字符。那么它是怎么转换的呢？很简单，还是使用的URLEncoder.encode()方法。用这个方法可以把中文以指定的编码(浏览器默认为UTF-8)转成一串类似"%A3%B5%6F%D3"这样格式的数据，而这个数据虽然表示的还是中文字符，但是显示出来的格式就像是加密了一样成为了全英文的字符。所以可以直接在请求行上传输了。而到达服务器之后，这个字符串会存储到request对象的内部。当我们调用request.getParameter(）方法的时候，request会把这个URL格式的字符串再解码回中文字符串。然而由于浏览器上用的是UTF-8的编码转码的，所以需要用UTF-8的方式解码才可以。而<mark>在request对象的内部，默认解码的编码是ISO-8859-1</mark>。所以虽然"%A3%B5%6F%D3"正确的传输过来了，也在服务器端接收到了，也就是说数据是对的，只不过格式错了。类似于一个txt的文件，非要把后缀名改为jpg然后用图片查看器查看，这样肯定是看到一片乱码。而我们得到的字符串就是这个原因才是乱码。不过字符串虽然是乱码，但是对应的二进制数据是对的，所以我们只需要把这个字符串再还原为二进制数据再重新编码就行了。所以可以调用String的getBytes方法，传参为ISO-8859-1，用这个码重新把字符串还原为二进制的byte数据。然后再用String 的构造器new String(byte[] ,"UTF-8")重新指定UTF-8的编码构造字符串即可。总体来说，GET的乱码解决方式就是

<mark>String name = new String(req.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");</mark>

> 现用 req.getParameter("name").getBytes("ISO-8859-1") 得到浏览器传过来的原始字节, 然后用 utf8 进行解码得到真正的字符串

### cookie



大家介绍一下cookie中存储中文的问题。cookie中默认是不能存储中文的，原因和上面一样，因为cookie 是用response的响应头设置回浏览器存储的，而响应头中不支持中文字符，所以不能保存cookie。解决方式就是我们手动的编码，把cookie中的中文字符串转码为非中文字符，也就是运用URLEncoder和URLDecoder两个类的编码和解码方法处理。代码如下：

```java
Cookie[] cookies = request.getCookies();            
   if (cookies != null) {                        
for (Cookie cookie : cookies) {                                
if ("name".equals(cookie.getName())) {                       
                 //%E4%B8%AD%E6%96%87    
       String value = cookie.getValue();  
       System.out.println("已经存在的cookie的value值：" + value);       
       System.out.println("解码后的字符串：" + URLDecoder.decode(value, "UTF-8"));  
}                        
}                
}                
 String value = "中文";                
//Cookie cookie = new Cookie("name", value);                
String encode = URLEncoder.encode(value, "UTF-8");                
System.out.println("编码后的字符串：" + encode);                
Cookie cookie = new Cookie("name", encode);                
response.addCookie(cookie);


```



## 响应



### 文件下载

先说为什么使用 ISO8859-1 编码，这个主要是由于http协议，<mark>http header头要求其内容必须为iso8859-1编码</mark>，所以我们最终要把其编码为 ISO8859-1 编码的字符串；因为ISO-8859-1编码范围使用了单字节内的所有空间，在支持ISO-8859-1的系统中传输和存储其他任何编码的字节流都不会被抛弃。换言之，<mark>把其他任何编码的字节流当作ISO-8859-1编码看待都没有问题</mark>

但是前面为什么不直接使用 "中文文件名".getBytes("ISO8859-1"); 这样的代码呢？

因为ISO8859-1编码的编码表中，根本就没有包含汉字字符，当然也就无法通过"中文文件名".getBytes("ISO8859-1");来得到正确的“中文文件名”在ISO8859-1中的编码值了，所以再通过new String()来还原就无从谈起了。 

所以先通过 "中文文件名".getBytes("utf-8") 获取其 byte[] 字节，让其按照字节来编码，即在使用 new String("中文文件名".getBytes("utf-8"), "ISO8859-1") 将其重新组成一个字符串，传送给浏览器。

String.getBytes(String decode)

方法会根据指定的decode编码返回某字符串在该编码下的byte数组

new String(byte[], decode)

使用decode指定的编码来将byte[]解析成字符串。


```java

```



浏览器那边会帮我们设置回原来的utf8字符串, 过程类似如下:

```java
String fileName = "测试";
fileName = new String(fileName.getBytes(), "ISO8859-1");
System.out.println("模拟传输：" + fileName); 
//使用iso8859-1编码后 fileName 在这些字符传递到目的地后，目的地程序再通过相反的方式
fileName = new String(fileName.getBytes("ISO8859-1"));
System.out.println("前端得到的文件名：" + fileName);
```

要实现文件的下载，不仅需要指定文件的路径，还需要在HTTP协议中设置两个响应消息头，具体如下：

消息头

```java
//设定接收程序处理数据的方式

Content-Disposition: attachment; filename =

//设定实体内容的MIME类型

Content-Type：application/x-msdownload
```

前端:

```html
<form action="uploadUrl" method="post" enctype="multipart/form-data">
    <input type="file" name="filename" multiple="multiple" />
    <input type="submit" value="文件上传" />
</form>
```

后端代码:

```java
response.addHeader("Content-Type", "application/octet-stream");

 response.addHeader("Content-Disposition","attachment;filename="

 +URLEncoder.encode(file.getName(),"utf-8"));
```



## 前端页面

HTML可以通过以下方式来规定字符的编码：

1. `<meta>`标签：在HTML文档的头部（`<head>`标签内）添加`<meta>`标签来指定字符编码。常见的字符编码包括UTF-8、ISO-8859-1等。例如：
   
   ```html
   <meta charset="UTF-8">
   ```

2. HTTP头部：通过在服务器返回的HTTP响应头部中添加`Content-Type`字段来指定字符编码。例如：
   
   ```
   Content-Type: text/html; charset=UTF-8
   ```

3. HTML实体引用：使用HTML实体引用来表示特殊字符。例如，`&lt;`表示小于号（<），`&gt;`表示大于号（>），`&amp;`表示&符号，等等。

请注意，指定字符编码是确保HTML文档正确解析和显示的重要步骤，特别是当文档中包含非ASCII字符或特殊字符时。确保HTML文档的字符编码与实际使用的字符编码一致，可以避免乱码和显示错误。



## 参考

[JavaEE中乱码问题的讨论 - 掘金](https://juejin.cn/post/6844904095623430152)

[java 下载文件名 编码_filename.getbytes_老谭TYH的博客-CSDN博客](https://blog.csdn.net/qq_30436011/article/details/128043144)

[前端那些事儿 - 表单域的 MIME 编码 | 曜彤.手记 (yhspy.com)](https://www.yhspy.com/2015/11/24/%E5%89%8D%E7%AB%AF%E9%82%A3%E4%BA%9B%E4%BA%8B%E5%84%BF-%E8%A1%A8%E5%8D%95%E5%9F%9F%E7%9A%84-MIME-%E7%BC%96%E7%A0%81/)
