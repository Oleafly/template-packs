#let left_indent = 1in
#let h2_indent = 0.5in
#let hanging_indent = 0.5in
#let font_size = 11pt
#let single = 11pt
#let line_spacing = single / 2
#let in_between = 2 * single / 3
#let above_spacing = single

#let configuration(document_content, name, document_date) = {
  set document(
    title: "Curriculum Vitae",
    author: name,
    keywords: ("CV", "Curriculum Vitae", "Resume", name),
    date: document_date,
  )
  set page("us-letter", margin: (x: 0.7in, y: 0.5in))
  set page(
    header: context {
      let loc = here()
      if loc.page() > 1 {
        align(left, counter(page).display("-1-"))
      }
    },
  )
  set text(weight: "regular", size: font_size)

  set par(leading: line_spacing)
  set par(spacing: single)

  show heading: it => {
    set text(style: "normal", weight: "regular", size: font_size)
    set block(above: above_spacing, below: line_spacing)

    if it.level == 1 {
      block(below: line_spacing)[
        #underline(it.body):
      ]
    } else if it.level == 2 {
      if it.body == [National Societies] {
        block(above: line_spacing, below: line_spacing)[
        #h(h2_indent)#text(it.body):
      ]
      } else {
      block(above: line_spacing, below: in_between)[
        #h(h2_indent)#text(it.body):
      ]
    }
  }
  }
    set cite(form: "full", style: "../styles/american-medical-association.csl")
  // set cite(form: "full", style: "apa")
    set bibliography(full: true)
    document_content
}
