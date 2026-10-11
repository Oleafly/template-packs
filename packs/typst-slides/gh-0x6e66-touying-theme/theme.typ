#import "@preview/touying:0.6.3": *

#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    if info.logo != none {
      place(right, text(fill: self.colors.primary, info.logo))
    }
    std.align(
      center + horizon,
      {
        block(
          inset: 0em,
          breakable: false,
          {
            text(size: 1.5em, fill: self.colors.primary, strong(info.title))
            if info.subtitle != none {
              parbreak()
              text(size: 1em, fill: self.colors.primary, info.subtitle)
            }
          },
        )
        v(1cm)
        set text(size: .8em)
        grid(
          columns: (1fr,) * calc.min(info.authors.len(), 3),
          column-gutter: 1em,
          row-gutter: 1em,
          ..info.authors.map(author => text(
            fill: self.colors.neutral-darkest,
            author,
          ))
        )
        v(1em)
        if info.institution != none {
          parbreak()
          text(size: .9em, info.institution)
        }
        if info.date != none {
          parbreak()
          text(size: .8em, utils.display-info-date(self))
        }
      },
    )
  }
  touying-slide(self: self, body)
})

#let slide(title: auto, ..args) = touying-slide-wrapper(
  self => {
    if title != auto {
      self.store.title = title
    }

    let header(self) = {
      set align(top)

      context {
        show: components.cell.with(inset: .7em)
        set text(fill: luma(40%), size: .7em)

        "~"

        for i in range(1, 9) {
          let current_heading = utils.current-heading(level: i)
          if current_heading != none {
            let h = ""

            if current_heading.body.has("text") {
              h = current_heading.body.text.replace(" ", "_")
            } else {
              h = current_heading.body
            }

            assert(h != "")

            h = lower(h)
            "/" + h
          }
        }
      }
    }

    let footer(self) = {
      set std.align(center + bottom)
      set text(size: .4em)
      {
        let cell(..args, it) = components.cell(
          ..args,
          inset: 1mm,
          std.align(horizon, text(fill: white, it)),
        )
        show: block.with(width: 100%, height: auto)
        grid(
          columns: self.store.footer-columns,
          rows: 1.5em,
          cell(fill: self.colors.primary, utils.call-or-display(
            self,
            self.store.footer-a,
          )),
          cell(fill: self.colors.secondary, utils.call-or-display(
            self,
            self.store.footer-b,
          )),
          cell(fill: self.colors.tertiary, utils.call-or-display(
            self,
            self.store.footer-c,
          )),
        )
      }
    }

    self = utils.merge-dicts(self, config-page(header: header, footer: footer))
    touying-slide(self: self, ..args)
  },
)

#let new-section-slide(
  config: (:),
  level: 1,
  numbered: false,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em, fill: self.colors.primary, weight: "bold")
    stack(
      dir: ttb,
      spacing: .65em,
      utils.display-current-heading(level: level, numbered: numbered),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.primary-light,
        ),
      ),
    )
    body
  }
  touying-slide(self: self, config: config, slide-body)
})

#let theme(
  aspect-ratio: "16-9",
  progress-bar: true,
  footer-a: self => self.info.author,
  footer-b: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-c: self => {
    h(1fr)
    utils.display-info-date(self)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
    h(1fr)
  },
  ..args,
  body,
) = {
  set text(size: 20pt, font: "Hack Nerd Font Mono")
  set cite(style: "institute-of-physics-numeric")

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      // header-ascent: 0em,
      // footer-descent: 0em,
      margin: (top: 3em, bottom: 1.5em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      slide-level: 99,
    ),
    config-methods(alert: utils.alert-with-primary-color),
    config-colors(
      primary: rgb("#04364a"),
      secondary: rgb("#176b87"),
      tertiary: rgb("#448c95"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    config-store(
      title: none,
      progress-bar: progress-bar,
      footer-columns: (25%, 1fr, 25%),
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
    ..args,
  )

  body
}

