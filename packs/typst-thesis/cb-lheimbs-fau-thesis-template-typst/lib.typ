// Thesis template styling library
// This file replicates the design from osrthesis.sty

#import "config.typ": *

// State for controlling header visibility (e.g., blank pages after Appendices title)
#let header-visible = state("header-visible", true)

// State for tracking whether we're in the appendix section (for header formatting)
#let in-appendix = state("in-appendix", false)

// State for tracking whether we're in the main content section (for header display)
#let in-main-content = state("in-main-content", false)

// Main thesis template function
#let thesis-template(
  title: "",
  author-given-name: "",
  author-surname: "",
  submission-date: datetime.today(),
  submission-city: "",
  thesis-type: "",
  supervisors: "",
  language: "English",
  bibliography-file: none,
  body,
) = {
  // Set document properties
  set document(title: title, author: author-given-name + " " + author-surname)

  // Set page properties
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm),
    numbering: "i", // Roman numerals for prefix section
    number-align: right,
    binding: left, // Enable two-sided layout for proper odd/even pages
  )

  // Set text properties
  set text(
    font: "New Computer Modern",
    size: 12pt,
    lang: if language == "German" { "de" } else { "en" },
  )

  // Set paragraph properties
  set par(
    justify: true,
    leading: 0.65em,
    spacing: 1em,
  )

  // Set heading properties
  show heading.where(level: 1): it => {
    if it.numbering != none {
      pagebreak(weak: true, to: "odd") // Chapters start on right page
    }
    set text(size: 24pt, weight: "bold")
    v(0.5em)
    if it.numbering != none {
      counter(heading).display()
      h(1em)
    }
    it.body
    v(1em)
  }

  show heading.where(level: 2): it => {
    set text(size: 16pt, weight: "bold")
    v(0.8em)
    it
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    set text(size: 14pt, weight: "bold")
    v(0.6em)
    it
    v(0.4em)
  }

  // Configure links
  show link: set text(fill: black)

  // Configure figures
  show figure: set block(breakable: true)
  set figure.caption(separator: [: ])
  show figure.caption: set text(size: 11pt)
  show figure.caption: it => context {
    strong(it.supplement + " " + it.counter.display(it.numbering))
    it.separator
    it.body
  }

  // Title page
  page(
    margin: (left: 3cm, right: 3cm, top: 3cm, bottom: 3cm),
    numbering: none,
  )[
    #set align(center)
    #v(1fr)

    // Title
    #text(size: 24pt, weight: "bold")[#title]

    #v(0.2in)
    #text(size: 12pt)[#upper(thesis-type)]

    #v(0.3in)
    #text(size: 18pt, weight: "bold")[#author-given-name #author-surname]

    #v(1fr)

    #text[#submitted-on #submission-date.display("[day].[month].[year]")]

    #v(1fr)

    // University logo (sigil)
    #image(logo-sigil, width: 30%)

    #v(0.3in)

    // University information
    #text[#university] \
    #v(0.03in)
    #text[#faculty, #department] \
    #v(0.03in)
    #text[#professorship]

    #v(0.3in)
    #v(1fr)

    // Supervisor information
    #text[#underline[#supervisor-label:]] \
    #text[#supervisors]

    #v(1fr)

    // Faculty logo
    #image(logo-faculty, width: 60%)

    #v(1fr)
  ]

  // Add blank page after title (like \shipout\null in LaTeX)
  // This ensures Declaration starts on page 3 (an odd page for two-sided printing)
  page(numbering: none)[]

  // Reset page counter so Declaration starts at page i
  counter(page).update(1)

  // Set up page numbering and headers for the body
  set page(
    header: context {
      // No header for prefix section (roman numerals before main content)
      if not in-main-content.get() {
        return none
      }

      let current-page = here().page()

      // No header on pages where a level-1 heading starts
      // (matches LaTeX \thispagestyle{plain} on chapter pages)
      // Exception: appendix sections (A, B...) keep their header -- only suppress
      // main content chapters and the unnumbered "Appendices" interstitial title page
      let headings-here = query(heading.where(level: 1)).filter(h => h.location().page() == current-page)
      let is-appendix-section-start = headings-here.len() > 0 and headings-here.first().numbering == "A.1"

      if headings-here.len() > 0 {
        if headings-here.first().numbering != "A.1" {
          return none
        }
      }

      // No header in explicitly hidden zones (e.g., blank page after Appendices title)
      // Bypass this for appendix section start pages: header-visible.update(true) fires
      // during content layout of that very page, so the state is still false when the
      // header slot is evaluated -- we must allow it through explicitly.
      // Also bypass for appendix continuation pages: once a numbered appendix section has
      // started, headers should always be visible. This avoids state timing issues where
      // header-visible is still false on continuation pages (e.g., page 2 of Appendix B).
      if not header-visible.get() and not is-appendix-section-start {
        let all-appendix-h1 = query(heading.where(level: 1)).filter(h => h.numbering == "A.1" and h.location().page() <= current-page)
        if all-appendix-h1.len() == 0 {
          return none
        }
      }

      // Find the last level-1 heading before or on this page
      let all-h1 = query(heading.where(level: 1))
      let before = all-h1.filter(h => h.location().page() <= current-page)
      if before.len() == 0 {
        return none
      }
      let last = before.last()

      // Build header content
      set text(size: 11pt)

      let header-text = if last.numbering != none {
        let num = counter(heading).at(last.location()).first()
        if last.numbering == "A.1" {
          // Appendix header: "Appendix A : Title"
          // Use last.numbering to detect appendix headings instead of in-appendix state,
          // since state.get() in page headers suffers from timing issues.
          [#appendix-name-singular #numbering("A", num) : #last.body]
        } else {
          // Chapter header: "N. Title" (matching LaTeX which removes "Chapter" prefix)
          [#num. #last.body]
        }
      } else {
        // Unnumbered heading (e.g., References)
        last.body
      }

      header-text
      v(-0.5em)
      line(length: 100%, stroke: 0.5pt)
    },
    numbering: "i",
    number-align: right,
  )

  body
}

// Appendix styling
#let appendix-style(body) = {
  counter(heading).update(0)
  in-appendix.update(true)
  header-visible.update(false) // Suppress header on blank filler page before Appendices title

  set heading(
    numbering: "A.1",
    supplement: appendix-name-singular,
  )

  show heading.where(level: 1): it => {
    if it.numbering == none {
      // "Appendices" title page - centered like LaTeX \appendixpagename
      pagebreak(to: "odd")
      v(1fr)
      align(center)[#text(size: 24pt, weight: "bold")[#it.body]]
      v(1fr)
      // Disable headers for the blank filler page that follows
      header-visible.update(false)
    } else {
      // Individual appendix section heading
      // Re-enable headers (takes effect after this page)
      pagebreak(weak: false)
      header-visible.update(true)
      set text(size: 24pt, weight: "bold")
      v(0.5em)
      counter(heading).display("A")
      h(1em)
      it.body
      v(1em)
    }
  }

  heading(numbering: none, outlined: true)[#appendix-name-plural]

  body
}

// Chapter shorthand for unnumbered chapters
#let chapter(numbering: "1", outlined: true, body) = {
  if numbering == none {
    heading(level: 1, numbering: none, outlined: outlined, body)
  } else {
    heading(level: 1, numbering: numbering, outlined: outlined, body)
  }
}
