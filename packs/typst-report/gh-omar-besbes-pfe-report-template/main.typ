// ==================== external packages ====================
#import "@preview/glossarium:0.5.6": make-glossary, register-glossary
#import "@preview/hydra:0.6.1": hydra

// ==================== internal packages ====================
#import "glossary.typ": glossary-dictionary
#import "content.typ": matter


// ==================== config ====================
#set document(
  title: "Rapport_PFE_Template",
  author: "Foulen Fouleni",
  date: datetime.today(),
  description: "Foulen Fouleni's report on his/her final year project",
  keywords: (
    "keyword 1",
    "keyword 2",
  )
)
#set page(
  paper: "a4",
  margin: (
    y: 4cm,
    x: 2.5cm,
  ),
  header: context {
    if matter.get() == "main" {
      let _left = hydra(
        2,
        display: (ctx, h) => [#emph(h.body)]
      )

      let _right = hydra(
        1,
        display: (ctx, h) => {
          let nums = counter(heading).at(h.location())
          let chap = nums.first()
          [Chapter #numbering("1.", chap) #emph(h.body)]
        },
      )

      if _left != none or _right != none {
        grid(columns: (1fr, 1fr),
          align(left, _left),
          align(right, _right),
        )
        line(length: 100%, stroke: 0.5pt)  
      }
    }
  } 
)
#set text(lang: "en", font: "New Computer Modern")
#set heading(bookmarked: true, numbering: "1.")
#set par(
  leading: 1.2em,
  spacing: 1.2em,
  first-line-indent: 1.8em,
  justify: true,
)
#set raw(block: true)
#set terms(separator: [: ])
#set quote(block: true)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)
#show raw: set text(font: "New Computer Modern Mono")
#show heading: set block(above: 2em, below: 1.5em)
#show link: set text(fill: blue.darken(60%))
#show heading.where(outlined: true): it => {
  if matter.get() != "main" {
    it
  } else if it.level == 1 {
      pagebreak(weak: true)
    if it.numbering == none {
      block[
        #text(size: 30pt, weight: "regular")[#it.body]
        #v(10%)
      ]
    } else {
      block[
        #v(35%)
        #text(size: 80pt, fill: gray)[#counter(heading).display("1")]
        #linebreak()
        #text(size: 30pt, weight: "regular")[#it.body]
        #v(10%)
      ]
    }
  } else {
    if it.numbering == none {
      block[#it.body]
    } else {
      let nums = counter(heading).get()
      let rest = nums.slice(1)
      let numbering = numbering("1.", ..rest)
      block[#numbering #it.body]
    }
  }
}
#show outline.entry: it => {
  show link: set text(fill: black)
  if it.level == 1 {
    set text(weight: "bold")
    it
  } else {
    let prefix =  if it.prefix() == none {
      ""
    } else {
      it.prefix().text.split(".").slice(1).join(".")
    }
    
    link(it.element.location(), it.indented(prefix, it.inner()))
  }
}
#show quote: set text(fill: luma(70))
#show: make-glossary
#register-glossary(glossary-dictionary)

// ==================== content ====================
#include "content.typ"