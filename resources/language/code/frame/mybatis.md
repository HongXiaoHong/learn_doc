入门

[(18条消息) 狂神说Java Mybatis笔记_每天进步一點點的博客-CSDN博客](https://blog.csdn.net/DDDDeng_/article/details/106927021)

[SpringBoot整合Mybatis完整详细版_springboot mybatis_海岛拾贝的博客-CSDN博客](https://blog.csdn.net/iku5200/article/details/82856621?spm=1001.2101.3001.6650.11&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-11-82856621-blog-79088577.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-11-82856621-blog-79088577.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=12)

mybatis 运行原理  核心类?

一对一 一对多 多对多

一 <association>

多 <collection>

[【Mybatis】（八）高级映射关系（一对一、一对多、多对多）-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/941743)

SQL session 如何管理?

springboot                                                                                                                                                                                         事务

分布式事务

## MyBatis 是否支持延迟加载

MyBatis根据对关联对象查询的select语句的执行时机，分为三种类型：直接加载、侵入式延迟加载与深度延迟加载。

- 直接加载：执行完对主加载对象的 select 语句，马上执行对关联对象的 select 查询。
- 侵入式延迟： 执行对主加载对象的查询时，不会执行对关联对象的查询。但当要访问主加载对象的详情属性时，就会马上执行关联对象的select查询。
- 深度延迟： 执行对主加载对象的查询时，不会执行对关联对象的查询。访问主加载对象的详情时也不会执行关联对象的select查询。只有当真正访问关联对象的详情时，才会执行对关联对象的 select 查询。

```xml
<!--全局参数设置-->
<settings>
    <!--延迟加载总开关-->
    <setting name="lazyLoadingEnabled" value="true"/>
    <!--侵入式延迟加载开关-->
    <!--3.4.1版本之前默认是true，之后默认是false-->
    <setting name="aggressiveLazyLoading" value="true"/>
</settings>
```

[mybatis懒加载(延迟加载) – 小猴子monkey1024的Java教程](http://www.monkey1024.com/framework/1378)

## 一级二级缓存

[(18条消息) mybatis一级缓存，二级缓存的开启、关闭、清除及使用说明_mybatis一级缓存开关是什么_迟到_啦的博客-CSDN博客](https://blog.csdn.net/qq_19314763/article/details/113534304)

一级缓存 默认开启

二级缓存不建议开启 开启后有脏读危险



## 事务管理

sqlsession 默认开启事务

MyBatis在结合Spring或SpringBoot时会将事务功能交由后者来进行管理

[MyBatis技术解密（七）：MyBatis事务管理 - 掘金 (juejin.cn)](https://juejin.cn/post/6844904067374792711)



## 批处理



[从七分钟到十秒，Mybatis 批处理真的很强！-51CTO.COM](https://www.51cto.com/article/707923.html)

sqlSessionFactory.openSession(ExecutorType.BATCH)​​得到的​​sqlSession​​对象（此时里面的​​Executor​​是​​BatchExecutor​​）去获得一个新的Mapper对象才能生效


batchSqlSession.commit(!TransactionSynchronizationMan

是否是事务环境，不是的话会强制提交，如果是事务环境的话，这个commit设置force值是无效的

```java
public class MybatisBatchUtils {
    
    /**
    * 每次处理1000条
    */
    private static final int BATCH_SIZE = 1000;
    
    @Resource
    private SqlSessionFactory sqlSessionFactory;
    
    /**
    * 批量处理修改或者插入
    *
    * @param data     需要被处理的数据
    * @param mapperClass  Mybatis的Mapper类
    * @param function 自定义处理逻辑
    * @return int 影响的总行数
    */
    public  <T,U,R> int batchUpdateOrInsert(List<T> data, Class<U> mapperClass, BiFunction<T,U,R> function) {
        int i = 1;
        SqlSession batchSqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH);
        try {
            U mapper = batchSqlSession.getMapper(mapperClass);
            int size = data.size();
            for (T element : data) {
                function.apply(element,mapper);
                if ((i % BATCH_SIZE == 0) || i == size) {
                    batchSqlSession.flushStatements();
                }
                i++;
            }
            // 非事务环境下强制commit，事务情况下该commit相当于无效
            batchSqlSession.commit(!TransactionSynchronizationManager.isSynchronizationActive());
        } catch (Exception e) {
            batchSqlSession.rollback();
            throw new CustomException(e);
        } finally {
            batchSqlSession.close();
        }
        return i - 1;
    }
}


```