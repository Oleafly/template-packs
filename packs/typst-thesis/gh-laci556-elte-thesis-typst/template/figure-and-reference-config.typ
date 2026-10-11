// based on https://codeberg.org/voroskoi/PannoTyp

#import "@preview/headcount:0.1.0": dependent-numbering
#import "@preview/rich-counters:0.2.2": *

#let SUPPLEMENTS = (
  image: "ábra",
  table: "táblázat",
  raw: "forráskód",
  equation: "egyenlet",
  algo: "algoritmus",
)

#let get-supplement(kind) = {
  if kind == table { return SUPPLEMENTS.table }
  if kind == raw { return SUPPLEMENTS.raw }
  if kind == "equation" { return SUPPLEMENTS.equation }
  if kind == "algo" { return SUPPLEMENTS.algo }
  return SUPPLEMENTS.image
}

#let counters = (
  image: rich-counter(identifier: "image", inherited_levels: 1),
  table: rich-counter(identifier: "table", inherited_levels: 1),
  raw: rich-counter(identifier: "raw", inherited_levels: 1),
  equation: rich-counter(identifier: "equation", inherited_levels: 1),
  algo: rich-counter(identifier: "algo", inherited_levels: 1),
)

#let get-counter(kind) = {
  counters.at(
    if type(kind) == str { kind } else { repr(kind) },
  )
}

#let display-counter-at(kind, location, n, increment: true) = {
  let original-numbers = (get-counter(kind).at)(location)
  let numbers = if not increment { original-numbers } else {
    (..original-numbers.slice(0, -1), original-numbers.last() + 1)
  }

  numbering(n, ..numbers)
}

#let equation-label-placeholder(_) = ""

#let figure-and-reference-config(content) = {
  set figure(numbering: "1.1.")
  set figure.caption(separator: ". ")

  show figure: set block(below: 2.5em)
  show figure.where(kind: image): set figure(supplement: SUPPLEMENTS.image)
  show figure.where(kind: table): set figure(supplement: SUPPLEMENTS.table)
  show figure.where(kind: raw): set figure(supplement: SUPPLEMENTS.raw)
  show figure.where(kind: "algo"): set figure(supplement: SUPPLEMENTS.algo)
  show figure.where(kind: "algo"): set figure.caption(position: top)

  show figure: it => {
    if it.numbering == none { return it }

    (get-counter(it.kind).step)()

    it
  }

  show math.equation.where(block: true): set math.equation(numbering: equation-label-placeholder)
  show math.equation: it => {
    if (it.numbering == equation-label-placeholder) {
      let c = get-counter("equation")
      (c.step)()

      let args = it.fields()
      let _ = args.remove("body")
      let _ = args.remove("numbering")
      let _ = if "label" in args { args.remove("label") }

      math.equation(it.body, ..args, numbering: _ => context (c.display)("(1.1)"))
      return
    }

    it
  }

  show figure.caption: it => {
    if (it.numbering == none) {
      return box(it.supplement + it.separator) + it.body
    }

    let counter-text = context display-counter-at(it.kind, here(), it.numbering, increment: false)
    box(counter-text + " " + it.supplement + it.separator) + it.body
  }

  show ref.where(form: "normal"): it => {
    if (it.element != none and it.element.func() == figure) {
      let nums = context display-counter-at(
        it.element.kind,
        it.target,
        it.element.numbering,
      )

      if (
        it.supplement == auto
          and (
            it.element.kind != image
              and it.element.kind != table
              and it.element.kind != raw
              and it.element.kind not in SUPPLEMENTS
          )
      ) {
        return it
      }

      let supp = if it.supplement != auto {
        it.supplement
      } else {
        get-supplement(it.element.kind)
      }

      return link(it.target, box(nums + " " + supp))
    }

    if (it.element != none and it.element.func() == math.equation) {
      let nums = context display-counter-at("equation", it.target, "1.1.")

      let supp = if it.supplement != auto { it.supplement } else { SUPPLEMENTS.equation }

      return link(it.target, box(nums + " " + supp))
    }

    it
  }

  content
}
