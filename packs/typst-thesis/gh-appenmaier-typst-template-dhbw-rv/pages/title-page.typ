/// Renders the title page for all five document types.
/// - labels (dict): UI label dictionary from labels.typ
/// - doc-type (str): "project" | "project-doc" | "term-paper" | "bachelor" | "seminar"
/// - title (str): Document title
/// - subtitle (str): Document subtitle
/// - author (str): Author name
/// - mat-number (str): Matriculation number
/// - course (str): Course identifier (e.g. TIK23)
/// - company (str): Dual partner company name and address
/// - company-supervisor (str): Company-side project supervisor
/// - supervisor (str): Academic supervisor (DHBW)
/// - submission-date (str): Submission date
/// - lecture (str): Lecture name — required when doc-type is "seminar"
/// - project-number (str): Project number — used when doc-type is "project"
/// - study-program (str): Name of the study programme (content only, without prefix)
/// - logo-path (str): Path to the DHBW logo image file
/// - margin (dict): Page margins, must match the global margin setting
/// -> none
#let title-page(
  labels: (:),
  doc-type: "project",
  title: "",
  subtitle: "",
  author: "",
  mat-number: "",
  course: "",
  study-program: "",
  company: "",
  company-supervisor: "",
  supervisor: "",
  submission-date: "",
  lecture: "",
  project-number: "1",
  show-company-supervisor: true,
  show-supervisor: true,
  logo-path: "",
  margin: (:),
) = {
  assert(
    doc-type != "seminar" or lecture != "",
    message: "title-page: `lecture` must not be empty when doc-type is \"seminar\"",
  )

  set page(header: none, numbering: none, margin: margin)

  // DHBW logo top right, does not affect text flow
  place(top + right, image(logo-path, width: 5cm))

  // Top spacing per document type
  let top-space = if doc-type == "project" or doc-type == "project-doc" { 1cm } else { 2cm }

  // Document type name
  let doc-name = labels.doc-names.at(doc-type, default: labels.doc-names.seminar)

  // Type block
  let type-block = if doc-type == "project" [
    #v(2cm)
    #text(weight: "bold")[#project-number. #doc-name]
  ] else if doc-type == "bachelor" or doc-type == "seminar" [
    #v(3cm)
    #text(weight: "bold")[#if doc-type == "seminar" [#labels.doc-names.seminar zur Vorlesung \ #lecture] else [#doc-name]]
  ] else [
    #v(2cm)
    #text(weight: "bold")[#doc-name]
  ]

  align(center)[
    // Spacing bridges logo height (~2.5 cm) + top-space
    #v(top-space + 2.5cm)
    #text(size: 20pt, weight: "bold")[#title] \
    #v(0.2em)
    #text(size: 16pt)[#subtitle]

    #type-block

    #v(0.5cm)
    #labels.program-prefix #study-program \
    #labels.university

    #v(0.3cm)
    #labels.by #author

    #v(1fr)
  ]

  // Metadata table
  if doc-type == "project-doc" {
    table(
      columns: (auto, 1fr),
      stroke: none,
      inset: (x: 0pt, y: 3pt),
      [#labels.meta-company-supervisor#h(1em)], [#company-supervisor],
      [#labels.meta-date#h(1em)],            [#submission-date],
    )
  } else {
    let rows = (
      ([#labels.meta-course#h(1em)],   [#course]),
      ([#labels.meta-mat-number#h(1em)],[#mat-number]),
      ([#labels.meta-partner#h(1em)],  [#company]),
    )
    if show-company-supervisor {
      rows = rows + (([#labels.meta-company-supervisor#h(1em)], [#company-supervisor]),)
    }
    if show-supervisor {
      rows = rows + (([#labels.meta-supervisor#h(1em)], [#supervisor]),)
    }
    rows = rows + (
      ([#labels.meta-date#h(1em)],      [#submission-date]),
    )
    table(
      columns: (auto, 1fr),
      stroke: none,
      inset: (x: 0pt, y: 3pt),
      ..rows.flatten(),
    )
  }

  pagebreak()
}
