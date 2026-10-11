#import "@preview/touying:0.8.0": *

// 幻灯片标题与副标题区域渲染
#let render-subslide-preamble(self) = {
  let style = self.store.at("style", default: "academic")

  let title-node = if self.store.title != auto and self.store.title != none {
    utils.call-or-display(self, self.store.title)
  } else {
    utils.display-current-heading(level: 2)
  }

  let subtitle-node = if self.store.subtitle != none {
    utils.call-or-display(self, self.store.subtitle)
  } else {
    none
  }

  if title-node != none {
    if style == "minimal" {
      // 极简风格标题
      block(below: 1.0em, {
        text(
          fill: self.colors.neutral-darkest,
          weight: "bold",
          size: 1.35em,
          title-node,
        )
        if subtitle-node != none {
          v(0.25em)
          text(
            fill: self.colors.secondary,
            weight: "regular",
            size: 0.85em,
            subtitle-node,
          )
        }
      })
    } else if style == "bold" {
      // 科技风格标题
      block(below: 1.15em, {
        text(
          fill: self.colors.primary,
          weight: "bold",
          size: 1.4em,
          title-node,
        )
        if subtitle-node != none {
          v(0.25em)
          text(
            fill: self.colors.secondary,
            weight: "medium",
            size: 0.9em,
            subtitle-node,
          )
        }
      })
    } else {
      // 典雅风格标题
      block(below: 1.15em, {
        text(
          fill: self.colors.primary,
          weight: "bold",
          size: 1.35em,
          title-node,
        )
        if subtitle-node != none {
          v(0.25em)
          text(
            fill: self.colors.secondary,
            weight: "medium",
            size: 0.85em,
            subtitle-node,
          )
        }
      })
    }
  }
}
