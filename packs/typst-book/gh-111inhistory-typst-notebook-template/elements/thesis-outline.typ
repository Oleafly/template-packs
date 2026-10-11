#import "/utils/size-utils.typ": 三号, 四号, 小四
#import "@preview/numbly:0.1.0": numbly

/// Build heading numbering for outline pages.
#let thesis-outline-heading-numbering(..nums) = {
  let values = nums.pos()
  if values.len() == 1 {
    return numbly("第{1:一}章")(..values)
  }

  let section-values = values.slice(1)
  section-values.map(str).join(".")
}

/// Build a centered outline title block.
#let thesis-outline-title(title) = block(
  above: 24pt,
  below: 18pt,
  width: 100%,
)[
  #set text(
    size: 三号,
    font: ("SimHei", "Arial"),
    weight: "bold",
  )
  #set par(first-line-indent: 0pt, spacing: 0pt)
  #align(center)[#title]
]

/// Build a single line in outline-like pages.
#let thesis-outline-entry(label, page, level: 1, bold: false) = context {
  let size = if level <= 2 { 四号 } else { 小四 }
  let font = ("SimSun", "Times New Roman")
  let char-width = measure(text(size: size, font: font)[中]).width
  let indent = if level <= 2 { 0pt } else { (level - 2) * char-width }

  pad(left: indent)[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 0.25em,
      align: (left + top, left + horizon, right + top),
      [
        #set text(
          size: size,
          font: font,
          weight: if bold { "bold" } else { "regular" },
        )
        #set par(first-line-indent: 0pt, spacing: 0pt)
        #label
      ],
      box(width: 100%)[#repeat([.], gap: 0.15em)],
      [
        #set text(
          size: size,
          font: font,
        )
        #set par(first-line-indent: 0pt, spacing: 0pt)
        #page
      ],
    )
  ]
}

/// Render the thesis outline page for headings.
#let thesis-outline(title: [目录], max-level: 4) = context {
  let entries = query(heading.where(outlined: true))

  thesis-outline-title(title)
  for entry in entries {
    if entry.level > max-level {
      continue
    }

    let loc = entry.location()
    let numbering = thesis-outline-heading-numbering(..counter(heading).at(loc))
    let label = [#numbering #h(1em) #entry.body]
    let page = str(counter(page).at(loc).first())
    let bold = entry.level == 1

    thesis-outline-entry(
      label,
      page,
      level: entry.level,
      bold: bold,
    )
  }
}

/// Render the outline page for image figures.
#let thesis-figure-outline(title: [图目录]) = context {
  let entries = query(figure.where(kind: "image"))

  thesis-outline-title(title)
  for entry in entries {
    if not entry.outlined {
      continue
    }

    let loc = entry.location()
    let chapter = counter(heading).at(loc).first()
    let index = counter(figure.where(kind: "image")).at(loc).first()
    let page = str(counter(page).at(loc).first())
    let label = [
      图 #numbering("1.1", chapter, index) #h(1em) #entry.caption.body
    ]

    thesis-outline-entry(label, page)
  }
}

/// Render the outline page for tables.
#let thesis-table-outline(title: [表目录]) = context {
  let entries = query(figure.where(kind: "table"))

  thesis-outline-title(title)
  for entry in entries {
    if not entry.outlined {
      continue
    }

    let loc = entry.location()
    let chapter = counter(heading).at(loc).first()
    let index = counter(figure.where(kind: "table")).at(loc).first()
    let page = str(counter(page).at(loc).first())
    let label = [
      表 #numbering("1.1", chapter, index) #h(1em) #entry.caption.body
    ]

    thesis-outline-entry(label, page)
  }
}
