#import "@preview/hydra:0.6.0": hydra, core as hydra-core

#let s5 = (
  // S5 paper, for use in generated PDFs
  paper: (
    width: 165mm,
    height: 240mm,
  ),
  margin: (
    left: 20mm,
    right: 20mm,
    top: 22.5mm,
    bottom: 22.5mm,
  ),
)

// LaTeX sizes (10pt style)
#let font-size = (
  tiny: 6pt,
  scriptsize: 7pt,
  footnotesize: 9pt,
  small: 9pt,
  normalsize: 10pt,
  large: 12pt,
  Large: 14pt,
  LARGE: 17pt,
  huge: 20pt,
  Huge: 25pt,
)

#let format-authors(authors) = {
  if type(authors) == str {
    authors
  } else if authors.len() == 1 {
    authors.at(0)
  } else {
    [TODO: Multiple authors]
  }
}

#let isy = [#smallcaps[isy], Linköpings universitet]
#let ida = [#smallcaps[ida], Linköpings universitet]

/// The main template. It is meant to be used as a "show-everything rule":
///
/// #rect(width: 80%)[
/// ```typst
/// #import "rtthesis.typ": *
///
/// #show: rtthesis.with(
///   ..parameters
/// )
///
/// = Introduction
///
/// Your thesis here
/// ```
/// ]
///
/// - title (string): The title of the thesis.
/// - display-title (content, none): The title of the thesis with custom markup (for front page).
///
///   The display title can be used to insert linebreaks in the displayed title.
/// - subtitle (content, none): The subtitle of the thesis.
/// - issn (string, none): The ISSN report number of the thesis.
///   This is given to you by the student's office at the end of your
///   thesis.
/// - authors (string, array): The author or authors of the thesis.
/// - supervisors (array): The supervisors of the thesis work. Supervisors are passed
///   as an array of name and affiliation. There are default affiliations for `isy` and `ida`.
/// - examiner (array): Name and affiliation of the examiner. There are default
///   affiliations for `isy` and `ida`.
/// - date (date): The publication date of the thesis.
/// - main-area (string): The main area ("huvudområde") in which the thesis work is done.
/// - department (string): The department where the thesis work is done.
/// - division (string): The division where the thesis work is done.
/// - abstract (content): #v(0em)
/// - acknowledgements (content, none): Acknowledgments are optional, although they are
///   usually present.
/// - s5-on-a4 (bool): If true, create A4 pages but put the content on S5 and draw edge visualizations.
///
///   Useful for printing drafts and making more room for your margin notes.
/// - liu-logo (content): Image containing the LiU logotype to put on the first page.
/// - font (dictionary): Which font to use in different contexts.
///   - `serif` is used for content.
///   - `sans` is used for headings and defaults to `font.serif` if `none` or omitted.
///   - `first-page` is used for the first page and defaults to `font.sans` if `none` or omitted.
/// - body (content): The main body of the thesis.
#let rtthesis(
  title: "Investigations of a Problem",
  display-title: none,
  subtitle: none,
  issn: none,
  authors: "Lisa Student",
  supervisors: (("Förnamn Efternamn", isy), ("Förnamn Efternamn", "Företag AB")),
  examiner: ("Förnamn Efternamn", isy),
  date: datetime.today(),
  main-area: "Electrical Engineering",
  department: "Department of Electrical Engineering",
  division: "Division of Automatic Control",
  abstract: none,
  acknowledgements: none,
  s5-on-a4: false,
  liu-logo: none,
  font: (
    serif: "Libertinus serif",
    sans: none,
    first-page: none,
  ),
  list-of-figures: true,
  list-of-tables: true,
  list-of-listings: true,
  body,
) = {
  let base-margin = if s5-on-a4 {
    (
      left: (210mm - s5.paper.width) / 2.0,
      right: (210mm - s5.paper.width) / 2.0,
      top: (297mm - s5.paper.height) / 2.0,
      bottom: (297mm - s5.paper.height) / 2.0,
    )
  } else {
    (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm)
  }

  let offset-margin(margin) = (
    left: margin.left + base-margin.left,
    right: margin.right + base-margin.right,
    top: margin.top + base-margin.top,
    bottom: margin.bottom + base-margin.bottom,
  )

  let serif = font.at("serif", default: "")
  let sans = if font.at("sans", default: none) == none { serif } else { font.sans }
  let first-page = if font.at("first-page", default: none) == none { sans } else { font.first-page }

  set page(..if s5-on-a4 {
    (
      paper: "a4",
      background: [#rect(
          width: s5.paper.width,
          height: s5.paper.height,
          stroke: (dash: "dashed", paint: gray, thickness: 0.5pt),
        )],
    )
  } else {
    (
      width: s5.paper.width,
      height: s5.paper.height,
    )
  })

  show bibliography: set text(size: font-size.normalsize)

  set text(font: serif, size: font-size.normalsize)
  show heading: set text(font: sans)
  show heading.where(level: 1): set heading(supplement: [Chapter])

  show figure.where(kind: table): set figure.caption(position: top)

  // Render first page

  set page(
    margin: offset-margin((
      left: 18mm,
      right: 18mm,
      top: 25mm,
      bottom: 25mm,
    )),
  )
  place(
    top,
    dy: -22.5mm + 10pt,
    {
      set text(font: first-page)
      text(size: 11.5pt)[
        Master of Science Thesis in #main-area
        #linebreak()
        #department, Linköping University, #date.year()
      ]
      v(52mm)
      text(
        size: 30pt,
        if display-title == none {
          title
        } else {
          display-title
        },
      )
      if subtitle != none {
        v(-4mm)
        text(size: 18pt, subtitle)
      }
      v(8mm)
      text(size: 16pt, weight: "bold", format-authors(authors))
    },
  )

  if liu-logo != none {
    place(bottom, dy: 10mm, liu-logo)
  }
  pagebreak()

  // Render second page
  set page(
    margin: offset-margin((
      left: 30mm,
      right: 30mm,
      top: 22.5mm,
      bottom: 22.5mm,
    )),
  )
  {
    v(1fr)

    align(
      center,
      {
        set text(font: serif)
        text()[Master of Science Thesis in #main-area]
        linebreak()
        v(-0.6mm)
        text(weight: "bold", title)
        linebreak()
        format-authors(authors)
        linebreak()
        v(-0.6mm)
        issn
      },
    )

    table(
      columns: (auto, auto),
      column-gutter: 2em,
      stroke: none,
      [Supervisor:],
      supervisors
        .map(supervisor => [
          #text(weight: "bold", supervisor.at(0)) \
          #h(8pt)#supervisor.at(1)
        ])
        .join(linebreak()),

      [Examiner:],
      [
        #text(weight: "bold", examiner.at(0)) \
        #h(8pt)#examiner.at(1)
      ],
    )

    v(1em)

    align(
      center,
      {
        text(style: "italic")[
          #division \
          #department \
          Linköping University \
          SE-581 83 Linköping, Sweden
        ]

        v(1em)

        text()[Copyright #sym.copyright #date.year() #format-authors(authors)]
      },
    )
    pagebreak()
  }

  set page(
    // Normal page margins
    margin: offset-margin((
      left: 20mm,
      right: 20mm,
      top: 22.5mm,
      bottom: 22.5mm,
    )),
    // Front matter footer
    footer: context align(center, counter(page).display("i")),
  )

  set heading(outlined: false)

  if abstract != none {
    heading[Abstract]
    v(0.75em)
    abstract
    pagebreak(weak: true)
  }

  if acknowledgements != none {
    heading[Acknowledgments]
    acknowledgements
    pagebreak(weak: true)
  }

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    box(
      align(right)[
        #v(4em)
        #text(size: 100pt)[#counter(heading).display()]
        #v(-0.5em)
        #line(length: 100%)
        #v(0.25em)
        #text(size: 20pt)[#it.body]
        #v(2em)
      ],
    )
  }
  show heading.where(level: 1, numbering: none): it => {
    pagebreak(weak: true)
    box(
      align(right)[
        #v(4em)
        #line(length: 100%)
        #v(0em)
        #text(size: 20pt)[#it.body]
        #v(2em)
      ],
    )
  }

  show outline.entry.where(level: 1): it => {
    v(14pt, weak: true)
    text(weight: "bold")[#it.body()#h(1fr)#it.page()]
  }
  outline(depth: 2, indent: 10pt)

  show outline.entry: it => {
    box(
      grid(
        columns: (1fr, auto),
        inset: 0.2em,
        align: horizon,
        stroke: 0pt,
        it.body(), it.page(),
      ),
    )
  }

  if list-of-figures {
    heading(numbering: none, level: 2)[List of Figures]
    outline(
      title: none,
      target: figure.where(kind: image),
    )
  }

  if list-of-tables {
    heading(numbering: none, level: 2)[List of Tables]
    outline(
      title: none,
      target: figure.where(kind: table),
    )
  }

  if list-of-listings {
    heading(numbering: none, level: 2)[List of Listings]
    outline(title: none, target: figure.where(kind: raw))
  }

  set heading(outlined: true)
  set page(
    header: context {
      hydra(
        1,
        display: (ctx, it) => {
          hydra-core.display(ctx, it)
          v(-3mm)
          line(stroke: 0.5pt, length: 100%)
        },
      )
    },
    footer: context {
      place(dy: -5pt, line(stroke: 0.5pt, length: 100%))
      align(center, counter(page).display("1"))
    },
  )
  counter(page).update(1)

  body
}

#let appendix(body) = {
  set heading(numbering: "A.1")
  show heading.where(level: 1): set heading(supplement: [Appendix])
  counter(heading).update(0)

  body
}
