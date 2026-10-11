// Chart and metrics visualization components

// Academic bar chart with formal axes and Computer Modern font
#let academic-bar-chart(data: (), max-value: 100, chart-height: 120pt, bar-width: 40pt) = {
  align(center)[
    #grid(
      columns: 1,
      align: center,
      
      // Chart Area (Axis and Bars)
      block(
        stroke: (left: 1.2pt + black, bottom: 1.2pt + black), // L-shaped formal axis
        inset: (left: 16pt, bottom: 0pt, right: 16pt),
        grid(
          columns: data.len(),
          gutter: 32pt,
          align: bottom + center,
          ..data.map(d => {
            let value = d.at(1)
            let relative-h = (value / max-value) * chart-height
            [
              #text(size: 9pt, weight: "bold", font: "New Computer Modern")[#value]
              #v(4pt)
              #rect(width: bar-width, height: relative-h, fill: luma(230), stroke: 0.8pt + black)
            ]
          })
        )
      ),
      
      // X-Axis Labels Area
      block(
        inset: (left: 16pt, top: 8pt, right: 16pt),
        grid(
          columns: data.len(),
          gutter: 32pt,
          align: top + center,
          ..data.map(d => {
            let name = d.at(0)
            box(width: bar-width)[
              #set text(size: 9pt, font: "New Computer Modern")
              #align(center)[#name]
            ]
          })
        )
      )
    )
  ]
}

// Academic metric card with sharp borders and Computer Modern font
#let paper-metric(title: "", value: "", subtext: none) = {
  block(
    width: 100%,
    stroke: 0.8pt + black, // Sharp academic framing
    radius: 0pt, // Zero rounding
    inset: 8pt, // Reduced from 14pt
    fill: luma(250), // Standard LaTeX listing background
    align(center)[
      // Smallcaps-style Title
      #text(font: "New Computer Modern", weight: "bold", size: 0.75em)[#upper(title)]
      #v(1pt)
      
      // Prominent Value
      #text(font: "New Computer Modern", weight: "bold", size: 1.8em)[#value]
      
      // Optional Contextual Subtext
      #if subtext != none [
        #v(1pt)
        #line(length: 35%, stroke: 0.5pt + luma(180)) // Subtle separator
        #v(2pt)
        #text(font: "New Computer Modern", style: "italic", size: 0.75em)[#subtext]
      ]
    ]
  )
}

// Dashboard grid of metrics
#let metrics-dashboard(..metrics) = {
  let items = metrics.pos()
  let cols = calc.min(3, items.len())
  
  grid(
    columns: (1fr,) * cols,
    gutter: 1em,
    ..items
  )
}

// Academic progress bar with sharp borders and Computer Modern font
#let paper-progress(percentage: 0, label: none) = {
  // Clamp the percentage between 0 and 100 to prevent layout breaks
  let p = calc.max(0, calc.min(100, percentage))
  
  block(width: 100%)[
    // Header Row: Label on the left, Percentage on the right
    #if label != none [
      #grid(
        columns: (1fr, auto),
        align: (left, right),
        text(font: "New Computer Modern", size: 9pt, weight: "bold")[#label],
        text(font: "New Computer Modern", size: 9pt)[#p%]
      )
      #v(4pt, weak: true)
    ]
    
    // The Progress Bar Container
    #block(
      width: 100%,
      height: 12pt,
      stroke: 0.8pt + black, // Sharp academic outer border
      radius: 0pt, // Zero rounding
      clip: true,
      {
        // The Fill Indicator
        if p > 0 {
          rect(
            width: p * 1%,
            height: 100%,
            fill: luma(80), // Dense, dark gray ink-like fill
            stroke: none
          )
        }
      }
    )
  ]
}


// Professional academic table with booktabs-style rules
#let paper-table(columns: (), headers: (), ..cells) = {
  // Calculate the last row to apply the heavy bottom border
  let data-cells = cells.pos()
  let total-rows = int(data-cells.len() / columns.len())
  
  // Optional: Force a serif font for a more traditional academic look
  // set text(font: "New Computer Modern")
  
  table(
    columns: columns,
    // Apply the booktabs-style stroke rules
    stroke: (col, row) => (
      top: if row == 0 { 1.2pt + black } else { none },  // Heavy top rule
      bottom: if row == 0 { 0.6pt + black }              // Light mid rule under headers
               else if row == total-rows { 1.2pt + black } // Heavy bottom rule
               else { none },                             // No internal horizontal lines
      left: none,                                         // No vertical lines
      right: none,
    ),
    align: left + horizon,
    
    // Header Row
    ..headers.map(h => table.cell(inset: (x: 8pt, y: 10pt))[*#h*]),
    
    // Data Rows
    ..data-cells.map(c => table.cell(inset: (x: 8pt, y: 8pt))[#c])
  )
}

// Key-value pairs display
#let key-value-list(..pairs) = {
  let items = pairs.pos()
  
  table(
    columns: (auto, 1fr),
    stroke: none,
    row-gutter: 0.5em,
    ..items.map(pair => (
      [*#pair.at(0):*],
      [#pair.at(1)]
    )).flatten()
  )
}

// Academic status badge with sharp borders and Computer Modern font
#let paper-badge(status, type: "neutral") = {
  // Define pale, paper-safe background tints
  let bg = luma(245) // Default light gray
  if type == "success" { bg = rgb("#e6ffec") }   // Very pale green
  else if type == "error" { bg = rgb("#ffebe9") }     // Very pale red
  else if type == "warning" { bg = rgb("#fffbda") }   // Very pale yellow
  
  box(
    fill: bg,
    stroke: 0.8pt + black, // Sharp academic boundary
    inset: (x: 4pt, y: 2pt),
    outset: (y: 1.5pt), // Pushes the border out slightly so it doesn't clip tall letters
    baseline: 15%, // Aligns the badge vertically with the surrounding text
    radius: 0pt // Zero rounding
  )[
    #text(font: "New Computer Modern", size: 0.8em, weight: "bold")[#upper(status)]
  ]
}


// Timeline item with compact spacing
#let timeline-item(date, title, description) = {
  grid(
    columns: (20%, 1fr),
    gutter: 0.8em,
    [
      #align(right)[
        #text(size: 10pt, fill: gray, weight: "bold")[#date]
      ]
    ],
    [
      #text(size: 11pt, weight: "bold")[#title]
      #v(0.2em)
      #text(size: 10pt)[#description]
    ]
  )
  v(0.6em)
}

// Comparison table (before/after)
#let comparison-table(items) = {
  table(
    columns: (1fr, 1fr),
    stroke: 0.5pt + gray,
    fill: (x, y) => if y == 0 { rgb("#f0f0f0") } else { white },
    [*Before*], [*After*],
    ..items.map(item => (
      [#item.at(0)],
      [#item.at(1)]
    )).flatten()
  )
}
