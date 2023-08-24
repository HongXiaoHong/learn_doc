# java 基础
## 字符串
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

### 字符串码点转换

将码点转换为对应的字符串, 至于为什么不转换成 char
是因为 char 只有两个字节, 根本容纳不下有 2 个编码单元的扩展码点
而 java 中 Unicode 默认使用的是 utf-16 来进行存储
所以这里使用的是 String, 而不是 char 来转换

具体 api 可查 https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/String.html
java 中竟然没有直接可以将码点转换为字符串的api, 着实有点辣鸡了..
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

Java 正确遍历字符串 https://blog.csdn.net/l294265421/article/details/47281023
这篇文章中提到也只是如何遍历码点
并没有将码点转换为 字符串
