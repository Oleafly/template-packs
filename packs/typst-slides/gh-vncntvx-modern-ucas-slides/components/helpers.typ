// 文本强调函数
#let red(it) = text(fill: rgb("#e11d48"), it)
#let green(it) = text(fill: rgb("#059669"), it)
#let alert(it) = text(fill: rgb("#d97706"), weight: "bold", it)
#let structure(it) = text(fill: rgb("#64748b"), weight: "medium", it)

// 底部无标号脚注
#let blfootnote(it) = place(
  bottom,
  clearance: 0pt,
  block(width: 100%, {
    line(length: 22%, stroke: 0.5pt + rgb("#cbd5e1"))
    v(0.25em)
    text(size: 0.65em, fill: rgb("#64748b"), it)
  }),
)
