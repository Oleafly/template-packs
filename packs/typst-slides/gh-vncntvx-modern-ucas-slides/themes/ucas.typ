#import "@preview/touying:0.8.0": *
#import "../components/slides/section.typ": (
  new-section-slide as _new-section-slide-fn,
)
#import "./colors.typ": ucas-colors
#import "./slide.typ": notes, slide

// 主题入口函数
#let ucas-theme(
  style: "academic",
  aspect-ratio: "16-9",
  align: top,
  logo: auto,
  header-logo: auto,
  sublogo: none,
  new-section-slide: false,
  font: (
    "PingFang SC",
    "Hiragino Sans GB",
    "Source Han Sans SC",
    "Heiti SC",
    "Arial",
  ),
  ..args,
  body,
) = {
  // 页面边距设置
  let page-margins = if aspect-ratio == "4-3" {
    (top: 2.6em, bottom: 2.0em, x: 2.6em)
  } else {
    (top: 2.8em, bottom: 2.2em, x: 3.2em)
  }

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: page-margins,
      fill: ucas-colors.neutral-lightest,
    ),
    config-common(
      slide-fn: slide,
      notes-fn: notes,
      new-section-slide-fn: if new-section-slide {
        _new-section-slide-fn
      } else { none },
    ),
    config-colors(
      primary: ucas-colors.primary,
      primary-dark: ucas-colors.primary-dark,
      primary-light: ucas-colors.primary-light,
      secondary: ucas-colors.secondary,
      text: ucas-colors.text,
      accent: ucas-colors.accent,
      crimson: ucas-colors.crimson,
      emerald: ucas-colors.emerald,
      neutral-lightest: ucas-colors.neutral-lightest,
      neutral-darkest: ucas-colors.neutral-darkest,
    ),
    config-store(
      align: align,
      style: style,
      aspect-ratio: aspect-ratio,
      page-margins: page-margins,
      logo: if logo == auto {
        image("../assets/vi/ucas-logo-H-standard.svg")
      } else {
        logo
      },
      header-logo: header-logo,
      sublogo: sublogo,
      title: auto,
      subtitle: none,
    ),
    config-methods(
      init: (self: none, body) => {
        // 正文字体与字号
        set text(
          size: 20pt,
          fill: ucas-colors.text,
          font: font,
          lang: "zh",
        )

        // 段落排版
        set par(leading: 0.65em, justify: false)

        // 项目符号列表
        set list(
          spacing: 0.85em,
          marker: (
            text(fill: self.colors.primary, sym.square.filled.small),
            text(fill: self.colors.secondary, sym.circle.filled.small),
            text(fill: self.colors.secondary, sym.dash.en),
          ),
        )

        // 编号列表
        set enum(spacing: 0.85em)

        // 超链接
        show link: it => text(fill: self.colors.primary, underline(
          stroke: 0.5pt + self.colors.primary,
          offset: 2pt,
          it,
        ))

        // 表格样式
        show table: set table(
          stroke: (x, y) => if y == 0 {
            (
              bottom: 1.5pt + self.colors.primary,
              top: 1.5pt + self.colors.primary,
            )
          } else {
            (bottom: 0.5pt + rgb("#cbd5e1"))
          },
          inset: 0.6em,
        )

        // 图表题注
        show figure.caption: set text(size: 0.75em, fill: self.colors.secondary)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    ..args,
  )

  body
}
