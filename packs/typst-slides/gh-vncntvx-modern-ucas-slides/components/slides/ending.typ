#import "@preview/touying:0.8.0": *
#import "../logo.typ": default-logo, render-logo

// 结语页
#let ending-slide(
  config: (:),
  title: [谢谢],
  subtitle: [敬请各位老师、同学批评指正],
  contact: none,
  ..args,
) = touying-slide-wrapper(self => {
  let main-logo = if "logo" in self.store and self.store.logo != none {
    self.store.logo
  } else {
    default-logo
  }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      header: none,
      footer: none,
    ),
    config,
  )

  let body = {
    place(hide(heading(
      level: self.slide-level,
      title,
      bookmarked: false,
      outlined: false,
      numbering: none,
    )))

    align(center + horizon, {
      if main-logo != none {
        render-logo(main-logo, height: 54pt)
        v(1.5em)
      }

      text(
        size: 2.4em,
        weight: "bold",
        fill: self.colors.primary,
        title,
      )

      if subtitle != none {
        v(0.8em)
        text(
          size: 1.05em,
          fill: self.colors.secondary,
          subtitle,
        )
      }

      if contact != none {
        v(1.2em)
        text(
          size: 0.85em,
          fill: self.colors.secondary.lighten(20%),
          contact,
        )
      }
    })
  }

  touying-slide(self: self, body)
})
