// Import the template and utilities
#import "../lib_v2.typ": *

// 1. Initialize global document rules
#show: project.with(
  lang: "ja",
  supplement-lang: "ja",
  heading-numbering: "1.1",
  equation-numbering: "1.1",
)

// 2. Render a compact report header (No separate cover page)
#report-header(
  title: "物理学実験レポート：単振り子の周期と重力加速度の測定",
  student-id: "12345678",
  author: "Typst 太郎",
  date: datetime.today().display(),
  lang: "ja",
)

// 3. Main Body
= 実験目的
本実験では、単振り子の周期を精密に測定することにより、重力加速度 $g$ を実験的に求めることを目的とする。

= 原理
長さ $L$ の糸に質量 $m$ のおもりを吊るした単振り子の微小振動において、運動方程式は以下のように表される。

$
  m L d^2/d t^2 theta = -m g sin theta
$

角度 $theta$ が十分に小さいとき（$sin theta approx theta$）、周期 $T$ は次式で与えられる。

$
  T = 2 pi sqrt(L / g)
$

これより、重力加速度 $g$ は測定値 $L$ と $T$ を用いて以下のように算出される。

$
  g = #ans($4 pi^2 L / T^2$)
$ <eq-g-formula>

= 測定結果
測定に用いた糸の長さは $L = #u("0.800 m")$ であった。
複数回の測定から得られた周期の平均値は $T = #u("1.794 s")$ であった。
式(@eq-g-formula)を用いて重力加速度 $g$ を計算すると、以下の通りとなる。

#crect[
  *重力加速度の測定値* \
  $ g approx #u("9.81 m/s^2") $
]

= 考察
本実験で得られた値 $g = #u("9.81 m/s^2")$ は、標準重力加速度 $g_0 = #u("9.80665 m/s^2")$ と非常によく一致しており、実験誤差の範囲内であった。

#bibliography("ex-refs.bib")
