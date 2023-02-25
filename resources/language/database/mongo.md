# mongo

MongoDB 一个非文档型 文档数据库

## hello M

### 入门

✨ [MongoDB中文手册|官方文档中文版 - MongoDB-CN-Manual (mongoing.com)](https://docs.mongoing.com/)

[documents/MongoDB.md · Aoisama/studied - Gitee.com](https://gitee.com/AoiX/studied/blob/master/documents/MongoDB.md#mongodb)

[黑马程序员MongoDB基础入门到高级进阶，一套搞定mongodb_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1bJ411x7mq/?spm_id_from=333.337.search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

### 部署

我这里用的是 docker 部署

```docker
docker run -it --name my_local_mongodb
 -e MONGO_INITDB_ROOT_USERNAME=hong
 -e MONGO_INITDB_ROOT_PASSWORD=Aqyzhhzzz_cssj_0922
 -v //e/mongo/share/db:/data/db
 -p 17017:27017 -d mongo:latest
```

### 特点

- 灵活
- 高可用
- 高性能

### 组成

数据库 -> 集合 -> 文档
类似于
mysql中的
数据库 -> 表 -> 记录

### GUI 客户端

1. idea database

2. 👍开源免费 robot 3T [Robo 3T | Free, open-source MongoDB GUI (formerly Robomongo)](https://robomongo.org/)

我这里使用的是 idea 连接

连接之前 记得先到 mongodb 中创建一个数据库

并且在数据库中创建一个用户

然后用这个用户登录

修改内容需要先进行登录

之前用的mongo 命令 新版本用的是这个 mongosh

mongosh -u user

Enter password:

```bash
test> use mydb
switched to db mydb
mydb> db.createUser( { user: "root", pwd: "123456", roles: [ { role: "root", db: "admin" } ] })
{ ok: 1 }
```

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/python/idea64_tc6NO60hpl.png)

## 命令

### 聚合查询

```mongodb
// 聚合函数测试
db.mydb.insertOne({_id: 1, name: "a", sex: 1, age: 1})
db.mydb.insertOne({_id: 2, name: "a", sex: 1, age: 2})
db.mydb.insertOne({_id: 3, name: "b", sex: 1, age: 3})
db.mydb.insertOne({_id: 4, name: "c", sex: 2, age: 4})
db.mydb.insertOne({_id: 5, name: "d", sex: 2, age: 5})

/*男女生的总年龄
#_id 必须加，后跟指定列 要分组的列名
#rew 求和 返回结果数*/
db.mydb.aggregate([
    {
        $group: {
            _id: "$sex",
            res: {$sum: "$age"}
        }
    }
])

// 求男女总人数
db.mydb.aggregate([
    {
        $group: {
            _id: "$sex",
            res: {$sum: 1}
        }
    }
])

// 求学生总数和平均年龄
db.mydb.aggregate([
    {
        $group: {
            _id: null,
            res: {$sum: 1},
            total_avg: {$avg: "$age"}
        }
    }
])

// 查询男生女生人数，升序排序
db.mydb.aggregate([
    {$group: {_id: "$sex", res: {$sum: 1}}},
    {$sort: {res: 1}}
])
```

#### $lookup | 多表查询

相当于左连接

```mongodb
{
   $lookup:
     {
       from: <collection to join>,
       localField: <field from the input documents>,
       foreignField: <field from the documents of the "from" collection>,
       as: <output array field>
     }
}
```

[详解MongoDB中的多表关联查询（$lookup） - 东山絮柳仔 - 博客园 (cnblogs.com)](https://www.cnblogs.com/xuliuzai/p/10055535.html)



```mongodb

```



### 索引

```mongodb
// 创建唯一索引
db.c1.createIndex( { name: -1 } )
// 分析索引
db.c1.find({name: "a"}).explain('executionStats')

因为我建立了索引的关系
这里使用了 FETCH 索引进行查询
------------------------------------结果--------------------------
[
  {
    "command": {
      "find": "c1",
      "filter": {
        "name": "a"
      },
      "$db": "mydb"
    },
    "executionStats": {
      "executionSuccess": true,
      "nReturned": 2,
      "executionTimeMillis": 15,
      "totalKeysExamined": 2,
      "totalDocsExamined": 2,
      "executionStages": {
        "stage": "FETCH",
        "nReturned": 2,
        "executionTimeMillisEstimate": 10,
        "works": 3,
        "advanced": 2,
        "needTime": 0,
        "needYield": 0,
        "saveState": 0,
        "restoreState": 0,
        "isEOF": 1,
        "docsExamined": 2,
        "alreadyHasObj": 0,
        "inputStage": {
          "stage": "IXSCAN",
          "nReturned": 2,
          "executionTimeMillisEstimate": 10,
          "works": 3,
          "advanced": 2,
          "needTime": 0,
          "needYield": 0,
          "saveState": 0,
          "restoreState": 0,
          "isEOF": 1,
          "keyPattern": {
            "name": -1
          },
          "indexName": "name_-1",
          "isMultiKey": false,
          "multiKeyPaths": {
            "name": []
          },
          "isUnique": false,
          "isSparse": false,
          "isPartial": false,
          "indexVersion": 2,
          "direction": "forward",
          "indexBounds": {
            "name": ["[\"a\", \"a\"]"]
          },
          "keysExamined": 2,
          "seeks": 1,
          "dupsTested": 0,
          "dupsDropped": 0
        }
      }
    },
    "explainVersion": "1",
    "ok": 1,
    "queryPlanner": {
      "namespace": "mydb.c1",
      "indexFilterSet": false,
      "parsedQuery": {
        "name": {
          "$eq": "a"
        }
      },
      "queryHash": "64908032",
      "planCacheKey": "A6C0273F",
      "maxIndexedOrSolutionsReached": false,
      "maxIndexedAndSolutionsReached": false,
      "maxScansToExplodeReached": false,
      "winningPlan": {
        "stage": "FETCH",
        "inputStage": {
          "stage": "IXSCAN",
          "keyPattern": {
            "name": -1
          },
          "indexName": "name_-1",
          "isMultiKey": false,
          "multiKeyPaths": {
            "name": []
          },
          "isUnique": false,
          "isSparse": false,
          "isPartial": false,
          "indexVersion": 2,
          "direction": "forward",
          "indexBounds": {
            "name": ["[\"a\", \"a\"]"]
          }
        }
      },
      "rejectedPlans": []
    },
    "serverInfo": {
      "host": "b886449b6326",
      "port": 27017,
      "version": "6.0.4",
      "gitVersion": "44ff59461c1353638a71e710f385a566bcd2f547"
    },
    "serverParameters": {
      "internalQueryFacetBufferSizeBytes": 104857600,
      "internalQueryFacetMaxOutputDocSizeBytes": 104857600,
      "internalLookupStageIntermediateDocumentMaxSizeBytes": 104857600,
      "internalDocumentSourceGroupMaxMemoryBytes": 104857600,
      "internalQueryMaxBlockingSortMemoryUsageBytes": 104857600,
      "internalQueryProhibitBlockingMergeOnMongoS": 0,
      "internalQueryMaxAddToSetBytes": 104857600,
      "internalDocumentSourceSetWindowFieldsMaxMemoryBytes": 104857600
    }
  }
]
```
