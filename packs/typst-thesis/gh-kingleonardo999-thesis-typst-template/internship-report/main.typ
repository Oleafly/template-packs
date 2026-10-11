#import "utils.typ" : *

// 全局设置
#set page(
  paper: "a4",
  margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
)

#set text(
  font: (font-en, font-cn),
  size: 12pt,
  lang: "zh",
  top-edge: "ascender",
  bottom-edge: "descender"
)

#set par(
  justify: true,
  leading: 8pt,
  spacing: 8pt,
  first-line-indent: (amount: 2em, all: true),
)

// 列表模板
// 有序列表
#set enum(
  numbering: "（1）",
  indent: 0em,
  body-indent: 0.5em,
)

// 无序列表
#set list(
  indent: 0em,
  body-indent: 0.5em,
)

// 章标题（level 1）：黑体小三 (≈15pt)，居中，"第X章"，段前24pt，段后18pt，每章另起一页
// 致谢、参考文献等后记标题不加章节编号
// 节标题（level 2）：黑体四号 (≈14pt)，顶格，段前18pt，段后6pt
// 子节标题（level 3）：黑体四号 (≈14pt)，段前12pt，段后6pt
// level 4+：黑体小四 (≈12pt)，段前12pt，段后6pt
#show heading: it => {
  set par(first-line-indent: 0em)
  if it.level == 1 {
    pagebreak(weak: true)
    // 每章重置图表代码计数器
    fig-num.update(0)
    tbl-num.update(0)
    code-num.update(0)
    let is-back-matter = (it.body == [致 谢] or it.body == [参考文献])
    let title = if is-back-matter {
      it.body
    } else {
      [第#counter(heading).display("一")章 #it.body]
    }
    align(center, [
      #text(font: font-title, size: 15pt, weight: "regular")[#title]
    ])
    v(18pt)
  } else if it.level == 2 {
    block(
      sticky: true,
      text(font: font-title, size: 14pt, weight: "regular")[
        #counter(heading).display() #it.body
      ],
    )
    v(6pt)
  } else if it.level == 3 {
    block(
      sticky: true,
      text(font: font-title, size: 14pt, weight: "regular")[
        #counter(heading).display() #it.body
      ],
    )
    v(6pt)
  } else if it.level == 4 {
    block(
      sticky: true,
      text(font: font-cn, size: 12pt, weight: "regular")[
        #counter(heading).display() #it.body
      ],
    )
    v(6pt)
  }
}

// 标题编号格式：目录中 level 1 为"第一章"，level 2/3 为"1.1 / 1.1.1"
#set heading(numbering: (..numbers) => {
  let nums = numbers.pos()
  if nums.len() == 1 {
    [第#numbering("一", ..nums)章]
  } else {
    numbering("1.1.1", ..nums)
  }
})

// 中文粗体修复：仅为粗体中的汉字添加描边，英文使用字体自身的正常粗体
#show strong: it => text(weight: "bold", it.body)
#show text.where(weight: "bold"): it => {
  show regex("\p{Han}+"): set text(stroke: 0.3pt + black)
  it
}


#set page(
  header: report-header,
  header-ascent: 10mm,
  footer: report-footer,
  footer-descent: 10mm,
)
// 封面
#include "cover.typ"

// 摘要（中+英）
#set page(header: report-header, footer: report-footer, numbering: "I")
#include "abstract.typ"
// 目录
// --- 目录 ---
#header-state.update("目 录")
#pagebreak()
#align(center, [
  #text(font: (font-en, font-title), size: 15pt, weight: "bold")[目 录]
])
#v(10pt)
#outline(target: heading, indent: 2em, title: none)
// 正文
#include "content.typ"
// 致谢
#set page(header: report-header, footer: report-footer, numbering: "1")
#include "acknowledgements.typ"
// 参考文献
#header-state.update("参考文献")
#pagebreak()
#heading(level: 1, numbering: none)[参考文献]
// 参考文献字号：五号 (10.5pt)
#set text(size: 10.5pt)
#gb7714-bibliography(title: none)
