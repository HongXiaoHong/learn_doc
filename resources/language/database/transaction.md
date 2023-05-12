# 事务

## todo

- [x] 数据库事务
- [x] springboot 如何开启 事务传播...
- [ ] 分布式事务

## 数据库事务

[java - mybatis sqlsession 缓存 clearCache不起作用 - SegmentFault 思否](https://segmentfault.com/q/1010000011300533)

后来发现是因为事务的原因。  
当update失败后（失败的原因一定是version不匹配），会重新查询数据最新值，然后再次重试；  
因为事务级别是repeatable-read，所以查询出来的“最新”值依旧是原值，而不是真正的最新值；  
所以需要修改事务级别为read-commited，问题解决

### 共享锁与排他锁

[MySQL中的共享锁与排他锁-HollisChuang's Blog](https://www.hollischuang.com/archives/923)

#### 共享锁(Share Lock)

共享锁又称读锁，是读取操作创建的锁。其他用户可以并发读取数据，但任何事务都不能对数据进行修改（获取数据上的排他锁），直到已释放所有共享锁。

如果事务T对数据A加上共享锁后，则其他事务只能对A再加共享锁，不能加排他锁。获准共享锁的事务只能读数据，不能修改数据。

##### 用法

`SELECT ... LOCK IN SHARE MODE;`

在查询语句后面增加`LOCK IN SHARE MODE`，Mysql会对查询结果中的每行都加共享锁，当没有其他线程对查询结果集中的任何一行使用排他锁时，可以成功申请共享锁，否则会被阻塞。其他线程也可以读取使用了共享锁的表，而且这些线程读取的是同一个版本的数据。

#### 排他锁（eXclusive Lock）

排他锁又称写锁，如果事务T对数据A加上排他锁后，则其他事务不能再对A加任任何类型的封锁。获准排他锁的事务既能读数据，又能修改数据。

##### 用法

`SELECT ... FOR UPDATE;`

在查询语句后面增加`FOR UPDATE`，Mysql会对查询结果中的每行都加排他锁，当没有其他线程对查询结果集中的任何一行使用排他锁时，可以成功申请排他锁，否则会被阻塞。

#### 意向锁

意向锁是表级锁，其设计目的主要是为了在一个事务中揭示下一行将要被请求锁的类型。InnoDB中的两个表锁：

意向共享锁（IS）：表示事务准备给数据行加入共享锁，也就是说一个数据行加共享锁前必须先取得该表的IS锁

意向排他锁（IX）：类似上面，表示事务准备给数据行加入排他锁，说明事务在一个数据行加排他锁前必须先取得该表的IX锁。

**意向锁是InnoDB自动加的，不需要用户干预。**

#### 给 select 语句加共享锁或排他锁

对于insert、update、delete，InnoDB会自动给涉及的数据加排他锁（X）；对于一般的Select语句，InnoDB不会加任何锁，事务可以通过以下语句给显示加共享锁或排他锁。

共享锁：`SELECT ... LOCK IN SHARE MODE;`

排他锁：`SELECT ... FOR UPDATE;`

### MySQL中的行级锁,表级锁,页级锁

[**MySQL中的行级锁,表级锁,页级锁**](https://www.hollischuang.com/archives/914)

在计算机科学中，锁是在执行多线程时用于强行限制资源访问的同步机制，即用于在并发控制中保证对互斥要求的满足。

在[数据库的锁机制](http://www.hollischuang.com/archives/909)中介绍过，在DBMS中，可以按照锁的粒度把数据库锁分为行级锁(INNODB引擎)、表级锁(MYISAM引擎)和页级锁(BDB引擎 )。

#### 行级锁

行级锁是Mysql中锁定粒度最细的一种锁，表示只针对当前操作的行进行加锁。行级锁能大大减少数据库操作的冲突。其加锁粒度最小，但加锁的开销也最大。行级锁分为**[`共享锁`](http://www.hollischuang.com/archives/923)** 和 **[`排他锁`](http://www.hollischuang.com/archives/923)**。

##### 特点

开销大，加锁慢；会出现死锁；锁定粒度最小，发生锁冲突的概率最低，并发度也最高。

---

#### 表级锁

表级锁是MySQL中锁定粒度最大的一种锁，表示对当前操作的整张表加锁，它实现简单，资源消耗较少，被大部分MySQL引擎支持。最常使用的MYISAM与INNODB都支持表级锁定。表级锁定分为**`表共享读锁`（[共享锁](http://www.hollischuang.com/archives/923)）**与**`表独占写锁`（[排他锁](http://www.hollischuang.com/archives/923)）**。

##### 特点

开销小，加锁快；不会出现死锁；锁定粒度大，发出锁冲突的概率最高，并发度最低。

---

#### 页级锁

页级锁是MySQL中锁定粒度介于行级锁和表级锁中间的一种锁。表级锁速度快，但冲突多，行级冲突少，但速度慢。所以取了折衷的页级，一次锁定相邻的一组记录。BDB支持页级锁

##### 特点

开销和加锁时间界于表锁和行锁之间；会出现死锁；锁定粒度界于表锁和行锁之间，并发度一般

---

#### MySQL常用存储引擎的锁机制

> MyISAM和MEMORY采用表级锁(table-level locking)
> 
> BDB采用页面锁(page-level locking)或表级锁，默认为页面锁
> 
> InnoDB支持行级锁(row-level locking)和表级锁,默认为行级锁

---

#### Innodb中的行锁与表锁

前面提到过，在Innodb引擎中既支持行锁也支持表锁，那么什么时候会锁住整张表，什么时候或只锁住一行呢？

InnoDB行锁是通过给索引上的索引项加锁来实现的，这一点MySQL与Oracle不同，后者是通过在数据块中对相应数据行加锁来实现的。InnoDB这种行锁实现特点意味着：**只有通过索引条件检索数据，InnoDB才使用行级锁，否则，InnoDB将使用表锁！**

在实际应用中，要特别注意InnoDB行锁的这一特性，不然的话，可能导致大量的锁冲突，从而影响并发性能。

- 在不通过索引条件查询的时候,InnoDB 确实使用的是表锁,而不是行锁。
- 由于 MySQL 的行锁是针对索引加的锁,不是针对记录加的锁,所以虽然是访问不同行 的记录,但是如果是使用相同的索引键,是会出现锁冲突的。应用设计的时候要注意这一点。
- 当表有多个索引的时候,不同的事务可以使用不同的索引锁定不同的行,另外,不论 是使用主键索引、唯一索引或普通索引,InnoDB 都会使用行锁来对数据加锁。
- 即便在条件中使用了索引字段,但是否使用索引来检索数据是由 MySQL 通过判断不同 执行计划的代价来决定的,如果 MySQL 认为全表扫 效率更高,比如对一些很小的表,它 就不会使用索引,这种情况下 InnoDB 将使用表锁,而不是行锁。因此,在分析锁冲突时, 别忘了检查 SQL 的执行计划,以确认是否真正使用了索引。

---

#### 行级锁与死锁

MyISAM中是不会产生死锁的，因为MyISAM总是一次性获得所需的全部锁，要么全部满足，要么全部等待。而在InnoDB中，锁是逐步获得的，就造成了死锁的可能。

在MySQL中，行级锁并不是直接锁记录，而是锁索引。索引分为主键索引和非主键索引两种，如果一条sql语句操作了主键索引，MySQL就会锁定这条主键索引；如果一条语句操作了非主键索引，MySQL会先锁定该非主键索引，再锁定相关的主键索引。 在UPDATE、DELETE操作时，MySQL不仅锁定WHERE条件扫描过的所有索引记录，而且会锁定相邻的键值，即所谓的next-key locking。

当两个事务同时执行，一个锁住了主键索引，在等待其他相关索引。另一个锁定了非主键索引，在等待主键索引。这样就会发生死锁。

发生死锁后，InnoDB一般都可以检测到，并使一个事务释放锁回退，另一个获取锁完成事务。

---

**有多种方法可以避免死锁，这里只介绍常见的三种**

1、如果不同程序会并发存取多个表，尽量约定以相同的顺序访问表，可以大大降低死锁机会。

2、在同一个事务中，尽可能做到一次锁定所需要的所有资源，减少死锁产生概率；

3、对于非常容易产生死锁的业务部分，可以尝试使用升级锁定颗粒度，通过表级锁定来减少死锁产生的概率；

### 数据库的并发一致性问题

读现象”是多个事务并发执行时，在读取数据方面可能碰到的状况。先了解它们有助于理解各隔离级别的含义。其中包括脏读、不可重复读和幻读。

#### 脏读

脏读又称无效数据的读出，是指在数据库访问中，事务T1将某一值修改，然后事务T2读取该值，此后T1因为某种原因撤销对该值的修改，这就导致了T2所读取到的数据是无效的。

脏读就是指当一个事务正在访问数据，并且对数据进行了修改，而这种修改还没有提交(commit)到数据库中，这时，另外一个事务也访问这个数据，然后使用了这个数据。因为这个数据是还没有提交的数据，那么另外一个事务读到的这个数据是脏数据，依据脏数据所做的操作可能是不正确的。

**举例说明：**

在下面的例子中，事务2修改了一行，但是没有提交，事务1读了这个没有提交的数据。现在如果事务2回滚了刚才的修改或者做了另外的修改的话，事务1中查到的数据就是不正确的了。

| 事务一                                                                                      | 事务二                                                                                            |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `/* Query 1 */`<br>`<br>SELECT age FROM users WHERE id = 1;<br>`<br>`/* will read 20 */` |                                                                                                |
|                                                                                          | `<br>/* Query 2 */`<br>`UPDATE users SET age = 21 WHERE id = 1;`<br>`<br>/* No commit here */` |
| `<br>/* Query 1 */`<br>`SELECT age FROM users WHERE id = 1;`<br>`/* will read 21 */`     |                                                                                                |
|                                                                                          | `<br>ROLLBACK;`<br>`/* lock-based DIRTY READ */`                                               |

在这个例子中，事务2回滚后就没有id是1，age是21的数据了。所以，事务一读到了一条脏数据。

#### 不可重复读

不可重复读，是指在数据库访问中，一个事务范围内两个相同的查询却返回了不同数据。这是由于查询时系统中其他事务修改的提交而引起的。比如事务T1读取某一数据，事务T2读取并修改了该数据，T1为了对读取值进行检验而再次读取该数据，便得到了不同的结果。

一种更易理解的说法是：在一个事务内，多次读同一个数据。在这个事务还没有结束时，另一个事务也访问该同一数据。那么，在第一个事务的两次读数据之间。由于第二个事务的修改，那么第一个事务读到的数据可能不一样，这样就发生了在一个事务内两次读到的数据是不一样的，因此称为不可重复读，即原始读取不可重复。

**举例说明：**

在基于锁的并发控制中“不可重复读(non-repeatable read)”现象发生在当执行SELECT 操作时没有获得读锁(read locks)或者SELECT操作执行完后马上释放了读锁； 多版本并发控制中当没有要求一个提交冲突的事务回滚也会发生“不可重复读(non-repeatable read)”现象。

| 事务一                                                                                                              | 事务二                                                                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/* Query 1 */`<br>`<br>SELECT * FROM users WHERE id = 1;<br>`                                                   |                                                                                                                                                                           |
|                                                                                                                  | `<br>/* Query 2 */`<br>`UPDATE users SET age = 21 WHERE id = 1;`<br>`<br>COMMIT;`<br>`<br>/* in multiversion concurrency<br>control, or lock-based READ COMMITTED */<br>` |
| `<br>/* Query 1 */`<br>`SELECT * FROM users WHERE id = 1;`<br>`<br>COMMIT;`<br>`/*lock-based REPEATABLE READ */` |                                                                                                                                                                           |

在这个例子中，事务2提交成功，因此他对id为1的行的修改就对其他事务可见了。但是事务1在此前已经从这行读到了另外一个“age”的值。

#### 幻读

幻读是指当事务不是独立执行时发生的一种现象，例如第一个事务对一个表中的数据进行了修改，比如这种修改涉及到表中的“全部数据行”。同时，第二个事务也修改这个表中的数据，这种修改是向表中插入“一行新数据”。那么，以后就会发生操作第一个事务的用户发现表中还有没有修改的数据行，就好象发生了幻觉一样.一般解决幻读的方法是增加范围锁RangeS，锁定检锁范围为只读，这样就避免了幻读。　　

> 幻读(phantom read)”是不可重复读(Non-repeatable reads)的一种特殊场景：当事务没有获取范围锁的情况下执行SELECT … WHERE操作可能会发生“幻影读(phantom read)”。

**举例说明：**

当事务1两次执行SELECT … WHERE检索一定范围内数据的操作中间，事务2在这个表中创建了(如INSERT)了一行新数据，这条新数据正好满足事务1的“WHERE”子句。

| 事务一                                                                              | 事务二                                                                                  |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `/* Query 1 */`<br>`<br>SELECT * FROM users<br>WHERE age BETWEEN 10 AND 30;<br>` |                                                                                      |
|                                                                                  | `<br>/* Query 2 */`<br>`INSERT INTO users VALUES ( 3, 'Bob', 27 );`<br>`<br>COMMIT;` |
| `<br>/* Query 1 */`<br>`SELECT * FROM users<br>WHERE age BETWEEN 10 AND 30;`     |                                                                                      |

在这个例子中，事务一执行了两次相同的查询操作。但是两次操作中间事务二向数据库中增加了一条符合事务一的查询条件的数据，导致幻读。

#### 解决方案

要想解决脏读、不可重复读、幻读等读现象，那么就需要提高[事务的隔离级别](http://www.hollischuang.com/archives/943)。但与此同时，事务的隔离级别越高，并发能力也就越低。所以，还需要读者根据业务需要进行权衡

### 事务的隔离级别

[深入分析事务的隔离级别](https://www.hollischuang.com/archives/943)

在DBMS中，[事务](http://www.hollischuang.com/archives/898)保证了一个操作序列可以全部都执行或者全部都不执行（原子性），从一个状态转变到另外一个状态（一致性）。由于事务满足久性。所以一旦事务被提交之后，数据就能够被持久化下来，又因为事务是满足隔离性的，所以，当多个事务同时处理同一个数据的时候，多个事务直接是互不影响的，所以，在多个事务并发操作的过程中，如果控制不好隔离级别，就有可能产生[脏读](http://www.hollischuang.com/archives/900)、[不可重复读](http://www.hollischuang.com/archives/900)或者[幻读](http://www.hollischuang.com/archives/900)等读现象。

在数据库事务的[ACID](http://www.hollischuang.com/archives/898)四个属性中，隔离性是一个最常放松的一个。可以在数据操作过程中利用数据库的锁机制或者多版本并发控制机制获取更高的隔离等级。但是，随着数据库隔离级别的提高，数据的并发能力也会有所下降。所以，如何在并发性和隔离性之间做一个很好的权衡就成了一个至关重要的问题。

在软件开发中，几乎每类这样的问题都会有多种最佳实践来供我们参考，很多DBMS定义了多个不同的“事务隔离等级”来控制[锁](http://www.hollischuang.com/archives/909)的程度和并发能力。

ANSI/ISO SQL定义的标准隔离级别有四种，从高到底依次为：可序列化(Serializable)、可重复读(Repeatable reads)、提交读(Read committed)、未提交读(Read uncommitted)。

下面将依次介绍这四种事务隔离级别的概念、用法以及解决了哪些问题（读现象）

#### 未提交读(Read uncommitted)

未提交读(READ UNCOMMITTED)是最低的隔离级别。通过名字我们就可以知道，在这种事务隔离级别下，一个事务可以读到另外一个事务未提交的数据。

##### 未提交读的数据库锁情况（实现原理）

> 事务在读数据的时候并未对数据加锁。
> 
> 务在修改数据的时候只对数据增加[行级](http://www.hollischuang.com/archives/914)[共享锁](http://www.hollischuang.com/archives/923)。

现象：

> 事务1读取某行记录时，事务2也能对这行记录进行读取、更新（因为事务一并未对数据增加任何锁）
> 
> 当事务2对该记录进行更新时，事务1再次读取该记录，能读到事务2对该记录的修改版本（因为事务二只增加了共享读锁，事务一可以再增加共享读锁读取数据），即使该修改尚未被提交。
> 
> 事务1更新某行记录时，事务2不能对这行记录做更新，直到事务1结束。（因为事务一对数据增加了共享读锁，事务二不能增加[排他写锁](http://www.hollischuang.com/archives/923)进行数据的修改）

##### 举例

下面还是借用我在[数据库的读现象浅析](http://www.hollischuang.com/archives/900)一文中举的例子来说明在未提交读的隔离级别中两个事务之间的隔离情况。

| 事务一                                                                                      | 事务二                                                                                            |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `/* Query 1 */`<br>`<br>SELECT age FROM users WHERE id = 1;<br>`<br>`/* will read 20 */` |                                                                                                |
|                                                                                          | `<br>/* Query 2 */`<br>`UPDATE users SET age = 21 WHERE id = 1;`<br>`<br>/* No commit here */` |
| `<br>/* Query 1 */`<br>`SELECT age FROM users WHERE id = 1;`<br>`/* will read 21 */`     |                                                                                                |
|                                                                                          | `<br>ROLLBACK;`<br>`/* lock-based DIRTY READ */`                                               |

事务一共查询了两次，在两次查询的过程中，事务二对数据进行了修改，并未提交（commit）。但是事务一的第二次查询查到了事务二的修改结果。在数据库的读现象浅析中我们介绍过，这种现象我们称之为[脏读](http://www.hollischuang.com/archives/900)。

所以，**未提交读会导致[脏读](http://www.hollischuang.com/archives/900)**

#### 提交读(Read committed)

提交读(READ COMMITTED)也可以翻译成读已提交，通过名字也可以分析出，在一个事务修改数据过程中，如果事务还没提交，其他事务不能读该数据。

##### 提交读的数据库锁情况

> 事务对当前被读取的数据加 行级共享锁（当读到时才加锁），一旦读完该行，立即释放该行级共享锁；
> 
> 事务在更新某数据的瞬间（就是发生更新的瞬间），必须先对其加 行级排他锁，直到事务结束才释放。

现象：

> 事务1在读取某行记录的整个过程中，事务2都可以对该行记录进行读取（因为事务一对该行记录增加行级共享锁的情况下，事务二同样可以对该数据增加共享锁来读数据。）。
> 
> 事务1读取某行的一瞬间，事务2不能修改该行数据，但是，只要事务1读取完改行数据，事务2就可以对该行数据进行修改。（事务一在读取的一瞬间会对数据增加共享锁，任何其他事务都不能对该行数据增加排他锁。但是事务一只要读完该行数据，就会释放行级共享锁，一旦锁释放，事务二就可以对数据增加排他锁并修改数据）
> 
> 事务1更新某行记录时，事务2不能对这行记录做更新，直到事务1结束。（事务一在更新数据的时候，会对该行数据增加排他锁，知道事务结束才会释放锁，所以，在事务二没有提交之前，事务一都能不对数据增加共享锁进行数据的读取。**所以，提交读可以解决`脏读`的现象**）

##### 举例

| 事务一                                                                                                              | 事务二                                                                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/* Query 1 */`<br>`<br>SELECT * FROM users WHERE id = 1;<br>`                                                   |                                                                                                                                                                           |
|                                                                                                                  | `<br>/* Query 2 */`<br>`UPDATE users SET age = 21 WHERE id = 1;`<br>`<br>COMMIT;`<br>`<br>/* in multiversion concurrency<br>control, or lock-based READ COMMITTED */<br>` |
| `<br>/* Query 1 */`<br>`SELECT * FROM users WHERE id = 1;`<br>`<br>COMMIT;`<br>`/*lock-based REPEATABLE READ */` |                                                                                                                                                                           |

在提交读隔离级别中，在事务二提交之前，事务一不能读取数据。只有在事务二提交之后，事务一才能读数据。

但是从上面的例子中我们也看到，事务一两次读取的结果并不一致，**所以提交读不能解决[不可重复读的读现象](http://www.hollischuang.com/archives/900)。**

简而言之，提交读这种隔离级别保证了读到的任何数据都是提交的数据，避免了脏读(dirty reads)。但是不保证事务重新读的时候能读到相同的数据，因为在每次数据读完之后其他事务可以修改刚才读到的数据。

#### 可重复读(Repeatable reads)

可重复读(REPEATABLE READS),由于提交读隔离级别会产生不可重复读的读现象。所以，比提交读更高一个级别的隔离级别就可以解决不可重复读的问题。这种隔离级别就叫可重复读（这名字起的是不是很任性！！）

##### 可重复读的数据库锁情况

> 事务在读取某数据的瞬间（就是开始读取的瞬间），必须先对其加 行级共享锁，直到事务结束才释放；
> 
> 事务在更新某数据的瞬间（就是发生更新的瞬间），必须先对其加 行级排他锁，直到事务结束才释放。

现象

> 事务1在读取某行记录的整个过程中，事务2都可以对该行记录进行读取（因为事务一对该行记录增加行级共享锁的情况下，事务二同样可以对该数据增加共享锁来读数据。）。
> 
> 事务1在读取某行记录的整个过程中，事务2都不能修改该行数据（事务一在读取的整个过程会对数据增加共享锁，直到事务提交才会释放锁，所以整个过程中，任何其他事务都不能对该行数据增加排他锁。**所以，可重复读能够解决`不可重复读`的读现象**）
> 
> 事务1更新某行记录时，事务2不能对这行记录做更新，直到事务1结束。（事务一在更新数据的时候，会对该行数据增加排他锁，知道事务结束才会释放锁，所以，在事务二没有提交之前，事务一都能不对数据增加共享锁进行数据的读取。**所以，提交读可以解决`脏读`的现象**）

##### 举例

| 事务一                                                                                 | 事务二                                                                                                                                                                       |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/* Query 1 */`<br>`<br>SELECT * FROM users WHERE id = 1;<br>`<br>`<br>COMMIT;<br>` |                                                                                                                                                                           |
|                                                                                     | `<br>/* Query 2 */`<br>`UPDATE users SET age = 21 WHERE id = 1;`<br>`<br>COMMIT;`<br>`<br>/* in multiversion concurrency<br>control, or lock-based READ COMMITTED */<br>` |

在上面的例子中，只有在事务一提交之后，事务二才能更改该行数据。所以，只要在事务一从开始到结束的这段时间内，无论他读取该行数据多少次，结果都是一样的。

从上面的例子中我们可以得到结论：可重复读隔离级别可以解决不可重复读的读现象。**但是可重复读这种隔离级别中，还有另外一种读现象他解决不了，那就是[幻读](http://www.hollischuang.com/archives/900)。**看下面的例子：

| 事务一                                                                              | 事务二                                                                                  |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `/* Query 1 */`<br>`<br>SELECT * FROM users<br>WHERE age BETWEEN 10 AND 30;<br>` |                                                                                      |
|                                                                                  | `<br>/* Query 2 */`<br>`INSERT INTO users VALUES ( 3, 'Bob', 27 );`<br>`<br>COMMIT;` |
| `<br>/* Query 1 */`<br>`SELECT * FROM users<br>WHERE age BETWEEN 10 AND 30;`     |                                                                                      |

上面的两个事务执行情况及现象如下：

1.事务一的第一次查询条件是`age BETWEEN 10 AND 30;`如果这是有十条记录符合条件。这时，他会给符合条件的这十条记录增加行级共享锁。任何其他事务无法更改这十条记录。

2.事务二执行一条sql语句，语句的内容是向表中插入一条数据。因为此时没有任何事务对表增加[表级锁](http://www.hollischuang.com/archives/914)，所以，该操作可以顺利执行。

3.事务一再次执行`SELECT * FROM users WHERE age BETWEEN 10 AND 30;`时，结果返回的记录变成了十一条，比刚刚增加了一条，增加的这条正是事务二刚刚插入的那条。

所以，事务一的两次范围查询结果并不相同。这也就是我们提到的幻读。

#### 可序列化(Serializable)

可序列化(Serializable)是最高的隔离级别，前面提到的所有的隔离级别都无法解决的幻读，在可序列化的隔离级别中可以解决。

我们说过，产生幻读的原因是事务一在进行范围查询的时候没有增加范围锁(range-locks：给SELECT 的查询中使用一个“WHERE”子句描述范围加锁），所以导致幻读。

##### 可序列化的数据库锁情况

> 事务在读取数据时，必须先对其加 表级共享锁 ，直到事务结束才释放；
> 
> 事务在更新数据时，必须先对其加 表级排他锁 ，直到事务结束才释放。

现象

> 事务1正在读取A表中的记录时，则事务2也能读取A表，但不能对A表做更新、新增、删除，直到事务1结束。(因为事务一对表增加了表级共享锁，其他事务只能增加共享锁读取数据，不能进行其他任何操作）
> 
> 事务1正在更新A表中的记录时，则事务2不能读取A表的任意记录，更不可能对A表做更新、新增、删除，直到事务1结束。（事务一对表增加了表级排他锁，其他事务不能对表增加共享锁或排他锁，也就无法进行任何操作）

虽然可序列化解决了脏读、不可重复读、幻读等读现象。但是序列化事务会产生以下效果：

1.无法读取其它事务已修改但未提交的记录。

2.在当前事务完成之前，其它事务不能修改目前事务已读取的记录。

3.在当前事务完成之前，其它事务所插入的新记录，其索引键值不能在当前事务的任何语句所读取的索引键范围中。

---

四种事务隔离级别从隔离程度上越来越高，但同时在并发性上也就越来越低。之所以有这么几种隔离级别，就是为了方便开发人员在开发过程中根据业务需要选择最合适的隔离级别

## spring 事务

### Spring 事务管理接口介绍

Spring 框架中，事务管理相关最重要的 3 个接口如下：

- **`PlatformTransactionManager`**： （平台）事务管理器，Spring 事务策略的核心。
- **`TransactionDefinition`**： 事务定义信息(事务隔离级别、传播行为、超时、只读、回滚规则)。
- **`TransactionStatus`**： 事务运行状态。

我们可以把 **`PlatformTransactionManager`** 接口可以被看作是事务上层的管理者，而 **`TransactionDefinition`** 和 **`TransactionStatus`** 这两个接口可以看作是事务的描述。

**`PlatformTransactionManager`** 会根据 **`TransactionDefinition`** 的定义比如事务超时时间、隔离级别、传播行为等来进行事务管理 ，而 **`TransactionStatus`** 接口则提供了一些方法来获取事务相应的状态比如是否新事务、是否可以回滚等等

---

#### **`@Transactional` 的常用配置参数总结（只列出了 5 个我平时比较常用的）：**

| 属性名         | 说明                                              |
| ----------- | ----------------------------------------------- |
| propagation | 事务的传播行为，默认值为 REQUIRED，可选的值在上面介绍过                |
| isolation   | 事务的隔离级别，默认值采用 DEFAULT，可选的值在上面介绍过                |
| timeout     | 事务的超时时间，默认值为-1（不会超时）。如果超过该时间限制但事务还没有完成，则自动回滚事务。 |
| readOnly    | 指定事务是否为只读事务，默认值为 false。                         |
| rollbackFor | 用于指定能够触发事务回滚的异常类型，并且可以指定多个异常类型。                 |

#### 事务传播行为

**事务传播行为是为了解决业务层方法之间互相调用的事务问题**。

当事务方法被另一个事务方法调用时，必须指定事务应该如何传播。例如：方法可能继续在现有事务中运行，也可能开启一个新事务，并在自己的事务中运行。

举个例子：我们在 A 类的`aMethod()`方法中调用了 B 类的 `bMethod()` 方法。这个时候就涉及到业务层方法之间互相调用的事务问题。如果我们的 `bMethod()`如果发生异常需要回滚，如何配置事务传播行为才能让 `aMethod()`也跟着回滚呢？这个时候就需要事务传播行为的知识了，如果你不知道的话一定要好好看一下。

```
@Service
Class A {
    @Autowired
    B b;
    @Transactional(propagation = Propagation.xxx)
    public void aMethod {
        //do something
        b.bMethod();
    }
}

@Service
Class B {
    @Transactional(propagation = Propagation.xxx)
    public void bMethod {
       //do something
    }
}
```

在`TransactionDefinition`定义中包括了如下几个表示传播行为的常量：

```
public interface TransactionDefinition {
    int PROPAGATION_REQUIRED = 0;
    int PROPAGATION_SUPPORTS = 1;
    int PROPAGATION_MANDATORY = 2;
    int PROPAGATION_REQUIRES_NEW = 3;
    int PROPAGATION_NOT_SUPPORTED = 4;
    int PROPAGATION_NEVER = 5;
    int PROPAGATION_NESTED = 6;
    ......
}
```

不过，为了方便使用，Spring 相应地定义了一个枚举类：`Propagation`

```
package org.springframework.transaction.annotation;

import org.springframework.transaction.TransactionDefinition;

public enum Propagation {

    REQUIRED(TransactionDefinition.PROPAGATION_REQUIRED),

    SUPPORTS(TransactionDefinition.PROPAGATION_SUPPORTS),

    MANDATORY(TransactionDefinition.PROPAGATION_MANDATORY),

    REQUIRES_NEW(TransactionDefinition.PROPAGATION_REQUIRES_NEW),

    NOT_SUPPORTED(TransactionDefinition.PROPAGATION_NOT_SUPPORTED),

    NEVER(TransactionDefinition.PROPAGATION_NEVER),

    NESTED(TransactionDefinition.PROPAGATION_NESTED);

    private final int value;

    Propagation(int value) {
        this.value = value;
    }

    public int value() {
        return this.value;
    }

}
```

**正确的事务传播行为可能的值如下** ：

**1.`TransactionDefinition.PROPAGATION_REQUIRED`**

使用的最多的一个事务传播行为，我们平时经常使用的`@Transactional`注解默认使用就是这个事务传播行为。如果当前存在事务，则加入该事务；如果当前没有事务，则创建一个新的事务。也就是说：

- 如果外部方法没有开启事务的话，`Propagation.REQUIRED`修饰的内部方法会新开启自己的事务，且开启的事务相互独立，互不干扰。
- 如果外部方法开启事务并且被`Propagation.REQUIRED`的话，所有`Propagation.REQUIRED`修饰的内部方法和外部方法均属于同一事务 ，只要一个方法回滚，整个事务均回滚。

举个例子：如果我们上面的`aMethod()`和`bMethod()`使用的都是`PROPAGATION_REQUIRED`传播行为的话，两者使用的就是同一个事务，只要其中一个方法回滚，整个事务均回滚。

```
@Service
Class A {
    @Autowired
    B b;
    @Transactional(propagation = Propagation.REQUIRED)
    public void aMethod {
        //do something
        b.bMethod();
    }
}
@Service
Class B {
    @Transactional(propagation = Propagation.REQUIRED)
    public void bMethod {
       //do something
    }
}
```

**`2.TransactionDefinition.PROPAGATION_REQUIRES_NEW`**

创建一个新的事务，如果当前存在事务，则把当前事务挂起。也就是说不管外部方法是否开启事务，`Propagation.REQUIRES_NEW`修饰的内部方法会新开启自己的事务，且开启的事务相互独立，互不干扰。

举个例子：如果我们上面的`bMethod()`使用`PROPAGATION_REQUIRES_NEW`事务传播行为修饰，`aMethod`还是用`PROPAGATION_REQUIRED`修饰的话。如果`aMethod()`发生异常回滚，`bMethod()`不会跟着回滚，因为 `bMethod()`开启了独立的事务。但是，如果 `bMethod()`抛出了未被捕获的异常并且这个异常满足事务回滚规则的话,`aMethod()`同样也会回滚，因为这个异常被 `aMethod()`的事务管理机制检测到了。

```
@Service
Class A {
    @Autowired
    B b;
    @Transactional(propagation = Propagation.REQUIRED)
    public void aMethod {
        //do something
        b.bMethod();
    }
}

@Service
Class B {
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void bMethod {
       //do something
    }
}
```

**3.`TransactionDefinition.PROPAGATION_NESTED`**:

如果当前存在事务，就在嵌套事务内执行；如果当前没有事务，就执行与`TransactionDefinition.PROPAGATION_REQUIRED`类似的操作。也就是说：

- 在外部方法开启事务的情况下,在内部开启一个新的事务，作为嵌套事务存在。
- 如果外部方法无事务，则单独开启一个事务，与 `PROPAGATION_REQUIRED` 类似。

这里还是简单举个例子：如果 `bMethod()` 回滚的话，`aMethod()`也会回滚。

```
@Service
Class A {
    @Autowired
    B b;
    @Transactional(propagation = Propagation.REQUIRED)
    public void aMethod {
        //do something
        b.bMethod();
    }
}

@Service
Class B {
    @Transactional(propagation = Propagation.NESTED)
    public void bMethod {
       //do something
    }
}
```

**4.`TransactionDefinition.PROPAGATION_MANDATORY`**

如果当前存在事务，则加入该事务；如果当前没有事务，则抛出异常。（mandatory：强制性）

这个使用的很少，就不举例子来说了。

**若是错误的配置以下 3 种事务传播行为，事务将不会发生回滚，这里不对照案例讲解了，使用的很少。**

- **`TransactionDefinition.PROPAGATION_SUPPORTS`**: 如果当前存在事务，则加入该事务；如果当前没有事务，则以非事务的方式继续运行。
- **`TransactionDefinition.PROPAGATION_NOT_SUPPORTED`**: 以非事务方式运行，如果当前存在事务，则把当前事务挂起。
- **`TransactionDefinition.PROPAGATION_NEVER`**: 以非事务方式运行，如果当前存在事务，则抛出异常。

更多关于事务传播行为的内容请看这篇文章：[《太难了~面试官让我结合案例讲讲自己对 Spring 事务传播行为的理解。》open in new window](https://mp.weixin.qq.com/s?__biz=Mzg2OTA0Njk0OA==&mid=2247486668&idx=2&sn=0381e8c836442f46bdc5367170234abb&chksm=cea24307f9d5ca11c96943b3ccfa1fc70dc97dd87d9c540388581f8fe6d805ff548dff5f6b5b&token=1776990505&lang=zh_CN#rd)

#### 事务隔离级别

`TransactionDefinition` 接口中定义了五个表示隔离级别的常量：

```
public interface TransactionDefinition {
    ......
    int ISOLATION_DEFAULT = -1;
    int ISOLATION_READ_UNCOMMITTED = 1;
    int ISOLATION_READ_COMMITTED = 2;
    int ISOLATION_REPEATABLE_READ = 4;
    int ISOLATION_SERIALIZABLE = 8;
    ......
}
```

和事务传播行为那块一样，为了方便使用，Spring 也相应地定义了一个枚举类：`Isolation`

```
public enum Isolation {

  DEFAULT(TransactionDefinition.ISOLATION_DEFAULT),

  READ_UNCOMMITTED(TransactionDefinition.ISOLATION_READ_UNCOMMITTED),

  READ_COMMITTED(TransactionDefinition.ISOLATION_READ_COMMITTED),

  REPEATABLE_READ(TransactionDefinition.ISOLATION_REPEATABLE_READ),

  SERIALIZABLE(TransactionDefinition.ISOLATION_SERIALIZABLE);

  private final int value;

  Isolation(int value) {
    this.value = value;
  }

  public int value() {
    return this.value;
  }

}
```

下面我依次对每一种事务隔离级别进行介绍：

- **`TransactionDefinition.ISOLATION_DEFAULT`** :使用后端数据库默认的隔离级别，MySQL 默认采用的 `REPEATABLE_READ` 隔离级别 Oracle 默认采用的 `READ_COMMITTED` 隔离级别.
- **`TransactionDefinition.ISOLATION_READ_UNCOMMITTED`** :最低的隔离级别，使用这个隔离级别很少，因为它允许读取尚未提交的数据变更，**可能会导致脏读、幻读或不可重复读**
- **`TransactionDefinition.ISOLATION_READ_COMMITTED`** : 允许读取并发事务已经提交的数据，**可以阻止脏读，但是幻读或不可重复读仍有可能发生**
- **`TransactionDefinition.ISOLATION_REPEATABLE_READ`** : 对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改，**可以阻止脏读和不可重复读，但幻读仍有可能发生。**
- **`TransactionDefinition.ISOLATION_SERIALIZABLE`** : 最高的隔离级别，完全服从 ACID 的隔离级别。所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，**该级别可以防止脏读、不可重复读以及幻读**。但是这将严重影响程序的性能。通常情况下也不会用到该级别。

相关阅读：[MySQL事务隔离级别详解open in new window](https://javaguide.cn/database/mysql/transaction-isolation-level.html)。

#### 事务超时属性

所谓事务超时，就是指一个事务所允许执行的最长时间，如果超过该时间限制但事务还没有完成，则自动回滚事务。在 `TransactionDefinition` 中以 int 的值来表示超时时间，其单位是秒，默认值为-1，这表示事务的超时时间取决于底层事务系统或者没有超时时间。

#### 事务只读属性

```
package org.springframework.transaction;

import org.springframework.lang.Nullable;

public interface TransactionDefinition {
    ......
    // 返回是否为只读事务，默认值为 false
    boolean isReadOnly();

}
```

对于只有读取数据查询的事务，可以指定事务类型为 readonly，即只读事务。只读事务不涉及数据的修改，数据库会提供一些优化手段，适合用在有多条数据库查询操作的方法中

如果不加`Transactional`，每条`sql`会开启一个单独的事务，中间被其它事务改了数据，都会实时读取到最新值。

- 如果你一次执行单条查询语句，则没有必要启用事务支持，数据库默认支持 SQL 执行期间的读一致性；
- 如果你一次执行多条查询语句，例如统计查询，报表查询，在这种场景下，多条查询 SQL 必须保证整体的读一致性，否则，在前条 SQL 查询之后，后条 SQL 查询之前，数据被其他用户改变，则该次整体的统计查询将会出现读数据不一致的状态，此时，应该启用事务支持

#### 事务回滚规则

这些规则定义了哪些异常会导致事务回滚而哪些不会。默认情况下，事务只有遇到运行期异常（`RuntimeException` 的子类）时才会回滚，`Error` 也会导致事务回滚，但是，在遇到检查型（Checked）异常时不会回滚。

---

#### [](#transactional-的使用注意事项总结)`@Transactional` 的使用注意事项总结

- `@Transactional` 注解只有作用到 public 方法上事务才生效，不推荐在接口上使用；
- 避免同一个类中调用 `@Transactional` 注解的方法，这样会导致事务失效；
- 正确的设置 `@Transactional` 的 `rollbackFor` 和 `propagation` 属性，否则事务可能会回滚失败;
- 被 `@Transactional` 注解的方法所在的类必须被 Spring 管理，否则不生效；
- 底层使用的数据库必须支持事务机制，否则不生效；

## 分布式事务

理论:

方案:

1. 轻量级 
   
   1. atomikos [原子学指南 |贝尔东 (baeldung.com)](https://www.baeldung.com/java-atomikos)
      
      1. 实现了 jta(Java Transaction API)
      
      2. 支持 xa 协议      XA 规范通过称为两阶段提交的协议提供完整性。两阶段提交是一种广泛使用的分布式算法，用于促进提交或回滚分布式事务的决策。

2. 消息的补偿机制