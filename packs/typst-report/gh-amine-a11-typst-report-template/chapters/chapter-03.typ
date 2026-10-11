#import "../config.typ": *
#import "../style.typ":heading_without_numbering,heading_without_numbering_smallcaps


#v(2.5cm)
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
    #heading_without_numbering("Chapter 3")
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
  = Extension of the Scoring System Configurability
  ],
)
#show outline.entry.where(level: 2): it => link(
  it.element.location(),
  block(text[#it.prefix().text.split(".").at(1) #h(15pt) #it.inner()])
  // it.indented(it.prefix(), it.body())
)
#outline(
  title: [= Contents],
  target: selector(heading.where(level: 2)).after(<start-chap3>).before(<end-chap3>)
)

#metadata("start-chapter3") <start-chap3>

#pagebreak()

#heading_without_numbering_smallcaps("Introduction")

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit

== lorem ipsum dolor sit amet, consectetur adipiscing elit.
lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

== lorem ipsum dolor sit amet, consectetur adipiscing elit.


=== lorem ipsum dolor sit amet.
loream ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

=== POI Selection and Ranking
lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

=== Traffic Density Configuration
lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

#heading_without_numbering_smallcaps("Conclusion")

lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

#metadata("end-chapter3") <end-chap3>
