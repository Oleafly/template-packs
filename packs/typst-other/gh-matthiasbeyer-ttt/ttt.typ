// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography
#let std-smallcaps = smallcaps
#let std-upper = upper

// Overwrite the default `smallcaps` and `upper` functions with increased spacing between
// characters. Default tracking is 0pt.
#let smallcaps(body) = std-smallcaps(text(tracking: 0.6pt, body))
#let upper(body) = std-upper(text(tracking: 0.6pt, body))

// Colors used across the template.
#let stroke-color = luma(200)
#let fill-color = luma(250)

// This function gets your whole document as its `body` and formats it as a simple
// non-fiction paper.
#let ttt(
  // The name of the author
  author: [Authors name],

  // The name of the class
  class: [Your class],

  // Author's name.
  subject: [The subject of today],

  // The paper size to use.
  paper-size: "a4",

  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: none,

  // Format in which the date will be displayed on cover page.
  // More info: https://typst.app/docs/reference/foundations/datetime/#format
  date-format: "[year]-[month]-[day]",

  // The result of a call to the `bibliography` function or `none`.
  // Example: bibliography("refs.bib")
  // More info: https://typst.app/docs/reference/model/bibliography/
  bibliography: none,

  // Whether to display a maroon circle next to external links.
  external-link-circle: true,

  // The content of your work.
  body,
) = {
  // Set the document's metadata.
  set document(title: class + [: ] + subject, author: author)

  // Set the body font.
  // Default is Linux Libertine at 11pt
  set text(font: ("Libertinus Serif", "Linux Libertine"), size: 12pt)

  // Set raw text font.
  // Default is Fira Mono at 8.8pt
  show raw: set text(font: ("Iosevka", "Fira Mono"), size: 9pt)

  // Configure page size and margins.
  set page(
    paper: paper-size,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )

  // Configure paragraph properties.
  // Default leading is 0.65em.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")
  // Default spacing is 1.2em.
  show par: set block(spacing: 1.35em)

  // Add vertical space after headings.
  show heading: it => {
    it
    v(3%, weak: true)
  }
  // Do not hyphenate headings.
  show heading: set text(hyphenate: false)

  // Show a small maroon circle next to external links.
  show link: it => {
    it
    // Workaround for ctheorems package so that its labels keep the default link styling.
    if external-link-circle and type(it.dest) != label  {
      sym.wj
      h(1.6pt)
      sym.wj
      super(box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + rgb("#993333"))))
    }
  }

  // Indent nested entires in the outline.
  set outline(indent: auto)

  // Configure heading numbering.
  set heading(numbering: "1.")

  // Configure page numbering and footer.
  set page(
    footer: context {
      // Get current page number.
      let i = counter(page).at(here()).first()
      align(center)[#h(1.75em) #i]
    },
  )

  // Configure equation numbering.
  set math.equation(numbering: "(1)")

  // Display inline code in a small box that retains the correct baseline.
  show raw.where(block: false): {
    box.with(
      fill: fill-color.darken(2%),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
    )
  }

  // Display block code with padding.
  show raw.where(block: true): block.with(
    inset: (x: 3pt),
  )

  // Break large tables across pages.
  show figure.where(kind: table): set block(breakable: true)
  set table(
    // Increase the table cell's padding
    inset: 7pt, // default is 5pt
    stroke: (0.5pt + stroke-color)
  )
  // Use smallcaps for table header row.
  show table.cell.where(y: 0): smallcaps

  set page(
    header-ascent: 0%,
    header: [
      #set rect(
        inset: (x: 5pt, y: 0pt),
        outset: (x: 0pt, y: 5pt),
        fill: rgb("e4e5ea"),
        width: 100%,
      )

      #grid(
        columns: (4fr, 5fr, 3fr),
        rows: (4fr, 5fr, 3fr),
        column-gutter: 10pt,

        rect[*Class*], rect[*Subject*], rect[#align(right)[*Date*]],

        rect[#class], rect[#subject], rect[#align(right)[#text(date.display(date-format))]],
      )
    ]
  )

  // Wrap `body` in curly braces so that it has its own context. This way show/set rules will only apply to body.
  {
    show heading.where(level: 1): it => {
      // If we start a new chapter, do so on a new page
      // ...except if we are on the first page
      if counter(page).at(here()).first() != 1 {
        pagebreak()
      }
      it
    }
    body
  }

  // Display bibliography.
  if bibliography != none {
    pagebreak()
    show std-bibliography: set text(0.85em)
    // Use default paragraph properties for bibliography.
    show std-bibliography: set par(leading: 0.65em, justify: false, linebreaks: auto)
    bibliography
  }
}

// This function formats its `body` (content) into a blockquote.
#let blockquote(body) = {
  block(
    width: 100%,
    fill: fill-color,
    inset: 1em,
    stroke: (y: 0.5pt + stroke-color),
    body
  )
}
