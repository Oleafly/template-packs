// 纯视觉层：不读取事实库、JD 或模块，不包含候选人默认内容。
// Header + 有序 sections；教育为特殊三列表头，所有条目共用 entry()/entry-rows()。
// 5pt 是行间附加距离（par.leading / grid.row-gutter），不是基线到基线距离。
#let present(v) = v != none and v != [] and (type(v) != str or v.trim() != "")
#let field(r, k) = r.at(k, default: none)
#let items(r, k) = r.at(k, default: ()).filter(present)
#let row-gap = 5pt

#let has-entry(entry) = (
  present(field(entry, "title")) or present(field(entry, "school"))
  or items(entry, "lines").len() > 0 or items(entry, "bullets").len() > 0
)
#let visible-entries(record) = items(record, "entries").filter(has-entry)
#let has-section(record) = visible-entries(record).len() > 0 or items(record, "skills").len() > 0

#let entry-text(size, body, fill: rgb("#262626"), weight: "regular") = text(
  size: size, fill: fill, weight: weight,
  top-edge: "bounds", bottom-edge: "bounds", body,
)

#let meta-item(item) = {
  set text(fill: rgb("#666666"), weight: "regular",
    top-edge: "bounds", bottom-edge: "bounds")
  show link: it => text(fill: rgb("#666666"), weight: "regular", it)
  [#text(weight: "medium")[#item.label：]#if present(field(item, "url")) {
    link(item.url, item.value)
  } else { item.value }]
}

#let meta-grid(rows) = {
  set par(leading: row-gap, spacing: 0pt)
  grid(
    columns: (105pt, 1fr, 175pt), column-gutter: 1pt, row-gutter: row-gap,
    align: (left + top, left + top, left + top),
    ..rows.map(meta-item),
  )
}

#let three-column-header(start, middle, end) = grid(
  columns: (145pt, 1fr, auto), column-gutter: 10pt,
  align: (left + horizon, left + horizon, right + horizon),
  start, middle, end,
)

#let bullet-square = pad(
  top: 0.14em,
  box(width: 0.46em, height: 0.46em, fill: rgb("#262626")),
)

#let entry-rows(record, entry-size) = {
  let stack = items(record, "stack")
  let stack-rows = if stack.len() > 0 {
    (par(leading: row-gap, spacing: 0pt, justify: true,
      entry-text(entry-size, fill: rgb("#606060"))[
        技术栈：#stack.join(" · ")
      ]),)
  } else { () }
  let line-rows = items(record, "lines").map(value =>
    par(leading: row-gap, spacing: 0pt,
      justify: field(record, "kind") != "education",
      entry-text(entry-size, value)))
  let bullet-rows = items(record, "bullets").map(body => grid(
    columns: (2em, 1fr), column-gutter: 0pt,
    align: (top + left, top + left),
    bullet-square,
    par(justify: true, leading: row-gap, spacing: 0pt,
      entry-text(entry-size, body)),
  ))
  stack-rows + line-rows + bullet-rows
}

#let entry-header(record, display-fonts, entry-size) = {
  set text(font: display-fonts, size: entry-size,
    top-edge: "bounds", bottom-edge: "bounds")
  if field(record, "kind") == "education" {
    three-column-header(
      text(weight: "semibold", record.school),
      text(weight: "medium", record.title),
      text(weight: "bold", record.at("role", default: [])),
    )
  } else if present(field(record, "title")) {
    // 缺少时间或角色仍保留另外两列，不丢失已有角色。
    three-column-header(
      text(fill: rgb("#606060"), record.at("dates", default: [])),
      text(weight: "semibold", record.title),
      text(weight: "medium", record.at("role", default: [])),
    )
  } else { none }
}

// 教育、实习、项目、校园、奖项只有数据不同，不各自维护字号和行距。
#let entry(record, display-fonts, entry-size) = block(
  width: 100%, breakable: false, above: 0pt, below: 0pt,
)[
  #set text(size: entry-size, top-edge: "bounds", bottom-edge: "bounds")
  #set par(leading: row-gap, spacing: 0pt)
  #let header = if present(field(record, "title")) or present(field(record, "school")) {
    entry-header(record, display-fonts, entry-size)
  } else { none }
  #grid(
    columns: (1fr,), row-gutter: row-gap,
    ..if header != none { (header,) } else { () },
    ..entry-rows(record, entry-size),
  )
]

#let skills(rows, entry-size) = block(above: 0pt, below: 0pt, breakable: false)[
  #set text(size: entry-size, top-edge: "bounds", bottom-edge: "bounds")
  #set par(leading: row-gap, spacing: 0pt)
  #grid(
    columns: (53pt, 1fr), column-gutter: 9pt, row-gutter: row-gap,
    ..rows.map(row => (text(weight: "semibold", row.label), row.value)).flatten(),
  )
]

#let section(record, display-fonts, entry-size, section-size, section-gap, entry-gap,
  first: false) = {
  let entries = visible-entries(record)
  let rows = items(record, "skills")
  if entries.len() > 0 or rows.len() > 0 {
    // section-gap 同时控制：节前 / 标题到横线 / 横线到正文。
    block(width: 100%, above: if first { 0pt } else { section-gap },
      below: section-gap, sticky: true, inset: (bottom: section-gap),
      stroke: (bottom: 1.15pt + rgb("#999999")))[
      #text(font: display-fonts, size: section-size, weight: "bold", tracking: 0pt,
        top-edge: "bounds", bottom-edge: "bounds", record.title)
    ]
    if rows.len() > 0 { skills(rows, entry-size) }
    for (i, record) in entries.enumerate() {
      if i > 0 or rows.len() > 0 { v(entry-gap) }
      entry(record, display-fonts, entry-size)
    }
  }
}

#let resume(
  data,
  zh-fonts: ("Noto Sans CJK SC",),
  latin-fonts: ("SF Pro Text", "SF Pro Display", "Inter", "Arial"),
  latin-display-fonts: ("SF Pro Display", "SF Pro Text", "Inter", "Arial"),
  body-size: 10.8pt,
  entry-size: 10.8pt,
  meta-size: 10.8pt,
  section-size: 13pt,
  name-size: 23pt,
  headline-size: 13pt,
  page-margin: (left: 11mm, right: 11mm, top: 8mm, bottom: 8mm),
  photo-width: 27mm,
  photo-height: 32.4mm,
  photo-gutter: 7mm,
  header-shift:4mm,
  section-gap: 5pt,
  entry-gap: 5pt,
  enforce-one-page: true,
) = {
  let fonts = latin-fonts.map(name => (name: name,
    covers: regex("[\u{0000}-\u{024f}]"))) + zh-fonts
  let display-fonts = latin-display-fonts.map(name => (name: name,
    covers: regex("[\u{0000}-\u{024f}]"))) + zh-fonts
  set document(title: data.at("document-title", default: "简历"), author: data.name)
  set page(paper: "a4", margin: page-margin, numbering: none)
  set text(font: fonts, fallback: true, size: body-size, fill: rgb("#262626"),
    lang: "zh", region: "CN", hyphenate: false, ligatures: false, overhang: false, tracking: 0em)
  set par(justify: false, leading: row-gap, spacing: 0pt, linebreaks: "optimized")
  set block(spacing: 0pt)
  show link: it => text(fill: rgb("#454545"), it)

  let has-photo = present(field(data, "photo"))
  let header-text = [
    #text(font: display-fonts, size: name-size, weight: "bold", tracking: 0pt,
      top-edge: "bounds", bottom-edge: "bounds", data.name)
    #if present(field(data, "headline")) {
      block(above: 14pt, below: 0pt,
        text(font: display-fonts, size: headline-size, weight: "bold", tracking: 0pt,
          top-edge: "bounds", bottom-edge: "bounds", data.headline))
    }
    #if items(data, "meta-grid").len() > 0 {
      block(above: row-gap, below: 0pt)[
        #set text(size: meta-size, top-edge: "bounds", bottom-edge: "bounds")
        #meta-grid(items(data, "meta-grid"))
      ]
    }
  ]
  // 自动高度行 = max(左侧实际高度, 照片高度)，短页头与长页头都不会和正文重叠。
  block(width: 100%, above: 0pt, below: 0pt, breakable: false)[
    #move(dy: header-shift)[
      #if has-photo {
        grid(
          columns: (1fr, photo-width),
          column-gutter: photo-gutter,
          align: (left + top, right + top),
          header-text,
          image(data.photo, width: photo-width, height: photo-height, fit: "cover"),
        )
      } else {
        header-text
      }
    ]
  ]
  let sections = items(data, "sections").filter(has-section)
  if sections.len() > 0 { v(section-gap) }
  for (i, record) in sections.enumerate() {
    section(record, display-fonts, entry-size, section-size, section-gap, entry-gap,
      first: i == 0)
  }
  if enforce-one-page {
    context assert(counter(page).final().first() == 1,
      message: "内容超过一页；请按相关性选择模块或精简措辞，不能裁切、自动隐去条目或缩小字号。")
  }
}
