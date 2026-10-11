// =============================================================================
// Typfolio — Presentation Theme for Typst
// Corporate proposal / presentation template
// =============================================================================

// =============================================================================
// COLOR SYSTEM
// =============================================================================

#let tp-blue = rgb("#2563EB")
#let tp-dark = rgb("#1A1A1A")
#let tp-body = rgb("#4B5563")
#let tp-muted = rgb("#9CA3AF")
#let tp-surface = rgb("#F8FAFC")
#let tp-border = rgb("#E5E7EB")
#let tp-white = rgb("#FFFFFF")

// Accent colors
#let tp-red = rgb("#EF4444")
#let tp-orange = rgb("#F59E0B")
#let tp-green = rgb("#10B981")
#let tp-teal = rgb("#06B6D4")
#let tp-purple = rgb("#7C3AED")

// =============================================================================
// TYPOGRAPHY
// =============================================================================

#let tp-font = ("Pretendard",)
#let tp-base-size = 14pt

// =============================================================================
// STATE
// =============================================================================

#let _footer-left = state("tp-footer-left", none)
#let _footer-doc-type = state("tp-footer-doc-type", "PROPOSAL")
#let _slide-counter = counter("tp-slide")

// =============================================================================
// COMPONENTS
// =============================================================================

/// Badge / tag component
#let tp-badge(label, color: tp-blue, outlined: false) = {
  if outlined {
    box(
      stroke: 1pt + color,
      inset: (x: 10pt, y: 5pt),
      radius: 4pt,
      text(fill: color, size: 0.75em, weight: "medium", label),
    )
  } else {
    box(
      fill: color.lighten(85%),
      inset: (x: 10pt, y: 5pt),
      radius: 4pt,
      text(fill: color.darken(10%), size: 0.75em, weight: "bold", label),
    )
  }
}

/// Checklist item
#let tp-check-item(body, color: tp-blue) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    align: (center + top, left),
    text(fill: color, weight: "bold", size: 1em)[✓],
    body,
  )
}

/// Card component
#let tp-card(
  body,
  title: none,
  accent: none,
  fill: tp-white,
  width: 100%,
) = {
  let stroke-def = 1pt + tp-border

  block(
    width: width,
    fill: fill,
    stroke: stroke-def,
    radius: 8pt,
    inset: 1.2em,
    {
      if title != none {
        text(weight: "bold", size: 1.1em, fill: tp-dark, title)
        v(0.4em)
      }
      set text(fill: tp-body)
      body
    },
  )
}

/// Section number badge (rounded rect, blue bg, white number)
#let tp-section-badge(num) = {
  box(
    fill: tp-blue,
    radius: 8pt,
    inset: (x: 14pt, y: 10pt),
    text(fill: tp-white, weight: "bold", size: 1.1em, num),
  )
}

/// Section header component (slide top area)
#let tp-section-header(num, title, subtitle) = {
  block(
    width: 100%,
    inset: (x: 2em, top: 1em, bottom: 0pt),
    {
      grid(
        columns: (auto, 1fr),
        column-gutter: 12pt,
        align: (left + horizon, left + horizon),
        tp-section-badge(num),
        {
          text(weight: "bold", size: 1.4em, fill: tp-dark, title)
        },
      )
    },
  )
}

/// Common footer
#let tp-footer() = context {
  let footer-left-val = _footer-left.get()
  let doc-type-val = _footer-doc-type.get()
  let slide-num = _slide-counter.get().first()

  block(
    width: 100%,
    inset: (x: 2em, y: 0.8em),
    {
      set text(size: 0.65em, fill: tp-muted)
      grid(
        columns: (1fr, 1fr),
        align: (left + horizon, right + horizon),
        {
          if footer-left-val != none {
            text(weight: "bold", fill: tp-dark, footer-left-val)
          }
        },
        {
          text(tracking: 1pt, doc-type-val)
          h(12pt)
          text(fill: tp-border)[|]
          h(12pt)
          [Page ]
          text[#{ if slide-num < 10 { "0" } }#slide-num]
        },
      )
    },
  )
}

// =============================================================================
// SLIDE FUNCTIONS
// =============================================================================

/// Cover slide
#let cover-slide(
  category: none,
  title: none,
  title-accent: none,
  subtitle: none,
  quote: none,
  prepared-for: none,
  date: none,
  presented-by: none,
) = {
  pagebreak(weak: true)
  _slide-counter.step()

  block(
    width: 100%,
    height: 100%,
    fill: tp-white,
    inset: 0pt,
    {
      v(1fr)
      align(center, {
        if category != none {
          tp-badge(category, color: tp-muted, outlined: true)
          v(1.2em)
        }

        if title != none {
          if title-accent != none {
            text(size: 2.8em, weight: "black", fill: tp-dark, title)
            text(size: 2.8em, weight: "black", fill: tp-blue, title-accent)
          } else {
            text(size: 2.8em, weight: "black", fill: tp-dark, title)
          }
          v(0.4em)
        }

        if subtitle != none {
          text(size: 1.2em, fill: tp-body, subtitle)
          v(1.5em)
        }

        // Accent line
        line(length: 40pt, stroke: 2.5pt + tp-blue)
        h(4pt)
        line(length: 20pt, stroke: 2.5pt + tp-border)
        v(1.5em)

        if quote != none {
          text(size: 0.95em, fill: tp-body)[
            #text(size: 1.8em, fill: tp-muted, baseline: -3pt)[\u{201C}] #h(2pt) #quote #h(2pt) #text(size: 1.8em, fill: tp-muted, baseline: -3pt)[\u{201D}]
          ]
        }
      })
      v(1fr)

      // Bottom footer
      block(
        width: 100%,
        fill: tp-surface,
        inset: (x: 2.5em, y: 1.2em),
        {
          set text(size: 0.7em)
          grid(
            columns: (1fr, 1fr, 1fr),
            align: (left, center, right),
            {
              if prepared-for != none {
                text(fill: tp-muted, weight: "bold", tracking: 1pt, size: 0.8em)[PREPARED FOR]
                v(4pt)
                text(fill: tp-dark, weight: "bold", size: 1.1em, prepared-for)
              }
            },
            {
              if date != none {
                text(fill: tp-muted, weight: "bold", tracking: 1pt, size: 0.8em)[DATE]
                v(4pt)
                text(fill: tp-dark, weight: "medium", size: 1.1em, date)
              }
            },
            {
              if presented-by != none {
                text(fill: tp-muted, weight: "bold", tracking: 1pt, size: 0.8em)[PRESENTED BY]
                v(4pt)
                text(fill: tp-dark, weight: "bold", size: 1.1em, presented-by)
              }
            },
          )
        },
      )
    },
  )
}

/// Table of contents slide
#let toc-slide(
  title: "TABLE OF CONTENTS",
  description: none,
  items: (),
  contact-phone: none,
  contact-email: none,
) = {
  pagebreak(weak: true)
  _slide-counter.step()

  block(
    width: 100%,
    height: 100%,
    fill: tp-white,
    {
      grid(
        columns: (1fr, 2fr),
        rows: (100%,),
        // Left blue panel
        block(
          width: 100%,
          height: 100%,
          fill: tp-blue,
          inset: 2em,
          {
            v(3em)
            text(fill: tp-white.transparentize(60%), size: 1.5em)[≡]
            v(1.5em)
            text(
              fill: tp-white,
              weight: "black",
              size: 2.2em,
              tracking: -0.5pt,
              title,
            )
            v(1.5em)
            if description != none {
              text(fill: tp-white.transparentize(20%), size: 0.85em, description)
            }
          },
        ),
        // Right content
        block(
          width: 100%,
          height: 100%,
          inset: (x: 2.5em, y: 2em),
          {
            v(1em)
            for i in range(0, items.len(), step: 2) {
              let left-item = items.at(i)
              let right-item = if i + 1 < items.len() { items.at(i + 1) } else { none }

              grid(
                columns: (1fr, 1fr),
                column-gutter: 2em,
                {
                  grid(
                    columns: (auto, 1fr),
                    column-gutter: 10pt,
                    align: (right, left),
                    text(fill: tp-blue, weight: "black", size: 1.6em, left-item.at("num")),
                    {
                      text(fill: tp-dark, weight: "bold", size: 1em, left-item.at("title"))
                      linebreak()
                      text(fill: tp-muted, size: 0.75em, left-item.at("desc"))
                    },
                  )
                  v(0.3em)
                  line(length: 100%, stroke: 0.5pt + tp-border)
                },
                {
                  if right-item != none {
                    grid(
                      columns: (auto, 1fr),
                      column-gutter: 10pt,
                      align: (right, left),
                      text(fill: tp-blue, weight: "black", size: 1.6em, right-item.at("num")),
                      {
                        text(fill: tp-dark, weight: "bold", size: 1em, right-item.at("title"))
                        linebreak()
                        text(fill: tp-muted, size: 0.75em, right-item.at("desc"))
                      },
                    )
                    v(0.3em)
                    line(length: 100%, stroke: 0.5pt + tp-border)
                  }
                },
              )
              v(1em)
            }

            v(1fr)

            if contact-phone != none or contact-email != none {
              set text(size: 0.75em, fill: tp-body)
              grid(
                columns: (1fr, 1fr),
                column-gutter: 2em,
                {
                  if contact-phone != none {
                    text(weight: "medium")[📞 #contact-phone]
                  }
                },
                {
                  if contact-email != none {
                    text(weight: "medium")[✉ #h(4pt) #contact-email]
                  }
                },
              )
            }
          },
        ),
      )
    },
  )
}

/// Content slide
#let content-slide(
  section-num: "01",
  section-title: "",
  section-subtitle: "",
  body,
) = {
  pagebreak(weak: true)
  _slide-counter.step()

  block(
    width: 100%,
    height: 100%,
    fill: tp-white,
    {
      // Section header
      tp-section-header(section-num, section-title, section-subtitle)

      // Thin separator line
      v(-0.3em)
      line(length: 100%, stroke: 0.5pt + tp-border)

      // Content area
      block(
        width: 100%,
        inset: (x: 2.5em, top: 0.2em, bottom: 0em),
        {
          set text(fill: tp-body, size: tp-base-size)
          body
        },
      )

      v(1fr)

      // Footer
      line(length: 100%, stroke: 0.5pt + tp-border.lighten(50%))
      tp-footer()
    },
  )
}

/// Comparison table component
#let tp-comparison-table(
  headers: (),
  rows: (),
  highlight-col: none,
  col-widths: none,
) = {
  let col-count = headers.len()
  let cols = if col-widths != none {
    col-widths
  } else {
    // First column narrower (category label), rest equal
    if col-count == 3 { (1.2fr, 1.8fr, 1.8fr) }
    else { range(col-count).map(_ => 1fr) }
  }

  // Build all cells: header row first, then data rows
  let header-cells = headers.enumerate().map(((i, h)) => {
    let is-hl = highlight-col != none and i == highlight-col
    table.cell(
      fill: if is-hl { tp-blue } else { tp-dark },
      text(fill: tp-white, weight: "bold", size: 0.85em, h),
    )
  })

  let data-cells = rows.enumerate().map(((row-idx, row)) => {
    let row-bg = if calc.rem(row-idx, 2) == 0 { tp-white } else { luma(248) }
    row.enumerate().map(((i, cell)) => {
      let is-hl = highlight-col != none and i == highlight-col
      table.cell(
        fill: row-bg,
        {
          set text(size: 0.82em)
          if is-hl {
            set text(fill: tp-blue, weight: "semibold")
            cell
          } else if i == 0 {
            set text(fill: tp-dark, weight: "semibold")
            cell
          } else {
            set text(fill: tp-body)
            cell
          }
        },
      )
    })
  }).flatten()

  block(
    width: 100%,
    radius: 8pt,
    clip: true,
    stroke: 1pt + tp-border,
    table(
      columns: cols,
      inset: (x: 1.2em, y: 0.9em),
      stroke: (x, y) => {
        // Vertical dividers between columns only (no outer border, handled by block)
        if x > 0 and x < col-count { (left: 0.5pt + tp-border) }
        // Horizontal dividers between data rows only
        else if y > 1 { (top: 0.5pt + tp-border) }
      },
      ..header-cells,
      ..data-cells,
    ),
  )
}

/// Section divider slide (transition page)
#let section-divider-slide(
  num: "01",
  title: "",
  subtitle: "",
  description: none,
) = {
  pagebreak(weak: true)
  _slide-counter.step()

  block(
    width: 100%,
    height: 100%,
    fill: tp-blue,
    {
      // Top-right decoration
      place(
        top + right,
        dx: -3em,
        dy: 2em,
        {
          line(length: 40pt, stroke: 2.5pt + tp-white.transparentize(40%))
          h(4pt)
          line(length: 20pt, stroke: 2.5pt + tp-white.transparentize(70%))
        },
      )

      v(1.5fr)
      block(
        width: 100%,
        inset: (x: 4em),
        {
          // Large number
          text(size: 5em, weight: "black", fill: tp-white.transparentize(70%), num)
          v(0.5em)
          // Title
          text(size: 2.4em, weight: "black", fill: tp-white, title)
          v(0.3em)
          // Subtitle
          text(
            size: 0.9em,
            fill: tp-white.transparentize(30%),
            weight: "medium",
            tracking: 1pt,
            upper(subtitle),
          )
          if description != none {
            v(1em)
            block(
              width: 60%,
              text(size: 0.85em, fill: tp-white.transparentize(20%), description),
            )
          }
        },
      )
      v(1fr)

      // Bottom bar
      block(width: 100%, height: 4pt, fill: tp-white.transparentize(60%))
    },
  )
}

/// Closing slide
#let closing-slide(
  quote: none,
  quote-accent: none,
  description: none,
  contacts: (),
  copyright: none,
) = {
  pagebreak(weak: true)
  _slide-counter.step()

  block(
    width: 100%,
    height: 100%,
    fill: tp-white,
    {
      v(1fr)

      align(center, {
        if quote != none {
          text(size: 2em, weight: "black", fill: tp-dark, quote)
          if quote-accent != none {
            linebreak()
            text(size: 2em, weight: "black", fill: tp-blue, quote-accent)
          }
          v(1em)
        }

        if description != none {
          block(width: 70%, text(size: 0.9em, fill: tp-body, description))
          v(2em)
        }
      })

      // Contact cards
      if contacts.len() > 0 {
        block(
          width: 100%,
          inset: (x: 4em),
          {
            grid(
              columns: contacts.map(_ => 1fr),
              column-gutter: 1.5em,
              ..contacts.map(c => {
                block(
                  width: 100%,
                  stroke: 1pt + tp-border,
                  radius: 8pt,
                  inset: 1.5em,
                  align(center, {
                    text(size: 1.8em)[#c.at("icon", default: "")]
                    v(0.6em)
                    text(
                      fill: tp-muted,
                      size: 0.65em,
                      weight: "bold",
                      tracking: 1pt,
                      upper(c.at("label")),
                    )
                    v(0.3em)
                    text(fill: tp-dark, weight: "bold", size: 0.9em, c.at("value"))
                    v(0.3em)
                    line(length: 30pt, stroke: 2pt + tp-blue)
                  }),
                )
              })
            )
          },
        )
      }

      v(1fr)

      if copyright != none {
        align(center, text(size: 0.6em, fill: tp-muted, copyright))
        v(0.8em)
      }

      // Bottom accent bar
      block(width: 100%, height: 4pt, fill: tp-blue)
    },
  )
}

// =============================================================================
// PRESENTATION INITIALIZER
// =============================================================================

/// Presentation initializer (show rule entry point)
#let tp-presentation(
  aspect-ratio: "16-9",
  footer-left: none,
  doc-type: "PROPOSAL",
  body,
) = {
  set text(font: tp-font, size: tp-base-size, lang: "ko")
  set strong(delta: 200)
  set par(leading: 0.7em)

  set page(
    paper: "presentation-" + aspect-ratio,
    fill: tp-white,
    margin: 0em,
  )

  show heading.where(level: 1): set text(size: 1.4em, weight: "bold", fill: tp-dark)
  show heading.where(level: 2): set text(size: 1.2em, weight: "bold", fill: tp-dark)
  show heading.where(level: 3): set text(size: 1em, weight: "bold", fill: tp-dark)

  _footer-left.update(footer-left)
  _footer-doc-type.update(doc-type)

  body
}
