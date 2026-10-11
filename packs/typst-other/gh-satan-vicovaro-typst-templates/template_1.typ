// --- 1. CONFIGURATION (Do not change this often) ---
#let latex_report(
  title: "",
  author: "",
  date: datetime.today().display(),
  body
) = {
  set document(title: title, author: author)
  
  // Font: Prefers "New Computer Modern" (Standard LaTeX), falls back to Times
  set text(font: ("New Computer Modern", "Times New Roman"), size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em, first-line-indent: 1.5em)
  show par: set block(spacing: 0.65em)

  // Headings: Numbered and Bold
  set heading(numbering: "1.1")
  show heading: it => {
    set text(weight: "bold", fill: black)
    block(above: 2em, below: 1em, it)
  }

  // Page numbers at bottom center
  set page(
    footer: context align(center, counter(page).display("1"))
  )

  // Title Page
  page(numbering: none, footer: none)[
    #v(3fr)
    #align(center)[
      #text(size: 2em, weight: "bold", title) \
      #v(1.5em)
      #text(size: 1.2em, author) \
      #v(0.5em)
      #date
    ]
    #v(4fr)
  ]
  counter(page).update(1)

  body
}

// Custom formal note box
#let note(title: "Note", content) = {
  pad(y: 1em, block(
    fill: luma(250), stroke: 0.5pt + black, 
    inset: 1em, width: 100%, radius: 0pt, breakable: true,
    [*#title:* #content]
  ))
}

// --- 2. DOCUMENT CONTENT ---

#show: latex_report.with(
  title: "Matrices, Lists, and Figures",
  author: "Your Name",
  date: "October 2025"
)

= Lists and Points
Typst makes lists very intuitive. You do not need complex commands, just symbols.

== Bullet Points
Use a hyphen `-` for bullets. Indent for nested lists.
- This is the first point.
- This is the second point.
  - This is a sub-point (indented by 2 spaces).
  - Another sub-point.
- Back to the main level.

== Numbered Lists
Use a plus sign `+` for automatic numbering.
+ First step of the process.
+ Second step.
+ Third step.
  + You can nest numbered lists too.
  + It handles the hierarchy automatically (1, 2, a, b, etc.).

= Math Arrays and Matrices
We use the `mat` function inside math mode (`$ ... $`). You use commas `,` to separate columns and semi-colons `;` to separate rows.

== Standard Matrix
A standard 2x2 matrix:
$ A = mat(
  1, 2;
  3, 4
) $

== Vectors and Delimiters
You can change the delimiters (brackets, bars, etc.) using `delim:`.

$ v = mat(delim: "[", 1; 2; 3) $

A determinant (using bars):
$ det(M) = mat(delim: "|", a, b; c, d) = a d - b c $

= Figures and Images
In academic reports, images should be wrapped in a `#figure` so they can have a caption and be referenced later.

== Inserting an Image
// NOTE: Since I don't have your image files, I am drawing a rectangle 
// to simulate one. To use a real image, replace the 'rect(...)' part 
// with 'image("my-picture.png")'.

#figure(
  // REPLACE THIS LINE BELOW WITH: image("chart.png", width: 80%)
  rect(width: 80%, height: 150pt, fill: luma(240), stroke: 1pt + black)[
    #align(center + horizon)[*Image Placeholder*]
  ],
  caption: [This is a figure caption. Note how it is numbered automatically.]
) <structural-analysis>

As seen in @structural-analysis, the placeholder represents where your data visualization would go. Using the `@label` syntax lets you cross-reference figures easily.

= Complex Equation Example
Here is a complex equation combining arrays and sums:

$ sigma^2 = 1/(N-1) sum_(i=1)^N (x_i - mu)^2 $

And a system of equations using a case block:
$ f(x) = cases(
  x^2 "if" x > 0,
  0 "otherwise"
) $



#figure(
  table(
    // Define columns: 
    // 'auto' fits the text, '1fr' fills remaining space
    columns: (auto, 1fr, auto), 
    stroke: none, // Turn off the grid
    
    // Top thick line
    table.hline(stroke: 1.5pt),
    
    // Headers
    table.header(
      [*ID*], [*Experiment Description*], [*Result (Unit)*]
    ),
    
    // Middle thin line
    table.hline(stroke: 0.5pt),

    // 5 Rows of Data
    [001], [Initial baseline test under standard conditions], [0.45],
    [002], [Stress test with variable load], [1.20],
    [003], [Thermal expansion measurement], [0.99],
    [004], [Vibration analysis at 50Hz], [0.05],
    [005], [Final structural integrity check], [Pass],

    // Bottom thick line
    table.hline(stroke: 1.5pt),
  ),
  caption: [Summary of Experimental Results]
)

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    inset: 12pt,
    align: left, // Left align is often cleaner than center
    stroke: (x, y) => (
      bottom: 0.5pt + gray.lighten(50%) // Only horizontal dividers
    ),

    // Header Styling: Light gray background
    fill: (col, row) => if row == 0 { gray.lighten(90%) } else { none },

    table.header(
      [*Metric*], [*Observation*], [*Status*],
    ),

    [Alpha],   [Initial read ok],  [Pass],
    [Beta],    [Slight variance],  [Check],
    [Gamma],   [Heat nominal],     [Pass],
    [Delta],   [Pressure high],    [Warn],
    [Epsilon], [Stable],           [Pass],
  )
)

#figure(
  table(
    columns: 3,
    inset: 10pt,
    align: center,
    stroke: none, // No grid lines at all

    // Header: Dark Blue background
    // Rows: Zebra striping (White / Light Gray)
    fill: (col, row) => 
      if row == 0 { rgb("#1a2b42") } 
      else if calc.even(row) { rgb("#f2f2f2") } 
      else { white },

    table.header(
      text(white)[*Col A*], 
      text(white)[*Col B*], 
      text(white)[*Col C*]
    ),

    [Data 1], [Data 2], [Data 3],
    [Data 4], [Data 5], [Data 6],
    [Data 7], [Data 8], [Data 9],
    [Data 10], [Data 11], [Data 12],
    [Data 13], [Data 14], [Data 15],
  )
)

#figure(
  table(
    columns: (auto, 1fr, auto), // Columns resize to fit content
    inset: (y: 8pt, x: 4pt),    // More vertical breathing room
    align: horizon,
    stroke: (x, y) => if y == 1 { (top: 2pt + black) } else { none }, // One heavy line below header

    table.header(
      text(size: 12pt)[*ID*], 
      text(size: 12pt)[*Description*], 
      text(size: 12pt, fill: gray)[*Value*], // Gray header for the last column
    ),

    [001], [System check complete], [98%],
    [002], [Loading sequence],      [45%],
    [003], [Waiting for input],     [0%],
    [004], [Processing data],       [12%],
    [005], [Exporting results],     [100%],
  )
)
