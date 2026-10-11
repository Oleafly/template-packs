/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p, thesis-parameters
#import "translations.typ" : t
#import "titlepage.typ" : thesis-titlepage
#import "acknowledgements.typ" : thesis-acknowledgements
#import "abstract.typ" : thesis-abstract
#import "bibliography.typ" : thesis-bibliography
#import "glossary.typ" : make-glossary, setup-glossary, thesis-loa, thesis-glossary
#import "appendix.typ" : thesis-appendix, appendix
#import "lists.typ": *
#import "util.typ" : *

#let _type = type

#let thesis(
  /// Title of the thesis or report.
  title: none,

  /// Author of this thesis or report.
  author: none,

  /// Student ID printed below the author if given.
  student-id: none,

  /// Date of this work, defaults to today.
  date: datetime.today(),

  /// Bibliography to use for this document.
  bibliography-file: none,

  /// Citation standard to use, see https://typst.app/docs/reference/model/bibliography for a full list. Alphanumeric is supported.
  bibliography-style: "ieee",

  /// Type of this thesis, can be "bachelor", "master" or "report".
  type: none,

  /// Language of this document, only "de", "en" are fully supported.
  lang: none,

  /// Whether to layout the document as a book (that can be bound) or not. Can be "single" (single-sided printing), "double" (double-sided printing) or false (no printing).
  book: false,

  /// Data to include in the header. Can be 'none' (empty), '"chapter"' (only current chapter), '"full"' (current chapter and section) or custom content.
  header: "chapter",

  /// Thesis abstract. To use multiple languages, use a dictionary with the language as the key.
  abstract: none,

  /// Additional acknowledgements added to the beginning.
  acknowledgements: none,

  /// Name of the examiner or list of names if multiple examiners.
  examiners: none,

  /// Name of the supervisor or list of names if multiple supervisors.
  supervisors: none,

  /// List of keywords for the title page.
  keywords: none,

  /// Company that supported this thesis.
  company: none,

  /// Entries for acronyms and glossary (Hint: Use a separate data file to define them).
  glossary: none,

  /// Don't emit any parts of the document itself, only set the styling options. Structure can be set up manually using the thesis-* functions.
  manual: false,

  /// Thesis content, use as global show rule is encouraged.
  body,
) = {
  // Validate parameters
  if not ("bachelor", "master", "report").contains(type) {
    panic("Set either 'bachelor', 'master', or 'report' as the document type option")
  }
  let lang-base = lang.split("-").at(0)
  if not ("de", "en").contains(lang-base) {
    panic("Set either 'de' or 'en' as the document language")
  }

  // Convert multilingual abstract into main/alt abstract
  if lang-base == "en" and (_type(abstract) != dictionary or abstract.at("de", default: none) == none) {
    panic("Kurzdarstellung required for English language")
  }
  let abstract-semantic = if _type(abstract) != dictionary {
    (main: abstract, alt: none)
  } else if lang-base == "de" {
    (main: abstract.de, alt: abstract.en)
  } else {
    (main: abstract.en, alt: abstract.de)
  }

  // All function parameters to be used in the thesis-* functions
  thesis-parameters.update((
    title: title,
    author: author,
    student-id: student-id,
    date: date,
    bibliography-file: bibliography-file,
    bibliography-style: bibliography-style,
    type: type,
    lang: lang,
    book: book,
    abstract: abstract-semantic,
    acknowledgements: acknowledgements,
    supervisors: supervisors,
    examiners: examiners,
    keywords: keywords,
    company: company,
    glossary: glossary,
    manual: manual,
  ))


  // Set document properties if given
  if title != none { set document(title: title) }
  if author != none { set document(author: author) }
  if abstract-semantic.main != none { set document(description: abstract-semantic.main) }
  if keywords != none { set document(keywords: keywords) }

  // Defer margins
  let margin-default = (x: 2.75cm, y: 3.5cm)
  let margin = if book == false { margin-default } else {
    let binding-offset = 0.5cm
    (
      single: (left:   margin-default.x + binding-offset,   right: margin-default.x - binding-offset, y: margin-default.y),
      double: (inside: margin-default.x + binding-offset, outside: margin-default.x - binding-offset, y: margin-default.y),
    ).at(book)
  }

  set page(
    paper: "a4",
    margin: margin,
    numbering: "1",
    header: context {
      if _type(header) == str and ("chapter", "full").contains(header) {
        let chap = current-heading()
        let sec = if header == "full" { current-heading(level: 2) } else { none }
        set text(style: "italic")
        show: upper

        let header-left = if sec != none [#heading-number(sec). #h(0.75em) #sec.body]
        let header-right = if chap != none {
          if chap.numbering != none [#chap.supplement #heading-number(chap).#h(0.75em)]
          chap.body
        }

        if book != "double" {
          grid(
            columns: (auto, 1fr, auto),
            align: (left, right),
            header-left,
            header-right,
          )
        } else {
          if calc.odd(here().page()) { align(right, header-right) }
          else { header-left }
        }
      }
      else if header == none { none }
      else { header }
    },
    footer: context {
      if here().page-numbering() == none { return none }
      if book == false { context align(center, counter(page).display()) }
      else if book == "single" { context align(right, counter(page).display()) }
      else if book == "double" { context align(if calc.odd(here().page()) { right } else { left }, counter(page).display()) }
    }
  )

  set text(
    lang: lang-base,
    font: "New Computer Modern",
    weight: "medium",
    size: 10pt,
  )
  set par(justify: true)

  // Register all entries
  show: make-glossary
  if glossary != none { setup-glossary(glossary) }

  // Show rules for common abbreviations
  include "text-show-rules.typ"

  set heading(supplement: context t("section"))
  show heading.where(level: 1): set heading(supplement: context t("chapter"), numbering: "1.1")
  show heading.where(level: 1): it => {
    set text(size: 24.88pt, weight: "medium")
    set par(leading: 0.5em, justify: false)
    {
      set page(header: none, numbering: none)
      pagebreak(weak: true, to: if book == false { none } else { "odd" })
    }
    v(16*ex)
    if it.numbering != none {
      stack(spacing: 8*ex, text(size: 0.85em)[#it.supplement #heading-number(it)], it.body)
    } else {
      it.body
    }
    v(4*ex)

    // Counter reset for figure counters that are <chapter>.1..
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
  }
  show heading.where(level: 2): set heading(numbering: "1.1")
  show heading.where(level: 3): set heading(numbering: "1.1")

  set figure(numbering: (..num) =>
    numbering("1.1", counter(heading).get().first(), num.pos().first())
  )
  show figure: it => {
    set align(center)
    set block(spacing: 2em)
    it
  }
  show figure.caption: it => {
    v(0.5em)
    it
  }

  set table(stroke: none)
  set table.hline(stroke: 0.75pt)

  // Alphanumeric is a citation style, not a bibliography style.
  set cite(style: "alphanumeric") if bibliography-style == "alphanumeric"

  // Print document structure or nothing (user has to set it up manually)
  if not manual {
    set page(numbering: "i")
    thesis-titlepage()
    thesis-acknowledgements()
    thesis-abstract()
    thesis-toc()
    thesis-loa()

    pagebreak(weak: true)
    counter(page).update(1)
    set page(numbering: "1")
    body

    thesis-lof()
    thesis-lol()
    thesis-lot()

    thesis-glossary()
    thesis-bibliography()
    thesis-appendix()
  } else {
    body
  }
}
