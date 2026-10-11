// Math utilities

#let _used-math-responsive = state("_used-math-responsive", false)
#let math-responsive(cb) = {
  context assert(
    _used-math-responsive.get(),
    message: "math-responsive can only be used after use-math-responsive",
  )
  [#metadata(cb) <math-responsive>]
}
#let use-math-responsive(it) = {
  show math.equation: eq => {
    show <math-responsive>: m => (m.value)(eq.block)
    eq
  }
  _used-math-responsive.update(value => {
    assert(not value, message: "use-math-responsive can only be used once")
    true
  })
  it
}
#let display(..args) = {
  show <math-responsive>: m => (m.value)(true)
  math.display(..args)
}
#let inline(..args) = {
  show <math-responsive>: m => (m.value)(false)
  math.inline(..args)
}

#let ee = $upright(e)$.body
#let ii = $upright(i)$.body
#let jj = $upright(j)$.body
#let kk = $upright(k)$.body

#let pm = $plus.minus$.body
#let mp = $minus.plus$.body

#let argmin = $op(arg min, limits: #true)$.body
#let argmax = $op(arg max, limits: #true)$.body

#let chev(..args) = {
  let body = args.pos().join($,$.body)
  $lr(chevron.l body chevron.r)$.body
}

#let cdots = $class("binary", dots.h.c)$.body

#let ns = h(-1em / 6)  // negative thin space

#let qed = h(1fr) + sym.square

#let pmod(divisor, space: auto) = {
  if space == auto {
    math-responsive(block => if block { math.quad } else { math.thick })
  } else {
    space
  }
  $(op("mod") med #divisor)$.body
}

#let pcases(..args, punct: $,$.body) = {
  let rows = args.pos()
  let params = args.named()

  if rows.len() > 0 and type(rows.at(0)) != array {
    rows = (rows,)
  }

  math.cases(
    ..params,
    ..rows
      .enumerate()
      .map(((i, parts)) => {
        parts.join($,$.body)
        if i != rows.len() - 1 { punct }
      }),
  )
}

// https://typst-doc-cn.github.io/guide/FAQ/mathcal_font.html
#let cal(it) = text(
  font: ("Computer Modern Symbol", "New Computer Modern Math"),
  math.scr(it),
)

// https://typst-doc-cn.github.io/guide/FAQ/math-inline-display.html
#let always-display-math(it) = {
  show math.equation.where(block: false): math.display
  it
}

// https://typst-doc-cn.github.io/guide/FAQ/emptyset.html
#let use-varnothing(it) = {
  show math.equation: set text(features: ("cv01",))
  it
}

// https://github.com/typst/typst/issues/1028
#let fix-inline-math-bounds(it) = {
  show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
  it
}

// Probability and Statistics

#let Var = $op("Var")$.body
#let Cov = $op("Cov")$.body

#let given = $mid(|)$.body

#let style-expected-value(it) = {
  show math.EE: math.op(math.EE)
  it
}
