// ============================================================
//  数学 / 物理速记
//  这里把 physica（微分、矢量、狄拉克符号…）和 unify（数值+单位）
//  整个转出去，再补一些自己常用的。
// ============================================================

// physica 提供：dd dv pdv grad div curl laplacian vb vu va
//               bra ket braket ketbra mel expval Tr Re Im
//               dmat imat jmat hmat mdet order eval tensor isotope …
#import "@preview/physica:0.9.8": *

// unify 提供：num() qty() numrange() qtyrange() —— 数值和单位的规范排版
//   #qty(9.81, "m/s^2")   #num(6.02e23)   #qtyrange(1, 10, "keV")
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange

#import "theme.typ": fonts, palette

// ---------- 正体符号 ----------
// 微分号、自然常数、虚数单位：物理里习惯用正体，跟变量区分开。
#let dif = math.upright("d")
#let ee = math.upright("e")
#let ii = math.upright("i")
#let jj = math.upright("j")

// ---------- 常用常数 ----------
// （约化普朗克常数 hbar 由 physica 提供，直接写 #hbar 或 $planck.reduce$）
#let kB = $k_upright(B)$
#let NA = $N_upright(A)$
#let mu0 = $mu_0$
#let eps0 = $epsilon_0$

// ---------- 常用记号 ----------
#let Lag = $cal(L)$ // 拉格朗日量
#let Ham = $cal(H)$ // 哈密顿量
#let Ord = $cal(O)$ // 量级
#let RR = $bb(R)$
#let CC = $bb(C)$
#let ZZ = $bb(Z)$
#let NN = $bb(N)$

#let deq = $eq.def$ // 定义为
#let conj(x) = $overline(#x)$ // 复共轭
#let herm(x) = $#x^dagger$ // 厄米共轭
#let avg(x) = $angle.l #x angle.r$ // 系综平均
#let abs2(x) = $abs(#x)^2$

// 偏导的紧凑写法：#pd(t) → ∂/∂t
#let pd(x) = $diff / (diff #x)$

// ---------- 不编号的行间公式 ----------
// 用法：#nonum($ x^2 + y^2 = r^2 $)
#let nonum(eq) = {
  set math.equation(numbering: none)
  eq
}

// ---------- 强调一个公式 ----------
// 用法：#boxeq($E = m c^2$)
#let boxeq(body, color: palette.primary) = block(
  width: 100%,
  above: 1.2em,
  below: 1.2em,
  align(
    center,
    box(
      inset: (x: 1em, y: 0.7em),
      radius: 3pt,
      fill: color.lighten(95%),
      stroke: 0.8pt + color.lighten(55%),
      body,
    ),
  ),
)

// ---------- 推导注释 ----------
// 在多行推导里给某一步加说明：$&= ... #why[用了分部积分]$
#let why(body) = text(
  font: fonts.kai,
  size: 0.85em,
  fill: palette.muted,
  [ #h(1em) （#body）],
)
