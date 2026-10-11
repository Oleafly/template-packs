// NPU-CV Typst template_Blue.
// This template is Ported from https://github.com/CSW33/NPU-CV.

#import "@preview/heroic:0.1.2": hi

#let npu-blue = rgb("#00509E")
#let default-latin-font = "Arial"
#let default-cjk-font = "Microsoft YaHei"
#let fallback-cjk-fonts = ("Microsoft Yahei", "Microsoft YaHei UI")
#let body-fonts = (default-latin-font, default-cjk-font) + fallback-cjk-fonts

#let cv-fonts(latin: default-latin-font, cjk: default-cjk-font) = {
  (latin, cjk) + fallback-cjk-fonts
}

#let cv-text(
  body,
  font: body-fonts,
  size: 11pt,
  fill: black,
  weight: "regular",
  style: "normal",
) = {
  text(font: font, size: size, fill: fill, weight: weight, style: style)[#body]
}

#let cv-icon(icon, fill: npu-blue, size: 1em, solid: true) = {
  hi(icon, color: fill, height: size, solid: solid)
}

#let contact(icon, body, href: none, font: body-fonts, fill: white) = {
  cv-icon(icon, fill: fill, size: 0.95em)
  h(0.45em)
  if href == none {
    cv-text(body, font: font, size: 9pt, fill: fill)
  } else {
    link(href)[#cv-text(body, font: font, size: 9pt, fill: fill)]
  }
}

#let cv-background(school, contacts, ui-font: cv-fonts()) = [
  #v(6cm)
  #place(center, image("images/npu_logo_big.png", width: 70%))
  #place(top + center, rect(width: 100%, height: 100%, fill: white.transparentize(5%)))

  #place(top + center, image("images/header.png", width: 101%))
  #place(top + left, dx: 0.5cm, dy: 0.32cm, image("images/npu_logo_2.png", width: 4.65cm))
  #place(
    top + right,
    dx: -0.5cm,
    dy: 0.56cm,
    cv-text(school, font: ui-font, size: 12pt, weight: "bold", fill: white),
  )

  #place(bottom + center, image("images/footer.png", width: 101%))
  #place(
    bottom + center,
    dy: -0.33cm,
    cv-text(contacts, font: ui-font, size: 9pt, fill: white),
  )
]

#let npu-cv(
  school: [电子信息学院 | School of Electronics And Information],
  latin-font: default-latin-font,
  cjk-font: default-cjk-font,
  body-font: none,
  body-size: 11pt,
  body-fill: black,
  ui-font: none,
  contacts: [
    #contact("envelope", [xxxx\@mail.nwpu.edu.cn], href: "mailto:xxxx@mail.nwpu.edu.cn")
    #h(4em)
    #contact("chat-bubble-left-right", [xxxxxxxxxxxxx])
    #h(4em)
    #contact("phone", [12345678900])
    #h(4em)
    #contact("code-bracket", [https://github.com/xxxx], href: "https://github.com/xxxx")
  ],
  body,
) = {
  let doc-font = if body-font == none { cv-fonts(latin: latin-font, cjk: cjk-font) } else { body-font }
  let doc-ui-font = if ui-font == none { cv-fonts(latin: latin-font, cjk: cjk-font) } else { ui-font }

  set document(title: "NPU CV", author: "CSW33")
  set page(
    paper: "a4",
    margin: (left: 1.2cm, right: 1.2cm, top: 1.8cm, bottom: 1.5cm),
    numbering: none,
    background: cv-background(school, contacts, ui-font: doc-ui-font),
  )
  set text(font: doc-font, size: body-size, fill: body-fill, lang: "zh", region: "cn")
  set par(first-line-indent: 0pt, leading: 0.78em, spacing: 0.72em, justify: false)
  set figure(supplement: [图])
  set figure.caption(separator: [. ])

  body
}

#let cv-section(
  title,
  icon: none,
  font: cv-fonts(),
  size: 18pt,
  fill: black,
  weight: "bold",
  style: "normal",
  icon-fill: npu-blue,
  icon-size: 18pt,
  icon-solid: true,
  rule-fill: npu-blue,
) = {
  block(width: 100%, above: 0.98em, below: 0em, sticky: true)[
    #cv-text(font: font, size: size, fill: fill, weight: weight, style: style)[
      #if icon != none {
        cv-icon(icon, fill: icon-fill, size: icon-size, solid: icon-solid)
        h(0.3em)
      }
      #title
    ]
    #v(-0.8em)
    #line(length: 100%, stroke: 0.7pt + rule-fill)
  ]
}

#let cv-subsection(
  title,
  tail: none,
  layout: "split",
  tail-width: 27%,
  font: body-fonts,
  size: 13pt,
  fill: black,
  weight: "bold",
  style: "normal",
) = {
  block(width: 100%, above: 0.9em, below: 0.9em, sticky: true)[
    #if tail == none {
      cv-text(title, font: font, size: size, fill: fill, weight: weight, style: style)
    } else if layout == "stack" {
      cv-text(title, font: font, size: size, fill: fill, weight: weight, style: style)
      v(0.2em)
      align(right)[#cv-text(tail, font: font, size: size, fill: fill, weight: weight, style: style)]
    } else {
      grid(
        columns: (1fr, tail-width),
        column-gutter: 1.2em,
        align: (left, right),
        cv-text(title, font: font, size: size, fill: fill, weight: weight, style: style),
        cv-text(tail, font: font, size: size, fill: fill, weight: weight, style: style),
      )
    }
  ]
}

#let cv-entry(
  title,
  tail: none,
  role: none,
  date: none,
  title-layout: "split",
  tail-width: 27%,
  title-font: body-fonts,
  title-size: 13pt,
  title-fill: black,
  title-weight: "bold",
  title-style: "normal",
  body-font: body-fonts,
  body-size: 11pt,
  body-fill: black,
  body-style: "normal",
  role-fill: black,
  role-style: "normal",
  body,
) = {
  cv-subsection(
    title,
    tail: tail,
    layout: title-layout,
    tail-width: tail-width,
    font: title-font,
    size: title-size,
    fill: title-fill,
    weight: title-weight,
    style: title-style,
  )
  if role != none or date != none {
    grid(
      columns: (1fr, auto),
      column-gutter: 0.8em,
      cv-text(
        if role == none { [] } else { role },
        font: body-font,
        size: body-size,
        fill: role-fill,
        weight: "bold",
        style: role-style,
      ),
      if date == none { [] } else { date },
    )
    v(0.3em)
  }
  cv-text(body, font: body-font, size: body-size, fill: body-fill, style: body-style)
}

#let cv-paper(
  title,
  venue: none,
  role: none,
  date: none,
  venue-width: 27%,
  title-font: body-fonts,
  title-size: 13pt,
  title-fill: black,
  title-weight: "bold",
  title-style: "normal",
  venue-font: body-fonts,
  venue-size: 13pt,
  venue-fill: black,
  venue-weight: "bold",
  venue-style: "normal",
  body-font: body-fonts,
  body-size: 11pt,
  body-fill: black,
  body-style: "normal",
  role-fill: black,
  role-style: "normal",
  body,
) = {
  if role != none or venue != none or date != none {
    block(width: 100%, above: 0.9em, below: 0.9em, sticky: true)[
      #grid(
        columns: (1fr, venue-width),
        column-gutter: 1.2em,
        cv-text(
          title,
          font: title-font,
          size: title-size,
          fill: title-fill,
          weight: title-weight,
          style: title-style,
        ),
        if venue == none { [] } else {
          align(bottom + right)[
            #cv-text(
              venue,
              font: venue-font,
              size: venue-size,
              fill: venue-fill,
              weight: venue-weight,
              style: venue-style,
            )
          ]
        },
      )
    ]
    if role != none or date != none {
      grid(
        columns: (1fr, venue-width),
        column-gutter: 1.2em,
        cv-text(
          if role == none { [] } else { role },
          font: body-font,
          size: body-size,
          fill: role-fill,
          weight: "bold",
          style: role-style,
        ),
        align(right)[#if date == none { [] } else { date }],
      )
    }
    v(0.3em)
  } else {
    cv-subsection(
      title,
      font: title-font,
      size: title-size,
      fill: title-fill,
      weight: title-weight,
      style: title-style,
    )
  }
  cv-text(body, font: body-font, size: body-size, fill: body-fill, style: body-style)
}

#let cv-small(body) = text(size: 9.2pt)[#body]
#let cv-red-large(body) = text(size: 18pt, fill: red)[#body]
#let cv-list(
  body,
  cols: 1,
  gutter: 1.6em,
  font: body-fonts,
  size: 11pt,
  fill: black,
  style: "normal",
) = {
  block(width: 100%)[
    #set text(font: font, size: size, fill: fill, style: style)
    #if cols <= 1 {
      body
    } else {
      columns(cols, gutter: gutter)[#body]
    }
  ]
}

#let cv-items(
  items,
  cols: 1,
  gutter: 1.6em,
  row-gutter: 0.8em,
  bullet: "•",
  font: body-fonts,
  size: 11pt,
  fill: black,
  style: "normal",
) = {
  let colspec = if cols <= 1 {
    (1fr,)
  } else if cols == 2 {
    (1fr, 1fr)
  } else if cols == 3 {
    (1fr, 1fr, 1fr)
  } else {
    (1fr, 1fr, 1fr, 1fr)
  }
  let cell(item) = cv-text([#bullet #h(0.45em)#item], font: font, size: size, fill: fill, style: style)
  grid(
    columns: colspec,
    column-gutter: gutter,
    row-gutter: row-gutter,
    ..items.map(cell),
  )
}
#let cpp = [C#move(dy: -0.22em, text(size: 0.72em)[++])]
