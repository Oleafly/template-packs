// Code block styles for presentations

// Professional code listing with caption and optional label
#let paper-code(code-block, caption: none, label: none) = {
  show raw.where(block: true): set text(font: ("New Computer Modern Mono", "Courier"), size: 8pt, fill: black)
  set raw(tab-size: 4)
  
  let framed = block(
    width: 100%,
    fill: luma(250),
    stroke: 0.8pt + black,
    radius: 0pt,
    inset: 8pt, // Reduced from 10pt
    {
      set block(spacing: 0pt)
      align(left)[#code-block]
    }
  )
  
  if caption != none {
    figure(
      framed,
      caption: caption,
      kind: "listing",
      supplement: [Listing]
    )
  } else {
    framed
  }
}

// Dark theme code block
#let code-dark(code) = {
  block(
    fill: rgb("#1e1e1e"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #set text(size: 9pt, font: "Courier New", fill: rgb("#d4d4d4"))
    #code
  ]
}

// Light theme code block
#let code-light(code) = {
  block(
    fill: rgb("#f5f5f5"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    #set text(size: 9pt, font: "Courier New", fill: black)
    #code
  ]
}

#let terminal-output(output-block, title: none) = {
  // Enforce light text for the dark terminal background
  show raw.where(block: true): set text(
    font: ("New Computer Modern Mono", "Courier"), 
    size: 8pt, 
    fill: luma(240) // Off-white/light gray text
  )
  set raw(tab-size: 4)

  block(
    width: 100%,
    fill: luma(30), // Very dark gray (almost black) background
    stroke: 0.8pt + black, // Sharp academic outer border
    radius: 0pt, // Zero rounding
    clip: true,
    {
      // Optional Header (e.g., to show the executed command)
      if title != none {
        block(
          width: 100%, 
          fill: luma(60), // Slightly lighter gray to distinguish the header
          inset: (x: 8pt, y: 6pt), 
          stroke: (bottom: 0.8pt + black)
        )[
          #align(left)[
            #text(
              font: ("New Computer Modern Mono", "Courier"), 
              weight: "bold", 
              size: 8pt, 
              fill: white
            )[> #title]
          ]
        ]
      }
      
      // Main Console Body
      block(width: 100%, inset: 8pt, { // Reduced from 10pt
        set block(spacing: 0pt) // Keep lines tightly packed
        align(left)[#output-block]
      })
    }
  )
}

// GitHub-style side-by-side diff with LaTeX typography
#let github-latex-diff(old-file: "", new-file: "", old-code: none, new-code: none) = {
  // Enforce LaTeX-style typography for the code blocks
  show raw.where(block: true): set text(font: ("New Computer Modern Mono", "Courier"), size: 8pt)
  
  // Set tab size, letting the markdown backticks handle the language syntax
  set raw(tab-size: 4)
  
  block(
    width: 100%,
    stroke: 0.8pt + black,
    radius: 2pt,
    clip: true,
    table(
      columns: (1fr, 1fr),
      stroke: none,
      align: left + top,
      fill: (col, row) => {
        if row == 0 {
          if col == 0 { rgb("#ffebe9") } else { rgb("#e6ffec") }
        } else {
          luma(245)
        }
      },
      
      // Header Row (Escaped - and + to prevent list formatting)
      table.cell(
        stroke: (bottom: 0.8pt + black, right: 0.8pt + black),
        inset: 8pt
      )[
        #text(font: ("New Computer Modern Mono", "Courier"), weight: "bold", size: 9pt)[\- #old-file]
      ],
      table.cell(
        stroke: (bottom: 0.8pt + black),
        inset: 8pt
      )[
        #text(font: ("New Computer Modern Mono", "Courier"), weight: "bold", size: 9pt)[\+ #new-file]
      ],
      
      // Code Row
      table.cell(stroke: (right: 0.8pt + black), inset: 8pt)[#old-code],
      table.cell(inset: 8pt)[#new-code]
    )
  )
}

// Unified diff viewer with automatic line-by-line coloring
#let unified-diff(file: "", diff-block: none) = {
  let raw-text = ""
  if type(diff-block) == str {
    raw-text = diff-block
  } else if diff-block != none and diff-block.has("text") {
    raw-text = diff-block.text
  } else {
    raw-text = "Error: Please pass a raw diff block."
  }
  
  // .trim() removes the invisible newlines at the start/end of markdown blocks
  let lines = raw-text.trim().split("\n")
  
  block(
    width: 100%,
    stroke: 0.8pt + black,
    radius: 2pt,
    clip: true,
    {
      if file != "" {
        block(
          width: 100%,
          fill: luma(245),
          inset: 6pt, // Reduced from 8pt
          stroke: (bottom: 0.8pt + black)
        )[
          #align(left)[
            #text(font: ("New Computer Modern Mono", "Courier"), weight: "bold", size: 8pt)[#file] // Reduced from 9pt
          ]
        ]
      }
      
      // Added inset: (top: 0pt, bottom: 6pt) to lock the top and pad the bottom
      block(
        width: 100%,
        fill: white,
        inset: (top: 0pt, bottom: 6pt), // Reduced from 8pt
        {
          set block(spacing: 0pt)
          align(left)[
            #for line in lines {
              let bg = white
              let text-fill = black
              
              if line.starts-with("+") {
                bg = rgb("#e6ffec")
              } else if line.starts-with("-") {
                bg = rgb("#ffebe9")
              } else if line.starts-with("@@") {
                bg = rgb("#f1f8ff")
                text-fill = rgb("#0969da")
              }
              
              block(
                width: 100%,
                fill: bg,
                inset: (x: 8pt, y: 1.2pt), // Reduced padding
                text(font: ("New Computer Modern Mono", "Courier"), size: 7.5pt, fill: text-fill)[#raw(line)] // Slightly smaller
              )
            }
          ]
        }
      )
    }
  )
}

// Code block with line numbers
#let code-with-lines(code, start: 1) = {
  block(
    fill: rgb("#f5f5f5"),
    inset: 10pt,
    radius: 0pt,
    stroke: 0.5pt + black,
  )[
    #set text(size: 9pt, font: "Courier New")
    #let lines = code.split("\n")
    #for (i, line) in lines.enumerate() [
      #text(fill: gray)[#(start + i)] #h(1em) #line\
    ]
  ]
}

// Inline code
#let inline-code(code) = {
  box(
    fill: rgb("#f0f0f0"),
    inset: (x: 4pt, y: 2pt),
    radius: 2pt,
  )[
    #text(size: 0.9em, font: "Courier New")[#code]
  ]
}
