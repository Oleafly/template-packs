// ================================ //
//         CONFIGURATION            //
// Edit this file to customise the  //
// template for your document.      //
// ================================ //

// ---- Language ---- //
// Options: "DE", "EN"
#let lang = "DE"

// ---- Document type ---- //
// Options: "project", "project-doc", "term-paper", "bachelor", "seminar"
#let doc-type = "project"

#assert(
  ("seminar", "project", "project-doc", "term-paper", "bachelor").contains(doc-type),
  message: "config.typ: doc-type must be one of: project, project-doc, term-paper, bachelor, seminar",
)

// ---- Show confidentiality notice ---- //
#let show-confidentiality-notice = false

// ---- Show abstract page ---- //
#let show-abstract = true

// ---- Show company supervisor on title page ---- //
#let show-company-supervisor = true

// ---- Show academic supervisor on title page ---- //
#let show-supervisor = true

// ---- Document metadata ---- //
#let config = (
  doc-type:          doc-type,
  title:             "[Titel]",
  subtitle:          "[Untertitel]",
  author:            "[Verfasser]",
  mat-number:        "[Matrikelnummer]",
  course:            "[Kurs]",
  study-program:     "[Studiengang]",
  company:           "SAP SE, 88677 Markdorf",
  company-supervisor:"[Projektbetreuer]",
  supervisor:        "[Gutachter DHBW]",
  submission-date:   "[Abgabedatum]",

  // Seminar paper only
  lecture:           "[Vorlesung]",

  // Project work only
  project-number:    "1",   // 1, 2
)
