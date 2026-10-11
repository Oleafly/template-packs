#let justified(lbody, rbody) = {
  block[
    #lbody
    #box(width: 1fr)[
      #align(right)[#rbody]
    ]
  ]
}

#let resume(author: (:), body) = {
  set document(
    author: author.name,
    title: "Resume",
  )
  
  set text(
    font: ("New Computer Modern"),
    lang: "en",
    size: 11pt,
    fill: rgb("#131A28"),
    fallback: false
  )

  set page(paper: "a4", margin: 0.25in)
  
  show par: set block(above: 0.1em, below: 0.1em)
  set par(justify: true)
  set heading(numbering: none, outlined: false)
  
  let name = {
    align(center)[
      #block[
        #set text(size: 16pt, style: "normal")
        #text(weight: "light")[#author.name]
      ]
    ]
  }

  let contacts = {
    set box(height: 13pt)
    set text(size: 11pt)
    let separator = box(width: 24pt)
    
    align(center)[
      #block[
        #align(horizon)[
          #box(image("assets/icons/phone.svg"))
          #box[#text(author.phone)]
          #separator
          #box(image("assets/icons/email.svg"))
          #box[#link("mailto:" + author.email)[#author.email]]
          #separator
          #box(image("assets/icons/linkedin.svg"))
          #box[#link("www.linkedin.com/in/" + author.linkedin)[#author.linkedin]]
        ]
      ]
    ] 
  }

  name
  contacts
  body
}

#let section(title) = {
  set text(size: 15pt)
  set block(above: 12pt, below: 9pt)
  set pad(rest: 0em)

  pad[
    #align(left)[
      #smallcaps[#title]
      #box(width: 1fr, line(length: 100%))
    ]
  ]
}

#let content(body) = {
  set text(size: 10pt, style: "normal", weight: "light")
  set par(leading: 0.65em)
  body
}

#let timeframe(body) = {
  set text(size: 11pt, weight: "light", style: "normal")
  body
}

#let organization(body) = {
  set text(size: 13pt, style: "normal", weight: "bold")
  set block(above: 14pt, below: 0pt)
  block[#body]
}

#let position(body) = {
  set text(size: 11pt, weight: "regular", ligatures: false)
  smallcaps[#body]
}

#let category(body) = {
  set text(size: 11pt, weight: "bold")
  body
}

#let role(
  title,
  daterange
) = {
  set block(above: 12pt, below: 0pt)

  block[
    #justified[#position[#title]][
      #timeframe[#daterange]
    ]
  ]
}

#let skills(name, items) = {

  set block(below: 0.1em)
  set pad(top: 5pt)
  
  pad[
    #grid(
      columns: (18fr, 82fr),
      gutter: 10pt,
      align(right)[
        #category[#name]
      ],
      align(left)[
        #set text(size: 11pt, style: "normal", weight: "light")
        #items.join(", ")
      ],
    )
  ]
}
