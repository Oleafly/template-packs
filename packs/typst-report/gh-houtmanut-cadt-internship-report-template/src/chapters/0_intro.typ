#import "../func/utils.typ": body-font, body-font-size, under-construction

#show raw: it => text(font: body-font, size: body-font-size, it.text)
#show outline.entry: it => {
  show text: set text(fill: black)
  it
}
#counter(page).update(1)

= ACKNOWLEDGEMENT
...

#[
  // write khmer text in this block
  #set text(lang: "km")
  = មូលន័យសង្ខេប

  ...

]

= ABSTRACT

...


= TABLE OF CONTENTS
#outline(
  title: none,
  indent: level => if level == 0 { 0in } else if level <= 2 { 0.125in } else {
    0.25in
  },
  depth: 3,
)

= LIST OF FIGURES
#outline(target: figure.where(kind: image), title: none)

= LIST OF TABLES
#outline(target: figure.where(kind: table), title: none)


= LIST OF ABBREVIATIONS

#table(
  columns: (1fr, 3fr),
  inset: 10pt,
  align: center,
  table.header(
    [*Abbreviation*], [*Explanation*],
    repeat: false,
  ),
  [CADT], [Cambodia Academy of Digital Technology],
)

= LIST OF APPENDICES
#outline(target: figure.where(kind: "appendix"), title: none)
