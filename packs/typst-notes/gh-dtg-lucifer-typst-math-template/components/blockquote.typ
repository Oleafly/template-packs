// components/blockquote.typ
// Elegant blockquotes, pull-quotes, and epigraphs with custom headers and citations

#import "theme.typ": resolve-palette

/// Blockquote component with left accent border, custom header, and citation support
/// - body: quote content
/// - title: optional custom header (e.g. "Key Insight", "Historical Note")
/// - author: optional author attribution (e.g. "Donald Knuth")
/// - source: optional source or publication (e.g. "The TeXbook")
/// - icon: whether to display a decorative quotation mark
#let blockquote(
  body,
  title: none,
  author: none,
  source: none,
  icon: true,
  bar-color: auto,
  bg-color: auto,
  text-color: auto,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    let c-bar = if bar-color == auto { p.blockquote.bar } else { bar-color }
    let c-bg = if bg-color == auto { p.blockquote.bg } else { bg-color }
    let c-title = if title != none { p.blockquote.title } else { none }
    let c-text = if text-color == auto { p.blockquote.text } else { text-color }

    v(8pt)
    block(
      width: 100%,
      stroke: (left: 3pt + c-bar),
      fill: c-bg,
      inset: (left: 14pt, right: 12pt, top: 10pt, bottom: 10pt),
      radius: (right: 3.5pt),
      breakable: true,
      {
        if title != none {
          grid(
            columns: (if icon { auto } else { 0pt }, 1fr),
            gutter: if icon { 6pt } else { 0pt },
            align: (left + horizon, left + horizon),
            if icon {
              text(fill: c-bar, size: 14pt, weight: "bold", font: ("New Computer Modern", "Libertinus Serif"), "“")
            },
            text(fill: c-title, weight: "bold", size: 10pt, title),
          )
          v(4pt)
        } else if icon {
          place(
            top + left,
            dx: -4pt,
            dy: -6pt,
            text(fill: p.blockquote.quote-mark, size: 22pt, font: ("New Computer Modern", "Libertinus Serif"), "“")
          )
        }

        block(
          inset: (left: if title == none and icon { 10pt } else { 0pt }),
          {
            text(fill: c-text, style: "italic", body)
            if author != none or source != none {
              v(5pt)
              align(right)[
                #text(fill: p.blockquote.author, size: 9pt, style: "normal")[\
                  --- #text(weight: "bold", author)
                  #if source != none [, #text(style: "italic", source)]
                ]
              ]
            }
          }
        )
      }
    )
  }
}

/// Standalone elegant pull-quote (fully center-aligned)
#let quote-box(
  body,
  author: none,
  source: none,
  width: 90%,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    v(10pt)
    align(center)[
      #block(
        width: width,
        stroke: (y: 0.8pt + p.border),
        inset: (y: 12pt, x: 16pt),
        align(center)[
          #text(
            fill: p.text,
            size: 10.5pt,
            style: "italic",
            [“#body”]
          )
          #if author != none or source != none {
            v(6pt)
            align(center)[
              #text(fill: p.text-muted, size: 9pt, style: "normal")[
                --- #text(weight: "bold", author)
                #if source != none [, #text(style: "italic", source)]
              ]
            ]
          }
        ]
      )
    ]
  }
}

/// Chapter or document epigraph spanning full width on the page
#let epigraph(
  body,
  author: none,
  source: none,
  width: 100%,
  theme: none,
) = {
  context {
    let p = resolve-palette(theme-override: theme)
    v(8pt)
    block(
      width: width,
      stroke: (left: 1.8pt + p.border),
      inset: (left: 14pt, y: 8pt),
      {
        text(fill: p.text-muted, size: 9.5pt, style: "italic", body)
        if author != none or source != none {
          v(4pt)
          align(right)[
            #text(fill: p.text-muted, size: 8.5pt, style: "normal")[
              --- #text(weight: "bold", author)
              #if source != none [, #text(style: "italic", source)]
            ]
          ]
        }
      }
    )
  }
}
