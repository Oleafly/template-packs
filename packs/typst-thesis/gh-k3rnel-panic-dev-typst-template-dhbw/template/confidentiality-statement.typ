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
  type-of-thesis,
) = {
  let authors-by-city = authors.map(author => author.company.city).dedup()

  v(2em)
  text(size: 20pt, weight: "bold", CONFIDENTIALITY_STATEMENT_TITLE.at(language))
  v(1em)

  if (confidentiality-statement-content != none) {
    confidentiality-statement-content
  } else {
    let authors-by-company = authors.map(author => author.company.name).dedup()
    let authors-by-study = authors.map(author => author.course-of-studies).dedup()
    let companies = authors-by-company.join(", ", last: AND.at(language))
    let author-study-course = authors-by-study.join(", ", last: AND.at(language))

    let institution = if (authors-by-company.len() == 1) {
      INSTITUTION_SINGLE.at(language)
    } else {
      INSTITUTION_PLURAL.at(language)
    }


    v(1em)

    par(
      justify: true,
      CONFIDENTIALITY_STATEMENT_SECTION_A.at(language)
        + type-of-thesis
        + CONFIDENTIALITY_STATEMENT_SECTION_B.at(language)
        + text(style: "italic", title)
        + CONFIDENTIALITY_STATEMENT_SECTION_C.at(language)
        + companies
        + CONFIDENTIALITY_STATEMENT_SECTION_D.at(language)
        + author-study-course
        + CONFIDENTIALITY_STATEMENT_SECTION_E.at(language)
        + university-location
        + CONFIDENTIALITY_STATEMENT_SECTION_F.at(language),
    )
    v(1em)
    list(
      par(justify: true, CONFIDENTIALITY_STATEMENT_SECTION_G.at(language)) + v(1em),
      par(justify: true, CONFIDENTIALITY_STATEMENT_SECTION_H.at(language)) + v(1em),
      par(justify: true, CONFIDENTIALITY_STATEMENT_SECTION_I.at(language)),
    )

    v(1em)

    par(
      justify: true,
      CONFIDENTIALITY_STATEMENT_SECTION_J.at(language) + companies + ".",
    )
  }

  let end-date = if (type(date) == datetime) {
    date
  } else {
    date.at(1)
  }

  v(2em)
  text(authors-by-city.dedup().join(", ", last: AND.at(language)) + [ ] + end-date.display(date-format))

  v(0.5em)
  if (many-authors) {
    grid(
      columns: (1fr, 1fr),
      gutter: 20pt,
      ..authors.map(author => {
        v(3.5em)
        line(length: 80%)
        author.name
      })
    )
  } else {
    for author in authors {
      v(4em)
      line(length: 40%)
      author.name
    }
  }
}
