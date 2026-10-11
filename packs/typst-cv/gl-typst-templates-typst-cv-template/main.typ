/*
  Created by Gwendal Debaussart - 2024
*/


#let resume(
  col : rgb("072AC8"),
  author :(:),
  profile-picture: none,
  about-me:[],
  education:(),
  experiences:(),
  papers:none,
  talks:none,
  languages:none,
  programming-languages:none,
  prices-grant:none,
  hobbies:none,
  show-footer : true,
  font : "Helvetica Neue",
  body
) = {
  set page(
    paper: "a4",
    margin: (
      left: 5mm,
      right: 5mm,
      top: 10mm,
      bottom: 10mm
    ),
    footer: if show-footer [#align(center)[❧]] else [],
  )
  set document(
      author: author.firstname + " " + author.lastname,
  )
  body
  set text(
    font: font,
    size:12pt,
    fill:col
  )

  set par(
    justify: true
  )

  grid(
    columns: (25%, 25%, 25%, 25%),
    rows:auto,
    inset: 1em,
    stroke: (x,y) => {
      if (x == 0 and y==0) {
      (right:col+1pt)
      }
    },
    grid.cell(rowspan:4)[
    #if profile-picture != none {
      block(
        clip: true,
        radius: 50pt,
        profile-picture
      )
    } else {
      square(width: 100%, fill:col)
    }
    #text(size: 1.75em)[#author.firstname \ #author.lastname] \
    #if ("nationality" in author) [#author.nationality Nationality \ ]
    Born: #author.birthdate

    #if ("address" in author) [
        #author.address
      ]
    ],
    grid.cell(colspan: 3, stroke: (bottom:1pt + col))[#text(size:2em)[About me]],
    [ #text(size:1.5em)[Languages \ ]
      #for el in languages [
        #el.lang (#el.level)\
      ]
    ],
    grid.cell(colspan:2)[
    #if programming-languages != none {
      text(size:1.5em)[Programming Languages \ ]
      for el in programming-languages [
        #el.lang \
      ]
    }
    ],
    grid.cell(colspan:3)[
    #if prices-grant != none {
      text(size:1.5em)[Prices & Grant \ ]
      for el in prices-grant [
        (#el.date) #el.name
        #if ("comments" in el) [-- #text(style:"italic")[#el.comments]] \
      ]
    }
  ],
    grid.cell(colspan:3, stroke:(top:1pt+col))[

    #text(size:1.5em)[Contacts]\
    #if ("mail"    in author) [Mail: #link("mailto:" + author.mail)[#author.mail] \ ]
    #if ("tel"     in author) [Tel.: #author.tel \ ]
    #if ("website" in author) [Website: #link("https://"+author.website)[#author.website] \ ]
    #if ("twitter" in author) [Twitter: #link("https://twitter.com/" + author.twitter)[\@#author.twitter] \ ]
    #if ("github"  in author) [Github: #link("https://github.com/" + author.github)[#author.github] \ ]
    #if ("gitlab"  in author) [Gitlab: #link("https://gitlab.com/" + author.gitlab)[#author.gitlab] \ ]
    #if ("scholar" in author) [
      #let fullname = str(author.firstname + " " + author.lastname)
      Scholar: #link("https://scholar.google.com/citations?user=" + author.scholar)[#fullname] \
    ]
    #if ("linkedin" in author) [LinkedIn: #link(author.linkedin)[#author.firstname #author.lastname] \ ]
    #if ("researchgate" in author) [Research Gate: #link("https://www.researchgate.net/profile/"+ author.researchgate)[#author.researchgate]]
  ],
  grid.cell(colspan:4, inset:(y: 0.5em), stroke: (bottom: 1pt + col, top: 1pt + col))[#text(size:2em)[Education]],
  ..for el in education {(
    grid.cell(colspan: 3,
      inset: {
        if el == education.last(){(bottom:1em)}
        else {(bottom:0em)}
      },
      stroke: (right:1pt +col))[
      #text(size:1.1em)[#el.degree] #if ("comments" in el) {text(size:0.9em, el.comments)} \ → #el.place
      ],
      [
        #el.startdate #if ("enddate" in el) {text[-- #el.enddate]}
      ])},
  grid.cell(colspan: 4, inset:(y: 0.5em), stroke: (y: 1pt + col))[#text(size:2em)[Experiences]],
  ..for el in experiences{(
    grid.cell(colspan:3,
    inset: {
        if el == experiences.last(){(bottom:1em)}
        else {(bottom:0em)}
      },
      stroke:(right: 1pt + col))[
        #text(size:1.1em)[#el.name] #if ("comments" in el) [#text(size:0.9em)[#el.comments]] \ → #el.place
        ],
    [
      #el.startdate #if ("enddate" in el) [-- #el.enddate]
    ]
  )},
  grid.cell(colspan: 4, inset:(y: 0.5em), stroke: (y: 1pt + col))[#text(size:2em)[Papers & Talks]],
  grid.cell(colspan:4)[
      #if papers == none and talks == none [
      Papers coming soon.
    ]
    #if papers != none {
      for el in papers [
        #el.authors,"#el.name". #text(style:"italic")[#el.journal], #el.date.
      ]
    }
    #if talks != none [
        #text(
          size:1.5em,
          [Talks\ ]
        )
      #for el in talks [
        (*#el.date*) "#el.name", #text(style:"italic")[#el.venue], #el.place.\
      ]
    ]
  ],
  )
}
