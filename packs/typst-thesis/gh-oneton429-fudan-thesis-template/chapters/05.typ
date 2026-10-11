= 公式

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

行内公式：$S=pi r^2$

行间公式：

$
  2 & = 1 + 1 \
    & = 2
$
