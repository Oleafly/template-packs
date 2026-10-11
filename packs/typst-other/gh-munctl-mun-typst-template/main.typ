// MUN Resolution Template for Typst

#let munresolution(
  title: "Resolution Title",
  author: "Author Name",
  doc-number: "RES/000",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  session: "First session",
  agenda: "Agenda item 0",
  topic: "Topic of resolution",
  res-number: "00/000",
  committee: "CommitteeName",
  body,
) = {
  // Set document properties
  set document(title: title, author: author)

  // Page setup
  set page(
    paper: "a4",
    margin: 1in,
    header: context [
      #if counter(page).get().first() > 1 [
        #set text(size: 9pt, weight: "bold")
        MUN/#doc-number #h(1fr) #title
        #line(length: 100%, stroke: 0.4pt)
      ]
    ],
    footer: context [
      #set text(size: 10pt)
      #align(center)[#counter(page).display() / #counter(page).final().first()]
    ],
  )

  // Font and paragraph settings
  set text(font: "Times New Roman", size: 11pt)
  set par(justify: false, leading: 0.65em)

  // Header section
  grid(
    columns: (auto, 1fr, auto),
    align: (left, left, right),
    [#text(size: 12pt)[Model United Nations]], [], [#text(size: 17pt)[*MUN*]#text(size: 9pt)[/#doc-number]],
  )

  line(length: 100%, stroke: 0.4pt)
  v(0.5em)

  // Committee header with logo and date
  grid(
    columns: (15%, 1fr, auto),
    column-gutter: 0.5em,
    align: (left, left, right),
    [#image("placeholder.png", width: 100%)],
    [
      #v(0em)
      #text(size: 17pt, weight: "bold")[#committee]
    ],
    [
      #text(size: 9pt)[#date]
    ],
  )

  v(5em)
  line(length: 100%, stroke: 0.4pt)
  v(0.5em)

  // Session and agenda info
  [*#session*] + linebreak()
  agenda + linebreak()
  [*#topic*] + linebreak()

  v(1em)

  // Resolution heading (centered and indented)
  align(center)[
    #block(width: 80%)[
      #set align(left)
      #text(size: 13pt, weight: "bold")[Resolution adopted by the #committee]
      #linebreak()
      #text(size: 13pt, weight: "bold")[on #date]
      #linebreak()

      #v(1em)

      #text(size: 13pt, weight: "bold")[#res-number. #title;]
      #linebreak()
      Submitted by: #author
      #linebreak()

      #v(2em)

      The #committee,

      #v(1em)
    ]
  ]

  // Body content (clauses)
  block(width: 100%, inset: (left: 10%, right: 10%))[
    #body
  ]
}

// Preambulatory clause
#let preambclause(phrase, content) = [
  #set par(hanging-indent: 2em)
  _#upper(phrase.slice(0, 1))#phrase.slice(1)_ #content,
]

// Operative clause (with semicolon)
#let operativeclause(phrase, content) = enum.item([
  #set par(hanging-indent: 2em)
  _#upper(phrase.slice(0, 1))#phrase.slice(1)_ #content;
])

// Last operative clause (with period)
#let operativeclauselast(phrase, content) = enum.item([
  #set par(hanging-indent: 2em)
  _#upper(phrase.slice(0, 1))#phrase.slice(1)_ #content.
])

// End bar
#let UNendbar = align(center)[
  #v(1em)
  #line(length: 15%, stroke: 0.4pt)
]

// Dummy text function (replacement for blindtext)
#let blindtext = [Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.]

// ======= Example Usage =======

#show: munresolution.with(
  title: "Resolution on Something Very Important",
  author: "The World",
  topic: "Very Important Things",
  committee: "Committee on Important Things",
)

// Preambulatory clauses
#preambclause("Concerned by", blindtext)

#preambclause("Strongly convinced that", blindtext)

#v(1em)

// Operative clauses
#enum(
  tight: false,
  spacing: 0.8em,
  operativeclause("Urges", blindtext),
  operativeclauselast("Requests", blindtext),
)

#UNendbar
