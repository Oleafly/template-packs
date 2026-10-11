#let template(
    font-size: 12pt,
    font: "Noto Serif CJK SC",
    doc,
) = {
    set page(
        margin: (x: 0.9cm, y: 1.3cm),
        paper: "a4",
    )
    set text(
        size: font-size,
        font: font,
    )
    show link: text
    set par(
        justify: true,
    )
    doc
}

#let r_name(name) = {
    set align(
        center,
    )
    text(
        style: "normal",
        weight: "extrabold",
        size: 20pt,
    )[#name]
    set align(left)
}

#let intent(content) = {
    set align(
        center,
    )
    text(
        style: "normal",
    )[#content]
    set align(left)
}

#let contact(
  ..texts
) = {
    set align(center)
    texts.pos().map(item => {
        box(
            height: 1em,
            {
              h(0.15em)
              item
            }
        )
    }).join(
      box(
        height: 1em,
        {
          h(0.5em) + "|" + h(0.5em)   
        }
      )
    )
}

#let r_line() = {v(-3pt); line(length: 100%); v(-5pt)}

#let r_section(title) = {
    v(0.5em)
    [== #title]
    r_line()
    v(0.5em)
}

#let r_item(proj_title, proj_time, proj_postion, proj_rule) = {
  grid(
    columns: (1fr, auto),
    gutter: 0em,
    [*#proj_title*],
    if proj_time != none and proj_time != "" {
      align(right)[#proj_time]
    } else { [] },
  )

  if (proj_postion != none and proj_postion != "") or (proj_rule != none and proj_rule != "") {
    v(-0.5em)
    grid(
      columns: (1fr, auto),
      gutter: 0em,
      if proj_postion != none and proj_postion != "" {
        [#proj_postion]
      } else { [] },
      if proj_rule != none and proj_rule != "" {
        align(right)[#proj_rule]
      } else { [] },
    )
  }
}

#let r_description(l, r) = {
    [- *#l*: #r]
}

#let award_item(
  summary,
  time,
) = {
  grid(
    columns: (1fr, auto),
    gutter: 0em,
    [- #summary],
    align(right)[#time],
  )
}
