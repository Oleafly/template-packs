// ============================================================
// 天津理工大学本科毕业设计说明书（毕业论文）—— Typst 示例主文件
// 编译：typst compile --font-path ./fonts main.typ
// 实时预览：typst watch --font-path ./fonts main.typ
// typst.app 网页版：连同 fonts/ 目录一并上传，无需其它设置
//
// Copyright (c) 2026 seatres (https://github.com/seatres)
// 依据 LaTeX Project Public License 1.3c（或更新版本）发布；许可全文见 LICENSE。
// ============================================================
#import "tjutthesis.typ": *

// 全文格式（页面、字体、标题、图表、公式编号）
#show: tjut-thesis

// ---------- 中文标题 / 摘要 / 关键词 ----------
// 单人课题去掉 subtitle 一行即可
#cn-abstract(
  title: "考虑电机特性的凸轮分度机构动力学研究",
  subtitle: "实验研究与动力学模型",
  keywords: ("分度凸轮", "动力学", "模型"),
)[
  本文针对凸轮分度机构进行了动力学理论和实验研究，针对机构特点建立了机构多自由度动力学模型。在此基础上分析了系统的固有特性与动态响应，并通过实验验证了模型的正确性。研究结果表明……（中文摘要一般在300--800 字以内，不加注释和评论，应具有独立性和自含性。）
]

// ---------- 英文标题 / 摘要 / 关键词（与中文摘要不另起新页） ----------
#en-abstract(
  title: "On the Dynamics of Indexing Cam Mechanisms with Motor Characteristics",
  subtitle: "Experimental Research and Dynamic Model",
  keywords: ("Indexing Cam", "Dynamics", "Model"),
)[
  Analytical and experimental research on the dynamics of indexing cam
  mechanisms is presented in this thesis. A multi-degree-of-freedom dynamic
  model is established according to the characteristics of the mechanism...
]

// ---------- 目录 ----------
#toc()

// ---------- 正文开始（页码从 1 起，页眉出现；改成实际届别） ----------
#show: mainmatter.with(grad-year: "2026")

= 绪论
// 一级标题自动排成“第一章 绪论”（三号黑体居中，自动另起一页）

本章介绍选题的理由、课题主要解决的问题，采用的手段、方法，简述研究成果及其意义。正文汉字为小四号宋体，英文、数字为 Times New Roman，行距 1.25 倍，每个段落首行自动缩进两个汉字。

正文中引用参考文献应在引用处加方括号注明文献号码，作为上角标，如某某人对此作了研究#super[\[1\]]；也可作为文字段落的组成部分，如数学模型见文献 [2]。

== 研究背景与意义
// 二级标题自动排成“1.1 研究背景与意义”（小三号黑体居中）

这里是节下的正文内容。

=== 国内研究现状
// 三级标题自动排成“1.1.1 国内研究现状”（四号黑体左起），最多三级

这里是小节下的正文内容。

// 小节内小标题：黑体小四单列一行、缩进两个汉字，序号用 1、2、3……自行书写
// （注意用顿号“1、”；若要写“1.”需转义成“1\.”，否则会被解析成有序列表）
#minisection[1、机构动力学等效集中参数模型]

将机构连续参数（质量和刚度连续分布）离散化，用有限多个自由度表示。

// 段落标题：宋体加黑小四；段内序号依次用⑴⑵⑶、A B C、a b c
（1）#paratitle[建模假设]#h(1em)建立动力学模型过程中作如下假设：A. 凸轮机构各构件无制造安装误差；B. 凸轮为刚体；C. 考虑凸轮输入轴扭转弹性，但输入转速为常数。

=== 国外研究现状

这里是小节下的正文内容。

== 本文主要研究内容

这里是节下的正文内容。

= 凸轮分度机构的实验研究

== 实验系统的组成

图应尽可能置于某页的开始或结尾，并且在图之前的文字段落中有“如图 x.x”的字样，如@fig-demo 所示。图中的标注一律采用中文，图题（五号楷体）紧接图的下一行居中打印，图号按章顺序编号。

#figure(
  // 实际使用时替换为：image("figures/你的图.png", width: 60%)
  rect(width: 50%, height: 5cm, fill: luma(240), stroke: 0.5pt)[
    #align(center + horizon)[示例图片占位]
  ],
  caption: [实验系统组成示意图],
) <fig-demo>

== 实验数据与分析

表应尽可能置于某页的开始或结尾，并且在表之前的文字段落中有“如表 x.x”的字样，如@tab-demo 所示。表标题（五号楷体）置于表的上方居中，表内文字为五号；表内不用“同上”“同左”等词，空白代表无此项内容。

#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(stroke: 1pt),
    [序号], [转速/(r/min)], [扭矩/(N·m)], [温升/℃],
    table.hline(stroke: 0.5pt),
    [1], [1000], [12.5], [8.2],
    [2], [1500], [13.1], [10.6],
    [3], [2000], [13.8], [13.4],
    table.hline(stroke: 1pt),
  ),
  caption: [实验测试结果],
) <tab-demo>

数学、物理和化学式在正文中另起一行打印，式的序号按章顺序编排并标注在该行最右边，如@eq-demo：

$ m dot.double(x) + c dot(x) + k x = F(t) $ <eq-demo>

式中：$m$ 为等效质量；$c$ 为阻尼系数；$k$ 为刚度；$F(t)$ 为激励力。较长的式另行居中横排；如必须转行，只能在 $+$、$-$、$times$、$div$、
$<$、$>$ 处转行，上下式尽可能在等号“$=$”处对齐。

= 结论

对本人所做工作进行归纳和综合，得到设计或研究的结论。与已有结果进行比较，指明所得结论的新进展，并对该课题尚应进一步改进与研究的方向提出建议。文字要简单、明确。

// ---------- 参考文献（自动另起一页；每条用 + 开头自动编号 [1][2]…；
//             “前引后列”：按正文引用先后排序，著录格式按 GB/T 7714-2015） ----------
#references[
  + 张三，李四，王五，等. 凸轮分度机构动力学建模与仿真研究[J]. 机械工程学报，2024，60(3):45-52.
  + 赵六. 高速凸轮机构动态特性分析[D]. 天津:天津理工大学，2023.
  + 孙七. 机械原理[M]. 3版. 北京:机械工业出版社，2021:120-135.
  + 周八. 工业凸轮机构设计手册[EB/OL]. (2023-05-12)[2026-03-01]. https:\/\/www.example.com/cam-handbook.
  + Smith J, Brown K, Davis M, et al. Dynamic analysis of indexing cam mechanisms[J]. Mechanism and Machine Theory, 2023, 180: 105-118.
]

// ---------- 附录（无附录可整段删除；标题自动编为“附录1 ×××”） ----------
#show: appendix

= 主要程序清单

这里放置较复杂的公式推演、计算机程序等内容（中文 5 号宋体，行距固定18 磅）。

// ---------- 致谢（自动另起一页，页眉到此结束） ----------
#acknowledgements[
  以简短的文字对指导教师和协助完成设计（论文）的人员表示谢意。感谢×××老师在毕业设计期间给予的悉心指导……
]
