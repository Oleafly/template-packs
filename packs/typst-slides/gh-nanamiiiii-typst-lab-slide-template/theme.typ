#import "@preview/touying:0.7.4": *

// Theme colors taken from slide_template_wide.pptx.
#let kasaken-colors = (
  title: rgb("#00b0f0"),
  footer: rgb("#b3424a"),
  blue: rgb("#4f81bd"),
  green: rgb("#9bbb59"),
  orange: rgb("#f79646"),
  rose: rgb("#d99694"),
  peach: rgb("#fac090"),
)

#let list-depth = counter("kasaken-list-depth")

// Reduce nested lists by 2pt per level while retaining a readable minimum.
#let sized-list(it, base-size: 24pt, step: 2pt, min-size: 16pt, leading: 0.55em) = {
  list-depth.step()
  context {
    let depth = list-depth.get().first()
    set text(size: calc.max(min-size, base-size - step * (depth - 1)))
    set par(leading: leading)
    it
  }
  list-depth.update(depth => depth - 1)
}

#let footer-date(self) = {
  if type(self.info.date) == datetime {
    self.info.date.display("[year]/[month]/[day]")
  } else {
    self.info.date
  }
}

#let decorations(self, show-heading: true) = block(width: 100%, height: 100%, fill: white)[
  // These positions are direct conversions from the PowerPoint master.
  #place(top + left, dx: 0in, dy: 1in, rect(
    width: 1.25in,
    height: 0.15625in,
    fill: kasaken-colors.blue,
    stroke: none,
  ))
  #place(top + left, dx: 1.35417in, dy: 1in, rect(
    width: 0.9375in,
    height: 0.15625in,
    fill: kasaken-colors.green,
    stroke: none,
  ))
  #place(top + left, dx: 2.39583in, dy: 1in, rect(
    width: 0.625in,
    height: 0.15625in,
    fill: kasaken-colors.orange,
    stroke: none,
  ))
  #place(top + left, dx: 3.125in, dy: 1in, rect(
    width: 0.3125in,
    height: 0.15625in,
    fill: kasaken-colors.rose,
    stroke: none,
  ))
  #place(top + left, dx: 3.54167in, dy: 1in, rect(
    width: 0.3125in,
    height: 0.15625in,
    fill: kasaken-colors.peach,
    stroke: none,
  ))
  #place(bottom + left, block(width: 100%, height: 0.625in, fill: kasaken-colors.footer)[
    #set text(size: 12pt, weight: "bold", fill: white)
    #set align(horizon)
    #pad(x: 0.667in, grid(
      columns: (1fr, 1.35fr, 1fr),
      align: (left + horizon, center + horizon, right + horizon),
      footer-date(self),
      utils.call-or-display(self, self.store.footer-text),
      context str(utils.slide-counter.get().first() + 1),
    ))
  ])
  #if show-heading {
    place(top + left, dx: self.store.page-title-left, dy: 0.16in, block(
      width: 13.333in - self.store.page-title-left - 0.667in,
      height: 0.72in,
    )[
      #set text(size: self.store.page-title-size, weight: "bold", fill: kasaken-colors.title)
      #align(left + horizon, utils.display-current-heading(
        level: 2,
        setting: utils.fit-to-width.with(grow: false, 100%),
      ))
    ])
  }
]

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(
      fill: white,
      background: decorations(self),
      header: none,
      footer: none,
    ),
  )
  let content-setting = body => {
    set text(fill: black, size: self.store.body-font-size)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: content-setting,
    composer: composer,
    ..bodies,
  )
})

// Title page matching the centered title/subtitle placeholders in the PPTX.
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(
      fill: white,
      background: decorations(self, show-heading: false),
      header: none,
      footer: none,
      margin: (top: 1.95in, bottom: 0.9in, x: 1in),
    ),
    config,
  )
  let info = self.info + args.named()
  let body = align(center + horizon, block(width: 100%)[
    #set align(center)
    #text(size: 40pt, weight: "bold", fill: kasaken-colors.title, utils.fit-to-width(
      grow: false,
      100%,
      info.title,
    ))
    #if info.subtitle != none {
      v(0.45in)
      text(size: 23pt, fill: black, info.subtitle)
    }
    #if info.author != none {
      v(0.18in)
      text(size: 19pt, fill: black, info.author)
    }
  ])
  touying-slide(self: self, body)
})

#let kasaken-theme(
  aspect-ratio: "16-9",
  footer-text: self => self.info.institution,
  page-title-size: 36pt,
  page-title-left: 0.35in,
  body-font-size: 24pt,
  list-font-step: 2pt,
  min-list-font-size: 16pt,
  list-leading: 0.55em,
  ..args,
  body,
) = {
  set text(font: "Noto Sans CJK JP", size: body-font-size)
  set par(leading: 0.45em)
  show strong: set text(weight: "bold")
  show list: it => sized-list(
    it,
    base-size: body-font-size,
    step: list-font-step,
    min-size: min-list-font-size,
    leading: list-leading,
  )

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      // 0.19in of clear space remains below the 0.15625in-high color bars.
      margin: (top: 1.35in, bottom: 0.78in, x: 0.667in),
    ),
    config-common(
      slide-fn: slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "Noto Sans CJK JP", size: body-font-size)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: kasaken-colors.title,
      neutral-lightest: white,
      neutral-darkest: black,
    ),
    config-store(
      footer-text: footer-text,
      page-title-size: page-title-size,
      page-title-left: page-title-left,
      body-font-size: body-font-size,
    ),
    ..args,
  )
  body
}

