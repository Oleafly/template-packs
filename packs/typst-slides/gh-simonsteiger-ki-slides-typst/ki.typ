#import "@preview/touying:0.6.1": *
#import "extras.typ": *

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  let header(self) = {
    set align(top)
    show: components.cell.with(fill: self.colors.primary, inset: 1em, width: 100%)
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: font-size.large, weight: "bold")
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
    place(right + horizon, image("ki-logo-neg.svg", height: 2cm))
  }
  let footer(self) = {
    set align(bottom)
    show: components.cell.with(fill: self.colors.secondary, inset: (x: .75em, y: 0.5em), height: 50%, width: 100%)
    set text(fill: self.colors.neutral-darkest, size: font-size.smaller)
    utils.call-or-display(self, self.store.footer)
    utils.display-current-heading(level: 1)
    h(1fr)
    context {
      let appendix-loc = query(<appendix>)
      if appendix-loc.len() > 0 {
        let frozen = utils.slide-counter.at(appendix-loc.first().location())
        let current = utils.slide-counter.get()
        if current.first() <= frozen.first() {
          utils.slide-counter.display() + " / " + str(frozen.first())
        }
      } else {
        utils.slide-counter.display() + " / " + utils.last-slide-number
      }
    }
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, ..args)
})

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = {
    place(bottom + right, image("ki-logo-pos.svg", height: 2cm), dx: 3em, dy: 3.5em)
    set align(center + horizon)
    block(scale_title(text(weight: "bold", info.title)))
    v(.75em)
    block(text(size: font-size.body, info.subtitle))
    set align(bottom + center)
    set text(size: font-size.smaller)
    if info.author != none {
      block(info.author)
    }
    if info.date != none {
      place(bottom + center, utils.display-info-date(self), dy: 3.5em)
    }
  }
  touying-slide(self: self, body)
})

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  let main-body = {
    place(bottom + right, image("ki-logo-pos.svg", height: 2cm), dx: 3em, dy: 3.5em)
    set align(self.store.new-section-adjust + horizon)
    text(size: font-size.xl, weight: "bold", utils.display-current-heading(level: 1))
    block(scale_text(90pt, max_font_size: 24pt, body))
  }
  touying-slide(self: self, main-body)
})

#let focus-slide(size: 2em, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.primary,
      margin: 2em,
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: size)
  touying-slide(self: self, align(horizon + left, body))
})

#let image-slide(body, background: none) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      background: background,
      margin: 2em,
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: 2em)
  set image(width: 100%,height: auto)
  touying-slide(self: self, align(horizon + center, body))
})

#let ki-theme(
  aspect-ratio: "16-9",
  new-section-adjust: center,
  footer: none,
  ..args,
  body,
) = {
  set text(font: "DM Sans", size: 20pt)
  set list(marker: ([•], [--]))

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (x: 4em, y: 4em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-colors(
      primary: ki-colors.plum_dark,
      secondary: ki-colors.blue_light,
      tertiary: ki-colors.plum,
      neutral-lightest: white,
      neutral-darkest: black,
    ),
    config-methods(
      // alert: (self: none, it) => text(fill: self.colors.neutral-darkest, it)
    ),
    config-store(
      title: none,
      new-section-adjust: new-section-adjust,
      footer: footer,
    ),
    ..args
  )

  body
}
