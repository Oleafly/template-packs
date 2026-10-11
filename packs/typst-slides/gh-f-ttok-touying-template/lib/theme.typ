#import "@preview/touying:0.6.1": *
#import "@preview/numbly:0.1.0": numbly

#let mytheme(
  text-font: ("Twitter Color Emoji", "Helvetica Neue", "Noto Sans JP"),
  text-size: 21pt,
  math-font: "New Computer Modern Sans Math",
  math-size: 1.05em,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: 1cm,
    ),
    config-common(
      slide-fn: slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: text-font, size: text-size)
        set heading(numbering: "1.")
        set par(leading: 0.9em, spacing: 1.6em)
        set math.lr(size: 1em)
        set math.mat(delim: "[")
        show math.equation: set text(font: math-font, size: math-size)
        set strong(delta: 0)
        set list(marker: (text(size: 1.3em, baseline: -0.08em, "•")))
        show raw: set text(font: ("M PLUS Code Latin 60", "M PLUS 1 Code"), size: 0.97em, weight: "semibold")
        show raw.where(block: true): set block(fill: luma(240), inset: 10pt, radius: 4pt, width: 100%)
        set table(inset: 0.5em, stroke: 1pt+luma(128))
        body
      },
    ),
    pause: utils.semi-transparent-cover.with(alpha: 100%),
    ..args,
  )
  body
}

#let title-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(self, config)
    let info = self.info
    let body = {
      set std.align(horizon + center)
      block(width: 95%, inset: 1em)[
        #align(left)[
          #v(3em)
          #text(weight: "bold", size: 1.5em, info.title)
          #v(-1em)
          #line(length: 100%, stroke: 2pt + rgb("9e9e9e"))

          #v(0.5em)
          #text(weight: "bold", size: 1.2em, info.author)

          #text(size: 1em, info.date)
        ]
      ]
    }
    touying-slide(self: self, body)
  },
)



#let slide(title: auto, ..bodies) = touying-slide-wrapper(
  self => {
    let header(self) = {
      set std.align(top)
      show: components.cell.with(inset: (x: 1.2cm), height: auto)
      set std.align(horizon)
      v(1.4em)
      components.left-and-right(
        utils.fit-to-width(
          100%,
          grow: false,
          text(
            weight: "bold",
            size: 1.3em,
            box(stroke: (bottom: rgb("ccc") + 2.5pt), outset: (bottom: 0.45em), title),
          ),
        ),
        [
          [#context [#h(0.1em)#utils.slide-counter.display()]/#utils.last-slide-number#h(0.1em)]
        ],
      )
    }
    let self = utils.merge-dicts(
      self,
      config-page(
        header: header,
        footer: none,
        margin: (x: 1.4cm, top: 3cm, bottom: 0cm),
      ),
    )
    touying-slide(self: self, ..{ if bodies.at(0) == parbreak() {} else { bodies } })
  },
)

#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(2cm)
    set text(size: 1.5em)
    stack(
      dir: ttb,
      spacing: 0.7em,
      text(self.colors.neutral-darkest, utils.display-current-heading(
        level: level,
        numbered: true,
        style: auto,
      )),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 3.5pt,
          rgb("#ccc"),
          rgb("#ccc"),
        ),
      ),
    )
    // text(self.colors.neutral-dark, body)
  }
  self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.neutral-lightest),
  )
  touying-slide(self: self, config: config, slide-body)
})
