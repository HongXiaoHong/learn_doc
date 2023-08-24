# 编码

编码可以分为 
- ASCII 编码
- gbk 编码
- UTF 编码 区别在于 编码单元不一样, utf8就以一个字节为编码单元, 16就2个字节为编码单位
  - utf8
  - utf16
  - utf32

Unicode/UFC-2 全球字符统一使用的码点
java/python/JavaScript 都是用的 Unicode 来保存string

<mark>
js有点特殊 使用 UFC2 只能存储两个字节, 于是扩展面的码点无法存储
但是 es6 改进了这一点
</mark>


UTF-16字符编码
https://www.bilibili.com/video/BV1Je411j7J8/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209

第一，UTF是Unicode转换格式，即Unicode编码的编码
第二，UTF-16以16位即双字节为编码单元
第三，UTF-16的编码结果为一个编码单元或两个编码单元
第四，Unicode基本字符的UTF-16编码与码点相等
第五，Unicode增补字符的UTF-16编码是一对代理
第六，UTF-16代理的取值范围分布在Unicode的保留区域
第七，Java语言内部使用UTF-16编码来表示字符
第八，UTF-16是一种变长编码，非常容易被误认为是定长编码

在线运行 java 之后
https://www.bejson.com/runcode/java/

你就会发现其实java的length也是算的编码单元, 而不是码点
如要记录真实的字符数量还得使用码点进行计算

```java
public class Main {
    public static void main(String[] args) {
        String input = "𝌆𝌆𝌆";
        System.out.println(input.codePointCount(0, 6));

        // Loop through each character and print its Unicode code point
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            int unicode = (int) c;
            System.out.println("Character: " + c + ", Unicode: " + unicode);
        }
    }
}

```

codePointCount api: 

https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html#codePointCount(int,int)

### 字符串码点转换
#### java
将码点转换为对应的字符串, 至于为什么不转换成 char
是因为 char 只有两个字节, 根本容纳不下有 2 个编码单元的扩展码点
而 java 中 Unicode 默认使用的是 utf-16 来进行存储
所以这里使用的是 String, 而不是 char 来转换
```java
public class Test {
    public static void main(String[] args) {
        String s = "𝌆🍷𝌆🍷𝌆";
        // 遍历编码单元
        for (int i = 0; i < s.length(); i++) {
            int cp = s.codePointAt(i);
            if (!Character.isSupplementaryCodePoint(cp)) {
                System.out.println((char) cp);
            } else {
                System.out.println(cp);
                System.out.println(fromCodePoint(cp));
                i++;
            }
        }

        String str = "𝌆𝌆";
        // 获取String的码点数组 => 码点数量
        int[] codePoints = str.codePoints().toArray();
        System.out.println(codePoints.length);
        //将码点数组转换成字符串
        str = new String(codePoints, 0, codePoints.length);

        System.out.println(str);
    }

    /**
     * 将码点转换为对应的字符串, 至于为什么不转换成 char
     * 是因为 char 只有两个字节, 根本容纳不下有 2 个编码单元的扩展码点
     * 而 java 中 Unicode 默认使用的是 utf-16 来进行存储
     * 所以这里使用的是 String, 而不是 char 来转换
     *
     * @param cp 码点
     * @return 码点对应的字符串
     */
    private static String fromCodePoint(int cp) {
        return new String(new int[]{cp}, 0, 1);
    }

}


```

#### JavaScript

https://www.ruanyifeng.com/blog/2014/12/unicode.html
JavaScript 中的字符串的编码也是使用的 Unicode 编码

只不过早起的 JavaScript 用的是UCS-2！

只支持 2 个字节, 也就是一个编码单元的识别
如果需要两个编码单元, 也就是 4 个字节, ucs-2 就无法识别了


后面 es6 也支持 4 个字节的识别
按道理应该也是 UTF-16 这种编码了
也就跟 java 差不多了
不过 java 中没有直接转换码点的方法
JavaScript 倒是提供了, very good 

```JavaScript
String.fromCodePoint(Number.parseInt("1F600", 16)) // 😀

String.fromCodePoint(Number.parseInt("1F680", 16))
'🚀'
'🚀'.codePointAt(0)
128640
```


## Unicode
Unicode 一览表

https://zh.wikipedia.org/zh-hans/Unicode%E5%AD%97%E7%AC%A6%E5%B9%B3%E9%9D%A2%E6%98%A0%E5%B0%84
Unicode 字符列表
https://zh.wikipedia.org/zh-hans/Unicode%E5%AD%97%E7%AC%A6%E5%88%97%E8%A1%A8

### 中文
https://www.lddgo.net/string/cjk-unicode
![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230824171019.png)

基本汉字使用 4E00 - 9FFF 匹配
如果正则表达式中需要匹配其他的生僻字

### 韩文
AC00-D7AF	谚文音节	Hangul Syllables
https://zh.wikipedia.org/zh-hans/%E8%B0%9A%E6%96%87

谚文（朝鲜语：언문／諺文），韩国官方将其中文译名定为韩古尔朝鲜语：한글／韓㐎 关于这个音频文件 Hangeul 帮助·信息）或韩字[3]，朝鲜官方则使用朝鲜国文（朝鲜语：조선글／朝鮮㐎 Chosŏn'gŭl）一称为其中文译名，俗称“朝鲜字母”、“㐎”、“训民正音”等，是朝鲜语所使用的表音文字。

15世纪，在朝鲜王朝（1392年－1897年）第四代君主世宗（1418年－1450年在位）的倡导下，由世宗本人于1443年正式创建，并在1446年与几位学者颁布使用。

### 杂项符号和图符
https://zh.wikipedia.org/zh-hans/%E9%9B%9C%E9%A0%85%E7%AC%A6%E8%99%9F%E5%92%8C%E5%9C%96%E7%AC%A6

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230824160151.png)

这里记录着 Unicode 的各种奇奇怪怪的图标

### emoji
1F600-1F64F

https://zh.wikipedia.org/zh-hans/%E9%9B%9C%E9%A0%85%E7%AC%A6%E8%99%9F%E5%92%8C%E5%9C%96%E7%AC%A6

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230824170247.png)