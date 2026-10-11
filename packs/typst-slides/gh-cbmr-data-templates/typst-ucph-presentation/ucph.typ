#import "@preview/touying:0.8.0": *
#import "@preview/zebraw:0.6.3": *


// Title-page slide
#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    place(top + left, dy: 10%, image(
      "images/title-box-" + self.store.language + ".png",
      width: 49%,
      height: 80%,
      fit: "contain",
    ))

    set text(fill: self.colors.neutral-darkest)
    if info.author != none {
      place(top + left, dy: 10%, block(inset: 0.64in, width: 49%, [
        #text(size: 1.3em, fill: self.colors.ucph-red, weight: "bold", info.title)
        #parbreak() \
        #text(size: 0.81em, fill: self.colors.ucph-blue, weight: "bold", info.author)
        #parbreak() \
        #text(size: 0.65em, fill: self.colors.ucph-red, weight: "bold", datetime.today().display())
      ]))
    }
  }

  self = utils.merge-dicts(self, config-page(margin: 0em, background: {
    place(top + left, rect(width: 100%, height: 100%, fill: gradient.linear(self.colors.ucph-grey, white)))
    place(bottom + right, image("images/background.png", height: 98.5%, fit: "contain"))
  }))

  touying-slide(self: self, body)
})

#let slide(title: auto, body, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  let header(self) = {
    set align(top)

    show: components.cell.with(fill: self.colors.ucph-grey, inset: 0.975em, height: 1.1em)
    set align(horizon)
    set text(fill: self.colors.neutral-darkest, size: 10pt)

    let count = counter("TODOs")
    let todotext = context {
      let todos = count.final().at(0)

      if todos == 1 {
        text(weight: "bold", fill: maroon)[1 TODO in document]
      } else if todos > 1 {
        text(weight: "bold", fill: maroon)[#todos TODOs in document]
      }
    }

    grid(
      columns: (2em, 1fr, 1fr, 0.5fr, 0.5fr),
      align: (center, left, center, center, right),
      box(image("images/3dots.svg", height: 0.23in), height: 1em),
      box(image("images/institute-" + self.store.language + ".png", height: 0.17in), height: 1em),
      text(utils.display-current-heading(level: 1), tracking: 2pt),
      todotext,
      context utils.slide-counter.display(),
    )
  }

  self = utils.merge-dicts(self, config-page(header: header))

  touying-slide(
    self: self,
    [
      #text(1.2em, weight: "bold", utils.display-current-heading(level: 2), fill: rgb("#A31D20"))

      #body
    ],
    ..args,
  )
})


#let ucph-theme(language: "en", ..args, body) = {
  assert(language == "en" or language == "da", message: "language must be 'en' or 'da'")

  // Default text size
  set text(size: 22pt, font: "Segoe UI")
  // Color hyperlinks by default
  show link: set text(fill: blue)
  // Default footnote size
  show footnote.entry: set text(size: 16pt)

  // Formatting options for raw text/code inserts
  show raw.where(block: false): it => box(
    fill: silver,
    inset: (x: 2pt, y: 3pt),
    outset: (x: 2pt, y: 3pt),
    baseline: 3pt,
    radius: 2pt,
    it,
  )

  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: (top: 2em, bottom: 1.5em, x: 0.64in),
    ),

    config-common(slide-fn: slide),
    config-methods(
      alert: utils.alert-with-primary-color,
      // cover: utils.color-changing-cover
    ),
    config-colors(
      primary: rgb("#000000"),
      ucph-red: rgb("#a31d20"),
      ucph-blue: rgb("#33b1dd"),
      ucph-grey: rgb("#dddddd"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    config-store(
      title: none,
      language: language,
    ),
    ..args,
  )

  body
}


// Table of contents slide
#let toc-slide(depth: 1) = {
  slide()[
    #text(fill: rgb("#A31D20"), size: 1.2em, weight: "bold")[Content]
    #components.progressive-outline(title: none, alpha: 20%, depth: depth)
  ]
}


// Enhanced code-blocks using zebraw
#let code-block(it, size: 18pt, numbering: false, ..args) = {
  pad(top: -0.6em, bottom: -0.2em, zebraw(
    text(it, size: size),
    lang: numbering,
    numbering: numbering,
    highlight-color: rgb("#ffcea4"),
    background-color: silver,
    ..args,
  ))
}

// Embed TODO in slide, with global counter in title-bar. Example:
//   #TODO[add figure to slide]
#let TODO(body) = {
  let count = counter("TODOs")
  count.step()

  place(bottom + right, footnote(
    {
      text(weight: "bold", fill: maroon)[TODO\[#context count.display()/#context count.final().at(0)\]: ]
      text(body, fill: maroon)
    },
    numbering: _ => {},
  ))
}
