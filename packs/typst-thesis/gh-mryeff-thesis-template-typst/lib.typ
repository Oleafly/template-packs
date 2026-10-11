// TH Nürnberg thesis template for Typst
// Ported from the public LaTeX template at https://github.com/th-nuernberg/thesis-template
// The goal is to keep the original document structure and visual rhythm while using idiomatic Typst.

#let maybe(value) = if value == none { [] } else { value }

#let copyright-note = [
  Dieses Werk einschließlich seiner Teile ist #strong[urheberrechtlich geschützt].
  Jede Verwertung außerhalb der engen Grenzen des Urheberrechtgesetzes ist ohne Zustimmung des Autors unzulässig und strafbar.
  Das gilt insbesondere für Vervielfältigungen, Übersetzungen, Mikroverfilmungen sowie die Einspeicherung und Verarbeitung in elektronischen Systemen.
]

#let title-page(
  title,
  thesis-type,
  author,
  program,
  student-id,
  faculty: [Fakultät Informatik],
  first-examiner,
  second-examiner,
  advisor: none,
  company: none,
  logo: none,
) = {
  set page(numbering: none, header: none, footer: none)
  set align(center)

  if logo != none {
    image(logo, width: 100%)
    v(1cm)
  }

  text(size: 17pt)[#faculty]
  v(2cm)

  text(size: 25pt, weight: "bold")[#title]
  v(1cm)

  text(size: 14pt)[#thesis-type im Studiengang #program]
  v(1cm)

  text(size: 12pt)[vorgelegt von]
  linebreak()
  text(size: 14pt)[#author]
  v(0.5cm)
  text(size: 9pt)[Matrikelnummer #student-id]

  v(1fr)

  align(center)[
    #table(
      columns: (3.2cm, 8cm),
      inset: (x: 0pt, y: 5pt),
      stroke: none,
      [Erstgutachter:], [#first-examiner],
      [Zweitgutachter:], [#second-examiner],
      if advisor != none { [Betreuer:] }, if advisor != none { [#advisor] },
      if company != none { [Unternehmen:] }, if company != none { [#company] },
    )
  ]

  v(1cm)
  [© #datetime.today().year()]
  v(0.8cm)

  set align(left)
  set text(size: 9pt)
  set par(justify: true)
  copyright-note
}

#let thesis(
  title: [My very fancy thesis title.],
  thesis-type: [Bachelorarbeit],
  author: [Georg Simon Ohm],
  program: [Informatik],
  student-id: [123 4567],
  faculty: [Fakultät Informatik],
  first-examiner: [Prof. Dr. Korbinian Riedhammer],
  second-examiner: [Prof. Dr. Bartosz von Rymon Lipinski],
  advisor: none,
  company: none,
  logo: "figures/ohm-logo.svg",
  keywords: (),
  body,
) = {
  set document(
    title: title,
    author: author,
    keywords: keywords,
  )

  set page(
    paper: "a4",
    margin: (inside: 3.3cm, outside: 2.5cm, top: 3cm, bottom: 2.5cm),
    numbering: "1",
    number-align: right,
  )
  set text(size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")
  set enum(numbering: "1.")
  set block(spacing: 0.65em)
  set raw(tab-size: 3)

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  title-page(
    title,
    thesis-type,
    author,
    program,
    student-id,
    first-examiner,
    second-examiner,
    faculty: faculty,
    advisor: advisor,
    company: company,
    logo: logo,
  )

  pagebreak()
  body
}

#let frontmatter(body) = {
  set page(numbering: "i")
  counter(page).update(1)
  body
}

#let mainmatter(body) = {
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)
  body
}

#let appendices(body) = {
  pagebreak()
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}

#let backmatter(body) = {
  pagebreak()
  set heading(numbering: none)
  body
}

#let listing(caption: none, body) = figure(
  kind: raw,
  supplement: [Listing],
  caption: caption,
)[
  #align(left)[
    #block(
      width: 100%,
      inset: (x: 10pt, y: 8pt),
      stroke: 0.5pt + rgb(170, 170, 170),
    )[
      #body
    ]
  ]
]
