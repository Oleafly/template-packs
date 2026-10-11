#import "../common/_deps.typ": *
#import "_pres-utils.typ": *

#let _typst-builtin-align = align

#let slide(
  title: auto,
  subtitle: none,
  align: horizon,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
    if align != auto {
      self.store.align = align
    }

    let align = _typst-builtin-align
    set strong(delta: 50)
    let header(self) = {
      show linebreak: none
      set align(top)
      show: components.cell.with(inset: 1em)
      set text(size: 1.25em)
      [*#utils.display-current-heading(level: 1, numbered: false)* #h(1fr) #text(size: 0.8em)[*#utils.display-current-heading(level: 2, numbered: false)*]]
    }

    let footer(self) = context {
      place(right, dx: -15pt, dy: -5pt)[#utils.slide-counter.at(here()).first() / #utils.last-slide-number]
    }

    let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )

  let new-setting = body => {
    show: align.with(self.store.align)
    show: setting

    body
  }

  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
  }
)

#let title-slide = touying-slide-wrapper(self => {
  let content = {
    let title-logo-height = 6.5%
    let dy = -1.25cm
    if self.store.composante != "cnam" {
      title-logo-height= 12%
      dy = -1.75cm
    }
    set strong(delta: 50)
    set image(height: title-logo-height)
    place(top + right, dx: -1cm, dy: dy, self.store.logo)

    if self.info.facade == "image" {
      title-box(self.store.colors.primary, title: text(size: 50pt)[*#self.info.title*], subtitle: text(size: 20pt, weight: "light")[*#self.info.subtitle*], color-title: self.store.colors.text-title)

      place(center + bottom, dy: 0.5cm, image("../resources/assets/facade-image-" + self.store.color-theme-name + ".png", width: 95%, height: 28%))

    } else if self.info.facade == "photo" {

      title-box(image("../resources/assets/photo-cnam.png", width: 100%, height: 110%, fit: "stretch"), title: text(size: 50pt)[*#self.info.title*], subtitle: text(size: 20pt, weight: "light")[*#self.info.subtitle*], color-title: self.store.colors.text-title)
    }

    if self.info.over-title != none {
      place(top + left, dx: -0.5cm, dy: -1.29cm)[#over-title(self.info.over-title)]
    }
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: (top: 2cm, left: 1.25cm, x: 0em)
    )
  )
  touying-slide(self: self, content)
  }
)

#let content-slide(title: "Sommaire") = touying-slide-wrapper(self => {
  let header = {
      set align(top)
      show: components.cell.with(inset: 1em)
      set align(horizon)
      set text(size: 1.25em)
      strong(title, delta: 50)
  }

 let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      header: header,
    ),
  )

  let content = {
    set outline.entry(fill: none)
    show outline.entry: it => context {
      let number = it.prefix()
      let section = it.element.body
      block(above: 2em, below: 0em)
      [#text([#number], fill: self.colors.primary) #h(0.25em) #section]
    }

    set align(horizon)
    components.adaptive-columns(text(size: 1.2em, strong(outline(title:none, indent: 1em, depth: 1), delta: 50)))
  }

  touying-slide(self: self, content)
})

#let new-section-slide(self: none, numbered: false, title)= touying-slide-wrapper(self => {
  let content = {
    let title-logo-height = 6.5%
    let dy = -1.25cm
    if self.store.composante != "cnam" {
      title-logo-height= 12%
      dy = -1.75cm
    }

    title

    title-box(self.store.colors.secondary, title: text(size: 45pt)[#utils.display-current-heading(level: 1, numbered: numbered)], subtitle: none, color-title: self.store.colors.section-title)

    if self.info.over-title != none {
      place(top + left, dx: -0.5cm, dy: -1.29cm)[#over-title(self.info.over-title)]
    }
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: (top: 2cm, left: 1.25cm, x: 0em)
    )
  )
  touying-slide(self: self, content)
}
)

#let focus-slide(body, overtitle: false) = touying-slide-wrapper(self => {
  let content = {
    title-box(self.store.colors.secondary, title: text(size: 45pt, weight: "semibold")[#body], subtitle: none, color-title: self.store.colors.text-focus)

    if overtitle {
      place(top + left, dx: -0.5cm, dy: -1.29cm)[#over-title(self.info.over-title)]
    }
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: (top: 2cm, left: 1.25cm, x: 0em, bottom: 0em)
    )
  )
  touying-slide(self: self, content)
  }
)