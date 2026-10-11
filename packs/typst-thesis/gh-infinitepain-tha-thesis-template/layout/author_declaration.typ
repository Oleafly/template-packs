#import "./utils/helpers.typ": toml_to_datetime, format_date
#import "@preview/linguify:0.4.2": linguify

#let author_declaration(
  author,
  authorSignaturePlace,
  submissionDate,
  language,
) = {
  let submissionDateTypst = toml_to_datetime(submissionDate)

  pagebreak()

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
  )

  heading(numbering: none, outlined: false)[#linguify("authorDeclarationTitle")]

  v(10mm)

  text[#linguify("authorDeclarationText")]

  v(20mm)

  text[
    #authorSignaturePlace#if linguify("authorDeclarationDate") != "" [, #linguify("authorDeclarationDate")] #format_date(submissionDateTypst, language)
  ]

  v(20mm)

  line(length: 50%, stroke: 0.5pt)

  v(2mm)

  text[#author]
}
