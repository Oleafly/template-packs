#import "@preview/fontawesome:0.6.2": *

#let configuration = yaml("resume.yml")
#let config = configuration.config

// variables {{{
#let xbox_color_fg = config.color.box.fg
#let xbox_color_bg = config.color.box.fg

#let font_title = config.font.title
#let font_body  = config.font.body
#let font_mono  = config.font.mono
// }}}

// fontawesome icon {{{
#let icon(name, shift: 1.5pt, solid: false) = {
  h(3pt)
  box(
    fa-icon(name, solid: solid)
  )
  h(3pt)
}
// }}}

// cbox {{{
#let cbox(name) = {
  box(
    outset: (x: 1pt, y: 1.5pt),
    inset: (x: 1pt, y: 1.0pt),
    clip: true,
    radius: 2pt,
    stroke: 0.2pt + gradient.linear(rgb("#efefef"), rgb("#dddddd"), angle: 90deg),
    fill: gradient.linear(rgb("#f7f7f7"), rgb("#ffffff"), angle: 90deg),
  )[
    #text(
      size: 8pt,
      spacing: 2pt,
    )[
      #name
    ]

  ]
  h(2pt)
}
// }}}

// cage macro {{{
#let cage(content) = {
  box(
    outset: (x: 1pt, y: 1.5pt),
    inset: (x: 1pt, y: 1.0pt),
    clip: true,
    radius: 2pt,
    stroke: 0.2pt + gradient.linear(rgb("#efefef"), rgb("#dddddd"), angle: 90deg),
    fill: gradient.linear(rgb("#f7f7f7"), rgb("#ffffff"), angle: 90deg),
    width: 100%,
  )[
    #text(
      size: 7pt,
      spacing: 2pt,
    )[
      #pad(
        left: 5pt,
        right: 5pt,
        top: 5pt,
        bottom: 5pt,
      )[
        #content
      ]
    ]
  ]
}
// }}}

// entry macro {{{
// timeline
#let timeline(body, last: false) = {
  let radius = 1.0pt
  let fill = rgb("#cccccc")
  let stroke = if not last {
    (
      right: (
        paint: fill,
        thickness: radius / 2.5,
        // dash: (
        //   3pt, 3pt, "dot", 3pt
        // ),
        miter-limit: 1,
        // cap: "round",
        // join: "round",
      ),
    )
  }
  let circle = box(
  )[
    #circle(radius: radius, fill: fill)
  ]
  (
    grid.cell(
      colspan: 2,
      align: center,
      inset: (
        y: 2pt,
      ),
    )[
      #circle
    ],
    grid.cell(
      rowspan: 2,
      inset: (
        bottom: 0.1em + 5pt,
        left: -5pt,
      ),
    )[
      #body
    ],
    grid.cell(
      stroke: stroke,
      inset: (
        top:    9pt,
        bottom: 9pt,
        y: 9pt,
        x: 9pt,
      ),
    )[],
    none,
  )
}

#let entry(
  company: (),
  product: (),
  position: (),
  extra,
) = [
  #cage[
    #text(
      weight: "bold",
      size: 9pt,
    )[
      #if type(company) == "str" [
        #company
      ] else [
        #if "link" in company [
          #if company.link != "" [
            #link(company.link, company.name)
          ] else if "url" in company [
            #link(company.url, company.name)
          ]
        ] else [
          #if "name" in company [
            #company.name
          ]
        ]
      ]
    ]
    #h(1fr)
    #text(
      size: 7pt,
    )[
      #if "link" in product [
        #if product.link != "" [
          #link(product.link, product.name)
        ] else if "url" in product [
          #link(product.url, product.name)
        ]
      ] else [
        #if "name" in product [
          #product.name
        ] else if "text" in product [
          #product.text
        ]
      ]
    ]
    #v(-3pt)
    #let count = position.len()
    #if count == 1 [
      #let pos = position.at(0)
      #text(
        size: 8pt,
      )[
        #pos.name
      ]
      #h(1fr)
      #if pos.location == product.name [
        #pos.location
        #icon("location-dot")
      ] else [
        #pos.location
        #icon("location-dot") \
        #if pos.from != "" [
          #if pos.to == "Present" [
            #icon("calendar")
          ] else [
            #icon("calendar-check")
          ]
          #text(
            size: 6pt,
            font: font_mono,
          )[
            #pos.from --- #pos.to
          ]
        ]
      ]
      #pad(
        left:   4pt,
        right:  4pt,
      )[
        #for desc in pos.description [
          - #desc
        ]
      ]
    ] else [
      #pad(
        left:   -6pt,
        bottom: -6pt,
      )[
        #grid(
          columns: (1.25em, 1.25em, 1fr),
          column-gutter: (0pt, 0.3em),
          ..position.enumerate().map(((idx, pos)) => {
            let last = idx == count - 1
            let body = [
              #if "name" in pos [
                #text(
                  size: 8pt,
                )[
                  #pos.name
                ]
              ]
              #h(1fr)
              #if "location" in pos [
                #if pos.location == product.name [
                  #pos.location
                  #icon("location-dot")
                ] else [
                  #pos.location
                  #icon("location-dot") \
                  #if pos.to == "Present" [
                    #icon("calendar")
                  ] else [
                    #icon("calendar-check")
                  ]
                  #text(
                    size: 6pt,
                    font: font_mono,
                  )[
                    #pos.from --- #pos.to
                  ]
                ]
              ]
              #pad(
                left:   4pt,
                right:  4pt,
              )[
                #if "description" in pos [
                  #for desc in pos.description [
                    - #desc
                  ]
                ]
              ]
              #v(4pt)
            ]

            timeline(body, last: last)

          }).flatten()
        )
      ]
    ]
    #extra
  ]
]

#let education-entry(edu) = [
  #cage[
    #text(
      weight: "bold",
      size: 9pt,
    )[
      #if edu.place.link != "" [
        #link(edu.place.link, edu.place.name)
      ] else [
        #edu.place.name
      ]
    ]
    #h(1fr)
    #text(size: 7pt)[
      #if edu.track != "" [
        #text(size: 8pt)[
          #edu.track
        ]
      ]
    ]
    #v(-3pt)
    #pad(
      left: 4pt,
      right: 4pt,
    )[
      #if edu.location != "" [
          // #icon("location-dot")
          #edu.location
          ---
        ]
        #edu.degree
        #if edu.major != "" [
          #edu.major
        ]
        #h(1fr)
        #text(
          size: 6pt,
          font: font_mono,
        )[
          #edu.from --- #edu.to
        ]
      // ] else [
      // ]
    ]

    // #pad(
    //   left: 4pt,
    //   right: 4pt,
    // )[
    //   #edu.degree
    //   #if edu.major != "" [
    //     #edu.major
    //   ]
    //   #h(1fr)
    //   #text(
    //     size: 6pt,
    //     font: font_mono,
    //   )[
    //     #edu.from --- #edu.to
    //   ]
    // ]

  ]
]

// }}}

// contact macro {{{
#let display-contact(item) = [
  #let content_font_size = 7pt
  #grid(
    columns: (1fr, 10fr),
    column-gutter: 2pt,
    [
      #box(
        outset: (x: 0pt, y: 1.0pt),
        inset: (x: 0pt, y: 0.0pt),
      )[
        #text(size: content_font_size + 1.0pt)[
          #icon(item.icon)
        ]
      ]
    ],
    [
      #let txt = text(
        size: content_font_size,
        font: font_mono,
        weight: "bold",
      )[
        #item.text
      ]
      #box(
        outset: (x: 0pt, y: 0.0pt),
        inset: (x: 0pt, y: 1.3pt),
      )[
        #if "link" in item {
          link(item.link, txt)
        } else {
          txt
        }
      ]
    ]
  )
  #v(-4pt)
]
// }}}


// progress bar skill set {{{
#let max_rating = 50
#let skill(name, rating) = {

  let done = false
  let i = 1
  h(2fr)
  while (not done){
    let colour = rgb("#c0c0c0")
    let strokeColor = rgb("#c0c0c0")
    let radiusValue = (left: 0em, right: 0em)

    if (i <= rating){
      colour = primary-colour
      strokeColor = primary-colour
    }

    if (i == 1) {
      radiusValue = (left: 2em, right: 0em)  
    } else if (i == max_rating) {
      radiusValue = (left: 0em, right: 2em) 
    }

    box(rect(
      height: 0.3em, 
      width: 1.5em, 
      stroke: strokeColor,
      fill: colour,
      radius: radiusValue
    ))

    if (max_rating == i){
      done = true
    }

    i += 1
  }

  [\ ]

}
// }}}

// main macro {{{
#let vantage(
  name: "",
  position: "",
  picture: (),
  color: (),
  links: (),
  tagline: [],
  leftSide,
  rightSide,
  breakSide,
  nextSide,
) = {
  set document(
    title: name + "'s CV",
    author: name,
  )
  set text(9.8pt, font: font_body)
  set page(
    margin: (x: 1.2cm, y: 1.2cm),
  )

  show heading.where(level: 1) : it => text(font: font_title, size: 16pt,[#{it.body} #v(10pt)])

  show heading.where(
    level: 2,
  ): it => text(
    font: font_title,
    fill: rgb(color.accent),
    [
      #{it.body}
      #v(-7pt)
      #line(length: 100%, stroke: 0.5pt + rgb(color.accent))
    ]
  )

  show heading.where(
    level: 3
  ): it => text(
    font: font_title,
    it.body
  )

  show heading.where(
    level: 4
  ): it => text(
    font: font_title,
    fill: primary-colour,
    it.body
  )

  if picture.enable == true [
    #grid(
      columns: (11fr, 3fr),
      column-gutter: 3em,
      [
        #text(font: font_title, size: 18pt, weight: "bold")[
          #name
        ]
        #h(1fr)
        #text(font: font_title, size: 15pt, weight: "medium")[
          #position
        ]
        #v(2pt)
        #v(5pt)
        #pad(
          left: 5pt,
          right: 5pt,
        )[
          #tagline.map(t => t).join(" ")
        ]
      ],
      [
        #image(picture.path)
      ]
    )
  ] else [
    #text(font: font_title, size: 18pt, weight: "bold", name)
    #v(-5pt)
    #text(font: font_title, size: 15pt, weight: "medium",[#position])
    #v(-3pt)
    #pad(
      left: 5pt,
      right: 5pt,
    )[
      #text(
        size: 9pt,
        tagline.map(t => t).join(" ")
      )
    ]
    #v(4pt)
  ]

  grid(
    columns: (7fr, 4fr),
    column-gutter: 2em,
    leftSide,
    rightSide,
  )
  v(2pt)

  breakSide
  v(2pt)
  nextSide

}
// }}}

