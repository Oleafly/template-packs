#let example(it, desc, scope: (:)) = {
  set heading(outlined: false, numbering: none)
  set list(indent: 1em)
  set par(first-line-indent: 0em)

  show heading: it => {
    if (it.level == 1) {
      set align(center)
      numbering("第1章  ", ..(1,) * it.level)
      it.body
    } else {
      set align(left)
      numbering("1.1   ", ..(1,) * it.level)
      it.body
    }
  }
  figure(
    caption: desc,
    grid(
      align: horizon + left,
      //stroke: 1pt,
      columns: (1fr, 1fr),
      column-gutter: 1em,
      inset: 1em,
      //grid.hline(),
      [标记：], [效果：],
      grid.hline(),
      [#it], [#eval(it.text, mode: "markup", scope: scope)],
      grid.hline(),
    ),
  )
}

#let noeq(it) = {
  math.equation(it, numbering: none, block: true)
}

#let TODO(it) = {
  set text(fill: red)
  it
}