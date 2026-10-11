// /template/lib.typ
// Template library — Public API
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Usage (LaTeX-inspired):
//
//   #show: document.with(
//     doc-class: "thesis",     // "article" | "report" | "book" | "thesis"
//     paper: "a4",             // "a4" | "a5" | "letter"
//     font-size: 12pt,         // any length
//     two-sided: true,         // true | false
//     output: "digital",       // "digital" | "print"
//     lang: "vi",              // "en" | "vi" | "ms" | "zh-Hant" | "zh-Hans"
//     components: (            // override individual toggles
//       show-toc: true,
//       show-lof: false,
//     ),
//     ..data,                  // metadata spread
//     acronyms: acronyms,
//   )

// MARK: Imports

// Sub-modules
#import "core/fonts.typ": *
#import "core/colors.typ": *
#import "core/utils.typ": *
#import "langs/i18n.typ": i18n-labels
#import "core/class-defaults.typ": class-defaults
#import "core/geometry.typ": page-geometry, resolve-margins
#import "core/output-profiles.typ": output-profile
#import "core/formatting.typ": *
#import "core/front-matter.typ": render-preamble-sections, render-lists

// Components (re-exported for user convenience)
#import "components/callout.typ": *
#import "components/todo.typ": *
#import "components/table.typ": *
#import "components/cover.typ": cover-page

// MARK: The Document Template

/// The main document template function.
/// Designed as a LaTeX-inspired class system with sensible defaults
/// that can be overridden per-parameter.
///
/// Parameters marked `auto` fall through to the class defaults.
#let document(
  // ── Document Class ──────────────────────────────────
  /// "article" | "report" | "book" | "thesis"
  doc-class: "report",

  // ── Page Geometry ───────────────────────────────────
  /// "a4" | "a5" | "letter" — auto falls through to class default
  paper: auto,
  /// length | dictionary — auto falls through to class default
  margin: auto,
  /// true | false — auto falls through to class default
  two-sided: auto,

  // ── Typography ──────────────────────────────────────
  /// Default font size — auto falls through to class default
  font-size: auto,
  /// Language code for i18n labels and Typst text lang
  lang: "en",
  /// Region code for Typst text region
  region: auto,

  // ── Output Mode ─────────────────────────────────────
  /// "digital" | "print"
  output: "digital",

  // ── Component Toggles ───────────────────────────────
  /// Dictionary of booleans — merged onto class defaults
  /// e.g., (show-toc: false, show-lof: false)
  components: (:),

  // ── Content Metadata ────────────────────────────────
  university: (:),
  course: (:),
  instructor: "",
  author: (:),
  assignment: (:),
  acronyms: none,

  // ── Sink + Body ─────────────────────────────────────
  ..args,
  body,
) = {
  // ════════════════════════════════════════════════════
  // 1. RESOLVE CONFIGURATION
  // ════════════════════════════════════════════════════

  // Get class defaults, fallback to "report" if unknown class
  let defaults = if doc-class in class-defaults {
    class-defaults.at(doc-class)
  } else {
    class-defaults.at("report")
  }

  // Resolve auto parameters — user overrides take precedence
  let cfg-paper = if paper == auto { defaults.paper } else { paper }
  let cfg-font-size = if font-size == auto { defaults.font-size } else { font-size }
  let cfg-two-sided = if two-sided == auto { defaults.two-sided } else { two-sided }
  let cfg-margin = if margin == auto { defaults.margin } else { margin }
  let cfg-par-leading = defaults.par-leading
  let cfg-par-spacing = defaults.par-spacing
  let cfg-heading-numbering = defaults.heading-numbering
  let cfg-chapter-pagebreak = defaults.chapter-pagebreak

  // Merge component flags: class defaults ← user overrides
  let cfg = dict-merge(defaults, components)
  // Inject resolved geometry and typography back into config
  let cfg = dict-merge(cfg, (
    doc-class: doc-class,
    paper: cfg-paper,
    font-size: cfg-font-size,
    two-sided: cfg-two-sided,
    margin: cfg-margin,
    chapter-pagebreak: cfg-chapter-pagebreak,
  ))

  // Resolve output profile and i18n labels
  let profile = output-profile(output)
  let labels = i18n-labels(lang)

  // Extract 2–3 letter ISO 639 base code for set text(lang: …)
  // BCP 47 tags like "vi-vn" or "zh-Hant" must be stripped to "vi" / "zh"
  let text-lang = if "-" in lang { lang.split("-").first() } else { lang }

  // Resolve page geometry
  let geo = page-geometry(cfg-paper, cfg-margin, cfg-two-sided)

  // Resolve region from lang if auto (supports both short and BCP 47 forms)
  let cfg-region = if region == auto {
    let lower = lower(lang)
    if lower in ("vi", "vi-vn") { "vn" }
    else if lower in ("ms", "ms-my") { "my" }
    else if lower in ("zh-hant", "zh-tw") { "tw" }
    else if lower in ("zh-hans", "zh-cn") { "cn" }
    else { "us" }
  } else { region }

  // ════════════════════════════════════════════════════
  // 2. PDF METADATA
  // ════════════════════════════════════════════════════

  set std.document(
    title: if "title" in assignment { assignment.title } else { "" }
      + if "subtitle" in assignment { ": " + assignment.subtitle } else { "" },
    author: if "name" in author { author.name } else { "" }
      + if "id" in author { " (" + author.id + ")" } else { "" },
    keywords: (
      if "id" in course { course.id } else { "" },
      if "name" in course { course.name } else { "" },
    ),
    date: datetime.today(),
  )

  // ════════════════════════════════════════════════════
  // 3. PAGE & TEXT SETUP
  // ════════════════════════════════════════════════════

  // Anchor for [Back to Top]
  [#metadata("top") <top>]

  // Page geometry
  set page(..geo)

  // Typography
  set text(
    font: body-font,
    size: cfg-font-size,
    weight: "regular",
    lang: text-lang,
    region: cfg-region,
  )

  // Paragraph settings
  set par(
    leading: cfg-par-leading,
    justify: true,
    spacing: cfg-par-spacing,
  )

  // ════════════════════════════════════════════════════
  // 4. APPLY FORMATTING RULES
  // ════════════════════════════════════════════════════

  show: apply-preamble-heading-rules.with(cfg)
  show: apply-code-rules
  show: apply-table-rules.with(profile.accent-color)
  show: apply-general-rules.with(profile)
  show: apply-figure-supplements.with(labels)

  // ════════════════════════════════════════════════════
  // 5. COVER PAGE
  // ════════════════════════════════════════════════════

  if cfg.show-cover {
    // No headers/footers, no numbering on cover
    set page(header: none, footer: none, numbering: none)
    cover-page(
      university: university,
      course: course,
      instructor: instructor,
      author: author,
      assignment: assignment,
    )
    pagebreak()
  }

  // ════════════════════════════════════════════════════
  // 6. FRONT MATTER (Roman numbering)
  // ════════════════════════════════════════════════════

  counter(page).update(1)

  // Centered, muted page numbers
  set page(
    header: auto,
    numbering: "i",
    number-align: center,
    footer: context [
      #set text(size: 10pt, fill: clr-neutral-text)
      #align(center)[
        #counter(page).display(page.numbering)
      ]
    ],
  )

  // Preamble sections (summary, forewords, etc.)
  render-preamble-sections(cfg, labels)

  // Lists (TOC, LOT, LOF, LOC, TODOs, Acronyms)
  let needs-pagebreak = doc-class == "thesis" or doc-class == "book"
  render-lists(cfg, labels, profile.accent-color, acronyms, needs-pagebreak)

  // ════════════════════════════════════════════════════
  // 7. MAIN CONTENT (Arabic numbering)
  // ════════════════════════════════════════════════════

  set page(numbering: "1", number-align: right)
  counter(page).update(1)

  // Apply chapter heading styling for main content
  show: apply-chapter-heading-rules.with(cfg, labels)

  // Footer with optional "Back to Top"
  set page(footer: context [
    #set text(size: 10pt, fill: clr-neutral-text)
    #if profile.show-back-to-top {
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        link(<top>)[#text(fill: clr-neutral-text)[#labels.back-to-top]],
        counter(page).display(page.numbering),
      )
    } else {
      align(right)[
        #counter(page).display(page.numbering)
      ]
    }
  ])

  // ════════════════════════════════════════════════════
  // 8. BODY
  // ════════════════════════════════════════════════════

  body
}

// MARK: Appendix Helper

/// Switches heading style to appendix format (A.1, A.2, ...).
/// Usage: `#show: appendix`
#let appendix(body) = {
  counter(heading).update(0)

  // Resolve labels from context — appendix uses the lang set in the document
  // We use a simple fallback approach here
  let _labels = i18n-labels("en")

  set heading(numbering: "A.1", supplement: _labels.appendix-supplement)

  show heading.where(level: 1): it => {
    pagebreak()
    align(left)[
      #stack(
        dir: ttb,
        spacing: 1.5em,
        text(
          font: heading-font,
          size: 18pt,
          weight: "regular",
          fill: clr-heading-rule,
        )[#_labels.appendix-prefix #counter(heading).display()],
        text(
          font: heading-font,
          size: 30pt,
          weight: "regular",
        )[#it.body],
        line(length: 100%, stroke: 1pt + clr-heading-rule),
      )
    ]
    v(0.5em)
  }

  body
}

/// Localized appendix helper — pass the language code to use correct labels.
/// Usage: `#show: appendix-l10n.with("vi")`
#let appendix-l10n(lang, body) = {
  counter(heading).update(0)

  let _labels = i18n-labels(lang)

  set heading(numbering: "A.1", supplement: _labels.appendix-supplement)

  show heading.where(level: 1): it => {
    pagebreak()
    align(left)[
      #stack(
        dir: ttb,
        spacing: 1.5em,
        text(
          font: heading-font,
          size: 18pt,
          weight: "regular",
          fill: clr-heading-rule,
        )[#_labels.appendix-prefix #counter(heading).display()],
        text(
          font: heading-font,
          size: 30pt,
          weight: "regular",
        )[#it.body],
        line(length: 100%, stroke: 1pt + clr-heading-rule),
      )
    ]
    v(0.5em)
  }

  body
}

// MARK: Bibliography Helper

/// Switches heading style to bibliography format.
/// Usage: `#show: bibliography-page`
#let bibliography-page(body) = {
  counter(heading).update(0)

  let _labels = i18n-labels("en")

  set heading(numbering: "I", supplement: _labels.bibliography-supplement)
  show link: set text(fill: blue)

  show heading.where(level: 1): it => {
    pagebreak()
    align(left)[
      #stack(
        dir: ttb,
        spacing: 1.5em,
        text(
          font: heading-font,
          size: 18pt,
          weight: "regular",
          fill: clr-heading-rule,
        )[],
        text(
          font: heading-font,
          size: 30pt,
          weight: "regular",
        )[#it.body],
        line(length: 100%, stroke: 1pt + clr-heading-rule),
      )
    ]
    v(0.5em)
  }

  body
}

/// Localized bibliography helper.
/// Usage: `#show: bibliography-page-l10n.with("vi")`
#let bibliography-page-l10n(lang, body) = {
  counter(heading).update(0)

  let _labels = i18n-labels(lang)

  set heading(numbering: "I", supplement: _labels.bibliography-supplement)
  show link: set text(fill: blue)

  show heading.where(level: 1): it => {
    pagebreak()
    align(left)[
      #stack(
        dir: ttb,
        spacing: 1.5em,
        text(
          font: heading-font,
          size: 18pt,
          weight: "regular",
          fill: clr-heading-rule,
        )[],
        text(
          font: heading-font,
          size: 30pt,
          weight: "regular",
        )[#it.body],
        line(length: 100%, stroke: 1pt + clr-heading-rule),
      )
    ]
    v(0.5em)
  }

  body
}
