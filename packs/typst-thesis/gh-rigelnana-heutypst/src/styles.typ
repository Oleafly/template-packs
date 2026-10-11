#import "utils.typ": font-size, font-family, fixed-leading

// ===== 页面设置 =====
#let page-setup = (
  paper: "a4",
  margin: (top: 28mm, bottom: 28mm, left: 25mm, right: 25mm),
  header-ascent: 20mm - 28mm + 20mm,  // 页眉距顶20mm
  footer-descent: 20mm - 28mm + 20mm, // 页脚距底20mm
)

// ===== 页眉双线（上细下粗） =====
// spec: 上细下粗边框线型，宽度3磅
// 用 place 精确定位，避免任何额外间距
#let header-line() = {
  v(-6pt)
  box(width: 100%, height: 3pt, {
    place(top, line(length: 100%, stroke: 1pt))
    place(bottom, line(length: 100%, stroke: 3pt))
  })
}

// 偶数页页眉内容
#let even-header-content = "哈尔滨工程大学本科生毕业论文"

// ===== 正文段落样式 =====
// 小4号宋体，首行缩进2字符，固定行距22磅
#let body-style(doc) = {
  set text(
    font: font-family.songti,
    size: font-size.xiaosihao,
    lang: "zh",
    region: "cn",
  )
  set par(
    first-line-indent: 2em,
    leading: 22pt - 1em,  // 固定行距22磅
    justify: true,
  )
  doc
}

// ===== 标题样式 =====
// 章标题：小2号黑体，居中，段前后各1行，行距22磅，段前分页
// 节标题：小3号黑体，顶格，段前后各0.5行，行距22磅
// 条标题：4号黑体，顶格，段前后各0.5行，行距22磅
// 款标题：小4号黑体
#let heading-style(doc) = {
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(font: font-family.heiti, size: font-size.xiaoerhao)
    set par(leading: 22pt - 1em, justify: false)
    v(22pt)
    align(center, it)
    v(22pt)
  }
  show heading.where(level: 2): it => {
    set text(font: font-family.heiti, size: font-size.xiaosanhao)
    set par(leading: 22pt - 1em, justify: false)
    v(11pt)
    it
    v(11pt)
  }
  show heading.where(level: 3): it => {
    set text(font: font-family.heiti, size: font-size.sihao)
    set par(leading: 22pt - 1em, justify: false)
    v(11pt)
    it
    v(11pt)
  }
  show heading.where(level: 4): it => {
    set text(font: font-family.heiti, size: font-size.xiaosihao)
    set par(leading: 22pt - 1em, justify: false)
    it
  }
  doc
}

// ===== 图表公式编号 =====
// 图表按章编排：图1.1、表1.1
// 公式按章编排：(1-1)
#let figure-style(doc) = {
  set figure(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    numbering("1.1", chapter, ..nums)
  })
  set figure.caption(separator: [ ])
  show figure.where(kind: table): set figure.caption(position: top)
  doc
}

#let equation-style(doc) = {
  set math.equation(numbering: (..nums) => {
    let chapter = counter(heading).get().first()
    "(" + str(chapter) + "-" + str(nums.pos().first()) + ")"
  })
  doc
}
