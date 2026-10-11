#import "@preview/ergo:0.2.0": *
#import "../../notebook.typ" as nb

#show: nb.notebook.with(
  title: "学习系统 / A Learning System",
  author: "Your Name",
  short-title: [Chapter 1 · Learning System],
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
)

#let chapter-content = [
#counter(heading).update(0)
#nb.chapter(
  [学习系统 / A Learning System],
  subtitle: [用同一章展示双语正文、交叉引用、表格、代码与 Ergo 陈述类环境。],
  key: "ch-learning",
)

#bookmark[本章状态 / Status][Week 1 · 2026-08-03]

#nb.zh-note[中英混排 / Mixed Chinese and English][
  中文正文由 `Songti SC` 排版，Latin text and mathematics use
  `New Computer Modern`。字体列表提供回退，因此术语如 “retrieval practice（提取练习）”
  可以自然地写在同一段中。
]

== 主动回忆 / Active Recall <sec-active-recall>

#nb.concept[Testing effect][
  *主动回忆*不是重读答案，而是在没有提示时尝试重建答案。
  Active recall strengthens retrieval routes by making the learner produce an answer.
]

#nb.zh-definition[间隔 / Spacing][
  把同一知识点的练习分散到多个时间点，而不是集中在一次会话中。
]

#nb.remark[Practical rule][
  当一个问题已经能稳定回答时，延长下一次复习间隔；答错时缩短间隔。
  This is a heuristic, not a claim that one schedule fits everyone.
]

我们会在 @sec-workflow 中把 @sec-active-recall 的原则转化为一个可执行流程。
脚注也可以正常使用：Typst 的交叉引用会随章节重排自动更新。#footnote[
  `include` 负责组合文件；标签与计数器仍属于最终的同一份文档。
]

== 一次学习循环 / One Study Loop <sec-workflow>

#table(
  columns: (auto, 1fr, 1fr),
  inset: 6pt,
  stroke: 0.4pt + luma(78%),
  table.header(
    [*Step*], [*操作 / Action*], [*产物 / Output*],
  ),
  [1], [提出一个可判分的问题], [Question],
  [2], [遮住材料，写出答案], [Answer from memory],
  [3], [对照、订正并标记薄弱点], [Feedback],
  [4], [安排下一次复习], [Next review],
)

#nb.zh-example[原子化卡片 / Atomic card][
  - *Question:* Why does binary search require a monotone predicate?
  - *Answer:* Because discarding half of the search interval is sound only when the
    predicate changes in one direction.
  - *中文提示：* 单调性保证被舍弃的一半不可能含有边界答案。
]

#nb.note(breakable: false)[Source-shaped notes][
  对原始资料做摘录时保留来源链接，例如
  #link("https://typst.app/docs/")[Typst Documentation]；随后再把摘录改写成自己的问题。
]

== 代码与结构 / Code and Structure

下面的伪代码说明如何把复习状态写成一个纯函数；块级代码、行内 `code` 与普通正文
可以混排。

```python
def next_interval(correct: bool, days: int) -> int:
    """Return the next review interval in days."""
    return max(1, round(days * 2.2)) if correct else 1
```

#nb.notation[符号约定][
  用 $I_n$ 表示第 $n$ 次复习前的间隔天数。一个简单模型是
  $I_(n+1) = max(1, round(2.2 I_n))$（答对时）。
]

#correction[订正示例：] 复习间隔不是越长越好；目标是在遗忘前后制造有难度但可完成的提取。
]

#chapter-content
