# springboot 常用组件

## Actuator | 监控/健康检查

[Spring Boot Actuator 使用 弹簧启动执行器 使用](https://www.jianshu.com/p/af9738634a21)

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

## Security | 安全认证
[Security 入门 之 Spring Boot中使用Spring Security进行安全控制](https://blog.didispace.com/springbootsecurity/)

## mapstruct
类 转换
dto bo po

@mapper

编译的时候 转换类自动生成
[Mapstruct @Mapper @Mapping 使用介绍以及总结](https://blog.csdn.net/weixin_44131922/article/details/126232977)

```xml
...
<properties>
    <org.mapstruct.version>1.5.2.Final</org.mapstruct.version>
</properties>
...
<dependencies>
    <dependency>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct</artifactId>
        <version>${org.mapstruct.version}</version>
    </dependency>
</dependencies>
...
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.mapstruct</groupId>
                        <artifactId>mapstruct-processor</artifactId>
                        <version>${org.mapstruct.version}</version>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
...

```

配置:

```java
package org.aurora.mapstruct;

import org.aurora.lombok.PersionDTO;
import org.aurora.lombok.PersonVO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MyMapper {

    MyMapper INSTANCE = Mappers.getMapper(MyMapper.class);

    @Mapping(source = "describe", target = "des")
    PersonVO transToViewObject(PersionDTO persionDTO);
}

```

生成的代码:

```java
package org.aurora.mapstruct;

import javax.annotation.Generated;
import org.aurora.lombok.PersionDTO;
import org.aurora.lombok.PersonVO;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2022-08-11T16:24:31+0800",
    comments = "version: 1.2.0.Final, compiler: javac, environment: Java 1.8.0_211 (Oracle Corporation)"
)
public class MyMapperImpl implements MyMapper {

    @Override
    public PersonVO transToViewObject(PersionDTO persionDTO) {
        if ( persionDTO == null ) {
            return null;
        }

        PersonVO personVO = new PersonVO();

        personVO.setDes( persionDTO.getDescribe() );
        personVO.setPId( persionDTO.getPId() );
        personVO.setName( persionDTO.getName() );
        personVO.setAge( persionDTO.getAge() );
        personVO.setSex( persionDTO.getSex() );

        return personVO;
    }
}

```