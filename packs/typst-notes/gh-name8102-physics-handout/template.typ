#import "lib/theme.typ": _merge-theme, default-theme, print-theme
#import "lib/state.typ": (
  metadata-state as _metadata-state, mode-state as _mode-state,
  question-series-state as _question-series-state, theme-state as _theme-state,
)
#import "lib/math.typ": zh-sub
#import "lib/structure.typ": _render-heading, chapter, handout-title, section, subsection
#import "lib/knowledge.typ": concept-content, extension-block, knowledge, summary, warning-block
#import "lib/attachments.typ": attachment-group, figure-group
#import "lib/tables.typ": comparison-table, data-table, record-table, three-line-table
#import "lib/questions.typ": calculation-question, choice-question, question, short-answer-question
#import "lib/solutions.typ": show-answer, solution
#import "@preview/unify:0.8.1": qty as _unify-qty

// 全模板统一的数量格式；调用处只需使用 qty(value, unit)。
#let qty-format = (
  space: "#h(0.166667em)",
  num-unit-space: "#h(0.166667em)",
  multiplier: "dot",
  thousandsep: "#h(0.166667em)",
  per: "fraction-short",
)

#let qty(
  value,
  unit,
  rawunit: false,
  space: qty-format.space,
  num-unit-space: qty-format.num-unit-space,
  multiplier: qty-format.multiplier,
  thousandsep: qty-format.thousandsep,
  per: qty-format.per,
) = _unify-qty(
  value,
  unit,
  rawunit: rawunit,
  space: space,
  num-unit-space: num-unit-space,
  multiplier: multiplier,
  thousandsep: thousandsep,
  per: per,
)

#let _default-question-series = (
  example: (prefix: [例题], numbering: "1."),
  exercise: (prefix: none, numbering: "1."),
)

#let _merge-question-series(base, override) = {
  let result = base
  for (series, config) in override {
    assert(
      type(config) == dictionary,
      message: "physics-handout: handout: question-series entry "
        + repr(series)
        + " must be a dictionary",
    )
    let merged = result.at(series, default: (:))
    for (key, value) in config { merged.insert(key, value) }
    result.insert(series, merged)
  }
  result
}

#let _default-header = context {
  let metadata = _metadata-state.get()
  let theme = _theme-state.get()
  let title = metadata.at("title", default: none)
  if title != none {
    align(right, text(size: 9pt, fill: theme.colors.secondary)[#title])
  }
}

#let _default-footer = context {
  let theme = _theme-state.get()
  align(center, text(size: 9pt, fill: theme.colors.secondary)[#counter(page).display("1")])
}

// 唯一公开入口。所有文档级模式和主题配置在这里一次性确定。
#let handout(
  mode: "student",
  metadata: (:),
  paper: "a4",
  flipped: false,
  margin: auto,
  header: auto,
  footer: auto,
  page-numbering: "1",
  theme: default-theme,
  question-series: _default-question-series,
  doc,
) = {
  assert(
    mode in ("student", "teacher"),
    message: "physics-handout: handout: mode must be student or teacher; found " + repr(mode),
  )
  assert(
    type(metadata) == dictionary,
    message: "physics-handout: handout: metadata must be a dictionary",
  )
  assert(
    type(question-series) == dictionary,
    message: "physics-handout: handout: question-series must be a dictionary",
  )

  let resolved-theme = _merge-theme(default-theme, theme)
  let page-margin = if margin == auto {
    (left: 18mm, right: 18mm, top: 16mm, bottom: 16mm)
  } else { margin }
  let header-body = if header == auto { _default-header } else { header }
  let footer-body = if footer == auto { _default-footer } else { footer }
  let fonts = resolved-theme.fonts
  let colors = resolved-theme.colors
  let sizes = resolved-theme.text

  [
    #_mode-state.update(mode)
    #_theme-state.update(resolved-theme)
    #_metadata-state.update(metadata)
    #_question-series-state.update(_merge-question-series(
      _default-question-series,
      question-series,
    ))
    #set page(
      paper: paper,
      flipped: flipped,
      margin: page-margin,
      header: header-body,
      footer: footer-body,
      numbering: page-numbering,
    )
    #set text(font: fonts.body, size: sizes.body-size, fill: colors.text)
    #set par(leading: 0.58em, spacing: 0.58em, justify: true)
    #set heading(numbering: none)
    #show heading: _render-heading
    #show math.equation: set text(font: fonts.math, weight: "regular")
    #doc
  ]
}
