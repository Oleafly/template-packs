#let defaultStyling(body, heading_pagebreak: true) = {
  show math.equation: set text(weight: 400)

  set page(margin: 1in, numbering: "1", number-align: center)
  set text(font: "New Computer Modern")
  show raw: set text(font: "New Computer Modern Mono")
  show heading: set block(above: 1.4em, below: 1em)

  show heading.where(level: 1): it => {
    let pg = counter(page).at(it.location()).first()

    if heading_pagebreak and pg > 1 {
      pagebreak(weak: true)
    }

    it
  }

  set heading(numbering: none)

  set par(leading: 0.75em, spacing: 1.00em, first-line-indent: 0em, justify: true)

  set enum(indent: 2em, numbering: "(a)", spacing: 1.3em)
  set list(indent: 2em, spacing: 1.3em)

  show raw.where(block: false): box.with(
    fill: luma(225),
    outset: (x: 2pt, y: 2pt),
    radius: 3pt,
    stroke: (0.5pt + luma(190))
  )

  show raw.where(block: true): it => {
    // Extract the language, defaulting to none if not specified
    let lang = if it.has("lang") { it.lang } else { none }
    
    box(
      width: 100%,
      fill: luma(225),
      // Switch from 'outset' to 'inset' so the padding is inside the box.
      // This ensures the label sits nicely inside the gray background.
      inset: 4pt,
      radius: 3pt,
      stroke: (0.5pt + luma(190)),
      {
        // Place the language label at the Top Right
        if lang != none {
          place(
            top + right, 
            box(
              fill: luma(125),
              inset: 3pt, 
              radius: 3pt,
              stroke: (0.5pt + luma(190)),
              text(fill: luma(255), size: 8pt, weight: "bold", lang)
            )
          )
        }
        
        // Display the actual code
        it
      }
    )
  }
  set table(stroke: 0.5pt)
  set table.vline(stroke: 0.5pt)
  set table.hline(stroke: 0.5pt)

  body
}

#let generic(date: none, title: none, subtitle: none, title_extra: none, heading_pagebreak: true, body) = {
  let author = "Matti Fischbach"
  let email = "matti.fischbach@web.de"
  let title = title + " " + title_extra

  set document(author: author, title: title)

  show: defaultStyling.with(heading_pagebreak: heading_pagebreak)

  // Title row.
  align(center)[
    #block(text(weight: 500, 1.55em, title))
    #block(text(weight: 500, 1em, subtitle))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: 1fr,
      gutter: 1em,
      align(center)[
        #author \
        #email
      ]
    ),
  )


  body
}

#let badge(content) = {
  box(
    fill: luma(250),
    inset: 3pt, 
    radius: 3pt,
    stroke: (0.5pt + luma(190)),
    smallcaps(text(content, weight: "bold"))
  )
}

#let question(title: none, body) = {
  let header = []
  if title != none {
    header = [#title]
  }

  block(
    fill: luma(255),
    stroke: (0.5pt + luma(180)),
    inset: 6pt,
    radius: 4pt,
    width: 100%,
    {
      grid(
        column-gutter: 2%,
        columns: (80%, 18%),
        align: (left, right),
        [
          #text(header, weight: 700)
        ],
        [
          #badge("Question")
        ]
      )
      v(0.25em) // Spacing between header and body
      line(length: 100%, stroke: (0.5pt + luma(180)))
      body
    }
  )
  v(0.5em)
}

// 2. ANSWER: Text with floating badge in top-right
#let answer(title: none, body) = {
  let header = []
  if title != none {
    header = [#title]
  }

  block(
    stroke: (left: 0.5pt + luma(180)), // Thick left border
    inset: (left: 1em), // text padding away from border
    width: 100%,
    {
      grid(
        column-gutter: 2%,
        columns: (80%, 18%),
        align: (left, right),
        [
          #text(header, weight: 700)
        ],
        [
          #badge("Answer")
        ]
      )
      v(0.25em) // Spacing between header and body
      body
    }
  )
  v(0.5em)
}

// 3. PROOF: Text with floating badge + QED at bottom
#let proof(title: none, body) = {
  let header = []
  if title != none {
    header = [#title]
  }

  block(
    stroke: (left: 0.5pt + luma(180)), // Thick left border
    inset: (left: 1em), // text padding away from border
    width: 100%,
    {
      grid(
        column-gutter: 2%,
        columns: (80%, 18%),
        align: (left, right),
        [
          #text(weight: "bold", header)
        ],
        [
          #badge("Proof")
        ]
      )
      v(0.25em) // Spacing between header and body
      body

      // QED Symbol (flushed right)
      h(1fr) 
      $square$ 
    }
  )
  v(0.5em)
}
