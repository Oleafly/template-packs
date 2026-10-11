#import "utils.typ": font_size, font_type

#pagebreak(weak: true)

#show outline: it => {
  show heading: set text(size: font_size.二号)
  it
}

#show outline.entry: it => {
  let is-chapter = it.level == 1
  set text(
    font: if is-chapter { font_type.黑体 } else { font_type.宋体 },
    weight: if is-chapter { "bold" } else { "regular" },
    size: font_size.小四,
  )
  it
}

#outline(
  title: "目录",
  depth: 3,
  indent: depth => calc.max(0, depth - 1) * 1em,
)

#pagebreak(weak: true)
