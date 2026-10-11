#import "../lib.typ": *


= 東工大パワー丼学入門 <ch:powerdon>

== 研究の背景と目的

吾輩は猫である。名前はまだ無い。どこで生まれたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは東工大生という人間中で一番獰悪な種族#todo[文献を入れる。]であったそうだ。


東京工業大学大岡山キャンパスにおける学生の栄養摂取と研究生産性の関係#note[パワー丼食べて]は、長年にわたり多くの研究者の関心を集めてきた#citep(<ArticleJA>)。特に、学食で提供される「パワー丼」は、その高いカロリー密度とニンニク含有量から、学位取得期間との相関が指摘されている#citep(<PhdthesisJA>)。



本章では、パワー丼と猫の関係性を数理的に証明し、実験データによる検証を行う。


== パワー丼・猫相関理論

=== 基本定義

まず、パワー丼の魅力度 $P$ と猫の接近度 $C$ を以下のように定義する。

$ P = alpha dot.op G + beta dot.op M + gamma dot.op T $ <eq:powerdon>

ここで、$G$ はニンニク含有量（g）、$M$ は肉量（g）、$T$ は調理温度（℃）であり、$alpha, beta, gamma$ は重み係数である。#citet(<YearDouble2023a>)によれば、これらの係数は以下の値をとる：

#figure(
  ztable(
    columns: 4,
    align: (left, center, center, center),
    stroke: none,
    inset: (x: 0.8em, y: 0.5em),
    format: (none,none,auto,auto),
    table.hline(stroke: 1pt),
    table.header([*パラメータ*], [*記号*], [*値*], [*単位*]),
    table.hline(stroke: 0.5pt),
    [ニンニク係数], [$alpha$], [2.45], [--],
    [肉量係数], [$beta$], [0.82], [--],
    [温度係数], [$gamma$], [0.15], [℃⁻¹],
    table.hline(stroke: 1pt),
  ),
  caption: [パワー丼魅力度モデルのパラメータ推定値],
) <tab:params>

=== 猫の嗅覚反応モデル

猫の嗅覚反応は、Weber-Fechnerの法則に従うと仮定する#citep(<BookEN>)。パワー丼からの匂い強度 $I$ に対する猫の反応 $R$ は：

$ R = k dot.op ln(I / I_0) $ <eq:weber>

ここで $I_0$ は検知閾値、$k$ は猫種依存の感度係数である。

=== パワー丼-猫定理

#block(
  fill: rgb("#f0f9ff"),
  stroke: 1pt + rgb("#0284c7"),
  inset: 1.2em,
  radius: 6pt,
  width: 100%
)[
  *定理 3.1（パワー丼-猫誘引定理）*
  
  パワー丼の魅力度 $P$ が臨界値 $P^*$ を超えるとき、半径 $r$ 以内に存在する猫の期待個体数 $E[N]$ は以下を満たす：
  
  $ E[N] = lambda dot.op pi r^2 dot.op (1 - e^(-mu(P - P^*))) $
  
  ただし $lambda$ は猫の空間密度、$mu$ は誘引係数である。
]

#v(1em)

*証明*　パワー丼から距離 $d$ における匂い強度は、拡散方程式の解として：

$ I(d) = frac(Q, 4 pi D d) exp(-d / L) $

と表される。ここで $Q$ は匂い放出率、$D$ は拡散係数、$L$ は特性長さである。

猫が誘引される条件は $R > R_"thresh"$ であり、@eq:weber を代入すると：

$ k ln(I(d) / I_0) > R_"thresh" $

これを $d$ について解くと、誘引範囲 $d < d_"max"$ が得られる。Poisson点過程を仮定すれば、期待個体数の式が導かれる。#h(1fr)$square.stroked$

== 実験的検証

=== 実験方法
#citet(<ArticleJA>)の調査データを用いて、パワー丼販売量と猫目撃数の相関を分析した。データ収集期間は2022年4月から2024年3月までの2年間である。

#figure(
  {
    ztable(
      columns: 5,
      align: (left, center, center, center, center),
      stroke: none,
      inset: (x: 0.8em, y: 0.5em),
      format: (none, none, none, (digits: 3), auto),  // 場所=text, 販売数=text, 猫目撃数=text, r=3桁, p=text
      
      table.hline(stroke: 1pt),
      table.header([*場所*], [*販売数*], [*猫目撃数*], [*$r$*], [*$p$*]),
      table.hline(stroke: 0.5pt),
      [第2食堂前], [$245 ± 32$], [$8.2 ± 1.4$], [0.847], [$<$#no-lead(0.001)],
      [本館裏], [--], [$3.1 ± 0.8$], [--], [--],
      [西8号館], [$565 ± 42$], [$1.5 ± 0.6$], [0.457], [#hide($<$)#no-lead(0.124)],
      [大岡山駅前], [--], [$0.8 ± 0.3$], [--], [--],
      table.hline(stroke: 1pt),
    )
  },
  caption: [キャンパス各地点における猫目撃数とパワー丼販売との関係（日平均）],
) <tab:observation>



@tab:observation が示すように、パワー丼販売地点である第2食堂前において、猫の目撃数が有意に高いことが確認された。

=== 時系列分析

昼食時間帯（11:30〜13:30）におけるパワー丼調理開始からの時間 $t$（分）と猫出現確率 $p(t)$ の関係を@fig:timeseries に示す。

#figure(
  block(
    fill: luma(245),
    stroke: 0.5pt + luma(200),
    inset: 2em,
    radius: 4pt,
    width: 80%,
  )[
    #align(center)[
      #text(size: 9pt, fill: luma(120))[
        【グラフ：パワー丼調理開始後の猫出現確率】\
        横軸：時間 $t$（分）、縦軸：猫出現確率 $p(t)$\
        \
        $t = 0$分で調理開始 → $t = 5$分で匂い拡散開始\
        → $t = 12$分でピーク（$p = 0.73$）\
        → $t = 30$分で平衡状態（$p = 0.45$）
      ]
    ]
  ],
  caption: [パワー丼調理開始後の猫出現確率の時間変化],
) <fig:timeseries>

この結果は、匂いの拡散時間と猫の移動速度を考慮した理論予測と良く一致する#citep(<InproceedingsJA>)。

== ニンニク含有量の最適化

=== 目的関数

猫の誘引を最大化しつつ、学生のニンニク臭による社会的コストを最小化する多目的最適化問題を考える：

$ max_(G) quad & J_1(G) = E[N(G)] $
$ min_(G) quad & J_2(G) = integral_0^T c(G, t) dif t $

ここで $c(G, t)$ はニンニク摂取量 $G$ による時刻 $t$ における社会的コスト関数である。

=== Pareto最適解

#citet(<ThirtyAuthorsJA>)による大規模最適化研究では、Pareto最適フロントが以下の形式で近似できることが示された：

$ J_2 = a dot.op J_1^2 + b dot.op J_1 + c $
#figure(
  {ztable(
    columns: 4,
    align: (center, center, center, center),
    stroke: none,
    inset: (x: 0.8em, y: 0.5em),
    
    // --- ADD THIS LINE ---
    // Col 1: auto (detects number), Col 2&3: 1 decimal, Col 4: none (text/symbols)
    format: (auto, (digits: 1), (digits: 1), none), 
    
    table.hline(stroke: 1pt),
    table.header([*$G$ (g)*], [*$E[N]$*], [*$J_2$*], [*Pareto*]),
    table.hline(stroke: 0.5pt),
    
    [5], [1.2], [0.8], [○],
    [10], [2.8], [1.5], [○],
    [15], [4.1], [2.9], [○],
    table.hline(stroke: 0.3pt),
    [20], [4.8], [5.2], [×],
    [25], [5.0], [8.1], [×],
    table.hline(stroke: 1pt),
  )
    set align(left)
    set par(first-line-indent: 0pt)
    text(size: 9pt)[注. $G$: ニンニク量、$E[N]$: 猫誘引数、$J_2$: 社会コスト]
  },
  caption: [ニンニク含有量とPareto効率性],
) <tab:pareto>

@tab:pareto より、ニンニク量15g以下が Pareto最適であることがわかる。

== 猫の行動パターン分類

=== 観察データ

24時間の行動観察により、パワー丼に対する猫の反応を4類型に分類した。

#figure(
  table(
    columns: 3,
    align: (left, center, left),
    stroke: none,
    inset: (x: 0.8em, y: 0.5em),
    table.hline(stroke: 1pt),
    table.header([*行動類型*], [*頻度*], [*特徴*]),
    table.hline(stroke: 0.5pt),
    [積極接近型], [35%], [匂いを感知後、直線的に接近],
    [慎重観察型], [28%], [一定距離を保ちつつ観察],
    [間接獲得型], [22%], [学生が残した残飯を狙う],
    [無関心型], [15%], [パワー丼に反応しない],
    table.hline(stroke: 1pt),
  ),
  caption: [パワー丼に対する猫の行動類型分布],
) <tab:behavior>

=== 検定結果

各類型の出現頻度が均等分布に従うという帰無仮説を検定した：

$ chi^2 = sum_(i=1)^4 frac((O_i - E_i)^2, E_i) = 12.8 $

自由度3の$chi^2$分布において、$p = .005$ であり、帰無仮説は棄却される。すなわち、猫の行動類型には有意な偏りが存在する#citep(<InbookEN>)。

== エネルギー収支モデル

猫がパワー丼を獲得するために消費するエネルギー $E_"cost"$ と、獲得した場合の期待エネルギー収入 $E_"gain"$ の収支を考える。

$ Delta E = p_"success" dot.op E_"gain" - E_"cost" $

#block(
  fill: rgb("#fef3c7"),
  stroke: 1pt + rgb("#d97706"),
  inset: 1.2em,
  radius: 6pt,
  width: 100%
)[
  *系 5.1（最適採餌戦略）*
  
  猫が合理的採餌者であると仮定すると、接近行動を取る条件は：
  
  $ p_"success" > frac(E_"cost", E_"gain") = frac(m dot.op g dot.op h + 1/2 m v^2, epsilon dot.op M_"don") $
  
  ここで $m$ は猫の体重、$h$ は移動に伴う高度変化、$v$ は接近速度、$epsilon$ は消化効率、$M_"don"$ はパワー丼のエネルギー量である。
]

== 文献レビュー

#citet(<ThirtyAuthorsTest>)による国際共同研究では、パワー丼類似食品と猫の関係が世界各地で報告されている。#citet(<BookENSingle>)の理論的枠組みと、#citet(<BookJASingle>)の実地調査を統合したアプローチが有効である。

動物行動学的には、#citet(<IncollectionEN>)による睡眠不足研究や、#citet(<ConferenceJA>)による感情制御研究からの知見が応用可能である。技術的側面では、#citet(<ManualEN>)のTSUBAMEマニュアルに記載されたシミュレーション手法が参考になる。

== 考察

本章で示した理論的フレームワークと実験的エビデンスは、パワー丼と猫の間に統計的に有意な関係が存在することを強く示唆している。

@eq:powerdon と @eq:weber を組み合わせることで、任意のパワー丼配合に対する猫誘引効果を予測することが可能となる。@tab:observation の結果は、この予測モデルの妥当性を支持している。

吾輩は猫である以上、この研究の被験者でもあり観察者でもあるという二重の立場にある。これは科学哲学的に興味深い問題を提起する#citep(<IncollectionEditionOnly>)。

== 結論

本研究により、以下の結論が得られた：

+ パワー丼の魅力度は @eq:powerdon によりモデル化できる
+ 猫の誘引範囲は定理3.1により定量的に予測可能である
+ 最適ニンニク量は15g以下である（@tab:pareto）
+ 猫の行動類型には有意な偏りが存在する（$chi^2 = 12.8, p = .005$）

今後の課題として、季節変動の組み込み、複数食堂間の競合モデル、および猫の個体差を考慮した拡張モデルの開発が挙げられる。
