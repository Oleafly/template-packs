// Copyright 2026 Leedehai. Governed by a MIT license in the LICENSE.txt file.
// Repository: https://github.com/Leedehai/typst-flow-book
//
// Usage:
// ```
// #import "flow-book.typ" as book
//
// #show: book.setup.with(title: "My Awesome Book", ...)
//
// Your content here.
// ```

#import "@preview/marginalia:0.3.1" as marginalia
#import "@preview/in-dexter:0.7.2" as in-dexter

#import "lib.typ": meta-impl, quote-impl, setup-impl, weblink-impl

/// Put a side note. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// foo#book.note[This is a side note]
/// ...
/// foo#book.note(dy: -1em)[This is a side note, but moved upward by 1em.]
/// ```
/// More usage in the documentation of package `marginalia`.
#let note = marginalia.note.with(
  numbering: (.., n) => super(text(fill: eastern)[#numbering("a", n)]),
  text-style: (size: 8pt),
)

/// Put a side note figure. Use `dy` to adjust y-position if needed.
///
/// Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// foo#book.notefigure[This is a side note]
/// ```
/// More usage in the documentation of package `marginalia`.
#let notefigure = marginalia.notefigure.with(text-style: (size: 8pt))

/// Put a block of content that occupies both the main text and the
/// margin that's otherwise reserved for side ntoes. Useful for
/// wide figures and tables, etc. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #book.wideblock[...]
/// ```
/// More usage in the documentation of package `marginalia`.
#let wideblock = marginalia.wideblock

/// Add an index. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// This is called a dog#book.index[dog].
/// Using LaTeX's bang grouping, so "laptop" and "desktop" appear under
/// "computer": _laptop computer_#book.index("computer!laptop"), and
/// desktop computer#book.index("computer!desktop").
/// ```
/// More usage in the documentation of package `in-dexter`.
#let index = in-dexter.index

/// Add a block quote. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #book.quote[...]
/// #book.quote(attribution: [Newton])[...]
/// ```
/// - body (content): the quoted body
/// - attribution (content, label, none): the attribution, skipped if none
/// -> content
#let quote(body, attribution: none) = quote-impl(body, attribution: attribution)

/// Add a link with color. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #book.weblink("https://typst.app")[Typst]
/// ```
/// - url (str): the web link URL.
/// - content (content, none): The content that is a link. If none, display url.
/// -> content
#let weblink(url, content) = weblink-impl(url, content)

/// A container for non-contextual book metadata holding title, subtitle,
/// author, etc. and more key-value pairs added in the setup call. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #show book.setup.with(..., meta: (editor: "Magic Wand"))
/// #book.meta.get("author")
/// #book.meta.get("editor")
/// ```
/// - key (str): the key.
/// -> any
#let meta(key) = context meta-impl(key)

/// The default i10n mapping dictionary. To override some of them:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #show book.setup.with(
///  // ...
///  i10n-texts: book.i10-texts-defaults + (table-of-contents: "目录")
/// )
/// ```
#let i10-texts-defaults = (
  forward: "Forward",
  preface: "Preface",
  table-of-contents: "Table of Contents",
  list-of-figures: "List of Figures",
  list-of-tables: "List of Tables",
  appendix-title-in-outline: "Appendix",
  appendix-abbreviated-heading-prefix: "App.",
  index: "Index",
  blank-page-message: "This page has been intentionally left blank.",
)

/// The default cover page font mapping dictionary. To override some of them:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #show book.setup.with(
///  ...
///  cover-page-sizes: book.cover-page-size-defaults + (title: (..: ..))
/// )
/// ```
#let cover-page-fonts-defaults = (
  title: (font: auto, size: 28pt, weight: "bold"),
  subtitle: (font: auto, size: 21pt, weight: "regular"),
  author: (font: auto, size: 21pt, weight: "regular"),
  publisher: (font: auto, size: 16pt, weight: "regular"),
)

/// The setup. Usage:
/// ```
/// #import "@preview/flow-book:x.y.z" as book
/// #show book.setup.with(title: "My Awesome Book", ...)
///
/// Your content here.
/// ```
/// - title (content, str): title of the book
/// - subtitle (content, str): subtitle of the book
/// - title-head (content, str): title-head of the book
/// - author (content, str): author of the book
/// - publisher (content, str): publisher of the book
/// - versioning (dictionary): versioning info, all fields are optional
///   - build-date (str, auto): a date or Typst's datetime pattern, or auto set
///   - version: (content, str): a version label
/// - page-size (str): Typst page-size option
/// - copyright-page (content, none): copyright page, skipped if none
/// - opening-page (content, none): the opening page, skipped if none
/// - dedication-page (content, none): the dedication page, skipped if none
/// - foreword (content, none): the foreword, skipped if none
/// - preface (content, none): the preface, skipped if none
/// - show-table-of-contents (bool): whether to show table of contents
/// - show-list-of-figures (bool): whether to show list of figures
/// - show-list-of-tables (bool): whether to show list of tables
/// - show-chapter-outline (bool): whether to show mini outline for each chapter
/// - appendices (dictionary): appendix
///   - appendix-title-page (content, none): appendix cover, skipped if none
///   - version: (content, str): a version label
/// - bibliography (content, none): the bibliography() call, skipped if none
/// - show-index (bool): whether to show index of terms and their pages
/// - cover-page-fonts (dictionary): to config various fonts on cover page,
/// - margin-note-metrics (dictionary): to config margin notes
/// - i10-texts (dictionary): to config translations for texts in template
/// - meta-dict (dictionary): key-values that can be exposed by `#meta`
/// - body (content): the book chapters
#let setup(
  title: "",
  subtitle: "",
  title-head: "",
  author: "",
  publisher: "",
  versioning: (build-date: auto, version: "version 1.0"),
  paper-size: "a4",
  copyright-page: none,
  opening-page: none,
  dedication-page: none,
  foreword: none,
  preface: none,
  show-table-of-contents: false,
  show-list-of-figures: false,
  show-list-of-tables: false,
  show-chapter-outline: true,
  appendices: (appendix-title-page: none, chapters: ()),
  bibliography: none,
  show-index: false,
  cover-page-fonts: cover-page-fonts-defaults,
  margin-note-metrics: (width: 5.2cm, sep: 1em),
  i10n-texts: i10-texts-defaults,
  meta-dict: (:),
  body,
) = {
  let opts = (
    title: title,
    subtitle: subtitle,
    title-head: title-head,
    author: author,
    publisher: publisher,
    versioning: versioning,
    paper-size: paper-size,
    copyright-page: copyright-page,
    opening-page: opening-page,
    dedication-page: dedication-page,
    foreword: foreword,
    preface: preface,
    show-table-of-contents: show-table-of-contents,
    show-list-of-figures: show-list-of-figures,
    show-list-of-tables: show-list-of-tables,
    show-chapter-outline: show-chapter-outline,
    appendices: appendices,
    bibliography: bibliography,
    show-index: show-index,
    cover-page-fonts: cover-page-fonts,
    margin-note-metrics: margin-note-metrics,
    i10n-texts: i10n-texts,
    meta-dict: meta-dict,
  )
  setup-impl(opts, body)
}
