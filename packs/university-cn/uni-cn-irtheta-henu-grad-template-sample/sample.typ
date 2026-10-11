#import "template.typ": *
#import "@preview/codelst:2.0.2": sourcecode
#show: setup-lovelace

#let algorithm = algorithm.with(supplement: "算法")

// ============ step 1 基本信息 ============ //
#show: project.with(
  anonymous: false,
  unit_code: "你的单位号",
  id: "你的学号",
  category_code: "你的分类号", 
  title_zh: "基于Typst所构建的河大博士论文模板的参考题目及加长版",
  college_name: "化学与分子科学学院",
  discipline_major: "化学、材料化学",
  research_area: "你的研究领域",
  applied_degree_zh: "你要的学位",
  applicant_zh: "你",
  supervisor_zh: "你的老板",
  date_zh: ("二〇二六", "六"),
  title_en: "your title in english",
  applied_degree_en: "Your wanted degree", 
  applicant_en: "Your name in english",
  supervisor_en: "Prof. Your Boss",
  date_en: ("2026", "Jun"),
  abstract_zh: [
    壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵“明月”之诗，歌“窈窕”之章。少焉，月出于东山之上，徘徊于斗牛之间。白露横江，水光接天。纵一苇之所如，凌万顷之茫然。浩浩乎如冯虚御风，而不知其所止；飘飘乎如遗世独立，羽化而登仙。

    于是饮酒乐甚，扣舷而歌之。歌曰：“桂棹兮兰桨，击空明兮溯流光。渺渺兮予怀，望美人兮天一方。”客有吹洞箫者，倚歌而和之。其声呜呜然，如怨如慕，如泣如诉，余音袅袅，不绝如缕。舞幽壑之潜蛟，泣孤舟之嫠妇。

    苏子愀然，正襟危坐而问客曰：“何为其然也？”客曰：“‘月明星稀，乌鹊南飞’，此非曹孟德之诗乎？西望夏口，东望武昌，山川相缪，郁乎苍苍，此非孟德之困于周郎者乎？方其破荆州，下江陵，顺流而东也，舳舻千里，旌旗蔽空，酾酒临江，横槊赋诗，固一世之雄也，而今安在哉？况吾与子渔樵于江渚之上，侣鱼虾而友麋鹿，驾一叶之扁舟，举匏樽以相属。寄蜉蝣于天地，渺沧海之一粟。哀吾生之须臾，羡长江之无穷。挟飞仙以遨游，抱明月而长终。知不可乎骤得，托遗响于悲风。”

    苏子曰：“客亦知夫水与月乎？逝者如斯，而未尝往也；盈虚者如彼，而卒莫消长也。盖将自其变者而观之，则天地曾不能以一瞬；自其不变者而观之，则物与我皆无尽也，而又何羡乎！且夫天地之间，物各有主，苟非吾之所有，虽一毫而莫取。惟江上之清风，与山间之明月，耳得之而为声，目遇之而成色，取之无禁，用之不竭。是造物者之无尽藏也，而吾与子之所共适。”

    客喜而笑，洗盏更酌。肴核既尽，杯盘狼藉。相与枕藉乎舟中，不知东方之既白。
  ],
  keywords_zh: ("泰普斯特", "博士论文", "模板", "赤壁赋", "苏轼"),
  abstract_en: [
    In the autumn of the year Jen-hsü, when the seventh moon was just beginning to wane, I went with some friends on an excursion to the Red Cliff. A fresh breeze was blowing, and the waves were calm. I filled my friends' cups and urged them to drink, repeating the verses of the "Moonlight Song" and singing the verse of the "Lovely One." In a little while the moon rose up over the eastern hills and began to wander between the Dipper and the Herdsman. A stream of white mist stretched across the river, connecting the water with the sky. We let our little reed-like boat float away over the vast expanse of water, feeling as free as if we were riding upon the wind, bound for some unknown region. Lightly did it seem, as though we had left the world and were standing alone, and had sprouted wings and were flying up to become immortals.

    Then we drank more wine and rejoiced greatly, and beating time on the side of the boat, we sang:—

    "With cinnamon oars and orchid paddles,
    We beat the sparkling waters and cleave the moon-beams as we go.
    Far, far away my thoughts wander,
    And I yearn for the lovely one at the other end of the world."

    One of my friends accompanied this song upon his flageolet, and the notes were so mournful, now like plaints, now like sighs, sobbing and complaining, that the lingering echoes seemed to hang upon the air without ceasing. They were enough to make the dragons in their deep caverns dance, and to draw tears from the widow in her lonely boat.

    Sadly I sat up and asked my friend why he played such a melancholy strain. He replied:—

    "'The moon is bright, the stars are few, southward the ravens flew.' Is not this the verse of Ts‘ao Ts‘ao? Westwards is Hsia-k‘ou, eastwards is Wu-ch‘ang, with their intermingling hills and rivers and their grey-green trees. Is not this the spot where Ts‘ao was defeated by Chou Yü? When Ts‘ao had broken through Ching-chou and captured Chiang-ling, and was sailing eastwards, his vessels stretched stem to stern for a thousand li, his banners darkened the sky. He poured a libation of wine and, grasping his spear, he composed the verses—

    'The moon is bright, the stars are few,
    Southward the ravens flew.'

    Truly he was a hero for a generation, but where is he to-day? Now, you and I are but fishermen and woodcutters on the river's brink, with the fish and shrimps for companions and the deer for friends. We sail in our tiny boat and toast each other with gourd-cups. We are but may-flies between heaven and earth, mere specks of grain in the vast ocean. I mourn the shortness of our lives and envy the endless flow of the great river. I would fain clasp the flying immortals and wander with them, and embrace the bright moon for ever. But I know this cannot be attained so suddenly, and so I entrust my sorrow to the notes of my flageolet in the mournful breeze."

    I replied: "Do you understand the nature of the water and the moon? The water flows by like this, yet it never really goes away. The moon waxes and wanes, yet in the end it neither increases nor diminishes. For if we look at things from the point of view of change, then heaven and earth itself does not endure for the twinkling of an eye; but if we look at them from the point of view of their unchangeableness, then all things, including ourselves, are without end. And what is there to envy? Moreover, everything in the universe has its owner; if a thing does not belong to me, I would not take so much as a hair of it. Only the clear breeze upon the river and the bright moon over the hills, which the ear catches and makes into music, and the eye meets and makes into beauty—these are without restriction, they are inexhaustible. They are the inexhaustible treasury of the Creator, and you and I can enjoy them together."

    My friend smiled with joy and we washed the cups and filled them again. When the food was all gone, the cups and plates lay scattered about. And we reclined upon each other in the boat, not knowing that the east was already growing light.
  ],
  keywords_en: ("Typst", "Docter Thesis", "Template", "THE RED CLIFF", "Shi Su"),
)

// ============ step 2 写正文 ============ //
= 快速开始

== 文档结构

Typst 源文件由标记内容和以 `#` 开头的代码表达式组成。普通段落可以直接书写，空行表示分段；函数参数中的方括号 `[]` 表示内容块，花括号 `{}` 表示代码块。遇到不熟悉的原生语法，可查阅 #link("https://typst.app/docs/")[Typst 官方文档]。

本文件开头的 `#show: project.with(...)` 是模板入口。论文作者通常只需要维护三类内容：基本信息与摘要参数、正文、正文后的参考文献和附录；页面尺寸、字体和编号规则由模板统一处理。

== 标题与分页

行首使用一个、两个、三个等号分别创建一级、二级、三级标题。模板会自动应用“第 1 章”“1.1”“1.1.1”等编号和对应样式，目录收录到三级标题。

一级标题是否从奇数页开始目前由作者手动控制。请在编译后观察上一部分的最后一页：结束于偶数页时使用一次 `#pagebreak()`，结束于奇数页时使用两次。正文增删后需要重新检查。当前第一章结束于第 1 页，因此下面用两次分页跳过偶数空白页。

#pagebreak()
#pagebreak()

= 模板 API 与常用组件

== 图片

使用原生 `figure` 包裹 `image`。标签写在 `figure` 后，正文引用时使用模板自动生成的 `fig:` 前缀，例如 @fig:sample-image。

#figure(
  image("assets/FantasticArtwork.jpg", height: 22%),
  caption: [图片标题示例],
) <sample-image>

推荐为标签使用有意义的英文短名。源文件中写 `<sample-image>`，引用时写 `@fig:sample-image`；图号按章节自动生成为“图 2-1”一类格式。

== 表格

普通表格使用原生 `table`，并用 `figure(kind: table)` 添加表题和编号。标签会自动获得 `tbl:` 引用前缀。

#figure(
  table(
    columns: (1.4fr, 1fr, 1fr),
    inset: 7pt,
    stroke: 0.7pt,
    align: center + horizon,
    [方法], [准确率], [耗时 / s],
    [基线方法], [91.2%], [1.28],
    [改进方法], [94.6%], [1.15],
  ),
  kind: table,
  caption: [普通表格示例],
) <basic-table>

如 @tbl:basic-table 所示，图和表的引用方式一致。论文常用的三线表可调用 `three_line_table_full` 或 `three_line_table_small`：前者等宽铺满版心，后者按内容自适应列宽。

#figure(
  three_line_table_full((
    ("模型", "参数量 / M", "准确率 / %"),
    ("Baseline", "12.4", "91.2"),
    ("Ours", "10.8", "94.6"),
  )),
  kind: table,
  caption: [铺满版心的三线表],
) <full-three-line-table>

#figure(
  three_line_table_small((
    ("数据集", "训练集", "测试集"),
    ("Set A", "800", "200"),
    ("Set B", "1200", "300"),
  )),
  kind: table,
  caption: [自适应宽度的三线表],
) <small-three-line-table>

== 公式

使用 `$ ... $` 输入数学内容。独占一行的公式会被视为行间公式，并由模板按章节编号；标签同样写在公式后，引用时加 `eqt:` 前缀。

$ L = 1 / N sum_(i=1)^N (y_i - hat(y)_i)^2 $ <loss-function>

式 @eqt:loss-function 给出了均方误差。多行公式使用反斜杠换行、`&` 指定对齐点：

$
  a + b &= c \
  b &= c - a
$ <aligned-equation>

不需要编号的行间公式直接在末尾添加特殊标签 `<->`，无需额外工具函数：

$ x^2 + y^2 = r^2 $ <->

数学推导中，若公式后的“因此”“所以”等衔接词需要顶格，使用 `no_indent`：

$ e^("i" x) = cos x + "i" sin x $ <euler-formula>

#no_indent()[令 @eqt:euler-formula 中的 $x = pi$，可得 $e^("i" pi) + 1 = 0$。]

== 列表与段落缩进

- 无序列表适合并列说明。
- 每个列表项以 `-` 开头。

#indent()列表后的首段如需恢复段首缩进，可在段首调用 `#indent()`。该函数只插入一个缩进宽度，不改变后续段落规则。

+ 有序列表使用 `+`。
+ Typst 会自动生成序号。

需要局部调整编号格式时，将设置限制在内容块中：

#[
  #set enum(numbering: "1.a)")
  + 一级条目
    + 二级条目
  + 另一个一级条目
]

== 代码与伪代码

本示例通过 `codelst` 的 `sourcecode` 渲染代码块：

#sourcecode[```typ
#let greeting(name) = [你好，#name！]

#greeting("Typst")
```]

计算机类论文可使用模板已导出的 `lovelace` 伪代码组件：

#algorithm(
  caption: [欧几里得算法],
  pseudocode(
    no-number,
    [*输入：* 正整数 $a$ 和 $b$],
    no-number,
    [*输出：* 最大公约数],
    [*while* $a != b$ *do*], ind,
      [*if* $a > b$ *then*], ind,
        $a <- a - b$, ded,
      [*else*], ind,
        $b <- b - a$, ded,
      [*end*], ded,
    [*end*],
    [*return* $a$],
  ),
)

== 参考文献引用

先在 `ref.bib` 中维护文献条目，再使用条目键引用。单篇引用写作 `#bib_cite(<liu2014>)`，效果如 #bib_cite(<liu2014>)；多篇连续引用可一次传入多个标签，例如 #bib_cite(<liang2019>, <li2026>)。

`bib_cite` 适合模板当前的顺序编码制。不要在正文中手写参考文献序号，以免增删文献后编号失配。

// 当前第二章结束于偶数页，一次分页后第三章从奇数页开始。
#pagebreak()

= 论文正文组织示例

== 研究背景

正式论文通常按“问题背景—相关工作—研究方法—实验结果—结论”组织章节。本章放入少量示例内容，用于观察正文段落、标题、图表和交叉引用组合后的实际版式。

Typst 将内容结构与显示规则分离。作者使用标题、图、表和公式等语义元素描述论文，模板负责把这些元素转换为学校要求的视觉样式。这样的组织方式也便于统一修改格式和复用写作内容 #bib_cite(<yang2014book>)。

== 方法设计

=== 整体流程

示例方法包含数据预处理、特征提取和结果评估三个阶段。整体结构可通过 @fig:sample-image 示意，核心优化目标采用式 @eqt:loss-function。

=== 实验设置

实验参数和结果建议优先使用三线表呈现。较宽表格可选 `three_line_table_full`，内容较少时可选 `three_line_table_small`。超大或需要跨列合并的复杂表格，应使用原生 `table` 进一步定制并在最终 PDF 中人工检查。

== 本章小结

本章展示了一个完整章节的标题层级、正文段落和交叉引用方式。实际写作时可复制本结构，但应删除所有教程文字和未使用的示例组件。

// 当前第三章结束于奇数页，两次分页后第四章从奇数页开始。
#pagebreak()
#pagebreak()

= 总结与展望

本文展示了河南大学博士学位论文 Typst 模板的主要写作接口。使用模板时应始终以学校最新规范为准，并在提交前逐页检查封面信息、目录页码、图表公式编号、参考文献和盲审信息。

后续工作可根据实际学科要求扩展新的页面变体或组件，但应尽量保持正文 API 稳定。

// ============ 第 3 步：生成参考文献 ============ //
// full: false 只列出正文实际引用的条目；设为 true 可列出 bib 文件中的全部条目。
// 参考文献也必须从奇数页开始；当前正文结束于奇数页，因此使用两次分页。
#pagebreak()
#pagebreak()
#fix_bibliography({
  bibliography("ref.bib", full: false)
})

// ============ 第 4 步：编写附录 ============ //
// page_appendix 生成“附录”主标题；二级标题作为“附录 A、附录 B”。
// 当前参考文献结束于奇数页，因此使用两次分页。
#pagebreak()
#pagebreak()
#show: page_appendix
#show: appendix_numbering_rule

== 附录 A

#appendix_tbl(
  three_line_table_full((
    ("配置", "参数量 / M", "准确率 / %"),
    ("基线", "12.4", "91.2"),
    ("完整模型", "10.8", "94.6"),
  )),
  "附录三线表示例",
  prefix: "A",
)

#appendix_eq($x = frac(-b plus.minus sqrt(b^2 - 4 a c), 2 a)$, prefix: "A")

附录中的图、表、公式使用 `appendix_img`、`appendix_tbl`、`appendix_eq`，编号分别形如 A-1。当前附录引用建议在正文中写成“见附录 A（表 A-1）”并在终稿中核对。

== 附录 B

#appendix_img("../assets/Me.jpg", "附录图片示例", width: 45%, prefix: "B")

// ============ step 5 致谢(anonymou: true 时需要自己删除这部分) ============ //
// 当前附录结束于奇数页，因此使用两次分页。
#pagebreak()
#pagebreak()
#show: page_acknowledgement.with(author: "希露菲", date: (2026, 6))

感谢我的导师李华教授在博士期间给予的悉心指导。李老师严谨求实的治学态度和敏锐的学术洞察力使我受益匪浅，从选题到论文撰写的每一个环节都凝聚着导师的心血。

感谢实验室各位同窗在科研和生活中给予的帮助。感谢家人多年来的理解、支持与包容，是你们让我能够心无旁骛地完成学业。

感谢各位评审专家在百忙之中评阅本论文。
