#import "utils.typ": wbh-colors

// Main Project Function
#let project(
  last_name: "",
  first_name: "",
  assignment_code: "",
  street: "",
  zip_city: "",
  student_id: "",
  course_id: "",
  assignment_title: "",
  b_exam_name: "",
  edition: "",
  // Optional: map BibTeX keys to display acronyms for inline citations.
  // Example: ("dtf01": "DTF01", "wbgu2019": "WBGU", "claude_ai": "Claude")
  // Inline `@dtf01` then renders as clickable "DTF01" linking to a hidden
  // anchor in the Literaturverzeichnis (emitted by `bibliography_section`).
  // Empty dict = no override, cites render as Typst default.
  cite_display: (:),
  body,
) = {
  // Set document metadata
  set document(author: first_name + " " + last_name, title: assignment_title)

  // Set page properties (A4, margins, header/footer)
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2.5cm, left: 1.5cm, right: 1.5cm),
    header: [
      #set text(8pt)
      #grid(
        columns: (1fr, 1fr),
        align(left)[#image("../assets/logo-wbh.jpg", width: 3cm)],
        align(right + bottom)[#assignment_code],
      )
      #line(length: 100%, stroke: 0.5pt + wbh-colors.primary)
    ],
    footer: [
      #set text(8pt)
      #line(length: 100%, stroke: 0.5pt + wbh-colors.gray)
      #grid(
        columns: (1fr, 1fr, 1fr),
        align(left)[#first_name #last_name (#student_id)],
        align(center)[#assignment_title],
        align(right)[Seite #context counter(page).display("1 / 1", both: true)],
      )
    ],
  )

  // Set text properties
  set text(
    font: (
      "Arial",
      "Calibri",
      "Sans Serif Collection",
    ),
    size: 10pt,
    lang: "de",
  )

  set par(
    leading: 0.6em, // 1.5 line spacing (approx)
    justify: true,
    first-line-indent: 0pt,
    spacing: 1.2em, // parskip full
  )

  // Heading Styling
  show heading.where(level: 1): it => {
    set text(fill: wbh-colors.primary, size: 14pt)
    block(below: 1em, it)
  }

  // Citation display override: if `cite_display` is non-empty, inline cites
  // are rendered as clickable links showing the acronym instead of the
  // APA author-year label. The link targets `bib_<key>` labels which must
  // be emitted before the bibliography (handled by `bibliography_section`).
  show cite: it => {
    let k = str(it.key)
    if cite_display.len() > 0 and k in cite_display {
      let shown = cite_display.at(k)
      if it.supplement != none { shown = [#shown, #it.supplement] }
      link(label("bib_" + k), shown)
    } else {
      it
    }
  }

  // Title Block
  align(left)[
    #text(1.5em, weight: "bold", fill: wbh-colors.primary)[#assignment_title] \
    #v(0.2em)
    #text(1.2em, fill: wbh-colors.gray)[#b_exam_name]
    #v(1.5em)
    #grid(
      columns: (auto, 1fr, auto, 1fr),
      column-gutter: (1em, 2em, 1em),
      row-gutter: 0.8em,

      [*Name:*], [#first_name #last_name], [*Studiengang:*], [#course_id],
      [*Matrikel-Nr.:*], [#student_id], [*Auflage:*], [#edition],
      [*Anschrift:*], [#street \ #zip_city], [], [],
    )
  ]

  v(1cm)

  // Main Content
  body
}
