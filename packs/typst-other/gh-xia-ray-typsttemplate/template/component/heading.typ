#let themed_heading(
  theme,
  body,
  numbering: "1.1",
  width: 100%,
  stroke: (bottom: 1pt),
  inset: it => (bottom: 7pt),
  outset: it => (bottom: 2pt),
  align-position: left,
  font: auto,
  weight: auto,
  style: auto,
  size: auto,
) = {
  set heading(numbering: numbering)
  show heading: it => {
    let heading_font = if font == auto { theme.type.accent.font } else { font }
    let heading_weight = if weight == auto { theme.type.accent.weight } else { weight }
    let heading_style = if style == auto { theme.type.accent.style } else { style }
    let heading_size = if size == auto { theme.sizes.heading } else { size }
    let heading_number_size = if it.level == 1 {
      heading_size * 2
    } else {
      heading_size * 1.5
    }
    let heading_body_offset = if it.level == 1 {
      0pt
    } else {
      0.2em
    }
    let heading_number = if it.numbering == none {
      []
    } else {
      text(
        counter(heading).display(it.numbering),
        size: heading_number_size,
        font: theme.type.accent.number.font,
        weight: theme.type.accent.number.weight,
        style: theme.type.accent.number.style,
      )
    }
    let heading_body = text(
      it.body,
      size: heading_size,
      font: heading_font,
      weight: heading_weight,
      style: heading_style,
    )
    let content = grid(
      columns: (auto, 1fr),
      rows: (auto, 0.3em),
      gutter: 0.35em,
      grid.cell(
        rowspan: 2,
        align: right + horizon,
        heading_number,
      ),
      grid.cell(
        align: align-position + bottom,
        move(dy: heading_body_offset, heading_body),
      ),
      grid.cell(
        move(
          dy: heading_body_offset,
          block(
            width: 100%,
            stroke: (top: stroke.bottom),
            [],
          ),
        ),
      ),
    )

    block(
      width: width,
      inset: inset(it),
      outset: outset(it),
      breakable: false,
      align(align-position, content),
    )
  }
  body
}
