#import "@preview/codelst:2.0.2": *
#import "acronym-lib.typ": init-acronyms, print-acronyms, acr, acrpl, acrs, acrspl, acrl, acrlpl, acrf, acrfpl
#import "glossary-lib.typ": init-glossary, print-glossary, gls
#import "locale.typ": TABLE_OF_CONTENTS, LIST_OF_FIGURES, LIST_OF_TABLES, CODE_SNIPPETS, APPENDIX, REFERENCES
#import "titlepage.typ": *
#import "confidentiality-statement.typ": *
#import "declaration-of-authorship.typ": *
#import "check-attributes.typ": *
#import "gender-disclaimer.typ": *

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

#let page-numbering-symbols = (
  "1",
  "a",
  "A",
  "i",
  "I",
  "α",
  "Α",
  "*",
  "א",
  "一",
  "壹",
  "あ",
  "い",
  "ア",
  "イ",
  "ㄱ",
  "가",
  "\u{0661}",
  "\u{06F1}",
  "\u{0967}",
  "\u{09E7}",
  "\u{0995}",
  "①",
  "⓵",
)

// // core macro (positional pages)
// #let mycitep(sourceKey, pages) = {
//   cite(label(sourceKey), supplement: [S.~#pages])
// }

// // convenience wrapper for “no pages”
// #let mycite(sourceKey) = {
//   cite(label(sourceKey))
// }

#let myCite(key, ..rest) = {
  // accept pages either as a trailing [block] or as a second positional string
  let pos = rest.pos()
  let pg  = if pos.len() >= 1 { pos.at(0) } else { none }
  let sup = if pg == none { none } else { [S.~#pg] }

  // cite expects a *label*, so convert the string key → label
  cite(label(key), supplement: sup)
}
#let myCiteMisc(key, ..rest) = {
  // accept pages either as a trailing [block] or as a second positional string
  let pos = rest.pos()
  let pg  = if pos.len() >= 1 { pos.at(0) } else { none }
  let sup = if pg == none { none } else { [§~#pg] }

  // cite expects a *label*, so convert the string key → label
  cite(label(key), supplement: sup)
}



#let supercharged-dhbw(
  title: none,
  authors: (:),
  language: none,
  at-university: none,
  confidentiality-marker: (display: false),
  type-of-thesis: none,
  type-of-degree: none,
  show-confidentiality-statement: true,
  show-declaration-of-authorship: true,
  show-gender-disclaimer: true,
  show-table-of-contents: true,
  show-acronyms: true,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-code-snippets: true,
  show-abstract: true,
  numbering-alignment: center,
  toc-depth: 3,
  acronym-spacing: 5em,
  glossary-spacing: 1.5em,
  abstract: none,
  appendix: none,
  acronyms: none,
  glossary: none,
  header: none,
  confidentiality-statement-content: none,
  declaration-of-authorship-content: none,
  help-from-ai-disclaimer-content: none, // relative path to a pdf file as string
  gender-disclaimer-content: none,
  titlepage-content: none,
  university: none,
  university-location: none,
  university-short: none,
  university-declined: none,
  department: none,
  head_of_study_program: none,
  completion_period: (none, none),
  completion_period_format: "[day].[month].[year]",
  submission_date: none,
  submission_date_format: "[day].[month].[year]",
  city: none,
  supervisor: (:),
  date: none,
  date-format: "[day].[month].[year]",
  bibliography: none,
  bib-style: "ieee",
  heading-numbering: "1.1",
  math-numbering: "(1)",
  page-numbering: (preface: "I", main: "1", appendix: "a"),
  logo-left: image("../template/assets/img/dhbw.jpg"),
  logo-right: image("../template/assets/img/brand_logo.png"),
  logo-size-ratio: "1:1",
  ignored-link-label-keys-for-highlighting: (),
  body,
) = {
  // check required attributes
  check-attributes(
    title: title,
    authors: authors,
    language: language,
    at-university: at-university,
    confidentiality-marker: confidentiality-marker,
    type-of-thesis: type-of-thesis,
    type-of-degree: type-of-degree,
    show-confidentiality-statement: show-confidentiality-statement,
    show-declaration-of-authorship: show-declaration-of-authorship,
    show-gender-disclaimer: show-gender-disclaimer,
    show-table-of-contents: show-table-of-contents,
    show-acronyms: show-acronyms,
    show-list-of-figures: show-list-of-figures,
    show-list-of-tables: show-list-of-tables,
    show-code-snippets: show-code-snippets,
    show-abstract: show-abstract,
    header: header,
    numbering-alignment: numbering-alignment,
    toc-depth: toc-depth,
    acronym-spacing: acronym-spacing,
    glossary-spacing: glossary-spacing,
    abstract: abstract,
    appendix: appendix,
    acronyms: acronyms,
    university: university,
    university-location: university-location,
    supervisor: supervisor,
    date: date,
    city: city,
    bibliography: bibliography,
    bib-style: bib-style,
    logo-left: logo-left,
    logo-right: logo-right,
    logo-size-ratio: logo-size-ratio,
    university-short: university-short,
    university-declined: university-declined,
    heading-numbering: heading-numbering,
    math-numbering: math-numbering,
    ignored-link-label-keys-for-highlighting: ignored-link-label-keys-for-highlighting,
    page-numbering: page-numbering,
  )

  // set the document's basic properties
  set document(title: title, author: authors.map(author => author.name))
  let many-authors = authors.len() > 3

  init-acronyms(acronyms)
  init-glossary(glossary)

  // define logo size with given ration
  let left-logo-height = 2.4cm // left logo is always 2.4cm high
  let right-logo-height = 2.4cm // right logo defaults to 2.4cm but is adjusted below
  let logo-ratio = logo-size-ratio.split(":")
  if (logo-ratio.len() == 2) {
    right-logo-height = right-logo-height * (float(logo-ratio.at(1)) / float(logo-ratio.at(0)))
  }

  // save heading and body font families in variables
  let body-font = "Open Sans"
  let heading-font = "Montserrat"

  // customize look of figure
  set figure.caption(separator: [ --- ], position: bottom)

  // set body font family
  set text(font: body-font, lang: language, 12pt)
  show heading: set text(weight: "semibold", font: heading-font)

  // heading numbering
  set heading(numbering: heading-numbering)

  // math numbering
  set math.equation(numbering: math-numbering)

  // set link style for links that are not acronyms
  let acronym-keys = if (acronyms != none) {
    acronyms.keys().map(acr => ("acronyms-" + acr))
  } else {
    ()
  }
  let glossary-keys = if (glossary != none) {
    glossary.keys().map(gls => ("glossary-" + gls))
  } else {
    ()
  }
  show link: it => {
  let dest = str(it.dest)
  let skip = dest == "toc" or dest in (acronym-keys + glossary-keys + ignored-link-label-keys-for-highlighting)
  if skip { it } else { text(fill: blue, it) }
}


  
show heading.where(level: 1): it => {
  let is-ai-disclaimer = query(<ai-disclaimer>)
      .any(x => x.location() == it.location())

  if not is-ai-disclaimer {
    pagebreak()
  }
  v(2em) + it + v(1em)
}

  show heading.where(level: 2): it => v(1em) + it + v(0.5em)
  show heading.where(level: 3): it => v(0.5em) + it + v(0.25em)

  if (titlepage-content != none) {
    titlepage-content
  } else {
    titlepage(
      authors,
      date,
      heading-font,
      language,
      left-logo-height,
      logo-left,
      logo-right,
      many-authors,
      right-logo-height,
      supervisor,
      title,
      type-of-degree,
      type-of-thesis,
      //university,
      university-location,
      at-university,
      date-format,
      show-confidentiality-statement,
      confidentiality-marker,
      university-short,
      university-declined,
      department,
      head_of_study_program,
      completion_period,
      completion_period_format,
      submission_date,
      submission_date_format,
    )
  }

  // set header properties
  let display-header = if (header != none and ("display" in header)) {
    header.display
  } else {
    true
  }

  let header-content = if (header != none and ("content" in header)) {
    header.content
  } else {
    none
  }

  let show-header-chapter = if (header != none and ("show-chapter" in header)) {
    header.show-chapter
  } else {
    true
  }

  let show-header-left-logo = if (header != none and ("show-left-logo" in header)) {
    header.show-left-logo
  } else {
    true
  }

  let show-header-right-logo = if (header != none and ("show-right-logo" in header)) {
    header.show-right-logo
  } else {
    true
  }

  let show-header-divider = if (header != none and ("show-divider" in header)) {
    header.show-divider
  } else {
    true
  }

  set page(
    margin: (top: 8em, bottom: 8em),
    header: [
      #set block(spacing: 0.75em)
      #context {
        if (display-header) {
          if (header-content != none) {
            header.content
          } else {
            grid(
              columns: (1fr, auto),
              align: (left, right),
              gutter: 2em,
              if (show-header-chapter) {
                align(left + bottom)[
                  #let headings = query(heading.where(level: 1))
                  #if headings.len() > 0 and not headings.any(it => (it.location().page() == here().page())) {
                    let elems = query(selector(heading.where(level: 1)).before(here()))

                    if (elems.len() > 0) {
                      let current-heading = elems.last()
                      let heading-counter = if current-heading.numbering == none {
                        none
                      } else {
                        counter(heading).get().first()
                      }

                      [#heading-counter #link(<toc>)[#current-heading.body]]


                    }
                  } else {
                    let elems = query(selector(heading.where(level: 1)).after(here()))

                    if (elems.len() > 0) {
                      let current-heading = elems.first()
                      let heading-counter = if current-heading.numbering == none {
                        none
                      } else {
                        counter(heading).get().first() + 1
                      }

                        [#heading-counter #link(<toc>)[#current-heading.body]]


                    }
                  }
                ]
              },
              stack(
                dir: ltr,
                spacing: 1em,
                if (show-header-left-logo and logo-left != none) {
                  set image(height: left-logo-height / 2)
                  logo-left
                },
                if (show-header-right-logo and logo-right != none) {
                  set image(height: right-logo-height / 2)
                  logo-right
                },
              ),
            )
            if (show-header-divider) {
              line(length: 100%)
            }
          }
        }
      }
    ],
  )

  // set page numbering for preface
  let preface-numbering = "I"
  if ("preface" in page-numbering) {
    preface-numbering = page-numbering.preface
  }

  set page(
    // necessary to apply numbering in the table of contents
    numbering: preface-numbering,
    footer: context {
      let display-total-page-number = preface-numbering.clusters().filter(c => c in page-numbering-symbols).len() >= 2

      align(
        numbering-alignment,
        numbering(
          preface-numbering,
          ..counter(page).get(),
          ..if display-total-page-number {
            counter(page).at(<numbering-preface-end>)
          },
        ),
      )
    },
  )
  counter(page).update(1)

  if (not at-university and show-confidentiality-statement) {
    pagebreak()
    confidentiality-statement(
      authors,
      title,
      confidentiality-statement-content,
      university,
      university-location,
      date,
      language,
      many-authors,
      date-format,
    )
  }

  if (show-declaration-of-authorship) {
    declaration-of-authorship(
      authors,
      title,
      declaration-of-authorship-content,
      date,
      language,
      many-authors,
      at-university,
      city,
      date-format,
    )
  }

  if (help-from-ai-disclaimer-content != none) {
  // Level-1 heading → new page + TOC entry
  [#heading(
  level: 1,
  numbering: none,
  outlined: true,
  )[
    Hilfsmittelangabe zum Einsatz von KI-basierten Werkzeugen
  ]<ai-disclaimer>]
  import "@preview/muchpdf:0.1.2": muchpdf

  muchpdf(
    read(help-from-ai-disclaimer-content, encoding: none),
    width: 90%
  )
}


  if(show-gender-disclaimer) {
    gender-disclaimer(
      gender-disclaimer-content,
      language,
    )
  }

  show outline.entry.where(level: 1): it => {
    v(18pt, weak: true)
    strong(it)
  }

  set par(justify: true, leading: 1em)

  if (show-abstract and abstract != none) {
v(-1em)
    align(center + horizon, heading(level: 1, numbering: none, outlined: true)[Abstract])
    
    context {

      
      // Decrease only the abstract body font size
      //set text(11pt)
      text(abstract)
    }
  }

  set par(leading: 0.65em)

  if (show-table-of-contents) {
    [#outline(
      title: TABLE_OF_CONTENTS.at(language),
      indent: auto,
      depth: toc-depth,
    ) <toc>]
  }

  context {
    let elems = query(figure.where(kind: image))
    let count = elems.len()

    if (show-list-of-figures and count > 0) {
      heading(level: 1, numbering: none, outlined: true)[#LIST_OF_FIGURES.at(language)]
      outline(
        title: none,
        target: figure.where(kind: image),
      )
    }
  }

  context {
    let elems = query(figure.where(kind: table))
    let count = elems.len()

    if (show-list-of-tables and count > 0) {
      heading(level: 1, numbering: none, outlined: true)[#LIST_OF_TABLES.at(language)]
      outline(
        title: none,
        target: figure.where(kind: table),
      )
    }
  }

  context {
    let elems = query(figure.where(kind: raw))
    let count = elems.len()

    if (show-code-snippets and count > 0) {
      heading(level: 1, numbering: none, outlined: true)[#CODE_SNIPPETS.at(language)]
      outline(
        title: none,
        target: figure.where(kind: raw),
      )
    }
  }

  if (show-acronyms and acronyms != none and acronyms.len() > 0) {
    print-acronyms(language, acronym-spacing)
  }

  if (glossary != none and glossary.len() > 0) {
    print-glossary(language, glossary-spacing)
  }

  [#metadata(none)<numbering-preface-end>]

  set par(leading: 1em, spacing: 2em)
  set block(spacing: 2em)

  // reset page numbering and set to main page numbering
  let main-numbering = "1 / 1"
  if ("main" in page-numbering) {
    main-numbering = page-numbering.main
  }

  set page(
    // necessary to apply numbering in the table of contents
    numbering: main-numbering,
    footer: context {
      let display-total-page-number = main-numbering.clusters().filter(c => c in page-numbering-symbols).len() >= 2

      align(
        numbering-alignment,
        numbering(
          main-numbering,
          ..counter(page).get(),
          ..if display-total-page-number {
            counter(page).at(<numbering-main-end>)
          },
        ),
      )
    },
  )
  counter(page).update(1)

  body

  [#metadata(none)<numbering-main-end>]
  // reset page numbering and set to appendix page numbering
  let appendix-numbering = "a"
  if ("appendix" in page-numbering) {
    appendix-numbering = page-numbering.appendix
  }

  set page(
    // necessary to apply numbering in the table of contents
    numbering: appendix-numbering,
    footer: context {
      let display-total-page-number = appendix-numbering.clusters().filter(c => c in page-numbering-symbols).len() >= 2

      align(
        numbering-alignment,
        numbering(
          appendix-numbering,
          ..counter(page).get(),
          ..if display-total-page-number {
            counter(page).at(<numbering-appendix-end>)
          },
        ),
      )
    },
  )
  counter(page).update(1)

  // Display bibliography.
  if bibliography != none {
    set std-bibliography(
      title: REFERENCES.at(language),
      style: bib-style,
    )
  bibliography
  }

  if (appendix != none) {
    heading(level: 1, numbering: none)[#APPENDIX.at(language)]
    appendix
  }

  [#metadata(none)<numbering-appendix-end>]
}
