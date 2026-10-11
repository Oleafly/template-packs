= An example documennt

#let figure-page(body) = {
  figure(
    placement: auto,
    numbering: none,
    block(height: 100%, align(horizon, body))
  )
}

#lorem(200)

#lorem(100)

#lorem(200)

#figure-page[
#figure(rect(fill: yellow, width: 50%, height: 5cm), caption: [A figure])
#figure(rect(fill: teal, width: 50%, height: 5cm), caption: [A figure])
]

#lorem(1000)