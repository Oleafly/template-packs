#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/glossarium:0.5.10": make-glossary, print-glossary, register-glossary

#let thesis(
  name: "Název maturitní práce",
  major: "Informační technologie",
  class: "ITB4",
  year: 2025,
  author: "Jméno Příjmení",
  abstract-cs: [
    Tvorba maturitní práce je jedním z velmi klíčových momentů při studiu. Kvalita zpracování její formální části je pak jedním z nejdůležitějších kritérií při jejím hodnocení. Cíl této práce je popsat jednotlivé kroky během tohoto procesu, doporučit postupy a vytvořit šablonu, která usnadní celý proces.
  ],
  abstract-en: [
    The creation of a graduation thesis is one of the most crucial moments during studies. The quality of the processing of its formal part is then one of the most important criteria in its evaluation. The aim of this work is to describe the individual steps during this process, recommend procedures and create a template that will facilitate the entire process.
  ],
  keywords-cs: [
    maturitní práce, šablona
  ],
  keywords-en: [
    graduation thesis, template
  ],
  acknowledgements: [
    Děkuji Mgr. Petru Novotnému za cenné připomínky a rady, které mi poskytl při vypracování maturitní práce.
  ],
  assignment: [
    Zadání maturitní práce je přílohou této práce.
  ],
  declaration: [
    Prohlašuji, že jsem tuto práci vypracoval/a samostatně a uvedl/a v ní všechny prameny, literaturu a ostatní zdroje, které jsem použil/a.
  ],
  dictionary: (),
  date: "15. května 2024",
  body: [],
) = {
  show: codly-init.with()
  show: make-glossary

  register-glossary(dictionary)

  codly(languages: codly-languages, zebra-fill: none, display-icon: false, display-name: false)

  set page(
    paper: "a4",
    margin: (
      left: 4cm,
      right: 2.5cm,
      top: 3cm,
      bottom: 3cm,
    ),
  )

  set text(font: "Times New Roman", size: 12pt, lang: "cs", hyphenate: false)
  show heading: set block(below: 20pt, above: 20pt)
  show math.equation: set text(size: 16pt)
  set figure(gap: 1.5em)
  show figure: set block(below: 16pt, above: 16pt)
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.caption: set text(size: 11pt, style: "italic")
  set par(leading: 1em, spacing: 0.75em + 18pt, justify: true)
  show heading.where(level: 1): set text(size: 20pt, weight: "bold")
  show heading.where(level: 2): set text(size: 16pt, weight: "bold")
  show heading.where(level: 3): set text(size: 14pt, weight: "bold")
  show figure.where(kind: "raw"): set figure(supplement: "Výpis")
  set align(center)

  grid(
    columns: 2,
    align: horizon,
    column-gutter: 0.5cm,
    [
      #image("assets/logo.svg", width: 1.77in)
    ],
    [
      #text(
        "Střední průmyslová škola Třebíč",
        size: 16pt,
        font: "Arial",
        weight: "bold",
        fill: rgb("#1F3864"),
      )
    ],
  )

  set align(center + horizon)

  heading(level: 3, outlined: false, [Maturitní práce])
  heading(level: 2, outlined: false, [#upper(name)])
  heading(level: 3, outlined: false, [Profilová část maturitní zkoušky])

  set align(left + bottom)

  table(
    columns: 2,
    stroke: none,
    [
      #text("Studijní obor:")
    ],
    [
      #text(major)
    ],

    [
      Třída:
      #text(class)
    ],
    [],

    [
      Školní rok:
    ],
    [
      #text(str(year))
      #text(author)
    ],
  )

  pagebreak()

  set align(left + top)

  heading(level: 1, outlined: false, [Zadání práce])

  assignment

  pagebreak()

  heading(level: 1, outlined: false, [ABSTRAKT])

  abstract-cs
  heading(level: 1, outlined: false, [KLÍČOVÁ SLOVA])

  keywords-cs

  heading(level: 1, outlined: false, [ABSTRACT])
  abstract-en

  heading(level: 1, outlined: false, [KEYWORDS])

  keywords-en

  pagebreak()

  heading(level: 1, outlined: false, [PODĚKOVÁNÍ])

  acknowledgements

  v(12pt)

  [V Třebíči dne #{ date }]
  set align(right)
  [Podpis autora]

  set align(left + bottom)

  heading(level: 1, outlined: false, [PROHLÁŠENÍ])

  declaration

  v(12pt)

  [V Třebíči dne #{ date }]

  set align(right)
  [Podpis autora]

  pagebreak()

  set align(left + top)

  [
    #show (
      outline
        .entry
        .where(
          level: 1,
        )
        .or(
          outline.entry.where(level: 2),
        )
    ): it => {
      strong(it)
    }


    #outline(depth: 3)
  ]

  set page(footer: context [
    #set align(center)
    #set text(size: 10pt)
    #counter(page).display("1")
  ])

  body

  pagebreak()

  set par(leading: 0.75em, spacing: 0.75em + 6pt, justify: true)

  bibliography("works.bib", title: "Seznam použité literatury", style: "iso690-2022.csl")

  pagebreak()

  outline(
    title: heading(level: 1, outlined: true, [Seznam obrázků]),
    target: figure.where(kind: image),
  )

  pagebreak()

  outline(
    title: heading(level: 1, outlined: true, [Seznam tabulek]),
    target: figure.where(kind: table),
  )

  pagebreak()

  outline(
    title: heading(level: 1, outlined: true, [Seznam výpisů]),
    target: figure.where(kind: raw),
  )

  pagebreak()

  heading(level: 1, outlined: true, [Seznam zkratek a symbolů])

  print-glossary(show-all: true, dictionary)
}
