#let title_parts(title) = {
  let clusters = title.text.clusters()
  (
    first: clusters.at(0, default: ""),
    rest: clusters.slice(1).join(),
  )
}

#let themed_title_outline(
  theme,
  outline-size: auto,
  outline-weight: auto,
  outline-style: auto,
) = {
  set text(
    size: if outline-size == auto { theme.sizes.regular } else { outline-size },
    font: theme.type.regular.font,
    weight: if outline-weight == auto { theme.type.regular.weight } else { outline-weight },
    style: if outline-style == auto { theme.type.regular.style } else { outline-style },
  )
  set outline.entry(fill: box(
    inset: (x: 1em),
    repeat(".", gap: 5pt),
  ))
  outline(
    title: none,
    indent: 0.8em,
  )
  pagebreak()
}

#let themed_title_body(
  theme,
  body,
  outline-size: auto,
  outline-weight: auto,
  outline-style: auto,
) = {
  for child in body.children {
    if repr(child.func()) == "styled" {
      child.func()(
        themed_title_body(
          theme,
          child.child,
          outline-size: outline-size,
          outline-weight: outline-weight,
          outline-style: outline-style,
        ),
        child.styles,
      )
    } else {
      child
      if child.func() == title {
        themed_title_outline(
          theme,
          outline-size: outline-size,
          outline-weight: outline-weight,
          outline-style: outline-style,
        )
      }
    }
  }
}

#let themed_title_text(
  theme,
  title,
  size: auto,
  weight: auto,
  style: auto,
  font: auto,
  decorative-size: auto,
  decorative-weight: auto,
  decorative-style: auto,
  decorative-font: auto,
  small-caps: auto,
  layout: auto,
  include-first: false,
) = {
  let parts = title_parts(title)
  let title_size = if size == auto { theme.sizes.title } else { size }
  let title_font = if font == auto { theme.type.accent.font } else { font }
  let title_weight = if weight == auto { theme.type.accent.weight } else { weight }
  let title_style = if style == auto { theme.type.accent.style } else { style }
  let first_size = if decorative-size == auto { title_size * 3 } else { decorative-size }
  let first_font = if decorative-font == auto { theme.type.decorative.font } else { decorative-font }
  let first_weight = if decorative-weight == auto { theme.type.decorative.weight } else { decorative-weight }
  let first_style = if decorative-style == auto { theme.type.decorative.style } else { decorative-style }
  let title_leading = theme.title.leading
  let title_spacing = theme.title.spacing
  let title_gutter = theme.title.gutter
  let title_small_caps = if small-caps == auto { theme.title.small-caps } else { small-caps }
  let title_layout = if layout == auto { theme.title.layout } else { layout }
  let title_content = text(
    font: title_font,
    size: title_size,
    weight: title_weight,
    style: title_style,
    spacing: title_spacing,
  )[
    #if include-first {
      title
    } else {
      parts.rest
    }
  ]
  let first_content = box(
    fill: none,
    outset: (
      right: 2pt,
      left: 10pt,
      top: 10pt,
      bottom: 10pt,
    ),
    text(
      fill: black,
      size: first_size,
      font: first_font,
      weight: first_weight,
      style: first_style,
      spacing: title_spacing,
      top-edge: "bounds",
      bottom-edge: "bounds",
      dir: auto,
    )[#parts.first],
  )
  let first_inline_content = text(
    fill: black,
    size: first_size,
    font: first_font,
    weight: first_weight,
    style: first_style,
    spacing: title_spacing,
    top-edge: "bounds",
    bottom-edge: "bounds",
    dir: auto,
  )[#parts.first]
  let full_title_content = {
    set par(leading: title_leading)
    if title_small_caps {
      smallcaps(title_content)
    } else {
      title_content
    }
  }

  if title_layout == "stacked" {
    grid(
      columns: (1fr,),
      row-gutter: title_gutter,
      align: center,
      first_content,
      full_title_content,
    )
  } else if title_layout == "inline" {
    {
      set par(leading: title_leading)
      (
        first_inline_content
          + if title_small_caps {
            smallcaps(title_content)
          } else {
            title_content
          }
      )
    }
  } else {
    grid(
      columns: (1fr, 2fr),
      column-gutter: title_gutter,
      align: (right + horizon, left),
      first_content, full_title_content,
    )
  }
}

#let themed_title(
  theme,
  body,
  title-align: center,
  title-size: auto,
  title-weight: auto,
  title-style: auto,
  title-font: auto,
  title-small-caps: auto,
  title-layout: auto,
  title-include-first: false,
  meta-width: 110%,
  meta-stroke: (top: black, bottom: black),
  meta-outset: (top: 10pt, bottom: 10pt),
  meta-content: auto,
  after-title: 2.5em,
  after-meta: 3em,
  outline-size: auto,
  outline-weight: auto,
  outline-style: auto,
) = {
  show title: it => {
    align(
      title-align,
      context themed_title_text(
        theme,
        document.title,
        size: title-size,
        weight: title-weight,
        style: title-style,
        font: title-font,
        small-caps: title-small-caps,
        layout: title-layout,
        include-first: title-include-first,
      ),
    )
    v(after-title)
    align(center, box(
      stroke: meta-stroke,
      outset: meta-outset,
      width: meta-width,
      if meta-content == auto {
        text(
          size: theme.sizes.regular,
          font: theme.type.secondary.font,
          weight: theme.type.secondary.weight,
          style: theme.type.secondary.style,
          context document.author.join(" & ") + "\n" + context document.date.display(),
        )
      } else {
        meta-content
      },
    ))
    v(after-meta)
  }
  themed_title_body(
    theme,
    body,
    outline-size: outline-size,
    outline-weight: outline-weight,
    outline-style: outline-style,
  )
}
