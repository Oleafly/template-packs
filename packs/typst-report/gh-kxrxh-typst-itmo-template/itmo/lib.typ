// ===== FONT AND LAYOUT SETUP =====

#let setup(body) = {
  set text(
    font: "New Computer Modern",
    lang: "ru",
    ligatures: true,
  )
  set page(
    paper: "a4",
    margin: (top: 20mm, right: 10mm, bottom: 20mm, left: 30mm),
    numbering: "1",
  )
  set par(
    first-line-indent: (amount: 1.25cm, all: true),
  )

  set heading(numbering: "1.")

  show heading: it => {
    it
    v(0.5em)
  }

  set table(
    stroke: 0.5pt + rgb("#000000"),
    fill: (_, row) => if row == 0 { rgb("#f0f0f0") } else { none },
    align: (col, row) => if row == 0 { center } else { left },
  )

  show raw: set text(
    features: ("calt", "liga"),
  )

  show raw: it => {
    block(
      fill: rgb("#fafafa"),
      inset: 8pt,
      radius: 2pt,
      stroke: 0.5pt + rgb("#383a42"),
      width: 100%,
      it,
    )
  }

  body
}


// ===== UTILITY FUNCTIONS =====

// Function to include code from files
#let code(filename, lang: none) = {
  raw(read(filename), lang: lang)
}

// Function to create code blocks
#let code-block(content, lang: none) = {
  raw(content, lang: lang)
}

// Table utilities
#let nl = table.cell

// ===== TITLE PAGE FUNCTION =====

// ITMO lab report title page
#let itmo-title-page(
  variant: "aboba",
  labn: "aboba",
  worktype: "Рефакторинг этап",
  discipline: "aboba",
  group: "aboba",
  student1: "aboba",
  student2: "aboba",
  teacher: "aboba",
  year: "2025",
  logo: "itmo.png",
) = {
  // Title page with no page number
  set page(numbering: none, footer: none)

  align(center)[
    // Ministry and University headers (matching LaTeX layout)
    #text(size: 12pt, weight: "bold")[
      Министерство науки и высшего образования Российской Федерации\
      Федеральное государственное автономное образовательное учреждение\
      высшего образования\
      «Национальный исследовательский университет ИТМО»\
      Факультет программной инженерии и компьютерной техники
    ]

    #v(1cm)

    // ITMO Logo (larger size for better visibility)
    #if logo != none {
      image(logo, width: 50%)
    }

    #v(4cm)

    #text(size: 14pt, weight: "bold")[
      #worktype № #labn\
      #text(weight: "regular")[по дисциплине]\
      #text(weight: "bold")[#discipline]
    ]


    #v(1fr)
  ]

  // Students and group (right-aligned)
  align(right)[
    #text(size: 12pt)[
      #if student2 == "aboba" or student2 == "" [
        Выполнил студент группы #group\
        #text(weight: "bold")[#student1]
      ] else [
        Выполнили студенты группы #group\
        #text(weight: "bold")[#student1]\
        #text(weight: "bold")[#student2]
      ]\
      \
      Преподаватель\
      #text(weight: "bold")[#teacher]
    ]
  ]

  // City and year (centered)
  align(center)[
    #v(1cm)
    #text(size: 12pt)[
      г. Санкт-Петербург\
      #year г.
    ]
  ]

  pagebreak()
}

// ===== EXPORT FUNCTIONS =====

// Export all functions and configurations for use in documents
(
// Main setup function - MUST be called first in your document
setup: setup,

// Main functions
itmo-title-page: itmo-title-page,
code: code,
code-block: code-block,

// Utility functions
nl: nl
)
