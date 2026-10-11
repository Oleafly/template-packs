#import "@preview/muchpdf:0.1.1" : muchpdf
#import "@preview/zebraw:0.5.5": *


#let base_indent = 1em
#let indent = 1.25cm
// TODO В данной реализации титульник подгружается из PDF. Но нет сложности ее переделать в typst формат
#let data = read("title.pdf", encoding: none)

#show figure: set block(breakable: true)
// #show figure: it => {
  // set block(breakable: true)
  // [#it.body]
// }


#let figure_capt = (body, caption) => {
  if body.kind == image [
    #figure(body, caption: caption, supplement: [Рисунок])
  ]
  else [
    #figure(body, caption: caption)
  ]
}

#set page(paper: "a4", margin: 0em)
#muchpdf(data, pages: (start: 0, end: 0))


#set page(paper: "a4", margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm))
#set par(leading: base_indent, justify: true, spacing: base_indent, first-line-indent: (
  amount: indent,
  all: true,
))

#set text(font: "Times New Roman", size: 14pt, lang: "ru", hyphenate: false)

#import "addons/cyrillic_enum.typ": ru_alph
#set enum(indent: indent)
// #set list(marker: [
//   #numbering(numbering: ru_alph(), 1,2,3)
//   ],
//    body-indent: indent)

#show table: set par(justify: false, first-line-indent: (amount: 0em, all: true))
#show table: set text(hyphenate: true)
#show table: set enum(indent: 0em)

#show heading.where(level: 1): it => {
  // set align(left)
  set text(14pt, weight: "bold")
  counter("listing_counter").update(1)

  block(inset: (x: indent, y: 0em), width: 100%)[
      #set align(center)
      #it  
  ]
}

#show heading.where(level: 2): it => [
  #set align(left)
  #set text(14pt, weight: "bold")
  
  #block(inset: (top: 14pt, bottom: 8pt))[

    #counter(heading).display() #it.body

    ]
  // #block(height: 6pt)
  // #block(height: 6pt)
  // #set par(first-line-indent: (amount: indent, all: true))
  // #heading(hanging-indent: indent, level: 2)[#it.body]
  
  // #block(it, inset: (x: indent, bottom: 12pt))
]


#show heading.where(level: 3): set heading(numbering: none)

#show heading.where(level: 3): it => {
  set text(14pt, weight: "regular") 
  block(width: 100%, inset: (x: indent, bottom: 8pt))[
    #it.body
  ]
}

#show heading.where(numbering: none): it => [
  #set align(center)
  #block(inset: (bottom: 14pt))[
    #it
  ]
]




// #show list: set par(leading: .6em, spacing: 1em)

// #show list: set #numbering()


#show table.cell: it => {
  set text(size: 12pt)
  set par(leading: .6em)
  set align(left)
  it
}

#set figure.caption(separator: [ -- ])


#show figure.caption.where(position: top): it => {
  align(left)[
    #block(inset: (top: 6pt, bottom: 3pt))[#it]
    ]
}

#show figure.where(kind: table): it =>  {
  set figure.caption(position: top) 
  set align(left)
  set par(leading: 1em, justify: true, spacing: 1.2em, first-line-indent: 1em)
  it
}



#show figure.where(kind: raw): it => {
set figure.caption(position: top)
counter("listing_counter").step()
it
}

#let listing_counter = counter("listing_counter")
#let chapter_num = context{counter(heading.where(level: 1)).display()}

#show figure.where(kind: raw): set figure(numbering: (..nums) => chapter_num + "." + listing_counter.display())


#show figure.where(kind: image): set figure(supplement: [Рисунок])

#show raw: it => {
  set align(left)
  set text(font: "Courier New", size: 12pt)
  set par(leading: .6em, spacing: 1em, first-line-indent: 0em, hanging-indent: 0em)

  block(stroke: 1pt, inset: .5em, 
  zebraw(it, background-color: luma(255), lang: false, inset: (top: .2em)))
  // align(left)[#block(
  //   it, stroke: (1pt), inset: .5em, width: 100%
  // )]
}


// Аннотация

#import "addons/bib_count.typ": bib-count
#show cite: it => {
  it
  bib-count.update(((..c)) => (..c, it.key))
}

#include "chapters/задание.typ"

#include "chapters/annotation.typ"


#set page(numbering: "1", footer-descent: 30% + 0pt)
// СОДЕРЖАНИЕ
#outline(depth: 2, title: "СОДЕРЖАНИЕ")

// ВВЕДЕНИЕ
#include "chapters/introduction.typ"


#set heading(numbering: "1.1")



// === ГЛАВЫ ===
// Пример включения

// #include "chapters/анализ_предметной_области.typ"

#include "chapters/список_литературы.typ"