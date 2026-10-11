#import "@preview/touying:0.8.0": *

// 基础卡片渲染函数
#let render-card(
  self: none,
  title: none,
  accent-color: rgb("#003a8c"),
  bg-color: rgb("#f8fafc"),
  stroke-color: rgb("#e2e8f0"),
  radius: (right: 6pt, left: 2pt),
  it,
) = {
  let style = if self != none and "store" in self and "style" in self.store {
    self.store.style
  } else {
    "academic"
  }

  if style == "bold" and title != none {
    // 科技风格卡片
    block(
      width: 100%,
      breakable: false,
      radius: 6pt,
      fill: bg-color,
      stroke: 0.6pt + stroke-color,
      inset: (x: 1.15em, y: 0.75em),
      spacing: 0.9em,
      {
        box(
          fill: accent-color,
          radius: 3pt,
          inset: (x: 0.6em, y: 0.25em),
          text(fill: white, weight: "bold", size: 0.85em, title),
        )
        v(0.35em)
        it
      },
    )
  } else {
    // 典雅与极简风格卡片
    block(
      width: 100%,
      breakable: false,
      radius: radius,
      fill: bg-color,
      stroke: (
        left: 3.5pt + accent-color,
        top: 0.5pt + stroke-color,
        right: 0.5pt + stroke-color,
        bottom: 0.5pt + stroke-color,
      ),
      inset: (x: 1.15em, y: 0.75em),
      spacing: 0.9em,
      {
        if title != none {
          text(fill: accent-color, weight: "bold", size: 0.95em, title)
          v(0.3em)
        }
        it
      },
    )
  }
}

// 标准区块
#let _tblock(self: none, title: none, it) = {
  let primary = if (
    self != none and "colors" in self and "primary" in self.colors
  ) {
    self.colors.primary
  } else {
    rgb("#003a8c")
  }
  render-card(
    self: self,
    title: title,
    accent-color: primary,
    bg-color: rgb("#f4f7fc"),
    stroke-color: rgb("#d6e4f7"),
    it,
  )
}

#let tblock(title: none, it) = touying-fn-wrapper-raw(
  _tblock.with(title: title),
  it,
)

#let ucas-block = tblock

// 示例区块
#let _exampleblock(self: none, title: [示例], it) = {
  let secondary = if (
    self != none and "colors" in self and "secondary" in self.colors
  ) {
    self.colors.secondary
  } else {
    rgb("#64748b")
  }
  render-card(
    self: self,
    title: title,
    accent-color: secondary,
    bg-color: rgb("#f8fafc"),
    stroke-color: rgb("#e2e8f0"),
    it,
  )
}

#let exampleblock(title: [示例], it) = touying-fn-wrapper-raw(
  _exampleblock.with(title: title),
  it,
)

// 警示区块
#let _alertblock(self: none, title: [强调], it) = {
  let accent = if (
    self != none and "colors" in self and "accent" in self.colors
  ) {
    self.colors.accent
  } else {
    rgb("#d97706")
  }
  render-card(
    self: self,
    title: title,
    accent-color: accent,
    bg-color: rgb("#fffbeb"),
    stroke-color: rgb("#fef3c7"),
    it,
  )
}

#let alertblock(title: [强调], it) = touying-fn-wrapper-raw(
  _alertblock.with(title: title),
  it,
)
