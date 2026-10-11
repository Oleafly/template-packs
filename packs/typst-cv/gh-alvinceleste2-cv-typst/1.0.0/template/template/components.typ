#import "@preview/iconify:0.5.3": icon
#import "./settings.typ": *

#let inline-icon(
  name,
  color: primary-color,
  size-to: "P",
  scale: 1.8,
) = context {
  let text-edge = measure(size-to).height
  let text-bounds = measure(text(top-edge: "bounds", size-to)).height
  let extend = calc.max(0pt, text-bounds - text-edge) * scale
  let shift = (text-bounds * scale - text-bounds) / 2
  return text(fill: color)[#icon(
    name,
    height: text-bounds * scale,
    y: -extend - shift,
  )]
}

#let vbar(color: primary-color, spacing: 0.3em) = text(
  fill: color,
  weight: "bold",
)[#h(spacing)|#h(spacing)]

#let color-link(color: primary-color, url, body) = link(url)[#text(
  fill: url-color,
)[#body]]

// How info is presented can be changed in this function
#let info(data) = [
  #grid(
    columns: 1,
    rows: (auto, 1.3em, auto, 1em, auto, 1.5em, auto),

    text(size: 25pt, weight: "bold")[#smallcaps(data.name) #smallcaps(
        data.last-name-1,
      ) #smallcaps(data.last-name-2)],
    [],

    text(
      size: 12pt,
    )[#inline-icon("material-symbols:location-on-rounded") #h(0.1em) #data.city / #data.country #vbar(spacing: 1em) #inline-icon("solar:phone-bold", scale: 2) #h(0.1em) #link("tel:" + data.phone-number)],
    [],

    text(size: 12pt)[#inline-icon("material-symbols:inbox-rounded") #h(
        0.1em,
      ) #link("mailto:" + data.email)],
    [],

    text(size: 11pt)[
      #if data.github != none {
        inline-icon("grommet-icons:github")
        h(0.4em)
        color-link(
          "https://github.com/" + data.github,
          data.github,
        )
        if data.linkedin != none {
          vbar(spacing: 1em)
        }
      }
      #if data.linkedin != none {
        inline-icon("grommet-icons:linkedin", scale: 1.6)
        h(0.4em)
        color-link(
          "https://linkedin.com/in/" + data.linkedin,
          data.linkedin,
        )
        if data.webpage != none {
          vbar(spacing: 1em)
        }
      }
      #if data.webpage != none {
        inline-icon("mingcute:link-fill", scale: 1.8)
        h(0.4em)
        color-link(
          "https://" + data.webpage,
          data.webpage,
        )
      }
    ],
  )
]

#let header(data: list) = {
  v(-1cm)
  if data.photo != none {
    grid(
      columns: (2fr, 1fr),
      align: center + horizon,
      info(data),

      grid.cell(rowspan: 1, box(
        width: 4cm,
        height: 4cm,
        radius: 50%,
        clip: true,
        data.photo,
      )),
    )
  } else {
    grid(
      columns: 1fr,
      align: center + horizon,
      info(data),
    )
  }
}

#let item(title: str, subtitle: str, date: str, body) = {
  block(breakable: false, above: 0.8em, below: 0.9em)[
    #pad(left: 1em)[
      #grid(
        columns: (1fr, auto),
        column-gutter: 0.5cm,
        align: (x, y) => {
          if x == 1 {
            right
          } else {
            left
          }
        },
        text(size: 1.05em, weight: "bold")[#smallcaps(title)],
        [#text(size: 1em, fill: primary-color)[#date]],
      )
    ]
    #pad(left: 1.5em)[#text(size: 1em)[#smallcaps(subtitle)]]
    #pad(left: 1.5em)[#body]
  ]
}

#let skills(skills: array) = {
  pad(left: 1em)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      row-gutter: 1em,
      align: (right, left),
      ..skills.flatten(),
    )
  ]
}

#let skill(title, desc) = {
  (
    text(weight: "bold", size: 1em)[#smallcaps(title)],
    text(size: 0.95em)[#desc],
  )
}
