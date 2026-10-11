// template.typ — 核心模板函数
// 封装所有格式设置，用户只需 #show: thesis-proposal.with(...) 即可应用

// ===== 字号常量（中国标准字号 → pt 映射） =====
#let font-size = (
  chu:      42pt,    // 初号
  xiao-chu: 36pt,    // 小初
  yi:       26pt,    // 一号
  xiao-yi:  24pt,    // 小一
  er:       22pt,    // 二号
  xiao-er:  18pt,    // 小二
  san:      16pt,    // 三号
  xiao-san: 15pt,    // 小三
  si:       14pt,    // 四号
  xiao-si:  12pt,    // 小四
  wu:       10.5pt,  // 五号
  xiao-wu:  9pt,     // 小五
  liu:      7.5pt,   // 六号
)

// ===== 字体族定义 =====
// 英文字体 fallback 链 + 中文字体
#let font-family = (
  fangsong: ("Times New Roman", "STFangsong"),  // 正文：仿宋
  heiti:    ("Times New Roman", "STHeiti"),      // 标题：黑体
  kaiti:    ("Times New Roman", "STKaiti"),      // 楷体
  songti:   ("Times New Roman", "STSong"),       // 宋体
)

// ===== 字体切换辅助函数 =====

/// 黑体文本
#let heiti(body) = text(font: font-family.heiti, body)

/// 仿宋文本
#let fangsong(body) = text(font: font-family.fangsong, body)

/// 楷体文本
#let kaiti(body) = text(font: font-family.kaiti, body)

// ===== 带下划线的信息域（封面用） =====

/// 固定宽度下划线框，内容居中
#let underline-field(width: 230pt, body) = {
  box(width: width, stroke: (bottom: 0.5pt), outset: (bottom: 2pt))[
    #align(center, body)
  ]
}

// ===== 主模板函数 =====
#let thesis-proposal(
  // 以下参数与 config.typ 中的变量对应
  student-name: "",
  student-id: "",
  advisor: "",
  advisor-title: "",
  school: "",
  major: "",
  class-name: "",
  thesis-title: "",
  thesis-english: "",
  submit-date: "",
  university: "",
  degree: "",
  body,
) = {
  // ----- 全局页面设置 -----
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
    numbering: "1",
    number-align: center,
  )

  // ----- 全局字体设置 -----
  // 正文：小四号（12pt）仿宋体，英文 Times New Roman
  set text(
    font: font-family.fangsong,
    size: font-size.xiao-si,
    lang: "zh",
    region: "cn",
  )

  // ----- 段落设置 -----
  // 1.5 倍行距：Typst 的 leading 是行间距（baseline 到 baseline 减去字号后的部分）
  // LaTeX \setstretch{1.5} 在 12pt 下 ≈ leading 0.88em
  // all: true 确保标题后的第一个段落也有缩进
  set par(leading: 0.88em, first-line-indent: (amount: 2em, all: true), justify: true)

  // ----- 标题样式 -----
  // 一级标题（section）：三号（16pt）黑体加粗
  // 编号格式：1．（阿拉伯数字 + 全角句号）
  show heading.where(level: 1): it => {
    set text(font: font-family.heiti, size: font-size.san, weight: "bold")
    v(24pt)
    block(
      below: 18pt,
      {
        if it.numbering != none {
          counter(heading).display("1")
          "．"
        }
        it.body
      },
    )
  }

  // 二级标题（subsection）：四号（14pt）黑体加粗
  show heading.where(level: 2): it => {
    set text(font: font-family.heiti, size: font-size.si, weight: "bold")
    v(18pt)
    block(
      below: 12pt,
      {
        if it.numbering != none {
          counter(heading).display("1.1")
          h(1em)
        }
        it.body
      },
    )
  }

  set heading(numbering: "1.1")

  // ----- 图表标题样式 -----
  // 五号（10.5pt），标签与标题间用 quad 分隔
  show figure.caption: it => {
    set text(size: font-size.wu)
    it.supplement
    if it.numbering != none {
      " "
      it.counter.display(it.numbering)
    }
    h(1em)
    it.body
  }

  // ----- 超链接样式 -----
  // 无颜色装饰，与正文一致
  show link: it => text(fill: black, it)

  // ----- 参考文献引用样式 -----
  show ref: it => {
    it
  }

  // ----- 正文内容 -----
  body
}
