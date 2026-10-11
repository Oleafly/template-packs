#import "../utils/style.typ": 字体, 字号
#import "../utils/invisible-heading.typ": invisible-heading

// 西北工业大学研究生学术成果页
#let academic-achievements(
  // documentclass 传入参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  // 其他参数
  title: "在学期间取得的学术成果和参加科研情况",
  outlined: true,
  body,
) = {
  if not anonymous {
    pagebreak(weak: true, to: if twoside { "odd" })
    [
      #set text(font: fonts.宋体, size: 字号.小四)
      #set par(leading: 1.5em, justify: true)

      #heading(level: 1, numbering: none, outlined: outlined, title) <no-auto-pagebreak>

      #v(0.5em)

      #body
    ]
    if twoside {
      pagebreak(weak: true, to: "odd")
    }
  }
}
