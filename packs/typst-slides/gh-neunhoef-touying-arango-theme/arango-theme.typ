// ╔══════════════════════════════════════════════════════════════════╗
// ║  arango-theme.typ — Arango-branded Touying slide theme           ║
// ║  Based on the official Arango Google Slides template             ║
// ║  Usage: #import "arango-theme.typ": *                            ║
// ╚══════════════════════════════════════════════════════════════════╝

#import "@preview/touying:0.6.1": *

// ── Color Palette ────────────────────────────────────────────────
#let arango-dark     = rgb("#0d3b1e")   // dark green (backgrounds, headings)
#let arango-medium   = rgb("#145a2f")   // medium green (card headers)
#let arango-light-bg = rgb("#f0f5eb")   // off-white/light green (content bg)
#let arango-white    = rgb("#ffffff")
#let arango-lime     = rgb("#b8e600")   // lime accent
#let arango-green    = rgb("#7acc29")   // green accent / borders
#let arango-teal     = rgb("#2a9d8f")   // teal for bullet markers
#let arango-text     = rgb("#2d2d2d")   // body text on light
#let arango-muted    = rgb("#6b7b6e")   // muted / secondary text
#let arango-border   = rgb("#7acc29")   // card border color

#let blue(content) = text(fill: rgb("#2a6fdb"))[#content]
#let red(content) = text(fill: rgb("#e63946"))[#content]

// ── Helper: Arango-style card box ────────────────────────────────
// Replicates the rounded cards with green header from the template
#let arango-card(title: none, body-content) = {
  block(
    width: 100%,
    radius: 12pt,
    clip: true,
    stroke: 1pt + arango-border,
  )[
    #if title != none {
      block(
        width: 100%,
        fill: arango-medium,
        inset: (x: 16pt, y: 10pt),
      )[
        #text(fill: arango-lime, weight: "semibold", size: 0.85em)[#title]
      ]
    }
    #block(
      width: 100%,
      fill: arango-light-bg,
      inset: 16pt,
    )[
      #v(-1cm)
      #body-content
    ]
  ]
}

// ── Helper: numbered step item (for "Next Steps" style slides) ───
#let arango-step(number: 1, title: none, description: none) = {
  block(
    width: 100%,
    radius: 10pt,
    fill: arango-light-bg,
    inset: (x: 20pt, y: 14pt),
    stroke: 0.5pt + arango-border.lighten(50%),
  )[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 16pt,
      align: (horizon, horizon),
      text(
        fill: arango-medium,
        weight: "light",
        size: 1.6em,
        font: "Urbanist",
      )[#if number < 10 [0#number] else [#number]],
      [
        #if title != none {
          text(weight: "bold", size: 1.05em)[#title]
        }
        #if description != none {
          v(2pt)
          text(fill: arango-muted, size: 0.85em)[#description]
        }
      ],
    )
  ]
}

// ── Helper: quote slide content ──────────────────────────────────
#let arango-quote(body, author: none, role: none) = {
  set text(size: 1.8em, weight: "light", font: "Urbanist")
  [
    #body

    #if author != none {
      v(24pt)
      text(fill: arango-lime, size: 0.45em, weight: "bold")[#author]
      if role != none {
        linebreak()
        text(fill: arango-muted, size: 0.35em, weight: "regular")[#role]
      }
    }
  ]
}

// ── Helper: highlight box (lime background for key phrases) ──────
#let lime-highlight(content) = {
  box(
    fill: arango-lime,
    inset: (x: 4pt, y: 2pt),
    radius: 2pt,
  )[#text(fill: arango-dark, weight: "bold")[#content]]
}

// ── Slide constructors ───────────────────────────────────────────

// Title slide (dark green background, like pages 2/4 in template)
#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  date: none,
  logo: image("arango-logo-stack-rev.png", width: 15%),
) = touying-slide-wrapper(self => {
  let body = {
    set page(fill: arango-dark, margin: 0pt)
    set text(fill: white, font: "Urbanist")
    block(
      width: 100%,
      height: 100%,
      inset: (x: 60pt, y: 50pt),
    )[
      // Logo area
      #if logo != none {
        logo
      } else {
        text(size: 28pt, weight: "bold", fill: white)[
          #text(fill: arango-lime)[●] Arango#text(fill: arango-lime)[.]
        ]
      }

      #v(1fr)

      // Title
      #if title != none {
        text(size: 36pt, weight: "bold", fill: arango-lime)[#title]
      }

      // Subtitle
      #if subtitle != none {
        v(8pt)
        text(size: 20pt, weight: "regular", fill: white.darken(10%))[#subtitle]
      }

      #v(1fr)

      // Author & date
      #set text(size: 14pt, fill: white.darken(25%))
      #if author != none [#author]
      #if date != none {
        linebreak()
        [#date]
      }
      #v(10pt)
    ]
  }
  touying-slide(self: self, body)
})

// Section divider slide (dark green, large centered text)
#let section-slide(title: none, subtitle: none) = touying-slide-wrapper(self => {
  let body = {
    set page(fill: arango-dark, margin: 0pt)
    set text(fill: white, font: "Urbanist")
    set align(horizon)
    block(
      width: 100%,
      height: 100%,
      inset: (x: 80pt, y: 60pt),
    )[
      #set align(left + horizon)
      #if title != none {
        text(size: 44pt, weight: "bold")[#title]
      }
      #if subtitle != none {
        v(12pt)
        text(size: 22pt, weight: "light", fill: arango-lime)[#subtitle]
      }
    ]
  }
  touying-slide(self: self, body)
})

// Thank-you / closing slide (dark green, centered)
#let closing-slide(
  title: "Thank You",
  subtitle: none,
  logo: image("arango-logo-stack-rev.png", width: 15%),
) = touying-slide-wrapper(self => {
  let body = {
    set page(fill: arango-dark, margin: 0pt)
    set text(fill: white, font: "Urbanist")
    set align(center + horizon)
    block(width: 100%, height: 100%)[
      #set align(center + horizon)
      #text(size: 48pt, weight: "bold")[#title]
      #if subtitle != none {
        v(20pt)
        text(size: 24pt, fill: arango-lime)[#subtitle]
      }
      #v(30pt)
      #if logo != none {
        logo
      } else {
        text(size: 28pt, weight: "bold")[
          #text(fill: arango-lime)[●] Arango#text(fill: arango-lime)[.]
        ]
      }
    ]
  }
  touying-slide(self: self, body)
})

// Light-background slide with a title bar (arango-light-bg + dark title strip)
#let light-slide(title: utils.display-current-heading(
          setting: utils.fit-to-width.with(grow: false, 100%),
          level: 2,
        ), body) = touying-slide-wrapper(self => {
  let slide-body = {
    set page(fill: arango-light-bg, margin: 0pt)
    set text(fill: arango-text, font: "Urbanist")
    block(width: 100%, height: 100%)[
      // Title bar
      #if title != none {
        block(
          width: 100%,
          fill: arango-dark,
          inset: (x: 60pt, y: 18pt),
        )[
          #text(size: 28pt, weight: "bold", fill: arango-lime)[#title]
        ]
      }
      // Content area
      #block(
        width: 100%,
        inset: (x: 60pt, top: 28pt, bottom: 50pt),
      )[
        #v(-1cm)
        #body
      ]
    ]
  }
  touying-slide(self: self, slide-body)
})

// ── Theme registration ───────────────────────────────────────────
#let arango-theme(
  aspect-ratio: "16-9",
  footer-logo: image("arango-logo-horz.png", width: 25%),
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      fill: arango-white,
      margin: (top: 70pt, bottom: 50pt, x: 60pt),
      footer: {
        set text(size: 9pt, fill: arango-muted, font: "Urbanist")
        block(
          width: 100%,
          inset: (x: 60pt, bottom: 12pt),
        )[
          #grid(
            columns: (1fr, 1fr, 1fr),
            align: (left, center, right),
            [
              #if footer-logo != none {
                footer-logo
              } else {
                text(size: 10pt, weight: "bold", fill: arango-dark)[
                  #text(fill: arango-green)[●] Arango#text(fill: arango-green)[.]
                ]
              }
            ],
            [© arango.ai 2026],
            [
              #context {
                let page-num = counter(page).get().first()
                str(page-num)
              }
            ],
          )
        ]
      },
      header: none,
    ),
    config-common(
      slide-fn: slide,
      // Heading-based slide creation:
      // = Section Title  → creates a section divider
      // == Slide Title   → creates a content slide
    ),
    config-methods(
      init: (self: none, body) => {
        // Global text settings
        set text(
          font: ("Urbanist", "Noto Sans", "Liberation Sans", "DejaVu Sans"),
          size: 20pt,
          fill: arango-text,
        )

        // Heading styles matching the template
        show heading.where(level: 1): set text(
          fill: arango-dark,
          size: 32pt,
          weight: "bold",
          font: "Urbanist",
        )
        show heading.where(level: 2): set text(
          fill: arango-muted,
          size: 20pt,
          weight: "regular",
          font: "Urbanist",
        )
        show heading.where(level: 3): set text(
          fill: arango-dark,
          size: 18pt,
          weight: "bold",
          font: "Urbanist",
        )

        // List styling — teal square markers like the template
        set list(
          marker: text(fill: arango-teal)[■],
          indent: 0.8em,
          body-indent: 0.5em,
        )

        // Table styling matching the template (page 25)
        set table(
          stroke: none,
          inset: (x: 12pt, y: 10pt),
          fill: (_, row) => if row == 0 { none } else if calc.odd(row) { arango-light-bg } else { none },
        )
        show table.cell.where(y: 0): set text(weight: "bold", fill: arango-dark)
        show table.cell.where(y: 0): it => {
          block(
            width: 100%,
            inset: (x: 12pt, y: 10pt),
            below: 0pt,
            stroke: (bottom: 2pt + arango-teal),
          )[#it.body]
        }

        // Strong text in arango-dark
        show strong: set text(fill: arango-dark, weight: "bold")

        // Link styling
        show link: set text(fill: arango-medium)
        show link: underline

        // Code blocks
        show raw.where(block: true): it => {
          block(
            width: 100%,
            fill: arango-dark,
            radius: 8pt,
            inset: 16pt,
          )[
            #set text(fill: white, size: 0.75em, font: "Fira Code")
            #it
          ]
        }

        show raw.where(block: false): it => {
          box(
            fill: arango-light-bg,
            inset: (x: 5pt, y: 2pt),
            radius: 3pt,
          )[
            #set text(fill: arango-medium, size: 0.9em, font: "Fira Code")
            #it
          ]
        }

        body
      },
    ),
    ..args,
  )
  body
}
