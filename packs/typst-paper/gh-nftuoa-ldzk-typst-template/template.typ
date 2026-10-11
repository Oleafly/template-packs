#let LDZK(title: none,
  author: [],
  abstract: [],
  address: [],
  keywords: { },
  category: [],
  doc,
  intro:[],
  author_eng:[],
  title_eng: [],
  abstract_eng: [],
  keywords_eng: [],
  address_eng:[],
  acknowledge:[])={
  
  let indent = h(2em)
  set page(paper: "a4",
    margin: (x: 3.17cm, y: 2.54cm),
  )

  set par(
    spacing: 1em,
    justify: true,
  )

  import "@preview/cuti:0.2.1": show-cn-fakebold
  show: show-cn-fakebold
  import "@preview/numbly:0.1.0": numbly
  set heading(numbering: numbly(
    "{1}",
    "{1}.{2}",
    "({3:a})",
  ))
  set text(font: ("Nimbus Roman","FZDaBiaoSong-B06S",),size:20pt,lang: "zh", region: "cn")
  title
  linebreak()
  set text(10.5pt)
  author
  linebreak()
  set text(9.5pt)
  address
  [ \ 摘要:]
  abstract
  [ \ 关键词:]
  for keyword in keywords{
    keyword
    if(keyword!=keywords.last()){[，]}
  }
  [ \ 中图分类号：]
  category


  set par(
  leading: 11pt,
  spacing: 2em,
  justify: true,
  )

  text(14pt,title_eng)
  [ \ ]
  text(10.5pt,author_eng)
  [ \ ]
  address_eng
  text(weight: "bold",
  [ \ Abstract: ])
  abstract_eng
  text(weight: "bold",[ \ Key words: ])
  for keyword_eng in keywords_eng{
    keyword_eng
    if(keyword_eng!=keywords_eng.last()){[，]}
  }
  [ \ ]
  set text(font: ("Calibri","SimSun","Source Han Serif VF",),size:10.5pt,weight: "regular")
  intro
  set text(size:10pt)
  doc
  [ \ ]  
  text(font: ("Adobe Kaiti Std"),size:10pt,"致谢:")
  text(font:("Nimbus Roman","FZDaBiaoSong-B06S"),acknowledge)
  
  set text(font: ("Nimbus Roman","Simsun","Source Han Serif VF"), size:12pt, weight: "bold",lang: "en", region: "us")

  [\ 参考文献]
  set text(font: ("Nimbus Roman","Simsun","Source Han Serif VF"), size:9.5pt, weight: "regular")

  bibliography("references.bib",style: "gb-7714-2015-numeric", title:none)
}