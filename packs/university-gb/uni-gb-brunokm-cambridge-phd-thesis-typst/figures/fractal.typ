#import "@preview/cetz:0.4.2": canvas, draw

// Recursively retain the three corner triangles at each subdivision.
#let midpoint(a, b) = a.zip(b).map(((x, y)) => (x + y) / 2)

#let sierpinski(a, b, c, depth) = {
  if depth == 0 {
    draw.line(a, b, c, close: true, fill: rgb("263c48"), stroke: none)
  } else {
    let ab = midpoint(a, b)
    let bc = midpoint(b, c)
    let ca = midpoint(c, a)
    sierpinski(a, ab, ca, depth - 1)
    sierpinski(ab, b, bc, depth - 1)
    sierpinski(ca, bc, c, depth - 1)
  }
}

#let fractal(width: 110mm, depth: 5) = canvas(length: width, {
  sierpinski((0, 0), (1, 0), (0.5, calc.sqrt(3) / 2), depth)
})
