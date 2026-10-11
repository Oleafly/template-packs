#import "../../imports.typ": *

// ── Color Palette ─────────────────────────────────────────────────────────────
// Edit theme.json to retheme the whole presentation.

#let _data = json("../../theme.json")

#let bg-color = rgb(_data.colors.background)
#let title-color = rgb(_data.colors.primary)
#let text-color = rgb(_data.colors.text)
#let accent-color = rgb(_data.colors.accent)
#let _section-colors = _data.colors.sections.map(c => rgb(c))
#let col1 = _section-colors.at(0)
#let col2 = _section-colors.at(1)
#let col3 = _section-colors.at(2)
#let col4 = _section-colors.at(3)
#let col5 = _section-colors.at(4)
#let col6 = _section-colors.at(5)
#let col7 = _section-colors.at(6)

#let _font = _data.typography.main_font
#let _base-size = _data.typography.base_size * 1pt
#let _heading-sizes = _data.typography.heading_sizes.map(s => s * 1pt)

// ── Theme function ─────────────────────────────────────────────────────────────
// Apply with: #show: theme.with(slide-fn: slide, ...)

#let theme(
  aspect-ratio: "16-9",
  slide-fn: none,
  ..args,
  body,
) = {
  set text(
    font: _font,
    size: _base-size,
    fill: title-color,
    fallback: true,
  )
  set par(leading: 0.4em, spacing: 1em, justify: false)

  show heading: it => {
    let sizes = _heading-sizes
    let weights = ("bold", "semibold", "medium")
    text(
      size: sizes.at(it.level - 1, default: 20pt),
      weight: weights.at(it.level - 1, default: "regular"),
      fill: title-color,
    )[#it]
  }

  set list(indent: 1.2em, spacing: 0.6em)
  set enum(indent: 1.2em, spacing: 0.6em)

  show footnote.entry: set text(size: 16pt)
  show link: it => text(fill: col6, it)

  set figure(numbering: none)
  show figure.caption: it => text(weight: "bold", fill: title-color, it)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      fill: bg-color,
      width: _data.dimensions.width_cm * 1cm,
      height: _data.dimensions.height_cm * 1cm,
      margin: (
        x: _data.dimensions.margins.x_cm * 1cm,
        y: _data.dimensions.margins.y_cm * 1cm,
      ),
      footer: context [
        #set text(size: 0.8em, fill: luma(50%))
        #set align(right)
        #pad(x: 0.75cm, y: -0.1cm)[#counter(page).display()]
      ],
    ),
    config-colors(
      primary: title-color,
      secondary: col1,
      tertiary: col2,
      neutral-lightest: bg-color,
      neutral-darkest: text-color,
    ),
    config-common(slide-fn: slide-fn),
    ..args,
  )

  body
}
