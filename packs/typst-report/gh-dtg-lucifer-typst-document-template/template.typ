// template.typ
// Master document template for executive, engineering, and technical reports.
// Replicates the layout, typography, and visual polish of the Veritas Technical Report.

#import "components/theme.typ": current-theme, resolve-palette
#import "components/cover.typ": render-cover-page
#import "components/toc.typ": format-toc-entry, outline-divider

#let document-template(
  title: "Document Title",
  subtitle: none,
  organization: none,
  author: (),
  date: auto,
  version: none,
  domain: none,
  abstract: none,
  footer-note: none,
  confidential: "Confidential & Proprietary",
  theme: sys.inputs.at("theme", default: "light"),
  paper: "a4",
  margin: (top: 2.6cm, bottom: 2.6cm, left: 2.5cm, right: 2.5cm),
  font: ("Libertinus Serif", "New Computer Modern", "DejaVu Serif"),
  sans-font: ("Roboto", "Liberation Sans", "DejaVu Sans"),
  mono-font: ("SF Mono", "IBM Plex Mono", "DejaVu Sans Mono"),
  font-size: 10.5pt,
  cover-page: true,
  toc: true,
  toc-title: "Table of Contents",
  toc-depth: 3,
  toc-pagebreak: true,
  lof: false,
  lot: false,
  numbered-headings: true,
  body,
) = {
  // Update reactive state
  current-theme.update(theme)

  // Resolve active theme palette
  let p = resolve-palette(theme-override: theme)

  // Document metadata
  set document(
    title: if title != none {
      if type(title) == str { title } else { repr(title) }
    } else { "Technical Report" },
    author: if author != none {
      if type(author) == array { author } else if type(author) == str { (author,) } else { () }
    } else { () },
  )

  // Page geometry, header & footer
  set page(
    paper: paper,
    margin: margin,
    fill: p.page-bg,
    header: context {
      let page-num = counter(page).get().first()
      let start-page = if cover-page { 2 } else { 1 }
      if page-num >= start-page {
        grid(
          columns: (1fr, auto),
          align: (left + bottom, right + bottom),
          text(size: 8.5pt, fill: p.text-muted, font: font)[
            *#title* #if subtitle != none [ — #subtitle ]
          ],
          text(size: 8.5pt, fill: p.text-muted, font: font)[
            #if organization != none {
              organization
            } else if date == auto {
              datetime.today().display("[month repr:long] [year]")
            } else if date != none {
              str(date)
            }
          ],
        )
        v(-3pt)
        line(length: 100%, stroke: 0.4pt + p.border)
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      let start-page = if cover-page { 2 } else { 1 }
      if page-num >= start-page {
        line(length: 100%, stroke: 0.4pt + p.border)
        v(2pt)
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          text(size: 8.5pt, fill: p.text-light, font: font)[
            #if confidential != none { confidential }
          ],
          text(size: 8.5pt, fill: p.text-muted, font: font, weight: "bold")[
            Page #page-num
          ],
        )
      }
    },
  )

  // Typography defaults
  set text(
    font: font,
    size: font-size,
    fill: p.text,
    lang: "en",
    hyphenate: true,
  )

  set par(
    justify: false,
    leading: 0.72em,
    spacing: 1.1em,
  )

  // Headings styling
  set heading(numbering: if numbered-headings { "1.1" } else { none })
  show heading: it => {
    set text(font: font)
    if it.level == 1 {
      v(1.4em)
      text(size: 1.65em, weight: "bold", fill: p.primary)[#it.body]
      v(0.6em)
    } else if it.level == 2 {
      v(1.1em)
      text(size: 1.3em, weight: "bold", fill: p.text)[#it.body]
      v(0.4em)
    } else if it.level == 3 {
      v(0.8em)
      text(size: 1.1em, weight: "bold", fill: p.secondary)[#it.body]
      v(0.3em)
    } else {
      v(0.6em)
      text(size: 1.0em, weight: "bold", fill: p.text)[#it.body]
      v(0.2em)
    }
  }

  // Figure styling
  show figure: it => {
    v(0.8em)
    it
    v(0.8em)
  }

  // Monospace code blocks with line numbering & left bar
  show raw: set text(font: mono-font, size: 8.5pt)

  show raw.where(block: false): box.with(
    fill: p.code.inline-bg,
    stroke: 0.4pt + p.code.inline-border,
    radius: 3pt,
    inset: (x: 3.5pt, y: 0pt),
    outset: (y: 2.5pt),
  )

  show raw.where(block: true): it => block(
    fill: p.code.bg,
    stroke: (left: 3.5pt + p.code.bar, rest: 0.6pt + p.code.border),
    radius: (right: 4pt, left: 0pt),
    inset: (x: 10pt, y: 8pt),
    width: 100%,
    if it.lines.len() == 0 [ ] else {
      grid(
        columns: (auto, 1fr),
        column-gutter: 10pt,
        row-gutter: 3.5pt,
        ..it
          .lines
          .map(line => (
            align(right, text(fill: p.code.line-number, font: mono-font, size: 7.5pt, str(line.number))),
            line,
          ))
          .flatten()
      )
    },
  )

  // Hyperlink styling
  show link: it => {
    if type(it.dest) == str {
      set text(fill: p.primary)
      underline(stroke: 0.5pt + p.primary.lighten(30%), offset: 2pt, it)
    } else {
      it
    }
  }

  // Render Cover Page
  if cover-page {
    render-cover-page(
      title: title,
      subtitle: subtitle,
      organization: organization,
      abstract: abstract,
      domain: domain,
      version: version,
      authors: if type(author) == array { author } else { (author,) },
      date: date,
      footer-note: footer-note,
      theme: theme,
    )
    pagebreak()
  }

  // Render Outlines (Table of Contents, List of Figures, List of Tables)
  if toc {
    outline(
      title: [Table of Contents],
      indent: auto,
      depth: toc-depth,
    )

    if lof {
      outline-divider()
      outline(
        title: [List of Figures],
        target: figure.where(kind: image),
      )
    }

    if lot {
      outline-divider()
      outline(
        title: [List of Tables],
        target: figure.where(kind: table),
      )
    }

    if toc-pagebreak {
      pagebreak()
    } else {
      v(14pt)
      line(length: 100%, stroke: 0.5pt + p.border)
      v(14pt)
    }
  }

  body
}
