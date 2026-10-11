// UdS Polylux Theme
// Typst port of beamerthemeUdS.sty

#import "@preview/polylux:0.4.0": *

// --- UdS Colors (RGB) ---
#let uds-blau       = rgb(0, 72, 119)
#let uds-rot        = rgb(200, 34, 84)
#let uds-gelb       = rgb(215, 223, 35)
#let uds-dunkelblau = rgb(1, 40, 63)
#let uds-grau       = rgb(110, 110, 110)
#let uds-hgrau      = rgb(145, 145, 145)
#let uds-hhgrau     = rgb(190, 190, 190)
#let uds-hhhgrau    = rgb(230, 230, 230)

// --- Slide dimensions (4:3 from beamer) ---
#let slide-width  = 254mm
#let slide-height = 190.5mm
#let left-margin  = 34mm   // 0.1338 * 254mm
#let right-margin = 28.4mm // 0.112 * 254mm

// --- Top color bar heights ---
#let rot-bar-height  = 1.25mm
#let gelb-bar-height = 0.60mm
#let rot-bar-frac    = 0.78  // rot covers 78% of width

// --- Footer dimensions ---
#let footer-height    = 11mm
#let footer-rule-height = 1.6mm
#let footer-separator-width = 0.2mm
#let footer-total = footer-height + footer-rule-height

// --- Logo ---
#let logo-width = 27.5mm

// --- Global state for footer fields ---
#let _short-author = state("uds-short-author", none)
#let _short-title  = state("uds-short-title", none)
#let _short-date   = state("uds-short-date", none)

// Keep a reference to polylux's slide function
#let _polylux-slide = slide

// ============================================================
// Header decoration (top color bars + logo)
// ============================================================

#let _header(logo-path) = {
  let rot-width  = rot-bar-frac * slide-width
  let gelb-width = (1 - rot-bar-frac) * slide-width

  // Red bar + yellow bar (aligned at top, different heights)
  place(top + left, dx: -left-margin, dy: -14mm, {
    box(width: slide-width, height: rot-bar-height, {
      place(top + left,
        rect(width: rot-width, height: rot-bar-height, fill: uds-rot, stroke: none),
      )
      place(top + left, dx: rot-width,
        rect(width: gelb-width, height: gelb-bar-height, fill: uds-gelb, stroke: none),
      )
    })
  })

  // Logo in top-right
  place(top + right, dx: right-margin - 15mm, dy: -3mm,
    image(logo-path, width: logo-width),
  )
}

// ============================================================
// Footer
// ============================================================

#let _footer() = {
  // Footer is placed flush at the page bottom.
  // Thin dunkelblau rule — flush on top of the footer bar
  place(bottom + left, dx: -left-margin, dy: footer-rule-height,
    rect(width: slide-width, height: footer-rule-height, fill: uds-dunkelblau, stroke: none),
  )
  // Main footer bar (blau) — at the very bottom of the page
  place(bottom + left, dx: -left-margin, dy: footer-total,
    box(width: slide-width, height: footer-height, fill: uds-blau, {
      set text(fill: white, size: 11pt)
      let date-col-width = left-margin
      let page-col-width = right-margin
      let mid-width = slide-width - date-col-width - page-col-width

      // Date column
      place(left + horizon, dx: 0mm, {
        box(width: date-col-width, height: footer-height, {
          align(center + horizon, {
            context _short-date.get()
          })
        })
      })

      // Separator after date
      place(left + horizon, dx: date-col-width, {
        rect(width: footer-separator-width, height: footer-height, fill: white, stroke: none)
      })

      // Author: Title column
      place(left + horizon, dx: date-col-width + 2.5mm, {
        box(width: mid-width - 5mm, height: footer-height, {
          align(left + horizon, context {
            let sa = _short-author.get()
            let st = _short-title.get()
            if sa != none { sa }
            if sa != none and st != none { ": " }
            if st != none { st }
          })
        })
      })

      // Separator before page number
      place(left + horizon, dx: date-col-width + mid-width, {
        rect(width: footer-separator-width, height: footer-height, fill: white, stroke: none)
      })

      // Page number
      place(left + horizon, dx: date-col-width + mid-width + 6mm, {
        box(width: page-col-width - 6mm, height: footer-height, {
          align(left + horizon, {
            toolbox.slide-number
          })
        })
      })
    }),
  )
}

// ============================================================
// Theme entry point
// ============================================================

#let uds-theme(
  short-author: none,
  short-title: none,
  short-date: none,
  logo-path: "UdS_Logo_4c.pdf",
  body,
) = {
  set page(
    width: slide-width,
    height: slide-height,
    margin: (
      left: left-margin,
      top: 14mm,
      right: right-margin,
      bottom: footer-total,
    ),
  )

  set text(font: "TeX Gyre Heros", size: 20pt, fill: uds-blau)
  set par(leading: 0.6em, spacing: 0.6em)

  _short-author.update(short-author)
  _short-title.update(short-title)
  _short-date.update(short-date)

  body
}

// ============================================================
// Content slide
// ============================================================

#let uds-slide(
  title: none,
  logo-path: "UdS_Logo_4c.pdf",
  body,
) = {
  _polylux-slide[
    #_header(logo-path)

    #if title != none {
      // LaTeX frametitle uses leftskip = -beamer@leftmargin + 10mm = -24mm
      pad(left: -24mm, text(size: 26pt, fill: uds-blau, weight: "regular", title))
      v(6mm)
    }

    #body

    #_footer()
  ]
}

// ============================================================
// Title slide
// ============================================================

#let title-slide(
  title: none,
  subtitle: none,
  author: none,
  institute: none,
  date: none,
  logo-path: "UdS_Logo_4c.pdf",
  owl-path: "UdS_Eule.pdf",
) = {
  // Title slide: no top bars, no footer, large owl on left.
  // UdS_Eule.pdf is pre-cropped from UdS_Logo_4c.pdf (trim=63 0 260.708 0 pt).
  set page(margin: 0mm)
  _polylux-slide[
    // Large owl on the left side
    #place(top + left,
      image(owl-path, height: slide-height),
    )

    // Small logo in top-right
    // The LaTeX \lower21mm is from the header baseline; effective position is ~7mm from page top.
    #place(top + right, dx: -(right-margin - logo-width / 2), dy: 11mm,
      image(logo-path, width: logo-width),
    )

    // Title block: LaTeX uses \vbox to20mm{\vss} + \vskip0bp plus3fill,
    // then beamercolorboxes with sep=8pt for each field, then \vskip0bp plus1fill.
    // Each beamercolorbox[sep=8pt] adds 8pt padding top+bottom.
    // Font sizes: title=\LARGE(32bp), subtitle=\small(18bp), author=\small(18bp), date=\scriptsize(14bp).
    // leftskip = 93mm - beamer@leftmargin = 59mm within each box.
    #pad(left: 93mm, right: right-margin, {
      set text(fill: uds-blau)
      v(90mm)
      // Title beamercolorbox [sep=8pt]
      if title != none {
        pad(top: 8pt, bottom: 8pt, text(size: 32pt, weight: "regular", title))
      }
      // Subtitle (inside same box as title, with \vskip15mm before it)
      if subtitle != none {
        v(15mm)
        pad(top: 8pt, bottom: 8pt, text(size: 18pt, subtitle))
      }
      // \vskip1em\par (1em at normalsize=20bp, plus \parskip=6bp)
      // v(1em)
      // Author beamercolorbox [sep=8pt]
      if author != none {
        pad(top: 8pt, bottom: 8pt, text(size: 18pt, author))
      }
      // Institute beamercolorbox [sep=8pt]
      if institute != none {
        pad(top: 8pt, bottom: 8pt, text(size: 18pt, institute))
      }
      // Date beamercolorbox [sep=8pt]
      if date != none {
        pad(top: 8pt, bottom: 8pt, text(size: 14pt, date))
      }
      v(1fr)
    })
  ]
}

// ============================================================
// Section slides (colored background: rot, gelb, dunkelblau)
// ============================================================

#let section-slide(
  color: uds-rot,
  body,
) = {
  // Full-color background above the footer. No header bars.
  let text-color = if color == uds-gelb { uds-blau } else { white }
  _polylux-slide[
    // Colored background covering everything above the footer
    #place(top + left, dx: -left-margin, dy: -14mm,
      rect(width: slide-width, height: slide-height - footer-total, fill: color, stroke: none),
    )

    // Centered content
    #set text(fill: text-color)
    #set align(center + horizon)
    #v(-20mm)
    #body

    #_footer()
  ]
}

// ============================================================
// Part/Eule slide (owl peeking from bottom)
// ============================================================

#let eule-slide(
  owl-bottom-path: "UdS_Eule_unten.pdf",
  body,
) = {
  _polylux-slide[
    // Owl peeking from the bottom center
    #place(bottom + center, dy: footer-total - 10mm,
      image(owl-bottom-path, width: 126mm),
    )

    // Centered content in upper portion
    #set align(center)
    #v(1em)
    #body

    #_footer()
  ]
}

// ============================================================
// Final/Abschluss slide (full logo centered + message)
// ============================================================

#let final-slide(
  message: "Vielen Dank für Ihre Aufmerksamkeit.",
  logo-path: "UdS_Logo_4c.pdf",
) = {
  // No header, no footer — plain slide
  set page(margin: 0mm)
  _polylux-slide[
    #set align(center)
    #set text(fill: uds-blau)
    #v(0.8fr)
    #image(logo-path, width: 100mm)
    #v(15mm)
    #text(size: 36pt, message)
    #v(1fr)
  ]
}

// ============================================================
// Block environments (block, alertblock, exampleblock)
// ============================================================

#let uds-block(title: none, body) = {
  v(6pt)
  // Title bar: white text on blau
  if title != none {
    block(width: 100%, fill: uds-blau, inset: 5pt,
      text(fill: white, title),
    )
  }
  // Body: black text on hhhgrau
  block(width: 100%, fill: uds-hhhgrau, inset: 5pt, above: 0pt,
    text(fill: black, body),
  )
  v(3pt)
}

#let uds-alertblock(title: none, body) = {
  v(6pt)
  if title != none {
    block(width: 100%, fill: uds-rot, inset: 5pt,
      text(fill: white, title),
    )
  }
  block(width: 100%, fill: uds-hhhgrau, inset: 5pt, above: 0pt,
    text(fill: black, body),
  )
  v(3pt)
}

#let uds-exampleblock(title: none, body) = {
  v(6pt)
  if title != none {
    block(width: 100%, fill: uds-gelb, inset: 5pt,
      text(fill: black, title),
    )
  }
  block(width: 100%, fill: uds-hhhgrau, inset: 5pt, above: 0pt,
    text(fill: black, body),
  )
  v(3pt)
}
