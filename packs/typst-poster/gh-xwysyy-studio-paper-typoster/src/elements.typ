// Shared show-chain (paper-typoster-elements) and reusable components (info, textbox).

#import "@preview/touying:0.7.3": components
#import "themes.typ": *

#let paper-typoster-elements(
  doc,
  code-font: "Maple Mono",
  t-sea: sea,
  t-sky: sky,
  t-skyll: skyll,
  t-paper: paper,
) = [
  #show strong: it => {
    let c = text.fill
    text(stroke: 0.04em + c, it.body)
  }

  #set list(marker: (text(fill: t-sea, [❖]), text(fill: t-sky, [⬦]), text(fill: t-sky, [–])), spacing: 1.6em, indent: 0.5em, body-indent: 0.8em)
  #set enum(spacing: 1.2em, indent: 0.5em)

  // Italic — per-character synthetic skew for CJK
  #show emph: it => {
    if type(it.body) == content and it.body.has("text") {
      for c in it.body.text {
        box(skew(ax: -8deg, c))
      }
    } else {
      box(skew(ax: -8deg, it.body))
    }
  }

  #show figure.caption: it => {
    set text(size: 0.78em, fill: luma(100))
    v(0.3em)
    it
  }

  // Table captions on top, tighter caption gap, pulled up against preceding content
  #show figure.where(kind: table): set figure.caption(position: top)
  #show figure.where(kind: table): set figure(gap: 0.3em)
  #show figure.where(kind: table): it => {
    v(-0.6em)
    it
  }

  #show raw.where(block: true): it => {
    set text(font: code-font, size: 0.9em)
    block(
      width: 100%,
      height: auto,
      fill: t-skyll,
      inset: 0.6em,
      radius: 0.5em,
      it
    )
  }
  #show raw.where(block: false): it => {
    set text(font: code-font)
    box(
      fill: t-skyll,
      inset: (x: 0.3em, y: 0.2em),
      radius: 0.3em,
      baseline: 0.2em,
      it
    )
  }

  #show link: underline
  #show link: it => {
    set text(fill: t-sea)
    it
  }

  // Detail Decoration — longer patterns first to avoid partial matches
  #show "<==>": [$arrow.l.r.double.long$]
  #show "<=>": [$<=>$]
  #show "-->": [$-->$]
  #show "<--": [$<--$]
  #show "==>": [$==>$]
  #show "<==": [$arrow.l.double.long$]
  #show "->": [$->$]
  #show "<-": [$<-$]
  #show "=>": [$=>$]
  #show "<=": [$arrow.l.double$]
  #show "|->": [$|->$]

  #set table(
    stroke: none,
    gutter: 0.2em,
    align: center,
    fill: (x, y) => if y == 0 {t-sea} else {t-skyll},
  )
  #show table.cell: it => {
    if it.y == 0 {
    set text(t-paper, weight: "bold")
    it
  } else {it}
  }

  #doc
]

#let info(something, description) = [
  *#something* #h(1fr) *#description*\
]

#let textbox(inset: 0.8em, radius: 0.4em, width: 100%, gutter: 0.6em, ..bodies) = context {
  let t = _theme-state.get()
  let bodies = bodies.pos()
  if bodies.len() == 1 {
    block(width: width, fill: t.skyll, inset: inset, radius: radius, bodies.first())
  } else {
    components.lazy-layout(grid(
      columns: (1fr,) * bodies.len(),
      gutter: gutter,
      ..bodies.map(b => block(width: 100%, fill: t.skyll, inset: inset, radius: radius, {
        b
        components.lazy-v(1fr)
      })),
    ))
  }
}
