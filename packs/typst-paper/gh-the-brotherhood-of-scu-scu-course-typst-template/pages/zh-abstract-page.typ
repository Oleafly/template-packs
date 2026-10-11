#import "../fonts/font-def.typ": *

// 中文摘要
#let zh_abstract_page(title, author, major, abstract,id, keywords: (), anonymous: false) = {
  show <_zh_abstract_>: {
    align(center)[
      #text(font: heiti, size: 18pt, title)
    ]
  }

  [摘要 <_zh_abstract_>]


  set text(font: kaiti)
  v(10pt)

  align(center)[
    #text(size: 14pt, tracking: -1pt)[
      // 根据匿名参数决定是否显示作者和导师信息
      #if not anonymous [
         #author #h(20pt) #id
      ]
    ]
  ]
  v(10pt)

  text(size: 10.5pt, tracking: -1pt)[
    #text(weight: "bold", [[摘要]    ],font: heiti)
    #abstract
  ]    
  
  linebreak()
  
  text(size: 10.5pt, tracking: -1pt)[
    #box(width: 2em)
    #text(weight: "bold", [关键词  ],font: heiti)
    #keywords.join("； ")
  ]    
}