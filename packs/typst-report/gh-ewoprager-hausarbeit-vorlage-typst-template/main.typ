// -----
// Preamble
// -----

#set document(title: "Placeholder title")

#set text(
  lang: "de",
  font: "Times",
  size: 11pt,
)

#set par(
  justify: true,
)

#show title: set align(center)

#let cover-page(
  matrikelnummer,
  prufungsausweisnummer,
  semester-year,
  task-setting-prof,
) = [

#v(1in)

Matrikelnummer: #matrikelnummer

Prüfungsausweisnummer: #prufungsausweisnummer

#v(2in)

#title()

#align(center)[
  #semester-year
  
  bei
  
  Prof. #task-setting-prof
]

#pagebreak()
]


// -----
// Cover page
// -----

#cover-page(
  [\<placehover\>],
  [\<placehover\>],
  [\<placehover\>],
  [\<placehover\>]
)


// -----
// Sachverhalt
// -----

#set page(numbering: "I", number-align: right)
#heading(numbering: none, outlined: false)[Sachverhalt]

// contents

// ...

#pagebreak()


// -----
// Inhaltsverzeichnis
// -----

#outline()

#pagebreak()


// -----
// Literaturverzeichnis
// -----

#heading(outlined: false)[Literaturverzeichnis]

// manual bibliography

#pagebreak()


// -----
// Gutachten section
// -----

// margins
#set page(margin: (
  right: 1.5cm,
  left: 7cm,
  top: 1.5cm,
  bottom: 1.5cm,
))

// heading numbering
#let custom-numbering(..args) = {
  assert(args.named().len() == 0, message: "Function `custom-numbering` does not accept named arguments.")
  let n = args.pos().len()
  if n == 1 {
    return []
  }
  if n > 7 {
    panic("Cannot nest headings beyond 7 layers.")
  }
  return numbering((
    "A.",
    "I.",
    "1.",
    "a)",
    i => numbering("a", i) + numbering("a)", i),
    "(1)",
  ).at(n - 2), args.pos().last())
}

#set heading(numbering: custom-numbering)
#show heading: set text(size: 12pt)

// page numbering
#set page(numbering: "1")
#counter(page).update(1)

// content

= Gutachten

== Level 2

=== Level 3

==== Level 4

===== Level 5

====== Level 6

======= Level 7

// Note: Can't go beyond 7 layers.
