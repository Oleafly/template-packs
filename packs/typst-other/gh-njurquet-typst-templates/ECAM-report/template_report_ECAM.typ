// This function generates a report titlepage for ECAM Brussels Engineering School work reports.
#let report(
  title: [Report Title],
  // The course, lab, project name.
  course-name: [Course Name],
  // An array of authors. For each author you can specify a first name,
  // last name and matricule.
  authors: (
    (
      first-name: "",
      last-name: "",
      matricule: "",
    ),
  ),
  // University logo file path (as a `image` type).
  logo: image,
  // The language of the report. Supports "en" (English) and "fr" (French).
  language: "en",
  // The paper's content.
  body,
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(a => a.first-name + " " + a.last-name))

  show heading: set block(above: 1.5em, below: 0.8em)
  set text(font: "New Computer Modern", lang: language, weight: "medium")
  set par(justify: true, leading: 0.5em, spacing: 1em)
  set list(indent: 10pt)
  set enum(indent: 10pt)
  set figure(supplement: "Figure")
  set align(center)

  v(1.5cm)

  {
    set image(width: 60%)
    logo
  }

  v(2.2cm)

  {
    // Title with horizontal lines above and below
    set par(spacing: 0.5cm)
    line(length: 100%, stroke: 0.4pt + black)
    smallcaps(text(title, weight: "bold", size: 22pt))
    line(length: 100%, stroke: 0.4pt + black)
  }

  v(0.4cm)

  // Course name
  smallcaps(text(course-name, size: 18pt))

  v(1.5cm)

  {
    // Creates a table with first name, last name & matricule
    // columns and one row per author
    show table.cell.where(y: 0): strong
    set text(size: 14pt)
    table(
      columns: (auto, auto, auto),
      column-gutter: 1.5em,
      row-gutter: 0.5em,
      stroke: none,
      table.header(
        text(if language == "en" { "First Name" } else { "Prénom" } + " :"),
        text(if language == "en" { "Last Name" } else { "Nom" } + " :"),
        [Matricule :],
      ),
      ..for author in authors {
        (
          table.cell(author.first-name),
          table.cell(author.last-name),
          table.cell(author.matricule),
        )
      },
    )
  }

  v(1fr)

  text("Haute École ICHEC - ECAM - ISFSC", size: 14pt, weight: "bold")

  parbreak()

  // Academic year helper (rolls over in September)
  let academic-year() = {
    let now = datetime.today()
    let year-one = now.year() - if now.month() < 9 { 1 } else { 0 }
    let year-two = year-one + 1
    return [Academic year #year-one -- #year-two]
  }
  text(academic-year(), size: 14pt)

  // Display the paper's contents.
  pagebreak(weak: true)
  set align(left)
  set page(numbering: "1")
  counter(page).update(1)
  body
}
