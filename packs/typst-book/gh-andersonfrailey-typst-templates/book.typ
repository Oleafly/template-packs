// =============================================================================
// TEXTBOOK TEMPLATE FOR TYPST
// =============================================================================
// This template provides comprehensive formatting for academic textbooks with
// professional front matter, numbered elements, glossary, index, and more.
// =============================================================================

// Import required packages
#import "@preview/glossarium:0.4.1": gls, glspl, make-glossary, print-glossary
#import "@preview/showybox:2.0.4": showybox

// =============================================================================
// GLOBAL STATE VARIABLES
// =============================================================================
// These states track various aspects of the document across chapters

// Track current chapter information for headers
#let chapter-name = state("chapter-name", none)
#let chapter-number = state("chapter-number", 0)
#let chapter-is-numbered = state("chapter-is-numbered", true)

// Track whether we're in front matter (roman numerals) or main matter (arabic)
#let in-front-matter = state("in-front-matter", true)

// Storage for glossary terms (definitions in boxes)
#let glossary-terms = state("glossary-terms", (:))

// Storage for index terms (highlighted key terms)
#let index-terms = state("index-terms", (:))

// =============================================================================
// MAIN TEMPLATE FUNCTION
// =============================================================================
#let book(
  // Basic book information
  title: "Book Title",
  author: "Author Name",
  institution: none,
  date: none,
  // Cover page options
  cover-image: none, // Pass image() here to use custom cover
  // Watermark options
  watermark: none, // Set to text string to enable watermark
  watermark-opacity: 0.1, // Very light grey
  // Style customization
  primary-color: rgb("#1f77b4"), // Used for chapter headings, links, etc.
  body-font: "New Computer Modern",
  heading-font: "New Computer Modern",
  // Document body
  body,
) = {
  // ===========================================================================
  // DOCUMENT METADATA
  // ===========================================================================
  set document(
    title: title,
    author: author,
  )

  // ===========================================================================
  // PAGE SETUP
  // ===========================================================================
  set page(
    paper: "us-letter",
    margin: (
      top: 1.5in,
      bottom: 1.5in,
      inside: 1.25in, // Larger inside margin for binding
      outside: 1in,
    ),

    // Page numbering - handled dynamically based on front/main matter
    numbering: none, // We'll set this manually
    number-align: bottom + center,

    // Headers - left page shows chapter, right page shows author
    header: context {
      // Don't show header on first page of each chapter
      let page-num = here().page()

      // Check if we're in front matter
      if in-front-matter.get() {
        return none
      }

      // Get chapter info
      let ch-name = chapter-name.get()
      let ch-num = chapter-number.get()

      // Only show header if we have a chapter set
      if ch-name != none {
        // Check if this is the first page of a chapter
        // (This is approximated by checking if heading appears on this page)
        let headings = query(selector(heading.where(level: 1)).after(here()))
        if (
          headings.len() > 0 and headings.first().location().page() == page-num
        ) {
          return none
        }

        set text(size: 10pt, style: "italic")

        // Alternate header based on page side
        if calc.odd(page-num) {
          // Right (odd) pages - show author
          grid(
            columns: 1fr,
            align(right, author),
          )
          line(length: 100%, stroke: 0.5pt)
        } else {
          // Left (even) pages - show chapter
          let is-numbered = chapter-is-numbered.get()
          grid(
            columns: 1fr,
            if is-numbered {
              align(left, [Chapter #ch-num: #ch-name])
            } else {
              align(left, [#ch-name])
            },
          )
          line(length: 100%, stroke: 0.5pt)
        }
      }
    },

    // Watermark - appears on all pages if enabled
    background: if watermark != none {
      rotate(
        300deg,
        text(
          size: 72pt,
          fill: rgb(128, 128, 128, watermark-opacity * 30),
          weight: "bold",
          watermark,
        ),
      )
    },
  )

  // ===========================================================================
  // TEXT FORMATTING
  // ===========================================================================
  set text(
    font: body-font,
    size: 11pt,
    lang: "en",
  )

  // Paragraph settings
  set par(
    justify: true,
    leading: 1.5em,
    spacing: 1.5em,
    first-line-indent: 1.8em,
  )

  // No indent after headings
  show heading: it => {
    it
    par(first-line-indent: 0em)[#text(size: 0pt)[#h(0pt)]]
  }

  // Remove () from citations by default
  show cite: set cite(form: "prose")

  // ===========================================================================
  // TABLE FORMATTING
  // ===========================================================================
  set table(stroke: none)

  // ===========================================================================
  // LIST AND ENUM FORMATTING
  // ===========================================================================
  set enum(indent: 2em)
  set list(indent: 2em)

  // ===========================================================================
  // HEADING STYLES
  // ===========================================================================
  set heading(numbering: "1.1")

  show heading: it => {
    set text(font: heading-font)
    it
  }

  // ===========================================================================
  // LINKS AND REFERENCES
  // ===========================================================================
  show link: set text(fill: primary-color)
  show ref: set text(fill: primary-color)

  // Display chapter references as "Chapter X" instead of "Section X"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      let num = counter(heading).at(el.location()).first()
      link(el.location())[Chapter #num]
    } else {
      it
    }
  }

  // ===========================================================================
  // FIGURE AND TABLE NUMBERING
  // ===========================================================================
  // Figures and tables are numbered by chapter (e.g., Figure 1.1, Table 2.3)

  set figure(
    numbering: num => {
      let ch = counter(heading).get().first()
      numbering("1.1", ch, num)
    },
  )

  // Reset figure counters at each chapter
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    it
  }

  // ===========================================================================
  // EQUATION NUMBERING
  // ===========================================================================
  // Equations numbered by chapter, only if they have a label (are referenced)

  set math.equation(
    numbering: num => {
      let ch = counter(heading).get().first()
      numbering("(1.1)", ch, num)
    },
  )

  // Reset equation counter at each chapter
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    it
  }

  // Only number equations that are referenced (have a label)
  show math.equation.where(block: true): it => {
    if it.has("label") {
      it
    } else {
      // Remove numbering for unlabeled equations
      set math.equation(numbering: none)
      it
    }
  }

  // ===========================================================================
  // COVER PAGE
  // ===========================================================================

  if cover-image != none {
    // Custom cover image takes full page
    page(
      margin: 0pt,
      cover-image,
    )
  } else {
    // Default text-based cover
    page(
      margin: 2in,
      header: none,
      footer: none,
    )[
      #v(1fr)

      #align(center)[
        #text(size: 2em, weight: "semibold")[
          #title
        ]

        #v(2em)

        #text(size: 1.5em)[
          #author
        ]

        #if institution != none {
          // v(1em)
          text(size: 1.5em)[
            #institution
          ]
        }
        #v(1em)
        #if date == none {
          text(
            size: 1.5em,
          )[Current Draft: #datetime.today().display("[month repr:long] [day], [year]")]
        } else {
          text(size: 1.5em)[Current Draft: #date]
        }
      ]

      #v(1fr)
    ]
  }

  // ===========================================================================
  // FRONT MATTER SETUP
  // ===========================================================================
  // Roman numeral page numbering for front matter

  set page(
    numbering: "i",
    number-align: bottom + center,
  )

  counter(page).update(1)

  // ===========================================================================
  // TABLE OF CONTENTS
  // ===========================================================================

  // Simple TOC with chapter numbers only
  page[
    #heading(outlined: false, numbering: none)[Contents]
    #v(1em)

    #show outline.entry.where(
      level: 1,
    ): it => {
      let loc = it.element.location()
      let pg = counter(page).at(loc).first()
      // Check if the heading is numbered (has a numbering property that isn't none)
      let is-numbered = it.element.numbering != none
      link(loc)[
        #if is-numbered [
          #strong[Chapter #counter(heading).at(loc).first() #it.element.body]
        ] else [
          #strong[#it.element.body]
        ]
        #box(width: 1fr, repeat[.])
        #pg
      ]
      v(0.5em)
    }

    // Only show level 1 headings (chapters)
    #outline(
      title: none,
      depth: 1,
    )
  ]

  // Detailed TOC with chapters and sections
  page[
    #heading(outlined: false, numbering: none)[Detailed Contents]
    #v(1em)

    #outline(
      title: none,
      depth: 2,
      indent: auto,
    )
  ]

  // ===========================================================================
  // MAIN MATTER SETUP
  // ===========================================================================

  // Switch to arabic numerals starting at 1
  in-front-matter.update(false)

  set page(
    numbering: "1",
    number-align: bottom + center,
  )

  counter(page).update(1)

  // Reset heading counter for chapters
  counter(heading).update(0)

  // Track whether level 1 headings are numbered (for headers and TOC)
  // This catches bibliography and other unnumbered headings added directly
  show heading.where(level: 1): it => {
    if it.numbering == none {
      chapter-is-numbered.update(false)
      chapter-name.update(it.body)
    }
    it
  }

  // ===========================================================================
  // MAIN DOCUMENT BODY
  // ===========================================================================

  body

  // ===========================================================================
  // BACK MATTER
  // ===========================================================================

  // Glossary of defined terms
  pagebreak()
  heading(outlined: false, numbering: none, level: 1)[Glossary]

  context {
    let terms = glossary-terms.final()
    if terms.keys().len() > 0 {
      // Sort terms alphabetically (case-insensitive)
      let sorted-pairs = terms.pairs().sorted(key: p => lower(p.first()))

      // Group by first letter
      let current-letter = none
      for (key, value) in sorted-pairs {
        let (display-term, definition) = value
        let first-letter = upper(key.first())

        // Show letter header when entering a new section
        if first-letter != current-letter {
          current-letter = first-letter
          v(0.8em)
          text(size: 14pt, weight: "bold")[#first-letter]
          v(0.3em)
          line(length: 100%, stroke: 0.5pt)
          v(0.3em)
        }

        [*#display-term*: #definition]
        parbreak()
      }
    } else {
      [No terms defined.]
    }
  }

  // Index of key terms
  pagebreak()
  heading(outlined: false, numbering: none, level: 1)[Index]

  context {
    let terms = index-terms.final()
    if terms.keys().len() > 0 {
      for (term, pages) in terms.pairs().sorted(key: p => p.first()) {
        let page-list = pages.sorted().dedup().map(p => str(p)).join(", ")
        [*#term*: #page-list]
        parbreak()
      }
    } else {
      [No index entries.]
    }
  }
}

// =============================================================================
// CUSTOM CHAPTER FUNCTION
// =============================================================================
// This function creates a chapter with automatic numbering and formatting
// Use this instead of regular headings for chapter-level divisions
// - title: The chapter title
// - label: Optional label for cross-referencing (e.g., "ch:intro" to use @ch:intro)
// - numbered: Whether to show "Chapter X" label (default: true)
// - label-above: Whether "Chapter X" appears above the title (default: true)
// - epigraph: Optional epigraph content (quote text)
// - epigraph-author: Optional author/speaker of the epigraph

#let chapter(
  title,
  label: none,
  numbered: true,
  label-above: true,
  epigraph: none,
  epigraph-author: none,
) = {
  pagebreak()

  if numbered {
    // Use a show rule to customize the heading display
    show heading.where(level: 1): it => {
      let ch-num = counter(heading).get().first()
      chapter-number.update(ch-num)
      chapter-name.update(title)
      chapter-is-numbered.update(true)

      set par(first-line-indent: 0em)

      if label-above {
        // "Chapter X" on its own line above the title
        align(left)[
          #text(size: 14pt, weight: "bold")[Chapter #ch-num]
        ]
        v(0.5em)
        align(left)[
          #text(size: 24pt, weight: "bold")[#title]
        ]
      } else {
        // "Chapter X: Title" on the same line
        align(left)[
          #text(size: 24pt, weight: "bold")[Chapter #ch-num: #title]
        ]
      }
    }

    // Create the heading (the show rule above controls display)
    // Attach label if provided
    if label != none {
      [#heading(level: 1, numbering: "1.")[#title]#label]
    } else {
      heading(level: 1, numbering: "1.")[#title]
    }
  } else {
    chapter-name.update(title)
    chapter-is-numbered.update(false)
    align(center)[
      #text(size: 24pt, weight: "bold")[#title]
    ]
    // Hidden heading for internal tracking only
    if label != none {
      [#heading(
          level: 1,
          numbering: none,
          outlined: false,
        )[#hide[#title]]#label]
    } else {
      heading(level: 1, numbering: none, outlined: false)[#hide[#title]]
    }
  }

  v(1em)

  // Add epigraph if provided
  if epigraph != none {
    align(right)[
      #block(width: 60%)[
        #set text(size: 10pt, style: "italic")
        #set par(justify: false)
        "#epigraph"
        #if epigraph-author != none {
          v(0.3em)
          align(right)[
            #text(style: "normal", size: 9pt)[— #epigraph-author]
          ]
        }
      ]
    ]
    v(1em)
  }
}

// =============================================================================
// EPIGRAPH FUNCTION
// =============================================================================
// Creates a formatted epigraph (quote) with optional attribution
// - quote: The quote text
// - author: Optional author/speaker name

#let epigraph(quote, author: none) = {
  align(right)[
    #block(width: 60%)[
      #set text(size: 10pt, style: "italic")
      #set par(justify: false)
      "#quote"
      #if author != none {
        v(0.3em)
        align(right)[
          #text(style: "normal", size: 9pt)[— #author]
        ]
      }
    ]
  ]
  v(1em)
}

// =============================================================================
// KEYWORD DEFINITION BOXES
// =============================================================================
// Creates a highlighted definition box and adds term to glossary

// #let define(term, definition) = {
//   // Add to glossary
//   glossary-terms.update(dict => {
//     dict.insert(term, definition)
//     dict
//   })

//   // Create definition box
//   // block(
//   //   fill: rgb("#f0f0f0"),
//   //   stroke: 1pt + rgb("#cccccc"),
//   //   radius: 4pt,
//   //   inset: 12pt,
//   //   width: 100%,
//   // )[
//   //   #text(weight: "bold", size: 11pt)[#term]
//   //   #v(0.3em)
//   //   #definition
//   // ]
//   showybox(
//     frame: (
//       border-color: orange.darken(50%),
//       title-color: orange.lighten(60%),
//       body-color: orange.lighten(80%),
//     ),
//     title-style: (
//       color: black,
//       weight: "bold",
//       align: left,
//     ),
//     shadow: (
//       offset: 3pt,
//     ),
//     title: term,
//     definition,
//   )
// }
//
// Helper function to extract plain text from content
#let content-to-string(content) = {
  if type(content) == str {
    content
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else {
    repr(content)
  }
}

#let define(term, definition) = [
  // Add to glossary - store both the string key and original term for display
  #glossary-terms.update(dict => {
    let key = content-to-string(term)
    // Store as (display_term, definition) tuple
    dict.insert(key, (term, definition))
    dict
  })
  #showybox(
    frame: (
      border-color: orange.darken(50%),
      title-color: orange.lighten(60%),
      body-color: orange.lighten(90%),
    ),
    title-style: (
      color: black,
      weight: "bold",
      align: left,
    ),
    shadow: (
      offset: 3pt,
    ),
    title: term,
    definition,
  )
]

// =============================================================================
// INDEX KEY TERMS
// =============================================================================
// Highlights a term and adds it to the index

#let keyterm(term) = {
  // Add current page to index
  context {
    let pg = here().page()
    let term-key = if type(term) == str { term } else { repr(term) }
    index-terms.update(dict => {
      if term-key in dict {
        dict.at(term-key).push(pg)
      } else {
        dict.insert(term-key, (pg,))
      }
      dict
    })
  }

  // Highlight the term
  text(weight: "bold", fill: rgb("#1f77b4"))[#term]
}

// =============================================================================
// UNNUMBERED SECTION
// =============================================================================
// Creates a section that doesn't appear in the detailed TOC

#let unnumbered-section(title) = {
  heading(level: 2, numbering: none, outlined: false)[#title]
}

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

// Reference a figure with proper formatting
#let figref(label) = {
  ref(label)
}

// Reference a table with proper formatting
#let tableref(label) = {
  ref(label)
}

// Reference an equation with proper formatting
#let eqref(label) = {
  ref(label)
}
