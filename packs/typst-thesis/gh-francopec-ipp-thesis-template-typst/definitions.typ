// File: definitions.typ
// Author: Franco Cordeiro
// Description: Contains dependencies and macro definitions.
//
// Dependencies
#import "@preview/cetz:0.4.0" // Drawings
#import "@preview/cetz-plot:0.1.2": plot, chart // Plotting graphs
#import "@preview/subpar:0.2.2"
#import "@preview/theorion:0.4.0": (
  show-theorion,
  theorem,
  lemma,
  proof,
  set-inherited-levels,
  set-theorion-numbering,
) // Special environments

// Macro definitions
#let braced-equations(..lines, limiter: math.brace, labels: (), gap: 0.5em, at-left: "", centering: false) = context {
  let n = lines.pos().len()

  let displayed_lines = lines.pos().map(parts => parts.map(p => $ display(#p) $))

  // Determine number of columns (maximum number of parts across all equations)
  let max-parts = displayed_lines.map(parts => parts.len()).fold(0, calc.max)
  // Measure height of each line
  let line-heights = displayed_lines.map(parts => parts.map(p => measure(p).height).fold(0pt, calc.max))
  // Measure width of each column
  let col-widths = range(max-parts).map(i => {
    displayed_lines
      .map(parts => {
        if i < parts.len() {
          measure($display(#parts.at(i))$).width
        } else {
          0pt
        }
      })
      .fold(0pt, calc.max)
  })

  let left-part = [#at-left #math.lr(limiter, size: n * gap + line-heights.sum())]

  let left-width = measure([#left-part]).width
  let first-colum = if centering {
    (100% - left-width - col-widths.sum() - 0.2em * col-widths.len()) / 2
  } else {
    0pt
  }
  let label-array = labels + displayed_lines.slice(labels.len()).map(_ => "")
  block(
    box(
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.2em,
        row-gutter: gap,
        // Left side cell
        grid.cell(
          rowspan: n,
          align: horizon + right,
          grid(
            columns: (first-colum, left-width),
            [], left-part,
          ),
        ),
        // Equations cells
        ..displayed_lines
          .zip(label-array)
          .map(linelabel => {
            let parts = linelabel.at(0)
            let lb = linelabel.at(1)
            [
              #math.equation(
                block: true,
                numbering: "(1)",
                [
                  #show math.equation.where(block: true): set align(left + horizon)
                  #set math.equation(numbering: none)

                  #grid(
                    columns: (..col-widths, 100% - col-widths.sum()),
                    align: (left, ..(range(max-parts - 1).map(_ => left))),
                    column-gutter: 0.2em,
                    ..parts,
                    ..(range(max-parts - parts.len()).map(_ => [])),
                  )],
              ) #label(lb)
            ]
          })
      ),
    ),
  )
}
