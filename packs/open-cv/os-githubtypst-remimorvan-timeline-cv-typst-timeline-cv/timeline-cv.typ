#import "@preview/fontawesome:0.5.0": *

#let is_non_empty(content) = {
  content != "" and content != []
}

#let tag(data: (), content) = [
  #box(inset: (left: .48em, bottom: -.18em))[
    #box(
      fill: rgb(data.colour.tag),
      inset: (x: .48em, y: .24em),
      clip: true,
      radius: .5em,
      text(font: data.font.tag, size: .8em, fill: black, weight: "regular")[#content],
    )
  ]
]

#let separator = [
  #h(.2em)·#h(.2em)
]

#let section_presentation(
  data: (),
  first_name,
  last_name,
  job_title,
  photo: [],
  contact: (),
  presentation: "",
  contact_separator: v(-.1em),
) = {
  set align(eval(data.name.align))
  // Name
  {
    set text(font: data.font.title)
    text(size: eval(data.name.first_name_size), weight: "extrabold")[
      #first_name
    ]
    linebreak()
    text(eval(data.name.last_name_size), weight: "extrabold")[
      #last_name
    ]
    v(1.5em, weak: true)
    if is_non_empty(job_title) {
      text(size: 1.1em, weight: "bold", fill: rgb(data.colour.side))[
        #smallcaps(job_title)
      ]
    }
    v(1em)
  }
  if (is_non_empty(photo)) [
    #set align(center)
    #photo
    #v(1em)
  ]
  // Contact
  for i in range(contact.len()) [
    #if (i > 0) {
      contact_separator
    }
    #let item = contact.at(i)
    #if ("type" in item) [
      #text(size: 1.2em, fa-icon(item.type, solid: true))
      #h(.5em)
    ]
    #text(font: data.font.tag)[
      #if ("link" in item) [
        #link(item.link)[#item.display]
      ] else [
        #item.display
      ]
    ]
  ]
  if is_non_empty(presentation) {
    v(1em)
    presentation
  }
}

#let section_timeline(
  icon: "",
  title: "Section Name",
  content: (),
) = {
  place()[
    #circle(radius: .9em, stroke: .15em, fill: black)
  ]
  if is_non_empty(icon) {
    place(start + top, dx: .45em, dy: .45em)[
      #box(height: .9em, width: .9em)[
        #align(center + horizon, text(fill: white, fa-icon(icon)))
      ]
    ]
  }

  box(inset: (left: 1.8em + 1.25em, top: .35em))[
    #heading(numbering: none, depth: 1, title)
  ]
  box(
    stroke: (left: .15em, rest: none),
    inset: (left: .9em + 1.25em, top: 1em, bottom: .75em),
    outset: (left: -.9em, top: .05em, right: 1.4em, rest: 0em),
  )[
    #list(
      marker: [
        #place(dx: -.35em - 1.25em)[
          #circle(radius: .35em, fill: white, stroke: .15em)
        ]
      ],
      body-indent: 0pt,
      spacing: 1.5em,
      ..content,
    )
  ]
}

#let entry_main(data: (), when: "", where: "", details: "", title: "", description) = [
  #if is_non_empty(when) [
    _ #when _
    #if (is_non_empty(where) or is_non_empty(details) or is_non_empty(title)) [
      #separator
    ]
  ]
  #text(weight: "semibold", where)
  #if is_non_empty(details) [
    #text(size: 0.9em)[
      #h(.2em) (#details)
    ]
  ]
  #if is_non_empty(when) and (is_non_empty(where) or is_non_empty(details)) [
    #linebreak()
  ]
  #text(
    font: data.font.title,
    size: 1.1em,
    fill: rgb(data.colour.main),
    weight: "semibold",
    smallcaps(title),
  )\
  #description
]

#let section_items(data: (), title: "", content, content_separator: v(-.1em)) = {
  heading(numbering: none, depth: 1, title)
  v(1em)
  for i in range(content.len()) [
    #if (i > 0) {
      content_separator
    }
    #content.at(i)
  ]
}

#let entry_side(data: (), title: "", preposition: "", where: "", when: "", description) = [
  #text(
    font: data.font.title,
    size: 1.1em,
    fill: rgb(data.colour.side),
    weight: "semibold",
    smallcaps(title),
  )
  #preposition
  #text(weight: "semibold", where)
  #if is_non_empty(when) [
    #text(size: 0.9em)[
      (#when)
    ]
  ]
  #if is_non_empty(description) [
    #description
  ]
]

#let skill_point(data: (), filled) = {
  box(
    circle(
      radius: .35em,
      stroke: (.15em + rgb(data.colour.side)),
      fill: if filled { rgb(data.colour.side) },
    ),
    inset: (x: .2em),
  )
}

#let entry_skill(data: (), title: "", level: 0, level_max: 3, details: "") = [
  #for i in range(level_max) {
    skill_point(data: data, i < level)
  }
  #h(.8em)
  #text(weight: "semibold", title)
  #if is_non_empty(details) [
    #text(size: 0.9em)[
      #h(.2em) (#details)
    ]
  ]
]


#let entry_simple(data: (), title: "", content) = [
  #text(
    font: data.font.title,
    size: 1.1em,
    fill: rgb(data.colour.side),
    weight: "semibold",
    smallcaps(title),
  )
  #content
]


#let cv(data: (), above: [], side: [], main: [], doc) = {
  set page(
    paper: "a4",
    margin: (x: eval(data.margin.x), y: eval(data.margin.y)),
  )
  set text(
    font: data.font.main,
    size: eval(data.font.size),
  )
  set par(
    justify: true,
    leading: 0.52em,
  )
  set list(marker: [•])
  set strong(delta: 200)
  show heading: it => block(
    width: 100%,
    text(
      font: data.font.title,
      smallcaps(it.body),
    ),
  )
  grid(
    columns: (3fr, 8fr),
    gutter: eval(data.margin.column_separator),
    [
      #set text(size: eval(data.font.size) * 0.9)
      #v(1em)
      #side
    ],
    [
      #main
    ],
  )
  doc
}
