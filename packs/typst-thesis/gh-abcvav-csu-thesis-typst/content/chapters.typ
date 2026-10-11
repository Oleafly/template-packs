#import "../styles/numbering.typ": main-text-numbering
#import "../styles/heading-settings.typ": main-text-heading
#import "../styles/font-settings.typ": font, font-size
#import "../utils.typ": myalgo, subfig, continued-header, emptypar, subeqs
#set heading(numbering: main-text-numbering)
#show heading: main-text-heading

= 一级标题

== 二级标题

=== 三级标题

`=` 是一级标题

`==` 是二级标题

`===` 是三级标题

*加粗语法*：`*文字包裹于星号中*`


= 图表语法

参考链接：#link("https://typst.app/docs/guides/table-guide/", text(fill: blue, "Table-Guide"))

图表已经设置好按章节自动编号。

#figure(
  table(
    columns: 3,
    align: center,
    table.hline(),
    table.header([表头1], [表头2], [表头3]),
    table.hline(),
    [表项1],[表项2], [表项3],
    [表项4],[表项5], [表项6],
    table.hline(),
  ),
  caption: [普通表]
) <mytable> // 先在表格后打上标签 <mytable>

引用图表的语法：`@mytable`。引用结果：@mytable

#figure(
  table(
    columns: (4cm, auto, auto),
    align: center + horizon,
    [你好], [你好], [你好],
    table.cell(rowspan: 2)[跨行表项, 指定 `align: horizon` 垂直居中], [表头], [表项],
    [表项], [表项]
  ),
  caption: [跨行表]
)

#figure(
  table(
    columns: (3cm, 3cm, 5cm),
    align: center,
    table.hline(),
    table.header([设定columns的长度后], [表头标题超过该长度], [就会自动换行]),
    table.hline(),
    [表项1],[表项2], [表项3],
    [表项4], table.cell(colspan: 2)[使用 `table.cell(colspan: 2)` 跨2列],
    table.hline(),
  ),
  caption: [跨列表]
)

#figure(
  table(
    columns: 3,
    align: center + horizon,
    stroke: none,
    table.hline(),
    table.header([*加粗表头1*], [*加粗表头2*], [不加粗表头3]),
    table.hline(),
    table.cell(rowspan: 2)[跨行表项1],[表项2], [表项3],
    [表项5], [表项6],
    table.hline(),
  ),
  caption: [三线表]
)


#figure(
  image("assets/example.png", width: 50%), // 50% / 1cm
  caption: [图像],
) <label1>

#figure(
  image("assets/example.png", width: 50%), // 50% / 1cm
  caption: [图像],
) <label2>

#subfig(
  columns: 2,
  gutter: -10em,
  figure(
    image("assets/example.png", width: 50%), // 50% / 1cm
    caption: [子图a],
  ),
  figure(
    image("assets/example.png", width: 50%), // 50% / 1cm
    caption: [子图b],
  ),
  caption: [横向子图ab],
)

#[
#figure(
  table(
    columns: 3,
    align: center + horizon,
    stroke: none,
    continued-header(
      colspan: 3,
      [表头1], [表头2], [表头3]
    ),
    table.cell(rowspan: 2)[跨行表项1],[表项2], [表项3], [表项4], [表项5],
    table.cell(rowspan: 2)[跨行表项1],[表项2], [表项3], [表项4], [表项5],
    table.cell(rowspan: 2)[跨行表项1],[表项2], [表项3], [表项4], [表项5],
    table.cell(rowspan: 2)[跨行表项1],[表项2], [表项3], [表项4], [表项5],
    table.cell(rowspan: 2)[跨行表项1],[表项2], [表项3], [表项4], [表项5],
    table.hline(),
  ),
  caption: [跨页三线表]
)]

#subfig(
  columns: 2,
  rows: 2,
  gutter: -10em,
  row-gutter: 0em,
  figure(
    image("assets/example.png", width: 50%), // 50% / 1cm
    caption: [子图a],
  ),
  figure(
    image("assets/example.png", width: 50%), // 50% / 1cm
    caption: [子图b],
  ),
  figure(
    image("assets/example.png", width: 50%), // 50% / 1cm
    caption: [子图c],
  ),
  figure(
    image("assets/example.png", width: 50%), // 50% / 1cm
    caption: [子图d],
  ),
  caption: [横纵向子图ab],
  label: <subfig>
)

通过 `@label-name` 的方式引用图表：@label1 表明...，而@label2 表明，@subfig 表明...

= 公式
行间公式： $ sum_(k=1)^n k = (n(n+1)) / 2 $

行内公式：$sum_(k=1)^n k = (n(n+1)) / 2$ 去掉 `$$` 和公式之间的空格自动变为行内公式。
公式符号表可参考链接：#link("https://typst.app/docs/reference/symbols/sym/", text(fill: blue, "Symbols General"))


行间公式： $ sum_(k=1)^n k = (n(n+1)) / 2 $

行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。行间公式后不顶格。

行间公式： $ sum_(k=1)^n k = (n(n+1)) / 2 $

#emptypar()

行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。行间公式后顶格。

子公式1：

#subeqs(
  $ sum_(k=1)^n k = (n(n+1)) / 2 $,
  $ f(x)= sin(x) $,
  $ g(x)= cos(x) $,
)

#emptypar()

子公式2：
#subeqs(
  $ sum_(k=1)^n k = (n(n+1)) / 2 $,
  $ f(x)= sin(x) $,
  $ g(x)= cos(x) $,
)

= 文献引用

文献引用步骤如下：

在根目录下的 `ref.bib` 文件中加入 bib 格式的


在谷歌学术中点击 `引用`$->$`BibTex` 然后复制到 `ref.bib` 文件中。
长这样：
```bibtex
@inproceedings{resnet,
  title     = {Deep residual learning for image recognition},
  author    = {He, Kaiming and Zhang, Xiangyu and Ren, Shaoqing and Sun, Jian},
  booktitle = {Proceedings of the IEEE conference on computer vision and pattern recognition},
  pages     = {770--778},
  year      = {2016}
}
```

#figure(
  image("assets/bib-ref.png", width: 100%),
  caption: [引用方法],
)


在需要引用的地方使用 `@` 命令：`@resnet`，引用结果：@resnet，参考文献会自动出现在*参考文献*的章节。

== 单文献引用
// 引用后会有一个空格
- 引用后有空格：文献 @resnet 指出，
- 引用后无空格：文献 #[@impagliazzo2001problems]指出，文献 #cite(<impagliazzo2001problems>)指出

== 多文献引用
- 引用后有空格：文献 @resnet @impagliazzo2001problems 指出
- 引用后无空格：文献 #[@resnet @impagliazzo2001problems]指出
