= ACKNOWLEDGMENT

TO FILL — Write your acknowledgment. Thank university leadership,
  your advisor, company supervisor, project manager, and anyone else
  who supported you during the internship.

= #text(stroke: 0.03em + black)[មូលន័យសង្ខេប]

TO FILL — Write your Khmer abstract here.


= ABSTRACT

TO FILL — Write your English abstract here.


// DO NOT EDIT
= TABLE OF CONTENTS
#{
  show link: set text(fill: black)
  set par(
    justify: false,
    first-line-indent: 0pt,
  )
  
  set outline.entry(fill: repeat(box(width: 0.265em)[.]))
  
  show outline.entry: it => {
    let weight = "bold"

    block(
      width: 100%,
      inset: (
        top: 6pt,
        right: 0pt,
        bottom: 0pt,
        left: if it.level == 1 { 0pt } else { 12pt },
      ),
      text(
        size: 12pt,
        weight: weight,
        top-edge: 0.15em,
        {
          show regex("[\u{1780}-\u{17FF}]+"): set text(stroke: 0.03em + black, top-edge: 0.45em, bottom-edge: -0.365em)
            link(
            it.element.location(),
            if it.prefix() == none [
              #it.inner()
            ] else [
              #box(width: if it.level == 1 { 1.75em } else { 2.75em })[#it.prefix()] #it.inner()
            ],
          )
        },
      ),
    )
  }
  outline(title: none, depth: 3)
}

// DO NOT EDIT
= LIST OF FIGURES
#{
  set outline.entry(fill: repeat(box(width: 0.265em)[.]))
  show link: set text(fill: black)
  set text(font: "Times New Roman", size: 12pt, weight: "regular")
  show outline.entry: it => link(
    it.element.location(),
    it.indented([#it.prefix():], it.inner()),
  )
  outline(target: figure.where(kind: image), title: none)
}

// DO NOT EDIT
= LIST OF TABLES
#{
  set outline.entry(fill: repeat(box(width: 0.265em)[.]))
  show link: set text(fill: black)
  set text(font: "Times New Roman", size: 12pt, weight: "regular")
  show outline.entry: it => link(
    it.element.location(),
    it.indented([#it.prefix():], it.inner()),
  )
  outline(target: figure.where(kind: table), title: none)
}

= LIST OF ABBREVIATIONS
#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: (center, center),
  table.header([*Abbreviation*], [*Explanation*]),
  [IT], [Information Technology],
)
