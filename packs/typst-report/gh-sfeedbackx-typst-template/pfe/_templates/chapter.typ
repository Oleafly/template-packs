// ======================================================
// CHAPTER TEMPLATE
// ------------------------------------------------------
// This file defines the `chapter_page()` function that
// provides consistent layout, headers, footers, and
// typographic settings for every chapter.
//
// USAGE:
//   #import "../_templates/chapter.typ": *
//
//   #chapter_page("1", [Chapter Title])[
//     Your content here...
//   ]
// ======================================================

#import "../_lib/utils.typ": chapter_outline, inline_title, title_box_chapter

// Renders a full chapter page with title, outline, and content.
// - chapter_num: string (e.g. "1", "2")
// - chapter_title: content block
// - body: chapter content
#let chapter_page(chapter_num, chapter_title, body) = {
  // cover page for chapter
  set page(footer: none, numbering: none)

  // Chapter title page with centered heading
  show heading.where(level: 1): it => {
    set align(center)
    text(size: 24pt, weight: "bold")[#it.body]
  }

  inline_title[Chapter #chapter_num]

  title_box_chapter(heading(context {
    let h = heading()[#chapter_title]
    h.body
  }))

  v(80pt)

  // Auto-generated outline of section headings in this chapter
  chapter_outline()

  // Main content page settings with header and footer
  set page(
    paper: "a4",
    footer: context {
      stack(
        dir: ttb,
        spacing: 5pt,
        line(length: 100%, stroke: 0.5pt),
        align(center, counter(page).display()),
      )
    },
    numbering: "1",
    margin: (top: 2.5cm, left: 3cm, right: 2cm, bottom: 2.5em),
    header: context {
      let doc_title = if document.title != none {
        "Chapter " + chapter_num + "." + h(5pt) + document.title
      } else {
        "No Title Set"
      }

      align(left + horizon)[
        #block(
          width: 100%,
          stroke: (bottom: 0.7pt),
          inset: (bottom: 5pt),
          below: 0pt,
          text(style: "italic", size: 12pt, doc_title),
        )
      ]
    },
  )
  // Typography settings
  set text(size: 12pt, lang: "en", hyphenate: false)

  set par(
    justify: true,
    leading: 0.75em,
    first-line-indent: 0.5cm,
    spacing: 1.2em,
  )

  // List styling
  set list(
    indent: 1.8em,
    spacing: 1em,
    body-indent: 0.5em,
    marker: ([•], [–], [◦]),
  )

  // Table styling with dark header row and zebra striping
  show table.cell.where(y: 0): set text(weight: "bold", fill: white)
  set table(
    stroke: 0.5pt + black,
    inset: 8pt,
    align: left,
    fill: (col, row) => if row == 0 { rgb("#1a1a6e") }
    else if calc.odd(row) { luma(245) }
    else { white },
  )

  // Table figures: breakable across pages, italic caption
  show figure.where(kind: table): it => {
    set block(breakable: true)
    set text(size: 10pt, style: "italic")
    it
  }

  set figure(gap: 0.7em)

  show figure.caption: it => {
    set text(size: 10pt, style: "italic")
    set align(center)
    it
  }

  // Render the chapter content
  body
}
