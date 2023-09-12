# springboot 源码分析

## 自动加载原理
[EnableAutoConfiguration注解的工作原理](https://www.jianshu.com/p/464d04c36fb1)

springboot 2.0 是从 
META-INF/spring.factories 下面进行加载

springboot 3.0 ＋ 不好意思哈, 改了

```java
protected List<String> getCandidateConfigurations(AnnotationMetadata metadata, AnnotationAttributes attributes) {
		List<String> configurations = ImportCandidates.load(AutoConfiguration.class, getBeanClassLoader())
			.getCandidates();
		Assert.notEmpty(configurations,
				"No auto configuration classes found in "
						+ "META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports. If you "
						+ "are using a custom packaging, make sure that file is correct.");
		return configurations;
	}
```

在 META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports 下面了呢

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230912173436.png)

