// components/diagrams.typ — Conceptual medical diagrams
//
// Cycle diagrams (cardiac/cell cycle …) and linear pathway diagrams
// (cascades, signalling). Built on CeTZ for a consistent look.

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "@preview/cetz:0.5.2": canvas, draw

// ── Cycle diagram ──────────────────────────────────────────────
// `steps` arranged clockwise on a circle, connected by arrows that
// close the loop. Each step is a small labeled node.
#let cycle-diagram(
  steps,
  color: palette.primary,
  radius: 2.6,
  node-radius: 1,
) = {
  let n = steps.len()
  let pos = i => {
    let ang = 90deg - i * (360deg / n)
    (radius * calc.cos(ang), radius * calc.sin(ang))
  }
  canvas(length: 1cm, {
    // arrows between consecutive nodes (shortened to node edges)
    for i in range(n) {
      let a = pos(i)
      let b = pos(calc.rem(i + 1, n))
      let dx = b.at(0) - a.at(0)
      let dy = b.at(1) - a.at(1)
      let len = calc.sqrt(dx * dx + dy * dy)
      let ux = dx / len
      let uy = dy / len
      draw.line(
        (a.at(0) + ux * node-radius, a.at(1) + uy * node-radius),
        (b.at(0) - ux * node-radius, b.at(1) - uy * node-radius),
        stroke: 1pt + color.darken(10%),
        mark: (end: ">", fill: color.darken(10%)),
      )
    }
    // nodes
    for (i, s) in steps.enumerate() {
      let p = pos(i)
      draw.circle(p, radius: node-radius, fill: color.lighten(82%), stroke: 1pt + color)
      draw.content(p, text(size: type-scale.tiny, fill: color.darken(25%), weight: "bold", align(center, s)))
    }
  })
}

// ── Pathway diagram ────────────────────────────────────────────
// Linear chain of labeled stages connected by arrows. An edge whose
// index is in `inhibit` is drawn as a flat-headed inhibition arrow.
#let pathway-diagram(
  stages,
  color: palette.info,
  box-w: 2.6,
  box-h: 1.1,
  gap: 1,
  inhibit: (),
) = {
  canvas(length: 1cm, {
    for (i, s) in stages.enumerate() {
      let x = i * (box-w + gap)
      draw.rect(
        (x, 0),
        (x + box-w, box-h),
        fill: color.lighten(82%),
        stroke: 1pt + color,
        radius: 3pt,
      )
      draw.content((x + box-w / 2, box-h / 2), text(size: type-scale.tiny, fill: color.darken(25%), weight: "bold", align(center, s)))
      if i > 0 {
        let px = (i - 1) * (box-w + gap) + box-w
        let mid = box-h / 2
        if inhibit.contains(i) {
          draw.line((px, mid), (x - 0.05, mid), stroke: 1pt + palette.danger)
          draw.line((x - 0.05, mid - 0.22), (x - 0.05, mid + 0.22), stroke: 2pt + palette.danger)
        } else {
          draw.line((px, mid), (x, mid), stroke: 1pt + color.darken(10%), mark: (end: ">", fill: color.darken(10%)))
        }
      }
    }
  })
}
