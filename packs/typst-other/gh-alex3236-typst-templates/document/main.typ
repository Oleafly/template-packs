#import "lib.typ": *

#show: project.with(
  title: "关于我转生成为Typst糕手并写了一个带封面的文档模板这件事",
  author: ("作者", "也许是另一个作者"),
  subtitle: "这是一个可爱的副标题，用于演示长标题的显示效果。",
  date: datetime.today(),
)

#heading-break.update((none, 30%, 15%))

= 简介

此模板提供了一个基本的文档结构，包括封面、目录、章节和段落。可用于报告、作业、文章、手册等文体的撰写。从基于 #link("https://github.com/jinhao-huang/SimplePaper")[jinhao-huang/SimplePaper] 改进后的 #link("https://github.com/Dawnfz-Lenfeng/easy-paper")[Dawnfz-Lenfeng/easy-paper] 项目改进而来。以上两个项目均基于 `MIT License` 许可。感谢他们的付出。

= 功能和用法

下面介绍此模板提供的默认行为和额外功能。请注意参照渲染产物对照代码，以了解用法。

== 页眉和页脚

如你所见，页眉默认显示文档标题和当前 Heading，页脚默认显示当前页码。

== 组件

以下是本模板引入的一些自定义组件。

=== 图片

`fimage` 能快速插入一张 `figure` 中的图片，并且可以指定 Caption.

#let img = bytes(
  "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'>
      <rect x='0' y='0' width='150' height='150' fill='#66ccff'/>
      <text x='50' y='70' text-anchor='middle' fill='white' font-size='48'>喵</text>
    </svg>",
)

#fimage(
  img,
  format: "svg",
  alt: "一张在 Figure 中的图片。",
)

也许你注意到了，它是圆角的。默认圆角为 `10pt`.

#fimage(
  img,
  format: "svg",
  max-width: 60pt,
  radius: 20pt,
  alt: "还可以更圆一点。",
)

默认状态下，`fimage` 以原尺寸为基础，把图片按设置的最大宽高自动等比例缩小，不会放大，并选最小的可行尺寸。

=== 代码

```python
def f(x):
    return x**2
```


=== 自定义块

用 `custom-block` 创建类似 Alert 的块。

#custom-block(
  color: rgb("#bee9ff"),
  title: "自定义块",
)[
  这是一个 `custom-block`.
]

#problem[
  这是一个 `problem`.
]

#solution[
  这是一个 `solution`.
]

#problem(
  title: "这不是一个问题.",
)[
  这是一个自定义标题的 `problem`.
]

#solution(
  title: [*这也并不是解答.*],
)[
  这是一个自定义标题的 `solution`.
]

=== 表格

#figure(
  table(
    columns: 3,
    [列1], [列2], [列3],
    [行1列1], [行1列2], [行1列3],
    [行2列1], [行2列2], [行2列3],
  ),
  caption: "这是一个普通的表格",
)

#v(2em)

#figure(
  [
    #show table: three-line-table
    #table(
      columns: 4,
      [x\\y], [香蕉], [苹果], [菠萝],
      ["香"], [#sym.times], [], [],
      ["苹"], [], [#sym.times], [],
      ["蕉"], [#sym.times], [], [],
      ["菠"], [], [], [#sym.times],
      ["果"], [], [#sym.times], [],
      ["萝"], [], [], [#sym.times],
    )
  ],
  caption: [而这是一个三线表格，描述了 $x in y$ 的关系图],
)

=== 日期

`fdate` 能快速插入日期，默认格式为 `yyyy-mm-dd`。

#fdate(datetime.today()) #h(1em)
#fdate(datetime.today(), splitter: "/") #h(1em)
#fdate(datetime.today(), splitter: (".", ",")) #h(1em)
#fdate(datetime.today(), splitter: ("+", "-", ";")) #h(1em)
#fdate(datetime.today(), ch: true)

=== 偏微分
$
  #pardiff([x], [y]): "如你所见，这是一个偏微分。"
$


== 排版

=== 自动分页

也许你注意到了，也许你没有。但，此模板默认进行智能分页，当二级和三级标题出现在页面下部时，会自动将其移动到下一页。比如，本节就被移动到了新的一页。

默认情况下，一级标题总是出现在新的一页。为节省空间，本文档调整了这一行为。你可以在本文代码的前几行看到，具体方式为：

```typst
// 默认：(100%, 30%, 15%)
#heading-break.update((none, 30%, 15%))
```

加长传入的列表，调整更多级标题的分页行为。该功能不稳定，若不需要可指定为 `none` 以禁用。

=== 页码

此模板区分目录页码和正文页码。目录级别默认为 `auto`.

=== 列表

无论是有序列表，还是无序列表，默认都在首行缩进的基础上再有 `1em` 的缩进。

+
  +
    +
      +
        + 有序列表标记
-
  -
    -
      -
        - 无序列表标记


=== 缩进

#_i[
  如你所见，此模板默认对所有段落进行首行缩进。如果你需要临时取消这一行为，可以使用 `_i`.
]

== 封底

为了让封底位于最后以符合逻辑，此模板没有选择在 `project.with` 中配置封底内容。你可以通过 `back-cover` 块放置封底。此处暂时禁用封底分页，以展示两个自定义封底：

#[
  #show pagebreak: it => {}

  #back-cover(
    outline-title: [], // 封底标题为空，不显示封底标题
    extra: [
      像这样即可用默认封底内容 \
      如果你喜欢，可以加点糖（添加一些额外内容） \
      并且拒绝在目录中显示。
    ],
  )[] // 你可以像这样使用默认的封底内容，并添加额外的内容

  #v(3em)

  #back-cover(
    outline-title: [这并不是一个封底],
  )[
    当然，你也可以不用默认封底的内容，并且在目录中显示自定义标题。 \
    你可以在最后真正的封底中预览默认封底标题。
  ]

  #v(2em)
]

= 更多配置

你可以在 `lib.typ` 的 `config` 块中修改更多配置。当然，你也可以随意修改其他内容。


= 星辰烘焙手记

#[
  #set text(font: font.zh_kai)
  在一切开始前，仰望星空
]

*暮色初临时分，我总提着青瓷罐往天台去。*

罐身冰裂纹蜿蜒，恰似银河褪去后裸露的河脉。

楼宇间穿梭的晚风，裹挟邻家曲奇的焦糖气息，

而我要捕的食材，正在云絮褶皱里明明灭灭。

第一粒星子叩响罐底，叮咚如檐角风铃震颤。

多是迷途的流星余烬，棱角早被大气磨成温润。

偶遇执拗的北斗，便以银匙轻叩，任声波织就捕梦的茧。

去年冬至猎户松弦，箭簇穿透三叠糯米云纱，

在紫苏叶脉凝出薄荷色霜花，透着凛冽的寒光。

\

*面团需在月华鼎沸时揉捻。*

云母粉簌簌筛落，银河突然向西倾倒须臾。

祖父的铜秤泛起微温，刻度盘浮出泛黄星谱——

天狼星对应糖粒，织女星化作盐晶。

指尖虹彩面团粘腻，窗外梧桐沙沙作响，

恍若奶油裱花嘴在枝叶间游走，勾勒风的形状。

北风从排气孔潜入，偷啜暗物质泡芙醺然踉跄；

撞翻的蛋白霜碗里，漾起超新星爆发的模样。

陨石坑化作琥珀桃仁，日冕凝为糖渍橙片的芳香。

\

*总有人问为何执着采撷星芒。*

许是二十年前雪夜，外婆拾起灶膛跃动的光斑：

「瞧这些迷途的星星，正在寻找归巢的翅膀」

她将红薯埋进灰烬时，宇宙胚胎在余温里膨胀。

而今罐底微光，仍裹着童年冬夜的焦香——

锡纸褶皱流转的暖意，是坍缩成蜜的远古太阳。

*晨雾漫窗时，甜点车已穿行街巷。*

给扫街老伯留块猎户座玛德琳，

替夜班护士温着仙后座茶汤。

保温箱里麒麟碎光静卧，熔岩深处跃动着涅槃辉芒——

那些高空湮灭的流浪者，终在掌心延展成光之回廊。

天台上空罐再度承接新坠星尘，

东方既白处浮起蛋白霜似的柔光，

而昨夜蛋糕里的星核，正在孩童瞳仁流转永恒曦芒。

#context back-cover[
  — #document.title — \
  *Alex3236.*

  #link("mailto:connect@live.cn")[connect\@live.cn] \
  #link("https://github.com/Alex3236/")
]

#hide[
  #show heading: it => []
  #for i in range(1, 11) [
    = 封底后莫名其妙的章节，用来展示目录。以防你不知道，这是第 #i 个
    == 而这是第 #i 个章节的二级标题
    === 这更是第 #i 个章节的三级标题
    ==== 喵
  ]

  = 这是一个长标题：#lorem(25)
  = 不要因为走得太远，就忘了当初为什么出发。
]
