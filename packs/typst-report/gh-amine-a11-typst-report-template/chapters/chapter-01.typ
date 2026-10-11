#import "../config.typ": *
#import "../style.typ":heading_without_numbering,heading_without_numbering_smallcaps


#set page(footer: none)

#grid(
  columns:(1fr, 0.5fr, 1fr),
  align(center+horizon)[
    #rect(
      height: 2pt,
      width: 100%,
      fill: rgb(0, 0, 0, 1),
      stroke: 3pt+black,
    )
  ],
  align(center+horizon)[
    #heading_without_numbering("Chapter 1")
  ],
  align(center+horizon)[
    #rect(
      height: 2pt,
      width: 100%,
      fill: rgb(0, 0, 0, 1),
      stroke: 3pt+black,
    )
  ],
)

#block(
  width: 100%,
  stroke: (y: 1pt),
  inset: 1em,
  align(center)[
    #show heading.where(level: 1): it => [
      #set text(font: heading_font, size: 24pt, weight: "bold")
      #it.body
    ]
  = Company Context and Internship Overview
  ],
)
#show outline.entry.where(level: 2): it => link(
  it.element.location(),
  block(text[#it.prefix().text.split(".").at(1) #h(15pt) #it.inner()])
  // it.indented(it.prefix(), it.body())
)
#outline(
  title: [= Contents],
  target: selector(heading.where(level: 2)).after(<start-chap>).before(<end-chap>)
)

#set page(  footer: [
    #v(0.5em)  // Add space above footer
    #block(
      width: 100%,
      stroke: (top: 1pt),
      inset: (top: 0.8em, bottom: 0.3em),  // More internal padding
      context[
        #align(center)[
          #counter(page).display("1")
        ]
      ]
    )
    #v(0.2em)  // Add space below footer
  ])

#metadata("start-chapter") <start-chap>

#pagebreak()

#set page(
  header-ascent: header_ascent,    // Proper spacing from text
  footer-descent: footer_descent,  // Proper spacing from text  
  header: [
    #v(0.3em)  // Add space above header
    #block(
      width: 100%,
      stroke: (bottom: 1pt),
      inset: (bottom: 0.8em, top: 0.5em),  // More internal padding
      align(left)[
        #text(size: 12pt)[Chapter 1. Company Context and Internship Overview]
      ]
    )
    #v(0.4em)  // Add space below header
  ]
)
#heading_without_numbering_smallcaps("Introduction")

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit.

== Host Organization

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut.

=== Company Overview

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

#figure(
  image("../images/company_logo.png", width: 30%),
  caption: [company logo]
) <fig:company-logo>

== Internship Objectives

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut 

=== Heatmap Performance Optimization

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

=== Scoring System Configurability Extension
lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


#heading_without_numbering_smallcaps("Conclusion")

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit 

#metadata("end-chapter") <end-chap>
