#import "boxes.typ": *
#import "fontconfig.typ": *
// #import "@preview/indenta:0.0.3": fix-indent
#import "@preview/hydra:0.6.2": hydra

#let chinese_numbering(..nums, location: none) = {
    if nums.pos().len() == 1 {
        numbering("第一章", ..nums)
    } else {
        numbering("1.1", ..nums)
    }
}

#let makecontent() = [
  #show outline: set heading(
    numbering: (..nums) => "",
  )
  #show heading: it => outlinebox(it)
  #outline(title: [目录], target: heading.where(outlined: true).or(figure.where(kind: "part")))
  #pagebreak()
  #counter(heading).update(0)
]

#let my-cases = (..items) => box(
  baseline: 50% - 0.5em,
  width: 1fr,
  math.cases(
    ..items.pos().map(item => math.display(box(inset: 5pt)[#text(font: text-fonts)[#item]])),
  ),
)

#let noindent = h(-2em)

#let conf(doc) = {
  set heading(
    numbering: chinese_numbering
  )

  show heading: it => headingbox(it)

  show outline.entry.where(level: 1): it => {
    if it.element.func() != heading {
      box(height: 2em, text(size: 14pt, font: part-fonts, fill: blue.darken(40%), it))
    } else {
      box(height: 1em, strong(it))
    }
  }

  set outline(
    depth: 3,
    indent: 2em
  )

  show outline.entry: it => {
    text(size:12pt, it)
  }

  set page(
    header: context align({
      if calc.odd(here().page()) {
        right
      } else {
        left
      }},
      emph(hydra(1, skip-starting: false)),
    ),
  )

  set text(font: text-fonts)

  show emph: set text(font: emph-fonts,)
  show strong: set text(font: bold-fonts)
  show raw: set text(font: code-fonts)

  set enum(indent: 2em)
  set list(indent: 2em,)

  set par(
    leading: 1em,
    first-line-indent: (amount: 2em, all: true)
  )

  set footnote(numbering: "①")

  show figure: set block(breakable: true)

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none {
      if el.func() == heading {
        link(el.location(), [#numbering(el.numbering, ..counter(heading).at(el.location()))])
      } else if el.func() == figure {
        link(el.location(), [#el.supplement #numbering(el.numbering, ..el.counter.at(el.location()))])
      }
    } else {
      it
    }
  }

  show raw.where(block: true): ctx => box(
    fill: blue.lighten(80%),
    outset: (y: 5pt, x: 10pt),
    inset: (y: 5pt),
    width: 90%,
    grid(columns: (2em, 1fr),
      grid.vline(x: 0, stroke: blue + 0.5pt, position: end),
      column-gutter: 7pt,
      stroke: (x, y) => if x == 1 {
        (bottom: (
          paint: white,
          thickness: 0.5pt
        ))
      },
      row-gutter: 5pt, 
      ..ctx.lines.map(
        line => (
          [#line.number], 
          box(inset: 2pt, line)
        )
      ).flatten()),
  )

  counter("part").update(1)
  
  doc
}