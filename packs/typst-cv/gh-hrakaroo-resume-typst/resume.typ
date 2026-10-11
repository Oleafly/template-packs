#let configuration = yaml("configuration.yaml")

#let lt_grey_colour = rgb("#979797")
#let grey_colour = rgb("#4b4b4b")

#set text(10pt, font: "Arial", fill: grey_colour)

#let sectionName(name) = {
  text(1.2em, tracking: 0.15em, [#upper(name)])
}

#let icon(name, shift: 1.5pt) = {
  box(
    baseline: shift,
    height: 10pt,
    image("icons/" + name + ".svg"),
  )
  h(3pt)
}

#let education(edu) = {
  text(0.9em, weight: "bold")[#edu.degree #h(1fr) #edu.year]
  linebreak()
  text(0.8em, weight: "medium")[#edu.major]
  linebreak()
  text(0.8em, weight: "medium")[#link(edu.place.link)[#edu.place.name]]
}

#let styled-link(dest, content) = emph(text(0.9em, link(dest, content)))

#let showContacts(contacts) = {
  let icon = icon.with(shift: 2.5pt)

  contacts
    .map(contact => {
      icon(contact.name)
      styled-link(contact.url, contact.displayText)
    })
    .join(v(0.5pt))
  [
  ]
}

#let headerName(name, position) = {
  align(center)[
    #text(28pt, fill: grey_colour, tracking: 0.15em, [#upper(name)]) \
    #v(2pt)
    #text(10pt, weight: "medium", fill: grey_colour, tracking: 0.1em, [#upper(position) #v(1pt)])
    #v(6pt)
    #line(length: 100%, stroke: 2pt + lt_grey_colour)
  ]
}

#let companySection(company) = {
  [
    #text(1.1em, weight: "bold")[#link(company.url)[#company.name]] \

    #if "positions" in company [
      #for position in company.positions [
        // Position title and dates
        #grid(
          columns: (1fr, auto),
          [#position.title], [#text(0.9em, style: "italic")[#position.from - #position.to]],
        )

        #block(inset: (left: 2em))[
          #text(0.9em, style: "italic")[#position.description]
        ]
        #if "accomplishments" in position.keys() [
          #block()[
            #set text(0.9em)
            #for bullet in position.accomplishments [
              #list(indent: 1em)[#bullet]
            ]
          ]
        ]
        #v(0.5em)  // Space between positions
      ]
    ]

    #v(1em)  // Space between companies
  ]
}

#let side-bar = [
  #sectionName("Contact") \
  #v(1pt)
  #showContacts(configuration.contacts)

  #line(length: 100%, stroke: 0.5pt + lt_grey_colour)

  #for sidebar in configuration.sidebars [
    #if "name" in sidebar.keys() [
      #sectionName(sidebar.name) \
      #v(1pt)
      #for coaching in sidebar.entries [
        #text(8pt)[#coaching]
        #v(1.5pt)
      ]
    ]
    #line(length: 100%, stroke: 0.5pt + lt_grey_colour)
  ]

  #sectionName("Education") \
  #v(1pt)
  #for edu in configuration.education [
    #education(edu)
    #v(1.5pt)
  ]

  #if "languages" in configuration.keys() [
    #line(length: 100%, stroke: 0.5pt + lt_grey_colour)
    #sectionName("Languages")

    #for language in configuration.languages [
      #text(8pt)[#language.name #h(1fr) (#language.level)]
      #v(1.5pt)
    ]
  ]
]

// Find the index of the pagebreak marker
#let pagebreak_index = configuration.employment.position(e => e.name == "pagebreak")

// Split the employment array into two parts
#let first_page_employment = if pagebreak_index != none {
  configuration.employment.slice(0, pagebreak_index)
} else {
  configuration.employment
}

#let second_page_employment = if pagebreak_index != none {
  configuration.employment.slice(pagebreak_index + 1) // +1 to skip the pagebreak item
} else {
  () // empty array if no pagebreak found
}

#let body-content = [
  #sectionName("Experience") \
  #v(1pt)
  #for company in first_page_employment [
    #companySection(company)
  ]
]

#headerName(configuration.name, configuration.title)

#v(0pt)

// First page - two column layout
#grid(
  columns: (3fr, 7fr),
  column-gutter: 2em,
  [
    #side-bar
  ],
  [
    #body-content
  ],
)

#pagebreak()

#for company in second_page_employment [
  #companySection(company)
]

#if "sections" in configuration.keys() [
  #(
    configuration
      .sections
      .map(section => {
        [
          #line(length: 100%, stroke: 0.5pt + lt_grey_colour)
          #sectionName(section.name) \
          #v(1pt)
          #for entry in section.entries [
            #text(0.9em, weight: "bold")[
              #entry.title
              #if "detail" in entry.keys() [ #h(1fr) #entry.detail ]
            ]
            #linebreak()
            #let subtitle = if "url" in entry.keys() {
              link(entry.url)[#entry.subtitle]
            } else {
              entry.subtitle
            }
            #text(0.8em, weight: "medium")[#subtitle]
            #v(1.5pt)
          ]
        ]
      })
      .join()
  )
]
