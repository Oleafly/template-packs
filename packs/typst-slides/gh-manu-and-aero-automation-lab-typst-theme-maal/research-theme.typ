#import "@preview/touying:0.7.4": *

// Research presentation theme reconstructed from [Template] Research.pptx.
// The original deck is 13.333 × 7.5 in (16:9), uses Arial, a white canvas,
// dark HKUST blues, restrained gold accents, and small page numbers.

#let research-blue = rgb("#004B8E")
#let research-navy = rgb("#003366")
#let research-deep-blue = rgb("#002060")
#let research-gold = rgb("#CE9310")
#let research-pale-blue = rgb("#D9E4EE")
#let research-paler-blue = rgb("#F2F6F9")
#let research-red = rgb("#C00000")
#let research-gray = rgb("#A5A5A5")
#let research-yellow = rgb("#FFFDB4")

#let _font-stack = (
  "Arial",
  "Liberation Sans",
  "Carlito",
  "Noto Sans",
  "Noto Sans CJK SC",
  "Microsoft YaHei",
  "SimHei",
)

#let _page-number() = context {
  set text(size: 9pt, fill: research-gray)
  utils.slide-counter.display()
}

#let _normal-canvas(self, shown-title, body) = {
  block(width: 13.333in, height: 7.5in)[
    #place(top + left, dx: .92in, dy: .40in)[
      #block(width: 11.5in, height: .67in)[
        #align(left + horizon)[
          #text(size: 36pt, weight: "bold", fill: black, shown-title)
        ]
      ]
    ]

    #place(top + left, dx: .92in, dy: 1.20in)[
      #block(width: 11.5in, height: 5.56in, clip: true)[
        #body
      ]
    ]

    #place(bottom + right, dx: -.28in, dy: -.12in)[
      #_page-number()
    ]
  ]
}

#let research-slide(title: auto, ..args) = touying-slide-wrapper(self => {
  let shown-title = if title == auto {
    utils.display-current-heading(level: 2)
  } else {
    title
  }

  self = utils.merge-dicts(
    self,
    config-page(
      margin: 0pt,
      header: none,
      footer: none,
      fill: white,
    ),
  )

  touying-slide(
    self: self,
    setting: body => _normal-canvas(self, shown-title, body),
    ..args,
  )
})

#let research-title-slide(
  title: auto,
  subtitle: auto,
  author: auto,
  date: auto,
) = touying-slide-wrapper(self => {
  let info = self.info
  let resolved-title = if title == auto { info.title } else { title }
  let resolved-subtitle = if subtitle == auto { info.subtitle } else { subtitle }
  let resolved-author = if author == auto { info.author } else { author }
  let resolved-date = if date == auto { info.date } else { date }
  let shown-date = if type(resolved-date) == datetime {
    resolved-date.display("[day] [month repr:long] [year]")
  } else {
    resolved-date
  }

  self = utils.merge-dicts(
    self,
    config-page(
      margin: 0pt,
      header: none,
      footer: none,
      fill: white,
    ),
  )

  let cover = block(width: 13.333in, height: 7.5in)[
    #place(top + left, dx: 1.05in, dy: .71in)[
      #block(width: 11.23in, height: 2.61in)[
        #align(center + horizon)[
          #text(size: 36pt, weight: "bold", fill: black, resolved-title)
        ]
      ]
    ]

    #place(top + left, dx: 1.67in, dy: 3.67in)[
      #block(width: 10in, height: 1.20in)[
        #align(center + horizon)[
          #set par(leading: .30em)
          #if resolved-subtitle != none {
            text(size: 20pt, weight: "bold", fill: research-blue, resolved-subtitle)
            linebreak()
          }
          #if resolved-author != none {
            text(size: 20pt, weight: "bold", fill: research-blue, resolved-author)
            linebreak()
          }
          #if resolved-date != none {
            text(size: 20pt, fill: black, shown-date)
          }
        ]
      ]
    ]

    #place(top + left, dx: 1.44in, dy: 5.29in)[
      #image("assets/hkust-lockup.png", width: 3.75in)
    ]
    #place(top + left, dx: 6.90in, dy: 5.29in)[
      #image("assets/lab-lockup.png", width: 5.26in)
    ]

    #place(bottom + right, dx: -.28in, dy: -.12in)[
      #_page-number()
    ]
  ]

  touying-slide(self: self, cover)
})

#let research-section-slide(self: none, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(margin: 0pt, header: none, footer: none, fill: white),
  )
  let canvas = block(width: 13.333in, height: 7.5in)[
    #place(top + left, dx: 1.05in, dy: 2.22in)[
      #block(width: 11.23in, height: 2.25in)[
        #align(center + horizon)[
          #text(size: 36pt, weight: "bold", fill: research-blue, body)
        ]
      ]
    ]
    #place(top + left, dx: 4.67in, dy: 4.70in)[
      #rect(width: 4in, height: 2pt, fill: research-gold, stroke: none)
    ]
    #place(bottom + right, dx: -.28in, dy: -.12in)[#_page-number()]
  ]
  touying-slide(self: self, canvas)
})

#let research-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  set text(font: _font-stack, size: 20pt, fill: black)
  set par(leading: .52em)
  set list(indent: 1.15em, body-indent: .55em, spacing: .30em)

  show: touying-slides.with(
    config-page(
      width: 13.333in,
      height: 7.5in,
      margin: 0pt,
      fill: white,
    ),
    config-common(
      slide-fn: research-slide,
      new-section-slide-fn: research-section-slide,
    ),
    config-methods(
      alert: (self: none, it) => text(fill: self.colors.primary, weight: "bold", it),
    ),
    config-colors(
      primary: research-blue,
      secondary: research-gold,
      neutral-lightest: white,
      neutral-darkest: black,
    ),
    ..args,
  )
  body
}

// Reusable content components -------------------------------------------------

#let research-columns(left, right, ratio: (1fr, 1fr), gutter: .45in) = {
  grid(
    columns: ratio,
    gutter: gutter,
    align: top,
    left,
    right,
  )
}

#let research-table(header, rows, columns: auto) = {
  let column-spec = if columns == auto { header.len() } else { columns }
  table(
    columns: column-spec,
    inset: (x: 8pt, y: 5pt),
    align: left + horizon,
    stroke: none,
    fill: (x, y) => if y == 0 {
      research-blue
    } else if calc.even(y) {
      research-pale-blue
    } else {
      research-paler-blue
    },
    table.header(
      ..header.map(cell => text(fill: white, weight: "bold", cell)),
    ),
    ..rows.flatten(),
  )
}

#let research-callout(
  body,
  fill: research-yellow,
  stroke: research-blue,
  width: auto,
) = block(
  width: width,
  inset: (x: 12pt, y: 9pt),
  radius: 4pt,
  fill: fill,
  stroke: .8pt + stroke,
  body,
)

#let research-caption(body) = text(
  size: 14pt,
  weight: "bold",
  fill: research-blue,
  style: "italic",
  body,
)

#let research-source(body) = text(
  size: 10pt,
  fill: research-blue,
  style: "italic",
  body,
)

#let research-process-step(body, width: 1.65in) = block(
  width: width,
  height: .55in,
  inset: 6pt,
  radius: 3pt,
  fill: research-blue,
  align(center + horizon, text(size: 16pt, fill: white, weight: "bold", body)),
)

#let research-process(..steps) = {
  let children = ()
  for (index, step) in steps.pos().enumerate() {
    if index > 0 {
      children.push(align(center + horizon, text(size: 24pt, fill: research-pale-blue)[→]))
    }
    children.push(research-process-step(step))
  }
  grid(columns: children.len(), gutter: .12in, ..children)
}

#let research-highlight(body, color: research-red) = text(
  fill: color,
  weight: "bold",
  body,
)
