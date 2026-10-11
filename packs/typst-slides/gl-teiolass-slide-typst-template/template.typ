// ====== PARAMS ======
#let accent_color = rgb("#1f77b4")
#let title_text_size = 2.0em
#let footer_text_size = 0.8em
#let title = "My very Title"
#let author = "Marche"
#let short_title = "Short Title"
// ====================

#let slide_counter = counter("slide_counter")

#let full_rect(color: red) = rect(width:100%, height:100%, fill: color)

#let slide_template(doc) = {
  set text(
    font: "Latin Modern Sans",
    size: 20pt,
  )
  set page(
      paper: "presentation-4-3",
      margin: 0pt,
  )
  doc
}

#let slide(
  ratios: (65pt, 1fr, 20pt),
  is_counted: true,
  header, content, footer
) = {
  if is_counted {
    slide_counter.step()
  }
  grid(
    columns: (100%),
    rows: ratios,

    box(
      width: 100%, height: 100%,
      header,
    ),
    box(
      width: 100%, height: 100%,
      content,
    ),
    box(
      width: 100%, height: 100%,
      footer,
    )
  )
}


#let slide_title(
  title,
  bg_color: accent_color,
  fg_color: white,
) = {
  set text(title_text_size, fg_color)
  box(
    width: 100%, height: 100%,
    fill: accent_color,
    {
      set align(left+horizon)
      block(
        inset: (left: 1em),
        title
      )
    }
  )
}

#let slide_footer(
  author: author,
  title: short_title,
  bg_color_left: white,
  bg_color_right: accent_color,
  fg_color_left: black,
  fg_color_right: white,
) = {
  set text(footer_text_size)
  grid(
    columns: (1fr, 1fr),
    box(
      width: 100%, height: 100%,
      fill: bg_color_left,
      {
        set align(right+horizon)
        set text(fg_color_left)
        box(inset:(right: 1em), author)
      }
    ),
    box(
      width: 100%, height: 100%,
      fill: bg_color_right,
      {
        set text(fg_color_right)
        set align(horizon)

        stack(
          dir: ltr,
          spacing: 0pt,

          1em,
          short_title,
          1fr,
          context [#slide_counter.display()/#slide_counter.final().first()],
          1em
        )
      }
    )
  ) 
}

#let slide_margin(margin: (x: 40pt, top: 30pt, bottom: 15pt), content) = {
  box(width: 100%, height:100%,inset: margin, content)
}

#let slide_double(margin: (x: 40pt, top: 30pt, bottom: 15pt), spacing: 30pt, content_left, content_right) = {
  slide_margin(
    margin: margin, 
    grid(
      columns: (1fr, spacing, 1fr),
      content_left, [], content_right
    )
  )
}

#let slide_common(
  title, content
) = {
  slide(
    slide_title(title),
    slide_margin(content),
    slide_footer()
  )
}
#let slide_common_double(
  title, content_left, content_right
) = {
  slide(
    slide_title(title),
    slide_double(content_left, content_right),
    slide_footer()
  )
}
