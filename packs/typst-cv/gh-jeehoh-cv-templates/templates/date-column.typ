// Copyright (c) 2026 Jiho Kim <nghtctrl@gmail.com>
// SPDX-License-Identifier: MIT
//
// This file is part of a curriculum vitae template distributed under the MIT
// License. See the LICENSE file in the project root for the full license text.
//
// This CV template is heavily inspired by Yaxin Hu's CV (see https://edayaxin.github.io/)

#let paper-type = "us-letter"

// Date column sizes
#let label-width = 1.0in  // Date column with right-aligned labels
#let gutter = 0.25in  // Whitespace separating the column from the body

// Accent colors
#let tonal-offset = 20%
#let accent-base = rgb("#4A5899")
#let accent-light = accent-base.lighten(tonal-offset)
#let accent-dark = accent-base.darken(tonal-offset * 1.5)

// Font sizes
#let base-size = 10pt
#let section-size = 13pt
#let subsection-size = 12pt

// Set once by `biography`, read by the author helpers below
#let owner-name = state("owner-name", none)

#let title(body, url: none) = {
  let styled = text(weight: "bold")[#body]
  if url == none { styled } else { link(url)[#styled] }
}

#let badge(name) = box(
  fill: accent-base,
  inset: (x: 2.5pt, y: 2pt),
  outset: (y: 1pt),
  radius: 1pt,
  text(fill: white, size: 6pt, weight: "bold", tracking: 0.4pt)[#upper(name)],
)

#let author(name) = text(fill: accent-light, weight: 800)[#name]

#let me = context author[#owner-name.get()]
#let me-eq = context author[#owner-name.get()\*]  // Equal contribution

#let pub-label(year, venue) = [#year \ #badge(venue)]

#let section(title) = {
  block(above: 2.5em, below: 1.5em, breakable: false, sticky: true)[
    #grid(
      columns: (label-width + gutter, 1fr),
      [], heading(level: 1)[#title],
    )
  ]
}

#let subsection(title) = {
  block(above: 1.5em, below: 1.5em, breakable: false, sticky: true)[
    #grid(
      columns: (label-width + gutter, 1fr),
      [], heading(level: 2)[#title],
    )
  ]
}

#let entry(side, body) = block(below: 1.5em, width: 100%, breakable: false)[
  #grid(
    columns: (label-width, gutter, 1fr),
    align: (right + top, left, left + top),
    text(size: base-size)[#set par(justify: false); #side], [], body,
  )
]

#let biography(
  name: none,
  phone: none,
  email: none,
  website: none,
  address: none,
  research-interest: none,
  show-address-label: true,
  show-research-label: true,
  contact-gap: 0.3em,
  body,
) = {
  set page(
    paper: paper-type,
    header: context {
      if counter(page).get().first() > 1 [
        #name
        #h(1fr)
        Curriculum Vitae
      ]
    },
    footer: context align(center)[
      #counter(page).display("1 of 1", both: true)
    ],
  )
  set text(font: "Libertinus Serif", size: base-size, hyphenate: true)

  set heading(numbering: none)
  show heading.where(level: 1): it => text(
    size: section-size,
    weight: "bold",
    fill: accent-dark,
  )[#it.body]
  show heading.where(level: 2): it => text(
    size: subsection-size,
    weight: "bold",
    fill: accent-dark,
  )[#it.body]

  owner-name.update(name)

  // Dot-separated contact line
  let contacts = ()
  if phone != none {
    contacts.push([#text()[#phone]])
  }
  if email != none {
    contacts.push(link("mailto:" + email)[#text()[#email]])
  }
  if website != none {
    contacts.push(link(website)[#text()[#website]])
  }

  block(below: 1.5em, breakable: false, sticky: true)[
    #grid(
      columns: (label-width + gutter, 1fr),
      row-gutter: 1.5em,
      [], text(size: base-size * 2)[#name],
      [],
      if contacts.len() > 0 {
        text(size: base-size)[#contacts.join([
          #h(contact-gap)#sym.bullet#h(contact-gap)
        ])]
      },
    )
  ]

  if address != none {
    entry(if show-address-label { [Address] } else { [] })[#address]
  }

  if research-interest != none {
    entry(if show-research-label { [Research \ Interests] } else { [] })[
      #research-interest
    ]
  }

  body
}
