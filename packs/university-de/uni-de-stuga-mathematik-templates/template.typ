#import "lib/theorems.typ": *

#let _locales = (
  de: json("locales/de.json"),
  en: json("locales/en.json"),
)

#let thesis(
  authors: (),
  title: "",
  supervisors: (),
  semester: "",
  abstract: none,
  language: "de",
  date: datetime.today(),
  degree: "Bachelor",
  courseOfStudy: "mathematics",
  body,
) = {
  let locale = _locales.at(language)

  let div = 10
  let bcor = 0.5cm
  let pw = 21.0cm
  let ph = 29.7cm
  let effective-width = pw - bcor
  let h-strip = effective-width / div
  let v-strip = ph / div

  set text(font: "New Computer Modern", lang: language)
  set par(justify: true)
  set heading(numbering: "1.1")
  show: thmrules.with(qed-symbol: $square$)
  set document(title: title)

  let headings-on-odd-page(it) = {
    show heading.where(level: 1): it => {
      {
        set page(header: none, numbering: none)

        pagebreak(to: "odd")
      }

      it
    }

    it
  }

  show heading.where(level: 1): it => {
    v(3cm)

    set text(size: 1.5em)

    it

    v(1.5em)
  }

  show: headings-on-odd-page

  show outline.entry.where(level: 1): it => {
    v(1.2em, weak: true)
    strong(it)
  }
  set outline.entry(fill: none)

  page(
    background: place(dx: 11.4mm, dy: 11.4mm)[
      #image("./images/UHB_Logo_4c.svg", height: 18.5mm)
    ],
    margin: (top: 1in, bottom: 1in, right: 1.5in, left: 1.5in),
    numbering: none,
  )[
    #v(5%)
    #align(center)[
      #stack(dir: ttb, spacing: 3em)[#line(length: 100%)][
        #text(size: 2em, weight: "bold", title)
      ][
        #text(
          size: 1.5em,
          locale.titlepage.subtitle.at(lower(degree)).at(lower(courseOfStudy)),
        )
      ][#line(length: 100%)]
    ]
    #v(5%)
    #align(center)[
      #stack(spacing: 1em)[
        #strong(locale.titlepage.submitted)
      ][
        #if type(authors) == array {
          authors.map(a => a.name).join(", ")
        } else { authors.name }][
        #if type(authors) == array {
          authors.map(a => link("mailto:" + str(a.email))).join(", ")
        } else { link("mailto:" + str(authors.email)) }][
        #v(1em)
        #strong(locale.titlepage.supervisor)][
        #supervisors.join("\n")]
    ]
    #align(center + horizon)[
      #stack(spacing: 1em)[
        #locale.titlepage.faculty 3][
        #locale.titlepage.uni][
        #semester][
        #date.display("[day].[month].[year]")
      ]
    ]
  ]

  set page(
    numbering: "I",
    margin: (
      top: v-strip,
      bottom: v-strip * 2,
      inside: h-strip + bcor,
      outside: h-strip * 2,
    ),
    binding: left,
  )
  counter(page).update(0)

  if abstract != none {
    show heading: set heading(numbering: none)
    align(center)[#heading(level: 1)[ABSTRACT]]
    abstract
  }

  outline()

  {
    set page(numbering: none)
    pagebreak(to: "odd", weak: true)
  }
  counter(page).update(1)
  //   footer: contex
  set page(
    numbering: "1",
  )

  body
}

#let main-style = {
  let div = 10
  let bcor = 0.5cm
  let pw = 21.0cm
  let ph = 29.7cm
  let effective-width = pw - bcor
  let h-strip = effective-width / div
  let v-strip = ph / div

  context set text(font: "New Computer Modern")
  set par(justify: true)
  set heading(numbering: "1.1")
  show: thmrules.with(qed-symbol: $square$)
  set page(
    numbering: "1",
    margin: (
      top: v-strip,
      bottom: v-strip * 2,
      inside: h-strip + bcor,
      outside: h-strip * 2,
    ),
    binding: left,
  )

  let headings-on-odd-page(it) = {
    show heading.where(level: 1): it => {
      {
        set page(header: none, numbering: none)

        pagebreak(to: "odd")
      }

      it
    }

    it
  }

  show heading.where(level: 1): it => {
    v(3cm)

    set text(size: 1.5em)

    it

    v(1.5em)
  }

  show: headings-on-odd-page
}

