#import "@preview/sicons:15.13.0": *

#let resume(
  left-column-width: 25%,
  avatar-path: "misc/default.png",
  name: "Jane Doe",
  role: "The Good Worker",
  personal: none,
  town: none,
  color: none,
  social-size: 1em,
  contacts: (),
  socials: ()
) = {
  grid(
    columns: (left-column-width, 1fr),
    align(center)[
      #image(avatar-path, fit: "contain", width: 70%)
    ],
    [
      #grid(columns: (1fr, 25%))[
        #text(20pt, weight: "black")[#name] \
        #text(16pt)[#role] \
      ][
        #if socials.len() > 0 [
        #set align(right + horizon)
        #for pair in socials {
          if color != none {
            link(pair.at(1))[#link(pair.at(1))[#sicon(slug: pair.at(0), size: social-size, icon-color: color.to-hex())]]
          } else {
            box(inset: (x: 0.2em))[#link(pair.at(1))[#sicon(slug: pair.at(0), size: social-size)]]
          }
        }
      ]
      ]
      #if personal != none [
        #personal \
      ]
      #if contacts.len() > 0 [
        Contacts: 
        #for value in contacts.values() [
          #box(inset: (x: 0.5em), value)
        ] \
      ]
      // Social:
      #if town != none [
        Lives: #town \
      ]
    ],
  )
}

#let section(
  header: none,
  left-column-width: 25%,
  subsections: (),
  color: gray
) = {
  let unimportant(body) = [#text(color)[#body]]
  
  show heading.where(
    level: 1
  ): it => block(width: 100%)[
    #set text(13pt, weight: "regular", color)
    #stack(
      spacing: 0.2em,
      smallcaps(it.body),
      line(
        length: 100%,
        stroke: 1pt + color
      )
    )
  ]
  
  heading(level: 1, header)
  for subsection in subsections {
    grid(
      columns: (left-column-width, 1fr),
      block(width: 70%)[#unimportant(subsection.label)],
      [
        #if "title" in subsection and subsection.title != none {
          let string = text(weight: "bold", subsection.title)
          if "href" in subsection and subsection.href != none {
            string = link(subsection.href)[#string]
          }
          if "title-postfix" in subsection and subsection.title-postfix != none {
            string = string + [ (_#subsection.title-postfix _)]
          }
          string
          [ \ ]
        }
        #if "description" in subsection and  subsection.description != none {
          subsection.description
        }
      ]
    )
  }
}