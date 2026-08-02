#let spacing = 25pt
#let huge = 30pt
#let text_size = 11pt
#let off_black = luma(20)

// Icons
// I do not recommend using these functions manually, as they are not meant to be.
// Use githubIcon, mailIcon or githubIconInline instead
// Both functions are easily customizized for different icons (e.g. twitter, linkedin, etc.)
// FIXME: scale, baseline and inset are very arbitrary - find a better way to do this
#let link_icon_left(path, address, name, scale: 10%) = box[
  #link(address)[
    #box(baseline: 25%, rect(fill: off_black, width: scale, inset: 2pt)[#image(path)])
    #name
  ]
]
#let link_icon_right(path, address, name, scale: 10%) = box[
  #link(address)[
    #name
    #box(baseline: 25%, rect(fill: off_black, width: scale, inset: 2pt)[#image(path)])
  ]
]
// Use the following functions to place a mail or github icon with some additional text, both of which are clickable links
#let githubIcon(address, name) = link_icon_right("icons/github.svg", address, name)
#let mailIcon(address, name) = link_icon_right("icons/mail.svg", address, name)
#let githubIconInline(address, name) = link_icon_left("icons/github.svg", address, name, scale : 7%)

// An entry in the CV - dates, type, location and description included
#let entry(from: "", to: "", type: "", location: "", body) = {
  block(height: auto, width: 100%)[
    #grid(
      columns: (20%, 80%),
      [
        #if from != "" { from } else { "    " }
        #if to != "" { text()[ -- #to] }
      ],
      [
        #grid(
          columns: (50%, 50%),
          [#text(weight: "bold")[#type]],
          [#text(weight: "bold")[#align(right)[#location]]]
        )
        #v(2pt)
        #body
      ]
    )
  ]
}

#let semibold(body) = text(weight: "semibold")[#body]

//
// project definition
//
#let project(
  firstname: "",
  lastname: "",
  github: ("", ""),
  mail: "",
  body
) = {
  set page(margin: spacing)
  set text(font: "Fira Code", fill : off_black, size: text_size, lang: "EN", region: "US")
  set list(marker: [>])

  // Override default section/header format
  show heading: txt => [
    #set text(fill: white, size: text_size, weight: "bold")
    #rect(fill: off_black)[#upper(txt.body)]
    #v(2pt)
  ]

  // Header left side - name in large letters
  box(width: 40%, height: (huge * 2) + text_size)[
    #rect(fill: off_black)[#text(white, size: huge, weight: "bold")[#upper(firstname)]]
    #v(-10pt)
    #rect(fill: off_black)[#text(white, size: huge, weight: "bold")[#upper(lastname)]]
  ]
  // Header right side - github and mail links
  box(width: 60%, height: (huge * 2) + text_size)[
    #align(horizon + right)[
      #block()[
          #githubIcon(github.at(0), github.at(1))\
          #mailIcon("mailto:" + mail, mail)
        ]
    ]
  ]
  body
}
