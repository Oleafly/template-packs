#import "../lib/util.typ": example, noeq

= 基于Typst的论文排版

本章介绍Typst语言的标记和语法，作为论文排版的基础。注意本章只介绍学位论文排版中常用的标记，需要完整语法的请参考Typst官方文档。

== 文字


#example(
  ```typst
  这是第一段
  这还是第一段
  这依然是第一段

  空白行后是第二段了。
  ```,
  [空白行标记正文分段],
)

#example(
  ```typst
  = 一级标题
  == 二级标题
  === 三级标题
  ```,
  [等号标记标题],
)

#example(
  ```typst
  下面我来说几条
  - 一条
  - 一条
  - 又一条，很长，带两个段落。注意缩进

    这是一个段落
  - 再来一条

  + 第一条
  + 第二条
  + 第三条
  ```,
  [加减号分别表示编号、不编号列表],
)
== 图表
#example(
  ```typst
  一般不建议插裸图
  #image("../assets/latin-handwritting.png", width: 80%)

  要加上说明
  #figure(
    caption: [这不是裸图],
    image("../assets/latin-handwritting.png", width: 80%)
  )
  ```,
  [插图],
)

#example(
  ```typst
  #figure(
    caption: [排版软件对比],
    table(
      columns: 4,
      table.hline(stroke: 1pt),
      table.header([软件], [Word], [LaTeX], [Typst]),
      table.hline(stroke: 1pt),
      [优点], [入门\ 容易], [格式\ 规范], [入门容易，\ 格式规范],
      [缺点], [格式\ 不规范], [入门难], [],
      table.hline(stroke: 1pt),
    )
  )
  ```,
  [插表],
)

#example(
  ````typst
  #figure(
    caption: [循环算法],
    ```python
    sum = 0
    for i in range(100):
      sum += 1
    ```
  )
  ````,
  [插代码],
)

== 数学公式
#example(
  ```typst
  这是一个内嵌公式 $y=sin(x)$。

  这是一个提行公式，默认带编号
  $
    e = 4 + sqrt(a^2+b)/c
  $

  这是一个不带编号的提行公式
  #noeq($e = m c^2$)
  ```,
  [等号标记标题],
  scope: ("noeq": noeq)
)

== 内部引用

#example(
  ```typst
  #figure(
    caption: [一个完美的圆],
    circle()
  ) <圆圈>

  我们首先画一个圆圈，如@圆圈 所示。它的面积如@圆面积 计算。
  $ s =pi r^2 $ <圆面积>

  #figure(
    caption: [面积对照表],
    table(
      columns: 2,
      table.hline(stroke: 1pt),
      [半径], [面积],
      table.hline(stroke: 1pt),
      [1], [#{3.14 * calc.pow(1, 2)}], 
      [2], [#{3.14 * calc.pow(2, 2)}], 
      [3], [#{3.14 * calc.pow(3, 2)}], 
      table.hline(stroke: 1pt),
    )
  ) <面积对照表>

  我们计算了一个面积对照表，见@面积对照表。
  ```,
  [加标签，引用标签],
)

== 文献引用

#example(
  ````typst
  我们在论文中描述了LaTeX的基本功能
  @lamportLaTeXDocumentPreparation1994。
  也描述了Typst
  @madjeTypstProgrammableMarkup2022
  基本功能。下面来做个对比。

  // 论文最后需要读入参考文献列表，如下所示。具体参考本文档的源代码。
  //#bibliography(
  //  "../assets/参考文献.bib",
  //  title: none,
  //  style: "gb-7714-2015-numeric" 
  //)
  ````,
  [等号标记标题],
)
