#let document_meta = (
  title: "Digitalisierung von Katzencafés",
  subtitle: "Ein Framework für die Integration moderner IT-Systeme in der Tiergastronomie",
  authors: (
    (name: "Finn Kölker", matricle: "17 33 70"),
  ),
  submission_date: datetime.today(),
  study_year: "2022",
  institution: "Private Hochschule für Wirtschaft und Technik",
  course: "Wirtschaftsinformatik (B.A.)",
  supervisor: "Prof. Dr. Max Mustermann",
  location: "Vechta",
)

#let typography = (
  font_family: "Georgia",
  main_text_size: 12pt,
  header_footer_size: 10pt,
  heading_sizes: (
    h1: 18pt,
    h2: 16pt,
    h3: 14pt,
    h4: 12pt,
  ),
  line_height: (
    main: 1.3,
    compact: 1.0,
  ),
)

#let page_margins = (
  top: 25mm,
  bottom: 20mm,
  left: 40mm,
  right: 25mm,
)

#let colors = (
  accent: rgb("#184484"),
  text: rgb("#2d2d2d"),
  subtle: rgb("#999999"),
)

#let get_author_names() = {
  document_meta.authors.map(author => author.name).join(", ")
}
