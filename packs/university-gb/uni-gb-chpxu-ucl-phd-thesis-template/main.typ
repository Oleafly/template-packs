// ============================================================
//  MAIN FILE
//  SHOW COMMANDS ETC. DEFINED HERE
//  #include all your files etc
//  Compile with:  typst compile main.typ
//  More details inside ucl-thesis.typ
// ============================================================

#import "ucl-thesis.typ": *
// ============================================================
//  Initialise all show rules here
// ============================================================
#show: thmrules
#show: style-algorithm.with(
  breakable: false,
  placement: none,
  scope: "column",
)
#show: word-count.with(exclude: (heading.where(level: 1)))
#show: codly-init.with()
// ============================================================
//  Initialise the template in ucl-thesis.typ
// ============================================================
#show: ucl-thesis.with(
  title: "THESIS TITLE",
  subtitle: "",
  author: "AUTHOR FULL NAME",
  department: "DEPARTMENT",
  faculty: "FACULTY",
  degree: "Doctor of Philosophy",
  year: "2026",
  supervisors: ("Prof. Jane Doe", "Prof. John Smith"),
  wordcount: total-words,

  // ── Front matter ───────────────────────────────────────────
  abstract: [
    The signed declaration should be followed by an abstract consisting of no more than 300 words. The abstract can be edited inside `main.typ`. <abstract>
  ],

  impact-statement: [
    The abstract should be followed by an impact statement consisting of no more than 500 words. For further information on the content of the Impact Statement, please see the Impact Statement Guidance Notes for Research Students and Supervisors. See #link("https://www.ucl.ac.uk/study/sites/study/files/impact-statement-guidance-notes.pdf"). The impact statement can be edited inside `main.typ`.
  ],
  dedication: [
    The dedication can be edited inside `main.typ`.
  ],
  acknowledgements: [
    The acknowledgements can be edited inside `main.typ`.
  ],

  line-spacing: 1.5,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-list-of-algorithms: true,
)

// ────────────────────────────────────────────────────────────
//  INITIALISE BIBLIOGRAPHY WITH PERGAMON
//    #add-bib-resource is needed before the files you intend to
//     use bibliographies more
//    You then need to use #refsection to wrap the files that
//      share a bibliography
//    I have basically wrapped the entire thesis in one refsection
// ────────────────────────────────────────────────────────────
#add-bib-resource(read("main.bib"))
#refsection(style: numeric-style())[

  // ────────────────────────────────────────────────────────────
  //  DEMO FILE - REMOVE THIS SECTION
  // ────────────────────────────────────────────────────────────

  #include "demo.typ"

  // ────────────────────────────────────────────────────────────
  //  BEGIN: MAIN BODY
  // ────────────────────────────────────────────────────────────

  #show heading.where(level: 1): set heading(supplement: [Chapter])
  // ============================================================
  //  CHAPTER 1 — Introduction
  // ============================================================
  #include "intro/intro.typ"

  // ============================================================
  //  CHAPTER 2 — theory
  // ============================================================
  #include "chapter2/theory.typ"

  // ============================================================
  //  CHAPTER 3 — Experiment
  // ============================================================
  #include "chapter3/experiment.typ"

  // ============================================================
  //  CHAPTER 4 — Conclusions
  // ============================================================
  #include "conclusions/conclusion.typ"

  // ────────────────────────────────────────────────────────────
  //  END: MAIN BODY
  // ────────────────────────────────────────────────────────────
  #pagebreak()
  // ============================================================
  //  APPENDICES
  //  In ucl-thesis.typ, I defined a function which auto-imports
  // all .typ files in a directory
  // ============================================================
  #counter(heading).update(0)
  #include-files("appendix", ("A", "B"))

  // ============================================================
  //  BIBLIOGRAPHY
  // ============================================================
  #pagebreak()

  // this uses pergamon which highlights URLs and can be used for multi-ref management
  #print-bibliography()
] // End refsection
