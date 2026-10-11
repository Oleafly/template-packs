// =============================================================================
// TECHNICAL.TYP - Technical/Programming Book Template
// =============================================================================
// Perfect for: programming books, technical manuals, documentation
// Features: code blocks, callouts, numbered sections, glossary, index
// =============================================================================

#import "../lib/core/theme.typ": *
#import "../lib/core/config.typ": *
#import "../lib/styles.typ": *
#import "../lib/components/front-matter.typ": *
#import "../lib/components/toc.typ": *
#import "../lib/components/decorative.typ": *
#import "../lib/components/back-matter.typ": *

/// Technical book template with sensible defaults
#let technical(
  // Metadata
  title: "Technical Guide",
  subtitle: none,
  author: "Author Name",
  publisher: none,
  date: datetime.today().display("[month repr:long] [year]"),
  version: none,
  isbn: none,
  
  // Layout
  paper: "a4",
  font-size: 10pt,
  language: "en",
  
  // Options
  show-toc: true,
  toc-depth: 3,
  
  // Content
  body
) = {
  // Page setup
  set page(
    paper: paper,
    margin: (inside: 2.5cm, outside: 2cm, top: 2.5cm, bottom: 2.5cm),
    numbering: "1",
    header: context {
      let elems = query(selector(heading.where(level: 1)).before(here()))
      if elems.len() > 0 {
        let chapter = elems.last().body
        align(right)[
          #text(size: 0.9em, style: "italic", fill: gray.darken(20%))[#chapter]
        ]
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt + gray)
      }
    },
  )
  
  // Typography - clean sans-serif for readability
  set text(
    font: ("Helvetica", "Arial"),
    size: font-size,
    lang: language,
  )
  
  set par(
    justify: true,
    leading: 0.7em,
  )
  
  // Headings - numbered, modern style
  set heading(numbering: "1.1.")
  
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1em)
    block[
      #text(size: 0.9em, weight: "regular", fill: gray.darken(20%))[
        Chapter #counter(heading).display()
      ]
      #v(0.3em)
      #text(size: 2em, weight: "bold")[#it.body]
    ]
    v(1.5em)
  }
  
  show heading.where(level: 2): it => {
    v(1.5em)
    text(size: 1.4em, weight: "semibold")[
      #counter(heading).display() #it.body
    ]
    v(0.8em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    text(size: 1.15em, weight: "medium")[
      #counter(heading).display() #it.body
    ]
    v(0.5em)
  }
  
  // Code block styling
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: rgb("#f6f8fa"),
      stroke: 1pt + rgb("#e1e4e8"),
      radius: 4pt,
      inset: 12pt,
    )[
      #set text(font: ("JetBrains Mono", "Fira Code", "Courier New"), size: 0.9em)
      #it
    ]
  }
  
  // Inline code styling
  show raw.where(block: false): box.with(
    fill: rgb("#f6f8fa"),
    inset: (x: 4pt, y: 2pt),
    outset: (y: 2pt),
    radius: 2pt,
  )
  
  // Front matter
  set page(numbering: none)
  
  // Title page
  title-page(
    title: title,
    subtitle: if version != none { subtitle + " v" + version } else { subtitle },
    author: author,
    publisher: publisher,
    date: date,
  )
  
  // Copyright page
  copyright-page(
    title: title,
    author: author,
    publisher: publisher,
    isbn: isbn,
    edition: if version != none { "Version " + version },
  )
  
  // Table of contents
  if show-toc {
    set page(numbering: "i")
    counter(page).update(1)
    toc-dotted(depth: toc-depth)
  }
  
  // Main content
  set page(numbering: "1")
  counter(page).update(1)
  
  body
}

// -----------------------------------------------------------------------------
// Technical book components
// -----------------------------------------------------------------------------

/// Tip/Note/Warning callout boxes
#let callout(body, type: "note", title: none) = {
  let colors = (
    note: (bg: rgb("#e7f3ff"), border: rgb("#4a90d9"), icon: "i"),
    tip: (bg: rgb("#e6f7e6"), border: rgb("#2da44e"), icon: sym.checkmark),
    warning: (bg: rgb("#fff8e6"), border: rgb("#d4a72c"), icon: "!"),
    danger: (bg: rgb("#ffebe9"), border: rgb("#cf222e"), icon: sym.times),
    important: (bg: rgb("#f5e6ff"), border: rgb("#8250df"), icon: sym.star),
  )
  
  let style = colors.at(type, default: colors.note)
  let default-titles = (
    note: "Note",
    tip: "Tip", 
    warning: "Warning",
    danger: "Danger",
    important: "Important",
  )
  
  block(
    width: 100%,
    fill: style.bg,
    stroke: (left: 4pt + style.border),
    inset: 12pt,
    radius: (right: 4pt),
  )[
    #text(weight: "bold", fill: style.border)[
      #style.icon #h(0.3em) #if title != none { title } else { default-titles.at(type, default: "Note") }
    ]
    #v(0.5em)
    #body
  ]
}

/// Shorthand callouts
#let note(body, title: none) = callout(body, type: "note", title: title)
#let tip(body, title: none) = callout(body, type: "tip", title: title)
#let warning(body, title: none) = callout(body, type: "warning", title: title)
#let danger(body, title: none) = callout(body, type: "danger", title: title)
#let important(body, title: none) = callout(body, type: "important", title: title)

/// Code listing with filename/caption
#let code-listing(code, filename: none, language: none, caption: none) = {
  block(width: 100%)[
    #if filename != none {
      block(
        width: 100%,
        fill: rgb("#24292f"),
        inset: (x: 12pt, y: 6pt),
        radius: (top: 4pt),
      )[
        #text(fill: white, size: 0.85em, font: "Courier New")[#filename]
      ]
    }
    #block(
      width: 100%,
      fill: rgb("#f6f8fa"),
      stroke: 1pt + rgb("#e1e4e8"),
      radius: if filename != none { (bottom: 4pt) } else { 4pt },
      inset: 12pt,
    )[
      #set text(font: ("JetBrains Mono", "Fira Code", "Courier New"), size: 0.9em)
      #if language != none {
        raw(code, lang: language, block: true)
      } else {
        raw(code, block: true)
      }
    ]
    #if caption != none {
      v(0.3em)
      text(size: 0.9em, style: "italic")[#caption]
    }
  ]
}

/// Terminal/shell output block
#let terminal(content) = {
  block(
    width: 100%,
    fill: rgb("#1e1e1e"),
    stroke: 1pt + rgb("#333"),
    radius: 4pt,
    inset: 12pt,
  )[
    #set text(fill: rgb("#d4d4d4"), font: ("JetBrains Mono", "Fira Code"), size: 0.9em)
    #content
  ]
}

/// Keyboard shortcut styling
#let kbd(key) = {
  box(
    fill: rgb("#f6f8fa"),
    stroke: 1pt + rgb("#d0d7de"),
    radius: 3pt,
    inset: (x: 5pt, y: 2pt),
  )[
    #text(font: "Courier New", size: 0.85em)[#key]
  ]
}

/// Definition list for API docs
#let def-list(..items) = {
  for item in items.pos() {
    block(spacing: 0.8em)[
      #text(weight: "bold", font: "Courier New")[#item.term]
      #if "type" in item {
        h(0.5em)
        text(size: 0.85em, fill: gray)[#item.type]
      }
      #v(0.3em)
      #pad(left: 1.5em)[#item.desc]
    ]
  }
}

/// Figure with code and result side by side
#let code-result(code-block, result, caption: none) = {
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #text(size: 0.85em, weight: "semibold")[Code]
      #code-block
    ],
    [
      #text(size: 0.85em, weight: "semibold")[Result]
      #block(
        width: 100%,
        stroke: 1pt + rgb("#e1e4e8"),
        radius: 4pt,
        inset: 12pt,
      )[#result]
    ],
  )
  if caption != none {
    v(0.3em)
    align(center)[#text(size: 0.9em, style: "italic")[#caption]]
  }
}

/// Exercise/Problem box
#let exercise(body, number: none, difficulty: none) = {
  let diff-colors = (
    easy: rgb("#2da44e"),
    medium: rgb("#d4a72c"),
    hard: rgb("#cf222e"),
  )
  
  block(
    width: 100%,
    stroke: 2pt + rgb("#4a90d9"),
    radius: 4pt,
    inset: 12pt,
  )[
    #grid(
      columns: (auto, 1fr, auto),
      gutter: 0.5em,
      [#text(weight: "bold")[Exercise #if number != none { number }]],
      [],
      [#if difficulty != none {
        text(
          size: 0.85em,
          fill: diff-colors.at(difficulty, default: gray),
          weight: "medium"
        )[#upper(difficulty)]
      }],
    )
    #v(0.5em)
    #body
  ]
}

/// Solution (collapsible in some viewers)
#let solution(body, title: "Solution") = {
  block(
    width: 100%,
    fill: rgb("#f6f8fa"),
    stroke: 1pt + rgb("#e1e4e8"),
    radius: 4pt,
    inset: 12pt,
  )[
    #text(weight: "bold", style: "italic")[#title]
    #v(0.5em)
    #body
  ]
}

/// Version/API badge
#let badge(text-content, color: rgb("#4a90d9")) = {
  box(
    fill: color.lighten(80%),
    stroke: 1pt + color,
    radius: 3pt,
    inset: (x: 6pt, y: 2pt),
  )[
    #text(size: 0.8em, fill: color.darken(20%), weight: "medium")[#text-content]
  ]
}

/// Deprecated notice
#let deprecated(message: none, since: none) = {
  callout(type: "warning", title: "Deprecated")[
    This feature is deprecated#if since != none [ since version #since].
    #if message != none [
      #v(0.3em)
      #message
    ]
  ]
}
