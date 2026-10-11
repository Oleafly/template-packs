#let primary-color = rgb("#f00024")

#let fmt(number, precision: 3,  sci: true) = {
  if number == 0 {
    return $0$
  }

  let multiplier = calc.pow(10.0, precision)
  if sci==false {
    let result = calc.floor(number * multiplier) / multiplier
    return str(result).replace(".", ",")
  }

  let expoent = calc.floor(calc.ln(calc.abs(number)) / calc.ln(10))

  let coefficient = number / (calc.pow(10.0, expoent))

  let rounded-coefficient = calc.round(coefficient * multiplier) / multiplier

  let coefficient-str = str(rounded-coefficient).replace(".", ",")

  if expoent == 0 {
    return $#coefficient-str$
  }

  let expoent-str = str(expoent).replace(".", ",")
  
  return $#coefficient-str dot 10^(#expoent-str)$
}


#let mkcover(book-title, book-author, author, primary-color) = [
  #set page(margin:20pt, fill: white)
  #set text(size: 24pt, font: "Arial", weight: "bold", fill: black)
  #set align(center)
  #place(
    bottom+right,
    dx: 25pt, dy: 60pt,
    float: false,
  )[#image("assets/images/cover.svg", width: 110%)]
  #table(
    columns: (auto, 1fr),
    inset: 0pt, stroke: none, 
    align: (left+horizon, right+horizon),
    table.header(
      [#image("assets/images/logo.svg", width: 2.5cm)],
      [#author]
    )
  )

  #upper[
    #text(size: 14pt, weight: 500)[Resolução Comentada dos Exercícios de]\
    #text(size: 24pt, weight: 700, fill: primary-color)[#book-title]\
    #text(size: 16pt, weight: 500)[de]\
    #text(size: 20pt, weight: 700, fill: primary-color)[#book-author]
  ]
]

#let mkfrontpage(book-title, book-author, author, primary-color) = [
  #set page(margin:2cm, fill: white)
  #set text(size: 12pt, font: "Arial", fill: black)
  #align(center)[
    #image("assets/images/logo.svg", width: 2cm)
    #text(size: 20pt, weight: "bold")[#author]
  ]
  #place(
    bottom+center,
    float: false
  )[
    Resolução Comentada de Exercícios
    #rect(width: 100%, height: 1pt, fill: primary-color)
    #grid(
      columns: (1fr, auto),
      column-gutter: 15pt,
      align: (left+bottom, right+horizon),
      [
        #cite(<Halliday2>, form: "full")
      ],
      [
        #image("assets/images/capa.png", width: 3cm)
      ]
    )
    #rect(width: 100%, height: 1pt, fill: primary-color)   
  ]
]

#let mkcontents() = [
  #show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(upper(it))
  }

  #outline(indent: 0pt, title: upper([Sumário]))

  #pagebreak()
]

#let custom-headings(it) = [
  #let level = it.level
  #set align(left)
  #set text(weight: "semibold", fill: primary-color, size: 12pt)
  #set par(first-line-indent: 0pt)
  #if level == 1 {
    set text(size: 16pt)
    upper(text(it))
    v(-12pt)
    line(length: 100%, stroke: 1pt + primary-color)
  } else {
    v(8pt)
    text(it)
  }
  #v(12pt)
]

#let solution(body) = {
  set par(first-line-indent: 0pt)
  box(
    stroke: 1pt+primary-color,
    radius: 3pt,
    width: 2cm, height: 0.6cm
  )[
    #set align(center+ horizon)
    #text(weight: "medium", fill: primary-color)[Solução]
  ]
  

  linebreak()
  linebreak()
  
  body

  align(right)[
    #h(1fr)
    #rect(width: 8pt, height: 8pt, fill: primary-color)
  ]
}


#let template(
  book: (
    title: none,
    author: (
      long: none,
      short: none
    )
  ),
  author: none,
  frontpage-input: none,
  body
) = {
  set page(
    paper: "a4",
    margin: (
      top: 3cm, bottom: 2cm, left: 2cm, right: 2cm
    ),
  )

  set text(
    font: "Arial", size: 12pt, lang: "pt", hyphenate: false
  )

  set par(
    first-line-indent: (
      all: true, amount: 1.25cm
    ),
    justify: true
  )

  set heading(numbering: "1.1.")

  mkcover(book.title, book.author.long, author, primary-color)

  counter(page).update(1)

  mkfrontpage(book.title, book.author.long, author, primary-color)

  mkcontents()
  pagebreak()


  set page(
    header: context {
      let current-page = counter(page).get().at(0)
      rect(width: 100%, stroke: (bottom: (thickness: 1pt, paint: primary-color)))[
        #if calc.even(current-page) [
          #counter(page).get().at(0)
          #h(1fr)
          #author
        ] else [
          Solucionário / *#book.title (#book.author.short)*
          #h(1fr)
          #counter(page).get().at(0)
        ]
      ]
    },
    footer: context {
      let current-page = counter(page).get().at(0)
      rect(width: 100%, stroke: (top: (thickness: 1pt, paint: primary-color)))[
        #if calc.even(current-page) {
          grid(
            columns: (auto, 1fr),
            align: (left+horizon, right+horizon),
            [#image("assets/images/logo.svg", width: 0.8cm)],
            [#link("https://costandrad.github.io/")[costandrad.github.io]]
          )
          
        } else {
          grid(
            columns: (auto, 1fr),
            align: (left+horizon, right+horizon),
            [#link("https://costandrad.github.io/")[costandrad.github.io]],
            [#image("assets/images/logo.svg", width: 0.8cm)],
          )
        } 
      ]
    }
  )

  //set math.equation(numbering: "(1)", number-align: bottom)


  // 🧭 Numeração de seções e listas
  set heading(numbering: "1.1.")
  show heading: set text(size: 12pt, fill: primary-color)
  show heading.where(): it => custom-headings(it)
  set list(marker: text(primary-color)[-])
    set enum(
    numbering: it => context {
      let headings = counter(heading).get()
      let sec = headings.at(0)
      if headings.len() > 1 {
        let subsec = headings.at(1)
        strong(text(primary-color)[#sec.#subsec.#it.])
      } else {
        strong(text(primary-color)[#sec.#it.])
      }
  })

  
  body

  set heading(numbering: none)

  bibliography("assets/references/references.bib", style: "assets/references/abnt.csl", title: "Referências")
}