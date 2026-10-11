// ##############################################
// #                                            #
// #           DO NOT EDIT THIS CODE            #
// #       Instructions are in `main.typ`       #
// #                                            #
// #  ┌──────────────────────────────────────┐  #
// #  │   Unless you know what you are doing │  #
// #  │   and want to edit this template.    │  #
// #  └──────────────────────────────────────┘  #
// #                                            #
// ##############################################


// Define a dotted line element for visual separators
#let dots = line(length: 100%, stroke: (dash: "dotted"))

// Function: or-dots
// Displays italicized text if a value is provided.
// Otherwise, shows a dotted line placeholder.
#let or-dots(value) = if value != none {
  text(style: "italic", value)
} else {
  grid.cell(align: bottom, dots)
}

// Function: kv-or-dots
// Creates a key-value pair layout.
// If a value exists, it is displayed; otherwise, a dotted placeholder appears.
#let kv-or-dots(key, value: none) = box(grid(
  columns: (auto, 1fr),
  column-gutter: 4mm,
  key, or-dots(value),
))

// Function: corner-stroke-block
// Draws a rectangular block with an inset and a stroked border.
// Used to visually frame content blocks with a corner stroke effect.
#let corner-stroke-block(inset: 5pt, height: 2cm, size: 4pt, stroke: 1pt) = {
  block(
    stroke: stroke,
    width: 100%,
    height: height,
    block(
      fill: white,
      outset: (x: -size, y: size),
      height: height,
      block(
        fill: white,
        outset: (x: size, y: -size),
        width: 100%,
        height: height,
        inset: inset,
        none,
      ),
    ),
  )
}

// Function: studiengang
// Returns formatted study program and degree data if available.
#let studiengang(data) = if data.studiengang == none {
  none
} else [
  #data.studiengang
  #if data.abschluss != none [
    (#data.abschluss)
  ]
]

// Function: prüferIn-or-beisitzerIn
// Displays examiner or committee member names.
// Adds a footnote reference if provided.
#let prüferIn-or-beisitzerIn(person) = {
  if person.name == none {
    none
  } else {
    text(style: "italic", person.name)
    if person.verweis != none {
      footnote(numbering: "*", emph(person.verweis))
    }
  }
}

// Symbols for ballot representation
#let ballot = text(weight: "bold", sym.ballot)
#let ballot-check = text(weight: "bold", sym.ballot.cross)

// Symbol of writing hand
#let writing-hand = text(font: "DejaVu Sans", "✍")

// Formatting of a free-question
#let free-question(title, subtitle: none, body: none) = [
  #writing-hand #h(2mm)  #text(weight: "bold", title)

  #subtitle

  #text(style: "italic", body)
]

// Get german month in a hacky way, Typst does not yet have localization support for this
#let localize-month(month) = if month == 1 {
  "Januar"
} else if month == 2 {
  "Februar"
} else if month == 3 {
  "März"
} else if month == 4 {
  "April"
} else if month == 5 {
  "Mai"
} else if month == 6 {
  "Juni"
} else if month == 7 {
  "Juli"
} else if month == 8 {
  "August"
} else if month == 9 {
  "September"
} else if month == 10 {
  "Oktober"
} else if month == 11 {
  "November"
} else if month == 12 {
  "Dezember"
} else {
  none
}

#let localized-date(date) = [#date.day(). #localize-month(date.month()), #date.year()]
