#import "theme.typ": *

#let join_content(items, sep: [, ]) = [
  #let n = items.len()
  #for idx in range(n) {
    items.at(idx)
    if idx + 1 < n { sep }
  }
]

#let icon_size = 0.92em
#let logo_size = 2.7em

#let contact_item(icon, body) = [
  #box(width: icon_size)[#image(icon, width: icon_size)]
  #h(0.24em)
  #body
]

#let school_logo(logo) = [
  #if logo == none {
    rect(
      width: logo_size,
      height: logo_size,
      stroke: thin_rule + rule_color,
      radius: 2pt,
      inset: 0pt,
    )[
      #align(center + horizon)[
        #text(size: tiny_size, fill: subtle_color)[LOGO]
      ]
    ]
  } else {
    image(logo, width: logo_size, height: logo_size, fit: "contain")
  }
]

#let school_card(school) = [
  #grid(
    columns: (auto, 1fr),
    gutter: 0.48em,
    align: (center, left),
    [#school_logo(school.logo)],
    [
      #text(size: small_size, weight: "bold")[#school.degree · #school.school]
      #v(0.05em)
      #text(size: tiny_size, fill: muted_color)[#school.major]
      #v(0.05em)
      #text(size: tiny_size, fill: subtle_color)[#school.tier · #school.years]
    ],
  )
]

#let resume_header(info) = [
  #grid(
    columns: (1.18fr, 0.82fr),
    gutter: 1.2em,
    align: (left, top),
    [
      #text(size: name_size, weight: "bold", fill: accent)[#info.name]
      #h(0.75em)
      #text(size: small_size, fill: muted_color)[#info.age 岁 · #info.gender · #info.graduation_year]

      #v(0.22em)
      #text(size: base_size, fill: text_color)[#info.summary]

      #v(0.30em)
      #text(size: small_size, fill: text_color)[
        #contact_item("assets/icons/phone.svg")[#info.phone]
        #h(0.9em)
        #contact_item("assets/icons/mail.svg")[#link("mailto:" + info.email)[#(info.email)]]
        #h(0.9em)
        #contact_item("assets/icons/github.svg")[#link(info.github_url)[#info.github]]
      ]

      #v(0.22em)
      #text(size: small_size, fill: muted_color)[
        #info.cet6 #h(0.85em) · #h(0.85em) #info.internship_duration
      ]
    ],
    [
      #school_card(info.undergraduate)
      #v(0.22em)
      #school_card(info.master)
    ],
  )

  #v(0.34em)
  #line(length: 100%, stroke: header_rule + accent)
  #v(0.42em)
]

// Page wrapper used by #show. It prints the header, then the document body.
#let resume_page(
  basic: (:),
  body,
) = [
  #resume_header(basic)

  #body
]

#let section(title, body) = [
  #v(section_before)
  #text(size: section_size, weight: "bold", fill: accent)[#title]
  #v(0.12em)
  #line(length: 100%, stroke: thin_rule + accent)
  #v(section_after)
  #body
]

#let entry(
  title: "",
  org: "",
  date: "",
  location: "",
  tech: (),
  body,
) = [
  #grid(
    columns: (1fr, auto),
    gutter: 0.8em,
    align: (left, right),
    [
      #text(weight: "bold")[#title]
      #if org != "" [
        #text(fill: muted_color)[ · #org]
      ]
    ],
    [
      #text(size: small_size, fill: muted_color)[#date]
    ],
  )

  #if location != "" or tech.len() > 0 [
    #v(0.05em)
    #text(size: small_size, fill: muted_color)[
      #if location != "" [#location]
      #if location != "" and tech.len() > 0 [#h(0.65em) | #h(0.65em)]
      #if tech.len() > 0 { join_content(tech, sep: [ · ]) }
    ]
  ]

  #v(0.16em)
  #body
  #v(entry_after)
]

#let compact_entry(
  title: "",
  right: "",
  body,
) = [
  #grid(
    columns: (1fr, auto),
    gutter: 0.8em,
    align: (left, right),
    [#text(weight: "bold")[#title]],
    [#text(size: small_size, fill: muted_color)[#right]],
  )
  #v(0.12em)
  #body
  #v(0.32em)
]

#let skill_line(label, items) = [
  #block[
    #text(weight: "bold")[#label]
    #h(0.45em)
    #text(fill: text_color)[#join_content(items, sep: [ · ])]
  ]
]

#let note(text_body) = [
  #text(size: tiny_size, fill: subtle_color)[#text_body]
]
