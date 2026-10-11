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

// === 目錄模板 ===
#let make-outline() = {
  pagebreak()
  
  chapter-title("目　錄")
  
  set text(size: 12pt, font: ntu-fonts)
  
  // 目錄設定
  set outline(
    title: none,
    indent: auto
  )
  
  outline(depth: 3)
  
  // 圖目錄
  pagebreak()
  chapter-title("圖目錄")
  outline(
    title: none,
    target: figure.where(kind: image)
  )
  
  // 表目錄  
  pagebreak()
  chapter-title("表目錄")
  outline(
    title: none,
    target: figure.where(kind: table)
  )
} 