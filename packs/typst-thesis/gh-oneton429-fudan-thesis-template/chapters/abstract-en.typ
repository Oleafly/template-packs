#import "../utils.typ": font_size, font_type

#let keywords = ("Typst", "Bachelor's Degree", "Graduation Thesis", "Template", "Open-source Projects")

#pagebreak(weak: true)

#heading("ABSTRACT", numbering: none)

This is the English abstract section.

#linebreak()

#grid(
  columns: (6.46em, 1fr),
  text("Key words: ", font: "SimHei", size: font_size.小三), keywords.join(","),
)
