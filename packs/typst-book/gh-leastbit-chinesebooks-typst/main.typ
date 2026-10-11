// ==================文档基本设置==================
// 封面变量，统一管理封面内容
#let cover = (
  title: "Typst中文书籍示例",
  subtitle: "基于Typst的现代排版系统",
  author_line: [#link("https://github.com/LeastBit")[LeastBit] 编著],
  logo: "cover.png", // 相对或绝对路径
  publisher: "https://github.com/LeastBit", 
  date: "2025年9月",
)


// ==================文档基本样式设置=========================
// 启用数学公式编号
#set math.equation(numbering: (..nums) => {
    // 章号 = 当前公式之前的一级标题数
    let chap = query(selector(heading.where(level: 1)).before(here())).len()-1
    // 返回形如 1.1, 1.2 的编号
    return [(#chap.#numbering("1", nums.pos().at(0)))]
})


// 中文字体设置
// 可以根据需要更改为其他中文字体
// 确保系统中已安装所选字体
#set text(
  font: ("Noto Serif SC"),
  size: 12pt,
  lang: "zh",
  region: "cn",
)

// 全局设置
#set par(
  first-line-indent: (amount: 2em, all: true),
  justify: true,
  leading: 1em,
)

// 标题样式与间距
#show heading.where(level: 1): it => {
  v(0em)                       // 一级标题前间距
  set align(center)
  set text(size: 18pt, weight: "bold")
  it
  v(0.2em)                     // 一级标题后间距
}

#show heading.where(level: 2): it => {
  v(0em)                       // 二级标题前间距
  set text(size: 14pt, weight: "bold")
  it
  v(0.2em)                     // 二级标题后间距
}

#show heading.where(level: 3): it => {
  v(0em)                       // 三级标题前间距
  set text(size: 12pt, weight: "bold")
  it
  v(0.2em)                     // 三级标题后间距
}

#set list(indent: 2em)
#set enum(indent: 2em)

// 引用样式设置（GB/T 7714-2015）
#set bibliography(
  style: "gb-7714-2015-numeric",
  title: "参考文献"
)

// ==================== 封面页 ====================
#page(
  margin: 0cm,
  header: none,
  footer: none,
  numbering: none,
)[
  #align(center)[
    #v(3cm)
    
    #text(size: 36pt, weight: "bold")[#cover.title]
    
    #v(1cm)
    
    #text(size: 20pt)[#cover.subtitle]
    
    #v(4cm)
    
    #text(size: 16pt)[#cover.author_line]

    #v(8cm)
    
    #image(cover.logo, width: 3cm)  // 图片参数为表达式，保持不变
    
    #v(1cm)
    
    #text(size: 14pt)[#cover.publisher]
    
    #v(0.5cm)
    
    #text(size: 12pt)[#cover.date]
  ]
]


// ==================== 前言 ====================
#pagebreak()
#counter(page).update(1)
#set page(
  footer: none,  // 如果页码在页脚
)


= 前言 <preface>

本书是一本关于Typst排版系统的中文教程示例。Typst是一个现代化的排版系统，它结合了LaTeX的强大功能和Markdown的简洁语法，为学术写作和技术文档提供了全新的解决方案。

在编写本书的过程中，我们充分考虑了中文排版的特殊需求，包括中文字体的选择、段落缩进、标点符号的处理等。本书采用了相关排版规范，确保内容的专业性和可读性。

本书适合以下读者：

- 需要撰写学术论文的研究人员和学生
- 技术文档编写人员
- 对现代排版系统感兴趣的爱好者
- 希望从LaTeX迁移到更简洁系统的用户

特别感谢Typst开发团队为我们提供了如此优秀的排版工具。

#align(right)[
  李豪 \
  2025年9月于重庆
]

// ==================== 标题编号设置 ====================
#set heading(numbering: (..nums) => {
  let level = nums.pos().len()
  if level == 1 {
    return [第#numbering("一", nums.pos().at(0))章 ]
  } else if level == 2 {
    return [#nums.pos().map(str).join(".") ]
  } else if level == 3 {
    return [#nums.pos().map(str).join(".") ]
  }
})

// ==================== 目录 ====================
#pagebreak()
#set page(numbering: none)  // 禁用页码
#outline(
  title: [目录],
  depth: 3,
  indent: auto,
)

// 页面设置 - A4纸张
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2cm),
  numbering: "1",
  number-align: center,
  // 页眉设置
  header: context {
    // 获取当前章节标题
    let elems = query(selector(heading.where(level: 1)).before(here()))
    let chapter-title = if elems.len() > 0 {
      elems.last().body
    } else {
      []
    }
    
    // 奇偶页不同的页眉
    if calc.odd(here().page()) {
      align(right)[
        #text(size: 10pt, chapter-title)
        // #h(1em)
        #line(length: 100%, stroke: 0.5pt)
      ]
    } else {
      align(left)[
        #text(size: 10pt)[#cover.title]
        #line(length: 100%, stroke: 0.5pt)
        // #h(1em)
      ]
    }
  },
  // 页脚设置
  footer: context {
    align(center)[
      #counter(page).display()
    ]
  }
)
// ==================== 正文开始 ====================
#pagebreak()//分页
#set page(numbering: "1")  // 重新启用页码
#counter(page).update(1)//重置页码

= Typst简介

== 什么是Typst
Typst是一个新一代的排版系统，它旨在成为LaTeX的现代替代品。与传统的排版系统相比，Typst具有以下特点：

首先，Typst采用了更加直观的语法设计。它借鉴了Markdown的简洁性，同时保留了LaTeX的强大功能。这使得用户可以快速上手，而不需要记忆大量的命令。

其次，Typst提供了实时预览功能。用户在编辑文档时可以立即看到排版效果，这大大提高了工作效率。传统的LaTeX需要编译才能看到结果，而Typst的增量编译技术使得预览几乎是即时的。

== Typst的优势

=== 简洁的语法

Typst的语法设计遵循了"简单即美"的原则。例如，创建一个标题只需要使用`=`符号：

```typst
= 一级标题
== 二级标题
=== 三级标题
```

这比LaTeX的`\section{}`、`\subsection{}`等命令更加直观。

=== 强大的编程能力

Typst内置了完整的编程语言，支持变量、函数、循环等编程概念。这使得用户可以创建复杂的自动化排版逻辑。例如：

```typst
#let greeting(name) = [你好，#name！]
#greeting("世界")
```

=== 优秀的中文支持

Typst从设计之初就考虑了国际化需求，对中文的支持非常完善。它能够正确处理中文的断行、标点挤压等排版细节。

== 安装与配置

Typst的安装非常简单。用户可以通过以下几种方式安装：

1. 使用包管理器安装（如brew、apt、winget等）
2. 下载预编译的二进制文件
3. 使用Web版本（无需安装）官网：https://typst.app

安装完成后，只需要创建一个`.typ`文件就可以开始编写文档了。

= 基础语法

== 文本格式

Typst支持多种文本格式化方式。*粗体文本*可以使用星号包围，_斜体文本_使用下划线包围。对于中文排版，我们通常使用*加粗*来强调，而较少使用斜体。

行内代码可以使用反引号包围，如`let x = 42`。对于代码块，可以使用三个反引号：

```python
def hello_world():
    print("你好，世界！")
    return True
```

== 列表

Typst支持有序列表和无序列表。无序列表使用`-`符号：

- 第一项
- 第二项
  - 子项目1
  - 子项目2
- 第三项
有序列表使用`+`符号：

+ 第一步：准备材料
+ 第二步：开始制作
+ 第三步：完成检查

== 表格

Typst提供了灵活的表格功能。下面是一个简单的表格示例：

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),  // 使用比例分配列宽
    inset: 10pt,//单元格行间距
    align: horizon,
    stroke: none,  // 先移除默认边框
    // 添加三线
    table.hline(),
    [*序号*], [*姓名*], [*年龄*], [*职业*],
    table.hline(stroke: 0.5pt),  // 较细的中间线
    [1], [张三], [28], [工程师],
    [2], [李四], [32], [设计师],
    [3], [王五], [25], [教师],
    [4], [赵六], [30], [医生],
    table.hline(),
  ),
  caption: [员工信息表]
) <tab:employee>

如@tab:employee 所示，这是一个基本的员工信息表。

= 高级功能

== 数学公式

Typst对数学公式的支持非常完善。行内公式可以使用`$`符号，如$E = m c^2$。独立公式使用`$`符号并单独成行：

$ 
integral_0^1 x^2 dif x = [x^3/3]_0^1 = 1/3 
$ <eq:integral>

如@eq:integral 所示，这是一个简单的积分公式。更复杂的公式也可以轻松排版：

$
mat(
  a_(11), a_(12), ..., a_(1n);
  a_(21), a_(22), ..., a_(2n);
  dots.v, dots.v, dots.down, dots.v;
  a_(m 1), a_(m 2), ..., a_(m n);
)
$

== 图片插入

Typst支持多种图片格式，包括PNG、JPEG、SVG等。插入图片的基本语法如下：

#figure(
  rect(width: 100%, height: 150pt, fill: gray.lighten(80%))[
    #align(center + horizon)[示例图片占位符]
  ],
  caption: [系统架构图]
) <fig:architecture>

#figure(
  rect(width: 100%, height: 100pt, fill: gray.lighten(90%))[
    #align(center + horizon)[示例图片占位符]
  ],
  caption: [示例图片]
) <fig:example>

如@fig:architecture 所示，这是系统的整体架构。在实际使用中，可以用`image("path/to/image.png")`来插入真实的图片文件。

== 引用管理

学术写作中，文献引用是必不可少的。Typst支持标准的BibTeX格式。在正文中可以使用`@`符号引用文献，如@wang2023typst 和@zhang2024modern 所述。

== 自定义样式

Typst允许用户自定义各种样式。例如，我们可以定义一个提示框：

#let note(body) = {
  rect(
    width: 100%,
    inset: 10pt,
    radius: 4pt,
    fill: blue.lighten(90%),
    stroke: blue,
  )[
    #text(weight: "bold")[注意：]#body
  ]
}

#note[这是一个自定义的提示框，可以用来强调重要信息。]

= 实践案例

== 学术论文排版

学术论文通常包含摘要、关键词、正文、参考文献等部分。Typst可以很好地处理这些需求。下面是一个论文摘要的示例：

#rect(
  width: 100%,
  inset: 15pt,
  fill: gray.lighten(95%),
)[
  #align(center)[#text(weight: "bold", size: 14pt)[摘要]]

  本文介绍了Typst排版系统在中文学术论文写作中的应用。通过对比传统的LaTeX系统，我们发现Typst在易用性、编译速度和中文支持等方面具有明显优势。实验结果表明，使用Typst可以将论文排版效率提高50%以上，同时保持专业的排版质量。

  *关键词*：Typst；排版系统；中文支持；学术写作
]

== 技术文档编写

技术文档需要清晰的结构和良好的代码展示。Typst的语法高亮功能可以很好地展示各种编程语言：

```rust
fn main() {
    let message = "你好，Typst！";
    println!("{}", message);
}
```

== 书籍排版

对于书籍排版，Typst提供了完整的解决方案。它支持：

- 自动生成目录
- 章节编号
- 页眉页脚定制
- 索引生成
- 交叉引用

这些功能使得Typst成为书籍排版的理想选择。

= 总结与展望

== 本书总结

通过本书的学习，读者应该已经掌握了Typst的基本使用方法。我们介绍了：

1. Typst的基本概念和优势
2. 基础语法和文本格式化
3. 数学公式、表格和图片的使用
4. 高级功能如引用管理和自定义样式
5. 实际应用案例

Typst作为一个现代化的排版系统，它不仅继承了传统排版系统的优点，还引入了许多创新特性。对于中文用户来说，Typst提供了优秀的中文支持，使得中文排版变得简单而专业。

== 未来发展

Typst仍在快速发展中。未来可能会加入更多功能：

- 更丰富的模板库
- 增强的协作功能  
- 更多的输出格式支持
- 插件生态系统的完善

随着社区的不断壮大，我们相信Typst会成为学术界和工业界的重要排版工具。

== 学习资源

对于希望深入学习Typst的读者，推荐以下资源：

- 官方文档：最权威的学习资料
- 社区论坛：可以获得帮助和交流经验
- 示例库：包含各种实用的模板和示例
- 视频教程：适合初学者快速入门

持续学习和实践是掌握Typst的关键。建议读者从简单的文档开始，逐步尝试更复杂的排版任务。

// ==================== 附录 ====================
#pagebreak()
#heading(level: 1, outlined: true, numbering: none)[附录A：常用命令速查] <appendix-a>
#figure(
  table(
  columns: (1fr, 1fr, 1fr),
  inset: 10pt,
  align: horizon,
  stroke: none,
  table.hline(),
  [*功能*], [*语法*], [*示例*],
  table.hline(stroke: 0.5pt),
  [一级标题], [`= 标题`], [`= 第一章`],
  [粗体], [`*文本*`], [*重要内容*],
  [斜体], [`_文本_`], [_强调内容_],
  [行内代码], [`` `代码` ``], [`print()`],
  [行内公式], [`$公式$`], [$x^2 + y^2$],
  [引用], [`@标签`], [@fig:example],
  [链接], [`#link("url")[文本]`], [#link("https://typst.app")[Typst]],
  table.hline(),

)
)
// ==================== 参考文献 ====================
#pagebreak()
#bibliography("references.bib")