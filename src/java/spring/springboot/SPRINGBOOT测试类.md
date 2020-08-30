# SPRINGBOOT测试类

## 快速开始

1. 在pom.xml中加入

   ```xml
   <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-starter-test</artifactId>
               <scope>test</scope>
               <exclusions>
                   <exclusion>
                       <groupId>org.junit.vintage</groupId>
                       <artifactId>junit-vintage-engine</artifactId>
                   </exclusion>
               </exclusions>
           </dependency>
   ```

   

2. 在test/java下新建类

   ![](D:\learn\note\SpringBoot\photo\Snipaste_2020-08-30_17-58-27.jpg)

3. 在对应的方法加上@Test

   ```java
   package person.hong.learn.api.utils;
   
   import org.junit.jupiter.api.Test;
   
   /**
    * @description:
    * @author: 洪晓鸿
    * @time: 2020/8/30 17:50
    */
   
   public class FileUtilsTest {
   
       @Test
       public void getFilePaths() {
           FileUtils.getFilePaths();
       }
   }
   
   ```

   