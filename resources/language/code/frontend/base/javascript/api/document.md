# document | 操作页面 api

https://developer.mozilla.org/zh-CN/docs/Web/API/Document/createDocumentFragment

Document.createDocumentFragment()
创建一个新的空白的文档片段

因为文档片段存在于内存中，并不在 DOM 树中，所以将子元素插入到文档片段时不会引起页面回流（对元素位置和几何上的计算）

因此，使用文档片段通常会带来更好的性能