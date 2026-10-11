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

// === 中文摘要模板 ===
#let make-abstract-zh(content, keywords: ()) = {
  pagebreak()
  
  chapter-title("摘　要")
  
  set text(size: 12pt, font: ntu-fonts)
  set par(
    leading: 1.0em,   // 2.0倍行距
    spacing: 1.2em,   // 段落間距
    justify: true, 
    first-line-indent: 2em
  )
  
  content
  
  if keywords.len() > 0 {
    v(2em)
    text(weight: "bold", font: ntu-fonts)[關鍵字：]
    keywords.join("、")
  }
}

// === 英文摘要模板 ===
#let make-abstract-en(content, keywords: ()) = {
  pagebreak()
  
  chapter-title("Abstract")
  
  set text(size: 12pt, font: ("Libertinus Serif"))
  set par(
    leading: 1.0em,   // 2.0倍行距，與中文保持一致
    spacing: 1.5em,   // 英文段落間距稍大
    justify: true,
    first-line-indent: 0em  // 英文不縮排
  )
  
  content
  
  if keywords.len() > 0 {
    v(2em)
    text(weight: "bold", font: ("Libertinus Serif"))[Keywords: ]
    keywords.join(", ")
  }
} 