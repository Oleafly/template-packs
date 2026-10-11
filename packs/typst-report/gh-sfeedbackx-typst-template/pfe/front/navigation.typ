// ======================================================
// TABLE OF CONTENTS, FIGURES, TABLES & ABBREVIATIONS
// ======================================================

#set heading(numbering: "1.1.1")

#import "../abbreviations.typ": abbreviations
#let abbreviationsList = ()
#abbreviationsList.push(abbreviations)

#show outline: it => {
  show heading: set block(below: 2em)
  it
}

#show outline.entry.where(level: 1): set block(above: 1em, below: 1em)
#show outline.entry.where(level: 3): set block(above: 1em, below: 1em)

// --- Table of Contents ---
#outline(indent: 1.5em, title: [Table of Contents])
#pagebreak()

// --- List of Figures ---
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
#pagebreak()

// --- List of Tables ---
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)
#pagebreak()

// --- List of Abbreviations ---
#heading(level: 1, outlined: false, numbering: none)[List of Abbreviations]
#v(3em)

#for dic in abbreviationsList [
  #for (key, value) in dic [
    / #key: #value
  ]
]

#pagebreak()
