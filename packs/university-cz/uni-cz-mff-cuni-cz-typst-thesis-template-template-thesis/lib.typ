#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#import "@preview/abbr:0.3.0"

#let abbr = abbr

/// Cite helper that strips the label prefix from the displayed citation text.
///
/// Useful when the citation style renders e.g. "Author [1]" and you only want "[1]".
///
/// - key (label): The citation label
/// - supplement (content): Optional supplement text
#let ite(key, supplement: none) = {
  show regex("[^\[\d\]]"): none
  cite(key, supplement: supplement)
}

/// MFF CUNI thesis template. Apply with:
/// ```typst
/// #show: mff-thesis.with(
///   title: "My Thesis",
///   author: "Jan Novak",
///   ...,
/// )
/// ```
///
/// The user document is responsible for:
/// - `#abbr.load("abbreviations.csv")` and `#abbr.config(...)` before `#show: mff-thesis.with(...)`
/// - Bibliography at the end: `#bibliography("sources.bib", style: "ieee-bc.csl")`
/// - List of figures: `#outline(title: "List of Figures", target: figure)`
/// - Abbreviations list: `#abbr.list()`
///
/// - title (str): Thesis title
/// - title-local (str): Thesis title in a local language
/// - author (str): Student's full name
/// - department (str): Student's home department
/// - department-local (str): Student's home department in a local language
/// - supervisor (str): Supervisor's full name and title
/// - supervisor-department (str): Supervisor's department
/// - supervisor-department-local (str): Supervisor's department in a local language
/// - study-programme (str): Study programme
/// - study-branch (str): Study branch / specialization
/// - year (int): Year of submission
/// - keywords (array): List of keywords (strings)
/// - keywords-local (array): List of keywords (strings) in a local language
/// - abstract (content): Thesis abstract
/// - abstract-local (content): Thesis abstract in a local language
/// - acknowledgements (content): Acknowledgements page content
/// - logo (content): University logo, e.g. `image("logo-en.svg")`; pass `none` to omit
/// - defense-date (datetime): Date shown on the declaration signature line; defaults to today
/// - sig-where (str): Where the thesis was written
/// - thesis-type (str): "bachelor" or "master"
/// - for-print (str, possible values are "digital", "single-sided", "double-sided"): Adds asymmetric margins for single and double-sided printing
/// - table-of-contents (content): TOC element, e.g. `outline(depth: 3)`, or `none` to omit
/// - codly-aliases (dict): Extra language aliases forwarded to `codly()`, e.g. `("riscv": "asm")`
/// - body (content): Thesis chapters and content
#let mff-thesis(
  title: "Thesis Title",
  title-local: "Název práce",
  author: "Author Name",
  department: "Department",
  department-local: "Jméno katedry",
  supervisor: "Supervisor Name",
  supervisor-department: "Supervisor department",
  supervisor-department-local: "Katedra vedoucího",
  study-programme: "Study programme",
  study-branch: "Study branch",
  year: 2026,
  keywords: (),
  keywords-local: (),
  abstract: none,
  abstract-local: none,
  acknowledgements: none,
  logo: none,
  defense-date: none,
  sig-where: "Prague",
  thesis-type: "bachelor",
  for-print: "digital",
  table-of-contents: outline(depth: 3),
  codly-aliases: (:),
  body,
) = {
  // Document meta

  let kws = if type(keywords) == array { keywords } else { (keywords,) }
  set document(title: title, author: author, keywords: kws)

  // Typography

  set text(size: 12pt, lang: "en", weight: 400)
  set par(justify: true, leading: 0.5em, spacing: 0.5em, first-line-indent: 1.25em)

  // Codly codeblocks

  show: codly-init.with()
  codly(languages: codly-languages, aliases: codly-aliases)
  show raw.where(block: true): set text(size: 8pt)

  // Equations

  set math.equation(numbering: "(1)")
  show math.equation.where(block: true): set block(above: 1em, below: 1em)

  // Figures

  show figure: it => [
    #v(1em, weak: true)
    #block(breakable: false)[
      #it.body
      #v(1em)
      #it.caption
    ]
    #v(1em, weak: true)
  ]

  // Quotes

  show quote.where(block: true): it => [
    #set pad(x: 1.25em)
    #it
  ]

  // Lists

  let _list-depth = state("_list-depth", 0)

  set list(indent: 1.25em, body-indent: 0.5em, spacing: 0.8em)
  show list: it => context {
    if _list-depth.get() == 0 {
      block(above: 1em, below: 1em, {
        _list-depth.update(1)
        it
        _list-depth.update(0)
      })
    } else { it }
  }

  set enum(indent: 1.25em, body-indent: 0.5em, spacing: 0.8em)
  show enum: it => context {
    if _list-depth.get() == 0 {
      block(above: 1em, below: 1em, {
        _list-depth.update(1)
        it
        _list-depth.update(0)
      })
    } else { it }
  }

  // Headings

  set heading(numbering: "1.1")
  show heading: set par(first-line-indent: 0pt)

  show heading: it => {
    let (above, below, size) = if it.level == 1 {
      (3.5%, 2%, 24pt)
    } else if it.level == 2 {
      (3%, 1.5%, 15pt)
    } else if it.level == 3 {
      (2.5%, 1.5%, 13pt)
    } else if it.level == 4 {
      (2.5%, 1%, 12pt)
    } else {
      (1em, 1em, 12pt)
    }

    v(above, weak: true)
    block(breakable: false, sticky: true)[
      #if it.level == 4 {
        set text(size: size, style: "italic")
        if it.numbering != none [
          #counter(heading).display(it.numbering)
          #h(0.6em)
        ]
        it.body
      } else if it.level == 5 {
        set par(leading: 0.3em)
        smallcaps(strong(it.body))
      } else {
        set text(size: size)
        if it.numbering != none [
          #counter(heading).display(it.numbering)
          #h(0.6em)
        ]
        it.body
      }
    ]
    v(below, weak: true)
    h(1.25em)
  }

  // Outlines

  show outline.entry: it => {
    v(0.65em, weak: true)
    it
  }

  // Aux values

  let page-margin = if for-print == "digital" {
    // Just bare margins, for digital viewing
    auto
  } else if (for-print == "single-sided") {
    (left: 40mm, rest: 25mm)
  } else if (for-print == "double-sided") {
    (inside: 40mm, rest: 25mm)
  } else {
    assert(false, message: "for-print can be either \"digital\", \"single-sided\" or \"double-sided\".")
  }

  let is-for-double-sided-print = for-print == "double-sided"

  let sig-date = if defense-date != none {
    defense-date
  } else { datetime.today() }

  // Title page

  set page(paper: "a4", numbering: none)

  align(center)[
    #if logo != none {
      logo
    }

    #v(0.8fr)

    #text(size: 22pt, weight: "bold")[#upper(thesis-type + " thesis")]

    #v(4em)

    #text(size: 18pt)[#author]

    #v(2em)

    #box(width: 70%)[
      #set par(justify: false)
      #text(size: 24pt, weight: "bold")[#title]
    ]

    #v(4em)

    #department

    #v(4em)

    #table(
      columns: 2,
      stroke: none,
      align(right)[Supervisor:], align(left)[#supervisor],
      align(right)[Study programme:], align(left)[#study-programme],
      align(right)[Study branch:], align(left)[#study-branch],
    )

    #v(4em)

    Prague #year

    #v(1fr)
  ]

  if is-for-double-sided-print {
    pagebreak()
  }

  pagebreak()

  set page(margin: page-margin)

  // Declaration

  v(1fr)

  [
    I declare that I carried out this bachelor thesis on my own,
    and only with the cited sources, literature and other professional sources. I
    understand that my work relates to the rights and obligations under the Act
    No.~121/2000 Sb., the Copyright Act, as amended, in particular the fact that the
    Charles University has the right to conclude a license agreement on the use of
    this work as a school work pursuant to Section~60 subsection~1 of the
    Copyright~Act.
  ]

  v(3em)

  [
    #set par(first-line-indent: 0pt)

    In #sig-where date #sig-date.display("[month repr:long] [day], [year]")
    #h(4em)
    #box(width: 1fr, repeat[.])
  ]

  pagebreak()
  if is-for-double-sided-print {
    pagebreak()
  }

  // Acknowledgements

  if acknowledgements != none {
    acknowledgements
    pagebreak()
    if is-for-double-sided-print {
      pagebreak()
    }
  }

  // Metadata summary

  let type-local = if thesis-type == "bachelor" {
    "bakalářské"
  } else if thesis-type == "master" {
    "diplomové"
  }

  [
    #set par(first-line-indent: 0pt, spacing: 0.8em)

    *Název práce:* #title-local

    *Autor:* #author

    *Katedra:* #department-local

    *Vedoucí #type-local práce:* #supervisor, #supervisor-department-local

    #if abstract-local != none [
      *Abstrakt:* #abstract-local
    ]

    *Klíčová slova:* #if type(keywords-local) == array { keywords-local.join(", ") } else { keywords-local }

    #v(1fr)

    *Title:* #title

    *Author:* #author

    *Department:* #department

    *Supervisor:* #supervisor, #supervisor-department

    #if abstract != none [
      *Abstract:* #abstract
    ]

    *Keywords:* #if type(keywords) == array { keywords.join(", ") } else { keywords }

    #v(1fr)
  ]

  pagebreak()
  if is-for-double-sided-print {
    pagebreak()
  }

  // Numbering starts here
  set page(numbering: "1", margin: page-margin)

  if table-of-contents != none {
    show outline.entry.where(level: 1): it => {
      set par(first-line-indent: 0pt)
      v(1em, weak: true)
      let loc = it.element.location()
      let num = if it.element.numbering != none {
        numbering(it.element.numbering, ..counter(heading).at(loc))
      }
      link(loc, strong(
        (
          if num != none {
            num + h(0.5em)
          } else { [] }
        )
          + it.element.body
          + h(1fr)
          + str(counter(page).at(loc).first()),
      ))
    }
    table-of-contents
    pagebreak()
  }

  body
}
