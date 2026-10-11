// Layout primitives and page chrome, all reading the resolved `settings` state.

#import "settings.typ": settings
#import "@preview/hydra:0.6.3": hydra

// Use the last heading of a page for the running header.
#let hydra = hydra.with(use-last: true)

// Advance the cursor by `count` line-grid steps.
#let v-step(count) = context {
  let s = settings.get()
  v(count * (s.texts.step + s.texts.ascender))
}

// Place `it` in the outer margin, flush right. `dx`/`dy` shift it; the rest go
// to the wrapping box.
#let place-side(it, dx: 0pt, dy: 0pt, ..box-args) = context {
  let s = settings.get()
  let half-gutter = s.side.half-gutter
  set par(justify: false)
  place(
    dx: -s.side.width - half-gutter + dx,
    dy: dy,
    box(
      width: s.side.width,
      inset: (left: half-gutter, right: half-gutter),
      outset: (
        top: half-gutter + s.texts.ascender,
        bottom: half-gutter,
      ),
      ..box-args,
      align(right, it),
    ),
  )
}

// Center a small symbol (e.g. a heading marker) in the sidenote column.
#let place-node(sym, dy: 0pt) = context {
  let s = settings.get()
  place-side(sym, dx: s.side.half-gutter + measure(sym).width / 2, dy: dy)
}

// Text on a proportionally smaller line grid.
#let small(it, scale: 2 / 3, size: 0.75em) = context {
  let s = settings.get()
  set par(leading: s.texts.step * scale)
  text(size, it)
}

// Page margins, one grid step taller at the top so the first baseline lands on
// the grid.
#let paper-margin(margin, texts) = (
  top: margin.t + texts.step,
  left: margin.e,
  right: margin.s,
  bottom: margin.f,
)

// Background: the hairline between the text body and the sidenote column, plus
// a patch that erases it where the page number sits.
#let page-background(paper, margin, side, fonts, theme) = {
  let rule-dx = margin.e - side.half-gutter
  place(
    top + left,
    dx: rule-dx,
    dy: 0pt,
    line(start: (0%, 0%), end: (0%, 100%), stroke: 0.75pt + theme.line),
  )
  place(
    bottom + center,
    dx: -paper.width / 2 + rule-dx,
    dy: -margin.f * (2 / 3),
    box(
      fill: theme.page,
      outset: (top: side.half-gutter, bottom: side.half-gutter),
      text(font: fonts.sans, fill: theme.line)[#h(2em)],
    ),
  )
}

// Footer: the page number under the text body, the section title at the outer edge.
#let page-footer(body, margin, side, fonts, theme) = context {
  let dy = -margin.f * (2 / 3)

  let page-number = text(font: fonts.sans, fill: theme.line)[
    #text(fill: theme.strong)[#counter(page).get().at(0)]
  ]
  place(bottom + center, dx: -body.width / 2 - side.half-gutter, dy: dy, page-number)

  let section-title = {
    show linebreak: ""
    text(font: fonts.sans, fill: theme.faint, hydra(1))
  }
  place(bottom + left, dx: -side.half-gutter + 2em, dy: dy, section-title)
}

// A sidenote at the current position, in the outer margin.
#let sidenote(it, dy: 0pt) = context {
  let s = settings.get()
  let dx = -here().position().x + s.margin.e
  let baseline-offset = s.texts.ascender * (2 / 3)
  sym.wj
  box(place-side(small(it), dx: dx, dy: dy - baseline-offset))
  h(0pt, weak: true)
}

// A page carrying only a centered, muted note.
#let blank-page(..args) = context {
  let s = settings.get()
  set page(
    background: {
      v(2fr)
      align(
        center,
        text(font: s.fonts.sans, fill: s.theme.muted)[This page is intentionally left blank.],
      )
      v(3fr)
    },
    footer: none,
    header: none,
  )
  pagebreak(..args)
}
