#import "@preview/touying:0.7.4": *
#import "presentation-utils.typ": *

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
    set strong(delta: 0)
    let header(self) = if title != none {
      show linebreak: none
      if self.store.navigation == "topbar" {
        set align(top)
        show: components.cell.with(fill: self.colors.primary, inset: 1em)
        set align(horizon)
        set text(fill: white, size: 1.25em)
        strong(utils.display-current-heading(level: 1, numbered: false))
        h(1fr)
        text(size: 0.8em, strong(utils.display-current-heading(level: 2, numbered: false)))
      } else if self.store.navigation == "mini-slides" {
        show: components.cell.with(fill: gradient.linear(self.colors.background.darken(10%), self.colors.background, dir: ttb))
        // components.mini-slides(
        my-mini-slides(
          self:self,
          fill: self.colors.primary,
          alpha: 60%,
          linebreaks: false
        )
        line(length: 100%, stroke: 0.5pt + self.colors.primary)

        place(dx: 1em, dy: 0.65em, text(size: 1.2em, fill: self.colors.primary, weight: "bold", utils.display-current-heading(level: 2, numbered: false)))
      }
    } else {
      return none
    }

    let footer(self) = {
       set align(bottom)
       set text(size: 0.8em)

       place(dx: 1em, dy: -1em, {
         grid(
          columns: (1fr, 4fr, 1fr),
          align: center + horizon,
          [ #set image(height: 1.75em)
            #self.info.footer-logo
          ],
          [
            #v(0.25em)
            #text(fill:self.colors.primary, strong(self.info.short-title))
          ],
          [
            #set text(fill:self.colors.primary, weight: "bold")
            #if self.appendix {
              self.store.app-count.step()
              context{
                pad(right: 2em, bottom: 1.5em, top: 0.25em,
                box(stroke: 1.75pt + self.colors.primary, radius: 5pt, inset: -1em,outset: 1.5em)[
                #align(horizon)[#text(fill: self.colors.primary, strong([A | #self.store.app-count.at(here()).first() / #self.store.app-count.final().first()]))]
                ])
              }
            } else {
              context box(stroke: 1.75pt + self.colors.primary, radius: 5pt, inset: -0.5em,outset: 1em)[#utils.slide-counter.display() / #utils.last-slide-number]
            }
          ]
        )
      })

      if self.appendix {
        let appendix-progress-bar = {
          context{
            let ratio = self.store.app-count.at(here()).first()/self.store.app-count.final().first()
            grid(
              columns: (ratio*100%, 1fr),
              components.cell(fill: self.colors.primary),
              components.cell(fill: self.colors.secondary.lighten(50%))
            )
          }
        }
        place(bottom, block(height: 2pt, width: 100%, spacing: 0pt, appendix-progress-bar))
      } else {
        place(bottom, components.progress-bar(height: 2pt, self.colors.primary, self.colors.secondary.lighten(40%)))
      }
    }

    let self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.background,
      header: header,
      footer: footer,
    ),
  )

  let new-setting = body => {
    show: align.with(self.store.align)
    show: setting

    if self.store.navigation == "topbar" {v(-1em)}
    if self.appendix {
      metadata((kind: "touying-appendix-slide"))
    }
    body
  }

  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
  }
)

#let title-slide = touying-slide-wrapper(self => {
  set strong(delta: 0)
  let content = {
    metadata((kind: "touying-title-slide"))
    v(1em)
    set heading(numbering: none)
    set align(center + horizon)
    if self.info.logo != none{
      set image(height: self.info.title-logo-height)
      if type(self.info.logo) == content {
        // place(top + right, dx: -2cm, dy: 0.25cm, self.info.logo)
        place(top + right, dx: -2cm, dy: 1em, self.info.logo)
      } else {
        let im-grid = {
          grid(
            columns: self.info.logo.len(),
            column-gutter: 1fr,
            align: center + horizon,
            inset: 2cm,
            ..self.info.logo.map((logos) => logos)
          )
        }

        // place(top, dy: -1.75cm, im-grid)
        place(top, dy: -1.84em, im-grid)
      }
    }

    block(width: 100%, inset: 2cm, {
      line(length: 100%, stroke: 0.15em + self.colors.primary)
      text(size: 1.75em, strong(self.info.title))
      line(length: 100%, stroke: 0.15em + self.colors.primary)

      if self.info.author != none {
        v(0.5em)
        set text(size: 1em)
        block(spacing: 1em, strong(self.info.author))
      }

      if self.info.institution != none {
        set text(size: 0.85em)
        block(spacing: 1em, self.info.institution)
      }
    })
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.background,
      margin: (top: 0em, bottom: 0em, x: 0em)
    )
  )
  touying-slide(self: self, content)
  }
)

#let content-slide = touying-slide-wrapper(self => {
  let localizaton = json("resources/i18n/fr.json")
  if self.store.lang == "en" {
    localization = json("resources/i18n/en.json")
  }

  set strong(delta: 0)
  show linebreak: none
  let header = {
    if self.store.navigation == "topbar" {
      set align(top)
      show: components.cell.with(fill: self.colors.primary, inset: 1em)
      set align(horizon)
      set text(fill: white, size: 1.25em)
      strong(localizaton.toc)
    } else if self.store.navigation == "mini-slides" {
      set align(top)
      show: components.cell.with(fill: gradient.linear(self.colors.background.darken(10%), self.colors.background, dir: ttb))
      v(0.8em)
      set align(horizon)
      set text(fill: self.colors.primary, size: 1.25em)
      h(0.75em) + strong(localizaton.toc)
      v(-0.6em)
      line(length: 100%, stroke: 0.5pt + self.colors.primary)
    }
  }

 let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: self.colors.background,
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
    components.adaptive-columns(text(size: 1.2em, strong(outline(title:none, indent: 1em, depth: 1))))
}

  touying-slide(self: self, content)
})

#let new-section-slide(level: 1, numbered: true, title) = touying-slide-wrapper(self => {
  let content = {
    set strong(delta: 0)
    if not self.appendix {
      self.store.sec-count.step()
    }

    set align(horizon)
    show: pad.with(10%)
    set text(size: 1.5em)
    v(-0.7em)

    let section-progress-bar = {
      context{
        let ratio = self.store.sec-count.at(here()).first()/self.store.sec-count.final().first()
        grid(
          columns: (ratio*100%, 1fr),
          components.cell(fill: self.colors.primary),
          components.cell(fill: self.colors.secondary.lighten(50%))
        )
      }
    }

   stack(
      dir: ttb,
      spacing: 0.5em,
      [*#utils.display-current-heading(level: level, numbered: false)*],
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        section-progress-bar
      ),
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.background)
  )
  touying-slide(self: self, content)
}
)

#let focus-slide(align: center + horizon, body) = touying-slide-wrapper(self => {
  let _align = align
  let align = _typst-builtin-align

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, margin: 2em),
  )

  set text(fill: white, size: 2em)
  set strong(delta: 0)
  let focus-content = [
    #metadata((kind: "touying-focus-slide"))
    #align(_align, strong(body))
  ]
  touying-slide(self: self, focus-content)
})

#let empty-slide(body) = touying-slide-wrapper(self => {

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.primary, margin: 2em),
  )

  set text(fill: white, size: 2em)
  set strong(delta: 0)
  touying-slide(self: self, align(_align, strong(body)))
})