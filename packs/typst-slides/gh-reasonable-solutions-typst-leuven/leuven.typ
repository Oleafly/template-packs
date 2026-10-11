// Leuven Typst Presentation Theme
// Based on the Leuven Emacs color theme

// ── Colors ──────────────────────────────────────────────────────────────────

#let leuven-blue    = rgb("#335EA8")   // primary — mode-line bg
#let leuven-navy    = rgb("#123555")   // headings — ol2 fg
#let leuven-sky     = rgb("#85CEEB")   // accent — mode-line fg
#let leuven-ice     = rgb("#E5F4FB")   // light bg — ol2 bg
#let leuven-green   = rgb("#005522")   // secondary accent
#let leuven-orange  = rgb("#EA6300")   // tertiary accent
#let leuven-text    = rgb("#333333")   // default fg
#let leuven-muted   = rgb("#8D8D84")   // comments / secondary text
#let leuven-white   = rgb("#FFFFFF")

// ── State ────────────────────────────────────────────────────────────────────

#let _slide-title    = state("leuven-slide-title", "")
#let _slide-subtitle = state("leuven-slide-subtitle", "")
#let _slide-author   = state("leuven-slide-author", "")
#let _slide-date     = state("leuven-slide-date", "")

// ── Internal helpers ─────────────────────────────────────────────────────────

// Footer bar shared by content slides
#let render-footer(title, author, date) = {
  block(
    width: 100%,
    height: 1.4em,
    fill: leuven-blue,
    inset: (x: 0.8em, y: 0.3em),
    {
      set text(size: 0.62em, fill: leuven-sky)
      grid(
        columns: (1fr, auto, 1fr),
        align(left, author),
        align(center, title),
        align(right, date),
      )
    },
  )
}

// ── Public API ────────────────────────────────────────────────────────────────

/// Initialize the presentation.  Call once at the top of your document.
///
/// - title    (str): presentation title
/// - subtitle (str): optional subtitle
/// - author   (str): author name(s)
/// - date     (str): date string
#let init(
  title: "",
  subtitle: "",
  author: "",
  date: "",
  body,
) = {
  // Persist metadata for footer/title slide
  _slide-title.update(title)
  _slide-subtitle.update(subtitle)
  _slide-author.update(author)
  _slide-date.update(date)

  // Page geometry: 16 × 9
  set page(
    width:  254mm,
    height: 142.875mm,
    margin: 0pt,
    fill:   leuven-white,
  )

  set text(font: "JetBrains Mono", size: 18pt, fill: leuven-text)

  body
}

/// Title slide.
#let title-slide() = context {
  let t  = _slide-title.get()
  let st = _slide-subtitle.get()
  let a  = _slide-author.get()
  let d  = _slide-date.get()

  page(fill: leuven-blue)[
    // Decorative top stripe
    #block(width: 100%, height: 6pt, fill: leuven-sky)

    #v(1fr)

    // Title block
    #pad(x: 2.2em)[
      #text(size: 2em, weight: "bold", fill: leuven-white, t)
      #if st != "" {
        linebreak()
        text(size: 1.15em, fill: leuven-sky, st)
      }
    ]

    #v(0.6fr)

    // Author / date bar
    #block(
      width: 100%,
      fill: leuven-navy,
      inset: (x: 2.2em, y: 0.8em),
    )[
      #set text(fill: leuven-sky, size: 0.78em)
      #grid(
        columns: (1fr, auto),
        align(left, a),
        align(right, d),
      )
    ]
  ]
}

/// Section divider slide.
///
/// - heading (content): section title
/// - sub     (content): optional subtitle / description
#let section-slide(heading, sub: none) = context {
  let footer_title  = _slide-title.get()
  let footer_author = _slide-author.get()
  let footer_date   = _slide-date.get()

  page(fill: leuven-white)[
    // Left accent bar
    #grid(
      columns: (8pt, 1fr),
      block(width: 100%, height: 100%, fill: leuven-blue),
      pad(x: 2em)[
        #v(1fr)
        #text(size: 1.6em, weight: "bold", fill: leuven-navy, heading)
        #if sub != none {
          linebreak()
          text(size: 0.85em, fill: leuven-muted, sub)
        }
        #v(1fr)
      ],
    )

    #place(bottom, render-footer(footer_title, footer_author, footer_date))
  ]
}

/// Regular content slide.
///
/// - title (content): slide heading
/// - body  (content): slide content
#let slide(title: none, body) = context {
  let footer_title  = _slide-title.get()
  let footer_author = _slide-author.get()
  let footer_date   = _slide-date.get()

  page(fill: leuven-white)[
    // Header bar
    #if title != none {
      block(
        width: 100%,
        fill: leuven-blue,
        inset: (x: 1.4em, y: 0.55em),
        text(size: 1.05em, weight: "bold", fill: leuven-white, title),
      )
    }

    // Content area
    #pad(x: 1.6em, top: 0.9em, bottom: 2.2em, body)

    #place(bottom, render-footer(footer_title, footer_author, footer_date))
  ]
}

/// Two-column content slide.
///
/// - title (content): slide heading
/// - left  (content): left column body
/// - right (content): right column body
#let slide2(title: none, left, right) = {
  slide(title: title)[
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 1.8em,
      left,
      right,
    )
  ]
}

// ── Styled content helpers ────────────────────────────────────────────────────

/// Highlighted block (blue ice background).
#let highlight-block(body) = block(
  fill:   leuven-ice,
  stroke: (left: 3pt + leuven-blue),
  inset:  (x: 1em, y: 0.7em),
  width:  100%,
  body,
)

/// Success / good-news block (green left bar).
#let success-block(body) = block(
  fill:   rgb("#EFFFEF"),
  stroke: (left: 3pt + leuven-green),
  inset:  (x: 1em, y: 0.7em),
  width:  100%,
  body,
)

/// Alert / warning block (orange left bar).
#let alert-block(body) = block(
  fill:   rgb("#FFF2DE"),
  stroke: (left: 3pt + leuven-orange),
  inset:  (x: 1em, y: 0.7em),
  width:  100%,
  body,
)

/// Code block with Leuven styling.
///
/// Wraps a `raw` element with a header bar showing the language label
/// and the characteristic Leuven light-yellow background.
///
/// - lang  (str):     language passed to `raw` for syntax highlighting
/// - title (content): optional caption shown in the header bar
/// - body  (str):     source code string
#let code-block(lang: none, title: none, body) = {
  // Override raw theme colors to match Leuven
  show raw: set text(font: "JetBrains Mono", size: 0.72em)

  // Syntax token colors drawn from leuven-theme.el
  show raw.where(lang: lang): it => {
    set text(fill: rgb("#000088"))
    it
  }

  let label-bar = if lang != none or title != none {
    block(
      width:  100%,
      fill:   leuven-navy,
      inset:  (x: 0.8em, y: 0.4em),
      {
        set text(size: 0.68em, fill: leuven-sky, font: "JetBrains Mono")
        if title != none { title } else { lang }
      },
    )
  }

  block(
    width:  100%,
    stroke: (left: 3pt + leuven-navy),
    clip:   true,
    radius: 2pt,
    {
      if label-bar != none { label-bar }
      block(
        width:  100%,
        fill:   rgb("#FFFFE0"),
        inset:  (x: 1em, y: 0.8em),
        raw(body, lang: lang, block: true),
      )
    },
  )
}

/// Full slide pre-loaded with a code block.
///
/// - title (content): slide heading
/// - lang  (str):     language for syntax highlighting
/// - body  (str):     source code string
#let code-slide(title: none, lang: none, body) = {
  slide(title: title, code-block(lang: lang, body))
}

/// Styled bullet list with Leuven colors.
#let leuven-list(..items) = {
  set list(marker: (
    text(fill: leuven-blue, "▸"),
    text(fill: leuven-navy, "–"),
    text(fill: leuven-muted, "·"),
  ))
  list(..items)
}
