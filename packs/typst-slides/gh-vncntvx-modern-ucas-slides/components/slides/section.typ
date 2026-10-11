#import "@preview/touying:0.8.0": *

// 章节过渡页
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  ..bodies,
) = touying-slide-wrapper(self => {
  let body = bodies.pos().at(0, default: none)
  let style = self.store.at("style", default: "academic")

  if style == "bold" {
    // 科技风格转场
    let self-bold = utils.merge-dicts(
      self,
      config-page(
        fill: self.colors.primary,
        header: none,
        footer: none,
      ),
    )
    let setting-bold(level, numbered, body) = {
      align(center + horizon, {
        text(
          size: 2.0em,
          weight: "bold",
          fill: white,
          utils.display-current-heading(level: level, numbered: numbered),
        )
        v(0.6em)
        line(length: 25%, stroke: 2pt + white.transparentize(30%))
        if body != none [
          #v(0.8em)
          #text(size: 0.9em, fill: white.transparentize(20%), body)
        ]
      })
    }
    touying-slide(
      self: self-bold,
      config: config,
      setting: setting-bold.with(level, numbered),
      body,
    )
  } else {
    // 典雅与极简风格转场
    let setting(level, numbered, body) = {
      align(center + horizon, {
        text(
          size: 1.8em,
          weight: "bold",
          fill: self.colors.primary,
          utils.display-current-heading(level: level, numbered: numbered),
        )
        v(0.8em)
        line(length: 25%, stroke: 1.5pt + self.colors.primary)
        if body != none [
          #v(0.8em)
          #text(size: 0.9em, fill: self.colors.secondary, body)
        ]
      })
    }
    touying-slide(
      self: self,
      config: config,
      setting: setting.with(level, numbered),
      body,
    )
  }
})
