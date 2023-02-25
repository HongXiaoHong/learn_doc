# mongo_test

实验数据

```mongodb
// 查看数据库
show dbs
// 创建数据库 并且切换数据库
use learning
// 查看当前数据库
db

// 查看已有集合
show collections
// 查看集合内容 db+集合+find() 查看 所有数据
db.notify_msg.find()

db.comment.insertOne({
    parentId: 1,
    details: "老默 我想吃鱼了",
    commend: 0,
})
db.comment.insertOne({
    parentId: 1,
    details: "迈克尔杰克驴",
    commend: 1,
})
db.comment.insertOne({
    parentId: 1,
    details: "狂飙里面真正在狂飙的是李有田吧",
    commend: 2,
})

db.comment.find()

// --------------- 多表查询 聚合 $lookup -----------------
// 详解MongoDB中的多表关联查询（$lookup） https://www.cnblogs.com/xuliuzai/p/10055535.html
// 订单表
db.orders.insertMany([
    {"_id": 1, "item": "almonds", "price": 12, "quantity": 2},
    {"_id": 2, "item": "pecans", "price": 20, "quantity": 1},
    {"_id": 3}
])

// 商品表 sku 与 订单表的 item 关联
db.inventory.insertMany([
    {"_id": 1, "sku": "almonds", description: "product 1", "instock": 120},
    {"_id": 2, "sku": "bread", description: "product 2", "instock": 80},
    {"_id": 3, "sku": "cashews", description: "product 3", "instock": 60},
    {"_id": 4, "sku": "pecans", description: "product 4", "instock": 70},
    {"_id": 5, "sku": null, description: "Incomplete"},
    {"_id": 6}
])

db.orders.aggregate([
    {
        $lookup:
            {
                from: "inventory",
                localField: "item",
                foreignField: "sku",
                as: "inventory_docs"
            }
    }
])
// 字段是一个数组 我们需要先将数组中的元素拆解出来
// 使用 $unwind
// $unwind 解构 将数组中的各个元素拆出来成一个文档
db.reward.insertOne({
    user_id: "A_id",
    bonus: [
        {type: "a", amount: 1000},
        {type: "b", amount: 2000},
        {type: "b", amount: 3000}
    ]
})

db.reward.find()
// 引用字段使用 $ 进行引用
db.reward.aggregate([
    {$unwind: "$bonus"}
])

db.reward.aggregate([
    {$match: {user_id: "A_id"}},
    {$unwind: "$bonus"},
    {$match: {'bonus.type': "b"}},
    {$group: {_id: '$user_id', amount: {$sum: '$bonus.amount'}}}
])
```
