#let body-font = "New Computer Modern"
#let sans-font = "Libertinus Serif"
#let defaultTextSize = 12pt
#let linkColor = rgb("#013f7d") // Color for links such as references to chapters or bib entries

// Language specific settings
#let language = "de"              // Change to "en" for english
#let chapterString = "Kapitel"    // Change to "Chapter" for english

#let mainLayoutConfig(doc) = [
  #set page(
    margin: (left: 40mm, right: 35mm, top: 39mm, bottom: 39mm),
    number-align: center,
  )

  #set text(
    font: body-font,
    size: defaultTextSize,
    lang: language
  )

  // Set color of references
  #show ref: set text(linkColor)
  #show link: set text(fill: linkColor)

  // Change outline style
  #set outline.entry(
    fill: box(width: 1fr, repeat("." + h(2mm)))
  )

  #show outline: set text(font: body-font)

  // Set math equation formatting
  #show math.equation: set text(weight: 800)

  // --- Headings ---
  #show heading: set block(below: 2em, above: 2em)
  #show heading: set text(font: body-font, weight: "thin", tracking: 0.1em, size: 0.75em)
  #set heading(numbering: "1.1")
  // Make all headings upper case and start on new page
  #show heading: it => {
    if it.level == 1 { // Chapter heading
      set text(font: body-font, weight: "thin", tracking: 0.13em, size: 12pt)
      pagebreak()
      // Wrap in block (which is implicitly sticky for headings) to prevent orphan heading at end of page
      block(grid(
        rows: 2,
        row-gutter: 10pt,
        text(upper(it.body)),
        line(length: 100%, stroke: (0.5pt + black)),
      ))
    } else if it.level == 2 { // Section heading
      set text(font: body-font, weight: "semibold", size: 10pt)
      v(0.5em)
      // Wrap in block (which is implicitly sticky for headings) to prevent orphan heading at end of page
      block(
        text(upper(numbering(it.numbering, ..counter(heading).at(it.location())) + " " + it.body))
      )
    }
    else {
      set text(font: body-font, style: "italic", weight: "thin", size: 11pt)
      v(0.5em)
      // Wrap in block (which is implicitly sticky for headings) to prevent orphan heading at end of page
      block(
        text(upper(numbering(it.numbering, ..counter(heading).at(it.location())) + " " + it.body))
      )
    }
  }

  // Set big page number to the top of pages (aka. header) where a new chapter starts
  #set page(header-ascent: 30%)
  #set page(
    header: context {
      // Find first heading of level 1 on current page
      let heading-lvl-1 = query(heading.where(level: 1)).find(h => h.location().page() == here().page())
      if heading-lvl-1 != none {
        if heading-lvl-1.numbering != none {
          // If there is a level 1 heading (chapter heading) on this page, set the header
          let header-text = align(
            right,
            text(
              baseline: 15pt,
              size: 70pt,
              fill: luma(120),
              numbering(heading-lvl-1.numbering, ..counter(heading).at(heading-lvl-1.location())),
            ),
          )
          header-text
        }
      } else {
        // Else find the closest lvl-2 heading within the same chapter;
        // if there is none fall back to closest lvl-1 heading

        let heading-lvl-2-selector = heading.where(level: 2)

        // TODO: Remove once https://github.com/typst/typst/pull/5970 is available
        let first-or-none(array) = {
          if array.len() == 0 { none } else { array.first() }
        }
        let last-or-none(array) = {
          if array.len() == 0 { none } else { array.last() }
        }

        // If there is a previous lvl-1 heading, ensure the lvl-2 heading comes afterwards
        // (to avoid using unrelated lvl-2 heading if subsequent lvl-1 heading has no subheadings)
        let last-heading-lvl-1 = last-or-none(query(heading.where(level: 1).before(here())))
        if last-heading-lvl-1 != none {
          heading-lvl-2-selector = heading-lvl-2-selector.after(last-heading-lvl-1.location())
        }

        let current-page = here().page()

        // Get the first lvl-2 heading on the current page (if any)
        let heading-lvl-2 = first-or-none(
          query(heading-lvl-2-selector).filter(h => h.location().page() == current-page)
        )

        if heading-lvl-2 == none {
          // Look for the last lvl-2 heading before the current page
          heading-lvl-2 = last-or-none(
            query(heading-lvl-2-selector).filter(h => h.location().page() < current-page),
          )
        }

        let get-heading-text(h) = {
          let header-string = (
            numbering(h.numbering, ..counter(heading).at(h.location())) + " " + h.body
          )

          let header-text = align(
            right,
            text(size: 12pt, header-string),
          )
          header-text
        }

        if heading-lvl-2 != none and heading-lvl-2.numbering != none {
          get-heading-text(heading-lvl-2)
        } // Fall back to using lvl-1 heading if there is no lvl-2 heading
        else if last-heading-lvl-1 != none and last-heading-lvl-1.numbering != none {
          get-heading-text(last-heading-lvl-1)
        }
      }
    }
  )

  // Reference first-level headings as "chapters"
  #show ref: it => {
      let el = it.element
      if el != none and el.func() == heading and el.level == 1 {
        let targetLink = it.target
        let supplement = chapterString
        if it.citation != none and it.citation.supplement != none { // Custom supplement set
          supplement = it.citation.supplement
        }
        let linkText = supplement + " " + numbering(el.numbering,..counter(heading).at(el.location()))
        link(targetLink, linkText)
    } else {
      it
    }
  }

  // --- Paragraphs ---
  #set par(
    leading: 0.6em,
    justify: true,
    spacing: 1.5em
  )

  // --- Citations ---
  #set cite(style: "alphanumeric")

  // --- Figures ---
  #show figure: set text(size: 0.85em)

  // Change indent of lists globally
  #set list(body-indent: 5pt, indent: 15pt)
  #doc
]
