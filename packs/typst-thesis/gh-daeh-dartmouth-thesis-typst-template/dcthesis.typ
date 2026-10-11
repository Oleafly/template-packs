// ============================================================================
// DARTMOUTH THESIS TEMPLATE - dcthesis.typ
// ============================================================================
// Typst implementation of the Dartmouth PhD thesis template (dcthesis.cls)
// Conforming to Dartmouth Graduate School thesis guidelines
//
// Font: New Computer Modern (matches LaTeX Computer Modern default)
// Version: 1.0
// Date: 2026-01-11
// ============================================================================

#let x-target = sys.inputs.at("x-target", default: "pdf")

// ----------------------------------------------------------------------------
// Line Height Calculation
// ----------------------------------------------------------------------------
// Typst 'leading' measures gap between lines (bottom edge to top edge).
// LaTeX 'baselineskip' measures baseline-to-baseline distance.
// Conversion formula: leading = baseline - (line-height-ratio × font-size)
//
// The line-height-ratio is font-specific and must be empirically tuned.
// Initial value for New Computer Modern: 0.65 (to be refined through comparison)
// ----------------------------------------------------------------------------

// Double-spacing ratio for body text
#let line-height-ratio = 0.8847

#let calc-leading(font-size, baseline) = {
  baseline - (line-height-ratio * font-size)
}

// ----------------------------------------------------------------------------
// Type Conversion Helpers
// ----------------------------------------------------------------------------
// Convert content/string/none to string for PDF metadata (set document())

/// Converts content, string, or none to a plain string.
/// Used for PDF metadata which requires string values.
#let to-string(value) = {
  if value == none {
    none
  } else if type(value) == str {
    value
  } else {
    // Content: extract plain text by rendering to string
    repr(value).replace("\\[", "").replace("\\]", "").trim()
  }
}

// ----------------------------------------------------------------------------
// Short Title State
// ----------------------------------------------------------------------------
// Track short titles for page headers

// Pending short title for next heading (consumed when heading is rendered)
#let pending-short-title = state("pending-short-title", none)

// Dictionary of short titles, keyed by heading body repr
#let short-titles = state("short-titles", (:))

/// Sets a short title for page headers when the full heading is too long.
///
/// Place immediately before a heading to provide an abbreviated version
/// for the running header. The short title appears in the page header
/// while the full title appears in the document body.
///
/// #example(```
/// #short[Methods]
/// == Methodological Approaches to Investigating Complex Phenomena
/// ```)
///
/// - title (content, str): The abbreviated title for headers
///
/// -> none
#let short(title) = {
  pending-short-title.update(title)
}

// Pending heading size override (consumed when heading is rendered)
#let pending-heading-size = state("pending-heading-size", none)

/// Sets a custom font size for the next heading's rendered title.
/// Does NOT affect the TOC entry. Place immediately before a heading.
///
/// #example(```
/// #heading-size(20pt)
/// = A Very Long Chapter Title That Needs To Be Smaller
/// ```)
///
/// - size (length): The font size for the heading title
///
/// -> none
#let heading-size(size) = {
  pending-heading-size.update(size)
}


#let title-page(
  thesis-title: none,
  author: none,
  degree: "Doctor of Philosophy",
  field: none,
  date: none,
  // === Institution ===
  school: "Guarini School of Graduate and Advanced Studies",
  university: "Dartmouth College",
  location: "Hanover, New Hampshire",
  // === Examining Committee ===
  advisor: none,
  examiner-1: none,
  examiner-2: none,
  examiner-3: none,
  dean: none,
  dean-title: "Dean of the Guarini School of Graduate and Advanced Studies",
  // === Title Page Variant ===
  // Options: "standard" ("engineering" and "mals" variants not implemented)
  variant: "standard",
  // === Copyright Page ===
  // Set to (year: int, name: "string" or content) to include a copyright page
  copyright: none,
) = {
  // ==========================================================================
  // TITLE PAGE
  // ==========================================================================

  // Generate title page based on variant

  // Signature line helper (2.66667in width)
  // Matches LaTeX \@signatureline
  // Extra 1pt compensates for minipage [t] alignment differences
  let signature-line(name) = {
    box(width: 2.66667in)[
      #v(0.3in + 1pt)
      #line(length: 2.66667in, stroke: 0.4pt)
      #name
    ]
  }

  // Long signature line for dean (5.5in width)
  // Matches LaTeX \@longsignatureline
  let long-signature-line(content) = {
    box(width: 5.5in)[
      #v(0.3in + 1pt)
      #line(length: 2.66667in, stroke: 0.4pt)
      #content
    ]
  }

  // LaTeX \bigbreak is approximately 12pt with some glue
  let bigbreak = v(12pt, weak: false)

  return [
    // #let page-background = {
    //   place(
    //     top + left,
    //     dx: 0pt,
    //     dy: 0pt,
    //     image("/figs/title_page_signed.png", width: 100%, height: 100%, fit: "stretch"),
    //   )
    // }
    // Title page with isolated margins (main.tex uses \newgeometry{top=1in})
    // Using page() function to scope margins to just this page
    #page(
      margin: (
        left: 1.5in,
        top: 1in,
        bottom: 1in,
        right: 1in,
      ),
      // background: page-background,
    )[
      // Single spacing for title page
      #set par(
        leading: calc-leading(12pt, 14.5pt),
        spacing: calc-leading(12pt, 14.5pt),
        first-line-indent: 0pt,
      )
      #set text(
        font: "New Computer Modern",
        size: 12pt,
        top-edge: "cap-height",
        bottom-edge: "descender",
        lang: "en",
        region: "US",
        hyphenate: false,
      )

      #align(center)[
        // LaTeX \begin{center} adds ~\topsep before first element
        #v(4pt)

        #[
          #set par(
            // leading: calc-leading(11pt, 18pt), // Double spacing (baselineskip = 24pt)
            // spacing: calc-leading(11pt, 18pt),
            justify: false,
          )
          // Title: \bfseries \MakeUppercase{\@title}
          #text(weight: "bold", hyphenate: false, upper(thesis-title))
        ]

        #bigbreak

        // Submission text
        A Thesis \
        Submitted to the Faculty \
        in partial fulfillment of the requirements for the \
        degree of

        #bigbreak

        #degree

        #bigbreak

        in

        #bigbreak

        #field

        #bigbreak

        by #author

        #bigbreak

        #school \
        #university \
        #location

        #bigbreak

        #date

        // \vfill - inside the center environment in LaTeX
        #v(1fr)

        // tabular[t]{cc} - Tuned grid with horizontal offsets to match LaTeX
        #grid(
          columns: (3in, 2.66667in),
          column-gutter: 0pt,
          row-gutter: 1.4pt,
          align: (center, left),
          // Row 1: "Examining Committee:" with 42.55pt left inset to match LaTeX x=378.55
          [], box(width: 2.66667in, inset: (left: 42.55pt))[Examining Committee:],
          // Row 2: phantom underline | Advisor signature with +7pt horizontal offset
          hide(box(width: 3in)[#line(length: 3in)]),
          box(width: 2.66667in + 7pt, inset: (left: 7pt))[#signature-line([(chair) #advisor])],
          // Rows 3-5: empty | Member signatures with +7pt horizontal offset
          [], box(width: 2.66667in + 7pt, inset: (left: 7pt))[#signature-line(examiner-1)],
          [], box(width: 2.66667in + 7pt, inset: (left: 7pt))[#signature-line(examiner-2)],
          [], box(width: 2.66667in + 7pt, inset: (left: 7pt))[#signature-line(examiner-3)],
          // Dean: spans both columns, LEFT-aligned with -6pt horizontal offset
          grid.cell(colspan: 2, align: left)[#h(-6pt)#long-signature-line([#dean \ #dean-title])],
        )

        // LaTeX tabular/center adds ~10pt internal spacing after content
        // This reduces v(1fr) above and pushes committee up
        #v(10.3pt)
      ]
    ]


    // LaTeX dcthesis.cls creates a blank page after title page
    // (from \null\vfil in maketitle, even when no copyright page)
    // This is the back side of the title page when printed
    #pagebreak()
    #pagebreak()
  ]
}

/// Main Dartmouth thesis template function.
///
/// Applies complete thesis formatting conforming to Dartmouth Graduate School
/// guidelines. Includes page layout, typography, heading styles, title page
/// generation, and page numbering. Use with a show rule to format your document.
///
/// #example(```
/// #show: dcthesis.with(
///   title: [My Thesis Title],
///   author: "Author Name",
///   degree: "Doctor of Philosophy",
///   field: "Computer Science",
///   date: "June 2026",
///   advisor: [Prof. January],
///   examiner-1: [Prof. February],
///   examiner-2: [Prof. March],
///   examiner-3: [Prof. April],
/// )
///
/// #frontmatter[
///   = Abstract
///   ...
/// ]
///
/// #mainmatter[
///   = Introduction
///   ...
/// ]
/// ```)
///
/// - title (content, str, none): Thesis title displayed on title page
/// - author (content, str, none): Author name for title page and PDF metadata
/// - degree (content, str, none): Degree name
/// - field (content, str, none): Field of study
/// - date (content, str, none): Graduation date (e.g., "December 2026")
/// - school (content, str, none): Graduate school name
/// - university (content, str, none): University name
/// - location (content, str, none): University location
/// - advisor (content, str, none): Thesis advisor (committee chair)
/// - examiner-1 (content, str, none): Committee member 1
/// - examiner-2 (content, str, none): Committee member 2
/// - examiner-3 (content, str, none): Committee member 3
/// - dean (content, str, none): Dean name for signature line
/// - dean-title (content, str, none): Dean title for signature line
/// - copyright (dictionary, none): Copyright info with `year` and `name` keys; `name` is optional and defaults to author
/// - hyphenate (bool): Enable automatic hyphenation
/// - text-kwargs (dictionary): Additional arguments for `set text()`
/// - page-kwargs (dictionary): Additional arguments for `set page()`
/// - document-kwargs (dictionary): Additional arguments for `set document()`
/// - body (content): Document content
///
/// -> content
#let dcthesis(
  // === Document Metadata ===
  thesis-title: none,
  author: none,
  degree: "Doctor of Philosophy",
  field: none,
  date: none,
  // === Institution ===
  school: "Guarini School of Graduate and Advanced Studies",
  university: "Dartmouth College",
  location: "Hanover, New Hampshire",
  // === Examining Committee ===
  advisor: none,
  examiner-1: none,
  examiner-2: none,
  examiner-3: none,
  dean: none,
  dean-title: "Dean of the Guarini School of Graduate and Advanced Studies",
  // === Title Page Variant ===
  // Options: "standard" ("engineering" and "mals" variants not implemented)
  variant: "standard",
  // === Copyright Page ===
  // Set to (year: int, name: "string" or content) to include a copyright page
  copyright: none,
  // === Drafting Options ===
  hyphenate: none, // Set to false to disable hyphenation (useful for proofreading)
  draft: false, // Set to true to enable draft mode (e.g., show overfull boxes)
  // === Advanced Overrides ===
  text-kwargs: (:), // Additional arguments passed to `set text()`
  page-kwargs: (:), // Additional arguments passed to `set page()`
  document-kwargs: (:), // Additional arguments passed to `set document()` (e.g., keywords, date)
  // === Document Body ===
  body,
) = {
  // ==========================================================================
  // DOCUMENT METADATA (PDF properties)
  // ==========================================================================
  // Visual fields (title, author) from first-level args
  // Additional metadata (keywords, date) via document-kwargs
  // Note: document() requires string values, so we convert content to string

  let hyphenate = if (hyphenate == none or draft == false) { true } else { hyphenate }

  let title-str = to-string(title)
  let author-str = to-string(author)

  let doc-specs = (
    title: if title-str != none { title-str } else { "" },
    author: if author-str != none { (author-str,) } else { () },
    ..document-kwargs,
  )
  set document(..doc-specs)

  // ==========================================================================
  // FONT CONFIGURATION
  // ==========================================================================

  set text(
    font: "New Computer Modern",
    size: 12pt,
    top-edge: "cap-height",
    bottom-edge: "descender",
    lang: "en",
    region: "US",
    hyphenate: hyphenate,
    overhang: true, // allows hyphens, periods, etc. to protrude into margin
    ..text-kwargs,
  )

  // Math font
  show math.equation: set text(
    font: "New Computer Modern Math",
  )

  // ==========================================================================
  // PAGE LAYOUT
  // ==========================================================================
  //
  // Why different top margins for title page vs other pages?
  // --------------------------------------------------------
  // LaTeX uses geometry{top=1.25in} uniformly, but actual content position differs:
  // - Title page (\thispagestyle{empty}): content starts at ~1in from top
  // - Regular pages: content starts at ~1.25in + headheight + headsep from top
  //
  // This happens because fancyhdr reserves header space (headheight=16pt + headsep)
  // on regular pages even when empty style is used elsewhere. The title page,
  // being inside the titlepage environment with empty style, doesn't have this
  // overhead applied the same way.
  //
  // In Typst, we must explicitly use different margins to match this behavior:
  // - Title page: top: 1in (via page() override)
  // - Regular pages: top: 1.25in + 8pt (accounts for header space difference)
  //
  // Alternative approaches considered:
  // - Uniform margins with phantom header on title page: adds complexity
  // - Adjusting header-ascent to absorb the difference: harder to reason about
  // The explicit different-margins approach is clearest for maintenance.

  set page(
    paper: "us-letter",
    margin: (
      left: 1.5in, // Binding requirement
      top: 0.95in + 8pt, // See comment above for why this differs from title page
      bottom: 0.8in,
      right: 0.5in + 0.02in, // +0.02in pad for overhang of hyphens
    ),
    numbering: none, // Controlled per section
    header: none, // Set dynamically
    footer: none, // Set dynamically
    // header-ascent controls how far header is raised into margin (higher = further from body)
    header-ascent: 16pt + 8pt, // NB use this to control the position of the line after the header. use inset to control the position of the text itself.
    // LaTeX footer position: footskip (~0.25in) from body bottom
    footer-descent: 0.18in, // NB use this to control the position of the footer text
    ..page-kwargs,
  )

  // ==========================================================================
  // PARAGRAPH SETTINGS
  // ==========================================================================

  set par(
    first-line-indent: 1.5em, // Matches LaTeX book class default (18pt at 12pt)
    leading: calc-leading(11pt, 18pt), // Double spacing (baselineskip = 24pt)
    spacing: calc-leading(11pt, 18pt),
    justify: true,
    linebreaks: "optimized",
    justification-limits: (
      // for typst 0.14.0 and later
      spacing: (min: 80%, max: 100%), // The spacing entry defines how much the width of spaces between words may be adjusted.
      tracking: (min: -0.009em, max: 0.02em), // The tracking entry defines how much the spacing between letters may be adjusted.
    ),
  )

  // Enable heading numbering (required for counter(heading) to work properly)
  set heading(numbering: "1.1.1.1")

  // ==========================================================================
  // HEADING STYLES
  // ==========================================================================

  // Chapter Headings (Level 1)
  // Matches dcthesis.cls lines 220-231 (titlesec [display] configuration)
  // LaTeX font sizes at 12pt: \LARGE=20pt, \Huge=25pt
  // titlesec [display] default spacing: 50pt before-sep, 40pt after-sep
  show heading.where(level: 1): it => {
    // Check for pending short title and store it
    context {
      let short = pending-short-title.get()
      if short != none {
        pending-short-title.update(none)
        let key = repr(it.body)
        short-titles.update(d => {
          d.insert(key, short)
          d
        })
      }
    }

    // Reset figure counters for chapter-based numbering (e.g., Fig. 2.1)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)

    // LaTeX book class forces chapters to start on new pages (\clearpage)
    pagebreak(weak: true)

    // titlesec default before-sep: 50pt from top margin to first rule
    // Must use v() because block(above:) collapses at page top
    v(58.5pt)

    align(
      center,
      block(
        above: 0pt,
        below: 50.5pt,
        width: 100%,
        breakable: false,
        stack(
          dir: ttb,
          spacing: 12pt, // 1pc gap from bottom rule to title (matches LaTeX \vspace{1pc})
          // Bordered block with top/bottom rules containing chapter label
          // Structure matches LaTeX: rule -> 10pt -> text -> 12pt (sep) -> rule
          block(
            above: 0pt,
            below: 0pt,
            width: 100%,
            stroke: (top: 1pt, bottom: 1pt),
            inset: (top: 25pt, bottom: 25pt),
            {
              // Use baseline bottom-edge so inset measures from baseline to stroke
              // (matches LaTeX where sep is from baseline to next rule)
              set text(top-edge: "cap-height", bottom-edge: "baseline")
              text(
                size: 20pt,
                font: "New Computer Modern Sans",
                weight: "regular",
              )[
                #if type(it.numbering) == function {
                  // Custom numbering (appendices) - numbering function returns full label
                  counter(heading).display(it.numbering)
                } else {
                  // Standard numbering - prepend "Chapter"
                  [Chapter #counter(heading).display("1")]
                }
              ]
            },
          ),
          v(30pt),
          // Chapter title: \Huge\bfseries = 25pt bold (or custom size via #heading-size)
          context {
            let custom-size = pending-heading-size.get()
            if custom-size != none {
              pending-heading-size.update(none)
            }
            let title-size = if custom-size != none { custom-size } else { 25pt }
            set par(justify: false)
            text(size: title-size, weight: "bold", hyphenate: false)[#it.body]
          },
        ),
      ),
    )
  }

  // Section Headings (Level 2)
  // Matches dcthesis.cls lines 233-240 (titlesec [frame] style)
  // LaTeX font sizes at 12pt: \large=14pt, \Large=17pt
  // Frame stroke uses \fboxrule default = 0.4pt
  show heading.where(level: 2): it => {
    // Check for pending short title and store it
    context {
      let short = pending-short-title.get()
      if short != none {
        pending-short-title.update(none)
        let key = repr(it.body)
        short-titles.update(d => {
          d.insert(key, short)
          d
        })
      }
    }

    // Unnumbered sections: simple centered bold text (e.g., Abstract)
    if it.numbering == none {
      block(above: 1.6em * 2, below: 1.3em, width: 100%)[
        #align(center, text(size: 17pt, weight: "bold")[#it.body])
      ]
      return
    }

    // Label text: \sffamily\large = sans-serif 14pt, with \enspace (0.5em) padding
    let label = text(
      font: "New Computer Modern Sans",
      size: 14pt,
      weight: "regular",
    )[#h(0.5em)#if type(it.numbering) == function {
        // Appendix mode - just show number (e.g., "A.1")
        counter(heading).display(it.numbering)
      } else {
        // Standard mode - "Section 1.1"
        [Section #counter(heading).display("1.1")]
      }#h(0.5em)]

    // Title text: \Large\bfseries = 17pt bold, centered (or custom size via #heading-size)
    let title = context {
      let custom-size = pending-heading-size.get()
      if custom-size != none {
        pending-heading-size.update(none)
      }
      let s = if custom-size != none { custom-size } else { 17pt }
      text(size: s, weight: "bold")[#it.body]
    }

    // Frame parameters
    let stroke-width = 0.4pt // \fboxrule default
    let frame-inset = 8pt // titlesec sep parameter
    let label-inset = 0.5em // Horizontal offset from frame edge

    block(above: 1.6em * 2, below: 1.3em, width: 100%)[
      // The frame with title content inside
      #rect(
        width: 100%,
        stroke: stroke-width,
        inset: (
          left: frame-inset,
          right: frame-inset,
          // Extra top padding to make room for the label on the border
          top: frame-inset + 14pt,
          bottom: frame-inset + 9pt,
        ),
      )[
        #align(center, title)
      ]

      // Overlay the label on top border (positioned from top-left of the block)
      // dy centers the label vertically on the border line
      #place(
        top + left,
        dx: label-inset,
        dy: -0.5em,
      )[
        // White background breaks the border line behind the text
        #box(
          fill: white,
          inset: (x: 1pt, y: 3pt),
        )[#label]
      ]
    ]
  }

  // Subsection Headings (Level 3)
  // Matches dcthesis.cls lines 242-247
  show heading.where(level: 3): it => {
    let num = if type(it.numbering) == function {
      counter(heading).display(it.numbering)
    } else {
      counter(heading).display("1.1.1")
    }
    block(
      above: 2.5em,
      below: 0.67em,
      width: 100%,
      stroke: (bottom: 0.4pt),
      inset: (bottom: 0.42em),
    )[
      #text(weight: "bold")[
        #num. #it.body
      ]
    ]
  }

  // Subsubsection Headings (Level 4)
  // Matches dcthesis.cls lines 249-254 (run-in style)
  // Uses block() to prevent first-line-indent on following paragraph (from CogSci pattern)
  show heading.where(level: 4): it => {
    v(2.5em, weak: true)
    (
      block(above: 0pt, below: 0pt)
        + text(
          weight: "bold",
          style: "italic",
          it.body + [. ] + h(0.5em, weak: false),
        )
    )
  }

  show heading.where(level: 5): it => {
    v(0.6em, weak: true)
    (
      block(above: 0pt, below: 0pt)
        + text(
          weight: "bold",
          // style: "italic",
          it.body + [. ] + h(0.5em, weak: false),
        )
    )
  }

  // Figure caption styling
  set figure(
    numbering: n => context {
      let chapter = counter(heading).get().first()
      [#chapter.#n]
    },
    // supplement: [Fig.],
  )
  set figure.caption(separator: [ #sym.bar.v ])
  show figure: set block(breakable: true) // allow figure captions to break across pages
  // Helper: bold the first sentence of caption body (split on first ". ")
  // If the body already starts with #strong[...], it's left as-is.
  let bold-first-sentence(body) = {
    let children = if body.has("children") { body.children } else { (body,) }

    // If first non-space child is already strong, body is pre-formatted
    let first = children.find(c => c.func() != [ ].func())
    if first != none and first.func() == strong {
      return emph(body)
    }

    // Find first ". " in text children and split there
    let before = ()
    let after = ()
    let found = false

    for child in children {
      if found {
        after.push(child)
      } else if child.has("text") and child.text.contains(regex("\.\s")) {
        let t = child.text
        let m = t.match(regex("\.\s"))
        before.push(text(t.slice(0, m.start + 1)))
        after.push(text(t.slice(m.start + 1)))
        found = true
      } else {
        before.push(child)
      }
    }

    if found {
      emph(strong(before.join()))
      emph(after.join())
    } else {
      // Single sentence — make entire caption bold italic
      emph(strong(body))
    }
  }

  show figure.caption: it => {
    set text(size: 11pt) // 2pt smaller than 12pt body
    set par(
      leading: calc-leading(11pt, 18pt), // single spacing
      justify: true,
    )
    set align(left)
    strong[#it.supplement #it.counter.display(it.numbering)]
    it.separator
    bold-first-sentence(it.body)
  }
  show figure.where(
    kind: table,
  ): set figure.caption(position: top)
  // Prevent page break between table caption and table body,
  // while still allowing the table itself to break across pages.
  // Add 1em vertical padding around table figures.
  show figure.where(kind: table): it => block(
    breakable: true,
    above: 1em,
    below: 1em,
  )[
    #block(sticky: true)[#it.caption]
    #it.body
  ]
  show table: it => {
    set par(justify: false)
    it
  }


  title-page(
    thesis-title: thesis-title,
    author: author,
    degree: degree,
    field: field,
    date: date,
    school: school,
    university: university,
    location: location,
    advisor: advisor,
    examiner-1: examiner-1,
    examiner-2: examiner-2,
    examiner-3: examiner-3,
    dean: dean,
    dean-title: dean-title,
    variant: variant,
    copyright: copyright,
  )

  // Copyright page (if requested)
  // Normalize copyright: none, false, or empty dict all mean "no copyright page"
  // If name is omitted, defaults to author argument
  let copyright-info = if copyright == none or copyright == false or copyright == (:) {
    none
  } else if type(copyright) == dictionary and "year" in copyright {
    (
      year: copyright.year,
      name: copyright.at("name", default: author),
    )
  } else {
    assert(
      false,
      message: "copyright must be (year: int) or (year: int, name: \"string\"), got: " + repr(copyright),
    )
  }

  if copyright-info != none {
    v(1fr)
    align(center)[
      Copyright by \
      #copyright-info.name \
      #copyright-info.year
    ]
    v(1fr)
    pagebreak()
  }

  // ==========================================================================
  // DOCUMENT BODY
  // ==========================================================================

  body
}

// ----------------------------------------------------------------------------
// Document Structure Functions
// ----------------------------------------------------------------------------

/// Wraps front matter content with Roman numeral page numbering.
///
/// Front matter includes abstract, preface, acknowledgments, table of contents,
/// and lists of figures/tables. Pages are numbered with lowercase Roman numerals
/// starting at ii (title page counts as i). Level 1 headings are unnumbered.
///
/// #example(```
/// #frontmatter[
///   = Abstract
///   This thesis investigates...
///
///   = Preface
///   I would like to thank...
///
///   #outline(title: "Contents")
/// ]
/// ```)
///
/// - body (content): Front matter content
///
/// -> content
#let frontmatter(body) = {
  set page(
    header: none,
    footer: align(center, context counter(page).display("i")),
    numbering: "i",
  )

  // Disable heading numbering for front matter
  set heading(numbering: none)

  // Unnumbered chapter headings for front matter (matches LaTeX \chapter*)
  // LaTeX \chapter* produces a left-aligned bold title (book class default)
  // LaTeX yMin ~188pt, need v() to position title correctly
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(90pt) // Tuned to match LaTeX \chapter* vertical position

    block(
      above: 0pt,
      below: 50.5pt,
      text(size: 25pt, weight: "bold")[#it.body],
    )
  }

  // counter(page).update(2) // Start at ii (title page is i)

  body
}

/// Wraps main thesis content with Arabic page numbering and running headers.
///
/// Main matter contains the numbered chapters of the thesis. Pages are numbered
/// with Arabic numerals starting at 1. Running headers display chapter and
/// section titles in small caps. Chapter pages have no header (plain style).
///
/// Use `#show: appendices` within mainmatter to switch to appendix numbering.
///
/// #example(```
/// #mainmatter[
///   = Introduction
///   This chapter introduces...
///
///   == Background
///   Previous work has shown...
///
///   = Methods
///   We employed the following methods...
///
///   #show: appendices
///   = Supplementary Materials
///   Additional data...
/// ]
/// ```)
///
/// - body (content): Main thesis content (chapters and appendices)
///
/// -> content
#let mainmatter(body) = {
  let debug-overlay = none
  // Configure page background if debug overlay is enabled
  let page-background = if x-target == "pdf" and debug-overlay != none {
    place(
      top + left,
      dx: 0pt,
      dy: 0pt,
      image("/utils/margins.png", width: 100%, height: 100%, fit: "stretch", page: 1),
    )
  } else {
    none
  }
  set page(
    background: page-background, // DEBUGGING
    header: context {
      let current-page = here().page()

      // LaTeX book class uses \thispagestyle{plain} on chapter pages
      // (no header, just footer). Check if this specific page has a chapter heading.
      let chapter-on-page = query(heading.where(level: 1)).filter(h => h.location().page() == current-page)
      if chapter-on-page.len() > 0 {
        return none
      }

      // Find the current chapter (most recent level 1 heading)
      let all-chapters = query(heading.where(level: 1)).filter(h => h.location().page() <= current-page)
      let current-chapter = if all-chapters.len() > 0 { all-chapters.last() } else { none }

      // Get short titles dictionary
      let shorts = short-titles.get()

      // Find the most recent numbered level 2 heading within the current chapter
      let sect = if current-chapter != none {
        let chapter-loc = current-chapter.location()
        let all-sections = query(heading.where(level: 2)).filter(h => (
          h.location().page() <= current-page and h.location().page() >= chapter-loc.page() and h.numbering != none
        ))
        if all-sections.len() > 0 {
          let s = all-sections.last()
          let nums = counter(heading).at(s.location())
          let num = nums.slice(0, calc.min(2, nums.len())).map(str).join(".")
          // Use short title if available, otherwise full title
          let key = repr(s.body)
          let title = if key in shorts { shorts.at(key) } else { s.body }
          [#num#h(1em)#upper(title)]
        } else {
          none
        }
      } else {
        none
      }

      // Fall back to chapter if no section in current chapter
      let chap = if sect == none and current-chapter != none {
        let c = current-chapter
        // Use short title if available, otherwise full title
        let key = repr(c.body)
        let title = if key in shorts { shorts.at(key) } else { c.body }
        if type(c.numbering) == function {
          [#upper(counter(heading).at(c.location()).map(str).join("."))#h(1em)#upper(title)]
        } else {
          [CHAPTER #counter(heading).at(c.location()).first()#h(1em)#upper(title)]
        }
      } else {
        none
      }

      // Build header content
      let left-mark = if sect != none {
        smallcaps[#sect]
      } else if chap != none {
        smallcaps[#chap]
      } else { [] }

      // Header with rule (matches \headrulewidth{.1pt})
      // Note: Use #short[...] before headings to provide shorter titles for headers
      set text(font: "New Computer Modern Sans", size: 12pt, top-edge: "ascender", bottom-edge: "descender")
      block(height: 1.2em, width: 100%, clip: true, below: 2pt, above: 0pt, align(top + left, left-mark))
      line(length: 100%, stroke: 0.1pt)
    },
    footer: align(center, context counter(page).display("1")),
    numbering: "1",
  )

  counter(page).update(1) // Reset to 1

  body
}

/// Wraps back matter content with continued page numbering and simplified headers.
///
/// Back matter typically contains the bibliography and any additional references.
/// Page numbering continues from main matter. Headers show only the chapter title
/// (right-aligned) without section information. Level 1 headings are unnumbered.
///
/// #example(```
/// #backmatter[
///   #bibliography("references.bib", style: "apa", title: "References")
/// ]
/// ```)
///
/// - body (content): Back matter content (bibliography, indices)
///
/// -> content
#let backmatter(body) = {
  set page(
    header: context {
      let current-page = here().page()

      // LaTeX book class uses \thispagestyle{plain} on chapter pages
      let chapter-on-page = query(heading.where(level: 1)).filter(h => h.location().page() == current-page)
      if chapter-on-page.len() > 0 {
        return none
      }

      // Find the most recent level 1 heading on or before this page
      let all-chapters = query(heading.where(level: 1)).filter(h => h.location().page() <= current-page)
      if all-chapters.len() == 0 {
        return none
      }

      let c = all-chapters.last()
      let right-mark = smallcaps[#upper(c.body)]

      // Header with rule (matches \headrulewidth{.1pt})
      // Use place() for consistent positioning
      block(
        width: 100%,
        height: 1em,
        stroke: (bottom: 0.1pt),
        inset: (bottom: 4pt),
      )[
        #set text(font: "New Computer Modern Sans", size: 12pt)
        #place(right + horizon)[#right-mark]
      ]
    },
    footer: align(center, context counter(page).display("1")),
    numbering: "1",
  )

  // Disable heading numbering for back matter (like frontmatter)
  set heading(numbering: none)

  // Unnumbered chapter headings for back matter (matches LaTeX \chapter*)
  let backmatter-heading(it) = {
    pagebreak(weak: true)
    v(90pt) // Match frontmatter positioning

    block(
      above: 0pt,
      below: 50.5pt,
      text(size: 25pt, weight: "bold")[#it.body],
    )
  }

  show heading.where(level: 1): backmatter-heading

  // Apply same heading style to bibliography's internal heading
  show bibliography: it => {
    show heading.where(level: 1): backmatter-heading
    it
  }

  // Continue page numbering from mainmatter
  body
}

/// Switches heading numbering to appendix style (A, B, C...).
///
/// Use within mainmatter to mark the transition from numbered chapters to
/// lettered appendices. Chapters become "Appendix A", "Appendix B", etc.
/// Sections within appendices are numbered as A.1, A.2, B.1, etc.
///
/// #example(```
/// #mainmatter[
///   = Introduction
///   Main chapter content...
///
///   #show: appendices
///
///   = Supplementary Data
///   This becomes "Appendix A"...
///
///   = Code Listings
///   This becomes "Appendix B"...
/// ]
/// ```)
///
/// - body (content): Appendix content
///
/// -> content
#let appendices(body) = {
  counter(heading).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter("appendices").update(1)

  set heading(
    numbering: (..nums) => {
      let vals = nums.pos()
      let value = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".at(vals.at(0) - 1)
      if vals.len() == 1 {
        return "Appendix " + value
      } else {
        return value + "." + nums.pos().slice(1).map(str).join(".")
      }
    },
  )

  // Override figure numbering: sequential (1, 2, 3...) instead of chapter-prefixed (A.1)
  // Use "Supplementary Figure" / "Supplementary Table" as supplement labels
  set figure(numbering: "1", supplement: [Supplementary Figure])
  show figure.where(kind: table): set figure(supplement: [Supplementary Table])

  /*
  This causes the layout to not converge.
  The show-figure rule reads and updates `after-heading` state inside `context`, creating a layout feedback loop.
  */
  // COMMENTED OUT: causes "layout did not converge" warning.
  // The show-figure rule reads and updates `after-heading` state inside `context`,
  // creating a layout feedback loop. See _memories/convergence-warning-after-heading-state.md
  //
  let after-heading = state("after-heading", false)

  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    after-heading.update(true)
    it
  }

  show figure: it => {
    context {
      if after-heading.get() {
        after-heading.update(false)
      } else {
        pagebreak(weak: true)
      }
    }
    it
  }

  [#pagebreak() #body]
}
