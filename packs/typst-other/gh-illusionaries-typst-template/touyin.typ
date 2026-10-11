#import "@preview/touying:0.7.1": *
#import "@preview/cetz-plot:0.1.3"
#import "@preview/cetz:0.4.2"
#import themes.default: *

#let corner-theme(..args, body) = [
  #let common-footer(self) = {
    place(bottom, utils.touying-progress(ratio => box(
      fill: self.colors.primary,
      height: 4pt,
      width: ratio * 100%,
    )))
  }

  #let common-header(self) = {
    place(bottom + end, dx: -1em, text(
      fill: self.colors.primary.transparentize(80%),
      size: 0.8em,
    )[#context utils.slide-counter.display() / #utils.last-slide-number])
  }

  #show: default-theme.with(
    config-page(
      margin: (x: 2em, y: 1.5em),
      footer-descent: 0em,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        set strong(delta: 0)
        show strong: underline.with(stroke: self.colors.primary.transparentize(75%) + 0.2em, evade: false)
        show footnote.entry: set text(size: .6em)
        show heading.where(level: 1): set text(1.4em)
        set table(
          stroke: (x, y) => {
            if y == 0 {
              return (bottom: self.colors.primary.transparentize(70%))
            } else {
              return none
            }
          },
          inset: (x: 0.5em, y: 0.35em),
        )
        set table.hline(stroke: self.colors.primary.transparentize(90%))
        set table.vline(stroke: self.colors.primary.transparentize(90%))
        show table.cell.where(y: 0): it => text(self.colors.primary, it)
        show figure.caption: set text(size: .8em, fill: self.colors.primary.transparentize(30%))
        show link: underline.with(offset: 0.2em)
        show link: set text(fill: self.colors.primary)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-common(
      slide-fn: (config: (:), repeat: auto, setting: body => body, composer: auto, body) => {
        slide(
          repeat: repeat,
          config: utils.merge-dicts(config-page(
            header: common-header,
            footer: common-footer,
          ), config),
          self => {
            block({
              set text(weight: "regular", size: 1.5em, fill: self.colors.primary)
              utils.display-current-heading(depth: 2)
            })

            place(
              bottom,
              dx: -self.page.margin.x,
              dy: self.page.margin.y,
              text(
                fill: self.colors.primary.transparentize(95%),
                size: 3em,
                utils.display-current-heading(level: 1),
              ),
            )

            if type(body) == function {
              body(self)
            } else {
              body
            }
          },
        )
      },
      new-section-slide-fn: (config: (:), body) => {
        slide(config: config-page(header: common-header, footer: common-footer), self => {
          set align(bottom)
          block(inset: (bottom: 1em))[
            #counter("section").step()
            #context {
              text(size: 1.5em, fill: self.colors.primary.transparentize(80%))[Section #counter("section").display()]
            }\
            #par(leading: 1.4em, text(3em, self.colors.primary, utils.display-current-heading(level: 1)))
            #body
          ]
        })
      },
    ),
    ..args,
  )

  #body
]