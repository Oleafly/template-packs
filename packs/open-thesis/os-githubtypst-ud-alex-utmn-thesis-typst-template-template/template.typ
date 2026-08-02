#import "@preview/zebraw:0.4.0": zebraw
#import "@preview/non-unlabeled:0.2.0": dont-number-unlabeled
#import "@preview/theorion:0.6.0": *


#let project(project_data, body) = {

  show: zebraw
  show: show-theorem
  set-theorion-numbering("1.1.1")

  set document(title: "Длинное название дипломной работы", 
                author: "Иванов Иван Иванович", date: auto)

  set page(margin: (left: 30mm,
                    right: 15mm,
                    top: 20mm,
                    bottom: 20mm),
                    numbering: "1", fill: rgb("FCFCFA"), paper: "a4")

  set text(font: "Times New Roman", size: 14pt, lang: "ru")
  set par(leading: 1.5em, first-line-indent: (all: true, amount: 1.25cm), justify: true)

  show heading: set block(below: 1.5em, above: 2em)
  show heading: set text(size: 14pt)
  show heading: it => { align(center)[#upper(it)] }
  set heading(numbering: "1.1.")

  show heading.where(level: 1): set heading(numbering: none)
  show heading: set text(hyphenate: false)

  show <chapter>: set heading(numbering: "ГЛАВА 1.")
  show <core_chapter>: set heading(numbering: "ГЛАВА 1.")

  show outline.entry: upper

  set math.equation(numbering: "(1)")
  
  let eq_numbering = counter("eq")

  show heading.where(level: 1): it => { eq_numbering.update(0); it }

  set math.equation(numbering: it => 
    {
    eq_numbering.step()
    context {
    
    let chapter_number = counter(heading).get().at(0)
    
    let eq_number = eq_numbering.get().at(0)

    numbering("(1.1)", chapter_number, eq_number)
    
    }
    
    }
    ) if project_data.numbering_style == "nested"

  let numbering_style = { if project_data.numbering_by_default { it => it } 
  else { dont-number-unlabeled(math.equation) } }

  show math.equation: numbering_style

  show figure.where(
  kind: table
): it => {

  
  align(right)[#it.caption.supplement #it.numbering]
  v(-0.5em)
  align(center)[#it.caption.body]
  it.body
  }


  show sym.lt.eq: $lt.eq.slant$
  show sym.gt.eq: $gt.eq.slant$

  body
}