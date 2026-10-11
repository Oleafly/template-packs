#import "@preview/latexlike-report:1.0.0": *

#let doc-style = latexlike-report.with(
  author: "Fabian Smith",
  title: [Exam preparation],
  subtitle: [12105 Quantitative methods to assess sustainability],
  participants: [],
  affiliation: [DTU Compute],
  year: [2025],
  class: [Computer Science and Engineering],
  other: none,
  date: [#datetime.today().display()],
  logo: image("../assets/images/dtu-logo-red.png", width: 14%),
  theme-color: rgb("#0f2787"),
  lang: "en",
  participants-supplement: "Authors:",
  title-font: "New Computer Modern",
  font: "New Computer Modern",
  font-size: 12pt,
  font-weight: 400,
  math-font: "New Computer Modern Math",
  math-weight: 400,
  math-ref-supplement: auto,
  math-numbering: "(1.1)",
  math-number-mode: "label",
  math-sub-numbering: true,
  pagebreak-section: true,
  show-outline: true,
  page-paper: "a4",
  h-l: context {
    let headings = query(heading.where(level: 1))
    let loc = here()
    let before = headings.filter(h => h.location().page() <= loc.page())
    if before.len() > 0 {
      smallcaps(before.last().body)
    }
  },
  h-r: [#image("../assets/images/dtu-logo-red.png", width: 14%)],
  h-c: none,
  f-l: [],
  f-r: [],
  f-c: chic-page-number(),
)

#let appendix(paths) = {
  set heading(numbering: "A.1", supplement: [Appendix])
  counter(heading).update(0)

  set page(numbering: "I")
  counter(page).update(1)

  set page(
    footer: context {
      line(length: 100%, stroke: 0.6pt)
      align(center, counter(page).display())
    },
    header: none,
  )
  show heading: it => {
    set text(11pt, weight: 400)
    set align(center)
    show: block.with(above: 15pt, below: 13.75pt, sticky: true)
    show: smallcaps
    [#it.supplement #counter(heading).display()]
    linebreak()
    it.body
  }
  for path in paths {
    pagebreak()
    path
    include (path)
  }
}

