# spring 配置与源码

## spring.application.name | 应用名字
项目启动的时候会获取 应用的名字
没有配置就采用默认的 application
org.springframework.boot.context.ContextIdApplicationContextInitializer#getApplicationId
```java

private String getApplicationId(ConfigurableEnvironment environment) {
		String name = environment.getProperty("spring.application.name");
		return StringUtils.hasText(name) ? name : "application";
	}
```