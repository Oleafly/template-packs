#import "@preview/fontawesome:0.2.0": *



// const color
#let color-darknight = rgb("#131A28")
#let color-darkgray = rgb("#333333")
#let color-gray = rgb("#5d5d5d")
#let default-accent-color = rgb("#262F99")

// const icons
#let linkedin-icon = box(
  fa-icon("linkedin", fill: color-darknight, font: "Font Awesome 6 Brands"),
)
#let github-icon = box(
  fa-icon("github", fill: color-darknight, font: "Font Awesome 6 Brands"),
)
#let phone-icon = box(
  fa-icon("phone", font: "Font Awesome 6 Free Solid")
)
#let email-icon = box(
  fa-icon("envelope", fill: color-darknight),
)

#let github-link(github-path) = {
  align(alignment.horizon)[
    #fa-icon("github", font: "Font Awesome 6 Brands", fill: color-darkgray)
    #link(
      "https://github.com/" + github-path,
      github-path,
    )
  ] 
}

#let resume(
  author: (:),
  language: "en",
  accent-color: default-accent-color,
  colored-headers: true,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  body
) = {
  if type(accent-color) == "string" {
    accent-color = rgb(accent-color)
  }
  
  set document(
    author: author.firstname + " " + author.lastname,
    title: "resume",
  )

  set text(
    font: ("Source Sans Pro", "source Sans 3"),
    lang: language,
    size: 11pt,
    fill: color-darkgray,
    fallback: true,
  )

  let bottom-margin = 25mm
  let ratio = 2 / 3
  let top-ratio = 3 / 5

  set page(
    paper: "a4",
    margin: (left: bottom-margin * ratio, right: bottom-margin * ratio, top: bottom-margin * top-ratio, bottom: bottom-margin),
    footer: [
      #set text(
        fill: gray,
        size: 8pt,
      )
      #date
    ],
    footer-descent: 0pt,
  )

  show par: set block(
    above: 0.75em,
    below: 0.5em,
  )
  set par(justify: true)
  
  set heading(outlined: false)

  show heading.where(level: 1): it => [
    #set text(
      size: 17pt,
      weight: "bold",
    )
    #let color = if colored-headers {
      accent-color
    } else {
      color-darkgray
    }

    #block(
      above: 1.4em,
      below: 1.0em
    )[
      #text(fill: color)[#it.body.text]
      #box(width: 1fr, line(length: 100%, stroke: color-darkgray))
    ]    
  ]


  let name = {
    align(center)[
      #pad(bottom: 5pt)[
        #block[
          #set text(
            size: 32pt,
            style: "normal",
            weight: "bold"
          )
          #text()[#author.firstname]
          #text(fill: accent-color)[#author.lastname]
        ]
      ]
    ]
  }

  let address = {
    align(center)[
      #author.address
    ]
  }

  let contacts = {
    let separator = box(width: 5pt)
    
    align(center)[
      #block[
        #align(horizon)[
          #if author.phone != none [
            #phone-icon
            #box[#text(author.phone)]
            #separator
          ]
          #if author.email != none [
            #email-icon
            #box[#link("mailto:" + author.email)[#author.email]]
          ]
          #if author.github != none [
            #separator
            #github-icon
            #box[#link("https://github.com/" + author.github)[#author.github]]
          ]
          #if author.linkedin != none [
            #separator
            #linkedin-icon
            #box[
              #link("https://www.linkedin.com/in/" + author.linkedin)[#author.firstname #author.lastname]
            ]
          ]
        ]
      ]
    ]
  }

  name
  address
  contacts
  body
}

#let resume-entry(
  title: "",
  location: none,
  date: "",
  description: "",
  accent-color: default-accent-color,
) = {
  
  block(below: 0.8em, above: 1.5em)[
    #grid(
      columns: (4fr, 1fr),
      gutter: 6pt,
      align: (alignment.left, alignment.right),
      heading([
        #if location != none {
          title + text(weight: "regular", size: 11pt, ", " + location)
        } else {
          title
        }
        ], level: 2),
      date,
      description
    )
  ]
  
}

#let resume-item(body) = {
  set text(
    size: 10pt,
    style: "normal",
    weight: "light",
  )
  set par(leading: 0.50em)
  body
}
