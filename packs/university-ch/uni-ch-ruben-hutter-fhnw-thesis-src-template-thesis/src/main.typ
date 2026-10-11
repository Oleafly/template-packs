#import "lib.typ": *

// ============================================================================
// Re-exports - make every utility available through the public API
// ============================================================================

#let fhnw-yellow = fhnw-yellow
#let fhnw-dark-gray = fhnw-dark-gray
#let fhnw-gray = fhnw-gray
#let fhnw-red = fhnw-red
#let fhnw-light-red = fhnw-light-red
#let fhnw-light-gray = fhnw-light-gray
#let fhnw-teal = fhnw-teal
#let fhnw-black = fhnw-black
#let fhnw-white = fhnw-white

#let todo = todo
#let todo-missing = todo-missing
#let todo-check = todo-check
#let todo-revise = todo-revise
#let todo-citation = todo-citation
#let todo-language = todo-language
#let todo-question = todo-question
#let todo-note = todo-note

#let unnumbered-chapter = unnumbered-chapter
#let algorithm = algorithm
#let important = important
#let definition = definition
#let theorem = theorem
#let ie = ie
#let eg = eg
#let cf = cf
#let etal = etal

#let default-sections = (
  (size: 15pt, weight: "bold", space-before: 28pt, space-after: 10pt),  // section (level 2)
  (size: 12pt, weight: "bold", space-before: 22pt, space-after: 8pt),   // subsection (level 3)
  (size: 11pt, weight: "bold", space-before: 18pt, space-after: 6pt),   // subsubsection (level 4)
)
#let default-section = (size: 11pt, weight: "bold", space-before: 18pt, space-after: 6pt)

// ============================================================================
// Main thesis setup function
// ============================================================================

#let thesis(
  // --- Metadata ---
  title: "Thesis Title",
  subtitle: none,
  author: "Author Name",
  email: "",
  student-id: "",
  supervisor: "",
  expert: "",
  thesis-type: "Bachelor Thesis",
  university: "University of Applied Sciences and Arts Northwestern Switzerland",
  school: "School of Computer Science",
  institute: "Institute of Mobile and Distributed Systems",
  location: "Brugg-Windisch, Switzerland",
  date: datetime.today(),
  language: "en",

  // --- Fonts ---
  body-font: default-fonts.body,
  sans-font: default-fonts.sans,
  mono-font: default-fonts.mono,

  // --- Font sizes ---
  body-size: 11pt,
  mono-size: 10pt,
  footnote-size: 9pt,
  header-size: 9pt,

  // --- Paragraph ---
  // First-line indent for body paragraphs (every paragraph indented except the
  // first one after a heading). Set to `0pt` for the modern block style.
  paragraph-indent: 1em,

  // --- Heading sizes ---
  chapter-number-size: 60pt,
  chapter-title-size: 24pt,
  sections: default-sections,
  default-section: default-section,

  // --- Font weights ---
  chapter-number-weight: "bold",
  chapter-title-weight: "bold",

  // --- Logos ---
  logo: auto,                       // auto | none | path-string | image-element
  swiss-universities-logo: auto,    // auto | none | path-string | image-element
  logo-width: 7.5cm,
  swiss-universities-height: 0.45cm,

  // --- Compilation modes ---
  draft: false,                     // render TODO markers + draft badge (opt-in; demo enables it explicitly)
  colored: true,                    // use colors for environments

  // --- Content ---
  abstract: [],
  abstract-title: none,        // override front-matter heading (e.g. "Executive Summary"); none = language default
  acknowledgments: none,
  chapters: (),
  appendices: (),
  bibliography-content: none,
  body,
) = {

  // Persist configuration into queryable state
  thesis-draft-state.update(draft)
  thesis-color-state.update(colored)
  set document(title: title, author: author)

  // --- Language labels ---
  let labels = (
    en: (
      abstract: "Abstract", acknowledgments: "Acknowledgments",
      toc: "Table of Contents", bibliography: "Bibliography",
      supervisor: "Supervisor", expert: "Expert",
      date-format: "[month repr:long] [day], [year]",
    ),
    de: (
      abstract: "Zusammenfassung", acknowledgments: "Danksagung",
      toc: "Inhaltsverzeichnis", bibliography: "Literaturverzeichnis",
      supervisor: "Betreuender Dozent", expert: "Experte",
      date-format: "[day]. [month repr:long] [year]",
    ),
  )
  let l = labels.at(language, default: labels.en)

  // --- Resolve logos into image elements ---
  let resolve-logo = (opt, ..args) => {
    if opt == none { return none }
    if opt == auto { return image(..args) }
    if type(opt) == str { return image(opt, ..args) }
    return opt
  }
  let logo-img = resolve-logo(logo, "assets/fhnw-logo.png", width: logo-width)
  let uni-img = resolve-logo(
    swiss-universities-logo, "assets/swissuniversity.png",
    height: swiss-universities-height,
  )

  // --- Page setup ---
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 3cm, top: 2.5cm, bottom: 2.5cm),
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        let on-chapter-page = query(heading.where(level: 1)).any(h =>
          h.location().page() == here().page()
        )
        if not on-chapter-page {
          set text(size: header-size, font: body-font, fill: fhnw-gray)
          let headings = query(heading.where(level: 1).before(here()))
          let chapter-name = if headings.len() > 0 { headings.last().body } else { [] }
          grid(
            columns: (1fr, auto),
            align: (left, right),
            chapter-name,
            counter(page).display(),
          )
          v(-0.65em)
          line(length: 100%, stroke: 0.3pt + fhnw-light-gray)
        }
      }
    },
    footer: [],
  )

  // --- Typography ---
  set text(font: body-font, size: body-size, lang: language)
  show raw: set text(font: mono-font, size: mono-size, lang: language)

  // Body line leading. Also used as the inter-paragraph spacing so a paragraph
  // break has the same height as a normal line (uniform vertical rhythm).
  let lead = 0.65em * 1.5

  set par(
    justify: true,
    leading: lead,
  )

  // Scientific paragraph style for flowing prose (abstract, acknowledgments,
  // chapters, appendices): first-line indent on every paragraph except the one
  // right after a heading (Typst does this automatically). Structural pages
  // (title page, ToC, bibliography) keep the default block style. Set
  // `paragraph-indent: 0pt` to revert fully to the modern block style.
  let prose(body) = {
    set par(
      first-line-indent: paragraph-indent,
      spacing: if paragraph-indent > 0pt { lead } else { auto },
    )
    body
  }

  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt),
    gap: 0.65em,
  )
  show footnote.entry: it => { set text(size: footnote-size); it }

  // --- Heading numbering ---
  set heading(numbering: (..nums) => {
    let level = nums.pos().len()
    if level == 1 { numbering("1", ..nums) }
    else { numbering("1.", ..nums) }
  })

  set math.equation(numbering: "1.")

  // --- Heading rendering ---
  show heading: it => {
    if it.level == 1 {
      // Chapter opener
      pagebreak(weak: true)
      v(3cm)
      block(width: 100%)[
        #if it.numbering != none [
          #text(
            size: chapter-number-size,
            font: sans-font,
            weight: chapter-number-weight,
            fill: fhnw-light-gray,
          )[#counter(heading).display()]
          #v(0.2em)
        ]
        #text(
          size: chapter-title-size,
          font: sans-font,
          weight: chapter-title-weight,
          fill: fhnw-dark-gray,
        )[#it.body]
      ]
      v(0.4em)
      line(length: 35%, stroke: 2.5pt + fhnw-yellow)
      v(1.5em)
    } else {
      // Sections / subsections
      let idx = calc.min(it.level - 2, sections.len() - 1)
      let s = if idx < 0 { default-section } else { sections.at(idx, default: default-section) }
      v(s.space-before, weak: true)
      block(breakable: false)[
        #set text(size: s.size, font: sans-font, weight: s.weight, fill: fhnw-dark-gray)
        #it
      ]
      v(s.space-after, weak: true)
    }
  }

  show link: it => text(fill: fhnw-teal, it)

  // Collect optional title-page lines up front so each block can be rendered
  // (and spaced) only when it actually has content. This keeps the layout
  // clean when subtitle / supervisor / expert / institute fields are omitted.
  let institute-lines = ()
  if school != "" { institute-lines.push(school) }
  if institute != "" { institute-lines.push(institute) }
  if university != "" { institute-lines.push(university) }

  let supervision-lines = ()
  if supervisor != "" {
    supervision-lines.push(
      text(weight: "bold", fill: fhnw-gray)[#l.supervisor:] + h(0.4em) + [#supervisor]
    )
  }
  if expert != "" {
    supervision-lines.push(
      text(weight: "bold", fill: fhnw-gray)[#l.expert:] + h(0.4em) + [#expert]
    )
  }

  // ========================================================================
  // TITLE PAGE
  // ========================================================================

  page(
    margin: (left: 0cm, right: 0cm, top: 0cm, bottom: 0cm),
    header: none,
    footer: none,
  )[
    #set align(left)

    // Yellow header band with logos
    #block(width: 100%, height: 3.6cm, fill: fhnw-yellow)[
      #pad(x: 3cm, y: 1.1cm)[
        #grid(
          columns: (1fr, auto),
          align: (left, right + horizon),
          if logo-img != none { logo-img },
          if uni-img != none { uni-img },
        )
      ]
    ]

    // Draft badge
    #if draft {
      place(top + right, dx: -0.6cm, dy: 0.3cm)[
        #block(
          fill: fhnw-red.lighten(85%),
          stroke: (paint: fhnw-red, thickness: 0.5pt),
          radius: 3pt,
          inset: 7pt,
        )[
          #text(size: 9pt, fill: fhnw-red, weight: "bold")[DRAFT] \
          #text(size: 8pt, fill: fhnw-red)[#datetime.today().display("[day].[month].[year]")]
        ]
      ]
    }

    // Title page body
    #pad(x: 3cm, y: 1.5cm)[
      // --- Top group: thesis type, title, optional subtitle ---
      #v(1.6cm)

      #text(size: 11pt, tracking: 3pt, fill: fhnw-gray)[#upper(thesis-type)]

      #v(1.2cm)

      #block(spacing: 0pt)[
        #set par(leading: 0.55em)
        #text(size: 28pt, font: sans-font, weight: "bold", fill: fhnw-dark-gray)[#title]
      ]

      #if subtitle != none [
        #v(0.4cm)
        #block(spacing: 0pt)[
          #set par(leading: 0.6em)
          #text(size: 15pt, font: sans-font, fill: fhnw-gray)[#subtitle]
        ]
      ]

      // Flexible gap: absorbs all remaining vertical space and pushes the
      // block below to the bottom of the page. It is inherently page-relative,
      // so the layout adapts to whichever optional fields are present.
      #v(1fr)

      // --- Bottom group: author, institute, supervision, location/date ---

      // Author block
      #block[
        #text(size: 12pt, weight: "bold", fill: fhnw-black)[#author]
        #if email != "" [
          #v(0.2em, weak: true)
          #text(size: 10pt, fill: fhnw-gray)[#email]
        ]
        #if student-id != "" [
          #v(0.2em, weak: true)
          #text(size: 10pt, fill: fhnw-gray)[#student-id]
        ]
      ]

      // Institutional block (only if any institutional info is provided)
      #if institute-lines.len() > 0 [
        #v(1cm)
        #block[
          #set par(leading: 0.55em)
          #text(size: 11pt, fill: fhnw-dark-gray)[#institute-lines.join(linebreak())]
        ]
      ]

      // Supervision block (only if a supervisor or expert is provided)
      #if supervision-lines.len() > 0 [
        #v(1cm)
        #block[
          #set par(leading: 0.55em)
          #text(size: 10pt, fill: fhnw-black)[#supervision-lines.join(linebreak())]
        ]
      ]

      // Location + date
      #v(1cm)
      #text(size: 11pt, fill: fhnw-dark-gray)[
        #location, #date.display(l.date-format)
      ]
    ]
  ]

  // ========================================================================
  // FRONT MATTER
  // ========================================================================

  if abstract != [] {
    pagebreak()
    unnumbered-chapter(if abstract-title == none { l.abstract } else { abstract-title })
    prose(abstract)
  }

  if acknowledgments != none {
    pagebreak()
    unnumbered-chapter[#l.acknowledgments]
    prose(acknowledgments)
  }

  pagebreak()
  unnumbered-chapter[#l.toc]
  outline(indent: auto, title: none)

  // ========================================================================
  // MAIN MATTER
  // ========================================================================

  pagebreak()
  prose({
    for chapter-content in chapters { chapter-content }
    body
  })

  // ========================================================================
  // BACK MATTER
  // ========================================================================

  if bibliography-content != none {
    pagebreak()
    unnumbered-chapter[#l.bibliography]
    bibliography-content
  }

  if appendices.len() > 0 {
    pagebreak()
    set heading(numbering: (..nums) => {
      let level = nums.pos().len()
      if level == 1 { numbering("A", ..nums) }
      else if level <= 3 { numbering("A.1", ..nums) }
    })
    counter(heading).update(0)
    prose({
      for appendix-content in appendices { appendix-content }
    })
  }
}
