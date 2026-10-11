#import "state.typ": theme-state
#import "theme.typ": default-theme

#let _align-content = align

#let _detail-defaults(theme, detail) = {
  assert(
    detail in ("low", "normal", "high"),
    message: "physics-handout: attachment-group: detail must be low, normal, or high; found "
      + repr(detail),
  )
  let scale = theme.layout.at("image-display-scale", default: 1.0)
  if detail == "low" {
    (width: theme.layout.image-min-low * scale, height: theme.layout.image-height-low * scale * 0.9)
  } else if detail == "high" {
    (
      width: theme.layout.image-min-high * scale,
      height: theme.layout.image-height-high * scale * 0.9,
    )
  } else {
    (
      width: theme.layout.image-min-normal * scale,
      height: theme.layout.image-height-normal * scale * 0.9,
    )
  }
}

#let _normalize-attachment(item, theme, index) = {
  let descriptor = if type(item) == content {
    (kind: "image", body: item, label: none, caption: none, detail: "normal")
  } else {
    assert(
      type(item) == dictionary,
      message: "physics-handout: attachment-group: attachment "
        + str(index + 1)
        + " must be a dictionary",
    )
    item
  }
  let kind = descriptor.at("kind", default: none)
  assert(
    kind in ("image", "table"),
    message: "physics-handout: attachment-group: attachment "
      + str(index + 1)
      + ".kind must be image or table",
  )
  let body = descriptor.at("body", default: none)
  assert(
    type(body) == content,
    message: "physics-handout: attachment-group: attachment " + str(index + 1) + " is missing body",
  )
  let detail = descriptor.at("detail", default: "normal")
  let defaults = _detail-defaults(theme, detail)
  let min-width = descriptor.at("min-width", default: defaults.width)
  let min-height = descriptor.at("min-height", default: defaults.height)
  if min-width == auto { min-width = 0pt }
  if min-height == auto { min-height = 0pt }
  assert(
    min-width >= 0pt,
    message: "physics-handout: attachment-group: attachment "
      + str(index + 1)
      + " min-width must not be negative",
  )
  assert(
    min-height == auto or min-height >= 0pt,
    message: "physics-handout: attachment-group: attachment "
      + str(index + 1)
      + " min-height must not be negative",
  )
  if kind == "image" {
    assert(
      body.func() == image,
      message: "physics-handout: attachment-group: image attachment "
        + str(index + 1)
        + " body must be image content",
    )
  }
  if kind == "table" {
    let min-font-size = descriptor.at("min-font-size", default: theme.text.table-min-size)
    assert(
      min-font-size >= theme.text.table-min-size,
      message: "physics-handout: attachment-group: table "
        + str(index + 1)
        + " min-font-size is below the theme minimum",
    )
  }
  (
    kind: kind,
    body: body,
    label: descriptor.at("label", default: none),
    caption: descriptor.at("caption", default: none),
    detail: detail,
    min-width: min-width,
    min-height: min-height,
    min-font-size: descriptor.at("min-font-size", default: theme.text.table-min-size),
  )
}

#let _normalize-attachments(items, theme) = {
  assert(
    type(items) == array,
    message: "physics-handout: attachment-group: attachments must be an array",
  )
  let normalized = ()
  for (index, item) in items.enumerate() {
    normalized.push(_normalize-attachment(item, theme, index))
  }
  normalized
}

#let _image-ratio(attachment) = {
  let size = measure(attachment.body)
  assert(
    size.width > 0pt and size.height > 0pt,
    message: "physics-handout: attachment-group: image has no measurable size",
  )
  size.width / size.height
}

#let _caption-content(attachment, theme) = {
  let result = ()
  if attachment.label != none { result.push(attachment.label) }
  if attachment.caption != none {
    if result.len() > 0 { result.push([：]) }
    result.push(attachment.caption)
  }
  if result.len() == 0 { [] } else {
    _align-content(center, text(
      size: theme.text.caption-size,
      fill: theme.colors.secondary,
    )[#result.join()])
  }
}

#let _image-size(
  attachment,
  cell-width,
  theme,
  max-width: none,
  max-height: none,
) = {
  let ratio = _image-ratio(attachment)
  let scale = theme.layout.at("image-display-scale", default: 1.0)
  let width-limit = if max-width == none { cell-width } else {
    calc.min(cell-width, max-width * scale)
  }
  let width = width-limit
  let height = width / ratio
  let height-limit = if max-height == none {
    theme.layout.image-max-height * scale
  } else {
    calc.min(theme.layout.image-max-height * scale, max-height)
  }
  if height > height-limit {
    height = height-limit
    width = height * ratio
  }
  (
    width: width,
    height: height,
    valid: width >= attachment.min-width and height >= attachment.min-height,
  )
}

#let _attachment-cell(
  attachment,
  cell-width,
  image-size: none,
  canvas-height: auto,
  theme: none,
) = {
  let body = if attachment.kind == "image" {
    let size = if image-size == none { _image-size(attachment, cell-width, theme) } else {
      image-size
    }
    let canvas = if canvas-height == auto { size.height } else { canvas-height }
    block(breakable: false, width: cell-width)[
      #box(width: cell-width, height: canvas, clip: false)[
        #_align-content(center + horizon)[
          // 用明确尺寸的容器约束图片，避免再次缩放。
          #box(
            width: size.width,
            height: size.height,
            clip: false,
            _align-content(center + horizon, attachment.body),
          )
        ]
      ]
      #v(theme.spacing.xs)
      #_caption-content(attachment, theme)
    ]
  } else {
    block(breakable: false, width: cell-width)[
      #attachment.body
      #v(theme.spacing.xs)
      #_caption-content(attachment, theme)
    ]
  }
  body
}

#let _chunks(count, columns) = {
  let rows = ()
  for start in range(0, count, step: columns) {
    rows.push(range(start, calc.min(start + columns, count)))
  }
  rows
}

#let _gallery-plans(count) = {
  if count == 0 { return () }
  if count == 1 { return (((0,),),) }
  if count == 2 { return (((0, 1),), ((0,), (1,))) }
  if count == 3 { return (((0, 1, 2),), ((0, 1), (2,)), ((0,), (1, 2)), ((0,), (1,), (2,))) }
  if count == 4 { return (((0, 1), (2, 3)), ((0, 1, 2, 3),), ((0,), (1,), (2,), (3,))) }
  if count <= 6 { return (_chunks(count, 3), _chunks(count, 2)) }
  (_chunks(count, 1),)
}

#let _attachment-source(attachment) = {
  if attachment.kind != "image" { return none }
  attachment.body.fields().at("source", default: none)
}

#let _vertical-attachments(
  attachments,
  width,
  theme,
  max-image-width: none,
  max-image-height: none,
  layout-name: "vertical fallback",
) = {
  let bodies = ()
  for (index, attachment) in attachments.enumerate() {
    if attachment.kind == "image" {
      let size = _image-size(
        attachment,
        width,
        theme,
        max-width: max-image-width,
        max-height: max-image-height,
      )
      if not size.valid {
        let source = _attachment-source(attachment)
        let source-detail = if source == none {
          ""
        } else if type(source) == str {
          ", source: " + source
        } else {
          ", source: " + repr(source)
        }
        let height-limit = if max-image-height == none { "none" } else { repr(max-image-height) }
        assert(
          false,
          message: "physics-handout: attachment-group: attachment "
            + str(index + 1)
            + source-detail
            + " cannot meet its minimum readable size in "
            + layout-name
            + "; display size: "
            + repr(size.width)
            + " × "
            + repr(size.height)
            + ", required minimum: "
            + repr(attachment.min-width)
            + " × "
            + repr(attachment.min-height)
            + "; available width: "
            + repr(width)
            + ", max height: "
            + height-limit,
        )
      }
      bodies.push(_attachment-cell(attachment, width, image-size: size, theme: theme))
    } else {
      bodies.push(_attachment-cell(attachment, width, theme: theme))
    }
  }
  block(width: width)[
    #for (index, body) in bodies.enumerate() [
      #if index > 0 [#v(theme.spacing.md)]
      #body
    ]
  ]
}

#let _analyze-plan(
  attachments,
  plan,
  width,
  theme,
  max-image-width: none,
  max-image-height: none,
) = {
  let valid = true
  let rows = ()
  let minimum-scale = 1000.0
  for row in plan {
    let cell-width = (width - (row.len() - 1) * theme.layout.attachment-gap) / row.len()
    if cell-width <= 0pt {
      valid = false
      continue
    }
    let specs = ()
    let row-height = 0pt
    for index in row {
      let attachment = attachments.at(index)
      if attachment.kind == "image" {
        let size = _image-size(
          attachment,
          cell-width,
          theme,
          max-width: max-image-width,
          max-height: max-image-height,
        )
        if not size.valid { valid = false }
        minimum-scale = calc.min(
          minimum-scale,
          if attachment.min-width > 0pt { size.width / attachment.min-width } else { 1000.0 },
          if attachment.min-height > 0pt { size.height / attachment.min-height } else { 1000.0 },
        )
        specs.push((attachment: attachment, size: size, body: none, height: size.height))
        row-height = calc.max(row-height, size.height)
      } else {
        // 表格不做整体缩放；min-width 是它参与当前网格列的可读性硬约束。
        if cell-width < attachment.min-width { valid = false }
        let body = _attachment-cell(attachment, cell-width, theme: theme)
        let height = measure(body, width: cell-width).height
        specs.push((attachment: attachment, size: none, body: body, height: height))
        row-height = calc.max(row-height, height)
      }
    }
    let cells = ()
    for spec in specs {
      if spec.attachment.kind == "image" {
        cells.push(_attachment-cell(
          spec.attachment,
          cell-width,
          image-size: spec.size,
          canvas-height: row-height,
          theme: theme,
        ))
      } else {
        cells.push(spec.body)
      }
    }
    if cells.len() > 0 {
      rows.push(grid(columns: (1fr,) * cells.len(), column-gutter: theme
          .layout
          .attachment-gap, ..cells))
    }
  }
  let body = block(width: width, breakable: false)[
    #grid(columns: (1fr,), row-gutter: theme.spacing.sm, ..rows)
  ]
  (
    valid: valid,
    body: body,
    width: width,
    height: measure(body, width: width).height,
    minimum-scale: minimum-scale,
    columns: plan.map(row => row.len()).fold(1, (a, b) => calc.max(a, b)),
  )
}

// 内部布局入口。调用方必须在 layout/context 中使用，以确保 measure 有上下文。
#let _attachment-layout(attachments, width, placement, theme, max-height: none) = {
  let normalized = _normalize-attachments(attachments, theme)
  if normalized.len() == 0 { return [] }
  let max-image-width = if placement == "side" {
    theme.layout.image-max-width-side
  } else {
    theme.layout.image-max-width-below
  }
  // 表格的可读宽度由附件描述符约束；含表格时让候选使用完整可用宽度，
  // 否则 image-max-width-below 会把本来可以并排的图片和小表格一起压窄。
  let gallery-width = if placement == "side" or normalized.any(item => item.kind == "table") {
    width
  } else {
    calc.min(width, max-image-width)
  }

  let candidates = ()
  for plan in _gallery-plans(normalized.len()) {
    let info = _analyze-plan(
      normalized,
      plan,
      gallery-width,
      theme,
      max-image-width: max-image-width,
      max-image-height: max-height,
    )
    if info.valid {
      candidates.push((
        info: info,
        score: info.columns * 12
          + calc.min(info.minimum-scale, 3.0) * 5
          - info.height / 24pt
          + if placement == "side" { 2 } else { 0 },
      ))
    }
  }
  if candidates.len() == 0 {
    return _vertical-attachments(
      normalized,
      gallery-width,
      theme,
      max-image-width: max-image-width,
      max-image-height: max-height,
      layout-name: "vertical fallback after gallery candidates failed",
    )
  }
  let selected = candidates.fold(none, (best, candidate) => {
    if best == none or candidate.score > best.score { candidate } else { best }
  })
  selected.info.body
}

#let attachment-group(
  attachments: (),
  placement: "auto",
  max-width: 100%,
  align: center,
) = context {
  assert(
    placement in ("auto", "side", "below"),
    message: "physics-handout: attachment-group: placement must be auto, side, or below; found "
      + repr(placement),
  )
  let theme = theme-state.get()
  if theme == none { theme = default-theme }
  layout(size => {
    let width = if max-width == auto {
      size.width
    } else if type(max-width) == ratio {
      size.width * max-width
    } else {
      calc.min(size.width, max-width)
    }
    let body = _attachment-layout(attachments, width, placement, theme)
    _align-content(align, body)
  })
}

#let figure-group(..args) = attachment-group(..args)
