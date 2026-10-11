// ============================================================
// McKinsey-Standard Consulting Report Template
// Based on McKinsey Global Institute design language:
// - Bower (Georgia substitute) for headlines
// - McKinsey Sans (Helvetica Neue substitute) for body
// - Blue-dominant palette with neutral grays
// - Generous whitespace, strict grid, exhibit discipline
// ============================================================

// --- COLOR SYSTEM (McKinsey Blue palette) ---
#let mckinsey-blue = rgb("#005EB8")      // Primary brand blue
#let dark-blue = rgb("#003A70")          // Deep headings
#let navy = rgb("#16213E")               // Darkest (cover, dividers)
#let steel = rgb("#5E6B7A")              // Body-secondary, captions
#let silver = rgb("#A2AAAD")             // Chart axes, light borders
#let light-bg = rgb("#F5F5F5")           // Exhibit backgrounds
#let white = rgb("#FFFFFF")
#let highlight-blue = rgb("#0091DA")     // Accent for key data points
#let red-neg = rgb("#D63B2F")            // Negative/risk only
#let dark-text = rgb("#2D2D2D")          // Body text

// ============================================================
// DOCUMENT WRAPPER
// ============================================================
#let report(title: "", subtitle: "", author: "", date: "", body) = {
  set document(title: title, author: author)
  set page(paper: "us-letter", margin: (x: 1in, y: 0.9in),
    footer: context {
      if counter(page).get().first() > 1 {
        set text(8pt, fill: silver)
        h(1fr) + str(counter(page).get().first()) + h(1fr)
      }
    }
  )

  // --- GLOBAL TYPOGRAPHY ---
  set text(font: "Helvetica Neue", size: 10.5pt, fill: dark-text)
  set par(justify: true, leading: 0.75em, spacing: 1.2em)
  set heading(numbering: none)
  set list(indent: 0.8em, body-indent: 0.5em, spacing: 0.65em)
  set enum(indent: 0.8em, body-indent: 0.5em, spacing: 0.65em)

  // --- HEADING STYLES ---
  show heading.where(level: 1): it => {
    set text(font: "Georgia", size: 22pt, weight: "bold", fill: dark-blue)
    block(sticky: true, above: 1.2em, below: 0.6em, it.body)
  }
  show heading.where(level: 2): it => {
    set text(font: "Helvetica Neue", size: 13pt, weight: "bold", fill: dark-blue)
    block(sticky: true, above: 1.2em, below: 0.5em)[
      #it.body
      #v(0.25em)
      #line(length: 100%, stroke: 0.75pt + silver)
    ]
  }
  show heading.where(level: 3): it => {
    set text(font: "Helvetica Neue", size: 11pt, weight: "bold", fill: dark-blue)
    block(sticky: true, above: 1.2em, below: 0.5em, it.body)
  }

  // --- GLOBAL TABLE STYLING ---
  show table: set text(size: 9pt)
  set table(inset: (x: 10pt, y: 7pt))
  show table: set par(justify: false)

  // --- COVER PAGE (Modern MGI style — full-page with design bg) ---
  page(margin: (x: 0in, y: 0in), footer: none)[
    // Background image
    #place(top + left)[
      #image("images/cover-bg.png", width: 100%, height: 100%, fit: "cover")
    ]
    // Semi-transparent overlay for text readability
    #place(top + left)[
      #rect(width: 100%, height: 100%, fill: rgb("#16213E99"))
    ]
    #pad(x: 1.4in)[
      #v(2.2in)
      #line(length: 60pt, stroke: 2.5pt + mckinsey-blue)
      #v(0.5em)
      #text(font: "Georgia", size: 38pt, weight: "bold", fill: white)[#title]
      #v(0.8em)
      #text(font: "Helvetica Neue", size: 14pt, fill: rgb("#FFFFFFBB"))[#subtitle]
      #v(1fr)
      #line(length: 100%, stroke: 0.5pt + rgb("#FFFFFF22"))
      #v(0.6em)
      #grid(columns: (1fr, 1fr),
        text(size: 10pt, fill: rgb("#FFFFFFAA"))[#author],
        align(right)[#text(size: 10pt, fill: rgb("#FFFFFFAA"))[#date]]
      )
      #v(0.5em)
      #text(size: 7pt, fill: rgb("#FFFFFF55"), style: "italic")[
        Confidential. Prepared for internal strategy teams. The author accepts no liability for decisions made in reliance on this report.
      ]
      #v(0.8in)
    ]
  ]

  body
}

// ============================================================
// SECTION DIVIDER (full-page navy, centered with design accents)
// ============================================================
#let section-divider(number, title, subtitle) = {
  pagebreak(weak: true)
  page(margin: (x: 0in, y: 0in), footer: none)[
    // Background image with geometric pattern
    #place(top + left)[
      #image("images/section-bg.png", width: 100%, height: 100%, fit: "cover")
    ]
    // Semi-transparent navy overlay for text readability
    #place(top + left)[
      #rect(width: 100%, height: 100%, fill: rgb("#16213Ecc"))
    ]
    // Decorative large ghost number (background watermark)
    #place(center + horizon, dy: -60pt)[
      #text(size: 200pt, weight: "bold", fill: rgb("#FFFFFF08"))[#number]
    ]
    // Centered content block
    #align(center + horizon)[
      #block[
        // Top accent line
        #line(length: 60pt, stroke: 2.5pt + mckinsey-blue)
        #v(1.2em)
        // Title
        #text(font: "Georgia", size: 32pt, weight: "bold", fill: white)[#title]
        #v(0.8em)
        // Thin separator
        #line(length: 40pt, stroke: 0.75pt + rgb("#FFFFFF33"))
        #v(0.8em)
        // Subtitle
        #text(size: 11pt, fill: rgb("#FFFFFFAA"))[#subtitle]
      ]
    ]
  ]
}

// ============================================================
// KPI CARDS & GRID
// ============================================================
#let kpi-card(value, label, delta) = {
  rect(width: 100%, radius: 0pt,
    stroke: (bottom: 2.5pt + mckinsey-blue, rest: 0.5pt + rgb("#E0E0E0")),
    inset: 14pt, fill: white)[
    #set par(justify: false)
    #set text(hyphenate: false)
    #align(center)[
      #text(size: 26pt, weight: "bold", fill: dark-blue)[#value]
      #v(0.2em)
      #text(size: 7pt, weight: "bold", fill: steel, tracking: 0.5pt)[#upper(label)]
      #v(0.1em)
      #text(size: 7pt, fill: silver)[#delta]
    ]
  ]
}

#let kpi-grid(..cards) = {
  let items = cards.pos()
  block(breakable: false, above: 0.8em, below: 0.8em)[
    #grid(columns: items.len(), column-gutter: 14pt, ..items)
  ]
}

// ============================================================
// CALLOUT BOX (blue left-border, light bg)
// ============================================================
#let callout(body) = {
  block(breakable: false, above: 0.8em, below: 0.8em)[
    #rect(width: 100%, stroke: (left: 3pt + mckinsey-blue, rest: none),
      radius: 0pt, inset: (left: 18pt, rest: 14pt), fill: light-bg)[
      #set text(size: 9.5pt)
      #body
    ]
  ]
}

// ============================================================
// CHART EXHIBIT
// Blue rule above, title, chart, source below.
// Title comes from Typst, NOT from matplotlib.
// ============================================================
#let chart-exhibit(number, title, path, src, width: 92%) = {
  block(breakable: true, above: 0.8em, below: 0.8em)[
    #line(length: 100%, stroke: 1.5pt + mckinsey-blue)
    #v(0.3em)
    #if number != none {
      text(size: 9.5pt, weight: "bold", fill: dark-blue)[Exhibit #number]
      h(6pt)
      text(size: 9.5pt, fill: dark-text)[#title]
    } else {
      text(size: 9.5pt, weight: "bold", fill: dark-blue)[#title]
    }
    #v(0.3em)
    #image(path, width: width)
    #v(0.3em)
    #text(size: 7pt, style: "italic", fill: silver)[Source: #src]
  ]
}

// ============================================================
// TABLE EXHIBIT
// Blue rule above, title, table, source below.
// ============================================================
#let table-exhibit(number, title, src, body) = {
  block(breakable: true, above: 0.8em, below: 0.8em)[
    #line(length: 100%, stroke: 1.5pt + mckinsey-blue)
    #v(0.3em)
    #if number != none {
      text(size: 9.5pt, weight: "bold", fill: dark-blue)[Exhibit #number]
      h(6pt)
      text(size: 9.5pt, fill: dark-text)[#title]
    } else {
      text(size: 9.5pt, weight: "bold", fill: dark-blue)[#title]
    }
    #v(0.3em)
    #body
    #v(0.3em)
    #text(size: 7pt, style: "italic", fill: silver)[Source: #src]
  ]
}

// ============================================================
// HIGHLIGHT STAT (large featured number)
// ============================================================
#let highlight-stat(value, label) = {
  block(breakable: false, above: 0.8em, below: 0.8em)[
    #rect(width: 100%, radius: 0pt, inset: 18pt,
      fill: light-bg, stroke: (left: 3pt + mckinsey-blue, rest: none))[
      #text(size: 28pt, weight: "bold", fill: dark-blue)[#value]
      #v(0.15em)
      #text(size: 9.5pt, fill: steel)[#label]
    ]
  ]
}

// ============================================================
// TIMELINE ITEM (implementation roadmap)
// ============================================================
#let timeline-item(marker, title, desc) = {
  block(breakable: true, above: 0.2em, below: 0.2em)[
    #grid(columns: (90pt, 1fr), column-gutter: 20pt,
      align: (center + horizon, left + top),
      rect(radius: 0pt, fill: mckinsey-blue, width: 90pt, height: 32pt,
        inset: (x: 8pt, y: 7pt))[
        #align(center + horizon)[#text(size: 9pt, weight: "bold", fill: white)[#marker]]
      ],
      [
        #text(size: 10.5pt, weight: "bold", fill: dark-blue)[#title]
        #v(0.15em)
        #text(size: 9.5pt, fill: steel)[#desc]
      ]
    )
  ]
}

// ============================================================
// BACKWARD-COMPAT: Standalone exhibit/source
// ============================================================
#let exhibit(number, title) = {
  v(0.8em, weak: true)
  line(length: 100%, stroke: 1.5pt + mckinsey-blue)
  v(0.3em, weak: true)
  text(size: 9.5pt, weight: "bold", fill: dark-blue)[Exhibit #number]
  h(6pt)
  text(size: 9.5pt, fill: dark-text)[#title]
  v(0.3em, weak: true)
}

#let source(txt) = {
  v(0.2em, weak: true)
  text(size: 7pt, style: "italic", fill: silver)[Source: #txt]
  v(0.8em, weak: true)
}
