// 数学作业通用模板
#set document(title: "数学作业", author: "")

// 页面设置
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 3cm),
  numbering: "1",
)

// 字体设置
#set text(
  font: ("New Computer Modern", "Songti SC", "STSong"),
  size: 11pt,
  lang: "zh",
)

// 段落设置
#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 2em,
)

// 标题设置
#set heading(numbering: "1.1")
#show heading: it => {
  set text(weight: "bold")
  it
  v(0.5em)
}

// 数学公式设置
#set math.equation(numbering: "(1)")

// 定义定理环境样式
#let theorem_box(title, content, color: blue) = {
  block(
    fill: color.lighten(95%),
    stroke: 1pt + color,
    radius: 4pt,
    inset: 10pt,
    width: 100%,
  )[
    #text(weight: "bold", fill: color)[#title]
    #v(0.3em)
    #content
  ]
}

// 定理环境
#let theorem(title: "定理", content) = {
  theorem_box(title, content, color: rgb("#1f77b4"))
}

// 引理环境
#let lemma(title: "引理", content) = {
  theorem_box(title, content, color: rgb("#ff7f0e"))
}

// 定义环境
#let definition(title: "定义", content) = {
  theorem_box(title, content, color: rgb("#2ca02c"))
}

// 命题环境
#let proposition(title: "命题", content) = {
  theorem_box(title, content, color: rgb("#d62728"))
}

// 推论环境
#let corollary(title: "推论", content) = {
  theorem_box(title, content, color: rgb("#9467bd"))
}

// 例子环境
#let example(title: "例子", content) = {
  theorem_box(title, content, color: rgb("#8c564b"))
}

// 注记环境
#let remark(title: "注", content) = {
  theorem_box(title, content, color: rgb("#7f7f7f"))
}

// 证明环境
#let proof(content) = {
  block(
    inset: (left: 1em, right: 0em, top: 0.5em, bottom: 0.5em),
  )[
    #text(weight: "bold")[证明：]
    #content
    #h(1fr) $qed$
  ]
}

// ==================== 代码和附录环境 ====================

// 代码块环境
#let code_block(content, language: none, caption: none) = {
  block(
    fill: rgb("#f5f5f5"),
    stroke: 1pt + rgb("#e0e0e0"),
    radius: 3pt,
    inset: 10pt,
    width: 100%,
  )[
    #if caption != none [
      #text(weight: "bold", size: 10pt)[#caption]
      #v(0.3em)
    ]
    #set text(font: ("Consolas", "Courier New"), size: 9pt)
    #content
  ]
}

// 附录标题
#let appendix_title(title) = {
  pagebreak()
  set text(size: 18pt, weight: "bold")
  align(center)[
    #title
  ]
  v(1em)
}

// 附录章节
#let appendix_section(title, content) = {
  block(
    inset: (top: 1em, bottom: 0.5em),
  )[
    #text(size: 14pt, weight: "bold")[#title]
  ]
  content
}

// 问题环境
#let problem(number, content) = {
  block(
    fill: rgb("#f0f0f0"),
    stroke: 1pt + gray,
    radius: 4pt,
    inset: 10pt,
    width: 100%,
  )[
    #text(weight: "bold", size: 12pt)[问题 #number]
    #v(0.3em)
    #content
  ]
}

// 解答环境
#let solution(content) = {
  block(
    inset: (left: 1em, right: 0em, top: 0.5em, bottom: 1em),
  )[
    #text(weight: "bold")[解：]
    #content
  ]
}

// ==================== 正文开始 ====================

// 标题页
#align(center)[
  #text(size: 20pt, weight: "bold")[优化作业四]
  
  #v(1em)
  
  #text(size: 14pt)[
    姓名：张三 \
    学号：20233000
  ]
  
  #v(0.5em)
  
  #text(size: 12pt)[
    提交日期：2025年11月4日
  ]
]

#v(2em)

// ==================== 作业内容 ====================

#problem("1")[
  若在点 $x^*$ 处 KKT 条件满足，$ {a_i (x^*), i in I^* union E} $ 线性无关，证明：$x^*$ 对应的 Lagrange 乘子 $lambda^*$ 唯一。
]

#solution[
  假设存在两组满足 KKT 条件的乘子 $(lambda^(1), mu^(1))$ 和 $(lambda^(2), mu^(2))$，其中 $lambda^(k) = (lambda_i^(k), i in I)$ 为不等式约束的乘子，$mu^(k) = (mu_j^(k), j in E)$ 为等式约束的乘子，$k = 1, 2$。
  
  由 KKT 条件的梯度条件，有：
  $ nabla f(x^*) + sum_(i in I^*) lambda_i^(1) a_i (x^*) + sum_(j in E) mu_j^(1) a_j (x^*) = 0 $
  
  $ nabla f(x^*) + sum_(i in I^*) lambda_i^(2) a_i (x^*) + sum_(j in E) mu_j^(2) a_j (x^*) = 0 $
  
  两式相减，得：
  $ sum_(i in I^*) (lambda_i^(1) - lambda_i^(2)) a_i (x^*) + sum_(j in E) (mu_j^(1) - mu_j^(2)) a_j (x^*) = 0 $
  
  由于 $ {a_i (x^*), i in I^* union E} $ 线性无关，因此：
  $ lambda_i^(1) - lambda_i^(2) = 0, quad i in I^*; quad mu_j^(1) - mu_j^(2) = 0, quad j in E $
  
  即 $lambda_i^(1) = lambda_i^(2)$ 对 $i in I^*$，$mu_j^(1) = mu_j^(2)$ 对 $j in E$。
  
  对于 $i in I backslash I^*$（不起作用的不等式约束），由互补松弛条件知对应的约束未起作用，因此 $lambda_i^(1) = lambda_i^(2) = 0$。
  
  综上，$(lambda^(1), mu^(1)) = (lambda^(2), mu^(2))$，即 Lagrange 乘子唯一。
]
