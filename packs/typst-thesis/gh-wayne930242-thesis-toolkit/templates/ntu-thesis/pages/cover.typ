#import "../font-config.typ": ntu-fonts

#let make-cover(
  university: "國立臺灣大學",
  university-en: "National Taiwan University",
  college: "工學院",
  college-en: "College of Engineering",
  institute: "工業工程學研究所",
  institute-en: "Institute of Industrial Engineering",
  degree-zh: "碩士",
  degree-en: "Master's",
  type-zh: "論文",
  type-en: "Thesis",
  title: (zh: "", en: ""),
  author: (zh: "", en: ""),
  advisor: (zh: "", en: ""),
  co-advisor: (),
  student-id: "",
  date: "",
) = {
  // 封面特殊頁面設定
  set page(
    margin: (top: 4cm, bottom: 3cm, left: 3cm, right: 3cm), 
    numbering: none,
    // 浮水印背景 - 與內文頁面一致的設定
    background: align(center + horizon, 
      image("../assets/watermark.svg", width: 40%)
    )
  )
  
  // 日期格式化
  let date-parts = date.split("-")
  let year = int(date-parts.at(0))
  let month = int(date-parts.at(1))
  let roc-year = year - 1911
  
  let months-zh = ("一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二")
  let months-en = ("January", "February", "March", "April", "May", "June", 
                   "July", "August", "September", "October", "November", "December")
  
  set text(font: ntu-fonts)
  
  align(center)[
    #v(1fr)
    
    // 學校學院資訊 (16pt)
    #text(size: 16pt)[#university#college#institute]
    
    #v(0.5em)
    // 學位論文 (18pt, 粗體)
    #text(size: 18pt, weight: "bold")[#degree-zh 學位#type-zh]
    
    #v(1em)
    // 英文學校資訊 (14pt)
    #text(size: 14pt, font: ("Libertinus Serif"))[#institute-en]
    #linebreak()
    #text(size: 14pt, font: ("Libertinus Serif"))[#college-en]
    #linebreak()
    #text(size: 16pt, font: ("Libertinus Serif"))[#university-en]
    
    #v(0.5em)
    // 英文學位 (16pt)
    #text(size: 16pt, font: ("Libertinus Serif"))[#degree-en #type-en]
    
    #v(2em)
    // 中文論文題目 (18pt, 粗體)
    #text(size: 18pt, weight: "bold", font: ntu-fonts)[#title.zh]
    
    #v(1em)
    // 英文論文題目 (18pt)
    #text(size: 18pt, font: ("Libertinus Serif"))[#title.en]
    
    #v(2em)
    // 作者姓名 (18pt)
    #text(size: 18pt, font: ntu-fonts)[#author.zh]
    #linebreak()
    #text(size: 18pt, font: ("Libertinus Serif"))[#author.en]
    
    #v(1.5em)
    // 指導教授 (18pt)
    #text(size: 18pt, font: ntu-fonts)[指導教授：#advisor.zh 博士]
    #linebreak()
    #text(size: 18pt, font: ("Libertinus Serif"))[Advisor: #advisor.en, Ph.D.]
    
    // 共同指導教授（如果有）
    #if co-advisor.len() > 0 {
      v(1em)
      for (i, co-adv) in co-advisor.enumerate() {
        text(size: 18pt, font: ntu-fonts)[共同指導教授：#co-adv.zh 博士]
        linebreak()
        text(size: 18pt, font: ("Libertinus Serif"))[Co-Advisor: #co-adv.en, Ph.D.]
        if i < co-advisor.len() - 1 { linebreak() }
      }
    }
    
    #v(2em)
    // 日期 (18pt)
    #text(size: 18pt, font: ntu-fonts)[中華民國 #roc-year 年 #months-zh.at(month - 1) 月]
    #linebreak()
    #text(size: 18pt, font: ("Libertinus Serif"))[#months-en.at(month - 1) #year]
    
    #v(1fr)
  ]
  
  // 確保分頁
  pagebreak()
} 