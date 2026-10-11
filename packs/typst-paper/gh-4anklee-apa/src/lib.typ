// APA 7th Edition Student Paper Template for Typst
// Based on Purdue OWL APA 7 Student Sample Paper guidelines

#let apa(
  // Title page information
  title: none,
  author: none,
  affiliation: none,
  course: none,
  instructor: none,
  due-date: none,

  // Optional settings
  running-head: none,
  abstract: none,
  keywords: (),

  // Font settings (APA allows Times New Roman, Calibri, Arial, etc.)
  font: "Times New Roman",
  font-size: 12pt,

  // Paper content
  body,
) = {
  // Validate required fields
  assert(title != none, message: "Title is required")
  assert(author != none, message: "Author is required")

  // Set document metadata
  set document(
    title: title,
    author: if type(author) == array { author.join(", ") } else { author },
  )

  // Running head text (must be provided for header to appear)
  let header-text = running-head

  // Page setup: 1-inch margins on all sides
  set page(
    paper: "us-letter",
    margin: 1in,
    header: context {
      if counter(page).get().first() > 1 or abstract != none {
        if header-text != none {
          grid(
            columns: (1fr, auto),
            align(left, header-text),
            align(right, counter(page).display()),
          )
        } else {
          align(right, counter(page).display())
        }
      }
    },
    header-ascent: 0.5in,
  )

  // Font and paragraph settings
  set text(
    font: font,
    size: font-size,
    lang: "en",
  )

  // Double-spacing throughout
  set par(
    leading: 2em,
    first-line-indent: 0.5in,
    justify: false,
  )

  // Block spacing
  show par: set block(spacing: 2em)

  // === TITLE PAGE ===
  {
    set par(first-line-indent: 0pt, leading: 2em)
    set align(center)

    // Title - bold, centered, positioned in upper third of page
    v(2in)

    text(weight: "bold", title)

    // Author name(s)
    v(2em, weak: true)
    if type(author) == array {
      author.join(", ")
    } else {
      author
    }

    // Affiliation (Department, University)
    if affiliation != none {
      v(2em, weak: true)
      affiliation
    }

    // Course number and name
    if course != none {
      v(2em, weak: true)
      course
    }

    // Instructor name
    if instructor != none {
      v(2em, weak: true)
      instructor
    }

    // Assignment due date
    if due-date != none {
      v(2em, weak: true)
      due-date
    }

    pagebreak()
  }

  // === ABSTRACT PAGE (if provided) ===
  if abstract != none {
    set par(first-line-indent: 0pt)

    align(center, text(weight: "bold", "Abstract"))
    v(2em, weak: true)

    set par(first-line-indent: 0.5in)
    abstract

    // Keywords (if provided)
    if keywords.len() > 0 {
      v(2em, weak: true)
      set par(first-line-indent: 0.5in)
      [#text(style: "italic", "Keywords:") #keywords.join(", ")]
    }

    pagebreak()
  }

  // === MAIN BODY ===
  // Repeat title at the start of the body (centered, bold)
  {
    set par(first-line-indent: 0pt)
    align(center, text(weight: "bold", title))
  }

  v(2em, weak: true)

  body
}

// === HEADING STYLES ===
// APA 7 has 5 levels of headings

// Level 1: Centered, Bold, Title Case
#let heading-1(content) = {
  set par(first-line-indent: 0pt)
  v(2em)
  align(center, text(weight: "bold", content))
  v(2em, weak: true)
}

// Level 2: Flush Left, Bold, Title Case
#let heading-2(content) = {
  set par(first-line-indent: 0pt)
  v(2em)
  text(weight: "bold", content)
  v(2em, weak: true)
}

// Level 3: Flush Left, Bold Italic, Title Case
#let heading-3(content) = {
  set par(first-line-indent: 0pt)
  v(2em)
  text(weight: "bold", style: "italic", content)
  v(2em, weak: true)
}

// Level 4: Indented, Bold, Title Case, Ending With a Period. Text begins on the same line.
#let heading-4(content) = {
  h(0.5in)
  text(weight: "bold", content + ".")
  h(0.5em)
}

// Level 5: Indented, Bold Italic, Title Case, Ending With a Period. Text begins on the same line.
#let heading-5(content) = {
  h(0.5in)
  text(weight: "bold", style: "italic", content + ".")
  h(0.5em)
}

// === REFERENCE PAGE ===
#let references(title: "References", body) = {
  pagebreak()
  set par(first-line-indent: 0pt)

  align(center, text(weight: "bold", title))
  v(2em, weak: true)

  // Hanging indent for references (0.5in)
  set par(hanging-indent: 0.5in)

  body
}

// === BLOCK QUOTE ===
// For quotes 40+ words: indented 0.5in from left margin, no quotation marks
#let block-quote(body) = {
  set par(first-line-indent: 0pt)
  v(2em)
  pad(left: 0.5in, body)
  v(2em)
}

// === FIGURE ===
// APA figure with caption below
#let apa-figure(
  content,
  caption: none,
  number: none,
  note: none,
) = {
  set par(first-line-indent: 0pt)
  v(2em)

  align(left)[
    #text(weight: "bold", "Figure " + str(number))

    #text(style: "italic", caption)

    #v(0.5em)
    #content

    #if note != none {
      v(0.5em)
      text(size: 10pt, style: "italic", "Note. " + note)
    }
  ]
  v(2em)
}

// === TABLE ===
// APA table with caption above
#let apa-table(
  content,
  caption: none,
  number: none,
  note: none,
) = {
  set par(first-line-indent: 0pt)
  v(2em)

  align(left)[
    #text(weight: "bold", "Table " + str(number))

    #text(style: "italic", caption)

    #v(0.5em)
    #content

    #if note != none {
      v(0.5em)
      text(size: 10pt, style: "italic", "Note. " + note)
    }
  ]
  v(2em)
}

// === APPENDIX ===
#let appendix(label: "A", title: none) = {
  pagebreak()
  set par(first-line-indent: 0pt)

  align(center)[
    #text(weight: "bold", "Appendix " + label)

    #if title != none {
      v(2em, weak: true)
      text(weight: "bold", title)
    }
  ]
  v(2em)
}

// === CITATION HELPERS ===
// Parenthetical citation: (Author, Year)
#let pcite(author, year) = {
  [(#author, #year)]
}

// Narrative citation: Author (Year)
#let ncite(author, year) = {
  [#author (#year)]
}

// Citation with page number: (Author, Year, p. X)
#let pcite-p(author, year, page) = {
  [(#author, #year, p. #page)]
}
