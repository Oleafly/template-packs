#import "section.typ": section

#let skills(title, skills) = section(title)[
  #table(
    columns: (2.2cm, 1fr),
    gutter: 4pt,
    stroke: none,

    ..skills
      .map(skill => (
        [
          #text(
            size: 8.3pt,
            weight: "semibold",
            fill: rgb("#334155"),
          )[
            #skill.title
          ]
        ],
        [
          #text(
            size: 7.8pt,
            fill: rgb("#64748B"),
          )[
            #skill.items.join(" • ")
          ]
        ],
      ))
      .flatten()
  )
]
