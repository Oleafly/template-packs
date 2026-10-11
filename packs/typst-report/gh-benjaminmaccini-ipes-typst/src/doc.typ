// ===========================================================================
// doc.typ — the `report` show rule.
//
// Composition order matters here:
//   1. record the theme, so every component can read it
//   2. document-wide text/paragraph/element defaults
//   3. front matter — cover and credits carry their own page chrome
//   4. `marginalia.setup`, which owns the page margins from here on
//   5. running headers, folios, heading and footnote presentation
//   6. the body
//   7. back matter — endnotes, indices, back cover
// ===========================================================================

#import "@preview/marginalia:0.3.1" as marginalia
#import "@preview/hydra:0.6.3": hydra

#import "theme.typ": get-theme, ipes-theme, theme-state
#import "sections.typ": heading-rules
#import "notes.typ": footnote-rules, endnotes as endnotes-section
#import "covers.typ": back-cover, credits-page, front-cover
#import "contents.typ": contents as contents-page

/// Running header: section title across the measure, folio on the outer edge.
#let _running-header(t) = context {
  marginalia.header(
    text-style: (size: t.scale.fine, fill: t.colors.muted, font: t.fonts.body),
    // centre slot — spans the text measure, so a long section title has room
    align(left, {
      set text(tracking: 0.14em, weight: 600, hyphenate: false)
      let h = hydra(1, display: (_, it) => upper(it.body))
      if h != none { h }
    }),
    // outer slot — the folio
    align(right, text(
      font: t.fonts.display,
      size: t.scale.h3,
      fill: t.colors.primary,
    )[#counter(page).display("1")]),
  )

  if t.options.header-rule {
    v(-0.55em)
    line(length: 100%, stroke: (thickness: 0.5pt, paint: t.colors.rule))
  }
}

/// The report template.
///
/// ```typ
/// #show: report.with(
///   title: [The new geopolitics of food],
///   subtitle: [Navigating policies for resilient self-reliance],
///   eyebrow: [A Special Report],
///   publisher: [IPES-Food],
///   date: [September 2026],
///   endnotes: bibliography("refs.bib", style: "nature"),
/// )
/// ```
#let report(
  /// Report title, used on the cover and in the PDF metadata.
  title: none,
  /// Sub-title / standfirst.
  subtitle: none,
  /// Small line above the cover title, e.g. `[A Special Report]`.
  eyebrow: none,
  /// Issuing organisation.
  publisher: none,
  /// Publication date, as content.
  date: none,
  /// Authors, for the PDF metadata.
  authors: (),
  /// Logo content for the cover.
  logo: none,
  /// The theme. Build one with `make-theme(..)`.
  theme: ipes-theme,
  /// Document language.
  lang: "en",
  /// Front-cover options, forwarded to `front-cover`. `none` skips the cover.
  cover: (:),
  /// Acknowledgements content, or a dictionary of `credits-page` options with
  /// a `body` key. `none` skips the page.
  credits: none,
  /// `true`, `false`, or a dictionary of `contents` options.
  contents: true,
  /// The result of `bibliography(..)`, or a dictionary with a `bib` key and
  /// any `endnotes` options. `none` skips the section.
  endnotes: none,
  /// Back-cover options, forwarded to `back-cover`. `none` skips it.
  back: none,
  /// Content placed after the body but before the endnotes — appendices,
  /// indices, a glossary.
  appendix: none,
  /// The report.
  body,
) = {
  let t = theme

  // --- 1. theme + metadata -------------------------------------------------
  theme-state.update(t)
  set document(
    title: if title == none { "" } else { title },
    author: authors,
  )

  // --- 2. document-wide defaults ------------------------------------------
  set text(font: t.fonts.body, size: t.scale.base, fill: t.colors.ink, lang: lang)
  set par(justify: true, leading: 0.62em, spacing: t.spacing.para * 1.7, first-line-indent: 0pt)
  set heading(numbering: if t.options.numbered-sections { "1.1" } else { none })

  show link: it => text(fill: t.colors.primary, it)
  show strong: set text(weight: 700)

  set list(marker: (
    text(fill: t.colors.accent)[#sym.square.filled],
    text(fill: t.colors.muted)[#sym.dash.en],
  ), indent: 0.6em, spacing: t.spacing.para * 1.5)
  set enum(indent: 0.6em, spacing: t.spacing.para * 1.5)

  set table(
    stroke: (x, y) => (
      top: if y == 0 { (thickness: 1pt, paint: t.colors.ink) } else if y == 1 {
        (thickness: 0.5pt, paint: t.colors.rule)
      } else { none },
      bottom: (thickness: 0.5pt, paint: t.colors.rule),
    ),
    inset: (x: 0.6em, y: 0.5em),
  )
  show table.cell.where(y: 0): set text(weight: 700, size: t.scale.fine)

  set figure(gap: 0.8em)
  show figure.caption: set text(size: t.scale.fine, fill: t.colors.muted)

  set quote(block: true)
  show quote: set pad(x: 1.2em)

  // --- 3. front matter -----------------------------------------------------
  if cover != none {
    front-cover(
      title: title,
      subtitle: subtitle,
      eyebrow: eyebrow,
      publisher: publisher,
      date: date,
      logo: logo,
      ..cover,
    )
  }

  if credits != none {
    if type(credits) == dictionary {
      // `body` is positional on `credits-page`, so lift it out of the options.
      let opts = credits
      let text-body = opts.remove("body", default: none)
      credits-page(..opts, text-body)
    } else {
      credits-page(credits)
    }
  }

  // --- 4. margins ----------------------------------------------------------
  show: marginalia.setup.with(
    inner: t.page.inner,
    outer: t.page.outer,
    top: t.page.top,
    bottom: t.page.bottom,
    book: t.page.book,
    clearance: t.page.clearance,
  )

  // --- 5. chrome -----------------------------------------------------------
  set page(
    paper: t.page.paper,
    fill: t.colors.paper,
    header: _running-header(t),
    header-ascent: 35%,
    // The folio lives in the header; a footer would print it twice.
    footer: none,
    numbering: "1",
  )
  counter(page).update(1)

  show: heading-rules
  show: footnote-rules

  // --- 6. body -------------------------------------------------------------
  if contents != false {
    if type(contents) == dictionary { contents-page(..contents) } else { contents-page() }
  }

  body

  if appendix != none { appendix }

  // --- 7. back matter ------------------------------------------------------
  if endnotes != none {
    if type(endnotes) == dictionary {
      endnotes-section(..endnotes.at("options", default: (:)), endnotes.bib)
    } else {
      endnotes-section(endnotes)
    }
  }

  if back != none {
    back-cover(publisher: publisher, ..back)
  }
}
