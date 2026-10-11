#import "./../../metadata.typ": *

#let image_dir = "../../img/"

#let person_card(name, photo, mail: none) = [
  #align(left)[
    #box(
      width: 4cm,
      height: 6cm,
      stroke: 0.6pt + gray,
      inset: 0pt,
      image(image_dir + photo, width: 4cm, height: 6cm, fit: "cover"),
    )
  ]

  #v(0.4cm)

  #align(left)[#name]

  #if mail != none [
    #v(0.25cm)
    #align(left)[
      #link("mailto:" + mail)[#mail]
    ]
  ]
]

#v(1.2cm)

#heading(level: 2, outlined: false)[Projektteam]

#v(0.4cm)

#table(
  columns: meta.candidates.len(),
  column-gutter: 2.5cm,
  stroke: none,

  ..meta.candidates.map(c => person_card(
    c.name,
    c.photo,
    mail: c.mail,
  ))
)

#v(1.8cm)

#heading(level: 2, outlined: false)[Projektbetreuer]

#v(0.6cm)

#person_card(
  meta.supervisor.name,
  meta.supervisor.photo,
  mail: meta.supervisor.mail,
)
