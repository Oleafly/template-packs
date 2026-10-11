#let notebook-frame-style(title, tags, body, supplement, number, accent-color) = {
  let has-title = title not in (none, [], "")
  let has-number = number not in (none, [], "")

  let title-cell = {
    set par(first-line-indent: 0pt)
    set text(
      font: ("Arial", "HarmonyOS Sans SC"),
      size: 11pt,
      weight: "bold",
      fill: luma(18%),
    )

    if has-number {
      supplement
      h(0.35em)
      number
    } else {
      supplement
    }
    if has-title {
      h(0.8em)
      title
    }
  }

  let tags-cell = {
    set par(first-line-indent: 0pt)
    set text(
      font: ("Arial", "HarmonyOS Sans SC"),
      size: 11pt,
      weight: "medium",
      fill: luma(42%),
    )

    if tags.len() > 0 {
      tags.join([、])
    } else {
      []
    }
  }

  let body-cell = {
    set par(
      first-line-indent: 0pt,
      justify: false,
    )
    align(left, body)
  }

  let title-fill = accent-color.lighten(70%)
  let body-fill = accent-color.lighten(92%)
  let border-stroke = 0.75pt + accent-color.darken(10%)

  grid(
    inset: 0pt,
    stroke: border-stroke,
    fill: body-fill,
    columns: (1fr, auto),
    rows: (auto, auto),
    gutter: 0pt,
    grid.header(
      repeat: true,
      grid.cell(
        fill: title-fill,
        stroke: (right: none),
        inset: (left: 0.85em, right: 0.5em, y: 0.38em),
        align: left + horizon,
        title-cell,
      ),
      grid.cell(
        fill: title-fill,
        stroke: (left: none),
        inset: (left: 0.5em, right: 0.85em, y: 0.38em),
        align: right + horizon,
        tags-cell,
      ),
    ),
    grid.cell(
      colspan: 2,
      fill: body-fill,
      inset: (left: 0.75em, right: 0.5em, y: 0.5em),
      align: left,
      breakable: true,
      body-cell,
    ),
  )
}
