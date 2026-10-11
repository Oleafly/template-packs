#import "@preview/ergo:0.2.0": *
#import "../../notebook.typ" as nb

#show: nb.notebook.with(
  title: "算法笔记 / Algorithms",
  author: "Your Name",
  short-title: [Chapter 3 · Algorithms],
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
)

#let chapter-content = [
#counter(heading).update(2)
#nb.chapter(
  [算法笔记 / Algorithms],
  subtitle: [展示算法、复杂度、计算问题、带自动编号的问题与练习，以及局部主题覆盖。],
  key: "ch-algorithms",
)

== 二分答案 / Binary Search on the Answer

#nb.comp-prob[First true position][
  给定一个布尔谓词 $P(0), dots, P(n-1)$，它先为 `false` 后为 `true`。
  求最小的 $i$ 使 $P(i)$ 为 `true`；若不存在则返回 $n$。
]

#nb.algo[Half-open interval algorithm][
  维护半开区间 $[l,r)$，并保持 $[0,l)$ 全部为假、$[r,n)$ 全部为真。

  ```text
  l = 0; r = n
  while l < r:
      m = l + (r - l) // 2
      if P(m): r = m
      else:    l = m + 1
  return l
  ```
]

#nb.runtime[Time and space][
  每轮把候选区间至少减半，因此时间复杂度是 $O(log n)$；若 $P$ 的求值成本为
  $T_P$，总时间为 $O(T_P log n)$。额外空间为 $O(1)$。
]

#nb.zh-note[Invariant / 循环不变式][
  The implementation becomes easier to verify once the two discarded regions are
  stated explicitly. 先写不变式，再写更新分支。
]

== 题目与解答 / Problems and Solutions

#nb.prob[
  在数组 `(1, 3, 3, 7, 9)` 中寻找第一个大于等于 `3` 的位置。
][
  取谓词 $P(i) := a_i >= 3$。序列为“假、真、真、真、真”，第一处为下标 $1$。
]

#nb.prob(
  colors: ergo-colors.primer-light,
  styles: ergo-styles.tab2,
  breakable: false,
  inline-qed: false,
)[Local override / 局部覆盖][
  说明为什么中点应写成 `l + (r-l)/2` 的形式。
][
  在固定宽度整数中，它避免直接计算 `l+r` 时可能发生的溢出。
  本块还独立覆盖了颜色、样式、分页与 Q.E.D. 位置；题号由模板包装器统一管理。
]

#nb.excs[Loop invariant][
  为上面的半开区间算法写出初始化、保持与终止三部分证明。
][
  初始化时两个已排除区域都为空；每个分支依据 $P(m)$ 排除一个正确区域；
  终止时 $l=r$，不变式迫使该点成为第一处真值。
]

#nb.zh-problem[带中文标题的问题 / Named problem][
  若谓词从未为真，算法返回什么？
][
  返回哨兵位置 $n$。显式标题会显示在自动生成的 Problem 3.x 题号之后。
]

== 从图到表 / A Small Comparison

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  block(fill: rgb("#eef5ff"), inset: 10pt, radius: 4pt)[
    *Linear scan* \
    无需单调性 \
    $O(n)$ predicate calls
  ],
  block(fill: rgb("#eefaf3"), inset: 10pt, radius: 4pt)[
    *Binary search* \
    需要单调性 \
    $O(log n)$ predicate calls
  ],
)
]

#chapter-content
