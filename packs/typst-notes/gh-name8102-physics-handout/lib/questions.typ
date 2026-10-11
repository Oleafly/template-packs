#import "state.typ": mode-state, question-series-state, theme-state
#import "theme.typ": _marker
#import "attachments.typ": _attachment-layout, _image-size, _normalize-attachments
#import "solutions.typ": _answer-space, show-answer, solution as render-solution

#let _layout = layout

#let _check-layout(value, component) = {
  assert(
    value in ("auto", "side", "below", "single"),
    message: "physics-handout: "
      + component
      + ": layout must be auto, side, below, or single; found "
      + repr(value),
  )
}

#let _check-points(points, component) = {
  if points != none {
    assert(
      type(points) in (int, float) and points > 0,
      message: "physics-handout: " + component + ": points must be a positive number or none",
    )
  }
}
#let _question-series-config(series) = {
  assert(
    type(series) == str and series.len() > 0,
    message: "physics-handout: question: series must be a non-empty string; found " + repr(series),
  )
  let registry = question-series-state.get()
  let configured = registry.at(series, default: none)
  let config = if configured == none {
    // 未注册的自定义分类默认从 1 开始且不显示前缀。
    (prefix: none, numbering: "1.")
  } else {
    assert(
      type(configured) == dictionary,
      message: "physics-handout: question: series configuration for "
        + repr(series)
        + " must be a dictionary",
    )
    configured
  }
  let prefix = config.at("prefix", default: none)
  let pattern = config.at("numbering", default: "1.")
  assert(
    prefix == none or type(prefix) == content,
    message: "physics-handout: question: series prefix must be content or none; found "
      + repr(prefix),
  )
  assert(
    type(pattern) == str and pattern.len() > 0,
    message: "physics-handout: question: series numbering must be a non-empty pattern string; found "
      + repr(pattern),
  )
  (prefix: prefix, numbering: pattern)
}

#let _question-marker(number, series, theme) = {
  let config = _question-series-config(series)
  let number-body = numbering(config.numbering, number)
  if config.prefix == none {
    number-body
  } else {
    [#config.prefix #h(theme.spacing.xs) #number-body]
  }
}

#let _question-heading(number, series, stem, points, theme) = block(
  sticky: true,
  breakable: false,
  above: theme.spacing.lg,
  below: theme.spacing.lg,
)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: theme.spacing.xs,
    align: (top + left, top + left),
    _marker([#_question-marker(number, series, theme)], theme, weight: 700),
    box(width: 1fr)[
      #stem
      #if points != none [
        #h(theme.spacing.xs)
        #text(size: theme.text.small-size, fill: theme.colors.secondary)[（#points 分）]
      ]
    ],
  )
]

#let _labeled-cell(
  body,
  width,
  theme,
  marker,
  marker-weight: 600,
  marker-size: none,
  marker-baseline: none,
) = block(width: width)[
  #set par(justify: false)
  #show math.equation: set text(size: theme.text.body-size)
  // 分式内部默认使用较小的数学层级；轻微放大以匹配题目正文的视觉字号。
  #show math.frac: set text(size: theme.text.body-size * 1.06)
  #grid(
    columns: (auto, 1fr),
    column-gutter: theme.spacing.xs,
    align: (top + left, top + left),
    _marker(
      marker,
      theme,
      weight: marker-weight,
      size: marker-size,
      baseline: marker-baseline,
    ),
    body,
  )
]

#let _option-cell(body, index, width, theme) = _labeled-cell(
  body,
  width,
  theme,
  numbering("A.", index + 1),
)

#let _subquestion-cell(body, index, width, theme) = _labeled-cell(
  body,
  width,
  theme,
  numbering("(1)", index + 1),
  marker-weight: 700,
  marker-size: theme.text.small-size,
  marker-baseline: theme.text.subquestion-marker-baseline-shift,
)

#let _span-width(span, width, gutter) = {
  let unit = (width - 3 * gutter) / 4
  span * unit + (span - 1) * gutter
}

#let _options-plan-grid(
  options,
  spans,
  width,
  theme,
  cell: _option-cell,
  row-gutter: none,
  breakable: false,
) = {
  let actual-row-gutter = if row-gutter == none { theme.spacing.md } else { row-gutter }
  let indent = theme.text.body-size * 1.2
  let content-width = width - indent
  let cells = ()
  for (index, option) in options.enumerate() {
    let span = spans.at(index)
    let cell-width = _span-width(span, content-width, theme.spacing.lg)
    cells.push(grid.cell(
      colspan: span,
      cell(option, index, cell-width, theme),
    ))
  }
  block(width: width, breakable: breakable)[
    #h(indent)
    #box(width: content-width)[
      #grid(
        columns: (1fr,) * 4,
        column-gutter: theme.spacing.lg,
        row-gutter: actual-row-gutter,
        align: top + left,
        ..cells,
      )
    ]
  ]
}

#let _repeat-span(count, span) = {
  let result = ()
  for _ in range(count) { result.push(span) }
  result
}

#let _option-plans(count) = {
  // 只保留规则方阵：四列、两列、单列。混合跨度会破坏行列对齐。
  (1, 2, 4).map(span => _repeat-span(count, span))
}

#let _analyze-option-plan(
  options,
  spans,
  width,
  theme,
  cell: _option-cell,
  reference-width: none,
  row-gutter: none,
) = {
  let actual-row-gutter = if row-gutter == none { theme.spacing.md } else { row-gutter }
  let gutter = theme.spacing.lg
  let indent = theme.text.body-size * 1.2
  let content-width = width - indent
  let reference = if reference-width == none { width } else { reference-width }
  let reference-content = reference - indent
  let half-reference = reference / 2 - indent
  let full-heights = ()
  let half-heights = ()
  for (index, option) in options.enumerate() {
    full-heights.push(
      measure(cell(option, index, reference-content, theme), width: reference-content).height,
    )
    half-heights.push(
      measure(cell(option, index, half-reference, theme), width: half-reference).height,
    )
  }

  let valid = true
  let severe-wraps = 0
  let avoidable-wraps = 0
  let long-wraps = 0
  let wrap-cost = 0.0
  let width-waste = 0.0
  let row-slack = 0.0
  let rows = ()
  let row = ()
  let used = 0

  for (index, option) in options.enumerate() {
    let span = spans.at(index)
    if used + span > 4 {
      rows.push(row)
      row = ()
      used = 0
    }
    let cell-width = _span-width(span, content-width, gutter)
    if span == 1 and cell-width < theme.layout.min-option-column-width { valid = false }
    let height = measure(cell(option, index, cell-width, theme), width: cell-width).height
    let ratio = height / full-heights.at(index)
    let half-ratio = half-heights.at(index) / full-heights.at(index)
    if ratio > 2.8 { severe-wraps += 1 }
    if ratio > 1.25 {
      if half-ratio > 1.25 {
        long-wraps += 1
        wrap-cost += (ratio - 1.0) * 0.35
      } else {
        avoidable-wraps += 1
        wrap-cost += ratio - 1.0
      }
    }
    if span == 1 and ratio > 2.8 { valid = false }
    if span == 2 and ratio > 2.4 { valid = false }

    let effective-span = span
    for probe-span in range(1, span + 1) {
      let probe-width = _span-width(probe-span, content-width, gutter)
      let probe-height = measure(cell(option, index, probe-width, theme), width: probe-width).height
      if probe-height <= height * 1.05 {
        effective-span = probe-span
        break
      }
    }
    let effective-width = _span-width(effective-span, content-width, gutter)
    width-waste += (cell-width - effective-width) / content-width
    row.push((height: height, width: cell-width))
    used += span
    if used == 4 {
      rows.push(row)
      row = ()
      used = 0
    }
  }
  if row.len() > 0 { rows.push(row) }
  // 能在半版宽内放下的选项不允许被挤到换行；真正长选项最多容忍两个。
  if avoidable-wraps > 0 or long-wraps > 2 { valid = false }

  let total-height = 0pt
  for (row-index, specs) in rows.enumerate() {
    let row-height = specs.map(spec => spec.height).fold(0pt, calc.max)
    total-height += row-height
    if row-index > 0 { total-height += actual-row-gutter }
    for spec in specs {
      if row-height > 0pt {
        row-slack += (row-height - spec.height) / row-height * spec.width / content-width
      }
    }
  }
  let body = _options-plan-grid(
    options,
    spans,
    width,
    theme,
    cell: cell,
    row-gutter: actual-row-gutter,
  )
  let measured-height = measure(body, width: width).height
  let blank-ratio = (width-waste + row-slack) / calc.max(1, options.len())
  (
    spans: spans,
    width: width,
    height: measured-height,
    row-count: rows.len(),
    row-gutter: actual-row-gutter,
    body: body,
    valid: valid,
    severe-wraps: severe-wraps,
    avoidable-wraps: avoidable-wraps,
    long-wraps: long-wraps,
    wrap-cost: wrap-cost,
    blank-ratio: blank-ratio,
    cost: severe-wraps * 10000 + wrap-cost * 900 + blank-ratio * 1000 + measured-height / 1pt * 0.5,
  )
}

#let _option-layouts(
  options,
  width,
  theme,
  cell: _option-cell,
  reference-width: none,
  row-gutter: none,
) = {
  let layouts = ()
  for spans in _option-plans(options.len()) {
    let info = _analyze-option-plan(
      options,
      spans,
      width,
      theme,
      cell: cell,
      reference-width: reference-width,
      row-gutter: row-gutter,
    )
    if info.valid { layouts.push(info) }
  }
  layouts
}

#let _question-number(series) = {
  _question-series-config(series)
  let question-counter = counter("physics-handout-question-" + series)
  let number = question-counter.get().first() + 1
  (number: number, advance: question-counter.step())
}

#let _best(candidates) = candidates.fold(none, (best, candidate) => {
  if best == none or candidate.cost < best.cost { candidate } else { best }
})

#let _subquestion-line-height(width, theme) = {
  measure(
    _subquestion-cell([中], 0, width, theme),
    width: width,
  ).height
}

#let _subquestion-info(subquestions, width, theme) = {
  if subquestions.len() == 0 {
    return (body: [], max-lines: 0.0, too-long: false)
  }
  // 解答题小问固定单列；七行阈值只用于判断是否需要把附件移到下方。
  let indent = theme.text.body-size * 1.2
  let content-width = width - indent
  let line-height = _subquestion-line-height(content-width, theme)
  let max-lines = 0.0
  for (index, item) in subquestions.enumerate() {
    let height = measure(
      _subquestion-cell(item, index, content-width, theme),
      width: content-width,
    ).height
    max-lines = calc.max(max-lines, height / line-height)
  }
  let body = _options-plan-grid(
    subquestions,
    _repeat-span(subquestions.len(), 4),
    width,
    theme,
    cell: _subquestion-cell,
    breakable: true,
  )
  (
    body: body,
    max-lines: max-lines,
    too-long: max-lines > 7,
  )
}

#let _subquestion-layout(subquestions, width, theme) = {
  _subquestion-info(
    subquestions,
    width,
    theme,
  ).body
}

#let _side-attachments-readable(attachments, width, theme) = {
  for attachment in attachments {
    if attachment.kind == "table" {
      if width < attachment.min-width { return false }
    } else {
      let size = _image-size(
        attachment,
        width,
        theme,
        max-width: theme.layout.image-max-width-side,
      )
      if not size.valid { return false }
    }
  }
  true
}

#let _calculation-layout(subquestions, attachments, width, theme) = {
  let normalized = _normalize-attachments(attachments, theme)
  if normalized.len() == 0 {
    return _subquestion-layout(subquestions, width, theme)
  }

  // 解答题优先把子问题放在左侧、附件放在右侧；不因两侧高度不同而重新拉伸行距。
  let attachment-width = width * 36%
  let text-width = width - attachment-width - theme.layout.attachment-gap
  let side-info = _subquestion-info(subquestions, text-width, theme)
  if (
    subquestions.len() > 0
      and not side-info.too-long
      and _side-attachments-readable(
        normalized,
        attachment-width,
        theme,
      )
  ) {
    let attachment-body = _attachment-layout(
      normalized,
      attachment-width,
      "side",
      theme,
    )
    return grid(
      columns: (text-width, theme.layout.attachment-gap, attachment-width),
      align: (top + left, top, top + right),
      side-info.body, [], attachment-body,
    )
  }

  // 纵向回退仍将附件压到右侧，避免图片占满整行，给题目解答和答题空间留下空间。
  let attachment-body = _attachment-layout(normalized, width, "below", theme)
  [
    #align(right, attachment-body)
    #if subquestions.len() > 0 [#v(theme.spacing.md) #_subquestion-layout(
        subquestions,
        width,
        theme,
      )]
  ]
}

#let _choice-layout(options, attachments, preference, width, theme) = {
  let normalized = _normalize-attachments(attachments, theme)
  let single-spans = _repeat-span(options.len(), 4)
  if preference == "single" {
    let option = _analyze-option-plan(options, single-spans, width, theme)
    let attachment-body = if normalized.len() == 0 {
      []
    } else {
      align(center, _attachment-layout(attachments, width, "below", theme))
    }
    return [
      #option.body
      #if normalized.len() > 0 [#v(theme.spacing.md) #attachment-body]
    ]
  }

  let candidates = ()
  let only-side = preference == "side"
  let only-below = preference == "below"

  if normalized.len() == 0 {
    for info in _option-layouts(options, width, theme) {
      candidates.push((placement: "options", options: info, cost: info.cost))
    }
  } else {
    let has-table = normalized.any(item => item.kind == "table")
    if not only-side {
      let attachment-body = align(center, _attachment-layout(attachments, width, "below", theme))
      let attachment-height = measure(attachment-body, width: width).height
      for info in _option-layouts(options, width, theme) {
        let total-height = info.height + theme.spacing.md + attachment-height
        candidates.push((
          placement: "below",
          options: info,
          attachments: attachment-body,
          cost: info.cost + total-height / 1pt * 0.7 + if only-below { -80 } else { 0 },
        ))
      }
    }

    if not has-table and normalized.len() <= 4 and not only-below {
      // 离散搜索附件宽度；每个宽度都重新测量全部规则与混合选项候选。
      for fraction in (24%, 30%, 36%, 42%) {
        let attachment-width = width * fraction
        let option-width = width - attachment-width - theme.layout.attachment-gap
        for info in _option-layouts(
          options,
          option-width,
          theme,
          reference-width: width,
        ) {
          // 并排图片的高度上限不能只由选项区高度决定：选项间距变小时，
          // 窄高图仍须达到附件声明的最小可读高度，否则会误判为只能放在下方。
          let required-image-height = normalized.map(item => item.min-height).fold(0pt, calc.max)
          let side-image-height = calc.max(
            required-image-height,
            calc.max(info.height + theme.spacing.xl, info.height * 2.4),
          )
          let readable = true
          let portrait = false
          for attachment in normalized {
            let size = _image-size(
              attachment,
              attachment-width,
              theme,
              max-width: theme.layout.image-max-width-side,
              max-height: side-image-height,
            )
            if not size.valid { readable = false }
            if size.height > size.width { portrait = true }
          }
          if not readable { continue }
          let attachment-body = _attachment-layout(
            attachments,
            attachment-width,
            "side",
            theme,
            max-height: side-image-height,
          )
          let attachment-height = measure(attachment-body, width: attachment-width).height

          // 图片略高时，将高度差均匀分配给选项行；上限避免选项被过度拉散。
          if info.row-count > 1 and attachment-height > info.height {
            let balanced-gutter = calc.min(
              theme.spacing.xl,
              info.row-gutter + (attachment-height - info.height) / (info.row-count - 1),
            )
            if balanced-gutter > info.row-gutter {
              info = _analyze-option-plan(
                options,
                info.spans,
                option-width,
                theme,
                reference-width: width,
                row-gutter: balanced-gutter,
              )
              side-image-height = calc.max(
                required-image-height,
                calc.max(info.height + theme.spacing.xl, info.height * 2.4),
              )
              attachment-body = _attachment-layout(
                attachments,
                attachment-width,
                "side",
                theme,
                max-height: side-image-height,
              )
              attachment-height = measure(attachment-body, width: attachment-width).height
            }
          }

          let mismatch = calc.abs(info.height - attachment-height)
          let side-slack = mismatch / calc.max(info.height, attachment-height)
          candidates.push((
            placement: "side",
            options: info,
            attachments: attachment-body,
            attachment-width: attachment-width,
            cost: info.cost
              + side-slack * 220
              + calc.max(info.height, attachment-height) / 1pt * 0.5
              // 可读的并排候选优先；窄高图尤其不应独占整行。
              - 260
              - if portrait { 320 } else { 0 },
          ))
        }
      }
    }
  }

  if candidates.len() == 0 {
    let option = _analyze-option-plan(options, single-spans, width, theme)
    let attachment-body = if normalized.len() == 0 {
      []
    } else {
      align(center, _attachment-layout(attachments, width, "below", theme))
    }
    return [
      #option.body
      #if normalized.len() > 0 [#v(theme.spacing.md) #attachment-body]
    ]
  }

  let selectable = candidates
  if not only-below {
    let side-candidates = candidates.filter(candidate => candidate.placement == "side")
    if side-candidates.len() > 0 { selectable = side-candidates }
  }
  let selected = _best(selectable)
  if selected.placement == "options" {
    selected.options.body
  } else if selected.placement == "below" {
    [
      #selected.options.body
      #v(theme.spacing.md)
      #selected.attachments
    ]
  } else {
    grid(
      columns: (selected.options.width, theme.layout.attachment-gap, selected.attachment-width),
      align: (top + left, top, top + center),
      selected.options.body, [], selected.attachments,
    )
  }
}

#let choice-question(
  stem: none,
  options: (),
  attachments: (),
  answer: none,
  analysis: none,
  points: none,
  layout: "auto",
  series: "exercise",
) = context {
  _check-layout(layout, "choice-question")
  _check-points(points, "choice-question")
  assert(
    type(options) == array and options.len() > 0,
    message: "physics-handout: choice-question: options must contain at least one option",
  )
  assert(
    type(attachments) == array,
    message: "physics-handout: choice-question: attachments must be an array",
  )
  let theme = theme-state.get()
  let mode = mode-state.get()
  let question = _question-number(series)
  let number = question.number
  let heading = _question-heading(number, series, stem, points, theme)
  let content = _layout(size => _choice-layout(options, attachments, layout, size.width, theme))
  let question-body = block(breakable: false)[
    #heading
    #content
  ]
  [
    #question.advance
    #question-body
    #show-answer([
      #text(font: theme.fonts.sans, weight: 700, fill: theme.colors.rule)[答案：]
      #if answer == none [未提供] else [#answer]
    ])
    #if analysis != none [#render-solution(analysis)]
  ]
}

#let calculation-question(
  stem: none,
  attachments: (),
  subquestions: (),
  answer-space: auto,
  solution: none,
  points: none,
  series: "exercise",
) = context {
  _check-points(points, "calculation-question")
  assert(
    type(attachments) == array,
    message: "physics-handout: calculation-question: attachments must be an array",
  )
  assert(
    type(subquestions) == array,
    message: "physics-handout: calculation-question: subquestions must be an array",
  )
  let theme = theme-state.get()
  let mode = mode-state.get()
  let question = _question-number(series)
  let number = question.number
  let heading = _question-heading(number, series, stem, points, theme)
  let question-content = _layout(size => _calculation-layout(
    subquestions,
    attachments,
    size.width,
    theme,
  ))
  [
    #question.advance
    #heading
    #question-content
    #if mode == "student" [#_answer-space(answer-space, subquestions.len(), theme)]
    #if solution != none [#render-solution(solution)]
  ]
}

#let short-answer-question(
  stem: none,
  answer-space: auto,
  answer: none,
  solution: none,
  points: none,
  series: "exercise",
) = context {
  _check-points(points, "short-answer-question")
  let theme = theme-state.get()
  let mode = mode-state.get()
  let question = _question-number(series)
  let number = question.number
  let heading = _question-heading(number, series, stem, points, theme)
  [
    #question.advance
    #heading
    #if mode == "student" [#_answer-space(answer-space, 1, theme)]
    #show-answer([
      #text(font: theme.fonts.sans, weight: 700, fill: theme.colors.rule)[答案：]
      #if answer == none [未提供] else [#answer]
    ])
    #if solution != none [#render-solution(solution)]
  ]
}

// 例题使用统一的 question 组件，并默认进入 example 编号序列。
#let question(
  title: none,
  problem: none,
  analysis: none,
  solution: none,
  conclusion: none,
  points: none,
  series: "example",
) = context {
  _check-points(points, "question")
  let theme = theme-state.get()
  let question-number = _question-number(series)
  let number = question-number.number
  let heading = _question-heading(number, series, title, points, theme)
  let question-body = block(
    breakable: false,
    above: theme.spacing.md,
    below: theme.spacing.md,
  )[
    #heading
    #text(weight: 700)[问题：]
    #problem
    #if analysis != none [
      #v(theme.spacing.xs)
      #text(weight: 700)[分析：]
      #analysis
    ]
    #if solution != none [
      #v(theme.spacing.xs)
      #text(weight: 700)[解：]
      #solution
    ]
    #if conclusion != none [
      #v(theme.spacing.xs)
      #text(weight: 700)[答：]
      #conclusion
    ]
  ]
  [
    #question-number.advance
    #question-body
  ]
}
