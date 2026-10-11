// NOTE: The title-page watermark used to go through @preview/grayness
// (transparent-image) with alpha: 100%, which means "fully opaque" — i.e. no
// transparency was actually applied. The dependency was dropped in favor of a
// plain image() call (grayness 0.1.0 relied on image.decode, removed in Typst
// 0.15). If you ever want a translucent watermark, use
// @preview/grayness:0.7.0's image-transparency(path, alpha: ..%) or bake the
// alpha into the image file.

// Document mode flag
#let final-mode = state("final-mode", false)

// Thesis metadata states
#let thesis-title = state("thesis-title", "")
#let thesis-author = state("thesis-author", "")
#let thesis-submission-date = state("thesis-submission-date", "")

// State to track if we're on the first page of a chapter
#let is-chapter-start = state("is-chapter-start", false)

// State to store current chapter title
#let current-chapter-title = state("current-chapter-title", "")

// Counter that's nonzero while a heading is being rendered.
// Used by main.typ's indent-targets show rule to skip injecting the
// "invisible paragraph" trailer for blocks created by heading rendering,
// so the first paragraph after a heading stays unindented.
#let in-heading = state("oist-in-heading", 0)

// Page header. Long chapter titles wrap to multiple lines: the title and the
// page number bottom-align in a grid so the page number sits on the last line
// of the title, and the underline is drawn beneath the whole block so it never
// crosses the wrapped text. Chapter-start pages show only the page number.
#let page_header = context {
  let current_page = counter(page).get().first()
  let chapter_start = is-chapter-start.get()
  let chapter_title = current-chapter-title.get()

  if chapter_start {
    align(right)[
      #text(size: 12pt, weight: "regular", font: "Times New Roman")[#current_page]
    ]
  } else {
    set text(size: 12pt, weight: "regular", font: "Times New Roman")
    grid(
      columns: (1fr, auto),
      column-gutter: 1em,
      align: (left + bottom, right + bottom),
      chapter_title,
      [#current_page],
    )
    v(0.2em)
    line(length: 100%, stroke: 0.5pt + black)
  }

  // Reset the chapter start flag after displaying header
  is-chapter-start.update(false)
}

// Page footer function for preamble pages - NEW FUNCTION
#let preamble_footer = context {
  let current_page = counter(page).display("i")  // Roman numerals for preamble
  // Place inside the bottom margin (1cm from page bottom). Using a larger
  // |dy| (e.g. 2.5cm) puts the page number flush with the content-area
  // boundary, so a dense outline whose last entry reaches the bottom of the
  // content area will visually collide with it.
  place(
    bottom + center,
    dy: -1cm,
    text(size: 12pt, weight: "regular", font: "Times New Roman")[#current_page]
  )
}

// Title page function
#let title_page(title, author, supervisor, cosupervisor, submission_date) = {
  // Title page font: New Computer Modern (successor of CMU Serif; bundled
  // with the Typst CLI, so it needs no local font installation)
  set text(font: "New Computer Modern", size: 12pt, hyphenate: false)

  set page(
    header: none,
    footer: none,
    background: [
      #place(
        center + horizon,
        block(
          width: 100%,
          height: 100%,
          [
            #move(
              dx: -8.8cm, // Adjusted offset for better centering
              dy: 5.5cm,
              image(
                "images/symbol.jpg",
                width: 100%, // Full page width
              )
            )
          ]
        )
      )
    ]
  )
  
  align(center, {
    // Reduce top space to move elements higher
    v(0.3fr)
    
    // University name in small caps style (manual implementation)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 14.4pt)[
        #text(size: 14.4pt)[O]#text(size: 11.5pt)[KINAWA] 
        #text(size: 14.4pt)[I]#text(size: 11.5pt)[NSTITUTE] 
        #text(size: 11.5pt)[OF] 
        #text(size: 14.4pt)[S]#text(size: 11.5pt)[CIENCE] 
        #text(size: 14.4pt)[A]#text(size: 11.5pt)[ND] 
        #text(size: 14.4pt)[T]#text(size: 11.5pt)[ECHNOLOGY]\
        #text(size: 14.4pt)[G]#text(size: 11.5pt)[RADUATE] 
        #text(size: 14.4pt)[U]#text(size: 11.5pt)[NIVERSITY]
      ]
    ]
    v(1.0cm)
    
    // Degree text (large = 14.4pt in LaTeX)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 14.4pt, font: "New Computer Modern", "Thesis submitted for the degree")
    ]
    v(1.0cm)
    
    // Degree type (Large = 17.28pt in LaTeX)
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 17.28pt, font: "New Computer Modern", "Doctor of Philosophy")
    ]
    v(1.0cm)
    
    // Top line
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #line(length: 100%, stroke: 1.2pt)
    ]
    v(0.5cm)
    
    // Title (huge = 24.88pt in LaTeX).
    // A long title may push the author/supervisor blocks off the page —
    // drop this to ~22pt if yours wraps to three or more lines.
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #text(size: 24.88pt, font: "New Computer Modern", title)
    ]
    v(0.5cm)
    
    // Bottom line
    block(spacing: 0pt)[
      #set par(leading: 0.65em)  // Tight line spacing
      #line(length: 100%, stroke: 1.2pt)
    ]
    v(2.5cm)
    
    // Author section
    align(right)[
      #block(spacing: 0pt)[
        #set par(leading: 0.65em)  // Tight line spacing
        #text(size: 12pt, font: "New Computer Modern", "by")
        #v(0.2cm)
        #text(size: 14.4pt, weight: "bold", font: "New Computer Modern", author)
      ]
    ]

    v(4.0fr)
    
    // Supervisor section
    align(right)[
      #block(spacing: 0pt)[
        #set par(leading: 0.65em)  // Tight line spacing
        #text(size: 14.4pt, font: "New Computer Modern", "Supervisor: ")
        #text(size: 14.4pt, weight: "bold", font: "New Computer Modern", supervisor)

        // Co-supervisor if exists
        #if cosupervisor != none {
          v(-0.5cm) // No extra space between supervisor and co-supervisor
          linebreak()
          text(size: 14.4pt, font: "New Computer Modern", "Co-Supervisor: ")
          text(size: 14.4pt, weight: "bold", font: "New Computer Modern", cosupervisor)
        }
        
        #v(1cm)
        #text(size: 12pt, font: "New Computer Modern", submission_date)
      ]
    ]
  })
  
  pagebreak()
}

// Appendix wrapper. Inside `body`, level-2+ headings are numbered as
// `<letter>.N`, `<letter>.N.M`, ... (e.g. A.1, A.1.1) instead of using the
// document-wide chapter counter. The level-1 heading of an appendix carries
// `numbering: none` explicitly, so it is unaffected.
//
// Figures and tables inside `body` are numbered as `<letter>.N` (e.g. A.1,
// A.2, B.1) instead of `<chapter>.N`. The image and table figure counters
// are reset to zero so each appendix starts at 1. Putting `set figure(...)`
// here (rather than reading a state inside the global numbering function)
// is what makes cross-references render correctly: the closure captures
// `letter` at figure-creation time, so `@<label>` from anywhere in the
// document still resolves to the figure's appendix letter.
//
// All figures/tables of an appendix MUST be placed inside this `body` block
// for the set rule and counter resets to apply.
//
// Sub-counters are reset to zero at the start of each appendix because
// level-1 headings with `numbering: none` do not auto-reset them in Typst —
// without this, sections in Appendix B would continue numbering from where
// the last main chapter (or earlier appendix) left off.
//
// Usage:
//   #appendix("A")[
//     #heading(level: 1, numbering: none, "Appendix A: Title") <appendix-a>
//     ...
//   ]
#let appendix(letter, body) = {
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() <= 1 { none }
    else { letter + "." + n.slice(1).map(str).join(".") }
  })
  set figure(numbering: it => letter + "." + str(it))
  counter(heading).update((..levels) => (levels.pos().at(0, default: 0),))
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  body
}

// Main thesis function
#let thesis(
  title: "",
  author: "",
  supervisor: "",
  cosupervisor: none,
  submission_date: "",
  mode: "draft",
  colored_refs: false,
  body
  ) = {
  // Set document metadata
  set document(title: title, author: author)
  final-mode.update(mode == "submission")
  thesis-title.update(title)
  thesis-author.update(author)
  thesis-submission-date.update(submission_date)

  // Cross-references and citations are black by default (print-friendly).
  // Set `colored_refs: true` in main.typ for a clickable, blue-linked
  // screen-reading copy.
  let ref_color = if colored_refs { rgb("#0066cc") } else { black }

  // Configure page settings - FIXED: Remove footer from main content pages
  if mode == "submission" {
    set page(
      paper:  "a4",
      margin: (
        left:   3.0cm,
        right:  2.5cm,
        top:    2.5cm,
        bottom: 2.5cm,
      ),
      header: page_header,
      footer: none,
      numbering: "1",  // Enable numbering but display it in header only
      binding: left,
    )
  } else {
    // Draft version: one-sided layout  
    set page(
      paper:  "a4",
      margin: (
        left:   3.0cm,
        right:  2.5cm,
        top:    2.5cm,
        bottom: 2.5cm,
      ),
      header: page_header,
      footer: none,
      numbering: "1",  // Enable numbering but display it in header only
    )
  }

  // Set base font (Times New Roman for primary text)
  set text(font: "Times New Roman", lang: "en", size: 12pt)
  set list(
    indent: 2em,
    body-indent: 0.5em,
    marker: ([•], [--], [◦], [·]),
  )
  
  // Configure heading numbering
  set heading(numbering: "1.1")
  
  // Configure figure and table captions
  set figure.caption(separator: ": ")
  
  // Style figure captions with Helvetica font (secondary font)
  show figure.caption: it => {
    // Use Helvetica (sans-serif) at 10pt
    set text(font: "Helvetica", size: 10pt)
    set align(left)

    // Determine if it's a figure or table
    let fig = query(figure).find(f => f.caption == it)

    if fig != none {
      context {
        if fig.body.func() == image {
          // Figure caption
          [*Figure #fig.counter.display(fig.numbering)*#it.separator#it.body]
        } else if fig.body.func() == table {
          // Table caption
          [*Table #fig.counter.display(fig.numbering)*#it.separator#it.body]
        } else {
          // Other caption
          [*#fig.supplement #fig.counter.display(fig.numbering)*#it.separator#it.body]
        }
      }
    } else {
      it
    }
  }
  
  // Configure table captions to appear above tables and align all captions to left
  show figure: it => {
    if it.body.func() == table {
      // For tables: place caption above the table with consistent spacing
      block(above: 2.0em, below: 2.0em)[
        #block(
          spacing: 10pt,
          width: 100%
        )[
          #set align(left)
          #set text(font: "Helvetica", size: 10pt)
          #context {
            let fig = it
          [*Table #fig.counter.display(fig.numbering)*#text(": ")#fig.caption.body]
          }
        ]
        #block(spacing: 10pt, it.body)
      ]
    } else {
      // For figures and other content: use default positioning (caption below) but left-aligned
      block(above: 2.0em, below: 2.0em)[
        #it.body
        #block(width: 100%)[
          #set align(left)
          #set text(font: "Helvetica", size: 10pt)
          #context {
            let fig = it
            if fig.body.func() == image {
              [*Figure #fig.counter.display(fig.numbering)*#text(": ")#fig.caption.body]
            } else {
              [*#fig.supplement #fig.counter.display(fig.numbering)*#text(": ")#fig.caption.body]
            }
          }
        ]
      ]
    }
  }

  // Configure figure and table numbering (chapter.number format)
  set figure(numbering: it => {
    let chap = counter(heading).get().at(0, default: 1)
    numbering("1.1", chap, it)
  })
  
  // Configure equation numbering
  set math.equation(numbering: "(1)")
  
  // Configure bibliography style  
  set bibliography(style: "apa", title: "Bibliography")
  
  // Add spacing between bibliography entries
  show bibliography: it => {
    set par(spacing: 1.5em)
    it
  }
  
  // Configure cite style for APA format
  show cite: it => {
    set text(weight: "regular", fill: ref_color)
    it
  }

  // Heading references render as "Chapter N" for level-1 and "Section N.M"
  // for level-2+ headings. (Setting `supplement` inside `set heading(...)`
  // does not work because `it.level` / `it.depth` are not resolvable at
  // that point; rewriting the ref display here is the reliable hook.)
  show ref: it => {
    set text(fill: ref_color)
    let target = it.element
    if target != none and target.func() == heading and target.numbering != none {
      let nums = counter(heading).at(target.location())
      let supp = if target.level == 1 { "Chapter" } else { "Section" }
      let num_str = numbering(target.numbering, ..nums)
      link(target.location())[#supp #num_str]
    } else {
      it
    }
  }

  // Configure quote styling for better visual clarity
  show quote: it => {
    set par(first-line-indent: 0em)
    block(
      above: 1.2em,
      below: 1.2em,
      inset: (left: 2em, right: 1em),
      stroke: (left: 3pt + gray),
      fill: luma(248),
      radius: (left: 0pt, right: 4pt)
    )[#it]
  }
  
  // Style for code blocks and raw text (technical font).
  // "DejaVu Sans Mono" ships with the Typst CLI, so it needs no local font
  // installation; the old "CMU Typewriter Text" had to be installed by hand.
  show raw: it => {
    set text(font: "DejaVu Sans Mono", size: 10pt)
    if it.block {
      block(
        width: 100%,
        fill: luma(245),
        inset: 10pt,
        radius: 4pt,
        breakable: false,
        it
      )
    } else {
      it
    }
  }
  
  // Style for links: external URLs are underlined; internal cross-references
  // (heading/figure/table refs and label-based links) are colored only.
  show link: it => {
    set text(font: "Times New Roman", fill: ref_color)
    if type(it.dest) == str {
      underline(it)
    } else {
      it
    }
  }

  // Hayagriva's APA renderer emits the "https://doi.org/" prefix of a DOI as
  // plain text adjacent to the linked DOI body, so `show link` only underlines
  // the body and the prefix is left unstyled. This regex rule catches any
  // URL-like substring that appears in plain text and underlines it with the
  // same color, restoring a single continuous underline across the full URL.
  show regex("https?://[a-zA-Z0-9./_\-~:?#\[\]@!$&'()*+,;=%]+"): it => {
    set text(font: "Times New Roman", fill: ref_color)
    underline(it)
  }

  // Ensure footnote text (including links) stays in Times New Roman.
  // Same rule as the global link rule: underline only external URLs.
  show footnote.entry: entry => context {
    set text(font: "Times New Roman")
    show link: link => context {
      set text(font: "Times New Roman", fill: ref_color)
      if type(link.dest) == str {
        underline(link)
      } else {
        link
      }
    }
    entry
  }

  // Apply mode-specific spacing using show rule (recommended approach)
  show: body => {
    if mode == "submission" {
      // Single spacing for submission version
      set par(
        leading: 0.65em,
        spacing: 0.65em,
        first-line-indent: (amount: 1.5em, all: false),
        justify: true
      )

      // Apply list spacing for submission mode
      show list: it => {
        v(0.8em)
        set par(leading: 0.65em, spacing: 0.65em)
        set list(spacing: 0.5em)
        it
        v(0.8em)
      }
      
      show list.item: it => {
        block(above: 0.0em, below: 0.0em)[#it]
      }
      
      // Style chapter headings (level 1) for submission mode
      show heading.where(level: 1): it => {
        // Mark this as a chapter start page
        is-chapter-start.update(true)

        // Update current chapter title - just the title, no "Chapter X:" prefix
        current-chapter-title.update(it.body)

        // Wrap heading rendering with `in-heading` >= 1 so main.typ's
        // indent-targets rule skips the invisible-paragraph injection for
        // blocks emitted here. Without this, the first paragraph after the
        // chapter title would be preceded by an injected paragraph and
        // therefore inherit the 1.5em first-line indent.
        in-heading.update(n => n + 1)
        pagebreak(weak: true)
        v(2em)
        block[
          #set par(first-line-indent: 0em)
          #if it.numbering != none [
            #set text(size: 29.86pt, weight: "bold", font: "Times New Roman")
            Chapter #counter(heading).display(it.numbering)
            #linebreak()
            #v(8mm)
          ]
          #set text(size: 29.86pt, weight: "bold", font: "Times New Roman")
          // Match main-text leading (0.65em × 12pt = 7.8pt absolute) so wrapped
          // chapter titles do not get the larger em-resolved leading at 29.86pt.
          #set par(leading: 7.8pt)
          #it.body
        ]
        v(13mm)
        in-heading.update(n => n - 1)
      }

      // Style section headings (level 2) for submission mode
      show heading.where(level: 2): it => {
        in-heading.update(n => n + 1)
        v(0.65em)
        set text(size: 17.28pt, weight: "bold", font: "Times New Roman")
        it
        v(0.65em)
        in-heading.update(n => n - 1)
      }

      // Style subsection headings (level 3) for submission mode
      show heading.where(level: 3): it => {
        in-heading.update(n => n + 1)
        v(0.65em)
        set text(size: 14.4pt, weight: "bold", font: "Times New Roman")
        it
        v(0.65em)
        in-heading.update(n => n - 1)
      }

      // Configure outline spacing for submission mode
      show outline: it => {
        set text(size: 12pt, font: "Times New Roman")
        set par(leading: 0.65em, spacing: 1.2em)
        // No extra bottom padding in submission mode
        it
      }
      
      body
    } else {
      // 1.5 spacing for draft version
      set par(
        leading: 1.2em,
        spacing: 1.8em,
        first-line-indent: (amount: 1.5em, all: false),
        justify: true
      )

      // Apply increased spacing to all blocks
      set block(spacing: 1.8em)
      
      // Apply list spacing for draft mode
      show list: it => {
        set par(leading: 1.2em, spacing: 1.2em)
        set list(spacing: 1.2em)
        it
      }
      
      // Style chapter headings (level 1) for draft mode
      show heading.where(level: 1): it => {
        // Mark this as a chapter start page
        is-chapter-start.update(true)

        // Update current chapter title - just the title, no "Chapter X:" prefix
        current-chapter-title.update(it.body)

        // See submission-mode level-1 rule for the rationale.
        in-heading.update(n => n + 1)
        pagebreak(weak: true)
        v(2em)
        set par(first-line-indent: 0em)
        block(
          width: 100%,
          inset: (left: 0pt),
        )[
          #if it.numbering != none [
            #set text(size: 24.88pt, weight: "bold", font: "Times New Roman")
            #align(left)[Chapter #counter(heading).display(it.numbering)]
            #linebreak()
            #v(-2.0em)
          ]
          #set text(size: 24.88pt, weight: "bold", font: "Times New Roman")
          // Match main-text leading (1.2em × 12pt = 14.4pt absolute) so wrapped
          // chapter titles do not get the larger em-resolved leading at 24.88pt.
          #set par(leading: 14.4pt)
          #align(left)[#it.body]
        ]
        v(1.8em)
        in-heading.update(n => n - 1)
      }

      // Style section headings (level 2) for draft mode
      show heading.where(level: 2): it => {
        in-heading.update(n => n + 1)
        v(1.8em)
        set text(size: 17.28pt, weight: "bold", font: "Times New Roman")
        it
        v(1.8em)
        in-heading.update(n => n - 1)
      }

      // Style subsection headings (level 3) for draft mode
      show heading.where(level: 3): it => {
        in-heading.update(n => n + 1)
        v(1.8em)
        set text(size: 14.4pt, weight: "bold", font: "Times New Roman")
        it
        v(1.8em)
        in-heading.update(n => n - 1)
      }

      // Configure outline spacing for draft mode
      show outline: it => {
        set text(size: 12pt, font: "Times New Roman")
        set par(leading: 1.5em, spacing: 1.8em)
        // Add bottom padding to avoid footer overlap
        block(below: 10mm)[#it]
      }
      
      body
    }
  }
  
// Style outline entries - make chapter entries bold and add per-entry bottom gap (to avoid footer overlap)
show outline.entry.where(level: 1): it => {
  // Add extra space before "Introduction" to separate from lists (ToC, LoF, LoT)
  let intro_spacer = if it.element != none and it.element.body != none and repr(it.element.body) == repr([Introduction]) {
    v(1.0em)
  } else {
    []
  }
  let gap = if mode == "submission" { 0pt } else { 8mm }
  // For figure/table entries (LoF/LoT), constrain the body width with a 2-column
  // grid so long captions wrap before reaching the page-number column on the right.
  if it.element != none and it.element.func() == figure {
    block(below: gap, width: 100%)[
      #set text(weight: "bold", font: "Times New Roman")
      #grid(
        columns: (1fr, auto),
        column-gutter: 0.6em,
        align: (left + bottom, right + bottom),
        [#it.prefix()#h(0.6em)#it.body()#h(0.4em)#box(width: 1fr, it.fill)],
        [#it.page()],
      )
    ]
  } else {
    block(below: gap)[#intro_spacer #text(weight: "bold", font: "Times New Roman", it)]
  }
}

// Figure & table entries in outlines (LoF/LoT): show short title instead of full caption
show outline.entry.where(element: figure): it => {
  let fig = it.element
  let caption_children = if fig.caption == none {
    none
  } else {
    fig.caption.body.fields().at("children", default: none)
  }
  let first_child = if caption_children == none { none } else { caption_children.at(0, default: none) }
  let custom_short = if first_child != none and first_child.func() == strong {
    first_child.fields().at("body", default: first_child)
  } else {
    none
  }
  // Determine label (Figure / Table / supplement)
  let label = if fig.body.func() == table {
    "Table"
  } else if fig.body.func() == image {
    "Figure"
  } else {
    fig.supplement
  }
  // Number text
  let num_text = fig.counter.display(fig.numbering)
  // Fallback to full caption if no custom short provided
  let short_display = if custom_short != none { custom_short } else { fig.caption.body }
  let gap = if mode == "submission" { 0pt } else { 8mm }
  block(below: gap)[
    #set text(weight: "regular", font: "Times New Roman")
    [*#label #num_text* ]#short_display
  ]
}

// Non-figure entries keep default content but with spacing in draft mode
show outline.entry: it => {
  let styled = it
  let gap = if mode == "submission" { 0pt } else { 8mm }
  block(below: gap)[#styled]
}
  
  // Title page
  title_page(title, author, supervisor, cosupervisor, submission_date)
  
  // Start front matter with roman numerals - MODIFIED TO USE FOOTER
  set page(
    numbering: "i",
    margin: (
        left:   3.0cm,
        right:  2.5cm,
        top:    3.5cm,
        bottom: 2.5cm,
      ),
    header: none,
    footer: preamble_footer,  // Use the new footer function for preamble pages
  )
  counter(page).update(1)
  
  body
}

// Helper function for numbered chapters
#let numbered-chapter(title, content) = [
  #heading(level: 1, numbering: "1.1", title)
  #content
]

// Helper function for unnumbered chapters
#let unnumbered-chapter(title) = {
  heading(level: 1, numbering: none, outlined: true, title)
}

// -----------------------------------------------
// Figures/Tables with optional short titles
// -----------------------------------------------

// Track whether we are rendering a List of Figures/Tables entry
#let _in_list_mode = state("in-lof-lot", none)

// Wrapper for figures/tables that accepts an optional short title for LoF/LoT.
// Usage:
//   #custom_figure(image("..."), short: [Short Title], caption: [Full detailed caption...]) <fig-id>
//   #custom_figure(table(...),  short: [Short Title], caption: [Full detailed caption...]) <tab-id>
#let custom_figure(body, caption: none, short: none) = {
  let cap_content = if caption != none { caption } else { [] }
  let short_content = if short != none { short } else { cap_content }

  let caption_block = context {
    let mode = _in_list_mode.get()
    if mode != none {
      short_content
    } else if short != none {
      if caption != none {
        [#short #cap_content] //. if you want to emphasize the short title, use a strong tag, like #strong(short)
      } else {
        strong(short)
      }
    } else {
      cap_content
    }
  }

  figure(body, caption: caption_block)
}

// Backward compatibility alias
#let oist_figure = custom_figure

// Build LoF/LoT using built-in outline (handles dots/page alignment)

// Public helpers to list figures and tables
#let list_of_figures() = context {
  _in_list_mode.update("figures")
  outline(title: none, target: figure.where(kind: image))
  _in_list_mode.update(none)
}

#let list_of_tables() = context {
  _in_list_mode.update("tables")
  outline(title: none, target: figure.where(kind: table))
  _in_list_mode.update(none)
}

// list_of_figures / list_of_tables moved above to use outline

// -----------------------------------------------
// Citation helpers
// -----------------------------------------------

// Narrative/prose citation: "Smith (2020) showed that ..."
#let prosecite(key) = cite(key, form: "prose")

// Full bibliography-style rendering of one entry, inline. Handy on the
// declaration page and on published-article cover pages.
#let fullcite(key) = cite(key, form: "full")

// -----------------------------------------------
// Published Article cover page + PDF embedding
// -----------------------------------------------

// Cover page that precedes each embedded published-article PDF.
// `bib_key` is a label (e.g. <Smith2024-ab>) used to render the full
// citation via `fullcite`. `related_chapter` is also a label (e.g. <study1>).
#let published_article_cover(
  number: "",
  title: "",
  bib_key: none,
  license: "",
  related_chapter: none,
) = {
  // Mirror the level-1 heading show rule: update state BEFORE pagebreak
  // so the new page's page_header reads the chapter-start flag.
  is-chapter-start.update(true)
  current-chapter-title.update("Published Article PDFs")
  pagebreak(weak: true)

  v(3em)

  block[
    #set par(first-line-indent: 0em)
    #set text(size: 14pt, font: "Times New Roman")
    Published Article #number
  ]

  v(0.5em)
  line(length: 100%, stroke: 1pt)
  v(2em)

  block[
    #set par(first-line-indent: 0em, justify: false)
    #set text(size: 20pt, weight: "bold", font: "Times New Roman")
    #title
  ]

  v(1.5em)

  if bib_key != none {
    block[
      #set par(first-line-indent: 0em, justify: true)
      #set text(size: 12pt, font: "Times New Roman")
      *Citation.* #fullcite(bib_key)
    ]
  }

  if related_chapter != none {
    v(0.5em)
    block[
      #set par(first-line-indent: 0em)
      #set text(size: 12pt, font: "Times New Roman")
      *Corresponding chapter in this thesis.* #ref(related_chapter)
    ]
  }

  v(2em)

  if license != "" {
    block(
      width: 100%,
      inset: 1em,
      fill: luma(245),
      stroke: 0.5pt + gray,
      radius: 4pt,
    )[
      #set par(first-line-indent: 0em, justify: true)
      #set text(size: 10pt, font: "Times New Roman")
      *Copyright notice.* #license
    ]
  }
}

// Embeds every page of `path` as a full-bleed page (no margins, no header).
// Page numbering of the host document is preserved across the embed.
// Useful for published-article PDFs and scanned co-author authorization forms.
//
// Bumps `oist-in-heading` for the duration of the loop so main.typ's
// indent-targets show rule does not inject an invisible trailing
// paragraph after each `page(...)` call. Without this, the trailer
// overflows onto a fresh page and produces alternating blank pages.
#let embed_pdf(path, count) = {
  in-heading.update(n => n + 1)
  for i in range(1, count + 1) {
    page(margin: 0pt, header: none, footer: none)[
      #image(path, page: i, width: 100%, height: 100%, fit: "contain")
    ]
  }
  in-heading.update(n => n - 1)
}
