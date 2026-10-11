// Stanford PhD Dissertation Template for Quarto/Typst
// Based on requirements from Stanford Student Services and suthesis-2e.sty

// Helper: build a List of Tables/Figures manually so the chapter prefix
// is resolved at each figure's location, not the outline's location.
#let _figure-list(std-kind, quarto-kind, supplement) = context {
  let figs = query(
    figure.where(kind: std-kind).or(figure.where(kind: quarto-kind))
  )
  for fig in figs {
    let loc = fig.location()
    let chapter = state("chapter-number").at(loc)
    let in-appendix = state("in-appendix").at(loc)
    let fig-num = counter(figure.where(kind: fig.kind)).at(loc).first()

    let prefix = if chapter == none or chapter == 0 {
      str(fig-num)
    } else if in-appendix == true {
      numbering("A.1", chapter, fig-num)
    } else {
      numbering("1.1", chapter, fig-num)
    }

    let caption-body = if fig.caption != none { fig.caption.body } else { [] }
    let page-num = counter(page).at(loc).first()

    block(spacing: 0.65em)[
      #link(loc)[
        #supplement~#prefix
        #h(0.5em)
        #caption-body
        #box(width: 1fr, repeat[.])
        #h(0.5em)
        #page-num
      ]
    ]
  }
}

#let thesis(
  // Required parameters
  title: none,
  author: none,
  department: none,

  // Optional parameters with defaults
  degree: "Doctor of Philosophy",
  department-prefix: "Department of",
  submission-month: none,
  submission-year: none,

  // Typography options
  font-size: 12pt,
  font-family: ("Times New Roman", "Libertinus Serif"),
  spacing: 1.3,

  // Optional content
  abstract: none,
  dedication: none,
  acknowledgments: none,
  preface: none,
  abbreviations: none,

  // Lists
  show-toc: true,
  show-lof: true,
  show-lot: true,

  // Section numbering
  section-numbering: "1.1",

  // Heading prefixes
  chapter-prefix: "Chapter ",
  appendix-prefix: "Appendix ",

  // Document body
  body,
) = {
  // ── Page setup ──
  set page(
    paper: "us-letter",
    margin: (
      left: 1.5in,
      right: 1in,
      top: 1in,
      bottom: 1in,
    ),
  )

  // ── Typography ──
  set text(
    font: font-family,
    size: font-size,
    fill: black,
    lang: "en",
    hyphenate: true,
  )

  set par(
    leading: spacing * 0.65em,
    justify: true,
  )

  set document(
    title: title,
    author: author,
  )

  // ── Heading styles ──
  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    // Check if this is a part or appendices divider heading (set by Lua filter)
    let part-num = state("part-number").at(it.location())
    let is-appendices-divider = state("is-appendices-divider").at(it.location()) == true
    if part-num != none and part-num > 0 {
      // Part divider page: centered with "Part I" label
      v(1fr)
      align(center)[
        #text(size: 1.4em, weight: "bold")[Part #numbering("I", part-num)]
        #v(0.3in)
        #text(size: 1.6em, weight: "bold", it.body)
      ]
      v(1fr)
    } else if is-appendices-divider {
      // Appendices divider page: centered
      v(1fr)
      align(center)[
        #text(size: 1.6em, weight: "bold", it.body)
      ]
      v(1fr)
    } else {
      v(0.5in)
      if it.numbering != none {
        // Update chapter number state and reset figure counters
        state("chapter-number").update(counter(heading).at(it.location()).first())
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: "quarto-float-fig")).update(0)
        counter(figure.where(kind: "quarto-float-tbl")).update(0)

        let prefix = if state("in-appendix").at(it.location()) == true {
          appendix-prefix
        } else {
          chapter-prefix
        }
        text(size: 1.2em, weight: "bold",
          prefix + counter(heading).display(it.numbering)
        )
        v(0.15in)
      }
      text(size: 1.4em, weight: "bold", it.body)
      v(0.3in)
    }
  }

  show heading.where(level: 2): it => {
    v(0.3in)
    text(size: 1.2em, weight: "bold", {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.5em)
      }
      it.body
    })
    v(0.15in)
  }

  show heading.where(level: 3): it => {
    v(0.2in)
    text(size: 1.1em, weight: "bold", {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.5em)
      }
      it.body
    })
    v(0.1in)
  }

  // ════════════════════════════════════════════════════
  // TITLE PAGE
  // ════════════════════════════════════════════════════

  set page(numbering: none)

  {
    set text(hyphenate: false)
    v(1in)

    align(center, text(
      size: 1.2 * font-size,
      weight: "regular",
      upper(title),
    ))

    v(1fr)

    align(center, text(
      size: 1.2 * font-size,
      weight: "regular",
      {
        upper("A Dissertation") + linebreak()
        upper("Submitted to the " + department-prefix + " " + department) + linebreak()
        upper("and the Committee on Graduate Studies") + linebreak()
        upper("of Stanford University") + linebreak()
        upper("in Partial Fulfillment of the Requirements") + linebreak()
        upper("for the Degree of") + linebreak()
        upper(degree)
      }
    ))

    v(1fr)

    align(center, text(
      size: 1.2 * font-size,
      weight: "regular",
      {
        upper(author) + linebreak()
        if submission-month != none and submission-year != none {
          upper(submission-month + " " + submission-year)
        }
      }
    ))

    v(0.5in)
  }

  // ════════════════════════════════════════════════════
  // PRELIMINARY PAGES
  // ════════════════════════════════════════════════════

  set page(numbering: "i")
  counter(page).update(4)

  if abstract != none {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, "Abstract")
    abstract
  }

  if preface != none {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, "Preface")
    preface
  }

  if acknowledgments != none {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, "Acknowledgments")
    acknowledgments
  }

  if dedication != none {
    pagebreak(weak: true)
    v(1fr)
    align(center, dedication)
    v(1fr)
  }

  if show-toc {
    pagebreak(weak: true)
    // Style part and appendices divider entries in the TOC
    {
      show outline.entry.where(level: 1): it => {
        let loc = it.element.location()
        let part-num = state("part-number").at(loc)
        let is-appendix-divider = state("is-appendices-divider").at(loc) == true
        if part-num != none and part-num > 0 {
          v(0.5em)
          strong({
            [Part ]
            numbering("I", part-num)
            [ #sym.dash.em ]
            it.body()
            box(width: 1fr, it.fill)
            it.page()
          })
          v(0.25em)
        } else if is-appendix-divider {
          v(0.5em)
          strong({
            it.body()
            box(width: 1fr, it.fill)
            it.page()
          })
          v(0.25em)
        } else {
          it
        }
      }
      outline(
        title: "Contents",
        depth: 3,
        indent: auto,
      )
    }
  }

  if show-lot {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: false, "List of Tables")
    _figure-list(table, "quarto-float-tbl", "Table")
  }

  if show-lof {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: false, "List of Figures")
    _figure-list(image, "quarto-float-fig", "Figure")
  }

  if abbreviations != none {
    pagebreak(weak: true)
    align(center, text(size: 1.4em, weight: "bold", "List of Abbreviations"))
    v(0.3in)
    abbreviations
  }

  // ════════════════════════════════════════════════════
  // MAIN BODY
  // ════════════════════════════════════════════════════

  set page(numbering: "1")
  counter(page).update(1)
  set page(
    number-align: center + bottom,
    header: context {
      // No header on pages where a level-1 heading starts
      let here-page = counter(page).at(here())
      let ch-starts = query(heading.where(level: 1))
        .filter(h => counter(page).at(h.location()) == here-page)
      if ch-starts.len() > 0 { return }

      let elems = query(selector(heading.where(level: 1)).before(here()))
      if elems.len() > 0 {
        let current = elems.last()
        set text(size: 0.9em)
        emph({
          if current.numbering != none {
            let prefix = if state("in-appendix").at(current.location()) == true {
              appendix-prefix
            } else {
              chapter-prefix
            }
            prefix
            numbering(current.numbering, ..counter(heading).at(current.location()))
            [. ]
          }
          current.body
        })
        h(1fr)
        counter(page).display()
      }
    },
  )

  set heading(numbering: section-numbering)
  state("in-appendix").update(false)
  state("chapter-number").update(0)
  state("part-number").update(0)
  state("is-appendices-divider").update(false)

  set figure(
    placement: auto,
    numbering: it => context {
      let chapter = state("chapter-number").get()
      if chapter == none or chapter == 0 {
        str(it)
      } else if state("in-appendix").get() == true {
        numbering("A.1", chapter, it)
      } else {
        numbering("1.1", chapter, it)
      }
    },
  )
  show figure: set block(breakable: false)
  show figure.caption: it => {
    set text(size: 0.95em)
    it
  }

  body
}
