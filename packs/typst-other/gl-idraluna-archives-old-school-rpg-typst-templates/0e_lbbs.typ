#let lbb(
  
  doc
  ) = {
  // Page setup
  set page(
    height: 8.5in,
    width: 5.5in,
    margin: (inside: 0.75in, outside: 0.75in, top: 0.5in, bottom: 0.75in)
  )
  set par(justify: true)

  // Font setup
  set text(
    font: "Jost",
    size: 9pt,
  )

  // Heading setup
  show heading.where(level: 1): it => [
    #text(font: "Rye", size: 24pt)[#it]
  ]

  show heading.where(level: 2): it => [
    #block()[ #text(weight: 700, size:10pt)[#upper(it.body+[:])]]
  ]

  show heading.where(level: 3): it => [  // level 3 headers are bold, inline text followed by a colon.
    #text(weight: 700, size:10pt)[#it.body:]
  ]

  // Table setup
  set table(stroke: none, align:left, gutter: 0em)
  set table.cell(inset: 3pt)
  show table.cell: it => {
    set text(size: 10pt) 
    set par(justify: false)
    if it.y==0 {
      set align(bottom)
      underline(strong(it))
    }else{it}
  }
  show table: it => {align(center)[#it]}

  // Display document
  doc
}

#show: lbb.with()

= 0e Sample

This template emulates the original version of the Dungeon Game. It uses Jost as a free alternative typeface to the original Futura. 

=== Note
For maximal verisimilitude, avoid using italics. 

== A Heading
#lorem(120)

=== Subheading
#lorem(35)

=== Another Subheading
#lorem(75)

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
  align: (left, center, center, center, center, center, center, center, center, center),
  [Undead], [Acol.], [Adept], [VP], [Vicar], [Curate], [Bishop], [Lama], [Patr.],
  [Skeleton], [7], [T], [T], [D], [D], [D], [D], [D],
  [Zombie], [9], [7], [T], [T], [D], [D], [D], [D],
  [Ghoul], [11], [9], [7], [T], [T], [D], [D], [D],
  [Wight], [-], [11], [9], [7], [T], [T], [D], [D],
  [Wraith], [-], [-], [11], [9], [7], [T], [T], [D],
  [Mummy], [-], [-], [-], [11], [9], [7], [T], [T],
  [Spectre], [-], [-], [-], [-], [11], [9], [7], [T],
  [Vampire], [-], [-], [-], [-], [-], [11], [9], [7]
)