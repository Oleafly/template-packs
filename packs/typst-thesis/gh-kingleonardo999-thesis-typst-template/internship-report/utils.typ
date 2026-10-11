#import "@preview/gb7714-bilingual:0.2.3": init-gb7714, gb7714-bibliography, multicite

// 字体定义
#let font-cn = "SimSun"       // 宋体
#let font-title = "SimHei"    // 黑体
#let font-en = "Times New Roman" // 英文/数字
#let font-code = "Consolas" // 代码
#let resume(start, body) = {
  enum(start: start, body)
}

// 颜色定义
#let black = rgb("#000000")

// 文档全局标题（用于偶数页页眉）
#let doc-title = "企业实习总结报告"

// 页眉状态追踪：none 表示正文模式（奇数页=章标题，偶数页=文档标题），字符串表示直接使用该标题
#let header-state = state("header-state", none)

// 图表代码按章编号计数器
#let fig-num = counter("fig-num")
#let tbl-num = counter("tbl-num")
#let code-num = counter("code-num")

// 封面图片
#let cover-image(path, width: 80%) = {
  v(20pt)
  block(
    align(center, [
      #image(path, width: width)
    ]),
  )
}

#let report-header = context {
  let page-num = counter(page).get().first()
  let physical-page = here().page()
  let is-odd = calc.rem(page-num, 2) == 1
  let current = header-state.get()

  let header-text = if not is-odd {
    // 偶数页页眉固定为文档标题
    doc-title
  } else if current != none {
    current
  } else {
    let chapters = query(heading.where(level: 1)).filter(
      ch => ch.location().page() <= physical-page,
    )
    if chapters.len() > 0 {
      let ch = chapters.last()
      let ch-num = counter(heading).at(ch.location()).first()
      [第#numbering("一", ch-num)章 #ch.body]
    } else {
      doc-title
    }
  }

  block(
    width: 100%,
    [
      #text(font: (font-en, font-cn), size: 10.5pt, align(center, header-text))
      #v(-8pt)
      #line(length: 100%, stroke: 1pt + black)
    ],
  )
}

#let report-footer = context {
  text(font: font-en, size: 9pt, align(center, counter(page).display()))
}


// 图：图题在下，图片与图题不分离
#let fig(cap, body) = context {
  let ch = counter(heading).get().at(0, default: 0)
  fig-num.step()
  // 同一 context 内 get() 读到 step 前的值，故 +1 得到本次编号
  let n = fig-num.get().first() + 1

  block(width: 100%, above: 6pt, below: 12pt, align(center, [
    // 图片与图题粘在一起，防止图题独留一页
    #block(sticky: true, above: 6pt, below: 12pt, body)
    #text(font: (font-en, font-cn), size: 10.5pt)[图#{ ch }-#{ n } #cap]
  ]))
}

// 表：表题在上，表题与表体不分离
#let tbl(cap, body) = context {
  let ch = counter(heading).get().at(0, default: 0)
  tbl-num.step()
  // 同一 context 内 get() 读到 step 前的值，故 +1 得到本次编号
  let n = tbl-num.get().first() + 1

  block(width: 100%, above: 12pt, below: 6pt, align(center, [
    // 表题与表体粘在一起，保证至少一行表体与标题同页
    #block(sticky: true, above: 12pt, below: 6pt, text(font: (font-en, font-cn), size: 10.5pt)[表#{ ch }-#{ n } #cap])
    #body
  ]))
}

// 代码块：标题居中在上，代码左对齐，标题与代码不分离，黑色实线边框包裹
#let codefig(cap, body) = context {
  let ch = counter(heading).get().at(0, default: 0)
  code-num.step()
  // 同一 context 内 get() 读到 step 前的值，故 +1 得到本次编号
  let n = code-num.get().first() + 1

  block(width: 100%, above: 12pt, below: 6pt, [
    // 代码标题与代码粘在一起，保证至少一行代码与标题同页
    #block(sticky: true, width: 100%, above: 12pt, below: 6pt, align(center, text(font: (font-en, font-cn), size: 10.5pt)[代码#{ ch }-#{ n } #cap]))
    #rect(
      stroke: 1pt + black,
      width: 100%,
      inset: 10pt,
      [
        // 仅在 codefig 内生效：英文 Consolas 五号，中文宋体五号，单倍行距
        #show raw: set text(font: (font-code, font-cn), size: 10.5pt)
        #show raw: set par(leading: 0.2em)
        #align(left, body)
      ],
    )
  ])
}

// 公式：居中，右侧编号（编号格式为 (1), (2)...），段前段后 6pt
#set math.equation(numbering: "(1)")
#show math.equation: it => {
  if it.block {
    block(above: 6pt, below: 6pt, align(center, it))
  } else {
    it
  }
}
