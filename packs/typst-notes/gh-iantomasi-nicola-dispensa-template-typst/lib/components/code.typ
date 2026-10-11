#import "../theme.typ": *

#let code-style(body) = {
  show raw: set text(font: f-mono, size: 5pt, fill: c-ink)

  show raw.where(block: true): it => block(
    width: 100%,
    clip: true,
    stroke: 0.5pt + c-line,
    {
      grid(
        columns: (auto, 1fr),
        align: (right + top, left + top),
        inset: (x: .3em, y: 0.35em),
        fill: (_, y) => if calc.even(y) { raw-bg-even } else { raw-bg-odd },
        ..it
          .lines
          .enumerate()
          .map(p => (
            text(fill: raw-num-color, size: 0.85em, str(p.at(0) + 1)),
            p.at(1),
          ))
          .flatten(),
      )

      if it.lang != none {
        place(
          top + right,
          dx: -.5em,
          dy: .2em,
          box(
            fill: raw-tag-bg,
            stroke: 0.1pt + c-ink,
            inset: (x: 0.5em, y: .22em),
            radius: 0pt,
            text(
              font: f-mono,
              size: .8em,
              fill: raw-tag-fg,
              tracking: 0.05em,
              upper(it.lang),
            ),
          ),
        )
      }
    },
  )

  body
}
