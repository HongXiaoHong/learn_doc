# mybatis 流式查询

使用Java程序从数据库中查询大量的数据时出现OOm异常, 除了使用jvm的参数提高内存, 还有什么方法可以解决,
在MyBatis中，流式查询可以通过使用`Cursor`或`ResultHandler`来实现。以下是关于如何使用这两种方式以及相关注意事项的总结：

## 使用Cursor进行流式查询

`Cursor`是MyBatis 3.4.0及以上版本提供的一个特性，它允许你以流的方式处理查询结果。`Cursor`是一个`Iterable`的实现，你可以像处理其他`Iterable`对象一样处理它。当你遍历`Cursor`时，MyBatis会从数据库中获取数据，这意味着你不需要一次性加载所有数据到内存中。

以下是一个使用`Cursor`的例子：

```java
try (SqlSession sqlSession = sqlSessionFactory.openSession();
     Cursor<User> cursor = sqlSession.getMapper(UserMapper.class).getAllUsers()) {
  for (User user : cursor) {
    // 在这里处理每个用户
  }
}
```

在这个例子中，`getAllUsers`方法返回一个`Cursor`，你可以遍历这个`Cursor`来处理每个用户。

**注意事项**：

- 使用Cursor时，你需要确保在使用完毕后关闭它，否则可能会导致资源泄露。你可以通过使用Java 7的try-with-resources语句来自动关闭Cursor。

## 使用ResultHandler进行流式查询

`ResultHandler`是一个接口，它有一个`handleResult`方法，这个方法会在每次从数据库中获取一个结果时被调用。你可以在`handleResult`方法中处理数据，例如保存到文件或发送到另一个服务。

以下是一个使用`ResultHandler`的例子：

```java
sqlSession.select("com.example.MyMapper.selectLargeData", new ResultHandler() {
  @Override
  public void handleResult(ResultContext context) {
    MyData data = (MyData) context.getResultObject();
    // 在这里处理数据
  }
});
```

在这个例子中，`handleResult`方法会在每次从数据库中获取一个结果时被调用。

**注意事项**：

- `fetchSize`字段决定了每次从数据库中获取的结果数量。如果你一次查询的数据量没有超过堆栈上限，可以设置一个较大的fetchSize值来提高查询效率。如果你需要查询大量数据，可以将fetchSize设置为Integer.MIN_VALUE，这会告诉数据库驱动一次只返回一个结果，这样可以避免内存溢出。这是MySQL JDBC驱动程序的特性，其他数据库的驱动程序可能不支持这种行为。

总的来说，`Cursor`和`ResultHandler`都可以用于处理大量数据，但它们的使用方式和适用场景有所不同。你可以根据你的具体需求来选择最适合你的方法。





### 扩展阅读

[MyBatis流式查询的三种实现方法-eolink官网](https://www.eolink.com/news/post/38548.html)

[MyBatis——流式查询 | Yu's Blog (nuistgy.github.io)](https://nuistgy.github.io/2023/03/09/mybatis%E6%B5%81%E5%BC%8F%E6%9F%A5%E8%AF%A2/#MyBatis-%E6%B5%81%E5%BC%8F%E6%9F%A5%E8%AF%A2%E6%8E%A5%E5%8F%A3)