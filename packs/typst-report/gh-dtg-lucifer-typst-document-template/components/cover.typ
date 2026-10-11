// components/cover.typ
// Signature Executive / Technical Report Cover Page from the Veritas Project.
// Features a rounded border container, uppercase tracking kicker, centered title, abstract block, metadata grid, and status footer.

#import "theme.typ": resolve-palette, current-theme

#let render-cover-page(
  title: "Document Title",
  subtitle: none,
  organization: "TECHNICAL REPORT",
  abstract: none,
  domain: none,
  version: none,
  authors: (),
  date: auto,
  footer-note: none,
  theme: none,
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)
  let c = p.cover

  align(center + horizon)[
    #block(
      fill: c.card-bg,
      stroke: 1.5pt + p.primary,
      radius: 12pt,
      inset: (x: 28pt, y: 36pt),
      width: 100%,
      [
        #if organization != none [
          #text(size: 13pt, tracking: 3pt, weight: "bold", fill: p.secondary)[#upper(organization)]
          #v(8pt)
          #line(length: 35%, stroke: 1.5pt + p.secondary)
          #v(14pt)
        ]

        #text(size: 30pt, weight: "bold", fill: p.primary)[#title]

        #if subtitle != none [
          #v(8pt)
          #text(size: 14pt, weight: "medium", fill: c.sub-text)[#subtitle]
        ]

        #if abstract != none [
          #v(20pt)
          #block(
            fill: c.abstract-bg,
            stroke: 0.8pt + c.abstract-border,
            radius: 6pt,
            inset: 12pt,
            width: 92%,
            [
              #text(size: 9.5pt, style: "italic", fill: c.abstract-text)[#abstract]
            ]
          )
        ]

        #v(28pt)
        // Metadata grid
        #let meta-columns = ()
        #let meta-items = ()

        #if domain != none {
          meta-items.push([
            #text(weight: "bold", size: 9pt, fill: c.meta-header, tracking: 1pt)[SYSTEM DOMAIN]\
            #v(2pt)
            #text(size: 9.5pt, fill: c.meta-text)[#domain]
          ])
        }

        #if version != none {
          meta-items.push([
            #text(weight: "bold", size: 9pt, fill: c.meta-header, tracking: 1pt)[DOCUMENT VERSION]\
            #v(2pt)
            #text(size: 9.5pt, fill: c.meta-text)[#version]
          ])
        }

        #if authors.len() > 0 {
          let author-str = if type(authors) == array { authors.join(", ") } else { authors }
          meta-items.push([
            #text(weight: "bold", size: 9pt, fill: c.meta-header, tracking: 1pt)[AUTHORS / CONTRIBUTORS]\
            #v(2pt)
            #text(size: 9.5pt, fill: c.meta-text)[#author-str]
          ])
        }

        #if meta-items.len() > 0 {
          let col-count = calc.min(meta-items.len(), 3)
          grid(
            columns: (1fr,) * col-count,
            gutter: 14pt,
            align: (center,) * col-count,
            ..meta-items
          )
        }

        #v(22pt)
        #line(length: 75%, stroke: 0.5pt + p.border)
        #v(10pt)

        #let date-str = if date == auto {
          datetime.today().display("[month repr:long] [year]")
        } else if date != none {
          str(date)
        } else {
          none
        }

        #let footer-items = ()
        #if date-str != none { footer-items.push([Date: #date-str]) }
        #if footer-note != none { footer-items.push(footer-note) }

        #if footer-items.len() > 0 [
          #text(size: 8.5pt, fill: c.footer-text)[
            #footer-items.join([ $dot$ ])
          ]
        ]
      ]
    )
  ]
}
