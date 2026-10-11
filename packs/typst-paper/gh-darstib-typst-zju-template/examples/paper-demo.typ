#import "../src/lib.typ": *

#let language = "zh" // 语言设置，默认为 "zh"，可选 "en"
#show: template.with(
  language: language,
  course: [中文+标题居中+摘要+双栏展示], // 课程名称，即第一个页面右上角的内容，可能需要使用 `#text(size: xxpt)[course name]` 来调整大小
  title: [基本使用], // 文章标题
  title_align: "center", // 标题对齐方式，默认 "center"，可选 "left"
  date: [#datetime.today().display()], // 日期，默认无，datetime.today() 为当前日期
  authors: (
    (
      name: "浅碎时光",
      id: "1234567890",
      institution: "信息安全 xxxx",
      mail: "darstib@zju.edu.cn",
    ),
    (
      name: "浅碎时光",
      id: "1234567890",
      institution: "信息安全 xxxx",
      mail: "darstib@zju.edu.cn",
    ),
  ),
  // title_en: [Course Paper Title], // 英文标题
  // abstract: [#lorem(100)],
  // keywords: ("keyword1", "keyword2"),
  abstract_zh: [由于部分中文论文要求在中文摘要后添加英文标题/摘要/关键词，而英文论文不需要中文。具体选择权交给大家：对于`date`, `author`, `title, abstract, keywords, abstract_zh` 和 `keywords_zh`，如果需要可以填写内容 ，则不会在页面中显示。
    如果需要在摘要结束后分页，设置 `pagebreak_after_title: true` 即可；如果不需要在摘要后显示目录，设置 `include_toc: false` 即可；如果不需要在目录结束后分页，设置 `pagebreak_after_toc: false` 即可。
    \ \
    *这篇文章的主要内容是模板中基本内容的使用示例，一些模板中的额外设置以及针对中文论文的配置。*],
  keywords_zh: ("基础用法", "中文论文"),
  include_toc: true, // 一般来说论文没有目录，这里方便读者定位
  // pagebreak_after_toc: false,
  columns: 2,
)

= 图片和表格

如果你对当前默认配置不满意，或者对正文格式有特殊的需求，可以自定义配置来覆盖默认。

// 可以自定义一些配置覆盖默认配置
#set text(font: "FangSong", size: 10pt)
#set par(leading: 0.6em)
// #set heading(numbering: "1.1.")

== 文字说明的位置和对齐

=== 位置

对于 `figure` 布局的内容，如果为图片，则会将 caption 放在图片下方（这是 typst 的默认布局），如@img:demo：

#figure(
  placement: none,
  scope: "column", // 作用域为父级；还可选 "column"，作用域为当前栏目
  image("img/demo.jpg", width: 80%),
  caption: "一个图片的例子",
)<img:demo>

但是如果为表格，则会将 caption 放在表格上方，如@tbl:demo 所示：

#figure(
  placement: none,
  scope: "column", // 作用域为父级；还可选 "column"，作用域为当前栏目
  table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: (horizon + center, horizon + center, horizon),
    table.header(
      [*Shape*],
      [*Volume*],
      [*Parameters*],
    ),

    align(center)[cylinder],
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],

    align(center)[tetrahedron], $ sqrt(2) / 12 a^3 $, [$a$: edge length],
  ),
  caption: "一个表格的例子",
)<tbl:demo>

=== supplement

在图表说明的前面往往有一个 “图x” “表x”的标识符，称为 supplement；在本模板中，其应该是加粗体（可能存在部分字体不明显的情况，比如当前部分使用的思源宋体在我当前设备上加粗并不明显）

=== 对齐

默认情况下我们的 caption 是居中对齐的，但是如果很长，则会导致最后一行也居中的情况；此时我们可以使用 `align(left)` 来将 caption 左对齐（这里使用了 `#[]` 来确保左对齐只是影响当前的图表），如@tbl:var_correspondence_task2 所示。

但是此时可能引入 `placement: auto` 失效的问题，导致图表无法自动放置在合适的位置（尤其在双栏中）。

有时为了减小从 markdown 转变为 tablem 的麻烦，我会使用 `#import "@preview/tablem:0.2.0": three-line-table`#footnote[https://typst.app/universe/package/tablem/] 来生成表格，这样可以更方便地使用 markdown 语法来编写表格内容。

#[#show figure.caption: set align(left)
  #figure(
    placement: auto,
    scope: "column",
    three-line-table(column-gutter: 5%)[
      | *data\\item* | *rating* | *likes* | *views* | *word_count* | *price* |
      | :---: | :------: | :-----: | :-----: | :--------: | :------: |
      | *count* | 30 | 400 | 400 | 400 | 400 |
      | *mean* | 4.800 | 7.875 | 78.955 | 40.560 | 3.875 |
      | *std* | 0.761 | 8.305 | 150.518 | 13.095 | 0.720 |
      | *min* | 1 | 0 | 4 | 17 | 0 |
      | *25%* | 5 | 2 | 23.75 | 32 | 2.99 |
      | *50%* | 5 | 5 | 41 | 38 | 3.99 |
      | *75%* | 5 | 12 | 73.25 | 47 | 3.99 |
      | *max* | 5 | 83 | 1900 | 112 | 7.99 |
    ],
    caption: [卖家提示的数据分布，包括评级、点赞、浏览量、字数和价格。该表总结了每个属性的关键统计信息。],
  )<tbl:distribution>
]

== 跨越

在使用双栏时，图表需要足够宽的情况下可以在 `figure` 中设置 `scope: "parent"`，这样 typst 会将图表跨越两栏，如@tbl:var_correspondence_task2；一般我们还会设置 `placement: auto`，这样 typst 会自动将图表放在合适#footnote[好吧有时候并不是那么合适……]的位置。



= 其他改进

== 无编号内容的引用

按照现有 typst 0.13 的语法，只能够对 figure 等布局以及 `numbering: true` 的标题进行`<tag>`等待`@label`引用；但是如果我们需要添加@appendix 等不适合参与序号的标题时，可以使用 `numbering: none` 来避免参与序号，此时无法直接引用，警告以下错误：

```error
cannot reference heading without numbering
Hint: you can enable heading numbering with `#set heading(numbering: "1.")`
```

对 ref 进行修改，可以实现对无序列标题的引用（写入 template 中，无需使用者显示调用）：

```typ
#show ref: it => {
  if it.element != none and it.element.func() == heading and it.element.numbering == none {
    it.element.body
  } else {
    it
  }
}
```

== 无序列表

在部分字体下，typst 的无序列表的点可能显示不同，有时不太明显，这里指明了使用的标识符：

```typ
#set list(
  indent: 0.25em,
  marker: (
    $bullet$,
    $triangle.filled.small.r$,
    $diamond.filled.small$,
    $square.filled.small$,
    $star.filled$,
  ),)
```

- 最后
  - 大概
    - 就是
      - 这样的
        - 效果

#figure(
  placement: bottom,
  scope: "parent",
  three-line-table[
    | *变量名称 (代码中)* | *论文中对应符号/概念* | *简要描述/作用* |
    | :------------------: | :-----------------: | :---------: |
    | `perturbed_samples` | $x_"adv"^t$ | 当前迭代的对抗样本 (在迭代开始时) |
    | `primary_gradient` | $hat(g)_(t+1)$ | 当前对抗样本 $x_"adv"^t$ 处的原始梯度 (步骤 1 的结果, 未调优) |
    | `gradient_variance` | $v_t$ / $v_(t+1)$ | 用于调优当前梯度的是上一轮计算的 $v_t$；\ 本轮计算并存储的是 $v_(t+1)$ (供下一轮使用) |
    | `gradient_momentum` | $g_t$ / $g_(t+1)$ | 用于计算当前动量的是上一轮的 $g_t$；\ 本轮更新后存储的是 $g_(t+1)$ (已包含方差调优) |
    | `normalized_grad` | 代表 $(hat(g)_(t+1) + v_t) / (norm(hat(g)_(t+1) + v_t)_1)$ 后成为 $g_(t+1)$ | 中间变量：1. 初始为 $hat(g)_(t+1) + v_t$ 经L1归一化后的结果；\ 2. 加上动量项 $mu dot g_t$ 后成为 $g_(t+1)$ |
    | `neighbor_samples` | $N$ | 梯度方差计算中邻域样本的数量 (超参数) |
  ],
  caption: [Python 代码中的变量与论文符号对应],
)<tbl:var_correspondence_task2>

// 中英文混用问题
#let bib_file = "refs.bib"
#if (bib_file != none) {
  if (language == "zh") {
    bilingual-bibliography(bibliography: bibliography.with(bib_file))
  } else {
    bibliography(bib_file)
  }
}

#line(length: 100%, stroke: 0.2pt)

对于参考文献，单纯的英文参考文献和中文参考文献没有什么大问题，但是当中英文文献混用时，可能会出现一些问题。Typst 的 `bibliography` 函数可以处理纯英文参考文献，但是对于中英文混和的参考文献，可能需要使用 `bilingual-bibliography` 函数。

这里@kopka2004guide 是一个简单的测试和例子@wang2010guide @testa1TestBook2021，仅测试了中文中常用的 “gb-7714-2015-numeric” 格式。

#heading(
  "附录",
  numbering: none, // 不参与序号
  outlined: true, // 在目录中展示
)<appendix>
