#import "state.typ": theme-state
#import "theme.typ": default-theme
#import "attachments.typ": _attachment-layout, attachment-group

// 普通正文不进入知识块；knowledge 只承载短小的核心定义、规律和结论。
#let knowledge(title: none, body) = context {
  let theme = theme-state.get()
  block(
    width: 100%,
    breakable: false,
    above: theme.spacing.sm,
    below: theme.spacing.sm,
    inset: (
      left: theme.inset.block-x + 1pt,
      right: theme.inset.table-x,
      top: 5pt,
      bottom: 5pt,
    ),
    fill: none,
    stroke: (left: theme.stroke.strong + theme.colors.rule),
  )[
    #if title != none [
      #text(weight: 700, fill: theme.colors.rule)[#title]
      #v(theme.spacing.xs)
    ]
    #body
  ]
}

#let _outlined-label(title, theme) = box(
  inset: (x: 2pt, y: 4pt),
  stroke: theme.stroke.normal + theme.colors.rule,
)[
  #text(weight: 700, fill: theme.colors.rule)[#title]
]

// 警示只用于易错点、边界条件和反例，不承载连续讲解。
#let warning-block(title: [易错], body) = context {
  let theme = theme-state.get()
  block(
    width: 100%,
    breakable: false,
    above: theme.spacing.md,
    below: theme.spacing.md,
    inset: (x: 7pt, y: 6pt),
    fill: none,
    stroke: (
      top: theme.stroke.normal + theme.colors.rule,
      bottom: theme.stroke.normal + theme.colors.rule,
    ),
  )[
    #_outlined-label(title, theme)
    #h(theme.spacing.sm)
    #body
  ]
}

// 扩展块专门承载扩展知识和高级结论；使用楷体和小字号，与正文保持距离。
#let extension-block(title: [拓展], body) = context {
  let theme = theme-state.get()
  block(
    width: 100%,
    breakable: false,
    above: theme.spacing.sm,
    below: theme.spacing.sm,
    inset: (
      left: theme.inset.block-x + 1pt,
      right: theme.inset.table-x,
      top: 5pt,
      bottom: 5pt,
    ),
    fill: none,
    stroke: (left: theme.stroke.hairline + theme.colors.rule),
  )[
    #set text(font: theme.fonts.kai, size: theme.text.extension-size)
    #text(weight: 700, fill: theme.colors.rule)[#title]
    #v(theme.spacing.xs)
    #body
  ]
}

#let concept-content(
  text: none,
  attachments: (),
  placement: "auto",
) = context {
  assert(
    placement in ("auto", "side", "below"),
    message: "physics-handout: concept-content: placement must be auto, side, or below; found "
      + repr(placement),
  )
  if text == none and attachments.len() == 0 { return [] }
  if attachments.len() == 0 { return text }
  let theme = theme-state.get()
  if theme == none { theme = default-theme }
  if text == none { return attachment-group(attachments: attachments, placement: placement) }
  if placement == "below" or placement == "auto" {
    [#text #v(theme.spacing.md) #attachment-group(attachments: attachments, placement: placement)]
  } else {
    layout(size => {
      let attachment-width = size.width * 42%
      let text-width = size.width - attachment-width - theme.layout.attachment-gap
      let attachment-body = _attachment-layout(attachments, attachment-width, "side", theme)
      grid(
        columns: (text-width, theme.layout.attachment-gap, attachment-width),
        align: (top + left, top, top + center),
        text, [], attachment-body,
      )
    })
  }
}

// 小结只保留顶部横线和项目列表。
#let summary(body) = context {
  let theme = theme-state.get()
  block(
    width: 100%,
    breakable: false,
    stroke: (top: theme.stroke.normal + theme.colors.rule),
    inset: (top: theme.spacing.sm, bottom: theme.spacing.sm),
    above: theme.spacing.md,
    below: theme.spacing.md,
  )[
    #text(weight: 700, fill: theme.colors.rule)[本节小结]
    #v(theme.spacing.xs)
    #body
  ]
}
