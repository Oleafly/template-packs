#let positions(list: ()) = {
  let rows = list.map(p => (
    [
      #if "title" in p {
        if "company" in p {
          text(weight: "bold", p.title + ", ")
          text(style: "italic", p.company)
        } else {
          text(weight: "bold", p.title)
        }
      } else {
        if "company" in p {
          text(style: "italic", p.company)
        }
      }
    ],
    [
      #set align(right)
      #if "start" in p {
        if "end" in p [
          #p.start #sym.dash #p.end
        ] else [
          #p.start
        ]
      } else {
        if "end" in p [
          #p.end
        ]
      }
    ]
  )).flatten()
  grid(columns: (3fr, 1fr), column-gutter: 0.25fr, row-gutter: 0.5em, ..rows)
}
