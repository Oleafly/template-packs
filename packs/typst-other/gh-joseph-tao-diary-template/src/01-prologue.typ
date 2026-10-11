#import "/template/template.typ": *

= 前言

#show raw.where(block: true): it => {
  block(
    width: 100%,
    fill: luma(200),
    inset: 10pt,
    radius: 8pt,
  )[#it]
}

以下是部分日记功能的展示：

== 待办

=== 添加待办

通过 ```typst #todo``` 添加，例如：

```typst
#todo[Todo 1] \
#todo[Todo 2] \
#todo[Todo 3]
```

#todo[Todo 1] \
#todo[Todo 2] \
#todo[Todo 3]

每一条 Todo 都带有 ```typst <todo:X>``` 标签。

=== 显示待办

通过 ```typst #show-todo``` 显示待办：

#show-todo()

待办的条目是指向源位置的链接。即使待办散落在日记的各个部分，最后都能通过 ```typst #show-todo``` 收集。

```typst #show-todo``` 可以用在日记的任何地方，不一定是所有待办之后。

== 样式

=== 列表

- 第一个项目
- 第二个项目

=== 链接

这是一个链接，指向 #link("https://www.example.com")[示例网站]。

=== 问答/采访

通过 ```typst #qa``` 添加。例如：

```typst
#qa[
  #lorem(10)
][
  #lorem(30)
]
```

#qa[
  #lorem(10)
][
  #lorem(30)
]

=== 诗歌

通过 ```typst #poem``` 添加。例如：

```typst
#poem[
  #lorem(5) \
  #lorem(7)
]
```

#poem[
  #lorem(5) \
  #lorem(7)
]

=== 名称隐去

通过 ```typst #name``` 添加。例如：

```typst
#name("A") and #name("B") are my friends.
```

#name("A") and #name("B") are my friends.

这个功能可以通过将 `main.typ` 中的 `show-name` 修改为 ```typst true``` 来关闭。

== 日记及日记交叉引用

使用 ```typst #diary-entry``` 和 ```typst #diary-ref``` 进行日记编写与引用。

一篇日记是一个带有 ```typst <diary:yyyymmdd>``` 标签的二级标题。

示例如下：

```typst
#let show-today() = context [
  Today is: #repr(state("date").get())
]

#diary-entry("19700101")
#show-today()

#diary-entry("19720102")
#show-today()

#diary-entry("19730103")
#show-today()

- Arbitrary: #diary-ref("19700101")
- Last year: #diary-ref("19720102")
- This year: #diary-ref("19730103")

== Non-Diary Chapter

#show-today() // none
```

#let show-today() = context [
  Today is: #repr(state("date").get())
]

#diary-entry("19700101")
#show-today()

#diary-entry("19720102")
#show-today()

#diary-entry("19730103")
#show-today()

- Arbitrary: #diary-ref("19700101")
- Last year: #diary-ref("19720102")
- This year: #diary-ref("19730103")

== Non-Diary Chapter

#show-today() // none
