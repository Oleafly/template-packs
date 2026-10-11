// LTeX: enabled=false
#import "template.typ": project, caption_with_source

#show: project.with(

  // ── Language ───────────────────────────────────────────────────────────────
  // "en" for English, "de" for German.
  lang: "en",

  // ── Submission options ─────────────────────────────────────────────────────
  // Remove confidentiality clause by setting to false
  confidentiality_clause: true,

  // ── Cover page ─────────────────────────────────────────────────────────────
  title_long:  "A thesis about writing a thesis in Typst that is really long and needs a lot of space and is therfore spanning over 3 lines ",
  title_short: "Writing in Typst",
  thesis_type: "Bachelor Thesis",
  faculty:     "Faculty of Business",
  program:     "Business Informatics",

  firstname:            "Max",
  lastname:             "Mustermann",
  course:               "XXXXX",
  signature_place:      "Karlsruhe",
  submission_date:      "04.04.2026",

  partner_company:      "Company_name",
  supervisor_university: "supervisot_name",

  // ── Degree statement ───────────────────────────────────────────────────────
  degree:        "Bachelor of Science (B. Sc.)",

  // ── Bibliography ───────────────────────────────────────────────────────────
  // Accepts a single path or an array: ("refs.bib", "more.yaml")
  library_paths: "refs.bib",
  // can be set to all available styles listed here: https://typst.app/docs/reference/model/bibliography/
  citation_style: "ieee",

  // ── Abstract ───────────────────────────────────────────────────────────
  abstract: (
    ("de", include("abstract/abstract_german.typ")),
    ("en", include("abstract/abstract_english.typ"))
  ),

  // ── Acronyms ───────────────────────────────────────────────────────────────
  // List of acronyms for the abbreviation list.
  // Reference them in text with @key
  // acronyms: (
  //   (key: "API", short: "API", long: "Application Programming Interface"),
  // ),
  acronyms: (
    (key: "API",  short: "API",  long: "Application Programming Interface"),
    (key: "LLM",  short: "LLM",  long: "Large Language Model"),
    (key: "RAG",  short: "RAG",  long: "Retrieval-Augmented Generation"),
    (key: "AST",  short: "AST",  long: "Abstract Syntax Tree"),
  ),

)

// ── Additional imports ─────────────────────────────────────────────────────
#import "@preview/drafting:0.2.2": *

// LTeX: enabled=true

// ── Chapters ───────────────────────────────────────────────────────────────
#include "chapters/chapter_1.typ"
#include "chapters/chapter_2.typ"
// add more chapters as you need
