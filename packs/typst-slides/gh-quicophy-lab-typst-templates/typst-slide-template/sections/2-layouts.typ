#import "../core/preamble.typ": *

= Layouts <sec-layouts>

// Basic slide with title and accent bar
#slide(title: "Basic Slide", color: col1)[
  A standard slide with a title, left accent bar, and section tag.

  - Use `= Section Name` to create sections
  - Use `color: colN` (col1–col6) to set accent colors
  - The section name appears in the top-right tag
]

// composer: splits slide into columns with proportional widths
#slide(title: "Multi-Column Layout", color: col1, composer: (2fr, 1fr))[
  *Main content column*

  The `composer` parameter creates multi-column layouts:

  - Simple syntax: `composer: (2fr, 1fr)`
  - Each `[...]` block = one column
  - Great for content + visuals

  #v(0.3cm)
  ```typst
  composer: (2fr, 1fr)
  ```
][
  *Side panel*

  #v(0.5cm)
  #rect(fill: gradient.linear(col1.lighten(60%), col1), width: 100%, height: 5cm, stroke: none, radius: 8pt)

  #v(0.5cm)
  Visualizations, diagrams, or supplementary info
]

// grid: fine-grained layout control
#slide(title: "Grid Layout", color: col1)[
  Use `grid` for precise control over spacing and alignment:

  #grid(
    columns: (2fr, 1fr, 1fr),
    column-gutter: 0.8cm,
    row-gutter: 0.5cm,
    [
      *Main content area*

      - Flexible column widths
      - Custom gutters
      - Mixed content types

      #v(0.3cm)
      #rect(
        fill: gradient.linear(col1.lighten(70%), col1.lighten(50%), angle: 45deg),
        width: 100%,
        height: 3cm,
        stroke: none,
        radius: 8pt,
      )
    ],
    [
      #align(center)[*Panel A*]
      #rect(
        fill: gradient.linear(col1.lighten(80%), col1.lighten(60%), angle: 90deg),
        width: 100%,
        height: 2cm,
        stroke: none,
        radius: 6pt,
      )
    ],
    [
      #align(center)[*Panel B*]
      #rect(
        fill: gradient.linear(col1.lighten(80%), col1.lighten(60%), angle: 90deg),
        width: 100%,
        height: 2cm,
        stroke: none,
        radius: 6pt,
      )
    ],
    // Second row
    grid.cell(colspan: 3)[
      #align(center)[
        #box-text([Cells can span multiple columns with `grid.cell(colspan: N)`], color: col1, width: 70%)
      ]
    ],
  )
]

// Figures with captions
#slide(title: "Figures & Images", color: col1)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1cm,
    [
      #set figure.caption(position: top)
      #figure(
        rect(
          fill: gradient.linear(col1.lighten(70%), col1.lighten(50%), angle: 45deg),
          width: 100%,
          height: 5cm,
          stroke: none,
          radius: 8pt,
        ),
        caption: [Caption above figure],
      )
    ],
    [
      #figure(
        rect(
          fill: gradient.linear(col1.lighten(70%), col1.lighten(50%), angle: 135deg),
          width: 100%,
          height: 5cm,
          stroke: none,
          radius: 8pt,
        ),
        caption: [Caption below with citation #cite-footnote(<knuthArtComputerProgramming1997>)],
      )
    ],
  )
]
