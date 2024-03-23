# mybatis

## 复习

[JDBC Batch - 廖雪峰的官方网站 (liaoxuefeng.com)](https://www.liaoxuefeng.com/wiki/1252599548343744/1322290857902113)

原生 jdbc 如何批量操作数据库

```java
try (PreparedStatement ps = conn.prepareStatement("INSERT INTO students (name, gender, grade, score) VALUES (?, ?, ?, ?)")) {
    // 对同一个PreparedStatement反复设置参数并调用addBatch():
    for (Student s : students) {
        ps.setString(1, s.name);
        ps.setBoolean(2, s.gender);
        ps.setInt(3, s.grade);
        ps.setInt(4, s.score);
        ps.addBatch(); // 添加到batch
    }
    // 执行batch:
    int[] ns = ps.executeBatch();
    for (int n : ns) {
        System.out.println(n + " inserted."); // batch中每个SQL执行的结果数量
    }
}
```

## 批量模式

[10万条数据批量插入，到底怎么做才快？-mysql批量插入数据 (51cto.com)](https://www.51cto.com/article/688454.html)



```java
@Service 
public class UserService extends ServiceImpl<UserMapper, User> implements IUserService { 
    private static final Logger logger = LoggerFactory.getLogger(UserService.class); 
    @Autowired 
    UserMapper userMapper; 
    @Autowired 
    SqlSessionFactory sqlSessionFactory; 
 
    @Transactional(rollbackFor = Exception.class) 
    public void addUserOneByOne(List<User> users) { 
        SqlSession session = sqlSessionFactory.openSession(ExecutorType.BATCH); 
        UserMapper um = session.getMapper(UserMapper.class); 
        long startTime = System.currentTimeMillis(); 
        for (User user : users) { 
            um.addUserOneByOne(user); 
        } 
        session.commit(); 
        long endTime = System.currentTimeMillis(); 
        logger.info("一条条插入 SQL 耗费时间 {}", (endTime - startTime)); 
    } 
} 
```

## 正题

[mybatis批量插入优化（ExecutorType.BATCH/BatchInsert/executeBatch）_Moshow郑锴的博客-CSDN博客](https://blog.csdn.net/moshowgame/article/details/122226553)

讲解: [【IT老齐180】MyBatis批量插入几千条数据，请慎用foreach_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1r34y1W7EL/?spm_id_from=333.788.recommend_more_video.5&vd_source=eabc2c22ae7849c2c4f31815da49f209)

```java
//批量插入对比
    try (SqlSession session = sqlSessionFactory.openSession()) {
        GeneratedAlwaysAnnotatedMapper mapper = session.getMapper(GeneratedAlwaysAnnotatedMapper.class);
        List<GeneratedAlwaysRecord> records = getRecordsToInsert(); // not shown
            
        MultiRowInsertStatementProvider<GeneratedAlwaysRecord> multiRowInsert = insertMultiple(records)
                .into(generatedAlways)
                .map(id).toProperty("id")
                .map(firstName).toProperty("firstName")
                .map(lastName).toProperty("lastName")
                .build()
                .render(RenderingStrategies.MYBATIS3);
            
        int rows = mapper.insertMultiple(multiRowInsert);
    }

```

这 2 篇文章提到 要在 mysql 的 url 上加 rewriteBatchedStatements = true

[jdbc mysql设置rewriteBatchedStatements参数实现高性能批量处理 executeBatch返回值问题_jdbc rewritebatchedstatements-CSDN博客](https://blog.csdn.net/chuangxin/article/details/83447387)

[【MyBatis-Plus】批量插入数据太慢，使用参数rewriteBatchedStatements=true后，堪称速度与激情！ - 不灭的焱 (php-note.com)](https://php-note.com/2225.html)