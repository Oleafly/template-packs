#import "/components/title.typ" : title_block
#import "/components/style.typ"

#let BASE_COLOR = rgb("141414")
#let MAIN_COLOR = rgb("ededed")
#let ACCENT_COLOR = rgb("ff6f61")

#let template(
  title: [],
  subtitle: [],
  author: [],
  affiliation: [],
  contact: [],
  date: datetime(year: 2026, month: 1, day: 1),
  body,
) = {
  show: style.configure.with()

  /* ===== epilogue of the title page ===== */
  /* reset page numbering */
  set page(numbering: "1")
  set heading(numbering: none)

  /* ===== prologue of the title page ===== */
  title_block(
    title: title,
    subtitle: subtitle,
    author: author,
    affiliation: affiliation,
    contact: contact,
    date: date,
  )
  v(2em)

  /* ===== main body ===== */
  body

  /* ===== bibliography ===== */
  // pagebreak()
  bibliography("/resources/references.bib", title: "References")
}
