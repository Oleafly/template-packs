#import "@preview/catppuccin:1.0.1": catppuccin, flavors, get-flavor
#import "@preview/codelst:2.0.2": *

#let code-block-label = "Kód"

#let configure-document(body) = {

  // font a jazyk
  set text(font: "New Computer Modern", lang: "cs")
  
  // rozložení stránky
  set page(
    margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 25mm),
    numbering: "1",
    number-align: center,
  )

  // globální nastavení, které se předává do projektu
  set  text(size: 11pt)                                      // velikost písma
  set  heading(numbering: "1.1")                             // číslování nadpisů
  show heading: set block(below: 2em, above: 2.5em)          // mezery u nadpisů
  show heading: set text(weight: "extrabold", size: 18pt)    // nastavení pro nadpisy
  set  par(justify: true, spacing: 1.8em, leading: 8pt)      // nastavení pro odstavce
  show enum: set block(above: 2em, below: 2em, spacing: 2em) // mezery u číslovaných seznamů
  set  enum(spacing: 1.8em)                                  // mezery mezi položkami v číslovaných seznamech
  set  list(spacing: 1.8em)                                  // mezery mezi položkami v nečíslovaných seznamech

  body
}

#let h1-pagebreak = state("h1-pagebreak", true)
#let h1-reset = state("h1-reset", true)

#let configure(body) = {
  
  // nadpisy
  show heading.where(level: 1): smallcaps         // kapitalky u nadpisů 1. úrovně
  show heading.where(level: 1): it => {
    context {
      if h1-reset.get() {
        counter(figure.where(kind: image)).update(0)  // reset číslování obrázků
        counter(figure.where(kind: table)).update(0)  // reset číslování tabulek
        counter(figure.where(kind: "code")).update(0) // reset číslování kódových bloků
        counter(math.equation).update(0)              // reset číslování rovnic
      }
      
      if h1-pagebreak.get() {
        pagebreak(weak: true)
      }
    }
    it
  }

  // velikost nadpisů
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 14pt)
  show heading.where(level: 4): set text(size: 12pt)

  // cislovani 
  set figure(numbering: (..nums) => {
    let chapter = counter(heading.where(level: 1)).get().at(0)
    if chapter > 0 {
      numbering("1.1", chapter, ..nums)
    } else {
      numbering("1", ..nums)
    }
  })
  set math.equation(numbering: (..nums) => {
    let chapter = counter(heading.where(level: 1)).get().at(0)
    if chapter > 0 {
      numbering("(1.1)", chapter, ..nums)
    } else {
      numbering("(1)", ..nums)
    }
  })
  page(numbering: none)[
    #outline(depth: 3, indent: auto)
  ]

  // --- Main Body ---
  set page(numbering: "1")
  counter(page).update(1)

  // Nastavení pro kódové bloky
  let latte = get-flavor("latte").colors
  let mocha = get-flavor("mocha").colors
  
  show raw: set text(font: ("Consolas", "JetBrainsMono NF NL", "JetBrainsMono NF", "JetBrains Mono", "Ubuntu Mono"))
  show raw: set text(size: 8.5pt)
  
  show raw.where(block: false): it => box(
    fill: latte.mantle.rgb,
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    text(fill: latte.text.rgb, it)
  )
  
  show raw.where(block: true): it => {
    set raw(theme: "Themes/Catppuccin/latte.tmTheme")
    sourcecode(
      it,
      numbers-style: n => text(fill: latte.text.rgb, n),

      frame: it => {
        code-frame(
          fill: latte.mantle.rgb,
          text(fill: latte.text.rgb, it)
        )
      }
    )
  }

  show figure.where(kind: "code"):  set figure(supplement: [Kód])
  show figure.where(kind: "image"): set figure(supplement: [Obrázek])
  show figure.where(kind: "table"): set figure(supplement: [Tabulka])

  // Nastavení pro popisky
  show figure.caption: set text(size: 9pt)
  
  // Zobrazovat u odkazů pouze číslo
  show ref: it => {
    let el = it.element
    if el != none and el.func() == figure {
      link(
        el.location(), 
        numbering(el.numbering, ..counter(figure.where(kind: el.kind)).at(el.location()))
      )
    } 
    else if el != none and el.func() == math.equation {
      let loc = el.location()
      let chapter = counter(heading.where(level: 1)).at(loc).at(0)
      let nums = counter(math.equation).at(loc)
      link(
        loc, 
        if chapter > 0 {
          numbering("1.1", chapter, ..nums)
        } 
        else {
          numbering("1", ..nums)
        }
      )
    }
    else {
      it
    }
  }
  
  // zobrazovat header tabulek tučně a zarovnaný na střed
  show table.cell.where(y: 0): i => align(center, text(i, weight: "bold"))
  show table.cell: i => align(left, text(i))

  // zobrazovat popisky tabulek nahoře
  show figure.where(kind: "table"): set figure.caption(position: top)

  

  body
}  