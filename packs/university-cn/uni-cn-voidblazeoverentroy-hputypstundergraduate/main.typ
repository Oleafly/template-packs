// ============================================================
// Typst 导入语句（类似 Python 的 import / from ... import）
// ============================================================

// #import "path" — 导入其他 Typst 文件中的函数/变量
//   three-line-table 是本地文件，用双引号指定路径
//   : three-line-table, continuable 是解包导入（只导入这两个名称）
#import "utilities/three-line-table.typ": three-line-table, continuable

// #import "@preview/包名:版本" — 从 Typst Universe 官方包仓库导入
//   @preview 是 Typst 的官方包命名空间
//   类似 LaTeX 的 \usepackage 或 npm 的 package.json
#import "@preview/zh-format:0.1.0": zh-format
#import "@preview/i-figured:0.2.4"

// ============================================================
// #set 规则 — 全局默认样式设置（类似 CSS 的全局声明）
// #set <函数名>(参数...) — 修改该函数后续调用的默认参数
// ============================================================

// #set page(...) — 设置页面布局的全局默认值
//   paper: "a4" — 纸张大小，Typst 内置支持 A4、Letter 等标准尺寸
//   margin: (top:, bottom:, left:, right:) — 页边距，支持命名参数
//     注意 Typst 的长度单位：cm（厘米）、pt（点，1pt=1/72英寸）、em（相对字号）
#set page(paper: "a4", margin: (top: 2.54cm, bottom: 2.54cm, left: 3.17cm, right: 3.17cm))

// #set text(...) — 设置文本全局默认值
//   font: (字体1, 字体2, ...) — 字体列表，Typst 按顺序查找，找不到就试用下一个
//     "Times New Roman" — 西文字体
//     "SimSun", "STSong" — 中文字体（宋体）
//   size: 12pt — 正文字号，小四号 ≈ 12pt
#set text(font: ("Times New Roman", "SimSun", "STSong"), size: 12pt)

// #set par(...) — 设置段落全局默认值
//   first-line-indent: (amount: 2em, all: true) — 首行缩进
//     amount: 2em — 缩进两个字符宽度（em 是相对单位，1em = 当前字号）
//     all: true — 所有段落都缩进（默认只缩进第一段）
//   justify: true — 两端对齐（类似 Word 的"两端对齐"）
#set par(first-line-indent: (amount: 2em, all: true), justify: true)

// #set heading(numbering: "1.1") — 标题编号格式
//   "1.1" 是编号模式字符串：
//     1 — 一级标题用阿拉伯数字（1, 2, 3...）
//     . — 分隔符
//     1 — 二级标题也用阿拉伯数字（1.1, 1.2...）
//   类似 Word 的多级列表编号格式
#set heading(numbering: "1.1")

// #show: zh-format — 应用中文格式包
//   #show 是 Typst 的"显示规则"，可以：
//     1. #show: 函数 — 对全部内容应用该函数
//     2. #show 元素: 规则 — 只对特定元素生效
//   zh-format 是来自 @preview/zh-format 包的函数，自动处理中文字距、标点挤压等
#show: zh-format

// ============================================================
// 图表、公式的自动编号
// ============================================================

// #show figure: i-figured.show-figure.with(numbering: "1-1")
//   figure — Typst 的图表容器（包含图片、表格、代码块等）
//   i-figured.show-figure — 来自 i-figured 包的函数，接管 figure 的渲染
//   .with(...) — 函数柯里化，预填参数，返回一个新的函数
//   numbering: "1-1" — 编号格式：章节号-序号（如"图3-1"）
//   这句是说：所有 figure 都用 i-figured 包来渲染，编号格式为"1-1"
#show figure: i-figured.show-figure.with(numbering: "1-1")

// #show math.equation: ... — 对数学公式应用自定义渲染
//   math.equation — 所有数学公式（包括行内 $...$ 和行间 $$...$$）
//   i-figured.show-equation — i-figured 包的公式渲染函数
//   numbering: "(1-1)" — 公式编号格式，括号包围的章节-序号
//   unnumbered-label: "-" — 不编号的公式使用什么标签
//     公式末尾加 <-> 表示不编号
#show math.equation: i-figured.show-equation.with(numbering: "(1-1)", unnumbered-label: "-")

// #show figure.caption: set text(...)
//   figure.caption — 图表的标题文字
//   这种语法是"对匹配的元素应用 set 规则"
//   这里设置图表标题字体为 Times New Roman + SimSun，字号 10.5pt（五号）
#show figure.caption: set text(font: ("Times New Roman", "SimSun"), size: 10.5pt)
// 设置图表标题的段间距（leading 是行距/段前间距）
#show figure.caption: set par(leading: 0.75em)

// #set figure.caption(...) — 设置 figure 标题的默认参数
//   separator: "　" — 编号和标题内容之间的分隔符（全角空格）
//   position: top — 标题位置在图表上方（学术论文通常图注在下、表注在上）
#set figure.caption(separator: "　")
#set figure.caption(position: top)

// #show figure: set block(breakable: true)
//   允许 figure 在分页时被拆断（跨页显示）
//   block 是 Typst 的块级容器，默认不可跨页断开
//   breakable: true 允许跨页
#show figure: set block(breakable: true)

// ============================================================
// 图表、公式计数器重置
// #show heading: i-figured.reset-counters
//   每当遇到 heading（标题）时，就调用 reset-counters
//   这样每进入新一章，图表和公式的编号自动从 1 重新开始
// ============================================================
#show heading: i-figured.reset-counters

// ============================================================
// 修复交叉引用编号（使引用与 i-figured 图表标题编号一致）
//
// #show ref: it => { ... }
//   ref — 交叉引用，如 @fig:xxx 或 @tbl:xxx
//   it => { ... } — 匿名函数（闭包），it 是原始引用元素
//   这个 show 规则接管了所有引用的渲染，让引用的编号格式
//   与图表标题保持一致
// ============================================================
#show ref: it => {
  // it.element — 被引用对象（figure、equation 等）
  // 如果引用对象不存在（none），直接返回原始引用文本
  let el = it.element
  if el == none { return it }

  // Typst 的 el.func() — 获取元素的类型函数
  // figure — 图表（图片、表格等）
  // math.equation — 数学公式
  if el.func() == figure {
    // ---- 图表引用 ----
    // counter(heading).at(el.location()).first()
    //   counter — 计数器（类似 LaTeX 的 counter）
    //   counter(heading) — 标题计数器
    //   .at(location) — 获取在某个位置时的计数器值
    //   .first() — 取第一个值（一级标题的编号）
    //   这里获取被引用图表所在章节的编号
    let chapter = counter(heading).at(el.location()).first()

    // 获取图表的类型（kind）：是"图"还是"表"？
    // el.kind 可能是字符串，可能是自定义类型
    // type(el.kind) == str 判断是否为字符串
    // repr(el.kind) — 将任意值转为字符串表示
    let kind-str = if type(el.kind) == str { el.kind } else { repr(el.kind) }

    // 获取 i-figured 包管理的图表计数器值
    // figure.where(kind: "i-figured-" + kind-str) — 筛选出指定类型的图表
    // counter(...).at(el.location()).first() — 获取该类型的当前计数值
    // + 1 — i-figured 计数器从 0 开始，显示时需要 +1
    let fig-count = counter(figure.where(kind: "i-figured-" + kind-str)).at(el.location()).first() + 1

    // 合成完整的编号：如 "3-1"（第3章第1个图）
    // numbering("1-1", chapter, fig-count) — 用模板字符串格式化编号
    let full-num = numbering("1-1", chapter, fig-count)

    // 获取 caption 中的前缀文字（supplement）
    // caption 是字典类型，supplement 键对应"图"或"表"这样的文字
    // .at("supplement", default: none) — 安全取值，不存在则返回 none
    let sup = el.caption.at("supplement", default: none)

    // 返回格式化的引用：[图 3-1] 或 [3-1]（无 supplement 时）
    // 方括号内是 Typst 的"内容块"（content），可包含多种元素
    if sup != none {
      [#sup #full-num]
    } else {
      [#full-num]
    }
  } else if el.func() == math.equation {
    // ---- 公式引用 ----
    let chapter = counter(heading).at(el.location()).first()
    // math.equation 的计数器没有 i-figured 前缀，直接使用
    let eq-count = counter(math.equation).at(el.location()).first()
    let full-num = numbering("(1-1)", chapter, eq-count)
    [#full-num]
  } else {
    // 其他类型的引用，原样输出
    it
  }
}

// ============================================================
// 标题样式定义
//
// #show heading.where(level: 1): it => { ... }
//   heading.where(level: 1) — 筛选函数，匹配一级标题
//   这里分别定义了三级标题的字体、字号、间距
// ============================================================

// 一级标题（章标题）—
//   font: ("Times New Roman", "SimHei") — 西文用 TNR，中文用黑体
//   size: 15pt — 字号
//   leading: 2em — 段前段后间距（2 倍行距）
//   first-line-indent: 0em — 取消首行缩进（标题通常不缩进）
//   align(center, it) — 居中显示
#show heading.where(level: 1): it => {
  set text(font: ("Times New Roman", "SimHei"), size: 15pt)
  set par(leading: 2em, first-line-indent: 0em)
  align(center, it)
}

// 二级标题（节标题）— 宋体 14pt 加粗
#show heading.where(level: 2): it => {
  set text(font: ("Times New Roman", "SimSun"), size: 14pt, weight: 700)
  set par(leading: 1.5em)
  it
}

// 三级标题（小节标题）— 宋体 12pt
#show heading.where(level: 3): it => {
  set text(font: ("Times New Roman", "SimSun"), size: 12pt)
  set par(leading: 1.3em)
  it
}

// ============================================================
// 封面页
// ============================================================

// #set page(header: none, footer: none) — 封面不显示页眉页脚
//   header/footer 设为 none 表示不渲染页眉页脚
#set page(header: none, footer: none)

// #align(center)[...] — 将内容居中
//   align 是 Typst 的对齐函数，语法类似 HTML 的 <center> 标签
//   方括号 [...] 是内容块（content block），类似 JSX 的 JSX.Element
#align(center)[
  // #v(2cm) — 垂直间距（类似 HTML 的 margin-top）
  //   在 Typst 中，v() 和 h() 分别表示水平和垂直空白
  #v(2cm)

  // ---- 校名（图片） ----
  // #image("路径", width:, height:) — 插入图片
  //   "assets/黑色校名.png" — 图片文件路径（相对 main.typ 的位置）
  //   width/height 可按比例缩放
  #image("assets/黑色校名.png", width: 7cm, height: 1.2cm)
  #v(0.6cm)

  // ---- 论文类型 ----
  // #scale(x:, y:)[内容] — 缩放内容
  //   x: 70%, y: 110% — 水平压缩、垂直拉伸达到某种字体效果
  // #text(size:, weight:, font:, tracking:)[内容] — 设置文本属性
  //   tracking: 5pt — 字符间距（字距），类似 CSS 的 letter-spacing
  #scale(x: 70%, y: 110%)[#text(size: 30pt, weight: "bold", font: "SimHei", tracking: 5pt)[本科毕业论文（设计）]]
  #v(2cm)

  // ---- 论文题目（带下划线） ----
  #text(size: 16pt, font: ("SimSun", "STSong"))[
    基于 Typst 的论文模板设计

  ]
  #v(3cm)

  // ---- 个人信息字段（下划线风格） ----
  // Typst 的 let 定义局部变量/函数
  //   let field(label, value) = { ... } — 定义函数
  //     参数 label: 字段名，value: 字段值
  //   类似 JavaScript 的 const field = (label, value) => { ... }
  #let field(label, value) = {
    // grid(columns:, column-gutter:)[内容...] — 网格布局
    //   columns: (8em, 1fr) — 两列：第一列 8em 宽，第二列占剩余空间
    //     1fr 是 fraction 的缩写，类似 CSS Grid 的 1fr
    //   column-gutter: 0pt — 列间距为 0
    // align(right)[...] — 右对齐内容（字段名）
    // align(center)[...] — 居中对齐内容（字段值）
    // #underline(stroke: 0.5pt, offset: 6pt)[内容] — 下划线
    //   stroke: 0.5pt — 线宽
    //   offset: 6pt — 下划线距文字的偏移量
    // #h(2em) — 水平空白，在值前后添加，使下划线更宽
    grid(
      columns: (8em, 1fr),
      column-gutter: 0pt,
      align(right)[#text(font: ("SimSun", "STSong"), size: 14pt)[#label]],
      align(center)[#text(font: ("SimSun", "STSong"), size: 14pt)[
        #underline(stroke: 0.5pt, offset: 6pt)[#h(2em) #value #h(2em)]
      ]],
    )
    v(0.5em)
  }

  // 调用 field 函数生成各个信息行
  #align(center)[
    #field("学 院 名 称", "XXX 学院")
    #field("专 业 名 称", "XXX 专业")
    #field("年 级 班 级", "XXX 2202")
    #field("学 生 姓 名", "XXX")
    #field("指 导 教 师", "XXX 教授")
  ]
  #v(2cm)

  // 日期
  #text(size: 14pt, font: ("SimSun", "STSong"))[2026 年 5 月]
]

// #{} — Typst 的代码块，可写多行代码
//   这里利用代码块生成一个空白页（封面之后的空白页）
//   page[] — 插入一个空白页面
//   set page(numbering: none) — 防止空白页显示页码
#{
  set page(header: none, footer: none, numbering: none)
  page[]
}

// ============================================================
// 中文摘要页
// ============================================================

// #pagebreak() — 强制分页（另起一页）
#pagebreak()

// #context counter(page).update(1)
//   context — 上下文关键字，用于访问动态值
//     类似 Vue 的 computed 或 React 的 useMemo
//     在 Typst 中，页码、计数器等动态值必须在 context 块中使用
//   counter(page).update(1) — 将页码计数器设置为 1
//     这里重置页码，从 I 开始（用罗马数字编摘要页的页码）
#context counter(page).update(1)

// 设置摘要页的页眉页脚
//   numbering: "I" — 页码格式为大写罗马数字
//   header: context { ... } — 页眉内容（context 块可访问动态值）
//     align(center, [摘　要]) — 居中显示"摘要"
//     v(0.5em) — 标题与分隔线之间的间距
//     line(length: 100%, stroke: 0.5pt) — 水平分隔线
//   footer: context { ... } — 页脚内容
//     counter(page).display("I") — 以罗马数字显示当前页码
//     类似 Word 的"第 X 页"域代码
#set page(
  numbering: "I",
  header: context {
    set text(font: ("Times New Roman", "SimSun"), size: 9pt)
    align(center, [摘　要])
    v(0.5em)
    line(length: 100%, stroke: 0.5pt)
  },
  footer: context {
    set text(font: ("Times New Roman", "SimSun"), size: 10pt)
    align(center, counter(page).display("I"))
  },
)

// #heading(numbering: none)[摘　要]
//   使用 heading 但关闭编号（none），仅保留标题样式
//   none 是 Typst 的关键字，表示"无值"
#heading(numbering: none)[摘　要]
#v(0.5em)
// 摘要正文
本文旨在设计一套基于 Typst 排版系统的论文模板，以满足河南理工大学本科毕业论文的格式要求。相比传统的 LaTeX 排版，Typst 具有编译速度快、语法简洁等优势。通过本模板的设计与实现，可以为后续学生提供一套开箱即用的论文写作工具，降低排版门槛，提高论文撰写效率。

#v(0.5em)

// *关键词：* — Typst 的星号标记
//   单星号 *内容* 表示斜体（类似 Markdown）
//   双星号 **内容** 表示粗体
//   但这里 *关键词：* 后面紧跟普通文字，没有闭合，星号只是普通字符
//   实际上 Typst 中 * 只有在成对出现且包围内容时才表示强调
//   这里 *关键词：* 中的星号是因为关键词后没有结束的 *，
//   所以 * 被视为普通字符显示
*关键词：* Typst；论文模板；排版系统；三线表

// ============================================================
// 英文摘要页
// ============================================================
#pagebreak()

// 重置页码（继续用罗马数字）
// 上一页是 I，这里更新为 2，保证页码连续性
#context counter(page).update(2)

// 页眉页脚设置与中文摘要类似，标题改为 ABSTRACT
#set page(
  numbering: "I",
  header: context {
    set text(font: ("Times New Roman", "SimSun"), size: 9pt)
    align(center, [ABSTRACT])
    v(0.5em)
    line(length: 100%, stroke: 0.5pt)
  },
  footer: context {
    set text(font: ("Times New Roman", "SimSun"), size: 10pt)
    align(center, counter(page).display("I"))
  },
)
#heading(numbering: none)[Abstract]
#v(0.5em)
This paper aims to design a thesis template based on the Typst typesetting system to meet the format requirements of undergraduate graduation theses at Henan Polytechnic University. Compared with traditional LaTeX typesetting, Typst has advantages such as fast compilation speed and concise syntax. Through the design and implementation of this template, it can provide students with an out-of-the-box thesis writing tool, reducing the typesetting barrier and improving the efficiency of thesis writing.

#v(2em)
*Keywords:* Typst; thesis template; typesetting system; three-line table

// ============================================================
// 目录页
// ============================================================
#pagebreak()

// 目录页无页眉页脚、无页码
#set page(
  numbering: none,
  header: none,
  footer: none,
)

// 临时屏蔽标题在目录中的显示
// #show heading.where(numbering: none): set heading(outlined: false)
//   匹配所有 numbering 为 none 的标题
//   outlined: false — 不在目录（outline）中显示
//   这样"目录"这个标题本身不会出现在目录列表中
#show heading.where(numbering: none): set heading(outlined: false)
#heading(numbering: none)[目　录]

// #outline(title: none, indent: 1.5em, depth: 3)
//   自动生成目录
//   title: none — 不显示"目录"标题（因为上面手写了）
//   indent: 1.5em — 每一级标题缩进 1.5em
//   depth: 3 — 目录深度，显示到三级标题
#outline(title: none, indent: 1.5em, depth: 3)

// 目录后的空白页（与封面后的空白页同理）
#{
  set page(header: none, footer: none, numbering: none)
  page[]
}

// ============================================================
// 正文页设置
// ============================================================
#pagebreak()

// 重置页码为 1（正文使用阿拉伯数字）
#context counter(page).update(1)

// 正文页眉页脚设置
// numbering: "1" — 页码格式为纯阿拉伯数字
// header 中的 context 块包含复杂的逻辑：
//   1. 查找当前页所属的一级标题（章标题）
//   2. 判断当前页是奇数页还是偶数页
//   3. 奇偶页显示不同的页眉内容
#set page(
  numbering: "1",
  header: context {
    // ---- 查找当前页所属的章标题 ----

    // here() — 当前上下文的位置
    // here().position().page — 当前页的绝对页码（从 1 开始计数，不计编号格式）
    let abs-page = here().position().page

    // query(heading) — 查询文档中所有的 heading 元素
    //   返回一个数组，包含所有标题的详细信息
    //   类似 document.querySelectorAll('heading')
    let h1s = query(heading)

    // 遍历所有标题，找到：
    //   1. level == 1（一级标题，即章标题）
    //   2. 位置在当前页或之前（.location().position().page <= abs-page）
    //   满足条件的最后一个标题就是当前页所属的章
    let title = none
    for h in h1s {
      if h.level == 1 and h.location().position().page <= abs-page {
        title = h.body
      }
    }
    if title == none { title = [无标题] }

    // ---- 判断奇偶页 ----
    // counter(page).get() — 获取当前页码（考虑编号格式）
    // .first() — 第一个值（页码的值）
    // calc.odd() — 判断奇偶性
    let display-page = counter(page).get().first()

    // 设置页眉字体
    set text(font: ("Times New Roman", "SimSun"), size: 9pt)

    // 奇偶页判断：
    // 奇数页 → 显示当前章标题（居中对齐）
    // 偶数页 → 显示学校名称（居中对齐）
    // 这是学术论文的常见格式
    if calc.odd(display-page) {
      align(center, title)
    } else {
      align(center, [河南理工大学本科毕业设计（论文）])
    }
    v(0.5em)
    // 页眉下方的分隔线
    line(length: 100%, stroke: 0.5pt)
  },
  footer: context {
    set text(font: ("Times New Roman", "SimSun"), size: 10pt)
    // 页脚居中显示阿拉伯数字页码
    // display("1") — 格式化为纯数字
    align(center, counter(page).display("1"))
  },
)

// ============================================================
// 正文内容开始
// ============================================================

// = 一级标题（一章）
//   单个 = 表示一级标题，== 表示二级标题，=== 表示三级标题
//   类似 Markdown 的 # heading 语法
//   但 Typst 的 = 必须在行首，且后面要有空格

= 绪论

== 研究背景

随着信息技术的飞速发展，学术论文的排版工具也在不断演进。传统的排版方式主要依赖于 Microsoft Word 等所见即所得的编辑器，这类工具虽然操作直观，但在处理复杂格式、交叉引用、数学公式等方面存在诸多不便。LaTeX 的出现极大地改善了学术排版的质量，但其陡峭的学习曲线和繁琐的语法也让许多学生望而却步。

近年来，Typst 作为一种新兴的排版系统逐渐受到关注。Typst 由 Typst GmbH 于 2023 年正式发布，其设计目标是结合 LaTeX 的排版质量与 Markdown 的易用性。相比 LaTeX，Typst 具有以下显著优势：

// + 表示无序列表项（类似 Markdown 的 - ）
//   - 也表示无序列表
//   列表可以嵌套（下一行缩进即可）
//   列表中可以使用 *强调* 等行内标记
+ *编译速度快*：Typst 采用增量编译技术，编译速度比 LaTeX 快数十倍，能够实现实时预览；
+ *语法简洁*：Typst 采用类 Markdown 的轻量级语法，学习成本低，上手快；
+ *模块化设计*：Typst 支持包管理和模块导入，便于模板复用和代码组织；
+ *错误提示友好*：Typst 提供清晰的错误信息和位置提示，降低了调试难度。

在此背景下，本文旨在设计一套基于 Typst 排版系统的河南理工大学本科毕业论文模板，以满足学校的格式要求，同时为学生提供更好的排版体验。

== 研究意义

本研究具有以下几方面的意义：

首先，从实用角度而言，一套规范的论文模板能够帮助学生将更多精力集中在论文内容本身，而非格式调整上。据统计，使用 LaTeX 排版论文时，学生平均需要花费 20%--30% 的时间在格式调试上。通过提供开箱即用的 Typst 模板，可以显著提高论文撰写效率。

其次，从教学角度而言，Typst 的简洁语法降低了排版工具的学习门槛，使得非计算机专业的学生也能快速掌握。这对于推广学术写作规范化具有积极意义。

最后，从技术角度而言，本模板的设计与实现过程可以为 Typst 在学术排版领域的应用提供参考案例，促进 Typst 生态的发展。

== 研究内容与论文结构

本文主要包括以下几个方面的内容：

+ 设计论文模板的整体结构，包括封面、摘要、目录、正文、参考文献等部分；
+ 实现页眉页脚的自动设置，奇数页显示章标题，偶数页显示学校名称；
+ 实现三线表、数学公式、图表等常用排版元素的样式定义；
+ 提供模板的使用说明和示例，帮助用户快速上手。

本文的组织结构如下：第 1 章为绪论，介绍研究背景和意义；第 2 章介绍相关技术，包括 Typst 排版系统和三线表规范；第 3 章为系统设计，阐述模板的架构和各模块的设计思路；第 4 章为实验与结果，展示模板的排版效果；第 5 章为结论，总结全文并展望未来工作。

#pagebreak()

= 相关技术

== Typst 排版系统

=== Typst 概述

Typst 是一种现代化的排版系统，由 Martin Haug 和 Laurenz Mädje 于 2019 年开始开发，2023 年正式发布 1.0 版本。Typst 的设计哲学是"简单而强大"——既保留了专业排版系统的能力，又提供了友好的用户界面。

Typst 的核心特性包括：

+ *响应式布局*：Typst 采用基于约束的布局引擎，能够自动处理页面元素的位置和大小；
+ *数学公式支持*：Typst 内置了强大的数学公式排版功能，语法比 LaTeX 更加直观；
+ *脚本语言*：Typst 提供了内置的脚本语言，支持变量、函数、条件判断等编程特性；
+ *包管理*：Typst 拥有官方的包管理器，用户可以方便地安装和使用第三方包。

=== Typst 与 LaTeX 的对比

为了更直观地展示 Typst 的优势，下面从多个维度对两者进行对比，如 @tbl:compare 所示：

// ---- 三线表示例 ----
// #figure(...) <标签> — 带标签的图表
//   figure 是图表容器
//   <tbl:compare> — 标签，用于交叉引用 @tbl:compare
//   supplement: "表" — 前缀文字（caption 中的"表"字）
//   caption: [...] — 图表标题
//
// three-line-table(...) — 自定义的三线表函数
//   columns: (auto, auto, auto) — 三列，auto 表示自动宽度
//   header: (...) — 表头行
//   continued-label: "表 2-1 ..." — 跨页时续表显示的文字
//   后面的行是数据行（每行一个方括号内容块）
#figure(
  align(center,
    three-line-table(
      columns: (auto, auto, auto),
      header: ([对比项], [LaTeX], [Typst]),
      continued-label: "表 2-1 Typst 与 LaTeX 功能对比",
      caption: [Typst 与 LaTeX 功能对比],
      [编译速度], [较慢（需多次编译）], [极快（增量编译）],
      [学习曲线], [陡峭], [平缓],
      [语法复杂度], [较高], [较低],
      [数学公式], [强大但语法繁琐], [强大且语法简洁],
      [包管理], [CTAN 生态成熟], [官方包管理器，生态发展中],
      [实时预览], [需要插件支持], [内置支持],
      [错误提示], [不够友好], [清晰直观],
    )
  ),
  supplement: "表",
  caption: [Typst 与 LaTeX 功能对比],
) <tbl:compare>

从上表可以看出，Typst 在编译速度、学习曲线、语法简洁性等方面具有明显优势，而在包生态方面仍在不断完善中。

== 三线表规范

三线表是学术论文中最常用的表格形式，由顶线、栏目线和底线三条横线组成。其设计原则是"简洁、清晰、规范"，具体要求如下：

+ *顶线*：表格最上方的横线，通常使用较粗的线条（0.75pt）；
+ *栏目线*：表头与数据之间的分隔线，使用细线（0.5pt）；
+ *底线*：表格最下方的横线，与顶线等粗（0.75pt）；
+ *无竖线*：三线表不使用竖线，各列之间通过空格分隔；
+ *表头*：第一行为表头，通常使用加粗字体。

三线表的设计摒弃了传统表格中繁琐的网格线，使数据呈现更加清晰明了，是学术写作中的标准表格格式。

== 数学公式

// Typst 数学公式语法：
//   行内公式：$ a^2 + b^2 = c^2 $ — 放在段落文字中
//   行间公式：$ ... $ 单独成行
//     注意 Typst 的行间公式也用 $ $ 包围（LaTeX 用 \[ \]）
//     区别在于：行内公式 $...$ 嵌在文字中
//               行间公式单独占一行，自动居中
//   上标：^（如 a^2）
//   下标：_（如 x_1）
//   分数：/（如 a/b）或用 frac 函数
//   希腊字母：拼写（alpha, beta, pi, sigma...）
//   特殊函数：sqrt(), integral(), sum() 等
//   加粗：bold(...)
//   矩阵：mat(...)
//   分段函数：cases(...)
//   多行公式对齐：用 \ 换行，& 标记对齐点
//   标签：公式末尾加 <公式名> 用于交叉引用
//   不编号：公式末尾加 <->

Typst 支持行内公式和行间公式。例如，勾股定理可以表示为 $a^2 + b^2 = c^2$。著名的欧拉公式为：

$ e^(i pi) + 1 = 0 $     // 行间公式，自动居中对齐

高斯积分的计算公式为：

$ integral_(-infinity)^(+infinity) e^(-x^2) d x = sqrt(pi) $

这些公式展示了 Typst 在数学排版方面的能力，其语法比 LaTeX 更加简洁直观。

此外，Typst 还支持线性代数中的常见表示。例如，向量 $bold(x) = (x_1, x_2, ..., x_n)^T$ 的 L2 范数定义为：

$ ||bold(x)||_2 = sqrt(sum_(i=1)^n x_i^2) $

在机器学习领域，交叉熵损失函数的定义如下：

$ L = - sum_(i=1)^C y_i log(hat(y)_i) $

其中 $C$ 为类别数，$y_i$ 为真实标签，$hat(y)_i$ 为模型预测值。

#pagebreak()

= 系统设计

== 模板整体架构

本模板采用模块化设计思想，将论文的各个组成部分封装为独立的模块，便于维护和扩展。模板的整体架构如下：

+ *主文件*（main.typ）：论文的入口文件，负责组织各模块的内容和设置全局样式；
+ *页面设置模块*（page.typ）：定义页面尺寸、页边距等基本参数；
+ *页眉页脚模块*（pageheaderfooter.typ）：实现页眉页脚的样式和内容逻辑；
+ *三线表模块*（three-line-table.typ）：提供三线表的排版功能。

这种模块化的设计使得模板的各个部分可以独立修改和测试，降低了耦合度。模板的模块依赖关系如 @fig:architecture 所示。

// 插入图片（带编号和标签）
#figure(
  align(center, image("images/architecture.png", width: 70%)),
  supplement: "图",
  caption: [模板模块依赖关系图],
) <fig:architecture>

== 页面设置

=== 页面尺寸与页边距

根据河南理工大学本科毕业论文的格式要求，页面设置如 @tbl:page-settings 所示：

#figure(
  align(center,
    three-line-table(
      columns: (auto, auto, auto),
      header: ([参数], [要求值], [模板设置]),
      continued-label: "表 3-1 页面参数设置",
      caption: [页面参数设置],
      [纸张大小], [A4], [A4],
      [上边距], [2.54cm], [2.54cm],
      [下边距], [2.54cm], [2.54cm],
      [左边距], [3.17cm], [3.17cm],
      [右边距], [3.17cm], [3.17cm],
      [正文字体], [宋体小四号], [SimSun 12pt],
      [行距], [1.5倍], [leading: 1.5em],
    )
  ),
  supplement: "表",
  caption: [页面参数设置],
) <tbl:page-settings>

=== 页面布局示意

页面的整体布局如 @fig:layout 所示。页眉位于页面顶部，包含标题文字和分隔线；页脚位于页面底部，居中显示页码；正文区域位于页边距围成的矩形内。

#figure(
  align(center, image("images/layout.png", width: 55%)),
  supplement: "图",
  caption: [页面布局示意图],
) <fig:layout>

=== 页眉页脚设计

页眉页脚的设计遵循以下规则：

+ 封面页：无页眉页脚，无页码；
+ 前置页（摘要、目录等）：页眉显示对应标题，页脚显示罗马数字页码；
+ 正文页：奇数页页眉显示当前章一级标题，偶数页页眉显示"河南理工大学本科毕业设计（论文）"，页脚显示阿拉伯数字页码。

== 标题样式设计

论文的标题分为三级，各级标题的样式设置如 @tbl:heading-style 所示：

#figure(
  align(center,
    three-line-table(
      columns: (auto, auto, auto, auto),
      header: ([级别], [字体], [字号], [对齐方式]),
      continued-label: "表 3-2 标题样式设置",
      caption: [标题样式设置],
      [一级标题], [黑体], [15pt], [居中],
      [二级标题], [宋体加粗], [14pt], [左对齐],
      [三级标题], [宋体], [12pt], [左对齐],
    )
  ),
  supplement: "表",
  caption: [标题样式设置],
) <tbl:heading-style>

一级标题采用黑体居中显示，段前段后间距为 2 倍行距；二级标题采用宋体加粗，段前段后间距为 1.5 倍行距；三级标题采用宋体，段前段后间距为 1.3 倍行距。

== 三线表实现

三线表的实现采用了 Typst 的表格 API，通过自定义函数封装了三线表的样式。核心实现思路如下：

+ 使用 `table` 函数创建基本表格结构；
+ 通过 `line` 函数绘制顶线、栏目线和底线；
+ 设置表头字体为加粗，数据行字体为常规；
+ 通过参数化设计支持不同列数和内容的表格。

#pagebreak()

= 实验与结果

== 实验环境

本文的实验环境配置如 @tbl:env 所示：

#figure(
  align(center,
    three-line-table(
      columns: (auto, auto),
      header: ([项目], [配置]),
      continued-label: "表 4-1 实验环境配置",
      caption: [实验环境配置],
      [操作系统], [Windows 11 Pro],
      [Typst 版本], [v0.13.0],
      [编辑器], [VS Code + Tinymist 插件],
      [处理器], [Intel Core i7-12700H],
      [内存], [16GB DDR5],
    )
  ),
  supplement: "表",
  caption: [实验环境配置],
) <tbl:env>

== 编译速度对比

为了验证 Typst 的编译速度优势，本文对同一份论文分别使用 Typst 和 LaTeX 进行编译，记录编译时间。实验结果如 @fig:speed 所示。

#figure(
  align(center, image("images/speed.png", width: 80%)),
  supplement: "图",
  caption: [Typst 与 LaTeX 编译速度对比],
) <fig:speed>

从 @fig:speed 可以看出，Typst 的首次编译时间仅为 1.8s，是 LaTeX 的 6.3%；增量编译时间仅为 0.3s，是 LaTeX 的 2.4%。Typst 的增量编译技术使得实时预览成为可能，极大地提升了写作体验。

== 模板功能测试

=== 三线表测试

下面使用三线表展示不同方法在数据集上的实验结果，如 @tbl:result 所示：

#figure(
  align(center,
    three-line-table(
      columns: (auto, auto, auto, auto),
      header: (
        [编号], [方法], [准确率], [耗时],
      ),
      continued-label: "表 4-2 各方法实验结果对比",
      caption: [各方法实验结果对比],
      [1], [方法 A], [92.3%], [1.2s],
      [2], [方法 B], [94.7%], [2.5s],
      [3], [方法 C], [95.1%], [3.8s],
      [4], [本文方法], [*97.6%*], [1.5s],
    )
  ),
  supplement: "表",
  caption: [各方法实验结果对比],
) <tbl:result>

下面展示一个行数较多的长表格，用于验证跨页显示和续表标签功能，如 @tbl:long-data 所示：

#figure(
  align(center,
    three-line-table(
      columns: (auto, auto, auto, auto, auto),
      header: ([编号], [学习率], [批次大小], [准确率], [耗时 (s)]),
      continued-label: "表 4-3 不同参数下的实验数据",
      caption: [不同参数下的实验数据],
      [1],  [0.001], [32],  [91.2%], [2.1],
      [2],  [0.001], [64],  [91.8%], [1.9],
      [3],  [0.001], [128], [92.1%], [1.7],
      [4],  [0.005], [32],  [93.5%], [2.3],
      [5],  [0.005], [64],  [94.2%], [2.0],
      [6],  [0.005], [128], [94.8%], [1.8],
      [7],  [0.01],  [32],  [95.1%], [2.5],
      [8],  [0.01],  [64],  [95.7%], [2.2],
      [9],  [0.01],  [128], [96.3%], [2.0],
      [10], [0.02],  [32],  [94.8%], [2.8],
      [11], [0.02],  [64],  [95.3%], [2.5],
      [12], [0.02],  [128], [96.0%], [2.3],
      [13], [0.05],  [32],  [93.2%], [3.1],
      [14], [0.05],  [64],  [94.0%], [2.8],
      [15], [0.05],  [128], [94.5%], [2.5],
      [16], [0.1],   [32],  [91.5%], [3.5],
      [17], [0.1],   [64],  [92.3%], [3.2],
      [18], [0.1],   [128], [93.1%], [2.9],
      [19], [0.002], [64],  [92.5%], [2.0],
      [20], [0.008], [64],  [95.0%], [2.1],
    )
  ),
  supplement: "表",
  caption: [不同参数下的实验数据],
) <tbl:long-data>

从表中可以看出，学习率为 0.01、批次大小为 128 时准确率最高（96.3%），同时耗时也在可接受范围内。

从表中可以看出，本文方法在准确率上取得了最优表现（97.6%），同时耗时仅为 1.5s，优于方法 B 和方法 C。

为了验证模板在跨页长表格场景下的排版效果，下面展示一个包含 50 行数据的跨页表格，如 @tbl:cross-page 所示：

#figure(
  align(center,
    three-line-table(
      columns: (auto, auto, auto, auto, auto, auto),
      header: ([序号], [姓名], [学号], [课程名称], [成绩], [学分]),
      continued-label: "表 4-4 跨页表格功能演示",
      caption: [跨页表格功能演示],
      [1],  [张明], [20230101001], [高等数学 A(一)], [92], [5],
      [2],  [张明], [20230101001], [线性代数], [88], [3],
      [3],  [张明], [20230101001], [大学物理 B(一)], [85], [4],
      [4],  [张明], [20230101001], [C 语言程序设计], [90], [3],
      [5],  [张明], [20230101001], [大学英语(一)], [87], [4],
      [6],  [张明], [20230101001], [思想道德与法治], [91], [2],
      [7],  [张明], [20230101001], [体育(一)], [95], [1],
      [8],  [张明], [20230101001], [军事理论], [93], [1],
      [9],  [李红], [20230101002], [高等数学 A(一)], [88], [5],
      [10], [李红], [20230101002], [线性代数], [85], [3],
      [11], [李红], [20230101002], [大学物理 B(一)], [82], [4],
      [12], [李红], [20230101002], [C 语言程序设计], [93], [3],
      [13], [李红], [20230101002], [大学英语(一)], [89], [4],
      [14], [李红], [20230101002], [思想道德与法治], [86], [2],
      [15], [李红], [20230101002], [体育(一)], [90], [1],
      [16], [李红], [20230101002], [军事理论], [88], [1],
      [17], [王磊], [20230101003], [高等数学 A(一)], [78], [5],
      [18], [王磊], [20230101003], [线性代数], [82], [3],
      [19], [王磊], [20230101003], [大学物理 B(一)], [75], [4],
      [20], [王磊], [20230101003], [C 语言程序设计], [80], [3],
      [21], [王磊], [20230101003], [大学英语(一)], [76], [4],
      [22], [王磊], [20230101003], [思想道德与法治], [83], [2],
      [23], [王磊], [20230101003], [体育(一)], [88], [1],
      [24], [王磊], [20230101003], [军事理论], [85], [1],
      [25], [赵雪], [20230101004], [高等数学 A(一)], [95], [5],
      [26], [赵雪], [20230101004], [线性代数], [91], [3],
      [27], [赵雪], [20230101004], [大学物理 B(一)], [93], [4],
      [28], [赵雪], [20230101004], [C 语言程序设计], [96], [3],
      [29], [赵雪], [20230101004], [大学英语(一)], [92], [4],
      [30], [赵雪], [20230101004], [思想道德与法治], [89], [2],
      [31], [赵雪], [20230101004], [体育(一)], [93], [1],
      [32], [赵雪], [20230101004], [军事理论], [91], [1],
      [33], [孙鹏], [20230101005], [高等数学 A(一)], [70], [5],
      [34], [孙鹏], [20230101005], [线性代数], [73], [3],
      [35], [孙鹏], [20230101005], [大学物理 B(一)], [68], [4],
      [36], [孙鹏], [20230101005], [C 语言程序设计], [75], [3],
      [37], [孙鹏], [20230101005], [大学英语(一)], [71], [4],
      [38], [孙鹏], [20230101005], [思想道德与法治], [78], [2],
      [39], [孙鹏], [20230101005], [体育(一)], [82], [1],
      [40], [孙鹏], [20230101005], [军事理论], [80], [1],
      [41], [刘洋], [20230101006], [高等数学 A(二)], [86], [5],
      [42], [刘洋], [20230101006], [概率论与数理统计], [83], [3],
      [43], [刘洋], [20230101006], [大学物理 B(二)], [81], [4],
      [44], [刘洋], [20230101006], [数据结构], [89], [3],
      [45], [刘洋], [20230101006], [大学英语(二)], [84], [4],
      [46], [刘洋], [20230101006], [马克思主义原理], [88], [2],
      [47], [刘洋], [20230101006], [体育(二)], [91], [1],
      [48], [刘洋], [20230101006], [形势与政策], [86], [1],
      [49], [刘洋], [20230101006], [离散数学], [82], [3],
      [50], [刘洋], [20230101006], [电子电路基础], [79], [3],
    )
  ),
  supplement: "表",
  caption: [跨页表格功能演示],
) <tbl:cross-page>

各方法的准确率对比如 @fig:accuracy 所示。

#figure(
  align(center, image("images/accuracy.png", width: 65%)),
  supplement: "图",
  caption: [各方法准确率对比],
) <fig:accuracy>

=== 公式排版测试

// 带标签的公式（可交叉引用 @eqt:quadratic）
二次方程 $a x^2 + b x + c = 0$ 的求根公式如 @eqt:quadratic 所示：

// <quadratic> — 公式标签，末尾的尖括号标记
//   公式默认会编号（格式为 (1-1)、(1-2) 等）
//   带标签的公式会显示编号，引用时显示编号
$ x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a) $ <quadratic>

// 不带编号的公式，末尾加 <->（不编号标记）
//   <-> 告诉 Typst 这个公式不编号，也不计入计数器
矩阵的表示如下（不编号）：

$ A = mat(delim: "[", 1, 2, 3; 4, 5, 6; 7, 8, 9) $ <->

分段函数的排版效果（不编号）：

$ f(x) = cases(
  x^2 + 1 & "if" x > 0,
  0 & "if" x = 0,
  -x^2 - 1 & "if" x < 0,
) $ <->

// 多行公式对齐（& 标记对齐点，\ 换行）
//   类似 LaTeX 的 align 环境
//   这里麦克斯韦方程组的等号对齐
多行公式对齐，麦克斯韦方程组如 @eqt:maxwell 所示：

$
  nabla times bold(E) &= - (partial bold(B)) / (partial t) \
  nabla times bold(H) &= bold(J) + (partial bold(D)) / (partial t) \
  nabla dot bold(D) &= rho \
  nabla dot bold(B) &= 0
$ <maxwell>

上述公式为麦克斯韦方程组的微分形式（@eqt:maxwell），其中 $bold(E)$ 为电场强度，$bold(H)$ 为磁场强度，$bold(D)$ 为电位移矢量，$bold(B)$ 为磁感应强度，$bold(J)$ 为电流密度，$rho$ 为电荷密度。

=== 列表排版测试

// 有序列表：+ 表示第一级，缩进的 + 表示子级
//   Typst 的有序列表会自动编号（1. 2. 3. ...）
//   可以嵌套（缩进表示层级）
有序列表示例：

+ 第一项内容
+ 第二项内容
  + 二级子项 A
  + 二级子项 B
+ 第三项内容

// 无序列表：- 开头
无序列表示例：

- 要点一
- 要点二
- 要点三

== 结果分析

通过上述测试可以看出，本模板能够正确实现以下功能：

+ 三线表的规范排版，线条粗细和间距符合学术论文要求；
+ 数学公式的正确显示，包括行内公式和行间公式；
+ 有序列表和无序列表的自动编号和缩进；
+ 页眉页脚的自动设置，奇偶页显示不同内容。

实验结果表明，Typst 在学术排版方面的能力已经能够满足本科毕业论文的基本需求。

#pagebreak()

= 结论

== 工作总结

本文设计并实现了一套基于 Typst 排版系统的河南理工大学本科毕业论文模板。主要完成了以下工作：

+ 设计了符合学校格式要求的页面布局，包括页边距、字体、行距等参数的配置；
+ 实现了页眉页脚的自动设置功能，支持奇偶页显示不同内容，前置页使用罗马数字页码，正文使用阿拉伯数字页码；
+ 封装了三线表、数学公式等常用排版元素，提供了简洁的调用接口；
+ 提供了完整的使用说明和示例，降低了学生的使用门槛。

实验表明，该模板能够满足论文排版的基本需求，具有良好的可用性和扩展性。

== 不足与展望

尽管本模板已经实现了基本功能，但仍存在一些不足之处：

+ 参考文献管理功能尚未完善，后续可以集成 BibTeX 或 CSL 格式的文献管理；
+ 目前仅支持单一学院的格式要求，未来可以扩展为多学院适配版本；
+ 模板的错误处理机制有待加强，需要提供更友好的错误提示。

后续工作将重点围绕以上问题展开，不断完善模板的功能和用户体验。同时，随着 Typst 生态的成熟，更多的第三方包将为模板的功能扩展提供支持。
