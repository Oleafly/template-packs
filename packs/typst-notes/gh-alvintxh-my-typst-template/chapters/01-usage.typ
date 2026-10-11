#import "../lib/lib.typ": *

= 模板用法

这一章把模板提供的各种块都摆一遍。每个例子下面都跟着源码，照抄改内容即可。

== 标题

一级标题 `=` 相当于一章，会自动另起一页，并重置公式、图、表和定理的编号。
二级 `==`、三级 `===` 用于节和小节，四级 `====` 是不编号的行内小标题。

不想让每章另起一页（短笔记常见），在 `main.typ` 里加 `chapter-break: false`。

== 定理类环境

定理、定义、引理、推论、命题、定律、例、注、习题共用一个计数器，
所以编号是连着的，找的时候不容易乱。

#definition(title: "熵")[
  对宏观态包含的微观态数 $Omega$，玻尔兹曼熵定义为
  $ S = kB ln Omega. $
] <def:entropy>

#law(title: "热力学第二定律")[
  孤立系统的熵不会自发减少：$dif S >= 0$。
] <law:second>

#theorem[
  平衡态对应熵取极大值。
] <thm:eq>

#proof[
  在约束条件下对 @def:entropy 中的 $Omega$ 求极值即可。
]

#example(title: "两个盒子")[
  把 $N$ 个粒子分到两个等大的盒子里，最概然分布是各一半，
  此时 $Omega$ 最大 —— 这正是 @thm:eq 的一个特例。
]

写法是：

```typ
#definition(title: "熵")[
  正文……
] <def:entropy>

引用时写 @def:entropy，会显示成「定义 1.1」。
```

`title:` 可以省略。想让某个环境不编号，用 `#proof[...]` 或 `#solution[...]`，
它们是浅色竖线样式，末尾自动补一个证毕方块。

#remark[
  环境名和配色都在 `lib/theme.typ` 里，想加一个「假设」环境，
  照着 `lib/blocks.typ` 里 `#let law = _numbered(...)` 那行复制一行就行。
]

== 提示框

提示框不编号，也不参与交叉引用，用来标记读的时候需要停一下的地方。

#info[`#info[...]` —— 补充说明、背景交代。]

#tip[`#tip[...]` —— 计算技巧、记忆方法。]

#warning(title: "量纲")[`#warning[...]` —— 容易忽略的前提条件。]

#danger(title: "符号约定")[`#danger[...]` —— 自己踩过的坑，考试会错的地方。]

#idea[`#idea[...]` —— 突然想到的思路，还没验证的猜测。]

== 零碎的小工具

- #hl[高亮]：`#hl[高亮]`，给关键结论上主色。
- #term[术语]：`#term[术语]`，术语首次出现时标一下。
- 按键：`#kbd("⌘")` 出来是 #kbd("⌘") #kbd("S")。
- 并排：`#side-by-side(a, b)` 把两块内容等宽排开。

#side-by-side(
  info[左边这一块。],
  tip[右边这一块。],
)

== 引文、列表和表格

#quote(attribution: [Feynman])[
  What I cannot create, I do not understand.
]

无序列表和有序列表：

- 第一条
- 第二条
  - 嵌套一层
+ 自动编号
+ 再来一条

表格默认是三线表的样子，首行自动加粗：

#figure(
  table(
    columns: 4,
    [量], [符号], [单位], [量纲],
    [能量], $E$, [J], $M L^2 T^(-2)$,
    [动量], $p$, [kg·m/s], $M L T^(-1)$,
    [作用量], $S$, [J·s], $M L^2 T^(-1)$,
  ),
  caption: [几个力学量的量纲],
) <tab:dim>

引用表格：见 @tab:dim。
