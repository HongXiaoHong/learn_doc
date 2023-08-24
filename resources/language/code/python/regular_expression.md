# python  正则表达式
Python 正则表达式的一些基本知识。

在 Python 中，正则表达式是通过 `re` 模块实现的。以下是一些常用的 `re` 模块函数和常用的正则表达式模式。

1. **re.search(pattern, string)**: 在字符串中查找匹配的模式。返回第一个匹配的模式，如果没有找到匹配项，则返回 None。

2. **re.match(pattern, string)**: 如果从字符串开始位置起匹配的模式，则返回匹配对象。如果没有找到匹配项，则返回 None。

3. **re.findall(pattern, string)**: 返回一个包含所有匹配的模式的列表。如果没有找到匹配项，则返回一个空列表。

4. **re.sub(pattern, repl, string)**: 将字符串中的所有匹配的模式替换为提供的字符串，并返回新的字符串。

常用的正则表达式模式有：

- **.**: 匹配除 "\\n" 之外的任何字符。

- **^**: 匹配字符串的开头。

- **$**: 匹配字符串的末尾。

- **\***: 前面的元素可以被匹配零次或多次。

- **+**: 前面的元素可以被匹配一次或多次。

- **?**: 前面的元素可以被匹配零次或一次。

- **{n}**: 前面的元素可以被匹配 n 次。

- **{n,}**: 前面的元素可以被匹配 n 次或更多次。

- **{,m}**: 前面的元素可以被匹配零次到 m 次。

- **{n,m}**: 前面的元素可以被匹配 n 次到 m 次。

- **\[abc\]**: 匹配方括号内的任何字符。

- **\[^abc\]**: 匹配不在方括号内的任何字符。

- **\\d**: 匹配任何数字，等价于 \[0-9\]。

- **\\D**: 匹配任何非数字字符，等价于 \[^0-9\]。

- **\\s**: 匹配任何空白字符，等价于 \[\\t\\n\\r\\f\\v\]。

- **\\S**: 匹配任何非空白字符，等价于 \[^\\t\\n\\r\\f\\v\]。

- **\\w**: 匹配任何字母数字字符，等价于 \[a-zA-Z0-9\_\]。

- **\\W**: 匹配任何非字母数字字符，等价于 \[^a-zA-Z0-9\_\]。

例如，假设我们有一个字符串 `'The quick brown fox jumps over the lazy dog.'`，我们想要找到所有的单词。我们可以使用 `\w+` 模式匹配任何单词（一个或多个字母或数字）。以下是如何使用 `re.findall` 函数来找到所有的单词：

```
pythonimport re

string = 'The quick brown fox jumps over the lazy dog.'
words = re.findall('\w+', string)
print(words)  # 输出：['The', 'quick', 'brown', 'fox', 'jumps', 'over', 'the', 'lazy', 'dog']

```

这只是 Python 正则表达式的基本概念。正则表达式是一个强大的工具，你可以使用它来执行复杂的模式匹配和文本操作。

#### re.search(pattern, string) 和 re.match(pattern, string)的区别

re.search（pattern， string） 和 re.match（pattern， string）的区别

`re.search()` 和 `re.match()` 都是 Python 的 `re` 模块中用于匹配字符串的函数，但是它们在功能上有一些不同：

1. **re.match()**: 此函数尝试从字符串的起始位置匹配一个模式，如果在起始位置没有找到匹配的模式，match()就返回None。这意味着，`re.match()` 只匹配字符串的开始部分。

2. **re.search()**: 此函数会在字符串中搜索模式的第一个出现位置，如果成功，则返回一个匹配对象，如果没有找到匹配的模式，则返回None。这意味着，`re.search()` 会扫描整个字符串，直到找到一个匹配的模式。

举个例子，我们有以下代码：

```
pythonimport re

text = "I love Python programming"

match_result = re.match('Python', text)
search_result = re.search('Python', text)

print('Match:', match_result)
print('Search:', search_result)

```

这段代码会输出：

```
sqlMatch: None
Search: <re.Match object; span=(7, 13), match='Python'>

```

从输出结果可以看到，`re.match()` 返回了 None，这是因为 "Python" 并不是字符串 text 的开始部分，所以 `re.match()` 没有找到匹配的模式。而 `re.search()` 返回了一个 Match 对象，这是因为 "Python" 在字符串 text 中被找到了，尽管它不在开始部分。

总的来说，当你想要查找字符串中是否包含某个模式，并且不关心这个模式出现的位置时，使用 `re.search()`，当你想要确保字符串从某个特定模式开始时，使用 `re.match()`。

### 参考
[菜鸟](https://www.runoob.com/python/python-reg-expressions.html)