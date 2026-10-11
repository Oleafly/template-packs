#import "simpleplus.typ": *

#show: simpleplus
#set document(title: "SimplePlus — Typst demonstration")

#title-slide(
  [SimplePlus Beamer Theme],
  subtitle: [Subtitle],
  date: [January 7, 2025],
)

#overview((
  (title: [First Section]),
  (title: [Second Section]),
))

#frame([Bullet Points])[
  - Lorem ipsum dolor sit amet, consectetur adipiscing elit
  - Aliquam blandit faucibus nisi, sit amet dapibus enim tempus eu
  - Nulla commodo, erat quis gravida posuere, elit lacus lobortis est, quis porttitor odio mauris at libero
  - Nam cursus est eget velit posuere pellentesque
  - Vestibulum faucibus velit a augue condimentum quis convallis nulla gravida
]

#frame([Blocks of Highlighted Text], vertical: top)[
  In this slide, some important text will be #alert[highlighted] because it's important. Please, don't abuse it.

  #v(-0.38mm)
  #standard-block([Block], [Sample text])
  #alert-block([Alertblock], [Sample text in red box])
  #example-block([Examples], [Sample text in green box. The title of the block is “Examples”.])
]

#frame([Multiple Columns])[
  #move(dx: -2.9pt)[#grid(
    columns: (1fr, 1fr),
    gutter: 12mm,
    [
      #pad(left: 3.3mm)[*Heading*]

      + Statement
      + Explanation
      + Example
    ],
    [Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lectus nisl, ultricies in feugiat rutrum, porttitor sit amet augue. Aliquam ut tortor mauris. Sed volutpat ante purus, quis accumsan dolor.],
  )]
]

#frame([Table])[
  #align(center)[#move(dy: 1.66pt)[
    #table(
      columns: (auto, auto, auto),
      stroke: none,
      inset: (x: 2.2mm, y: 1.065mm),
      table.hline(stroke: 0.8pt),
      table.cell(inset: (left: 2.2mm, right: 2.2mm, top: 1.4mm, bottom: 3.05mm))[*Treatments*],
      table.cell(inset: (left: 2.2mm, right: 2.2mm, top: 1.4mm, bottom: 3.05mm))[*Response 1*],
      table.cell(inset: (left: 2.2mm, right: 2.2mm, top: 1.4mm, bottom: 3.05mm))[*Response 2*],
      table.hline(stroke: 0.45pt),
      [Treatment 1], [0.0003262], [0.562],
      [Treatment 2], [0.0015681], [0.910],
      [Treatment 3], [0.0009271], [0.296],
      table.hline(stroke: 0.8pt),
    )
    #v(2mm)
    #move(dx: -1.08pt, dy: -6.88pt)[#text(size: 8.97pt)[#text(fill: dark-blue)[Table:] Table caption]]
  ]]
]

#frame([Theorem])[
  #theorem([Theorem (Mass–energy equivalence)], [$E = m c^2$])
]

#frame([Figure])[
  #move(dy: -4.93pt)[Uncomment the code on this slide to include your own image from the same directory as the template .typ file.]
]

#frame([Citation])[
  #move(dy: -3.8pt)[
    An example of the `\cite` command to cite within the presentation:

    #v(6.5pt)

    This statement requires citation [Smith, 2012].
  ]
]

#frame([References])[
  #set text(size: 8.97pt)
  #set par(leading: 0.755em)
  #move(dy: -2.28pt)[#pad(left: 2.8pt)[#grid(
    columns: (10pt, 1fr),
    gutter: 6.6pt,
    align: top,
    image("assets/reference.svg", width: 8pt),
    [
      #text(fill: dark-blue)[Smith, J. (2012).] \
      Title of the publication. \
      #text(fill: rgb("#607495"))[_Journal Name,_ 12(3):45–678.]
    ],
  )]]
]

#closing[The End]
