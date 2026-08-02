#let aimsessay(body) = {
  // --- Page Setup & Margins ---
  // A4 paper is approx 8.27 x 11.69 in. Target text area: 6.5 x 9 in.
  // x-margin = (8.27 - 6.5)/2 = ~0.885in
  // y-margin = (11.69 - 9)/2 = ~1.345in
  set page(
    paper: "a4",
    margin: (x: 0.885in, y: 1.345in),
    header: context {
      let page-num = counter(page).get().first()

      // Find current chapter and section for running headers
      let chapters = query(heading.where(level: 1).before(here()))
      let sections = query(heading.where(level: 2).before(here()))

      let left-mark = if chapters.len() > 0 {
        let ch = chapters.last()
        let num = counter(heading).at(ch.location()).first()
        [Chapter #num. #ch.body]
      } else { [] }

      let right-mark = if sections.len() > 0 {
        let sec = sections.last()
        // Format as X.Y
        let num = counter(heading).at(sec.location()).map(str).join(".")
        [Section #num. #sec.body]
      } else { [] }

      let is-even = calc.rem(page-num, 2) == 0

      let header-content = if is-even {
        [Page #page-num #h(1fr) #left-mark]
      } else {
        [#right-mark #h(1fr) Page #page-num]
      }

      // Underlined running header
      stack(
        dir: ttb,
        spacing: 0.3em,
        header-content,
        line(length: 100%, stroke: 0.5pt),
      )
    },
  )

  // --- Fonts & Formatting ---
  // Equivalent to 11pt, sfdefault, raggedright
  set text(font: "New Computer Modern Sans", size: 11pt, fallback: true)

  // \parskip=0.5\baselineskip, \parindent=0pt
  set par(justify: false, first-line-indent: 0pt)
  set par(spacing: 0.65cm)

  // --- Links and Citations ---
  // URL color = blue, cite color = brown (0.5, 0.3, 0.1 maps to RGB 127, 76, 25)
  show link: it => {
    if type(it.dest) == str and it.dest.starts-with("http") {
      text(fill: blue, it)
    } else {
      text(fill: rgb(127, 76, 25), it)
    }
  }
  show ref: set text(fill: rgb(127, 76, 25))

  // --- Headings ---
  // Default to Chapter 1, Section 1.1 layout
  set heading(numbering: "1.1")

  show heading: it => {
    if it.level == 1 {
      // Equivalent to \huge \bf and omitting the word "Chapter" each time
      v(15pt)
      text(size: 24pt, weight: "bold")[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(15pt)
        }
        #it.body
      ]
      v(15pt)
    } else if it.level == 2 {
      // Equivalent to \large \bf
      v(15pt)
      text(size: 14pt, weight: "bold")[
        #if it.numbering != none {
          counter(heading).display(it.numbering)
          h(15pt)
        }
        #it.body
      ]
      v(15pt)
    } else {
      // Strict structural error for \subsubsection, \paragraph, etc.
      // panic(
      //   "The command for heading level "
      //     + str(it.level)
      //     + " is disabled in AIMS Essays. Please choose a less intricate structure for your Essay!",
      // )
    }
  }

  // --- Outline (Table of Contents) ---
  // Restricts TOC to just Chapters (1) and Sections (2)

  show outline.entry: it => {
    let aims-red = rgb(210, 45, 45) // AIMS style red

    // 1. Get the numbering from the original heading
    let header-number = if it.element.numbering != none {
      // Get the array of numbers (e.g., [1] or [1, 1]) at the heading's location
      let nums = counter(heading).at(it.element.location())
      // Format them using the heading's own numbering style (e.g., "1.1")
      numbering(it.element.numbering, ..nums)
    } else {
      none
    }

    text(fill: aims-red, weight: "bold")[
      // 2. Display the number if it exists
      // #if header-number != none {
      //   header-number
      //   // h(0.8em) // Space between number and title
      // }

      // 3. Display the Title
      #if it.level == 1 {
        if (it.element.numbering == none) {
          it.element.body
        } else {
          str(header-number)
          h(0.75em)
          it.element.body
        }
        // it.element.body
      } else {
        // Indent subsections slightly
        // h(1.2em)
        text(weight: "regular", it)
      }

      #v(1em)

      // 4. Fill with dots and add page number
      // #box(width: 1fr, repeat[ . ])
      // #it.page
    ]
  }
show outline.entry.where(
  level: 1
): set block(above: 2em)

  set outline(depth: 3)


  // Render the actual document body
  body
}

// --- Appendix Environment ---
// Since Typst uses functions instead of stateful switches for massive structural
// changes, wrap your appendices in this function.
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}


#import "@preview/ctheorems:1.1.3": *
#show: thmrules
// #show: aimsessay

// Format to swap numbers (e.g., "1.1 Theorem" instead of "Theorem 1.1")
#let swap_fmt(name, number, body, title: none) = {
  [#strong[#number #name]#if title != none { [ (#title)] }.]
  h(0.5em)
  body
}

// Plain style (italics)
#let thm = thmbox("theorem", "Theorem", base: "heading", stroke: none)

// Definition style (upright/normal font)
// Note: In ctheorems, we can force the body to be upright by wrapping it in #text() if needed,
// but by default Typst theorems are upright. We explicitly make `thm` italic if we want strict LaTeX matching.
#let lem = thmbox("lemma", "Lemma", base: "heading", fmt: swap_fmt, stroke: none)
#let cor = thmbox("corollary", "Corollary", base: "heading", fmt: swap_fmt, stroke: none)
#let conj = thmbox("conjecture", "Conjecture", base: "heading", fmt: swap_fmt, stroke: none)
#let pro = thmbox("proposition", "Proposition", base: "heading", fmt: swap_fmt, stroke: none)
#let exa = thmbox("example", "Example", base: "heading", fmt: swap_fmt, stroke: none)
#let defn = thmbox("definition", "Definition", base: "heading", fmt: swap_fmt, stroke: none)
#let rem = thmbox("remark", "Remark", base: "heading", fmt: swap_fmt, stroke: none)
#let proof = thmproof("proof", "Proof")

// Number equations by section (e.g., 1.1, 1.2)
#set math.equation(numbering: "(1.1)")

// ----------------------------------------------------------------------------
// Custom Command Shortcuts
// Keep them clearly separate from other sections. Use #let instead of \newcommand.
// ----------------------------------------------------------------------------
#let be(body) = math.equation(block: true, body)
#let C = math.bb("C") // Complex
#let Z = math.bb("Z") // Integers
#let R = math.bb("R") // Real
#let sech = math.op("sech")
