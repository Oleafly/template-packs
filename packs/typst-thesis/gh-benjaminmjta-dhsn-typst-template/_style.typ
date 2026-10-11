#import "_setup.typ": *

#let style(
  body
) = {

  // Formatierung
  set document(
    title: Title,
    author: Author,
    description: Title + " - " + Subtitle,
  )

  set page(
    paper: "a4",
    margin: (
      inside: 3.5cm,
      outside: 2.5cm,
      top: 2.5cm,
      bottom: 2.5cm,
    ),
    footer: context {
      let num-style = page.numbering
      if num-style != none {
        let page-num = counter(page).get().first()
        let pos = if calc.even(page-num) { left } else { right }
        align(pos)[
          #counter(page).display(num-style)
        ]
      }
    }
  )

  set text(
    font: Font,
    size: FontSizeM,
  )

  set par(
    justify: true,
    leading: 0.5em,
  )

  // Kapitelüberschriften
  show heading.where(level: 1): it => {
    block(
      below: 2em,
      width: 100%,
      breakable: false,
    )[
      #v(5em)
      #text(FontSizeXL, weight: "bold")[#it.body]
    ]
  }

  // Unterkapitelüberschriften
  show heading.where(level: 2): it => {
    let kapitelnr = counter(heading).display()
    block(
      breakable: false,
      above: 2em,
      below: 1em,
      width: 100%,
    )[
      #text(FontSizeL, weight: "bold")[#kapitelnr #it.body]
    ]
  }

  // Unterunterkapitelüberschriften
  show heading.where(level: 3): it => {
    let kapitelnr = counter(heading).display()
    block(
      breakable: false,
      width: 100%,
    )[
      #text(FontSizeM, weight: "bold")[#kapitelnr #it.body]
    ]
  }

  show list: it => {
    block(above: 1em)[#it]
  }

  // Inhaltverzeichnisse
  show outline.entry: it => {
    // bissl hässlich so, aber direkt auf #Parts zugreifen funktioniert nicht. pro eintrag [] herum sein...
    if it.element.body in ([#Parts.at(0)], [#Parts.at(1)]) {
      block(
        above: 3em,
        below: 2em,
        text(weight: "black", size: FontSizeL, it.element.body)
      )
    } else if it.element.body in ([Inhaltsverzeichnis], [Eidesstattliche Erklärung], [Hilfsmittel]){
    } else if it.level == 1{
      set block(above: 1.5em)
      text(weight: "bold", it)
    }
      else {
      set block(above: 1em)
      it
    }
  }

  // Inhalt
  body
}

#let main(body) = {
  set page(header: context {
    let cp = here().page()
    let h1-on-page = query(heading.where(level: 1)).filter(h => h.location().page() == cp)

    if h1-on-page.len() == 0 {
      let active-headings = query(selector(heading.where(level: 1)).before(here()))
      if active-headings.len() > 0 {
        let current-h1 = active-headings.last()
        let num = if current-h1.numbering != none {
          numbering(current-h1.numbering, ..counter(heading).at(current-h1.location()))
        } else { "" }

        let position = if calc.even(cp) { left } else { right }

        block(width: 100%, stroke: (bottom: 0.5pt + black), inset: (bottom: 6pt))[
          #align(position)[
            #text(size: FontSizeS)[#current-h1.supplement #num - #current-h1.body]
          ]
        ]
      }
    }
  })

  show heading.where(level: 1): it => {
    let num = if it.numbering != none {
      numbering(it.numbering, ..counter(heading).at(it.location()))
    } else { "" }

    block(below: 2em, width: 100%, breakable: false)[
      #v(5em)
      #text(FontSizeL, weight: "bold")[#it.supplement #num]
      #v(0pt)
      #text(FontSizeXL, weight: "bold")[#it.body]
    ]
  }

  body
}
