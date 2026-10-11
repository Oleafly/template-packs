#import "../font-config.typ": ntu-fonts

#let make-verification(
  university: "國立臺灣大學",
  institute: "工業工程學研究所",
  degree-zh: "碩士",
  type-zh: "論文",
  title: (zh: "", en: ""),
  author-zh: "",
  student-id: "",
  oral-date: "",
) = {
  pagebreak()
  set page(numbering: "i")
  
  // 日期格式化
  let date-parts = oral-date.split("-")
  let year = int(date-parts.at(0))
  let month = int(date-parts.at(1))
  let day = int(date-parts.at(2))
  let roc-year = year - 1911
  
  set text(font: ntu-fonts)
  
  align(center)[
    #v(1fr)
    
    // 標題 (24pt, 36pt行距)
    #text(size: 24pt, font: ntu-fonts)[#university#degree-zh 學位#type-zh]
    #v(0.5em)
    #text(size: 26pt, weight: "bold", font: ntu-fonts)[口試委員會審定書]
    
    #v(1fr)
    
    // 論文題目 (20pt, 30pt行距)
    #text(size: 20pt, font: ntu-fonts)[#title.zh]
    #v(0.5em)
    #text(size: 20pt, font: ("Libertinus Serif"))[#title.en]
    
    #v(1fr)
  ]
  
  // 審定書內容 (16pt, 2.0倍行距)
  set par(
    leading: 1.0em,   // 2.0倍行距，與正文一致
    spacing: 1.2em,   // 段落間距
    justify: true, 
    first-line-indent: 2em
  )
  text(size: 16pt, font: ntu-fonts)[
    本論文係#author-zh 君（#student-id）在#university#institute 完成之#degree-zh 學位#type-zh，於民國 #roc-year 年 #month 月 #day 日承下列考試委員審查通過及口試及格，特此證明
  ]
  
  v(1fr)
  
  // 簽名表格
  align(center)[
    #text(size: 16pt, font: ntu-fonts)[
      #table(
        columns: 2,
        stroke: none,
        align: left,
        [口試委員：], [#line(length: 11.5cm, stroke: 1pt)],
        [], [（指導教授）],
        [], [#line(length: 5cm, stroke: 1pt) #h(1.5cm) #line(length: 5cm, stroke: 1pt)],
        [], [#line(length: 5cm, stroke: 1pt) #h(1.5cm) #line(length: 5cm, stroke: 1pt)],
        [], [#line(length: 5cm, stroke: 1pt) #h(1.5cm) #line(length: 5cm, stroke: 1pt)],
        [], [#line(length: 5cm, stroke: 1pt) #h(1.5cm) #line(length: 5cm, stroke: 1pt)],
        [所長：], [#line(length: 9cm, stroke: 1pt)],
      )
    ]
  ]
  
  v(1fr)
} 