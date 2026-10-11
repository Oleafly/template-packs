#import "../lib/math.typ": definition, theorem, proof
#import "../lib/style.typ": subimage

= 方法设计

== 总体框架

本章用于介绍论文的方法、模型、系统设计或研究方案。建议先给出总体框架，再分别说明关键模块。若需要插入示意图，可以使用 `figure` 环境，使图注和编号自动生成。

#figure(
  rect(
    width: 80%,
    height: 28mm,
    stroke: 0.8pt,
    inset: 8pt,
  )[
    #align(center + horizon)[方法框架示意图占位]
  ],
  caption: [方法总体框架示例],
)<method_framework>

如 @method_framework 所示，图可以使用外部图片，也可以用 Typst 原生元素绘制。实际写作时，可将上方占位框替换为 `image("path/to/figure.png", width: 80%)`。

== 数学表述

对于需要形式化定义的问题，可以使用定义、定理和证明等辅助函数。

#definition(title: [示例定义])[
  设 $cal(X)$ 为样本空间，$f: cal(X) -> RR$ 为目标函数。若存在参数 $theta$ 使得 $f_theta$ 能够近似 $f$，则称 $f_theta$ 为 $f$ 的一个参数化近似。
]

#theorem(title: [示例定理])[
  若目标函数连续，且模型类具有足够表达能力，则在适当条件下可以构造近似误差较小的参数化模型。
]

#proof[
  这里填写证明过程。若论文不需要定理环境，可以不使用 `lib/math.typ` 中的辅助函数。
]

== 子图示例

当一个图中包含多个子图时，可以使用 `subimage` 辅助函数手动标注 `(a)`、`(b)` 等子图编号。

#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    subimage("a", rect(width: 100%, height: 32mm, stroke: 0.8pt)[#align(center + horizon)[子图 A]]),
    subimage("b", rect(width: 100%, height: 32mm, stroke: 0.8pt)[#align(center + horizon)[子图 B]]),
  ),
  caption: [子图排版示例],
)<subfigure_example>

@subfigure_example 展示了子图的基本写法。若子图标号位置需要微调，可以使用 `label-dx` 参数。

