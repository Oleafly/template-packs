#import "@preview/algo:0.3.6": algo, code, d, i

= 图表

== 图表

#figure(caption: "测试表格")[
  #table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: center + horizon,
    table.header([], [*Area*], [*Parameters*]),
    "圆柱",
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],
  )
]

以上为单页测试表格，下面是单张图片。

#figure(caption: "测试图片")[
  #image("../cover/badge.jpg")
]

三线表需要手动指定header内容；如遇表格标题与表格内容完全分开的情况，请手动插入

```typst
#pagebreak(weak: true)
```

来将标题换页至下一页。

*注*：请勿在表格的`table.header`前和内容最后设置`table.hline`，否则会导致三线表格式错误。

#figure(caption: "测试表格")[
  #table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: center + horizon,
    table.header([], [*Area*], [*Parameters*]),
    "圆柱",
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    "正四面体", $ sqrt(2) / 12 a^3 $, [$a$: edge length],
    "圆柱",
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    "正四面体", $ sqrt(2) / 12 a^3 $, [$a$: edge length],
    "圆柱",
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    "正四面体", $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  )
]

@fig:test1 是组图：

#figure(
  caption: [组图测试],
  kind: image,
)[
  #grid(
    columns: (auto, auto),
    gutter: 5em,

    figure(caption: "(a) 子图1")[
      #image("../cover/badge.jpg", height: 10%)
    ],
    figure(caption: "(b) 子图2")[
      #image("../cover/signage.jpg", height: 10%)
    ],
  )
] <fig:test1>

== 表格样式禁用

=== 一般情况

当需要临时禁用表格样式（如伪代码`algo`）时，使用@algo_1 中代码：

#figure(caption: "代码测试", kind: raw)[
  #state("_no-table-style").update(true)
  #code()[
    ```typst
    #state("_no-table-style").update(true)
    ... // 有关内容
    #state("_no-table-style").update(false)
    ```
  ]
  #state("_no-table-style").update(false)
]<algo_1>

#figure(caption: "伪代码测试", kind: raw)[
  #state("_no-table-style").update(true)
  #algo(
    stroke: none,
    fill: none,
    block-align: left,
    title: [#h(-2em) #smallcaps("Function 1")],
    parameters: ($p_0$,),
  )[
    let a $<- [p_0]$ \
    for i in range(10):#i\
    a += 1#d\
  ]
  #state("_no-table-style").update(false)
]<algo_2>

#figure(caption: "非三线表测试表格")[
  #state("_no-table-style").update(true)
  #table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: center + horizon,
    table.header([], [*Area*], [*Parameters*]),
    "圆柱",
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],
  )
  #state("_no-table-style").update(false)
]

=== 更复杂的情况？

如果遇到编译器警告以下情况：

#figure(kind: raw)[
  ```bash
  warning: layout did not converge within 5 attempts
  = hint: check if any states or queries are updating themselves
  ```
]

你可以考虑使用通过在需要的作用域中，加入手动加入结尾的横线的表格渲染规则，来在外层三线表开始处理前结束格式化，如@code-force-table-end 所示。

#figure(caption: "另一种方式", kind: raw)[
  #show table: it => {
    if it.children.len() > 0 and it.children.last().func() == table.hline {
      return it
    }
    let new-children = it.children
    new-children.push(table.hline(stroke: none))
    table(
      columns: it.columns,
      align: it.align,
      column-gutter: it.column-gutter,
      row-gutter: it.row-gutter,
      inset: it.inset,
      stroke: it.stroke,
      ..new-children
    )
  }
  #code()[
    ```typst
    {
      #show table: it => {
        if (
          it.children.len() > 0 and
          it.children.last().func() == table.hline
        ) {
          return it
        }
        let new-children = it.children
        new-children.push(table.hline(stroke: none))
        table(
          columns: it.columns,
          align: it.align,
          column-gutter: it.column-gutter,
          row-gutter: it.row-gutter,
          inset: it.inset,
          stroke: it.stroke,
          ..new-children
        )
      }
      ... // 有关内容
    }
    ```
  ]
]<code-force-table-end>
