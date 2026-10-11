#import "lib.typ": *
#show: thmrules

#show: cumcm.with(
  title: "基于遗传算法的烟幕干扰弹投放策略的优化设计",
  problem-chosen: "A",
  team-number: "202501006013",
  college-name: "北京邮电大学",
  member: (
    A: "靳宸宇",
    B: "赵明远",
    C: "赵熠卓",
  ),
  advisor: "贺祖国",
  date: none,
  cover-display: false,
  abstract: [
针对无人机烟幕干扰弹投放策略优化问题，本文围绕提升对空地导弹的有效遮蔽时长展开研究，结合几何分析、光线投射仿真与优化算法，构建了基于物理求解器的评估与优化框架。首先，建立了烟幕运动模型与遮蔽判定机制，通过采样目标点与实时光线模拟计算有效遮蔽时间。

针对问题一，我们基于计算机模拟思路使用Rust语言构建了高效物理求解器，在给定参数下计算出对M1导弹的有效干扰时长为*1.4051*秒。

问题二采用改进遗传算法与局部简单正态随机搜索相结合，优化单机单弹投放策略，得到最大遮蔽时间*4.5886*秒。

问题三引入算术改进型遗传算法处理多弹投放下8个决策变量的高维优化问题，实现对M1的最长遮蔽时间*7.6058*秒。

问题四通过分机独立优化策略和正向验证得到三机协同干扰M1的最优解，总遮蔽时长达*11.7446*秒。

问题五借助热力图分析确定各无人机最佳干扰目标，采用CMA-ES进化策略进行多目标优化，显著提升了对三枚导弹的综合干扰效能。本研究创新性地融合多种优化算法与物理仿真，在复杂约束下实现了高效参数搜索与策略生成，为无人机协同干扰任务提供了可靠的数学模型和求解途径，最终求解的总遮蔽时长达到：*22.9218*秒

  ],
  keywords: ("优化策略", "遗传算法", "计算机仿真", "多目标规划"),
)

= 问题重述

无人机的应用日趋广泛，在军事领域更是大放异彩。以如今技术已经可以在强机动力无人机、精确延时引信和特制烟幕材料的支持下实现定时定点投放与预定位置起爆，起到良好的遮蔽作用。现利用无人机抛放烟幕干扰弹，引爆后形成球形烟幕的方式对空地导弹进行持续干扰，有效遮蔽真实目标。

无人机在收到投弹任务后将从定点以$70~140m\/s$的速度向某水平方向出发，此后不改变无人机航向、飞行速度与飞行高度，多架无人机可有不同航向与速度。投弹时，要求相邻的投弹时间间隔不少于$1s$；投弹后，烟幕弹先受重力作用向下运动，随后在延时引信的作用下在预定时间后起爆，此瞬间形成一个球形的烟幕用于遮挡目标，该烟幕始终以$3m\/s$的竖直速度匀速向下运动。起爆后$20s$内，以烟幕中心为球心，半径$10m$范围内的球形范围是有效的烟幕范围，即如果敌方对目标物的视线都能够被该球形范围遮挡，则可视为有效遮蔽。

雷达检出三枚空地导弹，飞行速度$300m\/s$，方向指向掩护目标（以下称“假目标”）。现以假目标为原点建立空间直角坐标系，地面为$x O y$平面，垂直地面向上为轴正向，派发给五架无人机执行真目标的遮蔽任务，该目标为半径$7m$，高$10m$的圆柱形，底面与地面重合，底面圆心位于$(0,200,0)$，给定三枚导弹M1、M2、M3位置分别为$(20000,0,2000)$、$(19000,600,2100)$、$(18000,-600,1900)$，五架无人机FY1、FY2、FY3、FY4、FY5位置分别为$(17800,0,1800)$、$(12000,1400,1400)$、$(6000,-3000,700)$、$(11000,2000,1800)$、$(15000,-2000,1300)$。

现设计烟幕干扰弹的投放策略，使无人机在一定飞行方向，飞行速度，投弹时间和烟幕弹起爆延时的情况下，各枚烟幕干扰弹对真目标的有效遮蔽时间尽可能长。

建立合适的数学模型求解如下五个问题：

1. 无人机FY1朝向假目标方向水平飞行，速度$120m\/s$，起飞$1.5s$后投弹，延时$3.6s$起爆，计算烟幕干扰弹对M1的有效干扰时长；
2. 无人机FY1投枚烟幕弹对M1进行干扰，确定合适的飞行方向，飞行速度，投弹时间与引爆延时，使烟幕对M1的有效干扰时长尽可能长；
3. 无人机FY1投枚烟幕弹对M1进行干扰，确定合适的飞行方向，飞行速度，三个投弹时间与引爆延时，使烟幕对M1的有效遮蔽时长尽可能长，并计算出该策略下每枚烟幕弹的投放位置坐标与起爆坐标，及各自对M1的有效干扰时长；
4. 三架无人机FY1、FY2、FY3各投放一枚烟幕弹对M1进行干扰，确定各自合适的飞行方向，飞行速度，投弹时间与引爆延时，使烟幕对M1的有效遮蔽时长尽可能长，并计算出该策略下每枚烟幕弹的投放位置坐标与起爆坐标，及各自对M1的有效干扰时长；
5. 五架无人机FY1、FY2、FY3、FY4、FY5各最多投放$3$枚烟幕弹对M1、M2、M3进行干扰，确定各自合适的飞行方向，飞行速度，投弹时间与引爆延时，使烟幕对M1、M2、M3的有效干扰时长尽可能长，并计算出该策略下每枚烟幕弹的投放位置坐标与起爆坐标，及各自对哪些导弹进行了干扰，得出有效干扰时长；

= 问题分析

== 问题1

有效遮蔽时间难以通过传统几何分析方法求得，更合适的方式是通过计算机进行物理仿真，对导弹击中假目标之前的所有时间进行精细离散化模拟，分析在导弹视角下，真目标的样点发出的光线是否被烟幕所遮挡，再计数得到能够起到有效遮挡作用的时间片数目，与时间细分度结合即可得出有效遮挡时间。该仿真计算模型也可用于后续问题的求解。

== 问题2

无人机的飞行速度，飞行方向，投弹时间和引爆延时直接决定了烟幕的投放位置，从而决定有效遮挡时间。最大化该时间，属于复杂非线性的优化问题。若要优化四个决策变量的取值，可以用到启发类算法，诸如遗传算法等，将其与局部随机搜索的方式相结合应能得到较优的投放策略。另外，也可通过空间约束强制去除不合理的随机解，缩小可行解范围，实现高效求解。

== 问题3

无人机FY1在投放$3$枚烟幕干扰弹的情况下会产生四个新的决策变量，并添加了投弹时间间隔作为新约束条件，遮蔽时间的取值将会更加稀疏化，而最传统的遗传算法（即通过基因和染色体进行仿真）存在各种突变造成的不稳定性，为弥补这种缺陷可以使用算数优化的遗传算法，并加入一些优化策略进行改进，最后结合局部正态随机搜索的方式得到最优解。

== 问题4

三架无人机FY1，FY2，FY3各自的$4$个决策变量（飞行速度，飞行方向，投弹时间和引爆延时）构成$3$组$12$个决策变量，相较问题$2$，$3$，这意味着更加广阔的维度空间与更稀疏的较优解，直接进行各种算法的堆砌已经难以满足快速收敛和全局最优的需求，考虑优化求解策略，先独立优化求解每架无人机的最长遮挡时间，再将3组独立优解组合作为$12$个决策变量的初始值，最后综合利用遗传算法和局部搜索得到尽可能优的解。

== 问题5

该问题类似问题4，同样是高维度的优化问题，不可盲目求解，需预先规划无人机投弹的干扰目标，同样在独立的情况下，得到无人机单独投弹分别对三枚导弹的三个最优干扰时长，共15个，列表比对以限制出较优策略。随后在此目标策略下，使用部分最优的组合作为迭代初值进行持续优化。并且使用协方差矩阵自适应进化算法进行全局最优规划。

= 模型假设与变量符号约定

== 模型假设

- 忽略无人机的起飞时间，在受领任务后，无人机瞬时进入匀速飞行状态
- 忽略一切空气阻力与风力对无人机、烟幕弹以及烟幕云团的影响
- 忽略烟幕弹带给烟幕云团的竖直方向初速度，起爆后烟幕云团即刻以$3m\/s$的速度匀速下落

== 符号约定

// 定义所有符号和约定
#let all_symbols = (
  ([$r$], [真、假目标圆柱体的半径]),
  ([$h$], [真、假目标圆柱体的高度]),
  ([$g$], [重力加速度，本文中取值为$9.81m\/s$]),
  ([$M_i$], [在空间坐标系中，例导弹M1的点位是$M_1$，M2的点位是$M_2$，依次类推]),
  ([$F Y_i$], [在空间坐标系中，例无人机FY1的点位是$F Y_1$，FY2的点位是$F Y_2$，依次类推]),
  ([$v_d^"(i)"$], [第i架无人机的飞行速度，例如无人机FY1的飞行速度为$v_d^"(i)"$]),
  ([$v_(d x)^"(i)"$], [第$i$架无人机$x$轴方向分速度，例如无人机FY1沿$x$轴方向的分速度为$v_(d x)^((1))$]),
  ([$v_(d y)^((i))$], [第$i$架无人机$y$轴方向分速度，例如无人机FY1沿$y$轴方向的分速度为$v_(d y)^((1))$]),
  ([$v_m$], [导弹的飞行速度]),
  ([$v_(m x)^((i)) , v_(m y)^((i)) , v_(m z)^((i))$], [第$i$枚空地导弹沿$x , y , z$轴正方向各自的分速度]),
  ([$x_m^((i)) , y_m^((i)) , z_m^((i))$], [第$i$枚空地导弹的位置坐标]),
  ([$t_i^((j))$], [第$i$架无人机从出发开始到投下第$j$枚烟幕干扰弹的时间间隔，以下简称“投弹时间”]),
  ([$t d_i^((j))$], [第$i$架无人机投下的第$j$枚烟幕干扰弹的引爆延时]),
  ([$t_(i j)^((k))$], [第$i$架无人机投下的第$j$枚烟幕干扰弹对第$k$枚空地导弹的有效干扰时长]),
  ([$t^((i k))$], [第$i$架无人机投下的所有烟幕干扰弹对第$k$枚空地导弹的有效干扰时长]),
  ([$x_i , y_i , z_i$], [第$i$架无人机的位置坐标]),
  ([$x_i^((j)) , y_i^((j)) , z_i^((j))$], [第$i$架无人机投下的第$j$枚烟幕干扰弹的位置坐标]),
  ([$hat(x)_i^((j)) , hat(y)_i^((j)) , hat(z)_i^((j))$], [第$i$架无人机投下的第$j$枚烟幕干扰弹的投放点]),
  ([$tilde(x)_i^((j)) , tilde(y)_i^((j)) , tilde(z)_i^((j))$], [第$i$架无人机投下的第$j$枚烟幕干扰弹的起爆点]),
  ([$O_(i j)$], [第$i$架无人机投下的第$j$枚烟幕干扰弹起爆后形成的球状烟幕的球心]),
  ([$x_(i j) , y_(i j) , z_(i j)$], [球状烟幕球心$O_(i j)$的位置坐标]),
  ([$d_(i j)^((k))$], [作第$k$枚空地导弹（Mk）位置与真目标中心的连线，球状烟幕球心$O_(i j)$到该连线所在直线之间的距离]),
  ([$T$], [真目标圆柱的几何中心]),
  ([$T_b$], [真目标圆柱的底面中心]),
  ([$T_i$], [在真目标表面取得的固定样点]),
)

#split_table(all_symbols,splits:(13,all_symbols.len()))

= 模型建立模型建立与求解

== 问题1的模型建立与求解 <问题1的模型建立与求解>

根据题目信息，当一架无人机飞行方向、飞行速度、投弹时间与引爆延时确定后，烟幕的运动状态和有效遮蔽时长也随即确定，此物理过程可先建立数学模型，后通过计算机仿真光线路径计算有效遮蔽时长，同时为后续问题提供求解基础。

=== 计算导弹位置与烟幕云团位置 <计算导弹位置与烟幕云团位置>

无人机的飞行速度、飞行方向可用其在$x$轴、$y$轴方向上的速度分量$v_(d x)^((1)) , v_(d y)^((1))$表示，投弹时间用$t_1^((1))$表示，引爆延时使用$t d_1^((1))$表示，在该场景下建立如下模型以判断球状烟幕是否起到有效遮蔽作用：

在某时刻$t$，得到导弹M1的运行位置$(x_m^((1)) , y_m^((1)) , z_m^((1)))$，由于导弹运行的速度方向指向原点位置，大小为$300m\/s$，如 @figure-1 所示：
#figure(
  image("./figures/p1.png", width: 39%),
  caption: [
    导弹速度求解示意
  ],
) <figure-1>

该情况下可得速度分量与M1运行位置表达式：
$
  cases(
    v_(m x)^((1)) = - 300 dot.op 10 / sqrt(101),
    v_(m y)^((1)) = 0,
    v_(m z)^((1)) = - 300 dot.op 1 / sqrt(101) med
  ) arrow.r M 1 : cases(
    x_m^((1)) = 20000 + v_(m x)^((1)) dot.op t,
    y_m^((1)) = 0 + v_(m y)^((1)) dot.op t,
    z_m^((1)) = 2000 + v_(m z)^((1)) dot.op t med
  )
$<func-1>

随后根据投弹时间$t_1^((1))$，引爆延时$t d_1^((1))$，无人机沿$x , y$轴方向的分速度$v_(d x)^((1)) , v_(d y)^((1))$确定从无人机起飞后$t s$时刻（$t in [t_1^((1)) + t d_1^((1)) , t_1^((1)) + t d_1^((1)) + 20]$）烟幕云团球心$O_11$的位置坐标$x_11 , y_11 , z_11$，即：

$
  O_11 : cases(
    x_11 = v_(d x)^((1)) dot.op (t_1^((1)) + t d_1^((1))),
    y_11 = v_(d y)^((1)) dot.op (t_1^((1)) + t d_1^((1))),
    z_11 = 1800 - 1 / 2 dot.op g (t d_1^((1)))^2 - 3 dot.op (t - t_1^((1)) - t d_1^((1))) med
  )
$ <func-2>

=== 目标点取样模拟 <目标点取样模拟>

为明确描述真目标的实际形状，在其表面上均匀取$24$个样点作为目标物的替代点，取法如下：

在圆柱的底面圆周上均匀取$8$个点，并按照圆柱高度的一半向上平移一次和两次得到新的$16$个点，这总计$24$个点将作为目标物的替代点进行光线模拟，各点相对位置与坐标如@figure-2 所示：

#let table_x = align(
    center,
  )[#table(
    columns: (10.2%, 17.08%, 17.09%, 17.08%, 18.8%, 19.74%),
    align: (center + horizon, center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      table.cell(align: center + horizon, rowspan: 2)[序号],
      table.cell(align: center + horizon, colspan: 5)[坐标],
      table.cell(align: center + horizon)[ $x$ ],
      table.cell(align: center + horizon)[ $y$ ],
      table.cell(align: center + horizon)[$z_1$],
      table.cell(align: center + horizon)[$z_2$],
      table.cell(align: center + horizon)[$z_3$],
    ),
    table.hline(),
    table.cell(align: center + horizon)[$1$],
    table.cell(align: center + horizon)[$0$],
    table.cell(align: center + horizon)[$193$],
    table.cell(align: center + horizon, rowspan: 8)[$0$],
    table.cell(align: center + horizon, rowspan: 8)[$5$],
    table.cell(align: center + horizon, rowspan: 8)[$10$],
    table.cell(align: center + horizon)[$2$],
    table.cell(align: center + horizon)[$0$],
    table.cell(align: center + horizon)[$207$],
    table.cell(align: center + horizon)[$3$],
    table.cell(align: center + horizon)[$7$],
    table.cell(align: center + horizon)[$200$],
    table.cell(align: center + horizon)[$4$],
    table.cell(align: center + horizon)[$-7$],
    table.cell(align: center + horizon)[$200$],
    table.cell(align: center + horizon)[$5$],
    table.cell(align: center + horizon)[$4.95$],
    table.cell(align: center + horizon)[$195.05$],
    table.cell(align: center + horizon)[$6$],
    table.cell(align: center + horizon)[$4.95$],
    table.cell(align: center + horizon)[$204.95$],
    table.cell(align: center + horizon)[$7$],
    table.cell(align: center + horizon)[$-4.95$],
    table.cell(align: center + horizon)[$195.05$],
    table.cell(align: center + horizon)[$8$],
    table.cell(align: center + horizon)[$-4.95$],
    table.cell(align: center + horizon)[$204.95$],
  )];

#let figure_2 = image("./figures/p2.png");
#figure(
  grid(
    columns: 2,
    gutter: 2pt,
    table_x, figure_2,
    text("（a）采样点的位置坐标", size: 10pt), text("（b）24个样点位置图示", size: 10pt)
  ),
  kind: image
) <figure-2>

=== 遮挡判断 <遮挡判断>

随后确定空地导弹运行位置M1指向真目标物体表面上某点$T_i$的向量$upright(bold(M)) upright(bold(1)) upright(bold(T))_(upright(bold(i)))$，以及导弹M1指向云团球心$O_11$的向量$upright(bold(M 1)) upright(bold(O))_(upright(bold(11)))$，下面根据这两个向量判断该时刻烟幕是否对物体表面上某点$T_i$起到遮挡作用。

两向量是同起点的，记向量$upright(bold(M 1)) upright(bold(O))_(upright(bold(11)))$在向量$upright(bold(M)) upright(bold(1)) upright(bold(T))_(upright(bold(i)))$上的投影向量为$upright(bold(a))$，令$lambda$满足：

$ upright(bold(M)) upright(bold(1)) upright(bold(T))_(upright(bold(i))) = lambda dot.op upright(bold(a)) $

根据$lambda$的不同取值，计算判定距离$d$，当$lambda > 1$时，$d = lr(|O_11 T_i|)$，当$lambda < 0$时，$d = lr(|O_11 M 1|)$，当$0 < lambda < 1$时，$d$为$O_11$到$upright(bold(M 1)) upright(bold(O))_(upright(bold(11)))$所在直线的距离，当该判定距离$d < 10$时，可以认为烟幕起到了有效遮挡作用，否则烟幕无效。细节如下@figure-3：（圆形表示球形烟幕，$upright(bold(M)) upright(bold(1)) upright(bold(T))_(upright(bold(i)))$可视作传入到导弹视线的光线）

#figure(
  image("./figures/p3.png", width: 70%),
  caption: [
    烟幕遮挡判定距离的应用原理
  ],
) <figure-3>

希望得到的是烟幕云团球心$O_(i j)$在$upright(bold(M)) upright(bold(1)) upright(bold(T))_(upright(bold(i)))$所在直线上的投影点$S$，若$S$在线段$M 1 T_i$上（即满足条件：$0 < lambda < 1$），说明烟幕是否有遮挡作用可以通过$O_(i j) S$的长度$d$来判断，当$d lt.eq 10$时，烟幕与视线$upright(bold(M)) upright(bold(1)) upright(bold(T))_(upright(bold(i)))$存在交点，即视线受到遮挡，反之$d > 10$时，无法遮挡导弹视线；对于投影点$S$不在线段$M 1 T_i$上的情况，则应选取距线段两端点中最近的一个计算距离$d$，同样当$d lt.eq 10$时可起到有效遮挡作用，反之$d > 10$时无法遮挡。

下面是$lambda , d$的计算方式：计算空间中$upright(bold(M O)) , upright(bold(M T))$两向量夹角余弦的公式为：

$
  cos ⟨upright(bold(M O)) , upright(bold(M T))⟩ = frac(
    upright(bold(M O)) upright(bold(dot.op)) upright(bold(M T)), lr(|upright(bold(M O))|) dot.op lr(|upright(bold(M T))|),
  )
$

由于$upright(bold(M O))$在$upright(bold(M T))$上的投影长度为$lr(|upright(bold(M O))|) dot.op lr(|cos ⟨upright(bold(M O)) , upright(bold(M T))⟩|)$则有：

$
  s = lr(|upright(bold(M O))|) dot.op lr(|cos ⟨upright(bold(M O)) , upright(bold(M T))⟩|) = lr(
    |frac(upright(bold(M O)) upright(bold(dot.op)) upright(bold(M T)), lr(|upright(bold(M T))|),)|
  )
$

投影向量比例$lambda$的正负取值取决于$cos ⟨upright(bold(M O)) , upright(bold(M T))⟩$或$upright(bold(M O)) upright(bold(dot.op)) upright(bold(M T))$的符号，两者同正同负，故：

$
  lambda = frac(
    med frac(
      upright(bold(M O)) upright(bold(dot.op)) upright(bold(M T)), lr(|upright(bold(M T))|),
    ) med, lr(|upright(bold(M T))|),
  ) = frac(upright(bold(M O)) upright(bold(dot.op)) upright(bold(M T)), lr(|upright(bold(M T))|)^2,)
$

当$0 < lambda < 1$时，计算垂线长度作为点到直线的距离作为烟幕遮挡判定距离：

$
  d = sqrt(lr(|upright(bold(M O))|)^2 - s^2) = sqrt(
    lr(|upright(bold(M O))|)^2 - lr(
      |frac(upright(bold(M O)) upright(bold(dot.op)) upright(bold(M T)), lr(|upright(bold(M T))|),)|
    )^2
  )
$

当$lambda < 0$时，$d = lr(|upright(bold(M O))|)$，当$lambda > 1$时，$d = lr(|upright(bold(O T))|)$，

根据真目标的样点位置$T$，当前时刻计算出的导弹位置$M$、烟幕位置$O$（@func-1 ，@func-2 ），带入到上式中即可求得$lambda , d$，示意图如下@figure-4 所示：

#figure(
  image("./figures/p4.png", width: 44%),
  caption: [
    *$lambda,d$*的计算示意图
  ],
) <figure-4>

=== 仿真求解遮蔽时长 <仿真求解遮蔽时长>

最后，需从无人机起飞到导弹击中假目标为止进行时间上的仿真，判断每时刻从真目标上各点发出到导弹上的光线是否被遮挡，累加计数即可得出被有效遮挡的时长，流程图如下 @figure-5 所示。
#figure(
  image("./figures/p5.png", width: 80%),
  caption: [
    有效遮蔽时长仿真计算流程图
  ],
) <figure-5>

=== 问题1结果总结 <问题1结果总结>

据此流程编写置于计算机底层运行的物理求解器，其脚本文件如附录I所示，根据问题中给出的：无人机FY1朝向假目标方向水平飞行，速度$120$m/s，起飞$1.5$s后投弹，延时$3.6$s起爆，即

#align(center)[#block[$v_(d x)^((1)) = - 120 , v_(d y)^((1)) = 0 , t_1^((1)) = 1.5 , t d_1^((1)) = 3.6$]]

信息输入后得出的遮蔽时长计算结果为

#align(center)[#block[*$t_11^((1)) = 1.5 = 1.4051$*]]

== 问题2的模型建立与求解 <问题2的模型建立与求解>

该问题的优化目标是得到尽可能长的遮蔽时间$t_11^((1))$，输入变量是$v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1))$，且遮蔽时间仅与这四个值有关，记作函数$t_11^((1)) (v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1)))$，该函数是非线性的。

=== 模型描述 <模型描述>

该优化模型可符号化表述为：

$ M a x med med med t_11^((1)) (v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1))) $

$
  s . t . med med med 70 lt.eq sqrt(v_(d x)^((1))^2 + v_(d y)^((1))^2) lt.eq 140\
  t_1^((1)) gt.eq 0\
  t d_1^((1)) gt.eq 0
$

其中决策变量为无人机FY1沿$x , y$轴方向的分量$v_(d x)^((1)) , v_(d y)^((1))$，投弹时间$t_1^((1))$和爆炸延时$t d_1^((1))$，约束条件只有时间非负性约束和无人机的速度大小约束。

=== 优化限制条件的推理 <优化限制条件的推理>

鉴于该函数在绝大多数情况下的值为$0$，完全随机搜索的方式会使工作量剧增，需要先对其四个输入变量的范围进行有效限制，一并作为优化模型的限制条件，更小的可行域能保证模型求解顺利进行。

空间位置上的限制作为优化约束，需要注意的是该约束条件并非模型约束，而是确保优化时不会在劣解附近盘旋过长时间。由于烟幕与导弹的运动状态始终保持不变，且导弹运动速度较快，故应要求烟幕干扰弹的起爆点不可在导弹视线区外，否则烟幕不会提供有效遮蔽作用。

按如下 @figure-6，分$x , y , z$三轴方向进行分析，从起飞到起爆的时间为$t_1^((1)) + t d_1^((1))$，故烟幕干扰弹在$x$轴方向上相对导弹的位移为$(v_(d x)^((1)) - v_(m x)^((1))) dot.op (t_1^((1)) + t d_1^((1)))$，该相对位移恒为正，大于$2200$时烟幕云团中心定会脱离视线区；同理在$y$轴方向上烟幕干扰弹相对导弹的位移为$v_(d y)^((1)) dot.op (t_1^((1)) + t d_1^((1)))$，当位移大于$200$时烟幕云团中心定会脱离视线区；$z$轴方向由于无人机位于初始导弹下方，故约束不明显，不做考虑。

另外较为明显的约束应当是

#figure(
  image("./figures/p6.png",width:99%),
  caption: [
    空间优化约束图示
  ],
) <figure-6>

从俯视图中可明显看出导弹位置与真目标连线是判定的关键，起爆后烟幕中心在俯视图中的位置$(tilde(x)_i^((j)) , tilde(y)_i^((j)))$保持恒定，只要烟幕位于连线右下方，则始终不会起到遮挡作用。

先要得到烟幕弹起爆位置坐标：

$
  tilde(O)_11 : cases(
    (x)_1^((1)) = 17800 + v_(d x)^((1)) dot.op (t_1^((1)) + t d_1^((1))),
    tilde(y)_1^((1)) = v_(d y)^((1)) dot.op (t_1^((1)) + t d_1^((1))),
    tilde(z)_1^((1)) = 1800 - 1 / 2 dot.op g (t d_1^((1)))^2 med
  )
$

以及起爆时刻的导弹位置坐标：

$
  M 1 : cases(
    x_m^((1)) = 20000 + v_(m x)^((1)) dot.op (t_1^((1)) + t d_1^((1))),
    y_m^((1)) = 0,
    z_m^((1)) = 2000 + v_(m z)^((1)) dot.op (t_1^((1)) + t d_1^((1))) med
  )
$

由于此时真目标的尺寸相较各方向的度量可以忽略不计，故以其底面圆心$T_b (0 , 200)$作为参考，得到直线$M 1 T_b$在$x O y$平面上的表达式：

$
  M 1 T_b : x / x_m^((1)) + y / 200 = 0 arrow.r 200 x + (20000 + v_(m x)^((1)) dot.op (t_1^((1)) + t d_1^((1)))) dot.op y = 0
$

故需要舍弃的劣解至少应满足：

$
    cases(
      200 dot.op (17800 + v_(d x)^((1)) dot.op (t_1^((1)) + t d_1^((1)))) + (20000 + v_(m x)^((1)) dot.op (t_1^((1)) + t d_1^((1)))) dot.op , (v_(d y)^((1)) dot.op (t_1^((1)) + t d_1^((1)))) > 0,
      frac(
        200 dot.op (17800 + v_(d x)^((1)) dot.op (t_1^((1)) + t d_1^((1)))) + (20000 + v_(m x)^((1)) dot.op (t_1^((1)) + t d_1^((1)))) dot.op (v_(d y)^((1)) dot.op (t_1^((1)) + t d_1^((1)))), sqrt(200^2 + (20000 + v_(m x)^((1)) dot.op (t_1^((1)) + t d_1^((1))))^2),
      ) > 10 med
    )
  $<func-3>


而对于正视图，需要排除的情况只有起爆烟幕最低点位于导弹上方的情况，即至少应满足：

$
  tilde(z)_1^((1)) - 10 > z_m^((1)) arrow.r 1800 - 1 / 2 dot.op g (t d_1^((1)))^2 - 10 > 2000 + v_(m z)^((1)) dot.op (t_1^((1)) + t d_1^((1)))
$<func-4>

=== 改进型遗传算法结合局部随机搜索最优解 <改进型遗传算法结合局部随机搜索最优解>

针对四个决策变量的优化，并不需要过于复杂的优化算法，但为了获取到较为精确的计算结果，本小问使用改进型遗传算法和局部正态随机搜索相结合的方式搜索全局最优解。

主要流程是先对决策变量进行二进制编码，根据各个变量不同的取值范围与精确度，确定各变量的二进制位个数 @YHXB202503017 。即先将有精度的数据放缩相应倍数得到整数，再逐个使用二进制进行编码，具体实现细节如@table-3：

#figure(
  table(
    columns: (15%, auto, auto, auto, 20%, auto),
    inset: 10pt,
    align: horizon,
    table.header([*决策变量符号*], [*决策变量含义*], [*取值范围*], [*编码位数*], [*二进制编码表示范围*], [*放缩倍率*]),
    [$v_(d x)^((1))$], [无人机沿x轴方向的分速度], [[-140,140]], [15], [[-16.384,16.383]], [100],

    [$v_(d y)^((1))$], [无人机沿y轴方向的分速度], [[-140,140]], [15], [[-16.384,16.383]], [100],

    [$t_1^((1))$], [投弹时间], [[0,30]], [15], [[0.000,32.767]], [1000],

    [$t d_1^((1))$], [爆炸延时], [[0,30]], [15], [[0.000,32.767]], [1000],
  ),
  caption: [决策变量编码表#footnote[*注*：投弹时间限制到约$30$s是由于无人机的运动速度较慢，如果在此时间内不投弹就不可能再有机会赶超空地导弹，也即不会对视线产生遮挡；而爆炸延时的$30$s限制是鉴于无人机高度有限，触地后便不再考虑。]],
)<table-3>
\

每组决策变量由$60$位二进制数组成，一位二进制数代表一个基因，每$15$位二进制数字串表示的一个决策变量对应成一个染色体，一组决策变量形成的$4$个染色体构成一个个体。

随后在限定范围内均匀随机生成足够多组的初始个体形成初始种群，再经过优化限制条件@func-3，@func-4，将这些个体所对应的解组合通过物理求解器求解得到对应的有效遮蔽时间，再根据遮蔽时间由大到小对这些个体进行排序，靠前的个体是更优的，将有更高的概率获得交配机会并将基因传递给下一代，反之则有更高的概率消逝夭折。

交配遗传的方式有很多，这里选择固定比例的方式，即初步筛选后排序前$5 %$的个体、$5 tilde.op 20 %$的个体、$20 tilde.op 50 %$的个体、后$50 %$的个体分别被选择为亲本的概率是$40 % , 30 % , 20 % , 10 %$，按照此概率从筛选后的个体群中选择2个个体作为亲本，此过程称为“#strong[选择];”。

选择亲本后交配得到一个新个体，子代产生方式使用保留、交叉遗传、变异相结合，该子代有$50 %$的概率与亲本其中之一（两个亲本机会均等）完全一致，$50 %$的概率发生染色体基因的交叉互换，交叉互换的方式如@figure-7，要求互换的基因片段是连续的，互换的基因个数范围是$5 tilde.op 7$，子代每条染色体的基因突变率是较小的，从高位到低位该突变率逐级递增，但总体维持较低水平，其具体取值作为参数以便于后续求解时随时调整，此过程称为“#strong[交叉与变异];”。

#figure(
  image(
    "figures/p7.png",width:80%
  ),
  caption: [基因交叉互换示意图（白色表示二进制数0，黑色表示二进制数1）],
) <figure-7>

得到的子代需要通过条件@func-3，@func-4 的筛选，通过不断进行亲本选择与交配，使符合条件的子代累积到某固定数量，随后与上一代亲本排序最靠前的一定数目的优质个体组合成为新一代。这一代再从亲本选择开始新的循环，直到特定的代际数目为止，整体流程@figure-8：

#figure(
  image(
    "figures/p8.png",
  ),
  caption: [改进型遗传算法流程图
  ],
) <figure-8>

无论是初始足够大的随机种群，还是交配时的基因突变，都能保证该算法在全局范围内搜索最优解。相较于传统遗传算法，改进点在于加入了优化的限制条件@func-3，@func-4，这使搜索与进化不再盲目，仅在可能出现最优解的区域进行搜索，也可加速整体的收敛速率。同时考虑到其突变的随机性和交叉的不稳定性，遗传算法在相对小范围可行域内的优化效果并不佳，即搜索精度不足，于是使用正态随机搜索法作为补充，当遗传算法确定了全局范围内的较优解时，再在优秀个体聚簇的多个区域逐个进行小范围随机搜索，并结合遗传算法的进化趋势，即算法倾向于选择哪个聚簇，实现优中选优，得到最优解。

=== 进化趋势可视化呈现与聚簇选择 <进化趋势可视化呈现与聚簇选择>
调用物理求解器以使用遗传算法，并得出各代最优解的有效遮蔽时间，绘制出的进化趋势如下@figure-9：

#figure(
  image("./figures/p9.png", width: 90%),
  caption: [
    进化过程的各代最优解
  ],
) <figure-9>

为了确定优秀个体的聚簇情况，均匀抽取$20$代种群中的$6$代，所有个体的遮蔽时间随无人机$x , y$轴方向分速度$v_(d x)^((1)) , v_(d y)^((1))$的分布情况热力图，如@figure-10（投弹时间$t_1^((1))$与起爆时间$t d_1^((1))$会进行自优化,即可理解为无人机的飞行速度与方向直接决定解的最优上限，同时为了便于绘图，这里不再讨论）：


通过进化趋势不难发现最优解的两个速度分量朝向区间$v_(d x)^((1)) : \[ 100 , 140 \] , v_(d y)^((1)) : \[ 8 , 15 \]$内靠拢，随后在此区间内利用$3 sigma$准则和正态分布规律确定局部正态随机搜索的参数，我们有很大可能确定整体在此问题上的最优解。

#figure(
  image("./figures/p10.png"),
  caption: [
    各代个体遮蔽时间随$v_(d x)^((1)) , v_(d y)^((1))$的分布热力图 #footnote[*注*：进化趋势热力图（颜色深浅表示速度区间块内所有有效个体遮蔽时间之和的大小）]
  ],
) <figure-10>

=== 问题2结果总结 <问题2结果总结>

经过遗传算法的进化迭代和优秀个体聚簇区域的局部随机搜索，得到的最优解如@table-4：

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header([], [*最长遮蔽时间*], [*x轴方向分速度*], [*y轴方向分速度*], [*投弹时间*], [*引爆延时*]),
    [*求解格式*], [4.5886], [135.58], [12.01], [0.9591], [0.0006],
    [], [*最长遮蔽时间*], [*飞行方向*], [*飞行速度*], [*投弹时间*], [*引爆延时*],
    [*题目格式*], [4.5886], [5.06], [136.11], [0.9591], [0.0006],
  ),
  caption: [求解结果对比表#footnote[*注*：时间单位：$s$；速度单位：$m\/s$；飞行方向指以$x$轴正向为起点，逆时针旋转为正方向，旋转到无人机飞行方向后的角度，单位为度$(degree)$， 后续过程单位均相同，不再说明。]],
)<table-4>

== 问题3的模型建立与求解 <问题3的模型建立与求解>

=== 模型表述 <模型表述>

与问题$2$不同，无人机FY1最多投放$3$枚烟幕干扰弹，该问题的决策变量为$v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1)) , t_1^((2)) , t d_1^((2)) , t_1^((3)) , t_1^((3))$共$8$个，相较于问题$2$增加一倍。三个烟幕干扰弹全过程对导弹M1的干扰时长为$t_1$，该时长也仅与$8$个决策变量有关，相应物理求解器的运行原理与问题$1 , 2$的完全一致，只是在判断是否遮挡导弹视线时需要计算三个烟幕云团的中心点，以及相应的判定距离，只要其中存在一个的判定距离满足$d lt.eq 10$，则视作被遮挡。另外增加的限制条件为相邻两弹的投弹时间间隔不小于$1$s。

即模型的总体表述为：
$ M a x med med med t_1 (v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1)) , t_1^((2)) , t d_1^((2)) , t_1^((3)) , t d_1^((3))) $

$ s . t . med med med cases(70 lt.eq sqrt(v_(d x)^(1)^2 + v_(d y)^(1)^2) lt.eq 140,
t_1^((1)) gt.eq 0,
t_1^((2)) gt.eq t_1^((1)) + 1,
t_1^((3)) gt.eq t_1^((2)) + 1,
t d_1^((1)) > 0 ,
t d_1^((2)) > 0 ,
t d_1^((3)) > 0) med $

=== 使用算数改进型遗传算法获取最优解邻域 <使用算数改进型遗传算法获取最优解邻域>

不同于问题$2$，上述提出的优化限制条件$(5 , 6)$不再适用，在不明确最优投弹策略的前提下该限制更有可能丢弃最优解。

同时鉴于@问题2的模型建立与求解 中使用到的二进制编码遗传算法搜索精度不高，并且染色体交叉互换、基因突变对实际数据造成的不稳定性过强，以及结合更高维度决策变量造成的庞大无效空间，对其进行算术化改进：

- 使用算数交叉法替换传统算法中染色体交叉互换的效果：

对两个亲本的同一染色体表示的数据加权作和，例如两个亲本同一染色体上的数据为$d a t a_1 , d a t a_2$，均匀随机生成一个位于$\[ 0 , 1 \]$的权重因子$beta$，则子代发生交叉后的数据为：

$ d a t a_3 = beta dot.op d a t a_1 + (1 - beta) dot.op d a t a_2 $

未发生交叉时子代与亲本保持一致。
- 使用高斯变异实现原算法中基因突变的效果：

按照一定概率对子代数据加入一定程度的噪声，噪声大小的标准差取在各变量整体取值范围的$2 %$.

- 锦标赛方式选择亲本：

亲本的选择不再是按照个体优劣的概率分配进行随机抽取，而是在整体种群中选择一定数量的个体，再对其优劣进行排序，找出最优个体，将重复两次后筛选出的两个个体作为亲本。

- 精英保留策略

保留上一代中固定数量的最优个体，与通过选择，交叉，变异产生的固定数量子代形成下一代。

- 多样性维护

如果种群内个体的差异过小，即种群多样性过低时，自动向其中注入随机新个体并替换掉其中的最差个体，以防止出现过早收敛的情况。

除限制条件移除外，其余基本与问题$(2)$保持一致，整体流程图如@figure-11：
#figure(
  image("./figures/p11.png", width: 80%),
  caption: [
    问题3算数改进型遗传算法流程图
  ],
) <figure-11>

利用该遗传算法得到的个体的遮蔽时间随无人机$x , y$轴方向分速度$v_(d x)^((1)) , v_(d y)^((1))$的分布情况热力图如下@figure-12：
#figure(
  image("./figures/p12.png", width: 90%),
  caption: [
    各代个体遮蔽时间随$v_(d x)^((1)) , v_(d y)^((1))$的分布热力图
  ],
) <figure-12>

=== 在最优解邻域内的局部正态随机搜索 <在最优解邻域内的局部正态随机搜索>

为弥补遗传算法搜索精度不高的缺陷，现利用其确定出的最优范围结合局部随机搜索法迭代求出最优解，主要流程是先以遗传算法得出的最优个体为中心，在方差给定的随机范围内搜索足够多的次数，排序得到该轮最优解；再以此最优解为中心，在方差更小的随机范围内搜索相同次数，排序，以此类推，直到迭代到预定次数后结束。

为更直观展示该随机搜索的求解过程，利用计算机绘制出的各轮最优遮蔽时间以及其所对应的$8$个决策变量随迭代的变化情况如@figure-13@figure-14：
#figure(
  image("./figures/p13.png", width: 95%),
  caption: [
    局部随机优化下各轮最优遮蔽时间随迭代次数的变化情况
  ],
) <figure-13>
#figure(
  image("./figures/p14.png"),
  caption: [局部随机优化下各轮最优遮蔽时间对应的8个决策变量两两分组后随迭代次数的变化情况#footnote[*注*：红色圆点表示起始点，红色五角星表示终止点，随迭代次数增加箭头颜色逐渐加深]],
) <figure-14>

=== 第3问结果总结 <第3问结果总结>

按照上述算法得到的最优解以及各决策变量的取值如@table-5：

#figure(
  align(
    center,
  )[#table(
      columns: (14.08%, 17.68%, 21.21%, 20.7%, 13.17%, 13.17%), align: (center, center, center, center, center, center,), table.header(table.cell(align: center)[最长

        遮蔽时间

      ], table.cell(align: center)[无人机$x$方向

        速度分量

      ], table.cell(align: center)[无人机$y$方向

        速度分量

      ], table.cell(align: center)[无人机

        飞行速度

      ], table.cell(align: center)[无人机

        飞行方向

      ], table.cell(align: center)[第一

        投弹时间

      ]), table.hline(), table.cell(align: center)[$ 7.6058$], table.cell(align: center)[$ -139.86$], table.cell(align: center)[$ 0.859$], table.cell(align: center)[$ 139.862$], table.cell(align: center)[$ 179.648$], table.cell(align: center)[$0.005 $], table.cell(align: center)[第一

        引爆延时

      ], table.cell(align: center)[第二

        投弹时间

      ], table.cell(align: center)[第二

        引爆延时

      ], table.cell(align: center)[第三

        投弹时间

      ], table.cell(align: center)[第三

        引爆延时

      ], table.cell(align: center)[], table.cell(align: center)[$ 3.611$], table.cell(align: center)[$3.737 $], table.cell(align: center)[$5.278 $], table.cell(align: center)[$ 5.575$], table.cell(align: center)[$ 6.0424$], table.cell(align: center)[],
    )], kind: table,
    caption: [第$3$问的最优解和决策变量]
)<table-5>

一并根据位移速度公式和物理求解器得出的抛放位置坐标和起爆位置坐标，以及有效干扰时长如附表result1.xlsx所示。

== 问题4的模型建立与求解 <问题4的模型建立与求解>

=== 模型描述 <模型描述>

导弹M1受到三架无人机FY1、FY2、FY3投弹的干扰，每架无人机最多投放一枚烟幕干扰弹，即决策变量为：

$ v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1)) ; v_(d x)^((2)) , v_(d y)^((2)) , t_2^((1)) , t d_2^((1)) ; v_(d x)^((3)) , v_(d y)^((3)) , t_3^((1)) , t d_3^((1)) $

导弹M1受到的干扰时间为$t_1$，除速度与时间非负性外无其余限制条件，故该模型可描述为：

$ M a x med med med t_1 (v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1)) ; v_(d x)^((2)) , v_(d y)^((2)) , t_2^((1)) , t d_2^((1)) ; v_(d x)^((3)) , v_(d y)^((3)) , t_3^((1)) , t d_3^((1))) $

$ s . t . med med med cases(70 lt.eq sqrt(v_(d x)^(1)^2 + v_(d y)^(1)^2) lt.eq 140,
70 lt.eq sqrt(v_(d x)^(2)^2 + v_(d y)^(2)^2) lt.eq 140,
70 lt.eq sqrt(v_(d x)^(3)^2 + v_(d y)^(3)^2) lt.eq 140,
t_1^((1)) >= 0 \, t_2^((1)) gt.eq 0 \, t_3^((1)) gt.eq 0,
t d_1^((1)) gt.eq 0 \, t d_2^((1)) gt.eq 0 \, t d_3^((1)) gt.eq 0) med $

=== 利用部分最优解合并全局解 <利用部分最优解合并全局解>

考虑到决策变量数目众多，维数众多以及有效解极其稀疏，不再进行全局遗传算法的求解，转而代替的是对三架无人机分别独立分析，考虑优化各自独立存在时对导弹M1的最长遮蔽时长，由于各无人机最多投放一枚烟幕弹，故第$i$架无人机投下的烟幕干扰弹对M1的遮蔽时长为$t^((i 1))$，且该时长仅由$v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1))$决定，此优化问题的类型与 @问题2的模型建立与求解 完全一致，利用相似的算法顺次得到三架无人机各自能够对导弹产生的最长的干扰时长，如@table-6：

#figure(
  align(
    center,
  )[#table(
      columns: (33.33%, 33.33%, 33.34%), align: (auto, auto, auto,), table.header(
        table.cell(align: center)[FY1的最长干扰时长], table.cell(align: center)[FY2的最长干扰时长], table.cell(align: center)[FY3的最长干扰时长],
      ), table.hline(), [$ 4.5886$], [$ 3.985$], [$ 3.171$],
    )], kind: table,
)<table-6>

将这些最优解直接组合后投入到物理求解器中进行计算，得到M1的干扰时长恰好为
#align(center)[#block[$ 11.7446 = 4.5886 + 3.985 + 3.171$]]
也即三个烟幕云团起作用的时间没有重合，这也侧面说明该时间难以再进行优化，为了继续验证，这里还是使用算术改进型遗传算法和局部搜索结合的形式再此基础上进行了优化，如@figure-15，发现没有更优解存在，即可认为得到了最优解。

#figure(
  image("./figures/p15.png", width: 60%),
  caption: [
    遗传算法优化改进最优解的趋势变化曲线（500轮迭代后未到达11.72）
  ],
) <figure-15>

=== 第4问结果总结 <第4问结果总结>

分别独立求解合并验证得出的最优解结果如@table-7：

#figure(
  align(
    center,
  )[#table(
      columns: (13.61%, 18.8%, 20.5%, 20.5%, 13.67%, 12.91%), align: (center, center, center, center, center, center,), table.header(
        table.cell(align: center)[], table.cell(align: center)[最长遮蔽时间], table.cell(align: center)[$x$轴方向分速度], table.cell(align: center)[$y$轴方向分速度], table.cell(align: center)[投弹时间], table.cell(align: center)[引爆延时],
      ), table.hline(), table.cell(align: center)[FY1], table.cell(align: center)[$ upright(bold(4.5886))$], table.cell(align: center)[$ upright(bold(135.58))$], table.cell(align: center)[$ upright(bold(12.01))$], table.cell(align: center)[$upright(bold(0.9591))$], table.cell(align: center)[$upright(bold(0.0006)) $], table.cell(align: center)[], table.cell(align: center)[最长遮蔽时间], table.cell(align: center)[$x$轴方向分速度], table.cell(align: center)[$y$轴方向分速度], table.cell(align: center)[投弹时间], table.cell(align: center)[引爆延时], table.cell(align: center)[FY2], table.cell(align: center)[$upright(bold(3.985)) $], table.cell(align: center)[$ upright(bold(99.48))$], table.cell(align: center)[$upright(bold(- 98.01)) $], table.cell(align: center)[$upright(bold(10.7293)) $], table.cell(align: center)[$ upright(bold(3.3112))$], table.cell(align: center)[], table.cell(align: center)[最长遮蔽时间], table.cell(align: center)[$x$轴方向分速度], table.cell(align: center)[$y$轴方向分速度], table.cell(align: center)[投弹时间], table.cell(align: center)[引爆延时], table.cell(align: center)[FY3], table.cell(align: center)[$upright(bold(3.171)) $], table.cell(align: center)[$upright(bold(40.11)) $], table.cell(align: center)[$ upright(bold(133.27))$], table.cell(align: center)[$upright(bold(23.1099))$], table.cell(align: center)[$ upright(bold(0.0763))$], table.cell(align: center, colspan: 2)[FY1], table.cell(align: center, colspan: 2)[FY2], table.cell(align: center, colspan: 2)[FY3], table.cell(align: center)[飞行速度], table.cell(align: center)[飞行方向], table.cell(align: center)[飞行速度], table.cell(align: center)[飞行方向], table.cell(align: center)[飞行速度], table.cell(align: center)[飞行方向], [$ upright(bold(136.11))$], [$upright(bold(5.06)) $], [$ upright(bold(139.65))$], [$ upright(bold(304.23))$], [$ upright(bold(139.18))$], [$upright(bold(73.25)) $],
    )], kind: table,
)<table-7>

一并根据位移速度公式和物理求解器得出的抛放位置坐标和起爆位置坐标，以及有效干扰时长如附表result2.xlsx所示。

== 问题5 <问题5>

=== 模型表述 <模型表述>

题目中要要求我们对五架无人机对三发导弹的优化策略，我们先绘制出这些点在空间中表示，如@figure-18 所示，可以看到无人机和导弹位置比较杂乱，变量维度较高，传统算法和现有模型比较难以解决

#figure(
  image("./figures/p18.png", width: 70%),
  caption: [
    空间中无人机和导弹的位置示意
  ],
) <figure-18>

优化目标应当是使烟幕干扰弹对各枚导弹的干扰时间$t_1 , t_2 , t_3$尽可能长，属于多目标优化问题，考虑到三枚导弹地位平等，可将这三个时间直接叠加作为优化目标，即三枚导弹所受到干扰时长总和，每架无人机的决策变量有8个，故总计40个决策变量，分别是：

$ v_(d x)^((1)) , v_(d y)^((1)) , t_1^((1)) , t d_1^((1)) , t_1^((2)) , t d_1^((2)) , t_1^((3)) , t d_1^((3)) ; v_(d x)^((2)) , v_(d y)^((2)) , t_2^((1)) , t d_2^((1)) , t_2^((2)) , t d_2^((2)) , t_2^((3)) , t d_2^((3)) ; \
v_(d x)^((3)) , v_(d y)^((3)) , t_3^((1)) , t d_3^((1)) , t_3^((2)) , t d_3^((2)) , t_3^((3)) , t d_3^((3)) ; v_(d x)^((4)) , v_(d y)^((4)) , t_4^((1)) , t d_4^((1)) , t_4^((2)) , t d_4^((2)) , t_4^((3)) , t d_4^((3)) ; \
v_(d x)^((5)) , v_(d y)^((5)) , t_5^((1)) , t d_5^((1)) , t_5^((2)) , t d_5^((2)) , t_5^((3)) , t d_5^((3)) ; $

其共同决定了$t_1 , t_2 , t_3$的取值，限制条件为投弹时间间隔约束、速度约束和时间非负性约束，故模型可表述为：

$ M a x med med med t_1 + t_2 + t_3 $

$ s . t . med med med cases(70 lt.eq sqrt(v_(d x)^((i))^2 + v_(d y)^((i))^2) lt.eq 140,
0 lt.eq t_i^((j)) lt.eq t_i^((j + 1)) - 1) med , i = 1 , 2 , dots.h , 5 ; j = 1 , 2 $

=== 策略限制与局部全局优化 <策略限制与部分解组合>

考虑到决策变量数目众多，维数众多以及有效解极其稀疏，在本问不再直接进行全局遗传算法的求解，转而代替的是对三架无人机分别独立分析，考虑优化各自独立存在时对三个导弹分别的最优遮蔽时长，然后使用使用一种在高维变量下表现更优的进化算法，即CMA-ES算法（Covariance Matrix Adaptation Evolution Strategy，协方差矩阵自适应进化策略）对限制后的变量进行全局优化求最优解。

通过之前的求解过程，我们可以借鉴一些思路进行无人机投弹策略限制：
- 在@问题3的模型建立与求解 中我们求解的过程是一架无人机投放三枚炸弹，其过程与当前独立局部优化过程类似，我们可以先使用@问题3的模型建立与求解 中的算数改进型遗传算法对独立优化进行大致求解
- @问题4的模型建立与求解 的过程为本题的简化过程，我们在求解过程中发现对独立个体的局部最优求解然后使用局部最优作为全局最优的初始条件，不会对结果产生不良的影响，即个体之间相互影响的因素并不是我们优化设计中需要解决的主要因素。
- 由@figure-18 观察各个无人机距离较远，距离无人机视线也较远，所以无人机对多个导弹干扰也并不是我们考虑的主要因素。

综上所述，我们采取的优化策略是，优先使用种族量设置较小的算数改进型遗传算法对于单架无人机对单个导弹的遮罩时间优化，由于无人机之间相互影响概率较小（即遮罩不会重合导致全局时长减小），我们可以把个体最优情况作为当前的全局最优情况。我们考虑到无人机距离较为离散，不妨设定初始优化策略，即单个无人机最优先遮罩一枚导弹，根据不同策略组合的情况，可以在这里确定我们期望的无人机遮挡策略。通过上述的初步规划，我们减少了决策变量的维度，需要规划的集中在各个无人机的速度和投弹、引爆时间。最后我们引入一种表现更优的CMA-ES算法，该算法能够在小种群多变量的环境下保持良好的性能，并且能够很好地拓展到大量并行计算的处理器上，提高运算效率@6790790，使用CMA-ES算法进行较高维度的全局优化，可以在一定程度上通过进化算法特性，优化我们在初步规划中没有考虑到的次要因素，从而进一步逼近全局最优。

在单个导弹的遮罩时间优化部分，题目中提到各无人机最多投放一枚烟幕弹，最多投放三枚烟幕弹，我们考虑到，对于局部个体的遗传算法来说，他会倾向于舍弃相对表现不优秀的解；所以在个体（一对一）情形下，投放三枚烟幕弹所取得的收益无论如何会比投放一枚要大。所以我们认为率先计算不同遮罩策略下，投放一枚和三枚可以较为全面地体现不同选择的优劣。

现分别以投$1、3$枚烟幕干扰弹作为前提，使用算数改进型遗传算法，分别计算任一架无人机以任一枚空地导弹作为干扰目标的最优干扰时长，共有$15$个策略待选组。在计算细节中，我们考虑到有$15$次优化，计算量偏大，所以我们对所有策略待选组，选用相同的小种族，较低迭代轮次的遗传迭代。这样虽然参数量小，可能迭代不出最优解，但是每个导弹对不同目标的相对干扰强度可以较为客观展现出来。我们将结果作成热力图形式，如@figure-16 展示

#figure(
  grid(
    columns: 2,
    gutter: 2pt,
    image("./figures/p16.png"), image("./figures/p17.png"),
    text("（a）仅投1枚干扰弹时，不同无人机对不同导弹的最佳干扰时长", size: 10pt), text("（b）投3枚干扰弹时，不同无人机对不同导弹的最佳干扰时长", size: 10pt)
  ),
  caption: [
    不同投放策略下，不同无人机对不同导弹的遮蔽时长
  ],
)<figure-16>


可以从@figure-16(b)中明显看出，FY1对M1干扰效果最佳，而且十分突出，可以使用@问题3的模型建立与求解 求出的最优结果就作为全局下F1-M1策略对的最优解，在后续全局优化可以简省这个策略对的决策变量。我们根据热力图中相对数目大小，可以认为FY2对M2相较于FY2其他方案较优，FY4对于M2较其他更优，FY5同理，FY5对M1遮罩效果比较好。

还剩下FY3的策略组，因为其个体差异性不是很明显，体现为三个色块颜色深浅类似，只考虑个体因素较难决策。我们转而考虑全局情况，目前M1和M2都被遮挡，但是M3未被遮挡，若FY3不遮挡M3，那么一个导弹被三架无人机遮挡，其间出现重叠概率会上升，并不利于全局最优，所以策略组尽量分散选择，因此我们确定FY3遮挡M3，更为合理，更有可能出现优解。就不妨确认这五个策略对和其对应局部最优的参数作为这五个无人机初始迭代条件：
#align(center)[#block[$F Y 1-M 1 ; F Y 2 -M 2 ;\ F Y 4-M 2; F Y 5-M 1; F Y 3-M 3$]]

基于我们初步的策略组和初始迭代条件，我们确定对于下一步遗传算法的目标函数
$ M a x med sum_5^() t^((i k)) \
s . t . med med med (i , k) in { (1 , 1) , (2 , 2) , (3 , 3) , (4 , 2) , (5 , 1) } med $


前文已经提到，这次的优化问题决策变量维数较高，传统算法难以迭代，于是在全局优化我们使用CMA-ES算法。该算法通过不断生成候选解并评估其优劣，以优质解的分布为依据，动态调整搜索中心（均值）、搜索范围（步长）和搜索形状（协方差矩阵），使搜索方向逐渐聚焦于最优解区域，无需手动调参即可自适应复杂优化问题的结构。经过实验验证，对于本问题可以产生良好的收敛效果，迭代过程的效果改进过程如@figure-19 所示

#figure(
  image("./figures/p20.png", width: 80%),
  caption: [
    CMA-ES算法下，最佳遮罩时间随轮次变化
  ],
) <figure-19>

从图中可以看到，其遮罩时间随着迭代稳步上升而且逐渐收敛，从最初解逐步收敛到全局最优，有相对比较大的提高，从其收敛的程度也可以证明我们最优解选取策略是有其实用意义的。

我们通过全局最优算法迭代出来的理论最优解，分别求各个无人机对不同导弹的遮罩时间，来初步验证是否会出现无人机遮挡非策略组内导弹的事件，结果如@figure-20 所示，我们发现其实该种方式优化出来的策略和解并不会发生无人机之间相互干扰的情况，再一次证明了我们初始假设的合理性，以及我们全局最优算法的优势。

#figure(
  image("./figures/p19.png", width: 50%),
  caption: [
    所有配置遮挡时间热力图
  ],
) <figure-20>

=== 第5问结果总结

经过上述计算，我们的得出了如@table-5-5 的最优规划参数：
#figure(
  table(
  columns: 7,
  align: center,
  stroke: (x, y) => (
    top: if y <= 1 { 1pt } else { 0.5pt },
    bottom: 0.5pt,
    left: none,
    right: none,
  ),
  inset: 8pt,

  // 复合表头 - 第一行
  table.cell(rowspan: 2)[*无人机编号*],
  table.cell(rowspan: 2)[*运动方向 (°)*],
  table.cell(rowspan: 2)[*运动速度 (m/s)*],
  table.cell(colspan: 3)[*投弹信息*],
  table.cell(rowspan: 2)[*总有效干扰时长 (s)*],

  // 复合表头 - 第二行（子表头）
  [*投弹ID*], [*投弹时间 (s)*], [*爆炸时间 (s)*],

  // FY1 数据
  table.cell(rowspan: 3)[FY1],
  table.cell(rowspan: 3)[179.64],
  table.cell(rowspan: 3)[139.79],
  [1], [0.00], [3.68],
  table.cell(rowspan: 3)[7.55],
  [2], [3.26], [8.49],
  [3], [5.40], [11.36],

  // FY2 数据
  table.cell(rowspan: 3)[FY2],
  table.cell(rowspan: 3)[280.31],
  table.cell(rowspan: 3)[138.70],
  [1], [3.98], [7.07],
  table.cell(rowspan: 3)[3.93],
  [2], [5.76], [9.65],
  [3], [32.57], [49.64],

  // FY3 数据
  table.cell(rowspan: 3)[FY3],
  table.cell(rowspan: 3)[92.09],
  table.cell(rowspan: 3)[130.88],
  [1], [18.36], [22.12],
  table.cell(rowspan: 3)[2.93],
  [2], [24.86], [45.79],
  [3], [39.39], [54.71],

  // FY4 数据
  table.cell(rowspan: 3)[FY4],
  table.cell(rowspan: 3)[295.29],
  table.cell(rowspan: 3)[119.39],
  [1], [4.77], [14.80],
  table.cell(rowspan: 3)[3.74],
  [2], [19.26], [25.98],
  [3], [38.46], [42.33],

  // FY5 数据
  table.cell(rowspan: 3)[FY5],
  table.cell(rowspan: 3)[109.05],
  table.cell(rowspan: 3)[113.43],
  [1], [15.25], [18.86],
  table.cell(rowspan: 3)[3.77],
  [2], [18.11], [45.31],
  [3], [53.45], [68.90],
),
caption: [第$5$问优化参数及有效干扰时长]
) <table-5-5>

根据最优规划参数，使用求解器计算，总遮罩时长为：
#align(center)[#block[$sum_(k=1)^3  t_k = 22.9218$]]

= 模型优缺点分析 <五模型优缺点分析>

== 模型优点 <模型优点>

#block[
  #set enum(numbering: "1)", start: 1)
  + 物理求解器与迭代层分离，逻辑清晰，易于编写优化算法

  + 精英保留策略下的遗传算法能够获取到全局范围内的最优解范围，且有较强的收敛性和较高的求解精度 @DGLG202203010

  + 遗传进化策略与局部随机搜索策略相结合可以起到优势互补的作用，既有遗传算法所具有全局最优趋势，也有局部正态随机迭代在搜索精度上的优势 @XTYY202008033
]

== 模型劣势 <模型劣势>

#block[
  #set enum(numbering: "1)", start: 1)
  + 遗传算法时间复杂度较高，单轮迭代所耗费时间较长

  + 遗传算法作为随机搜索算法并不稳定，尤其是传统染色体仿真型算法具有较高的不稳定性
]



#pagebreak()
#bib(bibliography("refs.bib"))

#pagebreak()

#appendix(
  "支撑材料列表",

  [
#table(
  columns: (1fr, 2fr),
  stroke: none,
  align: left,
  table.hline(stroke: 1pt),
  table.header([*文件/目录*], [*说明*]),
  table.hline(stroke: 0.5pt),

  [`backup/question_<id>`], [`id=1、2、3` 传统遗传算法代码],
  [`cma_es`], [CMA-ES算法求解第五问],
  [`init_params`], [遗传算法初始值],
  [`jianmo`], [复杂遗传算法代码],
  [`physical_solver`], [高性能物理求解器],
  [`pysrc`], [上述`backup`整理出的代码，其程序入口在`run_ga.py`],
  [`question_<id>`], [解决`question_<id> id=2、3`时的日志],
  [`AI工具使用详情.pdf`], [AI工具的使用记录],
  [`draw_heatmap.py`], [绘制无人机与导弹的热力图],
  [`result_<id>.xlsx`], [题目要求的三个结果表格],
  [`*.png`], [上述`question_<id>`对应的热力图],
  [`test.json`], [测试用例],
  table.hline(stroke: 1pt),
)


  ],
)

#appendix(
  "物理求解器核心 - Rust 源程序",

  ```rust
    /// 检查导弹是否被完全遮挡 - 使用预计算点
    #[inline]
    fn is_missile_completely_shadowed(
        &self,
        missile_pos: (f64, f64, f64),
        current_time: f64,
    ) -> bool {
        // 使用预计算的圆柱采样点
        for &target_point in self.cylinder_sample_points.iter() {
            if !self.is_sight_line_blocked(target_point, missile_pos, current_time) {
                return false;
            }
        }
        true
    }

    /// 检查视线是否被遮挡 - 高度优化版本
    #[inline]
    fn is_sight_line_blocked(
        &self,
        target_point: (f64, f64, f64),
        missile_pos: (f64, f64, f64),
        current_time: f64,
    ) -> bool {
        // 预计算常量
        const SMOKE_SINK_SPEED: f64 = 3.0;
        const SMOKE_RADIUS_SQ: f64 = 100.0; // 10.0^2

        // 使用预计算的烟幕数据，早期退出优化
        for smoke in self.smoke_data.iter() {
            // 快速检查烟幕球是否在当前时间有效
            if current_time < smoke.generation_time || current_time > smoke.valid_until {
                continue;
            }

            // 计算烟幕球当前位置（下沉3m/s）
            let delta_time = current_time - smoke.generation_time;
            let smoke_center = (
                smoke.explosion_x,
                smoke.explosion_y,
                smoke.explosion_z - SMOKE_SINK_SPEED * delta_time,
            );

            // 检查视线是否被这个烟幕球遮挡
            if self.is_line_blocked_by_smoke_fast(
                target_point,
                missile_pos,
                smoke_center,
                SMOKE_RADIUS_SQ,
            ) {
                return true;
            }
        }
        false
    }

    /// 检查线段是否被球体遮挡 - 高度优化版本，传入半径平方
    #[inline]
    fn is_line_blocked_by_smoke_fast(
        &self,
        point_a: (f64, f64, f64),
        point_b: (f64, f64, f64),
        center: (f64, f64, f64),
        radius_sq: f64,
    ) -> bool {
        let (ax, ay, az) = point_a;
        let (bx, by, bz) = point_b;
        let (cx, cy, cz) = center;

        let dx = bx - ax;
        let dy = by - ay;
        let dz = bz - az;

        let fx = cx - ax;
        let fy = cy - ay;
        let fz = cz - az;

        let line_length_sq = dx * dx + dy * dy + dz * dz;

        // 优化：如果线段长度为0，直接计算点到球心距离
        if line_length_sq < 1e-10 {
            let dist_sq = fx * fx + fy * fy + fz * fz;
            return dist_sq <= radius_sq;
        }

        // 计算投影参数
        let dot_product = fx * dx + fy * dy + fz * dz;
        let t = (dot_product / line_length_sq).clamp(0.0, 1.0);

        // 计算最近点到球心的距离平方
        let nearest_x = ax + t * dx;
        let nearest_y = ay + t * dy;
        let nearest_z = az + t * dz;

        let dist_x = nearest_x - cx;
        let dist_y = nearest_y - cy;
        let dist_z = nearest_z - cz;
        let dist_sq = dist_x * dist_x + dist_y * dist_y + dist_z * dist_z;

        dist_sq <= radius_sq
    }
  ```,
)

#appendix(
  "遗传算法 - Python源程序",
[
```py
def genetic_algorithm(generation):
    # 读取 parent
    csv_path = os.path.join("parent", f"parent_g{generation}.csv")
    if not os.path.exists(csv_path):
        print("parent csv not found")
        return

    with open(csv_path, "r") as f:
        reader = csv.reader(f)
        header = next(reader)
        data = list(reader)

    # 定义染色体
    chromosomes = []
    for row in data:
        v_x, v_y, time_val, delta_t = (
            float(row[2]),
            float(row[3]),
            float(row[4]),
            float(row[5]),
        )
        # 转换为二进制
        vx_bin = _float_to_bin(v_x, VX_MIN, VX_MAX, VX_BITS)
        vy_bin = _float_to_bin(v_y, VY_MIN, VY_MAX, VY_BITS)
        time_bin = _float_to_bin(time_val, TIME_MIN, TIME_MAX, TIME_BITS)
        delta_bin = _float_to_bin(delta_t, DELTA_T_MIN, DELTA_T_MAX, DELTA_T_BITS)
        chromosomes.append((vx_bin, vy_bin, time_bin, delta_bin))

    # 生成5000个子代
    offspring = []
    for _ in range(600):
        # 亲本选取
        parent1 = _select_parent(chromosomes)
        parent2 = _select_parent(chromosomes)

        # 交叉
        child = _crossover(parent1, parent2)

        # 变异
        child = _mutate(child)

        offspring.append(child)

    # 将子代转换为参数，生成JSON
    folder = os.path.join("offspring", f"g{generation}")
    os.makedirs(folder, exist_ok=True)
    for i, chrom in enumerate(offspring):
        v_x = _bin_to_float(chrom[0], VX_MIN, VX_MAX, VX_BITS)
        v_y = _bin_to_float(chrom[1], VY_MIN, VY_MAX, VY_BITS)
        time_val = _bin_to_float(chrom[2], TIME_MIN, TIME_MAX, TIME_BITS)
        delta_t = _bin_to_float(chrom[3], DELTA_T_MIN, DELTA_T_MAX, DELTA_T_BITS)

        # 生成JSON
        data = {
            "drone": [
                {
                    "id": 1,
                    "v_x": round(v_x, 2),
                    "v_y": round(v_y, 2),
                    "x": 17800.0,
                    "y": 0.0,
                    "z": 1800.0,
                    "drop_t_abs": [
                        {
                            "id": 1,
                            "time": round(time_val, 4),
                            "delta_t": round(delta_t, 4),
                        }
                    ],
                }
            ],
            "missile": [{"id": 1, "x": 20000.0, "y": 0.0, "z": 2000.0}],
        }

        filename = os.path.join(folder, f"raw_{i+1}.json")
        with open(filename, "w") as f:
            json.dump(data, f, indent=4)
    print(f"Generation {generation} offspring generated.")
```
]
)

#appendix(
  "绘制热力图 - Python源程序",
[```py
def create_heatmap(basedir, drones=None, missiles=None, save_path=None):
    """
    创建fyX和msX的热力图

    Args:
        basedir: 包含数据的基础目录
        drones: drone列表，默认为['fy1', 'fy2', 'fy3', 'fy4', 'fy5']
        missiles: missile列表，默认为['ms1', 'ms2', 'ms3']
        save_path: 保存图片的路径，如果为None则只显示不保存
    """
    if drones is None:
        drones = ["fy1", "fy2", "fy3", "fy4", "fy5"]

    if missiles is None:
        missiles = ["ms1", "ms2", "ms3"]

    # 创建数据矩阵
    data_matrix = np.full((len(missiles), len(drones)), np.nan)

    # 填充数据矩阵
    for i, missile in enumerate(missiles):
        for j, drone in enumerate(drones):
            fitness = load_best_fitness(basedir, drone, missile)
            if fitness is not None:
                data_matrix[i, j] = fitness

    # 检查是否有有效数据
    valid_data_count = np.sum(~np.isnan(data_matrix))
    if valid_data_count == 0:
        print("错误: 没有找到任何有效的best_fitness数据")
        return

    print(f"成功加载 {valid_data_count}/{len(drones)*len(missiles)} 个数据点")

    # 创建热力图
    plt.figure(figsize=(10, 6))

    # 使用seaborn绘制热力图
    mask = np.isnan(data_matrix)  # 创建mask来处理缺失数据

    ax = sns.heatmap(
        data_matrix,
        xticklabels=drones,
        yticklabels=missiles,
        annot=True,
        fmt=".4f",
        cmap="Blues",
        mask=mask,
        cbar_kws={"label": "Best Fitness"},
        square=False,
    )

    # 设置标题和标签
    plt.title("Drone vs Missile Best Fitness Heatmap", fontsize=16, fontweight="bold")
    plt.xlabel("Drone ID (fyX)", fontsize=12)
    plt.ylabel("Missile ID (msX)", fontsize=12)

    # 旋转x轴标签以便更好显示
    plt.xticks(rotation=0)
    plt.yticks(rotation=0)

    # 调整布局
    plt.tight_layout()

    # 保存或显示
    if save_path:
        plt.savefig(save_path, dpi=300, bbox_inches="tight")
        print(f"热力图已保存到: {save_path}")

    plt.show()
```]
)

#appendix(
  "遗传算法 - Python源程序",
[```py

class Question2Individual(Individual):
    """问题2的个体类，包含速度、角度、时间和delta_t参数"""

    def __init__(self, speed=None, angle=None, time=None, delta_t=None):
        super().__init__()

        # 问题2的参数范围
        self.param_ranges = {
            "speed": (70.0, 140.0),
            "angle": (-math.pi, math.pi),
            "time": (0.0, 30.0),
            "delta_t": (0.0, 10.0),
        }

        if speed is None:
            # 随机初始化
            self.speed = random.uniform(*self.param_ranges["speed"])
            self.angle = random.uniform(*self.param_ranges["angle"])
            self.time = random.uniform(*self.param_ranges["time"])
            self.delta_t = random.uniform(*self.param_ranges["delta_t"])
        else:
            # 使用给定参数
            self.speed = max(
                self.param_ranges["speed"][0], min(self.param_ranges["speed"][1], speed)
            )
            self.angle = self._normalize_angle(angle)
            self.time = max(
                self.param_ranges["time"][0], min(self.param_ranges["time"][1], time)
            )
            self.delta_t = max(
                self.param_ranges["delta_t"][0],
                min(self.param_ranges["delta_t"][1], delta_t),
            )

    def _normalize_angle(self, angle):
        """角度归一化到[-π, π]"""
        while angle > math.pi:
            angle -= 2 * math.pi
        while angle <= -math.pi:
            angle += 2 * math.pi
        return angle

    def get_velocity_components(self):
        """将速度大小和角度转换为v_x和v_y分量"""
        v_x = self.speed * math.cos(self.angle)
        v_y = self.speed * math.sin(self.angle)
        return v_x, v_y

    def to_dict(self):
        """转换为字典格式"""
        v_x, v_y = self.get_velocity_components()
        return {
            "speed": self.speed,
            "angle": self.angle,
            "v_x": v_x,
            "v_y": v_y,
            "time": self.time,
            "delta_t": self.delta_t,
            "fitness": self.fitness,
        }

    def mutate(self):
        """变异操作"""
        mutation_rate = GA_CONFIG["mutation_rate"]

        if random.random() < mutation_rate:
            # 速度变异
            self.speed += random.gauss(0, 2.0)
            self.speed = max(
                self.param_ranges["speed"][0],
                min(self.param_ranges["speed"][1], self.speed),
            )

        if random.random() < mutation_rate:
            # 角度变异
            self.angle += random.gauss(0, 0.05)
            self.angle = self._normalize_angle(self.angle)

        if random.random() < mutation_rate:
            # 时间变异
            self.time += random.gauss(0, 0.1)
            self.time = max(
                self.param_ranges["time"][0],
                min(self.param_ranges["time"][1], self.time),
            )

        if random.random() < mutation_rate:
            # delta_t变异
            self.delta_t += random.gauss(0, 0.2)
            self.delta_t = max(
                self.param_ranges["delta_t"][0],
                min(self.param_ranges["delta_t"][1], self.delta_t),
            )

    def is_valid(self):
        """检查个体是否有效"""
        return (
            self.param_ranges["speed"][0] <= self.speed <= self.param_ranges["speed"][1]
            and self.param_ranges["time"][0]
            <= self.time
            <= self.param_ranges["time"][1]
            and self.param_ranges["delta_t"][0]
            <= self.delta_t
            <= self.param_ranges["delta_t"][1]
        )

    def copy(self):
        """复制个体"""
        new_individual = Question2Individual(
            speed=self.speed, angle=self.angle, time=self.time, delta_t=self.delta_t
        )
        new_individual.fitness = self.fitness
        return new_individual


class Question2GeneticAlgorithm(GeneticAlgorithmBase):
    """问题2的遗传算法实现"""

    def __init__(self, drone_id, missile_id):
        self.drone_id = drone_id
        self.missile_id = missile_id

        # 加载对应的初始参数
        init_params_path = get_init_params_path(2, drone_id, missile_id)

        super().__init__(question_id=2, base_config_path=init_params_path)

        # 更新路径以使用新的结构
        self.combination_path = get_combination_path(2, drone_id, missile_id)
        self.task_path = get_task_path(2, self.task_id, drone_id, missile_id)
        self.best_json_path = get_best_json_path(2, drone_id, missile_id)
        self.best_result_path = get_best_result_path(2, drone_id, missile_id)

        # 创建任务目录和组合目录
        os.makedirs(self.combination_path, exist_ok=True)
        os.makedirs(self.task_path, exist_ok=True)
        os.makedirs(os.path.join(self.task_path, "results"), exist_ok=True)
        os.makedirs(os.path.join(self.task_path, "generations"), exist_ok=True)

        # 创建可视化目录
        self.viz_path = get_visualization_path(2, self.task_id, drone_id, missile_id)
        os.makedirs(self.viz_path, exist_ok=True)

    def create_individual(self, **kwargs):
        """创建个体实例"""
        return Question2Individual(**kwargs)

    def generate_task_config(self, individual):
        """生成任务配置"""
        # 复制基础配置
        config = copy.deepcopy(self.base_config)

        # 获取速度分量
        v_x, v_y = individual.get_velocity_components()

        # 更新参数
        if "drone" in config and len(config["drone"]) > 0:
            config["drone"][0]["v_x"] = float(v_x)
            config["drone"][0]["v_y"] = float(v_y)

            if (
                "drop_t_abs" in config["drone"][0]
                and len(config["drone"][0]["drop_t_abs"]) > 0
            ):
                config["drone"][0]["drop_t_abs"][0]["time"] = float(individual.time)
                config["drone"][0]["drop_t_abs"][0]["delta_t"] = float(
                    individual.delta_t
                )

        return config

    def calculate_fitness(self, result):
        """计算适应度"""
        try:
            # 检查result是否为None
            if result is None:
                return float("-inf")

            # 如果result直接是数值类型
            if isinstance(result, (int, float)):
                fitness_value = float(result)
                if math.isfinite(fitness_value):
                    return fitness_value
                else:
                    return float("-inf")

            # 如果result是字典类型
            if isinstance(result, dict):
                # 从结果中提取拦截时间作为适应度
                if "intercept_time" in result and result["intercept_time"] is not None:
                    intercept_time = float(result["intercept_time"])
                    # 拦截时间越长适应度越高
                    return intercept_time
                elif "result" in result and result["result"] is not None:
                    fitness_value = float(result["result"])
                    if math.isfinite(fitness_value):
                        return fitness_value
                    else:
                        return float("-inf")
                else:
                    return float("-inf")

            # 其他情况返回最低适应度
            return float("-inf")

        except (ValueError, KeyError) as e:
            print(f"计算适应度时出错: {e}")
            return float("-inf")

    def crossover(self, parent1, parent2):
        """交叉操作"""
        if random.random() > self.crossover_rate:
            return parent1.copy(), parent2.copy()

        # 算术交叉
        alpha = random.random()

        child1 = Question2Individual(
            speed=alpha * parent1.speed + (1 - alpha) * parent2.speed,
            angle=alpha * parent1.angle + (1 - alpha) * parent2.angle,
            time=alpha * parent1.time + (1 - alpha) * parent2.time,
            delta_t=alpha * parent1.delta_t + (1 - alpha) * parent2.delta_t,
        )

        child2 = Question2Individual(
            speed=(1 - alpha) * parent1.speed + alpha * parent2.speed,
            angle=(1 - alpha) * parent1.angle + alpha * parent2.angle,
            time=(1 - alpha) * parent1.time + alpha * parent2.time,
            delta_t=(1 - alpha) * parent1.delta_t + alpha * parent2.delta_t,
        )

        return child1, child2

    def save_best_result_with_params(self):
        """保存最优解结果，包含速度+角度组合参数"""
        if self.best_individual is None:
            return

        # 运行一次最优个体以获取详细结果
        best_task_id = f"best_{self.task_id}"
        best_config = self.generate_task_config(self.best_individual)
        task_configs = {best_task_id: best_config}
        results = self.run_physical_solver_batch(task_configs)

        if best_task_id in results and results[best_task_id] is not None:
            result_value = results[best_task_id]

            # 创建包含参数信息的结果
            result = {
                "result": result_value,
                "optimization_params": {
                    "drone_id": self.drone_id,
                    "missile_id": self.missile_id,
                    "speed": self.best_individual.speed,
                    "angle": self.best_individual.angle,
                    "angle_degrees": math.degrees(self.best_individual.angle),
                    "time": self.best_individual.time,
                    "delta_t": self.best_individual.delta_t,
                    "fitness": self.best_individual.fitness,
                },
            }

            # 保存到best_result.json
            with open(self.best_result_path, "w", encoding="utf-8") as f:
                json.dump(result, f, indent=2, ensure_ascii=False)
            print(f"最优解详细结果已保存到: {self.best_result_path}")
```]
)
