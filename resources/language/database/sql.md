# SQL

## 案例
[面试SQL题解析，别看不起CRUD](https://www.bilibili.com/video/BV1UH4y1m7uP/?spm_id_from=333.1007.tianma.2-2-5.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

## SQL 练习
[拥有自己的sql题库!sql练习平台本地安装&构建教程|数据分析师必看](https://www.bilibili.com/video/BV14P411p7Ss/?spm_id_from=333.788&vd_source=eabc2c22ae7849c2c4f31815da49f209)

鱼皮大佬开发的一个在线 SQL 练习网站
界面包括 SQL 编写/ SQL 编写提示/答案/相关数据

使用 sqlite 进行练习
可导入 **school.sqlite** 练习

### 建表

```sql
-- 学生表 student
create table student(sId varchar(10),sName nvarchar(10),sAge timestamp,sSex nvarchar(10));
insert into student values('01' , '赵雷' , '1990-01-01' , '男');
insert into student values('02' , '钱电' , '1990-12-21' , '男');
insert into student values('03' , '孙风' , '1990-05-20' , '男');
insert into student values('04' , '李云' , '1990-08-06' , '男');
insert into student values('05' , '周梅' , '1991-12-01' , '女');
insert into student values('06' , '吴兰' , '1992-03-01' , '女');
insert into student values('07' , '郑竹' , '1989-07-01' , '女');
insert into student values('08' , '王菊' , '1990-01-20' , '女');

select * from student;

-- 科目表 course
drop table course;
create table course(cId varchar(10),cName nvarchar(10),tId varchar(10));
insert into course values('01' , '语文' , '02');
insert into course values('02' , '数学' , '01');
insert into course values('03' , '英语' , '03');
select * from course;


--     教师表 teacher
    create table teacher(tId varchar(10),tName nvarchar(10));

insert into teacher values('01' , '张三');
insert into teacher values('02' , '李四');
insert into teacher values('03' , '王五');
select * from teacher;


--     成绩表 sc
create table sc(sId varchar(10),cId varchar(10),score decimal(18,1));
insert into sc values('01' , '01' , 80);
insert into sc values('01' , '02' , 90);
insert into sc values('01' , '03' , 99);
insert into sc values('02' , '01' , 70);
insert into sc values('02' , '02' , 60);
insert into sc values('02' , '03' , 80);
insert into sc values('03' , '01' , 80);
insert into sc values('03' , '02' , 80);
insert into sc values('03' , '03' , 80);
insert into sc values('04' , '01' , 50);
insert into sc values('04' , '02' , 30);
insert into sc values('04' , '03' , 20);
insert into sc values('05' , '01' , 76);
insert into sc values('05' , '02' , 87);
insert into sc values('06' , '01' , 31);
insert into sc values('06' , '03' , 34);
insert into sc values('07' , '02' , 89);
insert into sc values('07' , '03' , 98);
select * from sc;
```

### CRUD

参考



[经典SQL练习题(MySQL版)-阿里云开发者社区](https://developer.aliyun.com/article/637168)

```sql
-- 参考 https://developer.aliyun.com/article/637168
-- 这里是 sqlite 版本
select *
from student;
select *
from sc;
-- 1. 用一条SQL 语句 查询出每门课都大于80 分的学生姓名
-- 思路一: 成绩表 跟 跟学生表关联 行转列, 然后判断所有成绩都大于 80
-- 思路二: 这种就巧妙了, 先找到成绩比 80 少的学生 id, 然后通过在 学生表中进行反向筛选
-- 思路三: 学生表关联成绩表后, 给学生 id 进行分组, 通过分组条件 having min 最小的成绩不能比 80 少
select s.*
from student s
where s.sId not in (
    select sc.sId
    from sc
    where sc.score <= 80
);
/* 有个 bug 如果不在 sc 表中可能会出现没有出现过得记录
   07,郑竹,1989-07-01,女
   08,王菊,1990-01-20,女 */

select s.sName
from student s,
     sc
where s.sId = sc.sId
group by s.sName
having min(sc.score) > 80;
--     郑竹

-- 2. 删除除了自动编号不同, 其他都相同的学生冗余信息
-- 通过分组,找到除了 自动编码 其他信息相同的学生, 保留最小编号的学生, delete 掉其他(not in)学生信息
insert into student
values ('09', '王菊', '1990-01-20', '女');
-- 只能找到重复的记录
select *
from student;
select s1.*
from student s1,
     student s2
where s1.sName = s2.sName
  and s1.sAge = s2.sAge
  and s1.sSex = s2.sSex
  and s1.sId != s2.sId;
-- 只保留最小的那个记录
delete
from student
where sId not in (
    select min(s.sId) id from student s group by s.sName, s.sAge, s.sSex
);
select *
from student;

-- 一个叫 team 的表，里面只有一个字段name, 一共有4 条纪录，分别是a,b,c,d, 对应四个球对，现在四个球对进行比赛，用一条sql 语句显示所有可能的比赛组合
-- team(name)
create table team
(
    name varchar(1)
);
insert into team
values ('a');
insert into team
values ('b');
insert into team
values ('c');
insert into team
values ('d');
select *
from team;
-- 这种情况下会重复
select a.name host, b.name guest
from team a,
     team b
where a.name != b.name;
-- 这个 < 用的是真妙
select a.name, b.name
from team a,
     team b
where a.name < b.name;

create table amount
(
    year   INT,
    month  INT,
    amount DECIMAL(10, 5)
);
insert into amount
values (1991, 1, 1.1);
insert into amount
values (1991, 2, 1.2);
insert into amount
values (1991, 3, 1.3);
insert into amount
values (1991, 4, 1.4);
insert into amount
values (1992, 1, 2.1);
insert into amount
values (1992, 2, 2.2);
insert into amount
values (1992, 3, 2.3);
insert into amount
values (1992, 4, 2.4);
select *
from amount;

select year,
       (select m.amount from amount m where month = 1 and m.year = a.year) as m1,
       (select m.amount from amount m where month = 2 and m.year = a.year) as m2,
       (select m.amount from amount m where month = 3 and m.year = a.year) as m3,
       (select m.amount from amount m where month = 4 and m.year = a.year) as m4
from amount a
group by year;

--------------------------------------------- 正文 --------------------------------------------------
--     1. 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数

select s.*,
       a.score course1,
       b.score course2
from student s,
     (select sc.sId, sc.score from sc where sc.cId = '01') a,
     (select sc.sId, sc.score from sc where sc.cId = '02') b
where s.sId = a.sId
  and s.sId = b.sId
  and a.score > b.score;

-- 思路: 通过行转列
-- 本来我是想在 having 里面加上 score1 跟 score2 字段的, 但是发现会报错
-- 这是因为 SQL 关键字执行顺序的问题, 当我们执行到  group by 跟 having 的时候, 字段还没有被映射出来, 这个时候我们是拿不到字段的
-- 除非你是在 order by 阶段 这个时候字段已经被映射出来了, 当然这里是不需要 order by 的
-- 行转列了之后呢, 我们可以在进行一次 select 把我们需要的数据筛选出来了
select 
s.sId, 
SUM(CASE WHEN sc.cId = '01' THEN sc.score ELSE 0 END) AS score1, 
SUM(CASE WHEN sc.cId = '02' THEN sc.score ELSE 0 END) AS score2
from student s, sc
WHERE s.sId = sc.sId
GROUP BY s.sId
ORDER BY score1


-- 2. 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩
-- 思路: 先在成绩表通过分组找到 平均分大于 60 的学生编号以及平均成绩, 最后通过跟学生表进行关联得到

select s.sId,
       s.sName,
       avg(sc.score) averageScore

from student s,
     sc
where s.sId = sc.sId
group by s.sId
having avg(sc.score) > 60;

-- 3. 查询在 SC 表存在成绩的学生信息
-- 思路: 查询 成绩表 sc 中的学生 id, 我原本还打算使用 distinct, 但是这里用集合的概念加上 in 关键字就可以在学生表 student 中得到学生信息了
select s.*
from student s
where s.sId in (
    select sc.sid
    from sc
);

-- 4. 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )
-- 学生表 跟 成绩表 进行关联, 通过 分组 得到关于学生的数据, 对了, 这里记得使用 左连接, 因为需要把没有在成绩表中关联到的数据 加回到我们的查询结果中
select s.sId,
       s.sName,
       count(s2.sId) sum_course,
       sum(s2.score) sum_score
from student s
         left join sc s2 on s.sId = s2.sId
group by s.sId;

-- 4.1 查有成绩的学生信息
-- 如果是单单学生的信息, 但是如果要加上成绩, 那就要加上行转列了
select s.*
from student s,
     sc s2
where s.sId = s2.sId
group by s.sId;

select s.*
from student s
where s.sId in (
    select sc.sid
    from sc
);

select s.sid,
       s.sname,
       count(*)                                         as course_num,
       sum(score)                                       as total_score,
       sum(case when cid = 01 then score end)           as score_01,
       sum(case when cid = 02 then score end)           as score_02,
       sum(case when cid = 03 then score end) as score_03
from student as s,
     sc
where s.sid = sc.sid
group by s.sid;

-- 5. 查询「李」姓老师的数量
-- 使用 like 李 count 进行计算
select count(1) num_of_li
from teacher t
where t.tName like '李%';

-- 6. 查询学过「张三」老师授课的同学的信息
-- 思路: 先查询出 张三 老师的 sID
-- 在成绩表中查询出 对应学生 sId
-- 在学生表中查询对应的 学生
select s.*
from student s
where s.sId in (
    select sc.sId
    from teacher t,
         course c,
         sc
    where t.tId = c.tId
      and c.cId = sc.cId
      and t.tName = '张三'
);

-- 7. 查询没有学全所有课程的同学的信息
-- 先 查询出 总课程数
-- 通过分组查询每个学生学的课程数, 如果课程数少于总课程数就筛选对应的学生
-- 直接判断成绩表里面行数小于 3 3即是科目的数量
select *
from student
where sid in (select sid from sc group by sid having count(cid) < 3);

-- 8. 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息
-- 先选出 01 同学的成绩表作为一个集合
-- 再跟 成绩表进行关联, 然后再从学生表中拿到学生信息
select s.*
from student s
where s.sId in (
    select distinct s1.sid
    from sc s1
    where exists(
                  select 1 from sc s2 where s2.sId = '01' and s2.cId = s1.cId
              )
);

-- 9. 查询和" 01 "号的同学学习的课程完全相同的其他同学的信息
-- 想法: 将 01 同学的课程查出后变成一个字符串 在 sc 中通过sid分组 将得到的课程信息串联成一个字符串跟之前得到的 01 同学进行比较
-- 最后得到 sid 在 student表中找出学生信息
-- 参考答案
select *
from Student
where Sid in (
    select Sid
    from SC
    where Cid in (select Cid from SC where Sid = '01')
      and Sid <> '01'
    group by Sid
    having COUNT(Cid) >= 3
);
/*
分析参考答案
    Cid in (select Cid from SC where Sid = '01')
COUNT(Cid)>=3 保证了 另外的学生一定包含了01同学的课程  但是我觉得这种是有漏洞的*/

select * from teacher
select * from course
-- 10. 查询没学过"张三"老师讲授的任一门课程的学生姓名
-- 通过老师表 跟 课程表查出 张三老师 教授的课程 cId
-- 通过 in 查询出成绩表中上过 张三 老师的学生
-- 然后 通过 not in 查出没在上面的学生姓名即可
-- 先找到学过的学生
select s.sName name
from student s
where s.sId not in (
    select sc.sId
    from sc
    where sc.cId in (
        select c.cId
        from teacher t,
             course c
        where t.tId = c.tId
          and t.tName = '张三'
    )
);
select sname
from student
where sname not in (
    select s.sname
    from student as s,
         course as c,
         teacher as t,
         sc
    where s.sid = sc.sid
      and sc.cid = c.cid
      and c.tid = t.tid
      and t.tname = '张三'
);

-- 11. 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
-- 在成绩表中筛选出 不及格的 人, 然后通过学生学号进行分组
-- 通过 having 判断该学生是否有超过两门课程, 先选出这些学生的 id
-- 然后通过 sId 筛选出对应的成绩表, 通过 分析函数计算出对应的平均成绩, 再与学生表进行关联
select s.sid, s.sname, g.avg_score
from student s,
     (
         select sc.sId,
                avg(sc.score) avg_score
         from sc
         where sc.score < 60
         group by sc.sId
         having count(1) > 1
     ) g
where s.sId = g.sid;

-- 12. 检索" 01 "课程分数小于 60，按分数降序排列的学生信息
-- 应该先从 成绩表 中检索出 小于 60 分的 学生 id, 如果是 01 直接跟 成绩表进行关联后再进行排序就可以了
select s.*,
       sc.score
from student s,
     sc
where s.sId = sc.sId
  and sc.cId = '01'
  and sc.score < 60
order by sc.score desc;

-- 13. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
-- 行转列
select sc.sId,
       avg(sc.score)                                            avg_socre,
       sum(case when sc.cId = '01' then sc.score end)           score_1,
       sum(case when sc.cId = '02' then sc.score end)           score_2,
       sum(case when sc.cId = '03' then sc.score end) score_3
from sc
group by sId
order by avg(sc.score) desc;

/*
14. 查询各科成绩最高分、最低分和平均分，
以如下形式显示：
课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率(及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90）。
要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列*/
select sc.cId,
       c.cName,
       max(sc.score),
       min(sc.score),
       avg(sc.score),
       count(case when sc.score >= 60 then 1 end) * 1.0 / count(1) rate
from sc,
     course c
where sc.cId = c.cId
group by sc.cId;


-- 15. 按平均成绩进行排序，显示总排名和各科排名，Score 重复时保留名次空缺
-- 因为这里需要每一科的排名, 所以需要先把各科的排名先罗列出来, 再进行关联
-- 这里需要用到分析函数
select s.*, rank_01, rank_02, rank_03, rank_total
from student s
         left join (select sid, rank() over (partition by cid order by score desc) as rank_01
                    from sc
                    where cid = '01') A on s.sid = A.sid
         left join (select sid, rank() over (partition by cid order by score desc) as rank_02
                    from sc
                    where cid = '02') B on s.sid = B.sid
         left join (select sid, rank() over (partition by cid order by score desc) as rank_03
                    from sc
                    where cid = '03') C on s.sid = C.sid
         left join (select sid, rank() over (order by avg(score) desc) as rank_total from sc group by sid) D
                   on s.sid = D.sid
order by rank_total;

select s.*, rank_01, rank_02, rank_03, rank_total
from student s
         left join (select sid, dense_rank() over (partition by cid order by score desc) as rank_01
                    from sc
                    where cid = '01') A on s.sid = A.sid
         left join (select sid, dense_rank() over (partition by cid order by score desc) as rank_02
                    from sc
                    where cid = '02') B on s.sid = B.sid
         left join (select sid, dense_rank() over (partition by cid order by score desc) as rank_03
                    from sc
                    where cid = '03') C on s.sid = C.sid
         left join (select sid, dense_rank() over (order by avg(score) desc) as rank_total from sc group by sid) D
                   on s.sid = D.sid
order by rank_total;
-- 或者如果需要可以多次group by 之后进行合并

-- 17. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
-- 与14题类似

-- 18. 查询各科成绩前三名的记录
-- 没有分析函数的情况下 按照成绩进行排序 使用limit 取得前三名 之后使用union 连接起来
-- 有分析函数的情况下 使用分析函数 进行排名 然后用 where 筛选出来就好了
select *
from (select *, rank() over (partition by cid order by score desc) as graderank from sc) A
where A.graderank <= 3;

select sc.cid, rank() over (partition by sc.cId order by sc.score desc ) as graderank
from sc;

-- 20. 查询出只选修两门课程的学生学号和姓名
select sc.sId,
       s.sName
from sc,
     student s
where sc.sId = s.sId
group by sc.sId
having count(1) = 2;

-- 22. 查询名字中含有「风」字的学生信息
select s.*
from student s
where s.sName like '%风%';

-- 24. 查询 1990 年出生的学生名单
select s.*
from student s
where s.sAge > '1990-01-01'
  and s.sAge < '1991-01-01';

-- 33. 成绩不重复，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩

select s.*,
       c.cName,
       sc.score
from student s,
     course c,
     teacher t,
     sc
where s.sId = sc.sId
  and sc.cId = c.cId
  and c.tId = t.tId
  and t.tName = '张三'
order by sc.score desc
limit 0, 1;

select s.*, max(score)
from student s,
     teacher t,
     course c,
     sc
where s.sid = sc.sid
  and sc.cid = c.cid
  and c.tid = t.tid
  and t.tname = '张三';

-- todo 34. 成绩有重复的情况下，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩
select *
from (
         select *, DENSE_RANK() over (order by score desc) A
         from SC
         where Cid = (select Cid from Course where Tid = (select Tid from Teacher where Tname = '张三'))
     ) B
where B.A = 1;

-- 40. 查询各学生的年龄，只按年份来算
-- 获取当前时间的年份 减去 出生时间
select s.sName student_name, strftime('%Y', 'now') - strftime('%Y', s.sAge) age
from student s;

-- 41. 按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一
-- 上面的例子 加个case
select s.sName                                                       student_name,
       (case
            when strftime('%m-%d', 'now') < strftime('%m-%d', s.sAge)
                then strftime('%Y', 'now') - strftime('%Y', s.sAge) - 1
            else strftime('%Y', 'now') - strftime('%Y', s.sAge) end) age
from student s;

-- 42. 查询本周过生日的学生
-- 需要计算本周时间范围 然后根据这个范围进行筛选
select s.*
from student s
where strftime('%W', s.sAge) = strftime('%W', 'now');

-- 43. 查询下周过生日的学生
select s.*
from student s
where strftime('%W', s.sAge) - strftime('%W', 'now') = 1;
-- 44. 查询本月过生日的学生
select s.*
from student s
where strftime('%m', s.sAge) = strftime('%m', 'now');
-- 45. 查询下月过生日的学生
select s.*,
       strftime('%m', s.sAge) birthday_month
from student s
where strftime('%m', s.sAge) - strftime('%m', 'now') = 1;
```
