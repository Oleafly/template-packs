// tau-thesis.typ
#let m_paper = "iso-b5"
#let paper_counter = counter("paper")
// template function
#let tau-thesis(
  title: none,
  author: none,
  date: datetime.today(),
  body,
) = {
  // global settings
  set page(paper: "iso-b5", 
          margin: (top: 2cm, bottom: 3cm, inside: 2.5cm, outside: 2cm),
    
    footer: none,
    numbering: "1",
  )
  set terms(indent: 1em, separator: h(1cm, weak: true) )
  set text(lang: "en", size: 10pt, font: "Noto Sans")
  set par(leading: 0.7em, justify: true, first-line-indent: 1.5em)
  
  // math settings
  set math.equation(numbering: n => {
    let sn = counter(heading).get().first()
      [(#sn.#n)]
    }, supplement: [Eq.])
  
  // show math.equation: set text(font: "Noto Sans Math")
  show math.equation: set block(spacing: 1.5em)

  set heading(numbering: "1.1   ")

  show heading: set par(justify: false)
  // chapter
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)

    pagebreak(weak: true, to: "odd")
    text(size: 1.8em, weight: "regular", stretch: 75%, it)
    v(6.0em)
  }
  // section
  show heading.where(level: 2): it => {
    v(1.2em)
    text(size: 1.5em, weight: "regular", stretch: 75%, it)
    v(1em)
  }
  // subsection
  show heading.where(level: 3): it => {
    v(1.2em)
    text(size: 1.3em, weight: "regular", stretch: 75%, it)
    v(1.0em)
  }
  // paragraph
  show heading.where(level: 4): it => {
    v(1.2em)
    text(size: 1.1em, weight: "regular", stretch: 75%, it)
    v(1.0em)
  }

  // figure (include image, table, code...)
  set figure(numbering: n => {
    let sn = counter(heading).get().first()
      [#sn.#n]
    }, placement: auto)

  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  show figure.caption: it => {
    text(stretch: 75%, size: .9em, it)}

  // show figure.where(kind: image): set figure(supplement: [Fig.])
 
  let frame() = (x, y) => (
  left: none,
  right: none,
  bottom: .7pt,
  top: if y < 2 { .7pt } else { 0pt },
  )
  
  set table(
    inset: 3pt,
    align: center, 
    stroke: frame(),
  )
  // outline format
  show outline.entry: it => {
    v(0.2em)
    it
  }
  show outline.entry.where(level: 1): it => {
    v(0.8em)
    text(weight: "semibold", it)
  }
  // bib spacing
  show bibliography: it => {
    set par(spacing: 0.8em)
    it
  }
  // math equation refer as no parathesis
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el == none or el.func() != eq { return it }
      let sec = counter(heading).at(el.location()).first()
      let eq = counter(math.equation).at(el.location()).first()
      link(el.location(), [#el.supplement #sec.#eq])
  }

  body
}

// article include

// #let tab_page(dy, i) = {
//   pagebreak(to: "odd", weak: true)
//   page(
//     margin: 0pt,
//     header: none,
//     footer: none,
//     numbering: none,
//     )[#let label = numbering("I", i)
//       #place(right + top, dy: dy, block(
//         width: 6%,
//         height: 20%,
//         fill: gray,
//         inset: 0pt, align(center + horizon)[
//           #text(fill: white, size: 2em, weight: "bold")[#label]]
//       ))]
// }

#let includepdf(file, pages) = {
    pagebreak(to: "odd", weak: true)
    for p in range(1, pages + 1) {
      page(
        paper: m_paper,  // paper size reset to thesis paper size
        margin: 0pt,
        header: none, footer: none, background: none, numbering: none,
        image(file, page: p),
      )
    }
}

#let include_paper(paper_list) = {
  set page(numbering: none, header: none, footer: none)
  let total = paper_list.len()
  let step = 80%/(total - 1)
  for (i, pub) in paper_list.enumerate(){
    // tab_page(i*step, i + 1)
    includepdf(pub.at(0), 2)
    includepdf(pub.at(0), pub.at(1))
  }
}
