#import "fmt-req.typ": (
  acknowledgement-page, algox, appendix, bibliography-page, fmt-pass1, fmt-pass2, fmt-pass3, fmt-pass4, imagex,
  mask-pass, notation-page, paper-abstract, paper-cover, paper-outline, proof, pseudocode-list, subimagex, table-note,
  tablex, theorem, twoside-pass,
)

// 盲审模式和定制双面打印模式
// 需要使用哪个功能就把哪个 enable 设置为 true
#show: mask-pass.with(enable: false)
#show: twoside-pass.with(enable: false)

// 在 pass1 之后开始编写论文封面和前面的内容
#show: fmt-pass1

#paper-cover(
  [毕业论文（设计）], // 大标题
  [中文题目], // 中文题目
  [Title name in English], // 英文题目
  [11451466666], // 学号
  [马克思学院], // 学院
  [化学工程与工艺（卓越班）], // 专业
  [12班], // 班级
  [西门吹雪], // 学生
  [任我行], // 指导教师
  [教主], // 职称
  datetime(year: 2025, month: 2, day: 1), // 启动日期
  datetime(year: 2025, month: 12, day: 31), // 结束日期
  显示下划线: true,
  仅显示下划线: false,
)

// 在 pass123 之后开始编写论文摘要
#show: fmt-pass2
#show: fmt-pass3 // 页眉

#paper-abstract(
  // 中文摘要
  [
    摘要是论文内容的简要陈述，是一篇具有独立性和完整性的短文。摘要应包括本论文的基本研究内容、研究方法、创造性成果及其理论与实际意义。摘要中不宜使用公式、图表，不标注引用文献编号。避免将摘要写成目录式的内容介绍。
    摘要应有关键词，关键词数量应为3-8个。
    摘要结构要严谨、表达简明、语义确切。一般通用第三人称。建议采用“对......进行了研究”、“报告了....·.现状”、“进行了......调查”等记述方法标明学位论文的主题，不必使用“本文”、“作者”等作为主语。
  ],
  // 英文摘要
  [
    An abstract is a concise statement of the content of a thesis and an independent and complete short passage. It should include the basic research content, research methods, creative achievements, as well as their theoretical and practical significance of the thesis. Formulas, charts and reference numbering should not be used in the abstract. Avoid writing the abstract as a table-of-contents-style introduction.
    An abstract should contain keywords, with the number of keywords ranging from 3 to 8.
    The structure of an abstract shall be rigorous, the expression concise and the semantics accurate. Generally, the third person is used. It is recommended to use descriptive phrases such as "conducted research on...", "reported the current status of...", "carried out an investigation on..." to indicate the theme of the dissertation, without using "this paper" or "the author" as the subject.
  ],
  // 关键词
  中文关键词: ([论文内容], [创造性成果], [实际意义], [记述方法]),
  英文关键词: ([Thesis Content], [Creative Achievements], [Practical Significance], [Description Method]),
)

#paper-outline(
  插图清单: true,
  附表清单: true,
  // 如果不需要符号说明可以删掉这项或设置为none；
  // 如果要自定义删掉后在pass[3,4]内用notation-page自定义
  符号说明: [
    #align(center, block(
      width: 60%,
      grid(
        align: (right, left),
        columns: (1fr, 1.5fr),
        row-gutter: 20pt - 0.5em,
        column-gutter: 2em,
        [$alpha$], [衰减系数],
        [$beta$], [增益因子],
        [$gamma$], [反射率],
        [$delta$], [相位差],
        [API], [应用程序接口 (Application Programming Interface)],
        [GUI], [图形用户界面 (Graphical User Interface)],
      ),
    ))
  ],
)

// 在 pass1234 之后开始编写论文正文

#show: fmt-pass4

= 绪论 <chp:intro>

== 引言

学位论文......

=== 三级标题

......

==== 四级标题

标题引用：@chp:intro @sec:meaning @app:flowchart

无序列表：

- 项目1
  - 子项目1
  - 子项目2
- 项目2
- 项目3

有序列表：

+ 项目1
  + 子项目1
    + 子子项目1
  + 子项目2
+ 项目2
+ 项目3

== 本文研究主要内容

本文......

== 本文研究意义 <sec:meaning>

本文......

== 本章小结

本文......

= 数学、化学与引用文献的标注

== 数学

=== 数学和单位

包 `unify` 提供了更好的数字和单位支持，但与 `siunitx` 相比，只支持了`num`, `unit`, `qty`, `numrange`, `qtyrange` 五个函数：

#import "@preview/unify:0.7.1": *

- $num("-1.32865+-0.50273e-6")$
- $num("0.3e45", multiplier: "times")$
- $unit("kg m/s")$
- $unit("ohm")$
- $qty("0.13", "mm")$
- $qty("1.3+1.2-0.3e3", "erg/cm^2/s", space: "#h(2mm)")$
- $numrange("1,1238e-2", "3,0868e5", thousandsep: "'")$
- $numrange("10", "20", delimiter: "tilde")$
- $qtyrange("1e3", "2e3", "meter per second squared", per: "\\/", delimiter: "\"to\"")$
- $qtyrange("10", "20", "celsius", delimiter: "tilde")$

=== 数学符号和公式

按照国标GB/T3102.11—1993《物理科学和技术中使用的数学符号》，微分符号 $dif$ 应使用直立体。除此之外，数学常数也应使用直立体：

#let bf(x) = math.bold(math.upright(x))
#let ppi = $upright(pi)$
#let ee = $upright(e)$
#let ii = $upright(i)$

- 微分符号 $dif$： `dif`
- 圆周率 $ppi$： `upright(pi)`
- 自然对数的底 $ee$： `upright(e)`
- 虚数单位 $ii$： `upright(i)`

公式应另起一行居中排版。公式后应注明编号，按章顺序编排，编号右端对齐，如@equation 所示。

$
  ee^(ii ppi) + 1 = 0,
$ <equation>

$
  (dif^2 u) / (dif t^2) = integral f(x) dif x.
$

公式末尾是需要添加标点符号的，至于用逗号还是句号，取决于公式下面一句是接着公式说的，还是另起一句。

$
  (2h) / ppi limits(integral)_0^infinity (sin (omega delta)) / omega cos (omega x) dif omega = cases(
    h "," quad abs(x) < delta ",",
    h / 2 "," quad x = plus.minus delta ",",
    0 "," quad abs(x) > delta"."
  )
$

公式较长时最好在等号“$=$”处转行。子公式的引用请在该行公式后添加 `#<subequation>` 引用标签，如@subequation 所示。如果有某行公式不需要编号，请使用 `#<equate:revoke>` 标签。（此标签由 `equate` 包定义，目前不可自定义）

$
    & I(X_3; X_4) - I(X_3; X_4 | X_1) - I(X_3; X_4 | X_2) #<equate:revoke> \
  = & [I(X_3; X_4) - I(X_3; X_4 | X_1)] - I(X_3; X_4 | tilde(X_2)) \
  = & I(X_1; X_3; X_4) - I(X_3; X_4 | tilde(X_2)). #<subequation>
$

如果在等号处转行难以实现，也可在 $+$、$-$、$times$、$div$ 运算符号处转行，转行时运算符号仅书写于转行式前，不重复书写。

$
  1 / 2 Delta(f_(i j) f^(i j)) = 2 med &(sum_(i<j) x_(i j) (sigma_i - sigma_j)^2 + f_(i j) nabla_j nabla_i (Delta f) #<equate:revoke> \
    &+ nabla_k f_(i j) nabla^k f^(i j) + f^(i j) f^k [2 nabla_i R_(j k) - nabla_k R_(i j)]).
$

如果要使用LaTeX的公式语法，可以借助 `mitex` 包，它将LaTeX代码处理成抽象语法树（AST）。然后将 AST 转换为 Typst 代码，并使用 `eval` 函数将代码评估为 Typst 内容。具体使用方法如下：

#import "@preview/mitex:0.2.7": mi, mitex
#mitex(
  `
  \begin{cases}
    a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n = b_1 \\
    a_{21}x_1 + a_{22}x_2 + \cdots + a_{2n}x_n = b_2 \\
    \vdots \\
    a_{m1}x_1 + a_{m2}x_2 + \cdots + a_{mn}x_n = b_m
  \end{cases}
`,
)

上面是用 `mitex` 包表达的一个线性方程组，包也支持行内使用数学符号，如 #mi("\pi")，#mi("z = -1") 等。

=== 定理环境

示例文件中使用 `theorion` 宏包配置了定理、引理和证明等环境。

这里举一个“定理”和“证明”的例子。

#let Res = math.op("Res")

#theorem(title: "留数定理")[
  假设 $U$ 是复平面上的一个单连通开子集，$a_1, dots, a_n$ 是复平面上有限个点，$f$ 是定义在 $U without {a_1, dots, a_n}$ 上的全纯函数，如果 $gamma$ 是一条把 $a_1, dots, a_n$ 包围起来的可求长曲线，但不经过任何一个 $a_k$，并且其起点与终点重合，那么：

  $
    limits(integral.cont)_gamma f(z) dif z = 2 ppi ii sum_(k=1)^n op(I)(gamma, a_k) Res(f, a_k).
  $ <res>

  如果 $gamma$ 是若尔当曲线，那么 $op(I)(gamma, a_k) = 1$，因此：

  $
    limits(integral.cont)_gamma f(z) dif z = 2 ppi ii sum_(k=1)^n Res(f, a_k).
  $ <resthm>

  在这里，$Res(f, a_k)$ 表示 $f$ 在点 $a_k$ 的留数，$op(I)(gamma, a_k)$ 表示 $gamma$ 关于点 $a_k$ 的卷绕数。卷绕数是一个整数，它描述了曲线 $gamma$ 绕过点 $a_k$ 的次数。如果 $gamma$ 依逆时针方向绕着 $a_k$ 移动，卷绕数就是一个正数，如果 $gamma$ 根本不绕过 $a_k$，卷绕数就是零。

  @thm:res 的证明。

  #proof[
    首先，由……

    其次，……

    所以……
  ]
] <thm:res>

== 化学方程式

使用群友科技 Typsium 编写美观的化学式和化学方程式。

#import "@preview/typsium:0.3.1": ce

有多种不同种类的箭头可供选择。

#ce[->]
#ce[=>]
#ce[<=>]
#ce[<=]
#ce("<->")
#ce("<-")

你可以通过添加方括号来给它们添加额外的参数（例如顶部或底部的文字）。

$
  #ce("->[top text][bottom text]")
$

通过用 `ce` 包裹化学方程式，你可以把他显示在公式或文本中。

$
  #ce("[Cu(H2O)4]^2+ + 4NH3 -> [Cu(NH3)4]^2+ + 4H2O")
$

分子解析是灵活的，支持多种不同的书写方式，因此你可以复制并粘贴你的公式，它们很可能可以正常工作。氧化数可以像这样^^添加，自由基可以像这样.添加，水合基团可以像这样\u{B7}添加。

你可以使用多种类型的括号。默认情况下它们会自动缩放，但你可以通过显示规则禁用它。

行内公式通常需要稍微紧凑一些；为此，有一个影响布局的规则，可以为反应的每个部分单独开启或关闭。

== 引用文献的标注

按文件要求，参考文献外观应符合国标 GB/T 7714。

正文中引用参考文献时，使用 `@Si2021_22 @Zhong2021_92 @Jiao2020_06` 可以产生“上标引用的参考文献”，如 @Si2021_22 @Zhong2021_92 @Jiao2020_06。

Typst 使用 Hayagriva 管理参考文献，有部分细节问题还在逐步修复。

= 图表、算法格式

== 插图

本模板使用 `imagex` 函数对图片环境进行封装，在实现子图，双语图题等复杂功能的同时，仍保留较高的自定义程度，将通过下面的示例进行说明。图片的引用须以 `img` 开头。

=== 单个图形

图要有图题，图题应置于图的编号之后，图的编号和图题应置于图下方的居中位置。文中必须有关于本插图的提示，如“见@img:image”、“如@img:image”等。该页空白不够排写该图整体时，则可将其后文字部分提前排写，将图移到次页。使用 `footnote` 函数可以添加页注。

#imagex(
  image(
    "figures/cn-iron-exp.png",
    width: 80%,
  ),
  caption: [2000\~2024年我国钢材出口量及增速#footnote[单位（亿吨，%）来自IFind、信达证券研发中心，下同]],
  label-name: "image",
)

也支持在图表中添加英文图题，在 `imagex` 函数参数中添加参数 `caption-en` 即可。

#imagex(
  image(
    "figures/cn-iron-exp.png",
    width: 80%,
  ),
  caption: [2000\~2024年我国钢材出口量及增速],
  caption-en: [2000\~2024 year China steel export and growth rate],
  label-name: "image2",
)

=== 多个图形

简单插入多个图形的例子如@img:CUOP 所示。这两个水平并列放置的子图共用一个图形计数器，没有各自的子图题。

#imagex(
  image("figures/cn-oil.webp"),
  image("figures/us-oil.webp"),
  columns: (1fr, 1fr),
  caption: [历年中美石油产量],
  caption-en: [Historical China and US oil production],
  label-name: "CUOP",
)

如果多个图形相互独立，并不共用一个图形计数器，那么用 `grid` 或者 `columns` 就可以，如@img:parallel1 与@img:parallel2。

#grid(
  align: bottom,
  grid.cell(imagex(
    image("figures/cn-oil.webp"),
    caption: [中国石油产量],
    label-name: "parallel1",
  )),
  grid.cell(imagex(
    image("figures/us-oil.webp"),
    caption: [美国石油产量],
    label-name: "parallel2",
  )),
  columns: (1fr, 1fr),
)

如果要为共用一个计数器的多个子图添加子图题，使用 `subimagex`，如@img:subfigures:test1 和@img:subfigures:test2。

#imagex(
  subimagex(
    image("figures/cn-oil.webp"),
    caption: [中国石油产量],
    label-name: "test1",
  ),
  subimagex(
    image("figures/us-oil.webp"),
    caption: [美国石油产量],
    label-name: "test2",
  ),
  columns: (1fr, 1fr),
  caption: [历年中美石油产量],
  label-name: "subfigures",
)

如果需要双语图题，可以自由在 `imagex` 和 `subimagex` 添加 `caption-en` 参数。

#imagex(
  subimagex(
    image("figures/cn-oil.webp"),
    caption: [中国石油产量],
    caption-en: [China oil production],
    label-name: "test1",
  ),
  subimagex(
    image("figures/us-oil.webp"),
    caption: [美国石油产量],
    // caption-en: [Greenhouse gas emissions in 2050],
    label-name: "test2",
    alignx: center + horizon,
  ),
  columns: (1fr, 1fr),
  caption: [历年中美石油产量],
  caption-en: [Historical China and US oil production],
  label-name: "subbifigures",
)

== 表格

本模板使用 `tablex` 函数对表格进行封装，实现了自动续表和表格脚注功能，表格的引用须以 `tbl` 开头。

=== 基本表格

表的编排，一般是内容和测试项目由左向右横读，数据依序竖排。表应当有“自明性”。要有表号、表名及必要的说明，居中置于表的上方。表中文字、符号的字体应比正文小一号。通过在 `tablex` 函数的参数中设置 `caption-en` 可在表中添加英文图题，一般来说中文表题在上。

表格的编排建议采用国际通行的三线表#footnote[三线表，以其形式简洁、功能分明、阅读方便而在科技论文中被推荐使用。三线表通常只有 3 条线，即顶线、底线和栏目线，没有竖线。]，如@tbl:standard-table 所示。

#tablex(
  [Gnat],
  [per gram],
  [13.65],
  [],
  [each],
  [0.01],
  [Gnu],
  [stuffed],
  [92.50],
  [Emu],
  [stuffed],
  [33.33],
  [Armadillo],
  [frozen],
  [8.99],
  header: (table.cell(colspan: 2)[Item], [], table.hline(end: 2, stroke: 0.25pt), [Animal], [Desciption], [Price(\$)]),
  columns: 3,
  caption: [一个颇为标准的三线表],
  label-name: "standard-table",
)

通过更改表格的样式设置，可以将其显示为边框表格，如@tbl:normal-table 所示。（注意：边框表格跨页时，续表字样会被边框框选。故应传入参数 `breakable: false`取消其续表功能）

#tablex(
  ..for i in range(2) {
    ([250], [88], [5900], [1.65])
  },
  header: (
    [感应频率 #linebreak() (kHz)],
    [感应发生器功率 #linebreak() (%×80kW)],
    [工件移动速度 #linebreak() (mm/min)],
    [感应圈与零件间隙 #linebreak() (mm)],
  ),
  stroke: 0.5pt,
  columns: 4,
  caption: [高频感应加热的基本参数],
  caption-en: [XXXXXXX],
  label-name: "normal-table",
  breakable: false,
)

=== 复杂表格

我们经常会在表格下方标注数据来源，或者对表格里面的条目进行解释。可以用 `table-note` 在表格中添加表注，如@tbl:footnote-table 所示。

#tablex(
  [],
  [4.22],
  [120.0140#table-note("the second note.")],
  [],
  [333.15],
  [0.0411],
  [],
  [444.99],
  [0.1387],
  [],
  [168.6123],
  [10.86],
  [],
  [255.37],
  [0.0353],
  [],
  [376.14],
  [0.1058],
  [],
  [6.761],
  [0.007],
  [],
  [235.37],
  [0.0267],
  [],
  [348.66],
  [0.1010],
  align: horizon,
  breakable: false,
  header: (
    table.cell(rowspan: 2)[total],
    table.cell(colspan: 2)[20#table-note("the first note.")],
    table.cell(rowspan: 2)[],
    table.cell(colspan: 2)[40],
    table.cell(rowspan: 2)[],
    table.cell(colspan: 2)[60],
    table.hline(end: 3, stroke: 0.25pt),
    table.hline(start: 4, end: 6, stroke: 0.25pt),
    table.hline(start: 7, end: 9, stroke: 0.25pt),
    [www],
    [k],
    [www],
    [k],
    [www],
    [k],
  ),
  columns: 9,
  caption: [一个带有脚注的表格的例子],
  caption-en: [A Table with footnotes],
  label-name: "footnote-table",
)

如某个表需要转页接排，`tablex` 自动实现了续表功能。接排时表题省略，表头应重复书写，并上书“续表 xx”，如@tbl:long-table 所示。（注意：当表格跨页时，脚注不能添加在表头中，会导致重复标注，此时应传入参数 `breakable: false`取消续表功能）

#tablex(
  ..for i in range(18) {
    ([250], [88], [5900], [1.65])
  },
  header: (
    [感应频率 #linebreak() (kHz)],
    [感应发生器功率 #linebreak() (%×80kW)],
    [工件移动速度 #linebreak() (mm/min)],
    [感应圈与零件间隙 #linebreak() (mm)],
  ),
  columns: (25%, 25%, 25%, 25%),
  caption: [高频感应加热的基本参数],
  caption-en: [XXXXXXX],
  label-name: "long-table",
)

== 算法环境

本模板使用 `algox` 函数对算法环境进行封装，其中使用的算法包为 `lovelace`，需要自定义 `pseudocode-list` 的格式时可自行查询 `lovelace` 的文档。算法的引用须以 `algo` 开头。算法与表格一样也实现了跨页自动添加“续算法”的功能。

我们可以通过@algo:fibonacci 来计算斐波那契数列第 $n$ 项。

#let tmp = math.italic("tmp")
#algox(
  label-name: "fibonacci",
  caption: [斐波那契数列计算],
  pseudocode-list(line-gap: 1em, indentation: 2em)[
    - #h(-1.5em) *input:* integer $n$
    - #h(-1.5em) *output:* Fibonacci number $F(n)$
    + *if* $n = 0$ *then return* $0$
    + *if* $n = 1$ *then return* $1$
    + $a <- 0$
    + $b <- 1$
    + *for* $i$ *from* $2$ *to* $n$ *do*
      + $tmp <- a + b$
      + $a <- b$
      + $b <- tmp$
    + *end*
    + *return* $b$
  ],
)

== 代码环境

我们可以在论文中插入算法，但是不建议插入大段的代码。如果确实需要插入代码，推荐使用 `codly` 包插入代码。

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#show: codly-init.with()
#codly(languages: codly-languages)

```python
def fibonacci(n: int) -> int:
    # 输入：整数 n
    # 输出：Fibonacci 数列的第 n 项

    if n == 0:
        return 0
    if n == 1:
        return 1

    a = 0
    b = 1
    for i in range(2, n + 1):
        tmp = a + b
        a = b
        b = tmp
    return b
```

= 全文总结

== 主要结论

本文主要……

== 研究展望

更深入的研究……

// 参考文献
#bibliography-page(
  bibfunc: bibliography.with("refs.bib"),
  full: true,
) // full: false 表示只显示已引用的文献，不显示未引用的文献；true 表示显示所有文献

// 致谢
#acknowledgement-page[
  致谢主要感谢导师和对论文工作有直接贡献和帮助的人士和单位。致谢言语应谦虚诚恳，实事求是。
]

// 下面开始编写附录
#show: appendix

= Gauss-Jordan Elimination

== 介绍

高斯-约旦消元法（Gauss-Jordan Elimination）是一种用于求解线性方程组的算法，它是高斯消元法的改进版本。该方法通过将系数矩阵化为行最简形（简化行阶梯形）来求解方程组。

考虑一个线性方程组：
#mitex(
  `
  \begin{cases}
    a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n = b_1 \\
    a_{21}x_1 + a_{22}x_2 + \cdots + a_{2n}x_n = b_2 \\
    \vdots \\
    a_{m1}x_1 + a_{m2}x_2 + \cdots + a_{mn}x_n = b_m
  \end{cases}
`,
)

对应的增广矩阵为：
#mitex(
  `
  \begin{pmatrix}
    a_{11} & a_{12} & \cdots & a_{1n} & | & b_1 \\
    a_{21} & a_{22} & \cdots & a_{2n} & | & b_2 \\
    \vdots & \vdots & \ddots & \vdots & | & \vdots \\
    a_{m1} & a_{m2} & \cdots & a_{mn} & | & b_m
  \end{pmatrix}
`,
)

高斯-约旦消元法的基本步骤如下：

1. *前向消元*：将矩阵化为行阶梯形
  - 从第一行开始，选择主元（通常选择绝对值最大的元素）
  - 将主元所在行交换到当前行
  - 将主元化为 1（除以主元值）
  - 用当前行消去下方所有行的对应列元素
2. *后向消元*：将矩阵化为行最简形
  - 从最后一行开始，向上消去上方所有行的对应列元素
  - 确保每个主元列中，主元为 1，其他元素为 0

== 示例

考虑线性方程组：
#mitex(
  `
  \begin{cases}
    2x + y - z = 8 \\
    -3x - y + 2z = -11 \\
    -2x + y + 2z = -3
  \end{cases}
`,
)

对应的增广矩阵为：
#mitex(
  `
  \begin{pmatrix}
    2 & 1 & -1 & | & 8 \\
    -3 & -1 & 2 & | & -11 \\
    -2 & 1 & 2 & | & -3
  \end{pmatrix}
`,
)

经过高斯-约旦消元后，得到行最简形：
#mitex(
  `
  \begin{pmatrix}
    1 & 0 & 0 & | & 2 \\
    0 & 1 & 0 & | & 3 \\
    0 & 0 & 1 & | & -1
  \end{pmatrix}
`,
)

因此解为：#mi("x = 2")，#mi("y = 3")，#mi("z = -1")。

== 复杂度分析

高斯-约旦消元法的时间复杂度为 #mi("O(n^3)")，其中 #mi("n") 是方程的数量。空间复杂度为 #mi("O(n^2)")，用于存储系数矩阵。

== 应用

高斯-约旦消元法广泛应用于：
- 求解线性方程组
- 计算矩阵的逆
- 计算矩阵的秩
- 求解线性规划问题

= 绘图

== 流程图 <app:flowchart>

`fletcher` 是一个基于 `CeTZ` 的 `Typst` 包，用于绘制流程图，功能丰富，可参考 `fletcher` 的文档进行学习。

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond, parallelogram

#imagex(
  diagram(
    node-stroke: 0.5pt,
    node-inset: 1em,
    edge-corner-radius: 0pt,
    spacing: 2.5em,

    (
      node((0, 0), "待测图片", corner-radius: 5pt),
      node((0, 1), "读取背景", shape: parallelogram),
      node((0, 2), "匹配特征点对"),
      node((0, 3), "多于阈值", shape: diamond),
    )
      .intersperse(edge("-|>"))
      .join(),
    (
      node((0, 4), "透视变换矩阵"),
      node((0, 5), "图像修正"),
      node((0, 6), "配准结果", corner-radius: 5pt),
    )
      .intersperse(edge("-|>"))
      .join(),
    node((3, 2), "重采"),
    edge("<|-", [是]),
    node((3, 3), "清晰?", shape: diamond),
    edge("-|>", [是]),
    node((3, 4), "仿射变换矩阵"),

    edge((0, 3), (0, 4), [是], "-|>"),
    edge((0, 3), (3, 3), [否], "-|>"),
    edge((3, 4), (0, 5), "-|>", corner: right),
    edge((3, 2), (0, 0), "-|>", corner: left),
  ),
  caption: [绘制流程图效果],
  caption-en: [Flow chart],
  label-name: "fletcher-example",
)

== Graphviz 图

`diagraph` 包是一个简单的 `Graphviz Typst Binding`，用于在Typst中绘制Graphviz图。你可以使用 `render` 函数将 Graphviz Dot 字符串呈现为 SVG 图像。或者，你可以使用 `raw-render` 来传递raw而不是字符串。

#import "@preview/diagraph:0.3.7": raw-render, render

#imagex(
  render("digraph { a -> b }"),
  caption: [字符串绘制Graphviz图效果],
  label-name: "graphviz-example",
)

#imagex(
  raw-render(width: 100%, ```dot
  digraph G {
    // 全局样式
    graph [bgcolor="lightyellow", fontname="Arial", fontsize=10, rankdir=TB, splines=ortho];
    node [shape="record", style="filled", fillcolor="lightblue", fontname="Arial", fontsize=10];
    edge [color="darkgray", fontname="Arial", fontsize=9, arrowhead="normal"];

    // 定义节点（使用 record 形状支持表格化类图）
    Book [label="{Book|+title: string\n+isbn: string|+getDetails(): string}"];
    Author [label="{Author|+name: string|+getBooks(): Book[]}"];
    Publisher [label="{Publisher|+name: string|+getBooks(): Book[]}"];
    User [label="{User|+username: string\n+email: string|+borrowBook(b: Book)\n+returnBook(b: Book)}"];
    Loan [label="{Loan|+borrowDate: date\n+returnDate: date|null|}"];

    // 定义关系（调整箭头方向使逻辑更自然）
    Author -> Book [label="writes"];
    Publisher -> Book [label="publishes"];
    User -> Loan [label="makes"];
    Loan -> Book [label="refers to"];

    // 可选：增加约束使布局更紧凑
    {rank=same; Author; Publisher; User}
  }
  ```),
  caption: [raw绘制Graphviz图效果],
  label-name: "graphviz-example-raw",
)

== 数据图

`lilaq` 是一个强大的 Typst 绘图库，可以绘制各种类型的数据图。

#import "@preview/lilaq:0.6.0" as lq

#let xs = (0, 1, 2, 3, 4)
#let (y1, y2) = ((1, 2, 3, 4, 5), (5, 3, 7, 9, 3))

#imagex(
  lq.diagram(
    width: 10cm,
    height: 6cm,

    title: [Precious data],
    xlabel: $x$,
    ylabel: $y$,

    lq.plot(xs, y1, mark: "s", label: [A]),
    lq.plot(xs, y2, mark: "o", label: [B]),
  ),
  caption: [绘制折线图效果],
  caption-en: [Line plots],
  label-name: "lilaq-line-example",
)

#import "@preview/suiji:0.5.1"
#let rng = suiji.gen-rng(33)
#let (rng, x) = suiji.uniform(rng, size: 20)
#let (rng, y) = suiji.uniform(rng, size: 20)
#let (rng, colors) = suiji.uniform(rng, size: 20)
#let (rng, sizes) = suiji.uniform(rng, size: 20)

#imagex(
  lq.diagram(
    width: 10cm,
    height: 6cm,

    lq.scatter(
      x,
      y,
      size: sizes.map(size => 1000 * size),
      color: colors,
      map: color.map.magma,
    ),
  ),
  caption: [绘制散点图效果],
  caption-en: [Scatter],
  label-name: "lilaq-scatter-example",
)
