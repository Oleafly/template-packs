// tufte-thesis.typ
// A Typst template inspired by Aaron Turon's thesis design
// Combines classicthesis and tufte-latex aesthetics

// =============================================================================
// COLOR PALETTE
// =============================================================================

#let thesis-blue = rgb("#4A6FA5")      // Muted blue for headings
#let thesis-maroon = rgb("#8B2332")    // Burgundy for accents/links
#let thesis-gray = luma(120)           // Gray for secondary elements
#let thesis-light-gray = luma(245)     // Light gray for code backgrounds

// =============================================================================
// SIDENOTE SYSTEM
// =============================================================================

#let sidenote-counter = counter("sidenote")

// Sidenote configuration
#let sidenote-width = 1.6in
#let margin-gap = 0.25in      // Gap between main text and margin content

#let sidenote(body) = {
  sidenote-counter.step()
  // Anchor (superscript number in text)
  box(context {
    let num = sidenote-counter.get().first()
    super(text(fill: thesis-maroon, size: 8pt, weight: "bold", str(num)))
  })
  // Place sidenote at fixed position from page right edge
  context {
    let num = sidenote-counter.get().first()
    // Get current position to calculate absolute x coordinate
    let here-pos = here().position()
    // Target: right margin starts at 5.5in from page left (1in left margin + 4.5in text)
    // Position sidenote at 5.6in from page left
    let target-x = 5.75in
    let offset = target-x - here-pos.x
    box(place(
      dx: offset,
      dy: 0pt,
      block(
        width: sidenote-width,
        text(
          size: 8pt,
          fill: thesis-gray,
          {
            super(text(fill: thesis-maroon, weight: "bold", str(num)))
            h(3pt)
            body
          },
        ),
      ),
    ))
  }
}

// Margin quote (for epigraphs in the margin)
#let margin-quote(body, attribution: none) = {
  context {
    let here-pos = here().position()
    let target-x = 5.75in
    let offset = target-x - here-pos.x
    box(place(
      dx: offset,
      dy: 0pt,
      block(
        width: sidenote-width,
        {
          set text(size: 9pt, style: "italic", fill: thesis-gray)
          set par(justify: false, leading: 0.5em)
          body
          if attribution != none {
            v(0.3em)
            text(style: "normal", size: 8pt)[— #attribution]
          }
        },
      ),
    ))
  }
}

// =============================================================================
// CHAPTER STYLING
// =============================================================================

// Large decorative chapter number
#let chapter-number(num) = {
  text(
    size: 72pt,
    fill: thesis-gray.lighten(40%),
    weight: "regular",
    font: "New Computer Modern",
    str(num),
  )
}

// Chapter title with large number and rule
#let chapter-heading(num, title) = {
  pagebreak(weak: true)
  v(1fr)

  // Large number
  align(left)[
    #chapter-number(num)
  ]

  v(0.5em)

  // Title with rule
  block(width: 100% - 2.5in)[
    #text(
      size: 18pt,
      style: "italic",
      weight: "regular",
      fill: black,
      title,
    )
    #v(0.3em)
    #line(length: 100%, stroke: 0.5pt + thesis-gray)
  ]

  v(2em)
}

// =============================================================================
// PART PAGE
// =============================================================================

#let part-page(num, title) = {
  pagebreak(weak: true)
  v(1fr)
  align(center)[
    #text(size: 14pt, weight: "regular")[Part #numbering("I", num)]
    #v(1em)
    #text(
      size: 12pt,
      fill: thesis-blue,
      tracking: 0.15em,
      upper(title),
    )
  ]
  v(1fr)
  // No trailing pagebreak - let the next content's pagebreak handle it
}

// =============================================================================
// EPIGRAPH / QUOTE PAGE
// =============================================================================

#let epigraph-page(quote, attribution) = {
  pagebreak(weak: true)
  v(1fr)
  align(center)[
    #block(width: 70%)[
      #set par(justify: false)
      #text(style: "italic", size: 11pt)[#quote]
      #v(1em)
      #text(size: 10pt)[— #attribution]
    ]
  ]
  v(1.5fr)
  // No trailing pagebreak - let the next content's pagebreak handle it
}

// Inline epigraph (at start of chapter)
#let epigraph(quote, attribution) = {
  block(
    width: 100% - 2.5in,
    inset: (left: 0pt, right: 0pt, top: 0pt, bottom: 1em),
    {
      set text(size: 10pt, style: "italic")
      set par(justify: false, leading: 0.5em)
      quote
      v(0.5em)
      text(style: "normal", size: 9pt)[— #attribution]
    },
  )
}

// =============================================================================
// DOCUMENT TEMPLATE
// =============================================================================

#let tufte-thesis(
  title: none,
  subtitle: none,
  author: none,
  date: none,
  abstract: none,
  body,
) = {
  // -------------------------------------------------------------------------
  // Document metadata
  // -------------------------------------------------------------------------
  set document(
    title: title,
    author: author,
  )

  // -------------------------------------------------------------------------
  // Page setup - Tufte-style wide right margin
  // -------------------------------------------------------------------------
  set page(
    paper: "us-letter",
    margin: (
      left: 1in,
      right: 3in, // Wide right margin for sidenotes
      top: 1in,
      bottom: 1in,
    ),
    numbering: "1",
    number-align: right + bottom,
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        set text(size: 9pt, fill: thesis-gray)
        h(1fr)
        if title != none { emph(title) }
      }
    },
  )

  // -------------------------------------------------------------------------
  // Typography
  // -------------------------------------------------------------------------
  set text(
    font: "New Computer Modern",
    size: 10pt, // Classic thesis size (reduced from 11pt)
    fill: black,
  )

  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 0em, // Tufte style: no first-line indent
    spacing: 0.65em,
  )

  // -------------------------------------------------------------------------
  // Heading styles
  // -------------------------------------------------------------------------

  // Disable hyphenation for all headings
  show heading: set text(hyphenate: false)

  // Level 1: Chapter - handled specially via chapter-heading function
  // For auto headings, use small caps blue
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    block(width: 100% - 2.5in)[
      #text(
        size: 12pt,
        fill: thesis-blue,
        tracking: 0.1em,
        weight: "regular",
        smallcaps(it.body),
      )
    ]
    v(1em)
  }

  // Level 2: Section - SMALL CAPS, muted blue
  show heading.where(level: 2): it => {
    v(1.2em)
    block(width: 100% - 2.5in)[
      #text(
        size: 10pt,
        fill: thesis-blue,
        tracking: 0.08em,
        weight: "regular",
        upper(it.body),
      )
    ]
    v(0.6em)
  }

  // Level 3: Subsection - Italic, regular case
  show heading.where(level: 3): it => {
    v(0.8em)
    block(width: 100% - 2.5in)[
      #text(
        size: 10pt,
        style: "italic",
        weight: "regular",
        it.body,
      )
    ]
    v(0.4em)
  }

  // Level 4+: Run-in style
  show heading.where(level: 4): it => {
    v(0.6em)
    text(weight: "bold", size: 9pt, it.body)
    h(0.5em)
  }

  // -------------------------------------------------------------------------
  // Code blocks
  // -------------------------------------------------------------------------
  show raw.where(block: true): it => {
    set text(size: 8pt) // Smaller for more content per line
    block(
      fill: thesis-light-gray,
      inset: 10pt,
      radius: 0pt,
      width: 100%, // Full text width to prevent soft-wrapping
      it,
    )
  }

  show raw.where(block: false): it => {
    box(
      fill: thesis-light-gray,
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      text(size: 9pt, it),
    )
  }

  // -------------------------------------------------------------------------
  // Links
  // -------------------------------------------------------------------------
  show link: it => {
    text(fill: thesis-maroon, it)
  }

  // -------------------------------------------------------------------------
  // Tables - classic style with header emphasis
  // -------------------------------------------------------------------------
  set table(
    stroke: none,
    inset: 8pt,
    align: left,
  )

  // Table styling - use full text width for better readability
  show table: it => {
    set text(size: 9pt, hyphenate: false)
    block(width: 100%, it)
  }

  // -------------------------------------------------------------------------
  // Figures
  // -------------------------------------------------------------------------
  show figure.caption: it => {
    set text(size: 9pt, fill: thesis-gray)
    it
  }

  // -------------------------------------------------------------------------
  // Lists
  // -------------------------------------------------------------------------
  set list(
    marker: text(fill: thesis-maroon)[•],
    indent: 1em,
    body-indent: 0.5em,
  )

  set enum(
    indent: 1em,
    body-indent: 0.5em,
  )

  // -------------------------------------------------------------------------
  // Outline / TOC styling
  // -------------------------------------------------------------------------

  // Use proper indentation for TOC
  set outline(indent: auto)
  set outline.entry(fill: repeat[.#h(4pt)])

  // Level 1 entries: small caps blue with spacing above
  show outline.entry.where(level: 1): it => {
    v(0.6em, weak: true)
    block[
      #link(it.element.location())[
        #text(fill: thesis-blue, weight: "regular")[#smallcaps(it.body())]
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Level 2 entries: normal text with indent
  show outline.entry.where(level: 2): it => {
    block(inset: (left: 1.5em))[
      #link(it.element.location())[
        #it.body()
        #box(width: 1fr, it.fill)
        #it.page()
      ]
    ]
  }

  // Level 3 entries: smaller text with more indent
  show outline.entry.where(level: 3): it => {
    block(inset: (left: 3em))[
      #link(it.element.location())[
        #text(size: 10pt)[#it.body()]
        #box(width: 1fr, it.fill)
        #text(size: 10pt)[#it.page()]
      ]
    ]
  }

  // -------------------------------------------------------------------------
  // Title page
  // -------------------------------------------------------------------------
  if title != none {
    v(2fr)

    align(center)[
      // Title
      #text(
        size: 24pt,
        fill: thesis-blue,
        tracking: 0.05em,
        weight: "regular",
        hyphenate: false,
      )[
        #upper(title)
      ]

      #if subtitle != none {
        v(0.5em)
        text(size: 12pt, fill: thesis-gray, style: "italic", subtitle)
      }

      #v(2em)

      // Decorative flourish
      #text(size: 24pt, fill: thesis-gray)[❧]

      #v(2em)

      // Author
      #if author != none {
        text(size: 12pt, author)
      }

      #v(0.5em)

      // Date
      #if date != none {
        text(size: 11pt, fill: thesis-gray, date)
      }
    ]

    v(3fr)

    // Abstract at bottom of title page
    if abstract != none {
      align(center)[
        #block(width: 80%)[
          #set text(size: 10pt)
          #set par(justify: true)
          #text(weight: "bold")[Abstract] — #abstract
        ]
      ]
    }

    v(1fr)
    pagebreak()
  }

  // -------------------------------------------------------------------------
  // Body content
  // -------------------------------------------------------------------------
  body
}

// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

// Horizontal rule
#let hrule() = {
  v(0.5em)
  line(length: 100% - 2.5in, stroke: 0.5pt + thesis-gray)
  v(0.5em)
}

// Acknowledgments list (name + epithet style)
#let acknowledgment(name, epithet) = {
  text(weight: "regular", name)
  [, ]
  text(style: "italic", epithet)
  [;]
  linebreak()
}

// Colophon
#let colophon(body) = {
  pagebreak()
  v(1fr)
  block(width: 100% - 2.5in)[
    #text(
      size: 9pt,
      fill: thesis-maroon,
      tracking: 0.1em,
      weight: "regular",
      upper[colophon],
    )
    #v(1em)
    #set text(size: 10pt)
    #body
  ]
}

// Dedication page
#let dedication(body) = {
  pagebreak(weak: true)
  v(1fr)
  align(center)[
    #set text(style: "italic", size: 11pt)
    #body
  ]
  v(1.5fr)
  // No trailing pagebreak - let the next content's pagebreak handle it
}

// =============================================================================
// TABLE STYLING HELPERS
// =============================================================================

// Classic table with top/bottom rules and header rule
#let classic-table(columns: auto, header: (), ..rows) = {
  let header-cells = header.map(h => table.cell(
    stroke: (bottom: 0.5pt + thesis-gray),
    inset: (bottom: 8pt),
    text(weight: "bold", size: 10pt, h),
  ))

  table(
    columns: columns,
    stroke: (
      top: 0.8pt + black,
      bottom: 0.8pt + black,
    ),
    inset: 8pt,
    ..header-cells,
    ..rows.pos().flatten(),
  )
}
