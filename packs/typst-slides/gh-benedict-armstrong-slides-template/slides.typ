#import "template.typ": *

#show: presentation

#title-slide[
  #text(fill: white, size: 1.3em, weight: "bold")[Presentation Title]

  #text(fill: white, size: 0.8em, weight: "semibold")[
    #v(0.5em)
    Presented by Your Name
  ]

  #speaker-notes[
    Speaker notes for the title slide go here.
  ]
]

#show: content-slides

#slide[
  = Section Heading

  A simple slide with a heading and some body text.

  #show: later // equivalent to pause
  - Bullet point one
  - Bullet point two
  - Bullet point three
]

#slide[
  = Item-by-Item Slide

  #only("1-")[
    - Bullet point one

  ]
  #only("2-")[
    - Bullet point two
  ]
  #only("3-")[
    - Bullet point three
  ]
]

#slide[
  = Progressive Reveal

  First, we introduce an idea.
  #show: later

  Then we expand on it with more detail.
  #show: later

  Finally, we conclude.
]

#slide[
  = Two-Column Layout

  #grid(
    columns: (1fr, 1fr),
    gutter: 2em,
    [
      *Left column*
      - Item A
      - Item B
      - Item C
    ],
    [
      *Right column*
      - Item X
      - Item Y
      - Item Z
    ],
  )
]

#slide[
  = Math Example

  A state-space model:
  $
    avec(y)_k & = amat(A) avec(y)_(k-1) + amat(B) avec(u)_k \
    avec(x)_k & = amat(C) avec(y)_k + amat(D) avec(u)_k
  $
]

#slide[
  = Code Example

  ```python
  def hello(name: str) -> str:
      return f"Hello, {name}!"
  ```
]

#slide[
  = Figure with Caption

  #figure(
    image("figures/zurich2.jpg", width: 60%),
    caption: [An example figure caption.],
  )
]

#slide[
  = Highlighting Content

  This word will #highlight(2, red)[change color] on the next subslide.
]

#slide[
  = Image Slide

  #align(center)[
    #image("figures/zurich2.jpg", height: 70%)
  ]
]

#slide[
  = References

  Gravitational waves were first predicted by Einstein @einstein1918.
]

#slide[
  #bibliography(
    "bibliography.bib",
    style: "apa",
  )
]

#slide[

  #v(1fr)
  #align(center)[
    #text(size: 2em, weight: "bold", fill: title-color)[Thank you!]
  ]
  #v(1fr)
]
