## try-with-resources

### 作用

try-with资源语句 确保每个资源在语句结束时关闭

### 用法

实现AutoCloseable或Closeable接口的类 可以放到下面的resource

```java
BufferedReader resource;
try(resource=
new BufferedReader(new FileReader(path))){

}catch(Exception e){
throw e;
}
```

### 注意事项

> An exception can be thrown from the block of code associated with the try-with-resources statement. In the example writeToFileZipFileContents, an exception can be thrown from the try block, and up to two exceptions can be thrown from the try-with-resources statement when it tries to close the ZipFile and BufferedWriter objects. If an exception is thrown from the try block and one or more exceptions are thrown from the try-with-resources statement, then those exceptions thrown from the try-with-resources statement are suppressed, and the exception thrown by the block is the one that is thrown by the writeToFileZipFileContents method. You can retrieve these suppressed exceptions by calling the Throwable.getSuppressed method from the exception thrown by the try block.

可以通过Throwable.getSuppressed从try块引发的异常中调用方法来检索这些抑制的异常 Throwable.getSuppressed 的使用可参见 参考2

### 参考

1. [The try-with-resources Statement](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html)
2. [Java Throwable getSuppressed()用法及代码示例](https://vimsky.com/examples/usage/throwable-getsuppressed-method-in-java-with-examples.html)
