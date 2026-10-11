#import "@preview/pinit:0.2.2": *
#import "../core/locale.typ": jp-spacing

#let colormath(math, color) = text(fill: color, math)

#let apply-math-font(font: "Latin Modern Math") = {
  show math.equation: set text(font: font)
}

#let apply-block-equation-spacing(spacing: 0.7em) = {
  show math.equation.where(block: true): set block(spacing: spacing)
}

// Query the original labeled equations, not the unlabelled rendered copies.
// Touying repeats equations across subslides, so each label occupies one slot.
#let _referenced-equation-labels() = {
  let targets = query(ref).map(it => it.target)
  query(math.equation.where(block: true))
    .filter(it => it.has("label") and it.label in targets)
    .map(it => it.label)
    .dedup()
}

#let apply-referenced-only-equation-numbering(numbering: "(1)") = body => {
  set math.equation(numbering: none)
  show math.equation.where(block: true): it => context {
    if not it.has("label") {
      it
    } else {
      let index = _referenced-equation-labels().position(label => label == it.label)
      let fields = it.fields()
      let _ = fields.remove("label")
      fields.numbering = if index != none { (..nums) => std.numbering(numbering, index + 1) }
      math.equation(fields.remove("body"), ..fields)
    }
  }
  show ref: it => context {
    let equations = query(it.target).filter(el => el.func() == math.equation and el.block)
    if equations.len() == 0 {
      it
    } else {
      let index = _referenced-equation-labels().position(label => label == it.target)
      // Link to the final subslide, where the entire equation is visible.
      link(equations.last().location(), std.numbering(numbering, index + 1))
    }
  }
  body
}

#let apply-inline-japanese-math-spacing() = {
  show math.equation.where(block: false): it => jp-spacing(it)
}

#let pinit-highlight-equation-from(
  height: 0pt,
  arrow-length: 20pt,
  arrow-dx: 20pt,
  dx: 0pt,
  dy: 0pt,
  line-offset-y: 0pt,
  pos: "bottom",
  fill: rgb(0, 0, 0),
  stroke: auto,
  inset: 0.25em,
  pin1,
  pin2,
  body,
) = {
  pinit-highlight(
    pin1,
    pin2,
    dx: dx,
    dy: -dy - 18pt,
    extended-height: height,
    fill: fill.lighten(50%),
  )

  let stroke-color = if stroke == auto { fill } else { stroke }
  let out-contents = box(
    baseline: if pos == "top" or pos == "bottom" { top } else { auto },
    stroke: (bottom: stroke-color + 0.12em),
    inset: (x: inset, y: 5pt),
    text(fill: fill)[#body],
  )

  let pos-configs = (
    "bottom": (
      pin: pin1,
      place-dx: dx + arrow-dx,
      place-dy: out-height => height + arrow-length - dy - out-height - line-offset-y,
      arrow-pin: pin1,
      arrow-start-dx: dx + arrow-dx,
      arrow-end-dx: dx + arrow-dx,
      arrow-start-dy: height + arrow-length - dy,
      arrow-end-dy: height - dy - 20pt,
    ),
    "top": (
      pin: pin1,
      place-dx: dx + arrow-dx,
      place-dy: out-height => -dy + 10pt - arrow-length - 24.8pt - out-height - line-offset-y,
      arrow-pin: pin1,
      arrow-start-dx: dx + arrow-dx,
      arrow-end-dx: dx + arrow-dx,
      arrow-start-dy: -dy + 10pt - arrow-length - 24.8pt,
      arrow-end-dy: 34pt - dy - 50pt,
    ),
    "right": (
      pin: pin2,
      place-dx: arrow-length + dx,
      place-dy: _ => -dy - 25.9pt + height / 2 - 0.76em - line-offset-y,
      arrow-pin: pin2,
      arrow-start-dx: arrow-length + dx,
      arrow-end-dx: 0pt,
      arrow-start-dy: -dy - 16pt + height / 2,
      arrow-end-dy: -dy - 16pt + height / 2,
    ),
    "left": (
      pin: pin1,
      place-dx: -arrow-length + dx,
      place-dy: _ => -dy - 25.9pt + height / 2 - 0.76em - line-offset-y,
      arrow-pin: pin1,
      arrow-start-dx: -arrow-length + dx,
      arrow-end-dx: 0pt,
      arrow-start-dy: -dy - 16pt + height / 2,
      arrow-end-dy: -dy - 16pt + height / 2,
    ),
  )

  let config = pos-configs.at(pos)
  context {
    let out-height = measure(out-contents).height
    pinit-place(config.pin, out-contents, dx: config.place-dx, dy: (config.place-dy)(out-height))
  }
  pinit-arrow(
    config.arrow-pin,
    config.arrow-pin,
    fill: fill,
    start-dx: config.arrow-start-dx,
    end-dx: config.arrow-end-dx,
    start-dy: config.arrow-start-dy,
    end-dy: config.arrow-end-dy,
  )
}
