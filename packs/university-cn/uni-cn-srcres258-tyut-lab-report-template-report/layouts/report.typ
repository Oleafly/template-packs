#import "../utils/style.typ": 字号, 字体

// ============================================================
// Part A: Global document layout
// ============================================================
// Sets A4 paper, 2.54cm margins, default text/paragraph styles,
// and PDF metadata. Wraps the entire document.
#let doc(fonts: (:), info: (:), it) = {
  fonts = 字体 + fonts

  set page(paper: "a4", margin: (x: 2.54cm, y: 2.54cm), numbering: "1", number-align: center)
  set text(font: fonts.宋体, size: 字号.小四, lang: "zh", fallback: true, cjk-latin-spacing: auto)
  set par(leading: 0.65em, justify: true)
  set document(
    title: info.at("experiment-name", default: "实验报告"),
    author: info.at("student-name", default: "学生"),
  )

  it
}

// ============================================================
// Part B: Experiment content block
// ============================================================
// Creates a centered visible title AND an invisible level-1
// heading for TOC detection. The body (`it`) is rendered below.
#let experiment(fonts: (:), title: "", it) = {
  // Separate each experiment onto its own page
  pagebreak(weak: true)

  fonts = 字体 + fonts

  // Page header: current experiment name, same font size as page number (小四 / 12pt)
  set page(header: align(center, text(font: fonts.宋体, size: 字号.小四, title)))

  // Invisible level-1 heading for TOC detection
  {
    set text(size: 0pt, fill: white)
    heading(level: 1, numbering: none, title)
  }

  // Visible centered title
  align(center, text(font: fonts.黑体, size: 字号.三号, weight: "bold", title))

  // Vertical space before body
  v(0.5em)

  it
}

// ============================================================
// Part C: Content area styles (show-rule function)
// ============================================================
// Use as: #show: content-area.with(fonts: fonts)
// Enables first-line indent (2em), styles level-2 headings,
// and fixes indent issues on after-block elements and lists.
#let content-area(fonts: (:), it) = {
  fonts = 字体 + fonts

  // Page numbering: bottom center
  set page(numbering: "1", number-align: center + bottom)

  // Chinese paragraph style: 2em first-line indent on all paragraphs
  set par(first-line-indent: 2em)

  // Suppress auto-numbering — users provide their own heading numbers
  set heading(numbering: none)

  // Level-2 heading style: 黑体 / 四号 / bold / left-aligned
  show heading.where(level: 2): set text(font: fonts.黑体, size: 字号.四号, weight: "bold")
  show heading.where(level: 2): set align(left)

  // Fix: prevent first-line indent (all: true) from applying to
  // text immediately after headings, block math, and figures
  show heading: it => { it; v(0pt) }
  show math.equation.where(block: true): it => { it; v(0pt) }
  show figure: it => { it; v(0pt) }

  // Fix: disable first-line indent for list items
  show list.item: it => { set par(first-line-indent: 0em);   it
}

  it
}

// ============================================================
// Part D: Reset page number helper
// ============================================================
// Resets the page counter to 1. Call before each experiment
// if separate page numbering per experiment is desired.
#let reset-page-number = {
  counter(page).update(1)
}
