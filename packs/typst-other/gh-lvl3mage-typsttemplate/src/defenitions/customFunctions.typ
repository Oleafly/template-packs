#let customTable(background, ..elems) = context {
  set par(justify: false)
  let frame(outerStroke, innerStroke) = (x, y) => (
    left: if x > 0 {innerStroke } else { outerStroke },
    right: outerStroke,
    top: if y < 2 { outerStroke } else { innerStroke },
    bottom: outerStroke,
  )
  set table(
    fill: (x,y)=>if calc.even(y){background.darken(10%)} else {background.darken(5%)},
    stroke: frame(1pt,0.5pt),
  )
  table(

  stroke: frame(1pt ,0.5pt),

    ..elems
  )
}