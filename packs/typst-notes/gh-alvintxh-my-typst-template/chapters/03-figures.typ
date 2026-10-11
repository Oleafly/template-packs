#import "../lib/lib.typ": *

= 图片与作图

插图有两条路：外部图片文件用 `image()`，示意图直接在文档里画。
后者的好处是字体、线宽和正文一致，改起来也不用切工具。

== 插入图片文件

图片放 `figures/` 目录，然后：

```typ
#figure(
  image("../figures/sample-plot.png", width: 70%),
  caption: [从外部文件插入的图],
) <fig:sample>
```

#figure(
  image("../figures/sample-plot.png", width: 62%),
  caption: [外部图片文件（这张其实也是 Typst 画的）],
) <fig:sample>

`width` 用百分比是相对正文宽度。支持 PNG、JPEG、GIF、SVG 和 PDF。
引用写 `@fig:sample`，显示成 @fig:sample。

== 两张图并排

#figure(
  side-by-side(
    canvas({
      import cetz.draw: *
      axes(x: 2.6, y: 1.8, xlabel: $t$, ylabel: $x$)
      line((0, 0), (2.3, 1.6), stroke: palette.primary + 1.2pt)
    }),
    canvas({
      import cetz.draw: *
      axes(x: 2.6, y: 1.8, xlabel: $t$, ylabel: $v$)
      line((0, 1.1), (2.3, 1.1), stroke: palette.example + 1.2pt)
    }),
  ),
  caption: [匀速运动的 $x$–$t$ 图和 $v$–$t$ 图],
)

== 用 cetz 画示意图

`#canvas({ ... })` 里 `import cetz.draw: *` 之后就能用 `line`、`circle`、`rect`、
`content`、`arc` 这些。坐标是 `(x, y)`，默认 1 单位 = 1cm。

#figure(
  canvas({
    import cetz.draw: *
    let th = 31deg
    // 斜面
    line((0, 0), (4.2, 0), (4.2, 2.52), close: true, fill: rgb("#eef2f6"), stroke: 0.8pt)
    arc((0.95, 0), start: 0deg, stop: th, radius: 0.95, stroke: 0.6pt)
    content((1.15, 0.24), text(size: 8pt)[$theta$], anchor: "west")
    // 贴在斜面上的物块（把坐标系转到斜面方向再画）
    group({
      set-origin((2.5, 1.5))
      rotate(th)
      rect((-0.42, 0), (0.42, 0.6), fill: palette.primary.lighten(75%), stroke: 0.8pt + palette.primary)
    })
    // 三个力都从物块质心出发
    let o = (2.35, 1.76)
    line(o, (rel: (0, -1.15)), mark: arrow-style, stroke: 0.9pt)
    content((2.45, 1.1), text(size: 8pt)[$m vb(g)$], anchor: "west")
    line(o, (rel: (-0.52, 0.86)), mark: arrow-style, stroke: 0.9pt + palette.definition)
    content((1.72, 2.72), text(size: 8pt)[$vb(N)$], anchor: "east")
    line(o, (rel: (0.73, 0.44)), mark: arrow-style, stroke: 0.9pt + palette.example)
    content((3.18, 2.28), text(size: 8pt)[$vb(f)$], anchor: "west")
  }),
  caption: [斜面上物块的受力分析],
) <fig:incline>

模板里预置了 `#axes(x:, y:, xlabel:, ylabel:)` 画坐标轴，
和 `#arrow-style` 这个箭头样式，省得每次重复写。

== 画函数图

`cetz-plot` 负责有刻度的正经图。

#figure(
  canvas({
    import cetz.draw: *
    cetz-plot.plot.plot(
      size: (8, 4.4),
      x-label: $x$,
      y-label: $y$,
      x-tick-step: 2,
      y-tick-step: 0.5,
      legend: "inner-north-east",
      {
        cetz-plot.plot.add(
          domain: (0, 8),
          samples: 120,
          style: (stroke: palette.primary + 1.2pt),
          label: $ee^(-x slash 4) cos(2 x)$,
          x => calc.exp(-x / 4) * calc.cos(2 * x),
        )
        cetz-plot.plot.add(
          domain: (0, 8),
          samples: 60,
          style: (stroke: (paint: palette.danger, dash: "dashed")),
          label: $plus.minus ee^(-x slash 4)$,
          x => calc.exp(-x / 4),
        )
      },
    )
  }),
  caption: [欠阻尼振动的位移与包络线],
) <fig:damped>

== 节点图

`fletcher` 适合能级图、流程图、方框图这类由「节点 + 箭头」组成的图。

#figure(
  diagram(
    spacing: (10mm, 20mm),
    node-stroke: 0.7pt,
    node((0, 1), [基态 $E_0$], fill: palette.primary.lighten(88%)),
    node((0, 0), [激发态 $E_1$], fill: palette.example.lighten(85%)),
    edge((0, 1), (0, 0), "->", bend: 32deg, label: [吸收 $h nu$], label-side: left),
    edge((0, 0), (0, 1), "->", bend: 32deg, label: [自发辐射], label-side: left),
  ),
  caption: [二能级系统],
) <fig:two-level>

#figure(
  diagram(
    spacing: 16mm,
    node-stroke: 0.7pt,
    node((0, 0), [测量]),
    edge("->"),
    node((1, 0), [拟合]),
    edge("->"),
    node((2, 0), [模型]),
    edge((2, 0), (0, 0), "->", bend: 55deg, label: [修正], label-side: right),
  ),
  caption: [一个循环],
)

#tip[
  cetz 和 fletcher 的完整文档在 #link("https://typst.app/universe/package/cetz")[typst universe]
  上，画不出来的时候去翻例子最快。
]

== 图注和编号

图、表、代码块各有一套按章重置的编号（@fig:incline 是第三章第三张图）。
题注默认在图下方、表格上方。想调整措辞或字号，改 `lib/template.typ` 里
`show figure.caption` 那一段。
