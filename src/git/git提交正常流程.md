### 主要步骤
1. 登录GitHub 创建一个仓库
2. 在本地idea的 terminal中打入命令
```shell
# 初始化项目为git项目
git init
# 设置远端的URL
git remote add origin URL
# 拉取代码
git pull origin main
```
3. 其他选择图形化操作即可

### 之前的操作过程
```shell
D:\works\java\json>git init
Initialized empty Git repository in D:/works/java/json/.git/

D:\works\java\json>git --help
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.

D:\works\java\json>git reomte add origin https://github.com/HongXiaoHong/json.git
git: 'reomte' is not a git command. See 'git --help'.

The most similar command is
        remote

D:\works\java\json>git remote add origin https://github.com/HongXiaoHong/json.git

D:\works\java\json>git remote
origin

D:\works\java\json>git pull origin master
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/HongXiaoHong/json
 * branch            master     -> FETCH_HEAD
 * [new branch]      master     -> origin/master

D:\works\java\json>git add .

D:\works\java\json>git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   .classpath
        new file:   .project
        new file:   .settings/org.eclipse.core.resources.prefs
        new file:   .settings/org.eclipse.jdt.core.prefs
        new file:   .settings/org.eclipse.m2e.core.prefs
        new file:   output.json
        new file:   pom.xml
        new file:   src/main/java/alternativeName.json
        new file:   src/main/java/complicated.json
        new file:   src/main/java/output.json
        new file:   src/main/java/person/hong/json/App.java
        new file:   src/main/java/person/hong/json/fastjson/entity/Course.java
        new file:   src/main/java/person/hong/json/fastjson/entity/Person.java
        new file:   src/main/java/person/hong/json/fastjson/entity/Student.java
        new file:   src/main/java/person/hong/json/fastjson/entity/Teacher.java
        new file:   src/main/java/person/hong/json/fastjson/entity/TestMain.java
        new file:   src/main/java/person/hong/json/fastjson/use/BasicUse.java
        new file:   src/main/java/person/hong/json/fastjson/use/BeanStringJsonUse.java
        new file:   src/main/java/person/hong/json/fastjson/use/BeanUse.java
        new file:   src/main/java/person/hong/json/gson/advanced/Book.java
        new file:   src/main/java/person/hong/json/gson/advanced/Result.java
        new file:   src/main/java/person/hong/json/gson/advanced/TestMainBook.java
        new file:   src/main/java/person/hong/json/gson/advanced/TestMainDeserialzation.java
        new file:   src/main/java/person/hong/json/gson/advanced/TestMainDeserialzationWithGeneric.java
        new file:   src/main/java/person/hong/json/gson/advanced/User.java
        new file:   src/main/java/person/hong/json/gson/base/GsonApp.java
        new file:   src/main/java/person/hong/json/gson/base/Person.java
        new file:   src/main/java/person/hong/json/gson/base/Phone.java
        new file:   src/main/java/person/hong/json/gson/base/ReadJsonApp.java
        new file:   src/main/java/person/hong/json/gson/deserialization/Author.java
        new file:   src/main/java/person/hong/json/gson/deserialization/Book.java
        new file:   src/main/java/person/hong/json/gson/deserialization/BookDeserializer.java
        new file:   src/main/java/person/hong/json/gson/deserialization/EBook.java
        new file:   src/main/java/person/hong/json/gson/deserialization/EBookDeserializer.java
        new file:   src/main/java/person/hong/json/gson/deserialization/TestMainBook.java
        new file:   src/main/java/person/hong/json/gson/deserialization/TestMainEBook.java
        new file:   src/main/java/person/hong/json/gson/serialization/Author.java
        new file:   src/main/java/person/hong/json/gson/serialization/AuthorSerialiser.java
        new file:   src/main/java/person/hong/json/gson/serialization/Book.java
        new file:   src/main/java/person/hong/json/gson/serialization/BookSerialiser.java
        new file:   src/main/java/person/hong/json/gson/serialization/EBook.java
        new file:   src/main/java/person/hong/json/gson/serialization/EBookSerialiser.java
        new file:   src/main/java/person/hong/json/gson/serialization/TestMainBook.java
        new file:   src/main/java/person/hong/json/gson/serialization/TestMainEBook.java
        new file:   src/main/java/person/hong/json/gson/serialization/TestMainEBookWithAuthorSerialiser.java
        new file:   src/main/java/person/hong/json/jackson/entity/JSONCaseA.java
        new file:   src/main/java/person/hong/json/jackson/entity/JsonCaseB.java
        new file:   src/main/java/person/hong/json/jackson/use/TestReadJson.java
        new file:   src/main/java/person/hong/json/jackson/use/TestRootNode.java
        new file:   src/main/java/person/hong/json/jackson/use/TestWriteJson.java
        new file:   src/main/java/person/hong/json/util/PrintUtil.java
        new file:   src/main/java/result.json
        new file:   src/main/java/sample.json
        new file:   src/test/java/person/hong/json/AppTest.java
        new file:   target/classes/META-INF/MANIFEST.MF
        new file:   target/classes/META-INF/maven/person.hong/json/pom.properties
        new file:   target/classes/META-INF/maven/person.hong/json/pom.xml
        new file:   target/classes/alternativeName.json
        new file:   target/classes/complicated.json
        new file:   target/classes/output.json
        new file:   target/classes/person/hong/json/App.class
        new file:   target/classes/person/hong/json/fastjson/entity/Course.class
        new file:   target/classes/person/hong/json/fastjson/entity/Person.class
        new file:   target/classes/person/hong/json/fastjson/entity/Student.class
        new file:   target/classes/person/hong/json/fastjson/entity/Teacher.class
        new file:   target/classes/person/hong/json/fastjson/entity/TestMain.class
        new file:   target/classes/person/hong/json/fastjson/use/BasicUse.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanStringJsonUse$1.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanStringJsonUse$2.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanStringJsonUse$3.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanStringJsonUse.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanUse$1.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanUse$2.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanUse$3.class
        new file:   target/classes/person/hong/json/fastjson/use/BeanUse.class
        new file:   target/classes/person/hong/json/gson/advanced/Book.class
        new file:   target/classes/person/hong/json/gson/advanced/Result.class
        new file:   target/classes/person/hong/json/gson/advanced/TestMainBook.class
        new file:   target/classes/person/hong/json/gson/advanced/TestMainDeserialzation.class
        new file:   target/classes/person/hong/json/gson/advanced/TestMainDeserialzationWithGeneric$1.class
        new file:   target/classes/person/hong/json/gson/advanced/TestMainDeserialzationWithGeneric.class
        new file:   target/classes/person/hong/json/gson/advanced/User.class
        new file:   target/classes/person/hong/json/gson/base/GsonApp.class
        new file:   target/classes/person/hong/json/gson/base/Person.class
        new file:   target/classes/person/hong/json/gson/base/Phone.class
        new file:   target/classes/person/hong/json/gson/base/ReadJsonApp.class
        new file:   target/classes/person/hong/json/gson/deserialization/Author.class
        new file:   target/classes/person/hong/json/gson/deserialization/Book.class
        new file:   target/classes/person/hong/json/gson/deserialization/BookDeserializer.class
        new file:   target/classes/person/hong/json/gson/deserialization/EBook.class
        new file:   target/classes/person/hong/json/gson/deserialization/EBookDeserializer.class
        new file:   target/classes/person/hong/json/gson/deserialization/TestMainBook.class
        new file:   target/classes/person/hong/json/gson/deserialization/TestMainEBook.class
        new file:   target/classes/person/hong/json/gson/serialization/Author.class
        new file:   target/classes/person/hong/json/gson/serialization/AuthorSerialiser.class
        new file:   target/classes/person/hong/json/gson/serialization/Book.class
        new file:   target/classes/person/hong/json/gson/serialization/BookSerialiser.class
        new file:   target/classes/person/hong/json/gson/serialization/EBook.class
        new file:   target/classes/person/hong/json/gson/serialization/EBookSerialiser.class
        new file:   target/classes/person/hong/json/gson/serialization/TestMainBook.class
        new file:   target/classes/person/hong/json/gson/serialization/TestMainEBook.class
        new file:   target/classes/person/hong/json/gson/serialization/TestMainEBookWithAuthorSerialiser.class
        new file:   target/classes/person/hong/json/jackson/entity/JSONCaseA.class
        new file:   target/classes/person/hong/json/jackson/entity/JsonCaseB.class
        new file:   target/classes/person/hong/json/jackson/use/TestReadJson.class
        new file:   target/classes/person/hong/json/jackson/use/TestRootNode.class
        new file:   target/classes/person/hong/json/jackson/use/TestWriteJson.class
        new file:   target/classes/person/hong/json/util/PrintUtil.class
        new file:   target/classes/result.json
        new file:   target/classes/sample.json
        new file:   target/test-classes/person/hong/json/AppTest.class


D:\works\java\json>git commit -m 'jsonx【反】序列'
[master 93f4f20] 'jsonx【反】序列'
 111 files changed, 2269 insertions(+)
 create mode 100644 .classpath
 create mode 100644 .project
 create mode 100644 .settings/org.eclipse.core.resources.prefs
 create mode 100644 .settings/org.eclipse.jdt.core.prefs
 create mode 100644 .settings/org.eclipse.m2e.core.prefs
 create mode 100644 output.json
 create mode 100644 pom.xml
 create mode 100644 src/main/java/alternativeName.json
 create mode 100644 src/main/java/complicated.json
 create mode 100644 src/main/java/output.json
 create mode 100644 src/main/java/person/hong/json/App.java
 create mode 100644 src/main/java/person/hong/json/fastjson/entity/Course.java
 create mode 100644 src/main/java/person/hong/json/fastjson/entity/Person.java
 create mode 100644 src/main/java/person/hong/json/fastjson/entity/Student.java
 create mode 100644 src/main/java/person/hong/json/fastjson/entity/Teacher.java
 create mode 100644 src/main/java/person/hong/json/fastjson/entity/TestMain.java
 create mode 100644 src/main/java/person/hong/json/fastjson/use/BasicUse.java
 create mode 100644 src/main/java/person/hong/json/fastjson/use/BeanStringJsonUse.java
 create mode 100644 src/main/java/person/hong/json/fastjson/use/BeanUse.java
 create mode 100644 src/main/java/person/hong/json/gson/advanced/Book.java
 create mode 100644 src/main/java/person/hong/json/gson/advanced/Result.java
 create mode 100644 src/main/java/person/hong/json/gson/advanced/TestMainBook.java
 create mode 100644 src/main/java/person/hong/json/gson/advanced/TestMainDeserialzation.java
 create mode 100644 src/main/java/person/hong/json/gson/advanced/TestMainDeserialzationWithGeneric.java
 create mode 100644 src/main/java/person/hong/json/gson/advanced/User.java
 create mode 100644 src/main/java/person/hong/json/gson/base/GsonApp.java
 create mode 100644 src/main/java/person/hong/json/gson/base/Person.java
 create mode 100644 src/main/java/person/hong/json/gson/base/Phone.java
 create mode 100644 src/main/java/person/hong/json/gson/base/ReadJsonApp.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/Author.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/Book.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/BookDeserializer.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/EBook.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/EBookDeserializer.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/TestMainBook.java
 create mode 100644 src/main/java/person/hong/json/gson/deserialization/TestMainEBook.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/Author.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/AuthorSerialiser.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/Book.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/BookSerialiser.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/EBook.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/EBookSerialiser.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/TestMainBook.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/TestMainEBook.java
 create mode 100644 src/main/java/person/hong/json/gson/serialization/TestMainEBookWithAuthorSerialiser.java
 create mode 100644 src/main/java/person/hong/json/jackson/entity/JSONCaseA.java
 create mode 100644 src/main/java/person/hong/json/jackson/entity/JsonCaseB.java
 create mode 100644 src/main/java/person/hong/json/jackson/use/TestReadJson.java
 create mode 100644 src/main/java/person/hong/json/jackson/use/TestRootNode.java
 create mode 100644 src/main/java/person/hong/json/jackson/use/TestWriteJson.java
 create mode 100644 src/main/java/person/hong/json/util/PrintUtil.java
 create mode 100644 src/main/java/result.json
 create mode 100644 src/main/java/sample.json
 create mode 100644 src/test/java/person/hong/json/AppTest.java
 create mode 100644 target/classes/META-INF/MANIFEST.MF
 create mode 100644 target/classes/META-INF/maven/person.hong/json/pom.properties
 create mode 100644 target/classes/META-INF/maven/person.hong/json/pom.xml
 create mode 100644 target/classes/alternativeName.json
 create mode 100644 target/classes/complicated.json
 create mode 100644 target/classes/output.json
 create mode 100644 target/classes/person/hong/json/App.class
 create mode 100644 target/classes/person/hong/json/fastjson/entity/Course.class
 create mode 100644 target/classes/person/hong/json/fastjson/entity/Person.class
 create mode 100644 target/classes/person/hong/json/fastjson/entity/Student.class
 create mode 100644 target/classes/person/hong/json/fastjson/entity/Teacher.class
 create mode 100644 target/classes/person/hong/json/fastjson/entity/TestMain.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BasicUse.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanStringJsonUse$1.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanStringJsonUse$2.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanStringJsonUse$3.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanStringJsonUse.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanUse$1.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanUse$2.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanUse$3.class
 create mode 100644 target/classes/person/hong/json/fastjson/use/BeanUse.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/Book.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/Result.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/TestMainBook.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/TestMainDeserialzation.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/TestMainDeserialzationWithGeneric$1.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/TestMainDeserialzationWithGeneric.class
 create mode 100644 target/classes/person/hong/json/gson/advanced/User.class
 create mode 100644 target/classes/person/hong/json/gson/base/GsonApp.class
 create mode 100644 target/classes/person/hong/json/gson/base/Person.class
 create mode 100644 target/classes/person/hong/json/gson/base/Phone.class
 create mode 100644 target/classes/person/hong/json/gson/base/ReadJsonApp.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/Author.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/Book.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/BookDeserializer.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/EBook.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/EBookDeserializer.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/TestMainBook.class
 create mode 100644 target/classes/person/hong/json/gson/deserialization/TestMainEBook.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/Author.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/AuthorSerialiser.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/Book.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/BookSerialiser.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/EBook.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/EBookSerialiser.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/TestMainBook.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/TestMainEBook.class
 create mode 100644 target/classes/person/hong/json/gson/serialization/TestMainEBookWithAuthorSerialiser.class
 create mode 100644 target/classes/person/hong/json/jackson/entity/JSONCaseA.class
 create mode 100644 target/classes/person/hong/json/jackson/entity/JsonCaseB.class
 create mode 100644 target/classes/person/hong/json/jackson/use/TestReadJson.class
 create mode 100644 target/classes/person/hong/json/jackson/use/TestRootNode.class
 create mode 100644 target/classes/person/hong/json/jackson/use/TestWriteJson.class
 create mode 100644 target/classes/person/hong/json/util/PrintUtil.class
 create mode 100644 target/classes/result.json
 create mode 100644 target/classes/sample.json
 create mode 100644 target/test-classes/person/hong/json/AppTest.class

D:\works\java\json>git status
On branch master
nothing to commit, working tree clean

D:\works\java\json>git push -u origin master
Enumerating objects: 157, done.
Counting objects: 100% (157/157), done.
Delta compression using up to 12 threads
Compressing objects: 100% (137/137), done.
Writing objects: 100% (156/156), 57.02 KiB | 1.84 MiB/s, done.
Total 156 (delta 24), reused 0 (delta 0)
remote: Resolving deltas: 100% (24/24), done.
To https://github.com/HongXiaoHong/json.git
   6141843..93f4f20  master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.

D:\works\java\json>git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```