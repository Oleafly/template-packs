// uh-thesis.typ
#let m_paper = "iso-b5"
#let paper_counter = counter("paper")

//template function.
#let uh-thesis(
  title: none,
  author: none,
  date: datetime.today(),
  body,
) = {
  // global settings
  set page(paper: m_paper,
          margin: (top: 3cm, bottom: 2.5cm, inside: 2.5cm, outside: 2cm),
    
    footer: none,
    numbering: "1",
  )
  set terms(indent: 1em, separator: h(1cm, weak: true) )
  set text(lang: "en", size: 10pt, font: "Noto Serif")
  set par(leading: .5em, justify: true,
          spacing: .5em, first-line-indent: 1.5em)
  
  // math settings
  set math.equation(numbering: n => {
    let sn = counter(heading).get().first()
      [(#sn.#n)]
    })
  
  set heading(numbering: "1.1  ")
  
  show heading: set par(justify: false)
  // chapter
  show heading.where(level: 1): it => {
    context {
      counter(math.equation).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)

      pagebreak(to: "odd", weak: true)
      v(10%)
      if it.numbering != none {
        text(size: 1.6em, weight: "bold")[Chapter #counter(heading).display()]
      } 
      v(2%)
        block[#text(size: 1.7em, weight: "bold")[#it.body]]
      v(5%)
    }
  }
  // section
  show heading.where(level: 2): it => {
    text(size: 1.4em, weight: "semibold", it)
    v(0.2em)
  }
  // subsection
  show heading.where(level: 3): it => {
    text(size: 1.2em, weight: "semibold", it)
    v(0.2em)
  }
  // paragraph
  show heading.where(level: 4): it => {
    text(size: 1.0em, weight: "bold", it.body)
    v(0.2em)
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
    let sn = counter(heading).get().first()
    text(weight: "bold", size: .9em)[#it.supplement
    #context it.counter.display(it.numbering)#it.separator]
    text(size: .9em)[ #it.body]}

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
    v(0.5em)
    text(weight: "bold", it)
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
      link(el.location(), [Eq. #sec.#eq])
  }

  body
}

// header
#let default-header = context {
  let pg = here().page()
  let headings = query(heading)

  let chapters = headings.filter(h => h.level == 1 and h.location().page() <= pg)
  let sections = headings.filter(h => h.level == 2 and h.location().page() <= pg)

  let is-chapter-page = chapters.any(
    h => h.location().page() == pg
  )

  if is-chapter-page {
    none
  } else {
    let chapter = if chapters.len() > 0 {
      chapters.last().body
    } else {""}

    let section = if sections.len() > 0 {
      sections.last().body
    } else {""}
    if calc.odd(pg) {
      // text(style: "italic")[#chapter #h(1fr) #counter(page).display()]
      text()[#h(1fr) #counter(page).display()]
    } else {
      // text(style: "italic")[#counter(page).display() #h(1fr) #section]
      text()[#counter(page).display() #h(1fr)]
    }

    v(-.1em)
    align(center)[
      #line(length: 100%, stroke: 0.5pt)
    ]
  }
}

// article include
#let tab_page(dy, i) = {
  pagebreak(to: "odd", weak: true)
  page(
    margin: 0pt,
    header: none,
    footer: none,
    numbering: none,
    )[#let label = numbering("I", i)
      #place(right + top, dy: dy, block(
        width: 6%,
        height: 20%,
        fill: gray,
        inset: 0pt, align(center + horizon)[
          #text(fill: white, size: 2em, weight: "bold")[#label]]
      ))]
}

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
    tab_page(i*step, i + 1)
    includepdf(pub.at(0), pub.at(1))
  }
}
