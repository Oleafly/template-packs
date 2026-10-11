// template_KDP_6x9in_en_v1.typ
// Version: 2026-08-31 DJ
// Author: Demis D. John
/* This is a template for a 6x9 inch book formatted for Amazon KDP (Kindle Direct Publishing)[cite: 1].
Margin sizes should be set based on KDP requirements, here[cite: 2]:
https://kdp.amazon.com/en_US/help/topic/GVBQ3CMEQW3W2VL6

Currently set for:
- 6 x 9 inch trim
- no bleed (no images to very edge of pages)
  - actually current margins work for bleed as well
- less than 151 pages: Inside margin (agaisnt spine) >= 0.375 inches
- outside margin (not against spine): >= 0.250 in.
*/

#import calc: odd
#import "functions.typ": * // custom utility functions

#let book(
  title: "",
  author: "",
  year: "",
  isbn: "",
  copyrightfile: none,
  body
) = {

  // Page Setup for KDP 6x9 inch
  set page(
    width: 6in, 
    height: 9in, 
    margin: (inside: 0.75in, outside: 0.5in, top: 0.75in, bottom: 0.75in), 
    header: context {
      // Get current absolute page and find TOC absolute page
      let abs_now = here().position().page
      let toc_query = query(outline)
      let abs_toc = if toc_query.len() > 0 { toc_query.first().location().position().page } else { 0 }
      
      // Only show header if current absolute page is strictly AFTER the TOC page
      if abs_now >= abs_toc { 
        // Use abs_now for odd/even check to ensure layout stays consistent for KDP
        let header-text = if calc.odd(abs_now) {
          align(right, author)
        } else {
          align(left, title)
        }
        text(size: 9pt, fill: rgb("#3e3e3e"), header-text)
      }
    }
  )

  //-------------------------------------
  // Styles and logic for various element
  // ------------------------------------


  // Body Text Style
  set text(font: "Libertinus Serif", size: 11pt, lang: "en") 
  set par(justify: true, leading: 0.65em) 

  // Global Heading Styles
  set heading(numbering: "1.1.a") // ch. numbering style [cite: 7]
  show heading.where(label: <unnumbered>): set heading(numbering: none) // remove ch. numbers from <unnumbered> sections [cite: 8]

  // Chapter heading formatting
  let is_labeled_no_number_display(txt) = {
    if txt.has("label") and txt.label != none {
      str(txt.label).contains("no-number-display")
    } else {
      false
    }
  }

  // Chapter formatting (heading level 1)
  show heading.where(level: 1): set heading(supplement: [Chapter]) // Call these sections "Chapters"
  
  show heading.where(level: 1): txt => {
    counter(figure.where(kind: image)).update(0) // reset figure numbering for each chapter

    pagebreak(weak: true) // break before
    set align(center)
  
    if txt.numbering != none and not is_labeled_no_number_display(txt){ 
      let chapter_num = counter(heading).at(txt.location()).at(0)
      smallcaps( text(size: 18pt, weight: "regular", font: "Times New Roman", [CHAPTER #chapter_num]) )
      linebreak()
    }
    
    smallcaps( text(size: 18pt, weight: "regular", font: "Times New Roman", txt.body ) )
  }

  // Section titles (heading level 2)
  show heading.where(level: 2): txt => {
    block(sticky: true, width: 100%)[
      #set text(font: "Arial", weight: "bold", size: 13pt)
      #v(0.50em)
      #if txt.numbering != none and not is_labeled_no_number_display(txt) { 
        numbering(txt.numbering, ..counter(heading).at(txt.location()))
        [ ]
      }
      #smallcaps(txt.body)
    ]
  }
  
  // Sub-Section titles (heading level 3)
  show heading.where(level: 3): txt => {
    block(sticky: true, width: 100%)[
      #set text(font: "Arial", weight: "bold", style: "italic", size: 12pt)
      #if txt.numbering != none and not is_labeled_no_number_display(txt) { 
        let nums = counter(heading).at(txt.location())
        numbering("A.", nums.last())
        [ ]
      }
      #txt.body 
    ]
  }
  
  // Figure numbering: Chapter.Figure (eg. "Figure 1.9")
  set figure(numbering: (..nums) => {
    let ch = counter(heading).at(here()).first()
    if ch > 0 {
      numbering("1.1", ch, ..nums)
    } else {
      numbering("1", ..nums)
    }
  })

  // Figure Caption Style
  show figure.caption: txt => {
    set text(font: "Calibri", weight: "light") 
    set par(leading: 0.5em)
    txt
    v(0.5em)
  }

  // Table numbering resets in each chapter.
  show heading.where(level: 1): it => {
  counter(figure.where(kind: table)).update(0)
  it
  }

  // figure with no caption but still is in List of Figures
  show figure.where(kind: "nocaption"): item => block(
    width: 100%,
    align(center, item.body)
  )

  
  // Custom outline (Table of Contents & List of Figures) entries: Heading logic (TOC) vs. Figure logic (LOF)
  show outline.entry: txt => {
    let is-heading = txt.element.func() == heading
    let is-level-1 = is-heading and txt.element.level == 1
    let is-level-3 = is-heading and txt.element.level == 3
    
    // Format prefix based on element type and heading level
    let prefix = if is-level-1 and txt.prefix() != none {
      [#txt.prefix().] // Add a period to Level 1 headings
    } else if is-level-3 and txt.prefix() != none {
      upper(txt.prefix()) // Upper-case lettering for Level 3 headings
    } else {
      txt.prefix()
    }


    // Maintain clickability and custom font styling
    link(
      txt.element.location(),
      txt.indented(
        if prefix != none {
          text(
            font: "Calibri",
          )[#prefix]
        } else {
          none
        },
        txt.inner(), // the entry text
      ),
    )
  }

  // Separate TOC outline from List-of-Figs outline:
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }



  //------------------------------
  // Book Content begins here
  // -----------------------------

  // 1. Title Page
  align(center + horizon)[
    #text(size: 30pt, weight: "bold", title)
    #v(1em)
    #text(size: 16pt, author)
  ]
  pagebreak()

  // 2. Copyright Page (with manual override logic)
  if copyrightfile != none {
    include(copyrightfile)
    pagebreak()

  } else {
    place(left+bottom,
      dx: 0in,
      dy: -0.5in,
      text(size: 9pt)[
        Copyright © #year #author. \ All rights reserved.

        #if isbn != none {
          [ISBN: #isbn]
        }
      
      ]
    )
    pagebreak()
  }

  // 3. Content
  body
}  //end book()