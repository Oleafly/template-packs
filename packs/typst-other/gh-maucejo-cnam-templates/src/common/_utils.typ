#import "_deps.typ": *

#let over-title(title: none, size: none, color: none) = {
  let box1 = {
    box(fill: white, stroke: 1pt + color, inset: 8pt)[
      #set text(size: size, font: "Crimson Pro", weight: "semibold", fill: color)
      #title.first()
    ]
  }

  let box2 = {
    box(fill: white, stroke: 1pt + color, inset: 8pt)[
      #set text(size: size, font: "Crimson Pro", weight: "semibold", fill: color)
      #title.last()
    ]
  }

  context{
    let box1-size = measure(box1).width
    let box2-size = measure(box2).width

    box1

    let dec = box1-size - box2-size/2.5
    if dec < 0cm {
      dec = box1-size/3
    }
    place(dx: dec, box2)
  }
  v(1em)
}

#let subfigure = subpar.grid.with(supplement: "Figure")