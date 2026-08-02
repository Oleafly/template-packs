#let font_2p = 22pt
#let font_s2p = 18pt
#let font_3p = 16pt
#let font_s3p = 15pt
#let font_4p = 14pt
#let font_s4p = 12pt
#let font_5p = 10.5pt
#let font_s5p = 9pt

// Windows
#let font_hei = "simhei"
#let font_sun = "simsun"
#let font_times = "Times New Roman"
#let font_arial = "Arial"
#let font_kai = "kaiti"
#let font_fsun = "fangsong"

// MacOS
#let font_hei = "Hei"
#let font_sun = "Songti SC"
#let font_times = "Times"
#let font_arial = "Arial"
#let font_kai = "Kai"
#let font_fsun = "STFangsong"


#let font_body = (font_times,font_sun)
#let font_title = (font_arial,font_hei)
#let font_caption = (font_times,font_hei)
#let font_def = (font_times,font_hei)

#let project(
  title: "",
  authors: (),
  address: "",
  title_cn: "",
  authors_cn: (),
  address_cn: "",

  abstract: none,
  abstract_cn: none,

  keywords:(),
  keywords_cn:(),

  bibliography-file: none,

  body
) = {

  // Set document metdata.
  set document(title: title_cn, author: authors_cn)

  
  // Configure the page.
  set page(
    paper: "a4",
    margin: (left:2.0cm, right:2.0cm, top: 3.2cm, bottom: 2.5cm),
    header: context {
      let page_number = counter(page).get().first() 
      if page_number==1 [
        #align(center)[
          #text(font:font_body,size:font_s5p,)[中#h(0.4cm)国#h(0.4cm)电#h(0.4cm)机#h(0.4cm)工#h(0.4cm)程#h(0.4cm)学#h(0.4cm)报\ Proceedings of the CSEE]
        ]
      ]else if calc.odd(page_number) [
        #v(-5pt, weak: true)      
        #align(right)[
          #page_number
        ]
      ]else[
        #align(center)[
          #text(font:font_body,size:font_s5p,)[中#h(0.4cm)国#h(0.4cm)电#h(0.4cm)机#h(0.4cm)工#h(0.4cm)程#h(0.4cm)学#h(0.4cm)报]
        ]
        #v(-5pt, weak: true)      
        #page_number
      ]

      v(5pt, weak: true)
      line(length: 100%,stroke: 0.5pt)
      v(1.3pt, weak: true)
      line(length: 100%,stroke: 0.5pt)
    },
  )
  // first line indent
  
  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)",supplement:[式])
  show math.equation: it =>{
    h(0em,weak: false)
    set block(spacing: 0.65em)
    it
    h(0em,weak: false)
  }

  set raw(align: left)
  show raw: it =>{
    set block(spacing: 0.65em)
    text(size: font_s5p,font: font_body)[#it]
    h(0em,weak: false)
  }


  // Configure figures and tables.
  set figure(supplement:[])
  show figure: it => {
    set text(font: font_caption,weight: "black",size:font_s5p)
    set align(center)
    if it.kind == image [
      #box[
        #it.body
        #v(14pt, weak: true)
        图 #it.caption//\
        // Fig #it.caption
      ]
    ] else if it.kind == table [
      #box[
        表#it.caption//\
        // Tab.#it.caption
        #v(14pt, weak: true)
        #it.body
      ]
    ] else [
      ...
    ]
}
  set table(stroke: 0.5pt,)
  show table: set text(8pt)
  
  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  show enum: it =>{
    it
    h(0em,weak: false)
  }
  set list(indent: 10pt, body-indent: 9pt)
  show list: it =>{
    it
    h(0em,weak: false)
  }

  // Configure headings.

  set heading(numbering: "1.")
  show heading: it =>  {
    if it.level == 1 [
      #if it.body == "致谢" [
        #align(center)[
          #text(font:font_title,size:font_s4p)[#it.body]
        ]
        #set text(font:font_kai)
      ]else if it.body == "参考文献" [
        #text(font:font_title,size:font_s4p)[#it.body]
        #v(font_s4p, weak: true)
      ]else[
        // #text(font:font_title,size:font_s4p)[
        //   #counter(heading).display()#h(6pt)#it.body]
        #text(font:font_title,size:font_s4p)[#it]
        #v(font_s4p, weak: true)
      ]
    ] else if it.level == 2 [
      // #text(font:font_title,size:font_5p)[
      //   #counter(heading).display()#h(6pt)#it.body]
      #text(font:font_title,size:font_5p)[#it]
      #v(font_5p, weak: true)
    ] else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 [
        // #text(font:font_body,size:font_5p)[
        //   #counter(heading).display()#h(6pt)#it.body]
        #text(font:font_body,size:font_5p)[#it]
        #v(font_5p, weak: true)
      ]
    ]
    ""
    v(-font_5p, weak: true)
  }


  // ==================================================
  // ==================================================

  // Display the paper's title.
     set text(fallback: false)
  align(center)[
    #text(title_cn, size: font_2p, font: font_title)
    #v(font_4p, weak: true)
    #text(authors_cn.join("，"), size: font_4p, font: font_fsun)
    #v(font_4p, weak: true)
    #text("（"+address_cn+"）", size: font_5p, font: font_kai)
    #v(font_5p*2, weak: true)
    #text(title, size: font_s4p, font: font_times, weight: "black")
    #v(font_5p, weak: true)
    #text(authors.join(", "), size: font_5p, font: font_times)
    #v(font_5p, weak: true)
    #text("("+address+")", size: font_s5p, font: font_times)
    #v(font_5p+font_s4p, weak: true)
  ]

  // Start two column mode and configure paragraph properties.
  show: columns.with(2, gutter: 12pt)
  set par(justify: true)
  // Display abstract , index terms or keywords.
  set text(size: font_s5p,font: font_body)
  set par(leading: font_s5p)
  if abstract != none [  
    *ABSTRACT:* #abstract
    
    #if keywords != () [
    *KEY WORDS:* #keywords.join(", ")
    
    ]
  ]
  if abstract_cn != none [
    *#text(font:font_hei)[摘要]:* #abstract_cn

    #if keywords_cn != () [
    *#text(font:font_hei)[关键字]:* #keywords_cn.join(", ")

    ] 
  ]

  // Display the paper's contents.
  set par(justify: true, first-line-indent: 0.74cm)
  set text(font_5p,font:font_body) //会自动匹配前面的是英语字体，后面的是中文字体
  body 

  // Display bibliography.
    if bibliography-file != none {
      
      show bibliography: set text(size:font_5p,font:font_body)
      
      bibliography(bibliography-file, title: text(size:font_s4p,font:font_hei)[参考文献], style: "gb-7714-2015-numeric")
    }

}
