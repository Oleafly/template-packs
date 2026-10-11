#import "../font-config.typ": ntu-fonts, ntu-heading-fonts

// === 章節標題函數 ===
#let chapter-title(title) = {
  align(center)[
    #text(
      size: 21pt,  // 對應 LaTeX \Huge (20.74pt)
      weight: "bold", 
      font: ntu-heading-fonts
    )[#title]
  ]
  v(1em)
}

// === 致謝模板 ===
#let make-acknowledgement(content) = {
  pagebreak()
  
  chapter-title("致　謝")
  
  set text(size: 12pt, font: ntu-fonts)
  set par(
    leading: 1.0em,   // 2.0倍行距，與正文一致
    spacing: 1.2em,   // 段落間距
    justify: true, 
    first-line-indent: 2em
  )
  
  content
} 