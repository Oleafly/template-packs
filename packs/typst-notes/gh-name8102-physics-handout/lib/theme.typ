// physics-handout 的打印主题令牌。
// 黑白打印不依赖色块传达语义：结构、字重、线条和留白负责层级。
#let print-theme = (
  colors: (
    text: black,
    secondary: luma(35%),
    rule: black,
    light-rule: luma(55%),
  ),

  stroke: (
    hairline: 0.4pt,
    normal: 0.65pt,
    strong: 1.4pt,
    // 表格线不直接复用强调线，避免普通表格比正文更醒目。
    table-top: 0.9pt,
    table-header: 0.65pt,
    table-inner: 0.4pt,
    table-grid: 0.5pt,
  ),

  inset: (
    block-x: 8pt,
    block-y: 6pt,
    table-x: 6pt,
    table-y: 4pt,
  ),

  fonts: (
    body: ("Songti SC", "Hiragino Mincho ProN"),
    // 扩展块专用字体；保留跨平台楷体回退。
    kai: ("Kaiti SC", "STKaiti", "LXGW WenKai"),
    sans: ("PingFang SC", "Hiragino Sans GB"),
    // 序号使用同一套 CJK 字体，避免独立 Latin 字体与中文正文产生视觉基线差异。
    marker: ("Heiti SC", "Hiragino Sans GB"),
    latin: ("STIX Two Text", "Times New Roman"),
    math: ("STIX Two Math", "New Computer Modern Math"),
    // 中文数学角标使用与正文一致的衬线字体，避免黑体与数学字体冲突。
    math-cjk: ("Songti SC", "Hiragino Mincho ProN"),
  ),

  text: (
    title-size: 21pt,
    chapter-size: 16.5pt,
    section-size: 13.5pt,
    subsection-size: 11.5pt,
    body-size: 11pt,
    extension-size: 9pt,
    // Typst 的 Latin/CJK 标记基线存在字体度量差异；在主题层统一校正。
    marker-baseline-shift: 0.10em,
    // 小字号小问序号相对正文略向下，避免缩小后视觉上悬浮。
    subquestion-marker-baseline-shift: 0.15em,
    small-size: 9pt,
    caption-size: 9pt,
    table-min-size: 8.5pt,
  ),

  spacing: (xs: 2.5pt, sm: 5pt, md: 7pt, lg: 11pt, xl: 16pt),
  radius: (normal: 0pt),

  tables: (
    default-inset: (x: 6pt, y: 4pt),
    compact-inset: (x: 5pt, y: 3pt),
    record-inset: (x: 5pt, y: 7pt),
  ),

  layout: (
    min-option-column-width: 27mm,
    attachment-gap: 10pt,
    // 统一题图的标称尺寸，并为图文之间保留留白。
    image-display-scale: 0.65,
    image-min-low: 28mm,
    image-min-normal: 38mm,
    image-min-high: 50mm,
    image-height-low: 20mm,
    image-height-normal: 28mm,
    image-height-high: 38mm,
    image-max-width-side: 78mm,
    image-max-width-below: 100mm,
    image-max-height: 65mm,
  ),
)

// 保留 default-theme 作为模板入口默认值；调用方也可以显式传入 print-theme。
#let default-theme = print-theme

#let _marker(body, theme, weight: 600, size: none, baseline: none) = text(
  font: theme.fonts.marker,
  size: if size == none { theme.text.body-size } else { size },
  weight: weight,
  fill: theme.colors.rule,
  baseline: if baseline == none { theme.text.marker-baseline-shift } else { baseline },
)[#body]

#let _theme-value(theme, group, key, default: none) = {
  let values = theme.at(group, default: (:))
  values.at(key, default: default)
}

#let _merge-theme(base, override) = {
  if override == none { return base }
  assert(type(override) == dictionary, message: "physics-handout: theme must be a dictionary")
  let result = base
  for group in (
    "colors",
    "fonts",
    "text",
    "spacing",
    "radius",
    "stroke",
    "inset",
    "tables",
    "layout",
  ) {
    let replacement = override.at(group, default: none)
    if replacement != none {
      assert(
        type(replacement) == dictionary,
        message: "physics-handout: theme." + group + " must be a dictionary",
      )
      let merged = result.at(group, default: (:))
      for (key, value) in replacement {
        merged.insert(key, value)
      }
      result.insert(group, merged)
    }
  }
  result
}
