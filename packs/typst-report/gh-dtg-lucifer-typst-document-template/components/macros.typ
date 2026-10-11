// components/macros.typ
// Mathematical shortcuts, probability notations, and sequential process timeline helpers.

#import "theme.typ": resolve-palette, current-theme

// Common Blackboard Bold Math Shortcuts
#let RR = math.bb("R")
#let NN = math.bb("N")
#let ZZ = math.bb("Z")
#let QQ = math.bb("Q")
#let CC = math.bb("C")

// Visual Sequential Process Flow / Timeline
// Renders horizontal step arrows with styled badges:
// Example: #step-flow([$S_t$ (Current)], [$hat(S)_(t+1)$ (+15s)], [$hat(S)_(t+2)$ (+30s)])
#let step-flow(..steps) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let items = steps.pos()

  align(center)[
    #block(
      fill: if p.mode == "dark" { rgb("#0d1527") } else { rgb("#f8fafc") },
      stroke: 0.6pt + p.border,
      inset: (x: 14pt, y: 10pt),
      radius: 6pt,
      [
        #let content-cells = ()
        #for (i, step) in items.enumerate() {
          content-cells.push(
            box(
              fill: if p.mode == "dark" { rgb("#172554") } else { rgb("#eff6ff") },
              stroke: 0.5pt + if p.mode == "dark" { rgb("#1e40af") } else { rgb("#bfdbfe") },
              radius: 4pt,
              inset: (x: 8pt, y: 5pt),
              text(weight: "bold", size: 9pt, fill: p.primary)[#step]
            )
          )
          if i < items.len() - 1 {
            content-cells.push(
              text(weight: "bold", size: 11pt, fill: p.secondary)[ $arrow.r$ ]
            )
          }
        }
        #grid(
          columns: (auto,) * content-cells.len(),
          gutter: 6pt,
          align: horizon,
          ..content-cells
        )
      ]
    )
  ]
}
