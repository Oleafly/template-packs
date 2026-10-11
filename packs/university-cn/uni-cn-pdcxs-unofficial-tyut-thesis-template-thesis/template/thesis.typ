#import "../lib.typ": documentclass
#import "@preview/codly:1.3.0": codly-init // 如果不需要插入源代码，可以删除此行代码
#import "@preview/algo:0.3.6": * // 如不需要伪代码，可以删除此行代码

#let (
  doc,
  cover,
  decl,
  abstract,
  abstract-en,
  preface,
  outline-page,
  mainmatter,
  gloss,
  make-glossary-table,
  no-indent,
  init-bib,
  bibliography,
  multicite,
  acknowledgement,
  twoside,
  appendix,
) = documentclass(
  // anonymous: true, // 需要匿名可以打开此选项
  // twoside: true, // 打印纸质版时可以打开此选项
  info: (
    title: ("基于 Typst 的太原理工大学论文模板", "——非官方版本"),
    title-en: " A Typst Template for TYUT Thesis - Unofficial Edition",
    author: "爱因斯坦",
    student-id: "11001101010086",
    // department: "计算机科学与技术学院\n（大数据学院）", // 多行内容可以添加\n
    department: "XX学院",
    session: "20XX",
    major: "XX专业",
    class: "XX班",
    supervisor: ("张三", "教授"),
    submit-date: datetime.today(),
    // submit-date: datetime(year: 2025, month: 1, day: 28)
    // author-sign-date: datetime.today(), // 承诺书作者签名日期
    // supervisor-sign-date: datetime(year: 1997, month: 1, day:1), // 承诺书导师签名日期
  ),
  reference-data: read("./references.bib"),
  // font: "KaiTi", // Main Font
  // reference-font: ("Times New Roman", "SimSun"),
)

#show: doc
#cover()

// 以下是声明页插入电子签名的方法
// #decl(
//   author-signature: place(
//     dy: -1em,
//     dx: 1em,
//     image("imgs/author-signature.jpg", height: 2em)),
//   supervisor-signature: place(
//     dy: -1em,
//     dx: 1em,
//     image("imgs/author-signature.jpg", height: 2em)),
//     )
// 如果插入电子签名，请删除下行，否则会有两个声明页
#decl()

// 如果需要插入任务书，可将任务书转换为 PDF
// 再把 PDF 转换为图片，使用以下工具：
// https://smallpdf.com/pdf-to-jpg，
// 然后使用以下代码插入：
// #[
//   #set page(margin: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt))
//   #image("page-1.jpg", height: 100%)
//   #image("page-2.jpg", height: 100%)
// ]

#show: preface

// 术语列表
#make-glossary-table((
  (
    key: "urllc",
    short: "URLLC",
    long: "Ultra-Reliable and Low Latency Communications",
    description: "超可靠低延迟通信",
  ),
  (
    key: "api",
    short: "API",
    long: "Application Program Interface",
    description: "应用程序接口",
  ),
  (
    key: "tyut",
    short: "TYUT",
    long: "Taiyuan University of Technology",
    description: "太原理工大学",
  ),
  (
    key: "yolo",
    short: "YOLO",
    long: "You Only Look Once",
    description: "",
  ),
));

#abstract(keywords: ("Typst", "TYUT", "Template", "Thesis", "毕业论文"))[
  本项目是基于 Typst 制作的一款适用于#gloss("tyut")本科
  毕设论文的模板，注意此模板不是#gloss("tyut")官方模板，
  因此有不被承认的风险，请谨慎使用。

  使用本项目需要具备基本的 Typst 使用知识，
  学习大概需要1小时，
  需要阅读#link("https://typst.app/docs/tutorial")[
    #text(fill: blue)[#underline[官方入门教程]]]。
]

#abstract-en(keywords: ("Typst", "TYUT", "Template", "Thesis"))[
  This project is based on Typst to produce
  a template for undergraduate BSc thesis of
  Taiyuan University of Technology,
  note that it is an unofficial template,
  so there exists the risk of not being recognized,
  please use with caution.

  Using this project requires basic knowledge of
  using Typst, which takes about 1 hour to learn
  and requires reading
  #link("https://typst.app/docs/tutorial")[
    #text(fill: blue)[#underline[
      Official Getting Started Tutorial]]].
]

#show: init-bib

#outline-page()

#pagebreak()

#show: mainmatter
// 如果觉得公式字体不好看，可以将
// #show: mainmatter
// 替换为：
// #show: mainmatter.with(mono-font: ("JetBrains Mono", "LXGW WenKai Mono"))
// 这样会把公式的英文字体换为 JetBrains Mono
// 公式的中文字体换为霞鹜文楷等宽字体。
// 当然，需要在本地安装对应字体
// 或者在在线APP的项目中上传对应字体。

#show: codly-init.with() // 如果不需要插入源代码，可以删除此行代码


= 绪论

== 基本书写

直接输入文字即可。需要注意，如果两行之间没有空行，
像现在这样，会自动合并为一行。如果需要换行，
则需要多打一个空行。

像现在这样。

星号包裹内容为加粗内容，如*加粗内容*。

== 无序列表

可以通过以下方式添加无续列表：

- 表项1
- 表项2
  - 表项3
  - 表项4

== 有序列表

通过以下方式添加有续列表：

+ 表项1
+ 表项2
  + 表项3
  + 表项4
+ 表项5

尽量不要直接使用默认的有序列表编号，应为容易和章节标题编号混淆。
可以使用如下方式更改有续列表的编号样式：

#[
  #set enum(numbering: "A.a)")
  + 表项1
  + 表项2
    + 表项3
    + 表项4
  + 表项5
]

或者更复杂的自定义方案：

#[
  #enum(
    numbering: "A.",
    enum.item(1)[表项1],
    enum.item(2)[表项2
      #enum(
        numbering: (..nums) => "B." + numbering("a)", ..nums),
        enum.item(1)[表项3],
        enum.item(2)[表项4],
      )
    ],
    enum.item(3)[表项5],
  )
]

在论文正文中，应当尽量减少列表的使用。
如果想要说明一个方法的流程，可以考虑绘制流程图或者使用伪代码。

== 术语

如果论文中出现缩写，推荐使用 gloss 工具进行管理，
先将相关内容放入文档开头处的 make-glossary-table 中，
之后再使用，例如，第一次出现#gloss("urllc")时，
会写出对应的中文内容、英文全称和缩写，之后再出现
#gloss("urllc")时，则只出现缩写。再举一个例子：
#gloss("api")应当是全称，#gloss("api")和#gloss("api")
应当只显示缩写。
如果术语没有中文翻译，则可以使其 description 为空字符串，
例如#gloss("yolo")，第一次出现时只显示全称，
之后再出现则只显示缩写，如#gloss("yolo")。

如果引用了列表中没有出现的术语，
则会出现红色警告，例如：#gloss("vanet")

== 图片和表格

引用@tbl:timing，引用@tbl:timing-tlt，以及@fig:some-figure。
引用图表时，表格和图片分别需要加上
`tbl:`和`fig:` 前缀才能正常显示编号。
图片、表格以及引用的标签，尽量不要添加编号信息，
以真正的内容作为标签。
比如，`<root-solver-equation>` 是一个好标签，
`<equation-5>` 是一个糟糕的标签。

#figure(
  table(
    align: center + horizon,
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [常规表],
  placement: auto,
) <timing>


#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(),
    [t], [1], [2], [3],
    table.hline(stroke: .5pt),
    [y], [0.3s], [0.4s], [0.8s],
    table.hline(),
  ),
  caption: [三线表],
  placement: auto,
) <timing-tlt>

建议所有的 `figure` 都添加`placement`选项，
这样可以避免由于图片过大而产生大片的文字空白。
然而，这会导致图片位置可能并不会紧挨着文本。
因此，在引用图片时，不要说“如下图所示”或者“如上表所示”，
而是要通过引用编号来指明哪个图或者表。
例如，如@fig:some-figure 所示
（注意，“如”字后边和`@`符号之前没有空格，但是
标签结束后需要加一个空格）。
建议所有的图或者表都在正文中引用，并加以说明，否则会显得比较突兀。

如果觉得自动放置的图片位置不合适，
可以将 `placement` 选项的值设置为 `none` 或者 `bottom` 和 `top`。

建议表格尽量使用三线表的形式，美观一些。

#figure(
  image("imgs/author-signature.jpg", width: 50%),
  numbering: none,
  placement: auto,
  caption: [图片测试],
) <some-figure>

#figure(
  [
    #set text(font: ("Times New Roman", "SimHei"), size: 10pt)
    #set stack(dir: ttb, spacing: 0.5em)
    #set image(height: 2cm)
    #grid(
      columns: 2,
      gutter: 1em,
      stack(image("imgs/author-signature.jpg"), [(a) 子图1]), stack(image("imgs/author-signature.jpg"), [(b) 子图2]),
      stack(image("imgs/author-signature.jpg"), [(c) 子图3]), stack(image("imgs/author-signature.jpg"), [(d) 子图4]),
    )],
  caption: [多图示例],
  placement: auto,
) <multiple-figures>

@fig:multiple-figures 是一个多图合并的例子。
如果需要将多张图放到一起，推荐采用这种方式。

== 引用

直接引用相关 `bib` 文件中的条目即可
（大部分论文支持导出引用为 `bib` 格式，
如果不支持，也可以采用相应工具
把导出的引用内容转换为 `bib` 格式），
如这里引用了@deepLearn。中文引用@蒋有绪1998 也可以正常显示。
引用会按照出现的顺序自动编号，因此，
尽量不要在引用的标签中加入序号信息。
例如，`ref6` 是一个糟糕的引用标签，
`<Strange2012>` 则是一个不错的引用标签。
默认引用为上标形式，如果想要采用非上标形式，则需要这样：
另见 #cite(<deepLearn>, form: "prose") 的详细分析。
引用也可以添加作者，
比如：#cite(<蒋有绪1998>, form: "author")在
#cite(<蒋有绪1998>, form: "prose") 中，
提出了重要的理论框架。不过直接引用作者可能会产生额外空格，
建议作者直接手工输入。

当需要在同一个地方引用多个文献时，需要使用 `multicite` 函数，
如#multicite("蒋有绪1998", "deepLearn", "中国力学学会1990")，
此时，引用会自动进行合并，如果不是连续的序号，则会自动断开，
如#multicite("deepLearn", "中国力学学会1990")。此外，
如果需要非上标形式，
则可以：#multicite("蒋有绪1998", "deepLearn", "中国力学学会1990", form: "prose")。
需要注意的是，`multicite` 不支持直接引用作者，
即 `form` 字段不支持 `author` 选项。

== 目录

目录会自动生成一到三级标题的索引，例如，以下内容：

=== 三级标题

会被自动添加到目录当中。而以下内容

==== 四级标题

则不会出现在目录当中。



= 数学公式与代码

== 数学公式示例

我们可以利用求根公式来得到一般形式的
一元二次方程：$a x^2 + b x + c = 0$
的解，其具体内容为（如果不希望公式后边段落有缩进，
可以使用 `no-indent` 函数）：

$
  x_(1,2) = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a),
$ <root-finder>

#no-indent[
  其中， $a, b$ 和 $c$ 为原始方程的系数。
  根据@eqt:root-finder, 可以看到，每个一元二次方程，
  都有两个解，不过有时候两个根可能相等，有时候可能会出现复数根。
]

一般而言，如果公式后边是解释公式符号的内容，
意味着公式并不是这句话的结束，因此需要在公式后边添加一个英文逗号，
且下一段不需要空两格。而如果公式结束就是当前句子的结束，
则后边添加英文句号，下一段需要空两格开始。

根据相关公式，我们可以得到 $e^x$ 的泰勒展示：

$
  e^x= sum_(i=0)^oo x^i / i!.
$

如果某个公式不需要编号，可以加入 `<->` 标签。如：

$
  integral.cont sqrt(x^2+y^2) dif x dif y.
$ <->

但是后续公式会自动继续编号：

$
  e^(i pi) + 1 = 0.
$

更多数学公式内容，参考#text(fill: blue)[#underline[
  #link("https://typst.app/docs/reference/math/")[*官方文档*]]]。
也可使用#text(fill: blue)[#underline[
  #link("https://typerino.com/")[*在线公式编辑器*]]]进行公式编辑。

== 代码

=== 行内代码与块代码

行内代码块需要包裹在反引号内，如 `http`。
如果想要插入行内代码内容，则可以用反引号包裹，
比如 `print("Hello, world!")`。
如果想要行内公式有语法高亮，则需要使用三个反引号包裹，
且在开始位置加入语言名称，
如：```python print("Hello, world!")```
不过代码内容为用 `mono-font` 字体，
可能会被质疑没有遵守正文中英文字体为新罗马字体的要求，
所以要谨慎使用。
此外，*过长的行内公式*可能导致段内文字间空白过大，也需加以控制。
如果想要改变公式字体，
参考本文件在 ```typst #show mainmatter```
附近的注释内容（本文件中的注释内容很重要，建议仔细阅读）。

块级代码则需要以三个反引号包裹，
后面加上语言名称（可选，加上会有语法高亮），
如@lst:cpp-code 所示。如果需要引用代码，
需要加上`lst`，如这里引用了@lst:cpp-code。

#figure(
  ```cpp
  #include <vector>
  #include <iostream>
  using std::cout;
  using std::endl;
  using std::vector;

  int main() {
    vector<int> v{10, 3};
    for (auto i : v) {
      cout << i << endl;
    }
    // 这是中文注释。
    return 0;
  }
  ```,
  placement: auto,
  caption: [代码块展示],
) <cpp-code>



=== 伪代码

伪代码可以用 `algo` 库，如@alg:fib 所示。


#figure(
  algo(
    title: "Fib",
    parameters: ("n",),
  )[
    if $n < 0$:#i\ // use #i to indent the following lines
    return null#d\ // use #d to dedent the following lines
    if $n = 0$ or $n = 1$:#i #comment[you can also]\
    return $n$#d #comment[添加 comments!]\
    return #smallcaps("Fib")$(n-1) +$ #smallcaps("Fib")$(n-2)$
  ],
  caption: [斐波那契数列],
  kind: "algo",
  supplement: "算法",
  placement: none,
) <fib>

从@alg:fib 中可以看到，
斐波那契数列可以用递归的方式进行计算（注意此处的引用方法）。

#heading(level: 1, numbering: none)[总结]

使用如@lst:no-number-title 中的方法插入没有编号的标题：

#figure(
  ```typst
  #heading(level: 1, numbering: none)[章节标题]

  章节后续内容……
  ```,
  caption: [插入无编号章节的方法],
)<no-number-title>

例如，此处的总结章节就可以这样处理。
但是需要注意，无编号章节的
图片、公式、表格、代码、二级以下的标题等
编号内容不会自动更新章节编号，
如@lst:no-number-title 所示。
因此，建议无编号章节只用于最后的章节且不要出现引用内容。
或者不要使用无编号章节。

// 参考文献
#bibliography()


#acknowledgement[
  作者在设计（论文）期间都是在×××教授全面、具体指导下完成进行的。
  ×老师渊博的学识、敏锐的思维、民主而严谨的作风使学生受益非浅，
  并终生难忘。

  感谢×××副教授等在毕业设计工作中给予的帮助。

  感谢我的学友和朋友对我的关心和帮助。

]

// 如果不需要附录，请删除后续内容

#show: appendix

// 手动分页
#if twoside {
  pagebreak() + " "
}

= 插入英文文献与中文翻译的方法

从 `#show:appendix` 开始，就是附录部分了。
附录一般放一些额外的数学证明或者其他资料。
有时会要求把英文文献与中文翻译放到附录中。

推荐将英文文献和中文翻译全部导出为 PDF 文件，
然后再使用
#link("https://smallpdf.com/pdf-to-jpg")[
  #text(fill: blue)[#underline[SmallPDF]]]
把 PDF 文件转换为图片（每一页一张图片），
然后插入到此处的附录当中。

例如，英文参考文献有20页，
分别放置于项目目录中的 `paper` 文件夹中的
`1.jpg`，`2.jpg` 到 `20.jpg` 当中，
则可以在文档的附录中，使用@lst:pdf-insert-method 进行插入
（注意，`paper/` 路径和数字 21 需要根据具体路径、
页数和图片的命名方式进行变动）。

#figure(
  ```typst
  #image("paper/1.jpg")
  #pagebreak()

  #[
    #set page(margin: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt))
    #for i in range(2, 21) {
      image("paper/" + str(i) + ".jpg", width: 100%)
    }
  ]
  ```,
  caption: [插入其他 PDF 的方法],
)<pdf-insert-method>

由于第一页有章节标题，因此无法将插入的图片铺满整个页面。
后续内容则可以将页边距设置为 0 后，
插入铺满页面的图片。如果觉得插入的图片将论文页码
覆盖不太好看，可以将图片的上下空白区域裁剪掉
以显示出论文的页码。

目前 `Typst` 正在准备支持目录扫描功能，
此功能实现后插入其他 PDF 将直接实现为新的模板函数，
无需再手写代码。

= 关于网络演算的基本说明

== 到达曲线的说明

$
  lr(chevron.l f, alpha chevron.r) =
  sup_(0 <= t <= s) [f(x-t) + f(t) <= alpha]
$ <appendix-equation>

#figure(
  image("imgs/author-signature.jpg"),
  caption: [附录图片],
) <appendix-figure>

再试试表格。

#figure(
  table(
    align: center,
    columns: 3,
    [a], [b], [c],
    [d], [e], [f],
  ),
  caption: [附录表格],
) <appendix-table>

附录中的公式引用：@eqt:appendix-equation，
附录中的图片引用：@fig:appendix-figure，
附录中的表格引用：@tbl:appendix-table。

= 一些证明细节

== 另外的数学公式

$
  integral_(-oo)^oo x dif x = 0
$ <appendix-equation2>

#figure(
  image("imgs/author-signature.jpg"),
  caption: [附录图片],
) <appendix-figure2>

附录中的公式引用：@eqt:appendix-equation2，
附录中的图片引用：@fig:appendix-figure2.
