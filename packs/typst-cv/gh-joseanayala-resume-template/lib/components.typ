#import "tokens.typ": *

#let underlined-link(dest, body) = underline(link(dest, body))

#let header(name: "", tagline: "", contacts: []) = {
  align(center)[
    #text(
      font: heading-font,
      size: name-size,
      weight: "semibold",
    )[#smallcaps(
      name,
    )]
    #v(s3, weak: true)
    #text(size: tagline-size)[#tagline]
    #v(s2, weak: true)
    #contacts
  ]
}

#let entry(
  left-top: [],
  right-top: [],
  left-bot: [],
  right-bot: [],
) = {
  block(above: s2, below: s2)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      row-gutter: s1,
      strong[#left-top], strong[#right-top],
      emph[#left-bot], emph[#right-bot],
    )
  ]
}

#let bullets(items) = {
  set list(indent: s2, body-indent: s1, marker: [•])
  show list.item: it => block(spacing: s2, it)
  for item in items [- #item]
}

#let skills(rows) = {
  set list(indent: s2, body-indent: s1, marker: [•])
  show list.item: it => block(spacing: s2, it)
  for (label, value) in rows [- *#label*: #value]
}
