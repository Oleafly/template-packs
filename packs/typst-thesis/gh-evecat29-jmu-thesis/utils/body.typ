#let apply_style(doc, config) = {
  // 设置正文字体
  set text(
    size: config.at("size", default: 12pt),
    weight: config.at("weight", default: "regular"),
  )
  let conf_leading = config.at("leading", default: 0.65em)
  // 段落
  set par(
    leading: conf_leading, // 行间距
    spacing: conf_leading, // 段间距
    justify: config.at("justify", default: true), // 两端对齐
  )
  set block(spacing: conf_leading)
  doc
}