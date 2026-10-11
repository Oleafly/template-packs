#import "libs.typ": *

#let setup(body,

  type: "Projekt inżynierski",
  place: "Gliwice",
  year: "2026",

  field: "Kierunek studiów",
  spec: "Specjalność",
  
  promoter: "Promotor pracy",
  institute: "Nazwa jednostki",
  department: "Nazwa wydziału",
  
  bibfile: "dodatki/bibliografia.bib",
  bibstyle: "ieee",
  print: false,

  font-sans: "Latin Modern Sans",
  font-roman: "Latin Modern Roman",
  font-mono: "Latin Modern Mono",
  font-math: "Latin Modern Math",
  font-size: 12pt,
  
  authors: (
    (
      name: "Gal Anonim",
      uuid: 123456,
    ),
  ),

  topic-pl: "Tytuł pracy w języku polskim",
  topic-en: "Tytuł pracy w języku angielskim",
  
  abstract-pl: "Treść streszczenia w języku polskim.",
  abstract-en: "Treść streszczenia w języku angielskim.",
  
  keywords-pl: ("słowo kluczowe 1", "słowo kluczowe 2"),
  keywords-en: ("keyword 1", "keyword 2"),
  
) = {

  let authlist = authors.map(a => a.name).join(", ")
  
  let font-huge = (20/12)*font-size
  let font-large = (17/12)*font-size
  
  let chapter-start = state("chapter-start", none)
  let chapter-title = state("chapter-title", "")
  
  let header() = {
    let p = counter(page).get()
    let h = none;
    
    if chapter-start.get() != p {
      if calc.odd(p.at(0)) {
        h = align(left)[Rozdział~#chapter-title.get()]
      } else {
        h = align(right)[#topic-pl]
      }
    }

    if h != none {
      block(h,
        inset: (bottom: 6pt),
        stroke: (bottom: 0.5pt),
        width: 100%,
      )
    }
  }

  let margin = if not print { (rest: 2.5cm) }
  else { (inside: 3cm, outside: 2cm, rest: 2.5cm) }
  
  show heading.where(level: 1): set text(size: 25pt, weight: "bold")
  show heading.where(level: 1): set block(above: 96pt, below: 64pt)
  show heading.where(level: 1): it => pagebreak(weak: true) + v(96pt) + it 

  show heading.where(level: 2): set text(size: 14pt, weight: "bold")
  show heading.where(level: 2): set block(above: 32pt, below: 24pt)

  show heading.where(level: 3): set text(size: 12pt, weight: "bold")
  show heading.where(level: 3): set block(above: 24pt, below: 18pt)

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)

  show math.equation: set block(above: 14pt, below: 14pt)
  show math.equation: set text(font: font-math) 
  
  show raw: set text(font: font-mono, size: font-size)
  
  show figure.caption: set align(left)
  show figure.caption: it => block(width: 100%)[
    #strong[#it.supplement~#it.counter.display(it.numbering)#it.separator]~#emph[#it.body]
  ]

  show: codly-init.with()

  show heading.where(level: 1): it => context {
    let n = counter(heading).display()
    let p = counter(page).get()
    
    chapter-title.update(n + [~] + it.body)
    chapter-start.update(p)
    it
  }
  
  show ref: it => {
    let eq = math.equation
    let el = it.element

    if el == none or el.func() != eq { it }
    else {
        link(el.location(), 
          numbering(el.numbering,
            ..counter(eq).at(el.location())
          )
        )
    }
  }

  set math.equation(numbering: "(1)")
  
  set document(
    title: type,
    author: authlist,
    description: topic-pl,
    keywords: keywords-pl,
  )

  set text(
    font: font-roman,
    size: font-size,
    lang: "pl",
    hyphenate: false,
  )
  
  set page(
    paper: "a4",
    margin: margin,
    numbering: none,
    header: context header(),
  )

  set par(
    justify: true,
    spacing: 24pt,
    leading: 1em,
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

  codly(
    number-format: (n) => align(right, text(size: 0.65em, str(n))),
    enabled: true,
    zebra-fill: none, 
    stroke: none,
    display-name: false,
    smart-indent: true,
  )

  {
    set par(first-line-indent: 0pt)
    set page(
      numbering: "a", 
      footer: none,
      header: none,
    )
    
    page({
      set text(font: font-sans)
      set align(top + center)
      set par(spacing: font-size)
      
      image("obrazki/polsl_logo.png", width: 5.25cm)
      text(weight: "bold", size: font-huge, upper[#type])
      v(25pt)
      text(weight: "bold", size: font-large, [#topic-pl])
      v(15pt)
      for a in authors {
        text(weight: "bold", size: font-large, [#a.name])
        v(1pt)
        text(weight: "bold", size: font-size, [Numer albumu: #a.uuid])
        v(10pt)
      }
      v(10pt)
      table(stroke: none, columns: 2, align: (right, left),
        [#text(weight: "bold", size: font-large, "Kierunek:")], 
        [#text(size: font-large, [#field])],
        [#text(weight: "bold", size: font-large, "Specjalizacja:")], 
        [#text(size: font-large, [#spec])]
      )
      v(20pt)
      text(weight: "bold", size: font-large, upper("Prowadzący pracę"))
      v(1pt)
      text(weight: "bold", size: font-large, [#promoter])
      v(1pt)
      text(weight: "bold", size: font-large, upper[#institute])
      v(1pt)
      text(weight: "bold", size: font-large, upper[#department])
      v(1pt)
      set align(bottom + center)
      text(weight: "bold", size: font-large, upper[#place, #year])
    })

    if print { pagebreak(to: "odd") }
    
    page({
      text(lang: "pl", {
        par[*Tytuł pracy:* #topic-pl]
        par[*Streszczenie:* #abstract-pl]
        par[*Słowa kluczowe:* #keywords-pl.join(", ")]
      })
      v(15pt)
      text(lang: "en", {
        par[*Thesis title:* #topic-en]
        par[*Summary:* #abstract-en]
        par[*Key words:* #keywords-en.join(", ")]
      })
    })

    if print { pagebreak(to: "odd") }

    outline()

    if print { pagebreak(to: "odd") }
  }

  counter(page).update(1)
  
  {
    set page(numbering: "1")
    
    [       #body        ]

    set page(header: none)
    set par(spacing: font-large)
    
    bibliography(bibfile, style: bibstyle)
  }

}
