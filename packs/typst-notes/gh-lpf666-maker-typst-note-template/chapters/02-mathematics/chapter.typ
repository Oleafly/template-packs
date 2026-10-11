#import "@preview/ergo:0.2.0": *
#import "../../notebook.typ" as nb

#show: nb.notebook.with(
  title: "数学笔记 / Mathematics",
  author: "Your Name",
  short-title: [Chapter 2 · Mathematics],
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
)

#let chapter-content = [
#counter(heading).update(1)
#nb.chapter(
  [数学笔记 / Mathematics],
  subtitle: [展示公式、定义、引理、命题、定理、推论、证明和无证明陈述。],
  key: "ch-math",
)

== 群作用 / Group Actions

#nb.zh-definition[群 / Group][
  A *group* is an ordered pair $(G, star)$ where $star$ is associative, there is an
  identity $e$, and every $a in G$ has an inverse $a^(-1)$.

  群把“可组合、可撤销的对称操作”抽象成一个代数结构。
]

#nb.notation[Stabilizer and orbit][
  对 $x in X$，稳定子与轨道分别记作
  $G_x = {g in G: g dot x = x}$ 与 $G dot x = {g dot x: g in G}$。
]

#nb.lemma[Cosets and images][
  If $a G_x = b G_x$, then $a dot x = b dot x$.
][
  由陪集相等可得 $b^(-1) a in G_x$，所以
  $b^(-1) a dot x = x$，两边作用 $b$ 即得结论。
]

#nb.zh-theorem[轨道-稳定子定理 / Orbit-Stabilizer][
  Let a finite group $G$ act on $X$. For every $x in X$,
  $
    |G dot x| = |G| / |G_x|.
  $
][
  定义 $phi: G / G_x -> G dot x$ 为 $phi(a G_x) = a dot x$。
  上面的引理给出良定义性；同一等价链也给出单射性，而轨道的定义给出满射性。
  因此 $phi$ 是双射。
]

#nb.corollary[Divisibility][
  每个有限群作用的轨道大小都整除 $|G|$。
][
  由轨道-稳定子定理，$|G dot x| = |G| / |G_x|$。
]

#nb.proposition[Unproved statement][
  不需要在笔记中立刻证明的结果，可以把第三个位置参数写成空内容块 `[]`。
][]

#eqbox[$
  |G| = |G_x| dot |G dot x|
$]

== 一个分析例子 / An Analysis Example

#nb.definition[Lipschitz continuity][
  函数 $f: RR -> RR$ 是 $L$-Lipschitz 的，如果对任意 $x,y in RR$，
  $abs(f(x)-f(y)) <= L abs(x-y)$。
]

#nb.example[Contraction][
  若 $0 <= L < 1$，则 $f$ 是压缩映射。迭代 $x_(n+1)=f(x_n)$ 会把相邻误差按至多
  $L$ 的比例缩小。
]

#nb.thm(width: 86%, inline-qed: false)[Geometric error bound][
  If $abs(x_(n+1)-x_n) <= L^n C$ with $0 <= L < 1$, then
  $abs(x_m-x_n) <= C L^n/(1-L)$ for $m > n$.
][
  使用三角不等式并对几何级数求和：
  $
    abs(x_m-x_n)
    <= sum_(k=n)^(m-1) abs(x_(k+1)-x_k)
    <= C sum_(k=n)^infinity L^k
    = (C L^n)/(1-L).
  $
]

== 公式编号与引用 / Numbered Equations

模板会在每章开始时重置公式计数器，并把当前章号作为前缀。给公式末尾添加唯一标签后，
正文中的引用会随章节增删自动更新。

$ cases(
  mat(
    delim: #none,
    a_(1 1) x_1 + a_(1 2) x_2 +, dots.c, + a_(1 n) x_n, = b_1;
    a_(2 1) x_1 + a_(2 2) x_2 +, dots.c, + a_(2 n) x_n, = b_2;
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1) x_1 + a_(n 2) x_2 +, dots.c, + a_(n n) x_n, = b_n;
  )
) $ <eq:ch2-linear-system>

由 #nb.eqref(<eq:ch2-linear-system>) 可知，这是一般的 $n$ 元线性方程组；标签在整本笔记中必须唯一。
]

#chapter-content
