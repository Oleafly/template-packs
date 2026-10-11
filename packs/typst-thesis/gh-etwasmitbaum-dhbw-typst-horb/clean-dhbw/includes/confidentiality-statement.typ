#import "locale.typ": *

#let confidentiality-statement(
  authors,
  title,
  confidentiality-statement-content,
  university,
  university-location,
  date,
  language,
  many-authors,
  date-format,
) = {
  let authors-by-city = authors.map(author => author.company.city).dedup()

  heading(level: 1, CONFIDENTIALITY_STATEMENT_TITLE.at(language), outlined: false)
  v(1em)

  if (confidentiality-statement-content != none) {
    confidentiality-statement-content
  } else {
    let authors-by-company = authors.map(author => author.company.name).dedup()
    let authors-by-study = authors.map(author => author.course-of-studies).dedup()
    let companies = authors-by-company.join(", ", last: AND.at(language))

    let institution = if (authors-by-company.len() == 1) {
      INSTITUTION_SINGLE.at(language)
    } else {
      INSTITUTION_PLURAL.at(language)
    }

    text(CONFIDENTIALITY_STATEMENT_SECTION_A.at(language))
    v(1em)
    align(
      center,
      text(weight: "bold", title),
    )

    v(1em)

    [
      #CONFIDENTIALITY_STATEMENT_SECTION_B.at(language) #companies #CONFIDENTIALITY_STATEMENT_SECTION_C.at(language) #authors-by-study.join(" | ") #CONFIDENTIALITY_STATEMENT_SECTION_D.at(language) #university #university-location #CONFIDENTIALITY_STATEMENT_SECTION_E.at(language) #CONFIDENTIALITY_STATEMENT_SECTION_F.at(language)
      #list(
        indent: 2em,
        [#BULLET_POINT_ONE.at(language)],
        [#BULLET_POINT_TWO.at(language)],
        [#BULLET_POINT_THREE.at(language)],
      )
      #CONFIDENTIALITY_STATEMENT_SECTION_G.at(language) #companies.
    ]

    pagebreak()
  }
}
