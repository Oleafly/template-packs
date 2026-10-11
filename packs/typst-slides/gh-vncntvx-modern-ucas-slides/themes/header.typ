#import "@preview/touying:0.8.0": *
#import "../components/logo.typ": default-emblem, render-logo

// 顶栏布局函数
#let render-header(self) = {
  set std.align(top)
  let style = self.store.at("style", default: "academic")
  let mx = self.store.at("page-margins", default: (x: 3.2em)).x

  let header-logo = if (
    "header-logo" in self.store and self.store.header-logo != auto
  ) {
    self.store.header-logo
  } else {
    default-emblem
  }

  let logo-node = if header-logo != none {
    render-logo(header-logo, height: 30pt)
  } else {
    none
  }

  if style == "minimal" {
    // 极简风格：左侧微型章节标签，右侧视觉标识
    let sec = utils.display-current-heading(level: 1)
    pad(top: 8pt, x: mx, {
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        if sec != none {
          set text(
            size: 0.55em,
            fill: self.colors.secondary,
            weight: "medium",
            tracking: 0.08em,
          )
          upper(sec)
        } else { [] },
        logo-node,
      )
    })
  } else if style == "bold" {
    // 科技风格：顶部进度条，右侧视觉标识
    place(top, components.progress-bar(
      height: 2.5pt,
      self.colors.primary,
      self.colors.primary-light,
    ))
    pad(top: 8pt, x: mx, {
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [], logo-node,
      )
    })
  } else {
    // 典雅风格：顶部横线，左侧章节路径导航，右侧视觉标识
    let sec = utils.display-current-heading(level: 1)
    let subsec = utils.display-current-heading(level: 2)

    place(top + left, rect(
      width: 100%,
      height: 1.5pt,
      fill: self.colors.primary,
    ))
    pad(top: 8pt, x: mx, {
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        [
          #set text(size: 0.55em, fill: self.colors.secondary)
          #sec
          #(if subsec != none [ #h(0.8em) / #h(0.8em) #subsec ])
        ],
        logo-node,
      )
    })
  }
}
