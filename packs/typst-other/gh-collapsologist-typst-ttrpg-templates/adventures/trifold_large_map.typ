#import "templates/typography/scifi_compact.typ": typography, clue, hint

#show: typography

#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 2%, y: 4%),
)

#let title = "Trifold Adventure Template"

#let subtitle = [
  This template is for creating trifold adventure pamphlets quickly using
  barebones #highlight[Typst].
  
  The Typst website has a nice tutorial and a detailed reference.

  #hint[Typography] settings are in the "templates/typography" folder and are imported
  into this file.
]

#let author = "Author"

#let credits = [
  #place(
    bottom,
    float: true
  )[
    #line(length: 100%)
    #grid(
      columns: (1fr, 8fr),
      rows: 1,
      gutter: 8pt,
      align: left+horizon,
    )[
      #rect[Logo]
    ][
      #set text(style: "italic", size: 6pt)

      Credits, logos, licenses etc.

      Author: #author
    ]
  ]
]

// Content

#let page1 = [
  #text(
    size: 30pt,
    font: "BBH Sans Bogle",
    hyphenate: false,
    tracking: 2pt,
  )[
    #set align(center)
    #set par(spacing: 0.4em)
    #title
  ]

  #text(
    style: "italic",
  )[#subtitle]

  #rect(width: 100%, height: 40%)[
    Cover Art Placeholder

    To add an image, replace this block with `#image`.
  ]

  == Adventure Meta, Location Description....

  #lorem(40)

  #credits
]

#let page2 = [
  = General Context

  #clue[Page revealed when opening the front of the pamphlet.]

  #lorem(50)

  == What now?
  
  #lorem(20)
  
  == Sample Timeline of Events

  #table(
    columns: (auto, 1fr, 1fr),

    table.header([\#], [Stream 1], [Stream 2]),
    table.hline(),

    [Phase 1],
    table.vline(),
    [
      #lorem(15)
    ], 
    table.vline(),
    [
      #lorem(10)
    ],

    [Phase 2], 
    [
      #lorem(12)
    ], 
    [
      #lorem(8)
    ],

    [Phase 3],
    [
      #lorem(24)
    ], 
    [
      #lorem(32)
    ],
  )
]

#let page3 = [
  = Heading 1

  #lorem(20)

  == Heading 2

  #lorem(20)

  === Heading 3

  #lorem(20)

  ==== Heading 4

  #lorem(20)

  == H2
  Can be used inline
  == like so.

  === H3 
  too if you
  === want to

  == Layout Examples with Text Samples

  #hint[Bellow is a grid. Useful for producing
  unusual layouts. The pamphlet pages are actually laid out
  in a grid.]
  
  #grid(columns: 2, gutter: 8%)[
    *Numbered List:*

    + *Bold*
    + _italic_
    + #underline[Underlined]
    + #highlight[highlighted]
  ][
    *Bullets:*

    - `#hint` = #hint[Looks like this.]
    - `#clue` = #clue[Looks like this.]
  ]

  #rect(inset: 10pt, fill: black, height: 150pt)[
    #set text(fill: white)

    === Column Example
    Placed in a rectangular callout with custom styling.

    #line(stroke: white)

    #hint[Instead of grids you can use columns, but they offer less control.]
    
    #columns(2)[
      #lorem(20)

      #lorem(10)

      #lorem(10)
    ]
  ]
]

#let inner_section_top = [
= Location Info feat. Large Map

  #rect(width: 100%, height: 90%)[
    Map placeholder spanning two grid columns.

    The column and row ratios can be adjusted
    to alter the size of the section.
  ]
]

#let page4 = [
  #box[
    #grid(columns: (1fr, 2fr), gutter: 4%)[
      #rect(width: 100%, height: 50pt)[
        Placeholder.
      ]
    ][
      == Sublocation with minimap

      #hint[Example of grid being used to place
      a section of text next to and around
      an image. With some manual]
    ]
  ] #hint[text placement, text wrapping can be achieved.]

  #lorem(30)

  === 1 Numbered Location Sample
  _A short description of the location._

  - Dusty crates and cases: Some items.
  - Lockers: An item. #clue[An important item.]
  - Exits: Steep stairs to ceiling hatch (Some Location),
    Locked Door (Some Location),
    Airlock (Some Location).
]


#let page5 = [
  #lorem(45)

  #lorem(50)

  == Subsection

  #lorem(35)

  #lorem(50)
]

#let page6 = [
  = Back of the Pamphlet

  Nice location for clarifications, references
  or advice for running the module.

  = NPCs

  Compact inline NPC descriptions using numbered lists.

  + *Name (Affiliation)*: Description. _"Tasty quote."_
  + *Name (Affiliation)*: Description. _"Tasty quote."_
  + #clue[Name (Affiliation)]: Important NPC. Important because of #clue[this.] _"Tasty quote."_

  = Alternative Setups and Rules

  ...or general advice for running the module.

  + Leave some space between Sections.
  + Leave space between Content and Decor like Frames.
  + Come up with your own typographic language and use it consistently.
    Locations, NPC names, secrets, special items can all have a particular
    look.
  + Add creatures to the desert!

  #table(
    columns: (auto, 5fr),
    table.header(
      [*d6*], [*Sample Roll Table*]
    ),
    table.hline(),
    [1], [Thermal Paste],
    [2], [Reagent],
    [3], [Electronics Repair Kit],
    [5], [A weapon],
    [6], [1 day of food],
    table.hline(),
  )
]

// Layout Setup

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (100%),
  gutter: 4%,
)[
  #page2
][
  #page6
][
  #page1
]

#pagebreak()

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (1fr, 1fr),
  gutter: 4%,
  grid.cell(rowspan: 2)[
    #page3
  ],
  grid.cell(colspan: 2)[
    #inner_section_top
  ],
  grid.cell(colspan: 2)[
    #columns(2)[
      #page4
      #page5
    ]
  ]
)
