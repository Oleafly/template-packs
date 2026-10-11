#set page(
  paper: "a4",
  margin: (x: 1.4cm, top: 1.2cm, bottom: 1.2cm),
)

#set text(
  font: ("Linux Libertine", "DejaVu Serif", "Times New Roman", "FreeSerif"),
  size: 9.5pt,
  lang: "pt",
)

#set par(
  justify: true,
  leading: 0.52em,
)

#let section_heading(title) = {
  v(6pt)
  text(size: 13pt, weight: "regular", tracking: 0.5pt)[#title]
  v(-3pt)
  line(length: 100%, stroke: 0.6pt + luma(80))
  v(2pt)
}

#let cv_item(
  title: "",
  subtitle: "",
  date: "",
  location: "",
  tech_stack: none,
  bullets: (),
) = {
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(weight: "bold", size: 10pt)[#title] \
        #text(style: "italic", size: 9pt, fill: luma(60))[#subtitle]
      ],
      [
        #text(weight: "regular", size: 9pt)[#date] \
        #text(style: "italic", size: 8.5pt, fill: luma(90))[#location]
      ]
    )
    #if bullets.len() > 0 {
      v(-2pt)
      list(
        marker: [•],
        spacing: 4.5pt,
        ..bullets.map(b => text(size: 9pt)[#b])
      )
    }
    #if tech_stack != none and tech_stack.len() > 0 {
      v(1pt)
      text(size: 8.8pt)[*Tech Stack:* #tech_stack.join(", ")]
    }
  ]
}

// Data injection will be provided via JSON/YAML or variables
