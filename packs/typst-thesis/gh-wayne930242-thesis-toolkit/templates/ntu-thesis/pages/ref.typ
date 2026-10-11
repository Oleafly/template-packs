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

// === 參考文獻模板 ===
#let make-ref(bibliography-content) = {
  pagebreak()
  
  chapter-title("參考文獻")
  
  set text(size: 12pt, font: ntu-fonts)
  set par(
    leading: 1.0em,   // 2.0倍行距
    spacing: 1.2em,   // 段落間距
    justify: true,
    first-line-indent: 0em  // 參考文獻不縮排
  )
  
  bibliography-content
} 