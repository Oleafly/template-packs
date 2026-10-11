#import "@preview/touying:0.6.1": *

#let nerd-fonts = (
  "JetBrainsMono Nerd Font",
  "CaskaydiaCove Nerd Font",
  "FiraCode Nerd Font",
  "Iosevka Nerd Font",
  "Hack Nerd Font",
  // fallbacks if Nerd Fonts aren't present
  "JetBrains Mono",
  "Cascadia Code",
  "Fira Code",
  "Iosevka",
  "Hack",
)

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  let header(self) = {
    set align(top)
    show: components.cell.with(fill: self.colors.neutral-darker, inset: 1em)
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: .7em)
    utils.display-current-heading(level: 1)
    linebreak()
    set text(size: 1.5em)
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
  }
  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: self.colors.neutral-lighter, size: .8em)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
      fill: self.colors.neutral-darkest,
    ),
  )
  touying-slide(self: self, ..args)
})

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  self = utils.merge-dicts(
    self,
    config-page(background: {
      image("background.png", width: 100%, height: 100%)
    }),
  )
  let body = {
    set align(left + bottom)
    block(
      //fill: self.colors.primary,
      width: 40%,
      inset: (y: 1em),
      //radius: 1em,
      text(size: 2em, fill: self.colors.neutral-lightest, weight: "bold", info.title),
    )
    set text(fill: self.colors.neutral-lighter)
    if info.author != none {
      block(info.author)
    }
    if info.date != none {
      block(utils.display-info-date(self))
    }
  }
  touying-slide(self: self, body)
})

#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.neutral-darker,
      margin: 2em,
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: 2em)
  touying-slide(self: self, align(horizon + center, block(
    stroke: (paint: self.colors.primary, thickness: .2em),
    inset: 1em,
    radius: .5em,
    body,
  )))
})

#let custom-theme(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body,
) = {
  set text(size: 20pt, fill: rgb("#FFFFFF"), font: nerd-fonts)
  set raw(syntaxes: "aiken.sublime-syntax")

  show raw.where(block: true): it => align(center, block(
    fill: rgb("#1d2433"),
    inset: 1em,
    radius: 1em,
    text(fill: rgb("#cdd2de"), it),
  ))
  show raw.where(block: false): it => box(
    fill: rgb("#1d2433"),
    outset: 0.5em,
    radius: 0.5em,
    text(fill: rgb("#cdd2de"), it),
  )

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 4em, bottom: 1.5em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
    ),
    config-methods(
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: rgb("#FF2D55"),
      neutral-lightest: rgb("#FFFFFF"),
      neutral-lighter: rgb("#D1D5DB"),
      neutral-dark: rgb("#1F2937"),
      neutral-darker: rgb("#161B22"),
      neutral-darkest: rgb("#0D1117"),
    ),
    config-store(
      title: none,
      footer: footer,
    ),
    ..args,
  )

  body
}


