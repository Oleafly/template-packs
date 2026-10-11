// ATOM brief report template
// Target compiler: Typst 0.15.1

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let navy = rgb("#142B72")
#let blue = rgb("#2458B8")
#let ink = rgb("#18213D")
#let muted = rgb("#626B80")
#let guide-fill = rgb("#F2F6FF")
#let guide-stroke = rgb("#A9BCEB")
#let warning-fill = rgb("#FFF7E6")
#let warning-stroke = rgb("#E8B35D")

#let fallback(value, placeholder: [No indicado]) = {
  if value == none { placeholder } else { value }
}

#let repository-value(repository) = {
  if repository == none {
    [No indicado]
  } else {
    link(repository)[#repository]
  }
}

#let section-guide(expected-pages, body) = block(
  width: 100%,
  breakable: false,
  fill: guide-fill,
  stroke: 0.8pt + guide-stroke,
  radius: 5pt,
  inset: 10pt,
)[
  #set text(size: 9pt, fill: ink)
  *Guía de extensión: #expected-pages;.* #body
]

#let draft-warning(body) = block(
  width: 100%,
  breakable: false,
  fill: warning-fill,
  stroke: 0.8pt + warning-stroke,
  radius: 5pt,
  inset: 10pt,
)[
  #set text(size: 9pt, fill: ink)
  *Antes de entregar:* #body
]

#let atom-report(
  title: [Informe breve],
  assignment: [Tarea],
  authors: (),
  course: [Algoritmos y Técnicas de Optimización Metaheurística],
  institution: [Universidad de Chile],
  instructor: none,
  submission-date: datetime.today(),
  repository: none,
  commit: none,
  keywords: (),
  body,
) = {
  set document(
    title: title,
    author: authors,
    description: [Informe experimental breve del curso #course;.],
    keywords: keywords,
    date: submission-date,
  )

  set text(
    lang: "es",
    region: "CL",
    size: 10.5pt,
    fill: ink,
  )
  set par(
    justify: true,
    leading: 0.72em,
  )
  set page(
    paper: "a4",
    margin: (
      x: 2.35cm,
      top: 2.2cm,
      bottom: 2.25cm,
    ),
  )
  set heading(numbering: "1.1")
  set figure(gap: 0.5em)
  set table(
    inset: 5pt,
    stroke: 0.5pt + rgb("#CAD1E1"),
  )

  show heading.where(level: 1): set text(
    size: 16pt,
    weight: "bold",
    fill: navy,
  )
  show heading.where(level: 2): set text(
    size: 12pt,
    weight: "bold",
    fill: blue,
  )
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(size: 9pt, fill: muted)
  show link: set text(fill: blue)

  // Enhanced code blocks. The report still uses normal Typst raw blocks.
  show: codly-init.with()
  codly(languages: codly-languages)

  // Cover page. It is intentionally excluded from the body page numbering.
  {
    set page(header: none, footer: none)

    align(center)[
      #v(0.8cm)
      #text(size: 13pt, weight: "semibold", fill: navy)[#course]
      #v(1.8cm)
      #text(size: 27pt, weight: "bold", fill: navy)[#title]
      #v(0.35cm)
      #text(size: 14pt, weight: "semibold", fill: blue)[#assignment]
      #v(1.6cm)

      #align(left)[
        #table(
          columns: (auto, 1fr),
          stroke: none,
          inset: (x: 0pt, y: 4pt),
          [*Integrantes*], [#if authors.len() == 0 { [No indicados] } else { authors.join(", ") }],
          [*Docente*], [#fallback(instructor)],
          [*Repositorio*], [#repository-value(repository)],
          [*Commit*], [#fallback(commit)],
          [*Fecha*], [#submission-date.display("[day]/[month]/[year]")],
        )
      ]

      #v(1fr)
      #text(size: 10pt, fill: muted)[#institution]
    ]

    pagebreak()
  }

  counter(page).update(1)

  set page(
    header: context [
      #set text(size: 8pt, fill: muted)
      #course
      #h(1fr)
      #assignment
    ],
    footer: context [
      #set text(size: 8pt, fill: muted)
      Informe experimental
      #h(1fr)
      Página #counter(page).display("1")
    ],
  )

  body
}
