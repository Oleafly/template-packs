// components/boxes.typ
// Versatile container boxes, metric cards, and dashboard-style telemetry widgets.

#import "theme.typ": resolve-palette, current-theme

// Left-Bar Container Box
#let left-bar-box(
  bar-color: none,
  bg-color: none,
  border-color: none,
  radius: 4pt,
  inset: (x: 14pt, y: 11pt),
  width: 100%,
  body
) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let bar = if bar-color != none { bar-color } else { p.primary }
  let bg = if bg-color != none { bg-color } else { p.code.bg }
  let border = if border-color != none { border-color } else { p.border }

  rect(
    width: width,
    radius: radius,
    fill: bg,
    stroke: (left: 3.5pt + bar, rest: 0.5pt + border),
    inset: inset,
    body
  )
}

// Card Box with optional header, badge, and footer
#let card-box(
  title: none,
  label: none,
  footer: none,
  border-color: none,
  fill-color: none,
  radius: 6pt,
  width: 100%,
  body
) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let bg = if fill-color != none { fill-color } else { p.code.bg }
  let border = if border-color != none { border-color } else { p.border }

  block(
    fill: bg,
    stroke: 0.6pt + border,
    radius: radius,
    width: width,
    inset: 0pt,
    clip: true,
    [
      #if title != none or label != none [
        #block(
          width: 100%,
          fill: if p.mode == "dark" { rgb("#131c2e") } else { rgb("#f1f5f9") },
          inset: (x: 12pt, y: 8pt),
          stroke: (bottom: 0.5pt + border),
          [
            #grid(
              columns: (1fr, auto),
              align: (left + horizon, right + horizon),
              if title != none [
                #text(weight: "bold", size: 9.5pt, fill: p.text)[#title]
              ] else [ ],
              if label != none [
                #text(size: 7.5pt, weight: "bold", fill: p.primary, tracking: 1pt)[#label]
              ] else [ ]
            )
          ]
        )
      ]
      #block(
        width: 100%,
        inset: (x: 12pt, y: 10pt),
        text(fill: p.text, size: 9pt)[#body]
      )
      #if footer != none [
        #block(
          width: 100%,
          fill: if p.mode == "dark" { rgb("#0a0f1d") } else { rgb("#f8fafc") },
          inset: (x: 12pt, y: 6pt),
          stroke: (top: 0.5pt + border),
          text(size: 8pt, fill: p.text-muted)[#footer]
        )
      ]
    ]
  )
}

// Executive KPI / Metric Card
// Displays high-level status, numerical metrics, trend uplifts, and explanatory subtitles
#let metric-card(
  title: "Metric Title",
  value: "0.00",
  change: none,          // e.g. "+16.26% Uplift"
  change-positive: true, // true -> green, false -> red
  note: none,            // descriptive note beneath the value
  width: 100%,
  theme: none,
) = context {
  let active-theme = if theme != none { theme } else { current-theme.get() }
  let p = resolve-palette(theme-override: active-theme)

  let is-dark = p.mode == "dark"
  let change-color = if change-positive {
    if is-dark { rgb("#4ade80") } else { rgb("#16a34a") }
  } else {
    if is-dark { rgb("#f87171") } else { rgb("#dc2626") }
  }
  let change-bg = if change-positive {
    if is-dark { rgb("#052e16") } else { rgb("#dcfce7") }
  } else {
    if is-dark { rgb("#450a0a") } else { rgb("#fee2e2") }
  }

  block(
    fill: if is-dark { rgb("#0d1527") } else { rgb("#f8fafc") },
    stroke: 0.6pt + p.border,
    radius: 6pt,
    inset: (x: 12pt, top: 11pt, bottom: 11pt),
    width: width,
    [
      // 1. Category Title (fixed height keeps baseline identical across all cards)
      #box(
        width: 100%,
        height: 18pt,
        align(left + horizon)[
          #text(size: 7.5pt, weight: "bold", fill: p.text-muted, tracking: 0.3pt, hyphenate: false)[#upper(title)]
        ]
      )
      #v(4pt)
      // 2. Primary KPI Value
      #box(
        width: 100%,
        height: 22pt,
        align(left + horizon)[
          #text(size: 18pt, weight: "bold", fill: p.text)[#value]
        ]
      )
      #v(5pt)
      // 3. Status Badge / Trend Change
      #box(
        width: 100%,
        height: 15pt,
        align(left + horizon)[
          #if change != none [
            #box(
              fill: change-bg,
              stroke: 0.4pt + if is-dark { change-color.transparentize(50%) } else { change-color.lighten(20%) },
              radius: 3pt,
              inset: (x: 4.5pt, y: 2pt),
              baseline: 0%,
              text(size: 7pt, weight: "bold", fill: change-color, hyphenate: false)[#change]
            )
          ]
        ]
      )
      #v(3pt)
      // 4. Descriptive SLA Note / Context
      #box(
        width: 100%,
        height: 13pt,
        align(left + horizon)[
          #if note != none [
            #text(size: 7.2pt, fill: if is-dark { p.text-muted } else { p.text-light }, hyphenate: false)[#note]
          ]
        ]
      )
    ]
  )
}

// Grid container helper for Metric Cards
#let metric-grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  ..cards
) = {
  v(4pt)
  grid(
    columns: columns,
    gutter: gutter,
    ..cards.pos()
  )
  v(4pt)
}

// Key-Value Metadata Grid
#let key-value-grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  ..items
) = context {
  let p = resolve-palette(theme-override: current-theme.get())

  grid(
    columns: columns,
    gutter: gutter,
    ..items.pos().map(it => block(
      fill: if p.mode == "dark" { rgb("#101827") } else { rgb("#f8fafc") },
      stroke: 0.5pt + p.border,
      radius: 4pt,
      inset: (x: 10pt, y: 8pt),
      it
    ))
  )
}
