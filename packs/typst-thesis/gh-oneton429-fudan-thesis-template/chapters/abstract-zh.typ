#import "../utils.typ": font_size, font_type

#let keywords = ("Typst", "本科", "毕业论文", "模板", "开源项目")

#pagebreak(weak: true)

#heading("摘要", numbering: none)

这里是中文摘要部分。

#linebreak()

#grid(
  columns: (5em, 1fr),
  text("关键词：", font: font_type.黑体, size: font_size.小三), keywords.join("，"),
)
