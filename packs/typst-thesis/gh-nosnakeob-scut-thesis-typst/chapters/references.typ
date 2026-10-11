#import "../style/font.typ": *

// 使用 Typst 的 bibliography 功能，按文中出现顺序编号。
#set text(font: font.宋体, size: font_size.五号)
#set par(first-line-indent: 0em, leading: 0.45em)

#bibliography(title: "参考文献", "../biblibrary/example.bib", style: "gb-7714-2015-numeric")
