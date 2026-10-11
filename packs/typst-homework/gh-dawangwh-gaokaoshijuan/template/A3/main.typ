#import "../../core-paper/lib.typ": *
#import "figures.typ": *
#import "paper-config.typ": paper-config

#set-paper-config(paper-config)
#show: apply-paper-config


#spread-layout(
[
  #paper-header()

  #notice[
    #notice-title[注意事项：]
    #notice-item(1)[答卷前，考生务必将自己的姓名、考生号、考场号、座位号填写在答题卡上。]
    #notice-item(2)[回答选择题时，选出每小题答案后，用铅笔把答题卡上对应题目的答案标号涂黑。如需改动，用橡皮擦干净后，再选涂其他答案标号。回答非选择题时，将答案写在答题卡上，写在本试卷上无效。]
    #notice-item(3)[考试结束后，将本试卷和答题卡一并交回。]
  ]

  #Q-section[
    一、选择题：本题共 8 小题，每小题 5 分，共 40 分。在每小题给出的四个选项中，只有一项是符合题目要求的。
  ]

  #Q-choice(1)[
    样本数据 6，8，4，5，12 的中位数为
  ]
  #Q-options(4, 
    (
      [A. 5], [B. 6], [C. 8], [D. 9]
    )
  )


  #Q-choice(2)[
    已知平面向量 $a$，$b$ 不共线，且 $2 a + y b = x a - 3 b$，则
  ]
  #Q-options(2, 
    (
      [A. $x=2, y=-3$], [B. $x=-2, y=3$], 
      [C. $x=2, y=3$],  [D. $x=-2, y=-3$]
    )
  )

  #Q-choice(3)[
    已知集合 $A = {sin(7 pi / 6), cos(5 pi / 3), tan(5 pi / 4)}
    $，$B = {-sqrt(3)/2, -1/2, 1}$，则 $A inter B =$
  ]
  #Q-options(2, column-gap: 2em,
    (
      [A. ${-sqrt(3)/2, -1/2}$], [B. ${-sqrt(3)/2, 1}$], 
      [C. ${-1/2, 1}$], [D. ${-sqrt(3)/2, -1/2, 1}$]
    )
  )

  #Q-choice(4)[
    曲线 $y = 5 x + 8 ln x$ 在点 $(1, 5)$ 处的切线方程为
  ]
  #Q-options(2, (
      [A. $y=3 x+2$], [B. $y=5 x$], 
      [C. $y=8 x-3$], [D. $y=13 x-8$]
    )
  )

  #Q-choice(5)[
    已知抛物线 $C_1: y^2 = 2 p_1 x (p_1 > 0)$ 和 $C_2: x^2 = 2 p_2 y (p_2 > 0)$ 均经过点 $(4, 8)$，则 $C_1$ 的焦点与 $C_2$ 的焦点之间的距离为
  ]
  #Q-options(4, (
      [A. 12], [B. $4 sqrt(5)$], [C. 6], [D. $sqrt(65)/2$]
    )
  )

  #paper-footer(1)
],
[
  #Q-choice(6)[
    已知函数 $f(x) = (x+2)/(a^2+a)$ 的最大值为 1，则 $a =$
  ]
  #Q-options(4, 
    (
      [A. $1/2$], [B. 1], [C. $3/2$], [D. 2]
    )
  )

  #Q-choice(7)[
    一百零八塔位于宁夏回族自治区青铜峡市，以其独特的建筑格局和深远的历史文化闻名遐迩，该塔群共有 108 座塔，依山势自上而下排成 12 行，将第 $i$ 行中塔的座数记为 $a_i (i = 1, 2, dots, 12)$，其中 $a_3 = 1$，$a_1 = a_2 = 3$，$a_5 = a_6 = 5$，且 $a_1, a_2, dots, a_12$ 是一个首项为 7，公差为 2 的等差数列。将 $a_1, a_2, dots, a_12$ 分为 6 组，每组 2 个数，使得每组的 2 个数之和可构成一个项数为 6 且公差为 $d (d > 0)$ 的等差数列，则 $d =$
  ]
  #Q-options(4, 
    (
      [A. 2], [B. 4], [C. 6], [D. 8]
    )
  )

  #Q-choice(8)[
    设 $U = {(x_1, x_2, x_3) | x_i in {-2, -1, 1, 2}, i = 1, 2, 3}$ 为空间中 64 个点构成的集合，点 $P(1, 1, 1)$，记样本空间 $Omega = C_U(P)$。从 $Omega$ 中随机取一个点，定义随机变量 $X$ 如下：对 $Omega$ 中的每个点 $A(x_1, x_2, x_3)$，令 $X(A) = x_1 + x_2 + x_3$，则 $X$ 的数学期望为
  ]
  #Q-options(4, 
    (
      [A. $-1/21$], [B. $-1/63$], [C. 0], [D. $1/7$]
    )
  )

  #Q-section[
    二、选择题：本题共 3 小题，每小题 6 分，共 18 分。在每小题给出的四个选项中，有多项符合题目要求。全部选对的得 6 分，部分选对的得部分分，有选错的得 0 分。
  ]

  #Q-choice(9)[
    设 $z = 3 + 2 i$，则
  ]
  #Q-options(2, 
    (
      [A. $overline(z)=3-2 i$], [B. $abs(z)=5$], [C. $z^2=5+12 i$], [D. $(z+3)/(z-1) in #text(weight: "bold")[R]$]
    )
  )

  #Q-choice(10)[
    在空间中，$A$，$B$ 为两个定点，动点 $C$ 到直线 $A B$ 的距离为 2，动点 $D$ 到直线 $A B$ 的距离为 1。若二面角 $C - A B - D$ 为 60°，则 
  ]
  #Q-options(1, (
    [A. $angle C A D >= 60 degree$],
    [B. $C D >= sqrt(3)$],
    [C. 当 $A B perp C D$ 时，$C D perp$ 平面 $A B D$],
    [D. 当 $A B perp$ 平面 $A C D$ 时，$A C perp A D$],
  ))

  #paper-footer(2)
]
)

#pagebreak()

#spread-layout(
[
  #Q-choice(11)[
    已知圆 $C_1: (x+1)^2 + y^2 = 1$，圆 $C_2: (x-1)^2 + y^2 = 1$，圆 $C_3: x^2 + (y-sqrt(3))^2 = 1$，直线 $l: y = k x + b$ 与 $C_1$，$C_2$，$C_3$ 均有两个交点。记 $l$ 被 $C_1$，$C_2$，$C_3$ 截得的弦长分别为 $s_1$，$s_2$，$s_3$，则
  ]
  #Q-options(1, (
    [A. $k$ 可以取任意实数],
    [B. 满足 $s_1 = s_2 = s_3$ 的直线 $l$ 共有 3 条],
    [C. 满足 $s_1 + s_2 + s_3 = 3$ 的直线 $l$ 多于 3 条],
    [D. 当 $b = 0$ 时，$s_1 + s_2 + s_3$ 的最大值为 $2 sqrt(21) / 3$],
  ))

  #Q-section[
    三、填空题：本题共 3 小题，每小题 5 分，共 15 分。
  ]

  #Q-fill-blank(12)[
    双曲线 $5 x^2 - 6 y^2 = 1$ 的离心率为 #Q-blank-line()。
  ]

  #Q-fill-blank(13)[
    已知 $f(x) = 2 sin(a x + theta)$（$a in ZZ$，$0 <= theta < 2 pi$）是偶函数，$f(x)$ 在区间 $(0, pi/2)$ 单调递增，则 $theta =$ #Q-blank-line()，$f(2 pi / 5) =$ #Q-blank-line()。
  ]

  #Q-fill-blank(14)[
    设实数 $q$ 满足：存在数列 ${a_n}$，使得对于任意 $n in NN^+$，均有 $a_1 + a_2 + dots + a_n = n^2 + n$，且 ${a_n}$ 中有某连续 9 项 $a_i, a_(i+1), dots, a_(i+8)$ 是公比为 $q$ 的等比数列，则 $q$ 的最大值为 #Q-blank-line()。
  ]

  #Q-section[
    四、解答题：本题共 5 小题，共 77 分。解答应写出文字说明、证明过程或演算步骤。
  ]

  #Q-with-figure[
    #Q-answer(15, 13)[
      如图，在直三棱柱 $A B C - A_1 B_1 C_1$ 中，$angle A C B = 90 degree$，$A C = B C$，$D$，$E$ 分别为 $A B$，$A C_1$ 的中点。

      （1）证明：$D E parallel$ 平面 $B C C_1 B_1$；

      （2）设 $C C_1 = 2$，直线 $D E$ 与平面 $A C C_1 A_1$ 所成的角为 45°，求直线 $D E$ 到平面 $B C C_1 B_1$ 的距离。
    ]
  ][#prism-figure]

  #Q-answer(16, 15)[
    已知在 $triangle A B C$ 中，$A B = 3$，$B C = 2 sqrt(3)$，$cos B = -sqrt(3)/3$。

    （1）求 $cos A$；

    （2）设 $D$，$E$ 两点满足：$D$ 在 $B A$ 的延长线上，$D E parallel B C$，$A E perp A C$。若 $D E = sqrt(6)$，求 $C E$。
  ]

  #paper-footer(3)
],
[
  #Q-answer(17, 15)[
    投掷数 $N >= 2$。某同学用一个球进行投篮练习，至多投篮 $N$ 次。当且仅当投中 1 次或 $N$ 次均未投中时，停止练习。设该同学每次投中的概率为 $p (0 < p < 1)$，各次投中与否相互独立。记 $X$ 为停止练习时该同学的投篮次数。

    （1）当 $N = 4$，$p = 1/3$ 时，求 $X$ 的分布列；

    （2）设 $k$，$m$ 均为自然数。

    （i）当 $k <= N - 1$ 时，求 $P(X > k)$；

    （ii）当 $k + m <= N - 1$ 时，证明：$P(X > k + m | X > k) = P(X > m)$。
  ]

  #Q-answer(18, 17)[
    已知椭圆 $C: x^2/a^2 + y^2/b^2 = 1 (a > b > 0)$ 的左焦点为 $F(-1, 0)$，离心率为 $1/2$。

    （1）求 $C$ 的方程；

    （2）设 $O$ 为坐标原点，过 $F$ 且斜率大于 0 的动直线 $l$ 与 $C$ 交于 $P$，$Q$ 两点，其中 $Q$ 在第三象限。直线 $P O$ 与 $C$ 的另一个交点为 $R$。

    （i）若 $triangle P Q R$ 的面积是 $triangle P E O$ 的面积的 3 倍，求 $l$ 的方程；

    （ii）求 $tan angle P Q R$ 的最小值。
  ]

  #Q-answer(19, 17)[
    已知函数 $f(x)$ 的定义域为 $#text(weight: "bold")[R]$，且当 $x < 0$ 时，$f(x) = 2^x$。对任意 $x_0 in #text(weight: "bold")[R]$，定义集合 $D(x_0) = {d in #text(weight: "bold")[R] | f(x_0 + d) > f(x_0)}$。

    （1）若当 $x >= 0$ 时，$f(x) = 1 - x$，求 $D(-1)$；

    （2）若 $f(x)$ 是奇函数，$f(x_1) <= f(x_2)$，且 $x_1 x_2 != 0$，证明：$D(x_1) subset.eq D(x_2)$；

    （3）设 $f(x)$ 满足：① 若 $f(x_1) <= f(x_2)$，则 $D(x_1) subset.eq D(x_2)$；② 当 $0 < x < 1$ 时，$f(x) < f(0)$。

    （i）证明：$f(0) >= 1$；

    （ii）证明：$f(x)$ 在区间 $(0, +infinity)$ 单调递增。
  ]

  #paper-footer(4)
]
)
