// ============================================================
// 复旦大学学位论文 Typst 模板 - 扉页（指导小组成员）
// 根据规范：扉页列出指导小组成员名单
// ============================================================

#import "../config.typ": *

#let committee-page(info, committee-members: ()) = {
  set page(margin: page-margin, header: none, footer: none)

  v(60pt)

  align(center, text(
    font: font-family.黑体,
    size: font-size.小二,
    weight: "bold",
  )[指导小组成员])

  v(80pt)

  if committee-members.len() > 0 {
    set text(font: font-family.宋体, size: font-size.四号)
    set par(first-line-indent: 0em)

    let parsed = committee-members.map(m => {
      let s = m.replace("　", " ").trim()
      let parts = s.split(" ").filter(p => p != "")
      if parts.len() >= 2 {
        (parts.at(0), parts.slice(1).join(" "))
      } else {
        (s, "")
      }
    })

    align(center)[
      #grid(
        columns: (auto, 2em, auto),
        row-gutter: 1.5em,
        ..parsed.map(p => {
          (align(left, p.at(0)), [], align(left, p.at(1)))
        }).flatten()
      )
    ]
  }
}
