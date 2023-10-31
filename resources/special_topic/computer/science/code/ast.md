# ast
## 初识

其实一开始是在 c++ 转换到 java 中的思路了解到的

知道可以通过这么一颗语法树进行转换

但是市面上基本没有此类实现

实在是太惨兮兮了

后来是在 vue 语法解析的源码中知道了 同样也是用的 AST 代码对 vue 的语法进行解析

[玩转AST语法树](https://www.bilibili.com/video/BV1MT41137JT/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

该视频讲述了 如何利用 babel 将 js 代码转换为 ast 语法树
然后通过改写console.error 的参数 将当前行数 传递到参数中, 进行打印

### [用Java怎么解析C/C++代码生成AST抽象语法树结构？](https://www.zhihu.com/question/50931041/answer/123697502)
[grammars-v4](https://github.com/antlr/grammars-v4/)

作者：RednaxelaFX
链接：https://www.zhihu.com/question/50931041/answer/123697502
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

原理上说用Java实现C或C++的parser跟用别的语言实现没啥区别。现实中有若干现成的用Java实现的C或C++ parser。先说两个开源的。其中一个明显的例子是Eclipse CDT里的parser。它是完全用Java实现的，手写的递归下降parser，能把C或C++源码parse成AST供Eclipse CDT的IDE功能使用。它支持C99语法（包括GCC扩展）、C++语法（我没仔细看现在支持到什么版本了）等。它并不用于实际的编译（这跟Eclipse JDT里的Eclipse Compiler for Java不同）；实际编译还是交给诸如GCC、xlc之类的编译器去完成。关于Eclipse CDT里的C与C++ parser的介绍，请参考：CDT/designs/Overview of ParsingParsing and Analyzing C/C++ code in Eclipse最新的源码：org.eclipse.cdt.gitCDT里还包含一个用Java实现的LR parser，也可以参考：org.eclipse.cdt.git==================================还有一个用Java实现的C99的预处理器和语法分析器，分别是：GitHub - shevek/jcpp: The C Preprocessor as a Java libraryGitHub - shevek/jccfe: Java C Compiler Front End背景介绍请跳个传送门：使用Java之类的高级语言编写C编译器，如何实现内存分配，不是Java中无法直接操作内存吗？ - Java==================================Jetbrains的CLion的C++ parser也是用Java实现的。不过这个不开源所以对题主来说参考价值不大。面对很多人喷他们说为啥不用libclang，他们说：JetBrains Way to C++: The Inside Story of Our Journey==================================至于ANTLR，是的一直有人用它写C或C++的语法，但现实中用那些语法总是有各种问题要细致调整之后才用得了，所以…就不多说了。GitHub - antlr/grammars-v4: Grammars written for ANTLR v4; expectation that the grammars are free of actions. <- 这里是有C11和C++14的语法没错…题主要是勇敢的话请吃螃蟹 ^_^
