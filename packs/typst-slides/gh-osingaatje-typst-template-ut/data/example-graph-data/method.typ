#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: house, hexagon

#let methode-diagram = {
  let blob(pos, label, tint: white, ..args) = node(
    pos, align(center, label),
    width: 28mm,
    fill: tint.lighten(60%),
    stroke: 1pt + tint.darken(20%),
    corner-radius: 5pt,
    ..args,
  )

  diagram(
    spacing: 8pt,
    cell-size: (8mm, 10mm),
    edge-stroke: 1pt,
    edge-corner-radius: 5pt,
    mark-scale: 70%,

    blob((0,3), [Start], shape: house.with(angle: 30deg), width: auto, tint: red),
    blob((0,1), [New Typst file], tint: yellow, shape: hexagon, width: 5.5cm),
    blob((0,2), [Find syntax], tint: orange, width: 5.5cm),
    edge((0,3), (0,2), "-|>"),
    edge((0,3), "ll,uu", (0,1), "-|>"),
    blob((2,2), [Write flow chart in new file], tint: green, width: 4cm),
    edge((0,1), "rr", (2,2), "-|>"),
    edge((0,2), (2,2), "-|>"),
    blob((3,2), [Import new file in `main.typ`], tint: orange, width: 4cm),
    edge((2,2), "d,r", (3,2), "-|>"),
    blob((4,1), [Enjoy perfectness], tint: green, width: 5cm),
    blob((4,3), [Enjoy unreadable flow charts], tint: green, width: 5cm),
    edge((3,2), "r", (4,3), "-|>"),
    edge((3,2), "r", (4,1), "-|>"),
    blob((6,2), [End], shape: hexagon, width: 3cm, tint: red),
    edge((4,3), "rr", (6,2), "-|>"),
    edge((4,1), "rr", (6,2), "-|>"),
  )
}