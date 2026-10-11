= Glossar und Abkürzungsverzeichnis

#let glossary_entry(name, description) = {
  figure(
    [
      #grid(
        columns: (3fr, 8fr),
        gutter: 5mm,
        [
          #align(left, text(size: 12pt, [*#name*]))
        ],
        align(left, description),
      )
      #line(length: 100%, stroke: 0.5pt + rgb("#c4c4c4"))
    ],
    kind: "glossary_entry",
    supplement: name,
  )
}

#let outline_glossary() = [
  #glossary_entry("Beispiel", [
    Das ist ein Beispiel.
  ]) <bsp>
]

#outline_glossary()
