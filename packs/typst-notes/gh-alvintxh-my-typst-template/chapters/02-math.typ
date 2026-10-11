#import "../lib/lib.typ": *

= 数学与物理记号

Typst 的数学模式和 LaTeX 有点像但更省事：变量直接写，多字母的名字要用引号或者
`upright()` 包起来。这一章列出常用写法，以及 `physica` 提供的物理速记。

== 行内与行间

行内公式写 `$E = m c^2$`，出来是 $E = m c^2$；
行间公式在 `$` 两边留空格：`$ E = m c^2 $`。行间公式默认自动编号。

$ nabla times bold(E) = - pdv(bold(B), t) $ <eq:faraday>

引用写 `@eq:faraday`，显示成 @eq:faraday。不想给某个式子编号，用 `#nonum(...)` 包一下：

#nonum($ x^2 + y^2 = r^2 $)

== 多行推导

用 `&` 对齐，`\` 换行。`#why[...]` 可以在某一步右边加一句楷体的说明。

$
  integral_0^infinity x ee^(-a x) dif x
    &= - dv(,a) integral_0^infinity ee^(-a x) dif x #why[对参数求导] \
    &= - dv(,a) (1/a) \
    &= 1/a^2 .
$

想突出某个最终结果，用 `#boxeq(...)`：

#boxeq($ integral_0^infinity x^n ee^(-a x) dif x = (n!) / a^(n+1) $)

== 微分与导数

`physica` 提供了这几个，比手写分数干净得多：

#figure(
  table(
    columns: 2,
    [写法], [效果],
    [`$dv(f, x)$`], [$dv(f, x)$],
    [`$dv(f, x, 2)$`], [$dv(f, x, 2)$],
    [`$pdv(f, x)$`], [$pdv(f, x)$],
    [`$pdv(f, x, y)$`], [$pdv(f, x, y)$],
    [`$dd(x)$`], [$dd(x)$],
    [`$dd(x, y, z)$`], [$dd(x, y, z)$],
    [`$evaluated(f(x))_0^1$`], [$evaluated(f(x))_0^1$],
  ),
  caption: [微分记号],
)

正体的微分号也可以直接用 `#dif`：$integral f(x) dif x$。

== 矢量与场

#figure(
  table(
    columns: 2,
    [写法], [效果],
    [`$vb(E)$` 粗体矢量], [$vb(E)$],
    [`$vu(n)$` 单位矢量], [$vu(n)$],
    [`$va(r)$` 箭头矢量], [$va(r)$],
    [`$grad phi$`], [$grad phi$],
    [`$div vb(E)$`], [$div vb(E)$],
    [`$curl vb(B)$`], [$curl vb(B)$],
    [`$laplacian psi$`], [$laplacian psi$],
    [`$vb(a) dprod vb(b)$`], [$vb(a) dprod vb(b)$],
    [`$vb(a) cprod vb(b)$`], [$vb(a) cprod vb(b)$],
  ),
  caption: [矢量与矢量算符],
)

麦克斯韦方程组写起来就很短：

$
  div vb(E) &= rho / eps0, & curl vb(E) &= - pdv(vb(B), t), \
  div vb(B) &= 0, & curl vb(B) &= mu0 vb(J) + mu0 eps0 pdv(vb(E), t).
$

== 量子力学记号

#figure(
  table(
    columns: 2,
    [写法], [效果],
    [`$ket(psi)$`], [$ket(psi)$],
    [`$bra(phi)$`], [$bra(phi)$],
    [`$braket(phi, psi)$`], [$braket(phi, psi)$],
    [`$ketbra(psi, psi)$`], [$ketbra(psi, psi)$],
    [`$mel(m, H, n)$`], [$mel(m, H, n)$],
    [`$expval(H)$`], [$expval(H)$],
    [`$hbar$`], [$hbar$],
  ),
  caption: [狄拉克符号],
)

含时薛定谔方程：

$ ii hbar pdv(,t) ket(psi(t)) = Ham ket(psi(t)) $

== 矩阵

`mat()` 是内置的，`physica` 另外给了几个常用的：

$
  mat(a, b; c, d), quad
  dmat(lambda_1, lambda_2, lambda_3), quad
  imat(3), quad
  mdet(a, b; c, d)
$

对应写法：`$mat(a, b; c, d)$`、`$dmat(...)$`（对角阵）、`$imat(3)$`（三阶单位阵）、
`$mdet(...)$`（行列式）。另外还有 `zmat`（零阵）、`jmat`（雅可比）、`hmat`（海塞）。

== 数值与单位

用 `#qty()` 排「数值 + 单位」，指数、上下标和空格都会自动处理好：

- `#qty(9.81, "m/s^2")` → #qty(9.81, "m/s^2")
- `#qty(1.602e-19, "C")` → #qty(1.602e-19, "C")
- `#qty(6.626e-34, "J*s")` → #qty(6.626e-34, "J*s")
- `#num(6.022e23)` → #num(6.022e23)
- `#qtyrange(1, 10, "keV")` → #qtyrange(1, 10, "keV")

#warning(title: "单位要正体")[
  单位符号是正体、和数值之间有窄空格，手写 `$9.81 "m/s"^2$` 容易漏掉这些细节。
  能用 `#qty()` 就用它。
]

== 自带的几个记号

`lib/shortcuts.typ` 里定义了一小撮常用量，可以直接在公式里用：
$kB$（`#kB`）、$NA$（`#NA`）、$eps0$（`#eps0`）、$mu0$（`#mu0`）、
$Lag$（`#Lag`）、$Ham$（`#Ham`）、$RR$（`#RR`）、$ii$（`#ii`）、$ee$（`#ee`）。

要加自己的，往 `lib/shortcuts.typ` 里塞一行 `#let 名字 = $...$` 就行。
