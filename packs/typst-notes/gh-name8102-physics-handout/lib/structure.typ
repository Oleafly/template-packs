#import "state.typ": metadata-state, theme-state

#let _metadata-value(metadata, key) = {
  let value = metadata.at(key, default: none)
  if value == none { return [] }
  text(size: 9pt, fill: theme-state.get().colors.secondary)[#value]
}

// 正式章节使用原生 heading 保留语义；样式在 handout 中统一包成 sticky block。
#let _structure-heading(body, level) = heading(level: level, numbering: none)[#body]

#let _render-heading(it) = context {
  let theme = theme-state.get()
  let (size, color, spacing) = if it.level == 1 {
    (theme.text.chapter-size, theme.colors.rule, theme.spacing.xl)
  } else if it.level == 2 {
    (theme.text.section-size, theme.colors.text, theme.spacing.lg)
  } else {
    (theme.text.subsection-size, theme.colors.rule, theme.spacing.md)
  }
  block(
    width: 100%,
    sticky: true,
    breakable: false,
    above: spacing,
    below: spacing,
  )[
    #text(size: size, fill: color, weight: 700)[#it.body]
  ]
}

#let handout-title(
  title: none,
  subtitle: none,
  metadata: (:),
) = context {
  let theme = theme-state.get()
  let meta = metadata-state.get()
  let merged = meta
  if type(metadata) == dictionary {
    for (key, value) in metadata { merged.insert(key, value) }
  }
  let colors = theme.colors
  let sizes = theme.text
  let fonts = theme.fonts
  block(breakable: false, above: 0pt, below: sizes.title-size / 2)[
    #align(center)[
      #text(font: fonts.sans, size: sizes.title-size, weight: 700, fill: colors.rule)[#title]
      #if subtitle != none [
        #v(theme.spacing.sm)
        #text(font: fonts.sans, size: sizes.section-size, fill: colors.secondary)[#subtitle]
      ]
    ]
    #v(theme.spacing.md)
    #line(length: 100%, stroke: theme.stroke.strong + colors.rule)
    #v(theme.spacing.sm)
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: theme.spacing.md,
      align: (left, center, right),
      [#_metadata-value(merged, "school")],
      [#_metadata-value(merged, "grade")],
      [#_metadata-value(merged, "subject")],
    )
  ]
}

#let chapter(body) = _structure-heading(body, 1)

#let section(body) = _structure-heading(body, 2)

#let subsection(body) = _structure-heading(body, 3)
