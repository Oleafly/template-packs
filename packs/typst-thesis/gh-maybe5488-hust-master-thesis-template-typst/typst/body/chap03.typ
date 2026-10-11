#import "../hust-thesis.typ": *

#hust-chapter[XX问题的随机近似]

#heading(level: 2)[最优解的结构分析] <sec:3-optimal>

#figure(
[
#grid(columns: (1fr,), row-gutter: 8pt,
  subfigure("../assets/fig2subat.svg", [(a) 成本函数 $o d d(t)$ 和 $e v e n(t)$], width: 255.64pt),
  subfigure("../assets/fig2subbt.svg", [(b) 状态函数 $s(t)$], width: 278.35pt),
)
], caption: [成本函数$o d d\(t\)$，$e v e n\(t\)$ 和状态函数$s\(t\)$], supplement: [图]) <fig:Cost_State>

接下来，对每个独立片段都可以定义其#emph[状态函数]：

#math.equation(block: true, numbering: none)[$s(t) = cases(frac(o d d(t) - e v e n(t) + 1, 2) & "若" d "为奇", frac(e v e n(t) - o d d(t) + 1, 2) & "若" d "为偶")$]

假设片段开始为$0$时刻，$d$是到$t$时刻为止（包括$t$时刻）所到达的请求对数量。在图~#ref(<fig:phase_partition>, supplement: none)中展示了一个样例，七个请求对的序列被划分为$3$个独立片段。在每个独立片段的每个请求对中，红色线段的长度等于该请求对的状态值。

#figure(
[
#image("../assets/phase_partition.svg", width: 383.96pt)
], caption: [独立片段识别样例], supplement: [图]) <fig:phase_partition>

注意到算法~#strong[??]中使用请求对的状态值来识别独立片段，下面将状态值和状态函数之间建立联系，即证明$s\(t_i\)= S_i$ 。

#hust-theorem("lemma", "引理")[
对任意独立片段$f =\(f_1\,dots.h.c\,f_k\)$和其中的任一请求对$f_1 lt.eq i lt.eq f_k$, 有$s\(t_i\)= S_i$。
] <state-value>

#hust-proof[
考虑 $i gt.eq 2$。如果 $i - f_1$ 是奇数，在时间区间 $\(t_(i - 1)\,t_i\]$ 内，$o d d\(dot.op\)$ 不变，而 $e v e n\(dot.op\)$ 增加了 $2 l_(i - 1)$。因此可推出，

#math.equation(block: true, numbering: none)[$s\(t_i\) & =\(e v e n\(t_i\)- o d d\(t_i\)+ 1\)\/2 =\(e v e n\(t_(i - 1)\)+ 2 l_(i - 1) - o d d\(t_(i - 1)\)+ 1\)\/2\
 & = 1 -\(o d d\(t_(i - 1)\)- e v e n\(t_(i - 1)\)+ 1\)\/2 + l_(i - 1) = 1 - s\(t_(i - 1)\)+ l_(i - 1) .$]

对于每个独立片段 $f =\(f_1\,dots.h.c\,f_k\)$，状态函数在时间间隔 $\[t_(i - 1)\,t_i\]$ 中以单位速率减少。在最后一对 $f_k$ 独立片段之后，令 $t_u$ 为状态函数最早变为 $0$ 的时刻，即 $s\(t_u\)= 0$。显然，$t_u = t_(f_k) + s\(f_k\)$。为了完善定义，在 $t_u$ 之后，让 $s\(dot.op\)$ 保持 $0$，直到下一个独立片段开始。称 $t_u$ 为独立片段 $f$ 的结束时间。由此可以定义几何量 $L_f := t_u - t_(f_1)$ 为独立片段 $f$ 的长度。证毕。
]

可以发现，对于每个独立片段$f =\(f_1\,dots.h.c\,f_k\)$，状态函数在时间间隔$\[t_(i - 1)\,t_i\]$中以单位速率减少。在最后一对$f_k$独立片段之后，令$t_u$为状态函数最早变为$0$的时刻，也就是$s\(t_u\)= 0$。 显然，$t_u = t_(f_k) + s\(f_k\)$。为了完善定义，在$t_u$之后，让$s\(dot.op\)$保持$0$，直到下一个独立片段开始。称$t_u$为独立片段$f$的结束时间。由此可以定义几何量$L_f := t_u - t_(f_1)$为独立片段$f$的长度。

在前文的基础上，定义了一个离线算法TOPI（独立片段识别算法）。该算法的输入是一个序列，首先使用算法#strong[??]获得独立片段。对于每个独立片段，如果它是一个独立偶片段，则使用$upright(M a t c h)_(e v e n)$ 进行处理；否则采用$upright(M a t c h)_(o d d)$ 处理。以下定理证明算法TOPI 是最优的。

#hust-theorem("theorem", "定理")[
独立片段识别算法 TOPI 为 2-MPMD 问题的最优离线算法。
] <thm:algorithmPI>

#hust-proof[
考虑一个序列$R_p =\(p_1\,dots.h.c\,p_n\)$。定义一个切片序列$R\[i\]$为包含前$i$个请求对的子序列，即$R\[i\]:=\(p_1\,p_2\,dots.h.c\,p_i\)$。令$R\[0\]$表示空序列。 对于任意切片序列$R\[i\]$，如果TOPI 能在其上产生最优解，则称该切片序列是可验证的。同时，令$T O P I\(R\[i\]\)$表示TOPI 在$R\[i\]$上的解所产生的总成本。接下来归纳法作进行证明。

#emph[基础情形：] $T O P I\(R\[0\]\)= 0$，且 $T O P I\(R\[1\]\)= C o s t\({ mono(I n t e r n a l)\(p_1\)}\)$， $R\[0\]$和$R\[1\]$是可验证的。

#emph[归纳假设：]假设 $R\[i - 1\]$ 和 $R\[i - 2\]$ 都是可验证的。

#emph[归纳证明：] 现在验证 $R\[i\]$。考虑序列 $R\[i\]$中最后一个请求对$p_i$。令 $f =\(f_1\,dots.h.c\,f_k\)$ 为 TOPI 算法在解 $R\[i\]$ 中包含 $p_i$ 的独立片段。由于 $R\[i\]$ 的最优解必须匹配请求对 $q_j$，因此存在两种可能的匹配情况：

#enum(numbering: "(1)",
[$upright(O P T)$ 外部匹配$p_(i - 1)$ 和 $p_i$，之后 $upright(O P T)\(R\[i\]\)= T O P I\(R\[i - 2\]\)+ 2 l_(i - 1)$。
],
[$upright(O P T)$ 内部匹配$p_i$ ，之后 $upright(O P T)\(R\[i\]\)= T O P I\(R\[i - 1\]\)+ 1$。
]
)

注意算法~#strong[??]中，当一个新的请求对到达时，有两个不同的选项:

#enum(numbering: "(a)",
[将其添加到当前片段中，然后通过子程序执行$mono(E x t e r n a l)\(p_(i - 1)\,p_i\)$。这对应于情况(1)，即$T O P I\(R\[i\]\)= T O P I\(R\[i - 2\]\)+ 2 l_(i - 1)$。
],
[开始一个新的片段，然后通过子程序执行$mono(I n t e r n a l)\(p_i\)$。这对应于情况(2)，即$T O P I\(R\[i\]\)= T O P I\(R\[i - 1\]\)+ 1$。
]
)

考虑在独立片段$f$中的最后一对点$p_i$。不失一般性，假设$i - f_1$是奇数。需要证明TOPI 对于$p_i$的决策是最优的。 假设对于$p_i$选择了选项(a)。根据子程序~#strong[??]，条件$l_(i - 1) < s\(t_(i - 1)\)$成立。

因此可推出，

#math.equation(block: true, numbering: none)[$&  & l_(i - 1) & < s\(t_(i - 1)\)$]
#math.equation(block: true, numbering: none)[$& arrow.r.double & e v e n_f\(t_(i - 1)\)- o d d_f\(t_(i - 1)\) & < 1 - 2 l_(i - 1)$]
#math.equation(block: true, numbering: hust-equation-number)[$& arrow.r.double & e v e n_f\(t_(i - 2)\)- o d d_f\(t_(i - 1)\) & < 1 - 2 l_(i - 1)$] <eq:oddeven>

依据假设$i - f_1$为奇数，因此$R\[i - 2\]$为独立偶片段,$R\[i - 1\]$为独立奇片段。此前定义有TOPI 在独立片段的成本函数，对应为$e v e n_f\(t_(i - 2)\)$和$o d d_f\(t_(i - 1)$，因此可推出：

#math.equation(block: true, numbering: hust-equation-number)[$& e v e n_f\(t_(i - 2)\)- o d d_f\(t_(i - 1)\)= T O P I\(R\[i - 2\]\)- T O P I\(R\[i - 1\]\)$] <eq:topi>

结合不等式#ref(<eq:oddeven>, supplement: none)和等式#ref(<eq:topi>, supplement: none)，有：

#math.equation(block: true, numbering: hust-equation-number)[$T O P I\(R\[i - 2\]\)+ 2 l_(i - 1) & < T O P I\(R\[i - 1\]\)+ 1$] <eq:topi2>

即选项(a)比选项(b)更好。

因此，算法TOPI 对每一个请求对始终选择最优匹配，最终产生最优解。证毕。
]

注意到从算法#strong[??]中得到的片段是与成本无关的。全局最优解等于每个独立片段的局部最优解的组合。这也是"独立片段"这个术语的起源。对于单个独立片段，下面的引理表明其长度等于其最优解的成本。这个结论在后续的随机算法竞争分析中非常有用。

#hust-theorem("lemma", "引理")[
任一独立片段$f$均满足其长度等于其最优解的成本，即$L_f = C o s t_(O P T)\(f\)$。
] <lem:Phase_Length>

#hust-proof[
假设有一个独立片段 $f =\(f_1\,f_2\,dots.h.c\,f_k\)$，其中应用了两个子程序$upright(M a t c h)_(o d d)$ 和$upright(M a t c h)_(e v e n)$。两个程序分别计算$f$的偶成本函数和奇成本函数，表示为$e v e n_f\(t\)$和$o d d_f\(t\)$。注意到 $o d d_f\(t_(f_1)\)= 1$ 和 $e v e n_f\(t_(f_1)\)= 0$ 。在时间$t_(f_1)$到$t_(f_k)$之间，其中一个函数按照速度$2$增长，而另一个保持不变。

$upright(M a t c h)_(o d d)$ 和$upright(M a t c h)_(e v e n)$ 在$k$为奇数和偶数时分别产生一个$f$的解。如果$k$是奇数，$o d d_f\(t_(f_k)\)$等于$C o s t_(O P T)\(f\)$。 因此可推出：

#math.equation(block: true, numbering: none)[$&  & o d d_f\(t_(f_k)\)+ e v e n_f\(t_(f_k)\) & = 1 + 2 *\(t_(f_k) - t_(f_1)\)\
 & arrow.r.double & s\(t_(f_k)\)+\(t_(f_k) - t_(f_1)\) & = o d d_f\(t_(f_k)\)\
 & arrow.r.double & L_f & = o d d_f\(t_(f_k)\)$]

如果$k$是偶数，可以通过交换上面的$e v e n$和$o d d$符号作等价证明。证毕。
]

#heading(level: 2)[2-竞争的状态化随机延迟算法] <sec:3-ralgo>

本节介绍了状态化随机延迟算法（Randomized Delaying State-based Algorithm，#smallcaps[RDSA]），通过基于状态值的随机延迟决策，该算法可高效处理请求对序列，其竞争比被证明为$2$。同时提出了RDSA 的广义版本，适用于原始输入序列，并保证了竞争比为$2$。

#heading(level: 3)[状态化随机延迟算法] <subsec:rdsa>

#hust-algorithm(caption: [状态化随机延迟算法 RDSA])[
#strong[输入：] 在线输入请求对 \
#strong[输出：] 匹配解 $M$ \
#algo-line(1)[初始化 $S_1 arrow.l 1.$]
#algo-line(2)[*while* 算法空闲时，在时刻 $t(p_i)$ 接收请求对 $p_i$ *do*]
#algo-line(3, indent: 1)[$S_i arrow.l min{1-S_(i-1)+l_(i-1), 1}$]
#algo-line(4, indent: 1)[采样 $X_i tilde.op bold(U)(0, S_i)$]
#algo-line(5, indent: 1)[*if* 在时间段 $(t(p_i), t(p_i)+X_i]$ 接收请求对 $p_(i+1)$ *then*]
#algo-line(6, indent: 2)[$S_(i+1) arrow.l min{1-S_i+l_i, 1}$]
#algo-line(7, indent: 2)[$M$ add $mono("External")(p_i,p_(i+1))$ at time $t(p_(i+1))$]
#algo-line(8, indent: 1)[*else*]
#algo-line(9, indent: 2)[$M$ add $mono("Internal")(p_i)$ at time $t(p_i)+X$]
#algo-line(10)[*return* $M$.]
] <alg:randomizedalgo>

算法~#strong[??] 在接收到每个请求对 $p_i$ 时会在线计算其状态值 $S_i$。若RDSA 在空闲时接收请求对 $p_i$，从 $0$ 到 $S_i$ 中均匀采样值 $X_i$，然后将请求对 $p_i$ 延迟 $X_i$ 秒。如果下一对 $p_(i + 1)$ 在不晚于 $t\(p_i\)+ X_i$ 时刻到达，则 RDSA 会在 $t\(p_(i + 1)\)$ 时刻执行 $mono(E x t e r n a l)\(p_i\,p_(i + 1)\)$。否则，RDSA 将在 $t\(p_i\)+ X$ 时刻执行 $mono(I n t e r n a l)\(p_i\)$。

由于随机性，无法确定算法RDSA 在新请求对到达时处于等待或空闲状态。尽管如此，在一个包含 $k$ 个请求对的单个独立片段 $f =\(f_1\,dots.h.c\,f_k\)$ 并且 $f_1 lt.eq i lt.eq f_k$ 的情况下，将 RDSA 在请求对 $p_i$ 到达时处于空闲状态的概率，定义为 $P_i$，以下引理证明该概率等于状态值 $s\(t\(p_i\)\)$。

#hust-theorem("lemma", "引理")[
对于任意独立片段$f =\(f_1\,dots.h.c\,f_k\)$且满足$f_1 lt.eq i lt.eq f_k$中, 有$P_i = s\(t\(p_i\)\)$.
] <lem:probability>

#hust-proof[
使用归纳法证明该引理。对第一请求对 $p_(f_1)$，$P_1 = s\(t\(p_(f_1)\)\)= 1$。假设 $f_1 < i lt.eq f_k$ 并且 $P_(i - 1) = s\(t\(p_(f_(i - 1))\)\)$。

考虑两个连续的请求对 $p_(i - 1)$ 和 $p_i$。当 $p_i$ 到达时，RDSA 可能处于空闲状态的情况有两种可能，如下所示。

#enum(numbering: "(1)",
[当 $p_(i - 1)$ 到达时，RDSA 执行 $mono(E x t e r n a l)\(p_(i - 2)\,p_(i - 1)\)$ 并等待。这种情况发生的概率为 $1 - P_(i - 1)$。
],
[在时间间隔 $\[t\(p_(i - 1)\)\,t\(p_i\)\)$ 内，RDSA 执行 $mono(I n t e r n a l)\(p_(i - 1)\)$，其中 $X_(i - 1)$ 的样本小于 $l_(i - 1)$。这种情况的概率为 $P_(i - 1) dot.op l_(i - 1) / S_(i - 1) = l_(i - 1)$。
]
)

总之，当 $p_i$ 到达时，RDSA 处于空闲状态的概率等于 $P_i = 1 - P_(i - 1) + l_(i - 1) = s\(t\(p_i\)\)$。证毕。
]

现在，证明随机在线算法RDSA 在每个独立片段的解上竞争比都为$2$。

#hust-theorem("theorem", "定理")[
对于任意独立片段$f =\(f_1\,f_2\,dots.h.c\,f_k\)$，算法RDSA 在$f$上的竞争比为$2$。
]

#hust-proof[
设$L_f$为某个独立片段$f$的长度，$t_u$为该独立片段的结束时间。令$r d s a\(t\)$表示RDSA 在时间$t$之前所产生的总期望成本（包括空间和时间成本）。根据引理~#ref(<lem:Phase_Length>, supplement: none)，该独立片段上最优解的成本等于$L_f$。使用归纳法验证当$f_1 lt.eq i lt.eq f_k$时,有

#math.equation(block: true, numbering: hust-equation-number)[$r d s a\(t\(p_i\)\)= 2\(t\(p_i\)- t\(p_(f_1)\)\)+ S_i dot.op\(1 - S_i\)$] <eq:rdsa_pi>

#emph[基础情形：]当$i = 1$时，$r d s a\(t_(f_1)\)= 0$且$S_1 = 1$，因此直接得到等式~#ref(<eq:rdsa_pi>, supplement: none)。

#emph[归纳假设：]当$f_1 lt.eq i < f_k$，假设等式~#ref(<eq:rdsa_pi>, supplement: none)对于任意$i$成立，现在证明其对于$i + 1$也成立。

#emph[归纳证明：]考虑时间区间$\(t\(p_i\)\,t\(p_(i + 1)\)\]$。相较于$r d s a\(t\(p_i\)\)$，如果RDSA 在$p_i$到达时处于空闲状态，则$r d s a\(t\(p_(i + 1)\)\)$会包含一些额外的成本，这种情况的概率是$P_i$。

现在讨论RDSA 为$p_i$选择的延迟时间$X_i$。如果$X_i < l_i$，则RDSA 会在时间$t\(p_i\)+ X_i$执行$mono(I n t e r n a l)\(p_i\)$，额外成本为$2 X_i + 1$。否则，$X_i gt.eq l_i$，并且RDSA 会执行$mono(E x t e r n a l)\(p_i\,p_(i + 1)\)$，额外成本为$2 l_i$。总之，时间区间$\(t\(p_i\)\,t\(p_(i + 1)\)\]$内产生的额外成本期望为

#math.equation(block: true, numbering: none)[$P_i dot.op #scale(x: 120%, y: 120%)[\(] integral_0^(l_i) frac(2 X_i + 1, S_i) d\(X_i\)+ integral_(l_i)^(S_i) frac(2 l_i, S_i) d\(X_i\)#scale(x: 120%, y: 120%)[\)] = l_i dot.op\(1 + 2 S_i - l_i\)$]

因此，

#math.equation(block: true, numbering: none)[$r d s a\(t\(p_(i + 1)\)\) & = r d s a\(t\(p_i\)\)+ l_i dot.op\(1 + 2 S_i - l_i\)\
 & = 2\(t\(p_i\)- t\(p_(f_1)\)\)+ S_i dot.op\(1 - S_i\)+ l_i dot.op\(1 + 2 S_i - l_i\)\
 & = 2\(t\(p_(i + 1)\)- t\(p_(f_1)\)\)+ S_(i + 1) dot.op\(1 - S_(i + 1)\)$]

由上可知，等式~#ref(<eq:rdsa_pi>, supplement: none)对于任何$f_1 lt.eq i lt.eq f_k$都成立。

最后计算$\(t\(p_(f_k)\)\,t_u\]$的期间成本，其中只包含$t\(p_(f_k)\)+ X_(f_k)$时刻的$mono(I n t e r n a l)\(p_(f_k)\)$的成本为$P_(f_k) dot.op\(2 upright(bold(E))\[X_(f_k)\]+ 1\)= S_(f_k) dot.op\(S_(f_k) + 1\)$。 因此，$r d s a\(t_u\)= r d s a\(t\(p_(f_k)\)\)+ S_(f_k) dot.op\(S_(f_k) + 1\)= 2 L_f$。证毕。
]

在定理~#ref(<thm:algorithmPI>, supplement: none)中证明了最优解的成本是所有独立片段成本之和，因此每个独立片段对于最优算法来说是独立的。同样地，在状态化随机延迟算法中，由于该算法是基于状态值$S_i$选择选项，每个独立片段都以初始状态值$1$开始。因此，上一个独立片段的解不会影响当前独立片段的解的选择。对于RDSA 来说，所有独立片段也是独立的。

综上所述，状态化随机延迟算法的竞争比为

#math.equation(block: true, numbering: hust-equation-number)[$frac(C o s t_(R D S A)\(R_p\), C o s t_(O P T)\(R_p\)) = frac(sum_f C o s t_(R D S A)\(f\), sum_f C o s t_(O P T)\(f\)) = frac(2 sum_f C o s t_(O P T)\(f\), sum_f C o s t_(O P T)\(f\)) = 2$] <eq:cost_ratio>

#hust-theorem("corollary", "推论")[
对任意请求对序列$R$，状态化随机延迟算法RDSA 在$R$上的竞争比为$2$。
] <cor:2-competitive>

#heading(level: 3)[广义版本的状态化随机延迟算法RDSA] <subsec:generalization>

本节介绍了RDSA 的广义版本，适用于原始序列。假设给定请求序列$R$由$n$个请求组成，$r_1\,dots.h\,r_n$，其中 $t\(r_1\)lt.eq dots.h lt.eq t\(r_n\)$。对于任何有效算法$A L G$，每次最多有两个开放的请求。通过这种方式，可以根据开放的请求数量的奇偶性将时间轴分为"奇数区"和"偶数区"。更准确地说，对于$1 lt.eq i lt.eq n$，当$i$为奇数时，区间$\[t\(r_i\)\,t\(r_(i + 1)\)\)$被称为奇数区；当$i$为偶数时，该区间被称为偶数区#footnote[此处定义$t\(r_(n + 1)\)= + oo .$]。请注意，对于每个有效算法，包括最优算法，在每个奇数区间内都只有一个开放的请求，这导致不可避免的等待成本。在广义版本中仍然将某些请求成对考虑，并为每对请求定义到达时间。接下来按以下方式呈现RDSA 的广义版本。

开始时，没有请求，算法处于空闲状态。

当算法处于空闲状态时，检查接下来到达的两个请求 $r_i$ 和 $r_(i + 1)$（其中 $i$ 为奇数）。时间区间 $\[t\(r_i\)\,t\(r_(i + 1)\)\)$ 是奇数区间。在时间 $t\(r_(i + 1)\)$，如果 $x\(r_i\)= x\(r_(i + 1)\)$，则算法匹配这两个请求并保持空闲状态。否则，算法会将这两个请求视为到达时间为 $t\(r_(i + 1)\)$ 的一对请求，并进入等待状态。该对请求也被分配了一个类似于算法~#strong[??] 中的状态值 $S$。如果它是第一对，则其状态值为 $1$。否则，它的状态值等于 $min { 1 - S' + l\,1 }$，其中 $S'$ 是前一对的状态值，$l$ 是从上一对到 $t\(r_(i + 1)\)$ 到达时间之间偶数区间的总长度。同样从 $upright(bold(U))\(0\,S\)$ 中抽样一个延迟时间 $X$。

当算法处于等待状态时，设 $R_1$ 和 $R_2$ 是具有状态值 $S$ 的一对开放请求，其中 $x\(R_1\)= a$，$x\(R_2\)= b$。类似地，检查接下来到达的两个请求 $r_i\,r_(i + 1)$，并且时间区间 $\[t\(r_i\)\,t\(r_(i + 1)\)\)$ 是奇数区间。不失一般性，假设 $x\(r_i\)= a$。在时间 $t_i$，算法匹配请求 $R_1$ 和 $r_i$。如果 $x\(r_(i + 1)\)= a$，则请求 $R_2$ 和 $r_(i + 1)$ 被视为一对具有相同状态值和到达时间的请求。否则，当 $x\(r_(i + 1)\)= b$ 时，算法匹配 $R_2$ 和 $r_(i + 1)$ 并变为空闲状态。同时，请求 $r_i$ 和 $r_(i + 1)$ 被视为一对，其状态值为 $min { 1 - S' + l\,1 }$，而到达时间为 $t\(r_(i + 1)\)$，这与之前类似。请注意，算法不会等待太久。更确切地说，一旦从时间 $min { t\(R_1\)\,t\(R_2\)}$ 开始，偶数区间的总长度达到 $X$，则请求 $R_1$ 和 $R_2$ 立即匹配，并且算法变为空闲状态。

以下定理显示 RDSA 的广义版本也具有竞争比 $2$。

#hust-theorem("theorem", "定理")[
算法 RDSA 的广义版本对于在线 2-MPMD 问题是 $2$ 竞争比的。
]

#hust-proof[
考虑一个奇数区间$\[t\(p_i\)\,t\(p_(i + 1)\)\)$，其中$i$是奇数。设$Delta t = t\(p_(i + 1)\)- t\(p_i\)$。对于任何有效算法，包括 RDSA 的广义版本，在此时间间隔内恰好存在一个开放的请求。对于所有不早于$t\(p_(i + 1)\)$到达的请求，让它们提前$Delta t$到达。这样，最优解的成本减少了$Delta t$。与此同时，RDSA 广义版本产生的解的成本也减少了$Delta t$，即其竞争比不会增加。

现在，任何奇数区间的长度都为零，即输入序列已被改变为成对序列。广义版的 RDSA 与原始版本相同。根据推论#ref(<cor:2-competitive>, supplement: none)，该算法是$2$-竞争的。证毕。
]

#heading(level: 2)[随机近似下界的归纳证明] <sec:3-lowerbound>

本节采用姚氏最小最大原则 (Yao's principle) #cite(<yao1977probabilistic>) 推导 2-MPMD 问题的随机近似下界，并表明状态化随机延迟算法是理论最优的。通过构建一种随机序列的分布，使得任何在线确定性算法的期望成本比至少为$2$。

#heading(level: 3)[随机序列构建]

构造过程中使用状态函数$s\(t\)$来指示构造#footnote[这仍然是一个状态化过程，构造的当前步骤会基于上一个步骤的状态]，注意到状态函数$s\(t\)$可以由折线描述，其中每个转折点对应于序列中的一个请求对，如图~#hust-subref(<fig:Cost_State>, "b")所示。随机匹配序列 $tilde(R)$ 构造过程如下：

#enum(numbering: "(1)",
[将第一对放置在时间 $0$，并将其状态值设置为 $1$。
],
[对于上一次放置的请求对，假设其拥有到达时间 $t$ 和状态值 $S = s\(t\)$，采样一个非负时间间隔$X tilde.op upright(E x p)\(1\)$#footnote[回想一下 $upright(E x p)\(1\)$ 是指数分布，其概率密度函数为 $f\(x\)= e^(- x)$，其中 $x gt.eq 0$。]。
],
[如果 $X < S$，则在时间 $t + X$ 放置一请求对，并将其状态值设为 $1 - S + X$；否则终止过程。
],
[重复步骤2和3，直到过程结束。
]
)

由此得到的序列实际上是一个独立片段。假设存在一个请求对到达时间为$t$、状态值为$S = s\(t\)$，令$P_t\(x\)$ 是在间隔 $\(t\,t + x\)$ 内未进行任何放置的概率。因此，当 $x < s\(t\)$ 时，$P_t\(x\)= integral_0^x e^(- y) d y = e^(- x)$，与 $t$ 无关。为简单起见，在 $x lt.eq s\(t\)$ 时使用 $P\(x\)$ 代替记号 $P_t\(x\)$，且 $P\(x\)= e^(- x)$。

#heading(level: 3)[竞争比分析]

现在能够计算$O P T$和任何在线确定性算法$A L G$产生的期望成本。需要注意的是，构造过程是状态化的，也就是对状态值为$S$的任意时间点后构造的序列的分布只与$S$有关。首先讨论$O P T$产生的期望成本，由引理~#ref(<lem:Phase_Length>, supplement: none)可知这等于相应独立片段长度的期望值。

#hust-theorem("lemma", "引理")[
最优算法在$tilde(R)$的期望成本至多为$1$。
] <lemma:optcost>

#hust-proof[
对于 $1 lt.eq i$ 且 $0 lt.eq s lt.eq 1$，假设第 $i$ 请求对在时间 $t$ 以状态值 $s$ 放置，则 $T\(i\,s\)$ 表示第 $i$ 对之后的独立片段期望长度。注意到 $T\(1\,1\)$ 刚好是所希望的。第$\(i + 1\)$ 请求对有以下两种可能情况：

#enum(numbering: "(1)",
[第$\(i + 1\)$ 请求对不存在，即序列的结束时间为 $t + s$。该情况的概率为 $P\(s\)= e^(- s)$，额外成本为 $s$,如图~#hust-subref(<fig:lowerbound-opt>, "a")所示。
],
[第$\(i + 1\)$ 请求对的到达时间为 $t + x$，其中 $0 lt.eq x < s$，其概率密度为 $P\(x\)= e^(- x)$，额外成本为 $x + T\(i + 1\,1 - s + x\)$，如图~#hust-subref(<fig:lowerbound-opt>, "b")所示。
]
)

因此，对于$1 lt.eq i$和$0 lt.eq s lt.eq 1$，

#math.equation(block: true, numbering: none)[$T\(i\,s\)= s dot.op e^(- s) + integral_0^s\(x + T\(i + 1\,1 - s + x\)\)dot.op e^(- x) d x$]

假设$L > 0$是足够大的常数，定义$T'\(i\,s\)$为辅助函数，使得当$i gt.eq L$时，$T'\(i\,s\)$满足与$T'\(i\,s\)= - s^2 + 2 s$相同的方程。那么，对于$i = L - 1\,dots.h.c\,1$，使用归纳法如下：

#math.equation(block: true, numbering: none)[$T'\(i\,s\) & = s dot.op e^(- s) + integral_0^s\(x + T'\(i + 1\,1 - s + x\)\)dot.op e^(- x) d x\
 & = s dot.op e^(- s) + integral_0^s\(x -\(1 - s + x\)^2 +\(1 - s + x\)\)dot.op e^(- x) d x med med upright("(归纳假设)")\
 & = - s^2 + 2 s$]

因此，对于所有$i gt.eq 1$和$0 lt.eq s lt.eq 1$，有$T'\(i\,s\)= - s^2 + 2 s$。具体来说，$T'\(1\,1\)= 1$。现在考虑$T\(1\,1\)$和$T'\(1\,1\)$之间的差距。对于$ell gt.eq L$，独立片段包含至少$ell$对的概率最多为$\(1 - P\(1\)\)^ell =\(1 - e^(- 1)\)^ell$。对于具有$ell$对且第$L$对状态值为$s$的独立片段，在第$L$对之后实际发生的成本最多为$ell - L + 1$#footnote[简单地内部匹配所有对，这不会引起比最优算法更少的成本]，其中在$T'$中将其视为$- s^2 + 2 s gt.eq 0$。因此，

#math.equation(block: true, numbering: none)[$T\(1\,1\)lt.eq T'\(1\,1\)+ sum_(ell = L)^(+ oo)\(ell - L + 1\)dot.op\(1 - e^(- 1)\)^ell = 1 + e^2 dot.op\(1 - e^(- 1)\)^L .$]

当$L$可以任意大时，$T\(1\,1\)lt.eq 1$。证毕。
]

#figure(
[
#grid(columns: (1fr, 1fr), column-gutter: 4pt, subfigure("../assets/lowerbound_opt-1.svg", [(a) $O P T$情况1], width: 210.76pt), subfigure("../assets/lowerbound_opt-2.svg", [(b) $O P T$情况2], width: 210.76pt))
], caption: [最优算法$O P T$在$tilde(R)$上的期望成本], supplement: [图]) <fig:lowerbound-opt>

现在讨论任何在线确定性算法产生的期望成本。

#hust-theorem("lemma", "引理")[
对于任何在线确定性算法 $A L G$，$A L G$ 所产生的期望成本至少为 $2$。
] <lemma:alg_cost>

#hust-proof[
假设对于$1 lt.eq i$和$0 lt.eq s lt.eq 1$，第$i$对数$p_i$在时间$t$以状态值$s$放置。令$A L G\(i\,s\,0\)$和$A L G\(i\,s\,1\)$分别表示$A L G$在接收$p_i$后处于空闲或等待状态时产生的期望成本。目标是$A L G\(1\,1\,1\)gt.eq 2$。

假设当接收到配对$p_i$时，$A L G$处于空闲状态。如果$p_i$是该独立片段的最后一对，则不会产生额外成本。否则，假设在$p_i$之后的第一对在时间$t + x$放置，其概率密度为$e^(- x)$。按照这种方式，$A L G$在时间$t + x$开始等待，这表明

#math.equation(block: true, numbering: none)[$A L G\(i\,s\,0\)= integral_0^s A L G\(i + 1\,1 - s + x\,1\)dot.op e^(- x) d x$]

该情况如图~#hust-subref(<fig:lowerbound-alg>, "d")所示。

现在考虑当 $A L G$ 收到对 $\(p_i\)$ 时处于等待状态的情况。假设 $A L G$ 将对 $p_i$ 延迟 $m$ 秒，其中 $m lt.eq s$。有以下三种可能情况。

#enum(numbering: "(1)",
[第 $\(i + 1\)$ 对不存在，即序列的结束时间是 $t + s$。此情况的概率为 $P\(s\)= e^(- s)$，$A L G$ 在时间 $t + m$ 执行 $mono(I n t e r n a l)\(p_i\)$，额外成本为 $2 m + 1$，如图~#hust-subref(<fig:lowerbound-alg>, "a")所示。
],
[第 $\(i + 1\)$ 对 $p_(i + 1)$ 的到达时间为 $t + x$，其中 $x lt.eq m$，其概率密度为 $e^(- x)$。$A L G$ 在时间 $t + x$ 执行 $mono(E x t e r n a l)\(p_i\,p_(i + 1)\)$ 并转为空闲状态，额外成本为 $2 x + A L G\(i + 1\,1 - s + x\,0\)$如图~#hust-subref(<fig:lowerbound-alg>, "b")所示。
],
[第 $\(i + 1\)$ 对 $p_(i + 1)$ 的到达时间为 $t + x$，其中 $x > m$，其概率密度为 $e^(- x)$。$A L G$ 在时间 $t + m$ 执行 $mono(I n t e r n a l)\(p_i\)$ 并转为空闲状态。在时间 $t + x$，它再次转为等待状态。此情况下的额外成本为 $2 m + 1 + A L G\(i + 1\,1 - s + x\,1\)$如图~#hust-subref(<fig:lowerbound-alg>, "c")所示。
]
)

因此，对于$1 lt.eq i$且$0 lt.eq s lt.eq 1$，有：

#math.equation(block: true, numbering: none)[$A L G\(i\,s\,1\)=\(2 m + 1\)dot.op e^(- s) & + integral_0^m\(2 x + A L G\(i + 1\,1 - s + x\,0\)\)dot.op e^(- x) d x\
 & + integral_m^s\(2 m + 1 + A L G\(i + 1\,1 - s + x\,1\)\)dot.op e^(- x) d x$]

与引理~#ref(<lemma:optcost>, supplement: none)类似，令$L > 0$为足够大的常数，并定义$A L G'\(i\,s\,0\)$和$A L G'\(i\,s\,1\)$作为两个辅助函数，使得相同的方程成立且在$i gt.eq L$和$j in { 0\,1 }$时，$A L G'\(i\,s\,j\)= j - s^2 + 2 s$。然后，对于$i = L - 1\,dots.h.c\,1$，使用归纳方法如下：

#math.equation(block: true, numbering: none)[$A L G'\(i\,s\,0\) & = integral_0^s A L G'\(i + 1\,1 - s + x\,1\)dot.op e^(- x) d x\
 & = integral_0^s\(1 -\(1 - s + x\)^2 + 2\(1 - s + x\)\)dot.op e^(- x) d x\
 & = - s^2 + 2 s\
A L G'\(i\,s\,1\) & =\(2 m + 1\)dot.op e^(- s) + integral_0^m\(2 x + A L G'\(i + 1\,1 - s + x\,0\)\)dot.op e^(- x) d x\
 & + integral_m^s\(2 m + 1 + A L G'\(i + 1\,1 - s + x\,1\)dot.op e^(- x) d x\
 & =\(2 m + 1\)dot.op e^(- s) + integral_0^m\(2 x -\(1 - s + x\)^2 + 2\(1 - s + x\)\)dot.op e^(- x) d x\
 & + integral_m^s\(2 m + 2 -\(1 - s + x\)^2 + 2\(1 - s + x\)\)dot.op e^(- x) d x\
 & = 1 - s^2 + 2 s$]

与引理~#ref(<lemma:optcost>, supplement: none)类似，设$L > 0$为一个足够大的常数，并定义$A L G'\(i\,s\,0\)$和$A L G'\(i\,s\,1\)$为两个辅助函数，使得相同的方程成立，当$i gt.eq L$且$j in { 0\,1 }$时，有$A L G'\(i\,s\,j\)= j - s^2 + 2 s$。然后，对于$i = L - 1\,dots.h.c\,1$，使用归纳法如下：

#math.equation(block: true, numbering: none)[$A L G'\(i\,s\,0\) & = integral_0^s A L G'\(i + 1\,1 - s + x\,1\)dot.op e^(- x) d x\
 & = integral_0^s\(1 -\(1 - s + x\)^2 + 2\(1 - s + x\)\)dot.op e^(- x) d x\
 & = - s^2 + 2 s\
A L G'\(i\,s\,1\) & =\(2 m + 1\)dot.op e^(- s) + integral_0^m\(2 x + A L G'\(i + 1\,1 - s + x\,0\)\)dot.op e^(- x) d x\
 & + integral_m^s\(2 m + 1 + A L G'\(i + 1\,1 - s + x\,1\)dot.op e^(- x) d x\
 & =\(2 m + 1\)dot.op e^(- s) + integral_0^m\(2 x -\(1 - s + x\)^2 + 2\(1 - s + x\)\)dot.op e^(- x) d x\
 & + integral_m^s\(2 m + 2 -\(1 - s + x\)^2 + 2\(1 - s + x\)\)dot.op e^(- x) d x\
 & = 1 - s^2 + 2 s$]

因此，当$i gt.eq L$且$j in { 0\,1 }$时，$A L G'\(i\,s\,j\)= j - s^2 + 2 s$。特别地，$A L G'\(1\,1\,1\)= 2$。现在，让考虑$A L G\(1\,1\,1\)$和$A L G'\(1\,1\,1\)$之间的差距。对于$ell gt.eq L$，独立片段包含至少$ell$对的概率最多为$\(1 - P\(1\)\)^ell =\(1 - e^(- 1)\)^ell$。对于一个具有$ell$个请求对，并且第$L$对具有状态值$s$的独立片段，在第$L$对之后实际产生的成本不小于$0$，其中在$T'$中被认为是至多$1 - s^2 + 2 s gt.eq 2$。因此，

#math.equation(block: true, numbering: none)[$A L G\(1\,1\,1\)gt.eq A L G'\(1\,1\,1\)- sum_(ell = L)^(+ oo) 2\(1 - e^(- 1)\)^ell = 2 - 2 e\(1 - e^(- 1)\)^L$]

由于$L$可以任意大，$A L G\(1\,1\,1\)gt.eq 2$。证毕。
]

#figure(
[
#grid(columns: (1fr, 1fr), gutter: 8pt, subfigure("../assets/lowerbound_alg-1.svg", [(a) $A L G$在$t$处于等待时情况1], width: 210.76pt), subfigure("../assets/lowerbound_alg-2.svg", [(b) $A L G$在$t$处于等待时情况2], width: 210.76pt), subfigure("../assets/lowerbound_alg-3.svg", [(c) $A L G$在$t$处于等待时情况3], width: 210.76pt), subfigure("../assets/lowerbound_alg-4.svg", [(d) $A L G$在$t$处于空闲状态], width: 210.76pt))
], caption: [确定性算法$A L G$在$tilde(R)$上的期望成本], supplement: [图]) <fig:lowerbound-alg>

#hust-theorem("theorem", "定理")[
任何随机化在线算法在2-MPMD上的竞争比至少为 $2$。
]

#hust-proof[
依据引理~#ref(<lemma:optcost>, supplement: none)和引理~#ref(<lemma:alg_cost>, supplement: none)，$A L G\(1\,1\,1\)gt.eq 2$且$T\(1\,1\)lt.eq 1$，即对于 $tilde(R)$，任何在线确定性算法的期望成本比率至少为 $2$。基于姚氏最小最大原则#cite(<yao1977probabilistic>)，任何随机化在线算法的竞争比至少为 $2$。证毕。
]

#heading(level: 2)[随机近似下界的演绎推导] <sec:3-formalization>

本节将介绍解决随机理论下界中使用到的技术。

通过直觉可知需要构造具有某种分布的独立片段，并且这个过程是一个状态化的过程。但是这个分布是未知的。由第~#ref(<sec:3-optimal>, supplement: none)节可知，最优解的产生完全基于状态值，因此可根据生成片段时当前的状态值来决定之后的片段如何生成。即在某一个时刻，假设该时刻的状态值为$s$，令其之后$Delta t$时间内生成一个请求对的概率应该为$f\(s\)Delta t$，也就是构造序列的生成概率密度为$f\(s\)$。

接下来计算一个重要的条件概率$g_s\(y\)$，该条件概率指示在一个状态值为$s$的时间点之后，一直持续到状态值为$y$之间都没有新的请求对生成的概率。

#math.equation(block: true, numbering: none)[$&  & g_s\(y - epsilon\)= g_s\(y\)\(1 - f\(y\)epsilon\)upright("且") g_s\(s\)= 1\
 & arrow.r.double & g'_s\(y\)= frac(g_s\(y\)- g_s\(y - epsilon\), epsilon) = g_s\(y\)* f\(y\)\
 & arrow.r.double & g'_s\(y\)= g_s\(y\)f\(y\)arrow.r.double g_s\(y\)= e^(F\(y\)- F\(s\))$]

现在需要计算 $O P T$ 和任何在线确定性算法 $A L G$ 产生的期望成本。需要注意的是，构造过程是状态化的，也就是说，对于状态值为 $s$ 的任意时间点后构造的序列的分布，只与 $s$ 有关。因此，假设某一时间点其状态值为 $s$，计算算法在这一点之后构造序列的期望成本，该值仅与状态值 $s$ 有关。首先讨论$O P T$产生的期望成本，这等于相应独立片段长度的期望值。 $T\(s\)$考虑两种情况:

#enum(numbering: "(1)",
[构造过程在之后没有生成请求对，独立片段增加长度$s$。这种情况的概率为$g_s\(0\)= e^(F\(0\)- F\(s\))$。
],
[构造过程在之后状态$y$生成请求对，独立片段增加长度$\(s - y\)+ T\(1 - y\)$。这种情况的概率密度为$g_s\(y\)= e^(F\(y\)- F\(s\))$。
]
)

因此可得递推式：

#math.equation(block: true, numbering: hust-equation-number)[$T\(s\)= s e^(F\(0\)- F\(s\)) + integral_0^s\[\(s - y\)+ T\(1 - y\)\]e^(F\(y\)- F\(s\)) f\(y\)d y$]

接下来计算$A L G$的期望成本，对任意 $A L G$ 参数化。由于$A L G$ 在任一时间点要么等待，要么空闲，并且在这一时间点后可以延迟等待，将延迟等待的时间参数化为 $m$#footnote[注意到 $m > s$ 的算法可以等价转化为 $m = s$ 的算法]。可获得 $A L G$ 对构造序列的成本计算#footnote[注意在$A\(0\,s\)$中的$m^(*)$的值并不能确定]，类似#ref(<sec:3-lowerbound>, supplement: none)节中的定义，将$A L G$等待状态的版本定义为$A\(1\,s\,m\)$，空闲状态的版本定义为$A\(0\,s\)$，两者均可展开为积分递推式，$A\(1\,s\,m\)$考虑两种情况:

#enum(numbering: "(1)",
[构造过程在$m$时间内没有生成请求对，$A L G$会在$m$时间内部匹配，其成本为$1 + 2 m$。此后$A L G$转换为空闲状态。这种情况的概率为$g_s\(s - m\)= e^(- m)$。
],
[构造过程在$\(0\,m\)$时间内生成请求对，其$A L G$外部匹配成本为$2\(s - y\)$，此后$A L G$转换为空闲状态。这种情况的概率密度为$f\(y\)e^(y - s)$。
]
)

$A\(0\,s\)$只会考虑构造算法生成某对请求点之后，算法便转换为等待状态，其概率密度为$e^(F\(y\)- F\(x\))$，因此可得递推式：

#math.equation(block: true, numbering: none)[$& A\(1\,s\,m\)=\[\(1 + 2 m\)+ A\(0\,s - m\)\]e^(- m) + integral_(s - m)^s\[2\(s - y\)+ A\(0\,1 - y\)\]f\(y\)e^(y - s) d y$]
#math.equation(block: true, numbering: hust-equation-number)[$& A\(0\,s\)= integral_0^s A\(1\,1 - y\,m^(*)\)e^(F\(y\)- F\(s\)) f\(y\)d y$]

此时目标是 $max_(f\(x\)) min_m A\(1\,1\,m\)\/T\(1\)$，即找到一种分布，能够攻击所有确定性算法，并找到其中成本比最大的一种分布。这类似于博弈论中扮演敌手，设计一个分布去攻击所有的确定性策略。因此可假设最优分布满足#emph[混合策略纳什均衡]，即所有确定性算法都具有相同的成本。

假设$A L G$延迟等待任意值在$tilde(R)$上的期望成本都相同，则假设以下等式成立：

#math.equation(block: true, numbering: hust-equation-number)[$forall m\,med med med med A\(1\,s\,m\) & = a\(s\)arrow.r.double frac(d, d m) a\(s\)= 0$] <eq:assumption>
#math.equation(block: true, numbering: hust-equation-number)[$A\(0\,s\) & = b\(s\)$]

让$A\(1\,s\,m\)$对$m$求导可得：

#math.equation(block: true, numbering: none)[$frac(d, d m) A\(1\,s\,m\)= & 2 m e^(- m) f\(s - m\)- 2 m e^(- m) - b (- m + s) e^(- m)$]
#math.equation(block: true, numbering: hust-equation-number)[$& + b (m - s + 1) e^(- m) f\(s - m\)- e^(- m) b'\(s - m\)+ e^(- m)$]

重整化，令$s - m = t$, 联立$a'\(s\)= 0$的假设可得方程：

#math.equation(block: true, numbering: hust-equation-number)[$2 m f\(t\)- 2 m - b\(t\)+ b\(1 - t\)f\(t\)- b'\(t\)+ 1 = 0$] <eq:lowerbound_1>

同时，让$A\(0\,s\)$对$s$求导可得：

#math.equation(block: true, numbering: none)[$frac(d, d m) A\(0\,s\) & =$]
#math.equation(block: true, numbering: none)[$b'\(s\) & = a\(1 - s\)f\(s\)- f\(s\)integral_0^s a (1 - y) e^(- F (s) + F (y)) f\(y\)thin d y$]
#math.equation(block: true, numbering: hust-equation-number)[$b'\(s\) & = a\(1 - s\)f\(s\)- f\(s\)b\(s\)$] <eq:lowerbound_2>

同时，可得：

#math.equation(block: true, numbering: hust-equation-number)[$A\(1\,s\,0\)= a\(s\)= 1 + b\(s\)$] <eq:lowerbound_3>

联立方程~#ref(<eq:lowerbound_1>, supplement: none)、~#ref(<eq:lowerbound_2>, supplement: none)和#ref(<eq:lowerbound_3>, supplement: none)可得：

#math.equation(block: true, numbering: none)[$&  & b'\(t\) & = 2 m f\(t\)- 2 m - b\(t\)+ b\(1 - t\)f\(t\)+ 1\
 &  &  & = 1 + b\(1 - t\)f\(t\)- b\(t\)f\(t\)\
 & arrow.r.double & f\(t\)\(2 m + b\(t\)\) & = 2 m + b\(t\)\
 & arrow.r.double & f\(t\) & = 1$]

因此可得$f\(s\)= 1$。 将其代入$T\(s\)\,A\(1\,s\,m\)$可推出：

#math.equation(block: true, numbering: hust-equation-number)[$T\(s\) & = - s^2 + 2 s$]
#math.equation(block: true, numbering: hust-equation-number)[$A\(1\,s\,m\) & = - s^2 + 2 s + 1$]

取$s = 1$，可以得到目标值$T\(1\)= 1\,A\(1\,1\,m\)= 2$，与上一节归纳证明的结果一致，并且发现算法$A\(1\,1\,m\)$的值与$m$无关，满足假设的等式#ref(<eq:assumption>, supplement: none)。

#heading(level: 2)[本章小结]
