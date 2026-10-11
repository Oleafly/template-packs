#import "@preview/touying:0.8.0": *
#import "../logo.typ": default-logo, render-logo

// 扉页
#let title-slide(
  config: (:),
  logo: auto,
  sublogo: auto,
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  let aspect-ratio = self.store.at("aspect-ratio", default: "16-9")

  let title-margin = if aspect-ratio == "4-3" {
    (top: 2.0em, bottom: 1.8em, x: 2.8em)
  } else {
    (top: 2.2em, bottom: 2.0em, x: 3.6em)
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      header: none,
      footer: none,
      margin: title-margin,
    ),
    config,
  )

  let info = self.info + args.named()

  let main-logo = if logo == auto {
    if "logo" in self.store and self.store.logo != none {
      self.store.logo
    } else {
      default-logo
    }
  } else {
    logo
  }

  let sub-logo = if sublogo != auto {
    sublogo
  } else if "sublogo" in self.store and self.store.sublogo != none {
    self.store.sublogo
  } else {
    none
  }

  let body = {
    place(hide(heading(
      level: self.slide-level,
      if type(info.title) == content { info.title } else { [#info.title] },
      bookmarked: false,
      outlined: false,
      numbering: none,
    )))

    block(width: 100%, breakable: false, align(center + horizon, {
      if main-logo != none {
        render-logo(main-logo, height: 54pt)
        v(1.1em)
      }

      if info.title != none {
        text(
          size: 1.65em,
          weight: "bold",
          fill: self.colors.primary,
          info.title,
        )
      }

      if info.subtitle != none {
        v(0.35em)
        text(
          size: 1.0em,
          weight: "medium",
          fill: self.colors.secondary,
          info.subtitle,
        )
      }

      v(0.6em)
      line(length: 24%, stroke: 1.5pt + self.colors.primary)
      v(0.7em)

      if info.author != none {
        text(
          size: 0.95em,
          weight: "bold",
          fill: self.colors.neutral-darkest,
          info.author,
        )
      }

      if info.institution != none {
        v(0.25em)
        text(
          size: 0.8em,
          fill: self.colors.secondary,
          info.institution,
        )
      }

      if sub-logo != none {
        v(0.6em)
        render-logo(sub-logo, height: 26pt)
      }

      if info.date != none {
        v(0.45em)
        text(
          size: 0.75em,
          fill: self.colors.secondary.lighten(20%),
          utils.display-info-date(self),
        )
      }

      if extra != none {
        v(0.4em)
        extra
      }
    }))
  }

  touying-slide(self: self, body)
})
