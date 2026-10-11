// template.typ
// Master document template providing page setup, theming, typography, and layout

#import "components/theme.typ": current-theme, resolve-palette
#import "components/toc.typ": format-toc-entry, toc-header

#let document-template(
  title: none,
  subtitle: none,
  author: none,
  date: auto,
  abstract: none,
  theme: "light",
  paper: "a4",
  margin: (x: 2.2cm, top: 2.3cm, bottom: 2.3cm),
  font: ("New Computer Modern", "Libertinus Serif"),
  header-font: ("Roboto", "Liberation Sans", "DejaVu Sans"),
  sans-font: ("Roboto", "Liberation Sans", "DejaVu Sans"),
  mono-font: ("SF Mono", "DejaVu Sans Mono"),
  font-size: 10pt,
  toc: false,
  toc-title: "Contents",
  toc-pagebreak: false,
  cover-page: false,
  chapter-label: "Chapter",
  numbered-headings: true,
  body,
) = {
  // Update the global template theme state
  current-theme.update(theme)

  // Resolve active theme palette
  let p = resolve-palette(theme-override: theme)

  // Document metadata
  set document(
    title: if title != none {
      if type(title) == str { title } else { repr(title) }
    } else { "Document" },
    author: if author != none {
      if type(author) == array { author } else if type(author) == str { (author,) } else { () }
    } else { () },
  )

  // Page setup
  set page(
    paper: paper,
    margin: margin,
    fill: p.page-bg,
    header: context {
      let page-num = counter(page).get().first()
      let start-header-page = if cover-page { 2 } else { 1 }
      if page-num > start-header-page {
        grid(
          columns: (1fr, auto),
          align: (left + bottom, right + bottom),
          text(
            fill: p.text-muted,
            size: 8pt,
            font: header-font,
            if title != none { title } else { [] },
          ),
          text(
            fill: p.text-muted,
            size: 8pt,
            font: header-font,
            if subtitle != none { subtitle } else { [] },
          ),
        )
        v(-2pt)
        line(length: 100%, stroke: 0.4pt + p.border)
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if not cover-page or page-num > 1 {
        align(center)[
          #text(fill: p.text-muted, size: 8.5pt, font: mono-font)[#page-num]
        ]
      }
    },
  )

  // Typography defaults: Serifs/Roman for academic document body
  set text(
    font: font,
    size: font-size,
    fill: p.text,
    lang: "en",
    hyphenate: true,
  )

  // Use SFMono Nerd Font for all raw / monospace code elements throughout the document
  show raw: set text(font: mono-font)

  set par(
    justify: false,
    leading: 0.72em,
    spacing: 1.1em,
  )

  // Headings styling (Preserves classic Roman/Serif style)
  set heading(numbering: if numbered-headings { "1.1" } else { none })
  show heading: it => {
    set text(fill: p.text)
    if it.level == 1 {
      v(20pt)
      text(
        fill: p.accent,
        weight: "bold",
        size: 18pt,
        font: font,
        it,
      )
      v(8pt)
    } else if it.level == 2 {
      v(14pt)
      text(
        fill: p.text,
        weight: "bold",
        size: 13pt,
        font: font,
        it,
      )
      v(6pt)
    } else if it.level == 3 {
      v(10pt)
      text(
        fill: p.text,
        weight: "bold",
        size: 11pt,
        font: font,
        it,
      )
      v(4pt)
    } else {
      v(8pt)
      text(weight: "bold", size: 10pt, it)
      v(3pt)
    }
  }

  // Links styling: external URLs get styled underlines; internal links (TOC, cross-refs) stay clean and active
  show link: it => {
    if type(it.dest) == str {
      set text(fill: p.accent)
      underline(stroke: 0.5pt + p.accent.lighten(40%), offset: 2pt, it)
    } else {
      // Internal links remain fully clickable without distracting underlines
      it
    }
  }

  // Outline styling
  show outline.entry: it => format-toc-entry(it, chapter-label: chapter-label, theme: theme)

  // Title section
  if title != none {
    if cover-page {
      v(1fr)
    } else {
      v(12pt)
    }

    align(center)[
      #block(width: 85%)[
        #text(
          fill: p.accent,
          size: 26pt,
          weight: "bold",
          font: font,
          title,
        )

        #if subtitle != none [
          #v(8pt)
          #text(
            fill: p.text-muted,
            size: 13pt,
            style: "italic",
            subtitle,
          )
        ]

        #if author != none [
          #v(16pt)
          #text(
            fill: p.text,
            size: 13pt,
            weight: "medium",
            if type(author) == array {
              author.join("   •   ")
            } else {
              author
            },
          )
        ]

        #if date != none [
          #v(6pt)
          #text(
            fill: p.text-muted,
            size: 10pt,
            if date == auto {
              datetime.today().display("[month repr:long] [day], [year]")
            } else {
              date
            },
          )
        ]
      ]
    ]

    if cover-page {
      if abstract != none {
        v(2fr)
        align(center)[
          #block(
            width: 80%,
            stroke: (y: 0.5pt + p.border),
            inset: (y: 12pt, x: 14pt),
            align(left)[
              #text(weight: "bold", size: 9.5pt, fill: p.accent)[Abstract]
              #v(4pt)
              #text(size: 9pt, fill: p.text, style: "italic", abstract)
            ],
          )
        ]
      }
      v(2fr)
      pagebreak()
    } else {
      v(14pt)
      line(length: 100%, stroke: 0.6pt + p.border)
      v(16pt)

      if abstract != none {
        align(center)[
          #block(
            width: 85%,
            stroke: (y: 0.5pt + p.border),
            inset: (y: 10pt, x: 12pt),
            align(left)[
              #text(weight: "bold", size: 9pt, fill: p.accent)[Abstract]
              #v(4pt)
              #text(size: 9pt, fill: p.text, style: "italic", abstract)
            ],
          )
        ]
        v(16pt)
      }
    }
  }

  // Table of Contents
  if toc {
    toc-header(title: toc-title, theme: theme)
    outline(title: none)
    if toc-pagebreak or cover-page {
      pagebreak()
    } else {
      v(20pt)
      line(length: 100%, stroke: 0.5pt + p.border)
      v(15pt)
    }
  }

  body
}
