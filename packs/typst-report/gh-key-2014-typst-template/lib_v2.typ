// lib_v2.typ

// --- Packages ---
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": num, qty
#import "@preview/cetz:0.5.2": canvas, draw, matrix, vector
#import "@preview/showybox:2.0.4": showybox
#import "@preview/whalogen:0.3.0": ce
// #import "@preview/lilaq:0.6.0" as lq

// --- User-defined Macros ---
#import "utils.typ": *

// --- Language & Caption Mappings ---
// Defines localized labels for figures, tables, equations, and bibliography titles.
#let supplement-labels = (
  ja: (
    fig: "図",
    tab: "表",
    eq: "式",
    citation: "参考文献",
  ),
  en: (
    fig: "Fig.",
    tab: "Table",
    eq: "Eq.",
    citation: "References",
  ),
  en-full: (
    fig: "Figure",
    tab: "Table",
    eq: "Equation",
    citation: "References",
  ),
)

// --- Main Template Setup---
// Configures global document rules such as margins, fonts, paragraphs, and heading spacing.
#let project(
  lang: "ja",
  supplement-lang: "ja",
  heading-numbering: none,
  equation-numbering: none,
  indent: false,
  body,
) = {
  // Select labels dynamically based on the language
  let labels = supplement-labels.at(supplement-lang, default: supplement-labels.ja)

  // --- Page & Document Properties ---
  set page(
    paper: "a4",
    margin: (x: 25mm, y: 30mm),
    numbering: "1",
  )

  set par(
    justify: true,
    first-line-indent: (
      amount: if indent { 1em } else { 0em },
      all: indent,
    ),
    leading: 0.8em,
  )

  // Configure fallback fonts depending on the language
  let font-family = if lang == "ja" {
    ("New Computer Modern", "Harano Aji Mincho", "New Computer Modern Math")
  } else {
    ("New Computer Modern", "New Computer Modern Math")
  }

  let math-font-family = if lang == "ja" {
    ("New Computer Modern Math", "New Computer Modern", "Harano Aji Mincho")
  } else {
    ("New Computer Modern Math", "New Computer Modern")
  }

  set text(
    font: font-family,
    size: 11pt,
    lang: lang,
  )

  // --- Bibliography Configuration ---
  set bibliography(
    title: labels.citation,
    style: "ieee",
  )

  // --- Typography Rules for Math---
  show math.equation: set text(
    font: math-font-family,
  )

  // Use horizontal style for inline fractions
  show math.equation.where(block: false): set math.frac(style: "horizontal")

  // Allow block equations to break across pages
  show math.equation.where(block: true): set block(breakable: true)

  // --- Heading Configuration ---
  set heading(
    numbering: heading-numbering,
  )

  // Add vertical spacing and bold math in headings
  show heading: it => {
    show math.equation: math.bold
    v(0.5em)
    it
    v(0.5em)
  }

  // --- Equation Numbering Logic ---
  // Reset equation counter at level-1 headings if equation-numbering is "1.1"
  show heading.where(level: 1): it => {
    if equation-numbering == "1.1" and heading-numbering != none {
      counter(math.equation).update(0)
    }
    it
  }

  // Format equation numbers (e.g., "(1)" or "(1.1)")
  let target-numbering = if equation-numbering == "1" {
    "(1)"
  } else if equation-numbering == "1.1" {
    (..nums) => {
      let h = counter(heading).at(here())
      if h.len() > 0 and h.at(0) != 0 and heading-numbering != none {
        "(" + str(h.at(0)) + "." + numbering("1", ..nums) + ")"
      } else {
        "(" + numbering("1", ..nums) + ")"
      }
    }
  } else {
    equation-numbering
  }

  set math.equation(
    numbering: target-numbering,
    supplement: labels.eq,
  )

  // --- Tables & Figures ---
  set figure(supplement: labels.fig)
  show figure.where(kind: table): set figure(supplement: labels.tab)
  show figure.where(kind: table): set figure.caption(position: top)

  // --- Main Content ---
  body
}

// --- Layout Component: Thesis Cover Page ---
#let thesis-cover(
  academic-year: "",
  title: "",
  affiliation: "",
  student-id: "",
  author: "",
  supervisor: "",
  date: "",
  lang: "ja",
) = {
  // Hide page numbers for the cover page
  set page(numbering: none)

  align(center + horizon)[
    #if academic-year != "" [
      #text(16pt)[#academic-year #if lang == "ja" [年度 卒業論文] else [Bachelor's Thesis]]
      #v(2em)
    ]

    #text(24pt, weight: "bold")[#title]

    #v(8em)

    // Grid alignment for metadata fields
    #align(center)[
      #block(width: 65%)[
        #grid(
          columns: (auto, 1fr),
          row-gutter: 1.2em,
          align: (right, left),
          if lang == "ja" [所属:] else [Affiliation:], h(1em) + affiliation,
          if lang == "ja" [学生番号:] else [Student ID:], h(1em) + student-id,
          if lang == "ja" [氏名:] else [Author:], h(1em) + author,
          if lang == "ja" [指導教員:] else [Supervisor:], h(1em) + supervisor,
          if lang == "ja" [提出日:] else [Date:], h(1em) + date,
        )
      ]
    ]
  ]
  pagebreak()
}

// --- Layout Component: Report Header ---
// Generates a compact top header for shorter documents or reports that do not require a separate cover page.
#let report-header(
  title: "",
  author: "",
  student-id: "",
  date: none,
  lang: "ja",
) = {
  align(center)[
    #text(17pt, weight: "bold")[#title]
    #v(1em)
  ]
  align(center)[
    #if student-id != "" [ #student-id ]
    #if student-id != "" and author != "" [ #h(2em) ]
    #if author != "" [ #author ]
    #if (student-id != "" or author != "") and date != none [ \ ]
    #if date != none [#date]
  ]
  v(2em)
}

// --- Layout Component: Abstract ---
// Formats the abstract/summary section.
#let thesis-abstract(
  lang: "ja",
  body,
) = {
  let heading-title = if lang == "ja" { "概要" } else { "Abstract" }
  align(center)[
    #text(14pt, weight: "bold")[#heading-title]
    #v(1.2em)
  ]

  block(width: 90%, align(left)[
    #set par(first-line-indent: 1em)
    #body
  ])
  pagebreak()
}

// --- Layout Component: Table of Contents ---
// Generates the table of contents and resets the page numbering system.
// Front matter (TOC, abstract) uses Roman numerals (i, ii...), while the main body resets to Arabic numerals (1, 2...).
#let thesis-toc(
  lang: "ja",
) = {
  // Use Roman numerals for the TOC page
  set page(numbering: "i")
  counter(page).update(1)

  let label_of_toc = if lang == "ja" { "目次" } else { "Table of Contents" }
  align(center)[#text(16pt, weight: "bold")[#label_of_toc]]
  v(1.2em)
  outline(title: none, indent: auto)

  pagebreak()
  // Reset and switch to Arabic numerals for the following main body pages
  set page(numbering: "1")
  counter(page).update(1)
}
