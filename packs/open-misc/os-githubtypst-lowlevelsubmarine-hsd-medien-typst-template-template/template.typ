#let metadata = state("hsd_metadata", ())
#let main_content = state("main_content", false)

#let template(
  title: none,
  sub_title: none,
  author: none,
  type_of_work: none,
  degree_program: none,
  time_of_submission: none,
  examiners: (),
  additional_front_page_content: none,
  citation_style: "american-psychological-association",
  preface: none,
  bibliography_sources: none,
  doc,
) = {
  metadata.update((author: author))

  set text(size: 11pt, font: "arial", top-edge: 1em, hyphenate: true, lang: "de", costs: (
    hyphenation: 200%,
    runt: 100%,
    widow: 100%,
    orphan: 100%,
  ))
  set par(justify: true, linebreaks: "optimized", leading: 0.75em, spacing: 1.5em)

  set bibliography(style: citation_style)

  set footnote.entry(separator: line(length: 5cm, stroke: 1pt), indent: 0pt)

  show heading: it => block({
    set par(leading: 0.4em)
    if (it.numbering != none) {
      counter(heading).display()
      h(0.75em)
    }
    it.body
  })

  show heading.where(level: 1): value => {
    set text(size: 14pt, weight: "bold")
    pagebreak(weak: true)
    pad(bottom: 9pt, value)
  }

  align(right, [
    #image("./logos.png")
    #v(5em)
    #par(justify: false, leading: 1.2em, text(size: 24pt, weight: "bold", title))
    #if sub_title != none [
      #v(1.5em)
      #text(size: 16pt, weight: "bold", sub_title)
    ]
    #v(3em)
    #text(size: 16pt, weight: "bold", author)
    #v(10em)
    #text([#type_of_work im Studiengang])
    #v(3pt)
    #text(weight: "bold", degree_program)
    #v(3pt)
    #text(size: 12pt, weight: "bold", time_of_submission)
    #v(4em)
    #if examiners.len() > 0 [
      Prüfer*innen:
      #v(3.5pt)
      #examiners.join([
        #v(2.5pt)
      ])
    ]
    #additional_front_page_content
  ])
  pagebreak()

  set page(
    margin: (
      top: 2.4cm,
      bottom: 3.7cm,
      left: 4.2cm,
      right: 3cm,
    ),
    header-ascent: 2em,
    header: pad(bottom: 0em, {
      pad(bottom: -9pt, grid(
        columns: (1fr, auto),
        [
          #show linebreak: " "
          #title
        ],
        align(right)[
          Seite
          #context (counter(page).display())
        ],
      ))
      line(length: 100%)
    }),
    footer: text(costs: (hyphenation: 10000%), par(justify: false)[
      #type_of_work, Hochschule Düsseldorf, Fachbereich Medien, #degree_program - #author, #time_of_submission
    ]),
  )

  // exclude header from page counter
  counter(page).update(1)
  set page(numbering: "i")

  preface
  outline(indent: 1em)

  pagebreak()
  counter(page).update(1)
  set page(numbering: "1")
  set heading(numbering: "1.1")

  doc

  counter(heading).update(0)
  set heading(numbering: "I")
  if (bibliography_sources != none) {
    heading[Literaturverzeichnis]
    bibliography(bibliography_sources, title: none)
  }
}

#let eidesstattliche_erklaerung(
  address: none,
  email: none,
) = [
  = Eidesstattliche Erklärung
  Hiermit versichere ich an Eides statt, dass ich diese Arbeit eigenständig verfasst und keine anderen als die angegebenen und bei Zitaten kenntlich gemachten Quellen und Hilfsmittel benutzt habe.

  #v(9em)
  #line(length: 66%)
  Datum, Unterschrift

  #v(11em)
  *Kontaktinformationen*
  #parbreak()
  #context metadata.get().author
  #linebreak()
  #if (address == none) ["address" missing!] else { address }
  #linebreak()
  #if (email == none) ["email" missing!] else { email }
]

#let gender_hinweis(custom_text: none) = {
  [= Genderhinweis]

  if (custom_text != none) { custom_text } else [
    In der vorliegenden Arbeit wird darauf verzichtet, bei Personenbezeichnungen sowohl die weibliche als auch die männliche und diverse Form zu nennen. Das generische Maskulinum adressiert alle Leserinnen und Leser und gilt in allen Fällen, in denen dies nicht explizit ausgeschlossen wird, für alle Geschlechter.
  ]
}
