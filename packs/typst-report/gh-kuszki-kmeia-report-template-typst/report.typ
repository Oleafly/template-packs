#import "@preview/hydra:0.6.2": hydra
#import "@preview/unify:0.7.1": num, qty, unit
#import "@preview/zero:0.6.1": ztable, format-table, set-num, set-round
  
#import "@preview/codly-languages:0.1.1": *
#import "@preview/codly:1.3.0": *

#import "@preview/cetz-plot:0.1.3": plot, chart
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/lilaq:0.5.0" as lq

#let setup(body,

  title: "Sprawozdanie z ćwiczenia",

  field: "Kierunek studiów",
  study: "Kod studiów / Semestr",
  subject: "Kod",
  section: "Grupa / Sekcja",
  date: "Data wykonania ćwiczenia",
  year: "Rok akademicki",

  topic: "Nazwa ćwiczenia",
  foreman: "Prowadzący ćwiczenie",
  lab: "Laboratorium Metrologii",
  institute: "Nazwa jednostki",
  
  bibfile: none,
  bibstyle: "ieee",
  headstyle: "default",
  margin: 1.75cm,

  font-sans: "Latin Modern Sans",
  font-mono: "Latin Modern Mono",
  font-math: "Latin Modern Math",
  font-size: 12pt,
  
  authors: ( ("Gal Anonim"), ),

  
) = {

  let font-tiny = (9/12)*font-size
  let font-small = (11/12)*font-size
  let font-huge = (20/12)*font-size
  let font-large = (17/12)*font-size
  let font-big = (14/12)*font-size
  
  let header() = if headstyle == "compact" {}
  else {
    let n = counter(page).get().at(0)
    let N = counter(page).final().at(0)

    set text(weight: "bold", size: font-small)
    
    block(height: 100% - margin, width: 100%, 
      grid(
        align: center + horizon,
        columns: (1fr, 3.75cm),
        rows: (1fr, 1fr),
        stroke: black,
        upper(institute), [#subject],
        upper(lab), [Strona #n z #N],
      )
    )
  }

  let footer() = if headstyle == "compact" {
    let n = counter(page).get().at(0)
    let N = counter(page).final().at(0)

    align(center)[Strona #n z #N]
  } else {}

  let margins = if headstyle == "compact" { 
    (bottom: 0.5cm + margin, top: 0.5cm + margin, rest: margin) 
  } else { 
    (top: 4.0cm + margin, rest: margin) 
  }

  show heading: set text(weight: "bold", size: font-size)
  show heading.where(level: 1): set text(size: font-big)
  
  show heading.where(level: 1): set block(above: font-large, below: font-large)
  show heading.where(level: 2): set block(above: font-big, below: font-big)
  show heading.where(level: 3): set block(above: font-size, below: font-size)

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)

  show math.equation: set text(font: font-math) 
  show raw: set text(font: font-mono, size: font-size)
  
  show figure.caption: set align(center)
  show figure.caption: it => block[
    #strong[#it.supplement~#it.counter.display(it.numbering)#it.separator]~#it.body
  ]

  show link: set text(blue)

  show: codly-init.with()

  set math.equation(numbering: "(1)")
  
  set document(
    title: title,
    author: authors.join(", "),
    description: topic,
    keywords: "sprawozdanie",
  )

  set text(
    font: font-sans,
    size: font-size,
    lang: "pl",
    hyphenate: false,
  )
  
  set page(
    paper: "a4",
    margin: margins,
    numbering: "1",
    header: context header(),
    footer: context footer(),
    header-ascent: font-huge,
    footer-descent: font-huge,
  )

  set par(
    justify: true,
    spacing: 1.25em,
    leading: 0.75em,
    first-line-indent: 32pt,
  )

  set heading(
    numbering: "1.",
  )

  set figure(
    numbering: "1",
    gap: font-size,
  )

  set table(
    inset: 6pt,
    stroke: 0.666pt,
  )

  set bibliography(
    style: bibstyle,
    full: false,
  )

  set ref(
    supplement: none,
  )

  set-num(
    product: math.dot, 
    decimal-separator: ",",
    tight: true,
  )

  codly(
    number-format: (n) => align(right, text(size: 0.65em, str(n))),
    enabled: true,
    zebra-fill: none, 
    stroke: none,
    display-name: false,
    smart-indent: true,
  )
    
  page({    
    set par(spacing: font-size, first-line-indent: 0pt)
    set align(top + center)

    table(
      align: center + horizon,
      columns: (auto, auto),
      stroke: none,
      inset: font-size,
      column-gutter: 5*font-huge,
      table.cell(rowspan: 5, {
        par(authors.join("\n"))
        text(size: font-tiny)[Nazwisko i imię studenta]
      }),
      par(date) + text(size: font-tiny)[Data wykonania ćwiczenia],
      par(field) + text(size: font-tiny)[Kierunek],
      par(study) + text(size: font-tiny)[Kod studiów / semestr],
      par(section) + text(size: font-tiny)[Grupa / Sekcja],
      par(year) + text(size: font-tiny)[Rok akademicki],
    )
    v(48pt)
    text(size: font-large, weight: "bold", title)
    v(32pt)
    par(topic)
    text(size: font-tiny)[Nazwa ćwiczenia]
    v(32pt)
    par(foreman)
    text(size: font-tiny)[Prowadzący ćwiczenie]
    v(1fr)
    table(
      align: center + horizon,
      columns: (auto, auto),
      stroke: none,
      inset: font-tiny,
      column-gutter: 5*font-huge,
      repeat("."), repeat("."),
      text(size: font-tiny)[Data przyjęcia sprawozdania],
      text(size: font-tiny)[Ocena / Podpis],
    )
    v(16pt)
  })

  {
    body
  } 

  if bibfile != none {
    bibliography(bibfile, full: true)
  }
  
  }

}
