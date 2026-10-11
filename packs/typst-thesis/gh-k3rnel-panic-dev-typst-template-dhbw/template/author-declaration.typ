#import "locale.typ": *

#let declaration-of-authorship(
  authors,
  type-of-thesis,
  title,
  declaration-of-authorship-content,
  date,
  language,
  many-authors,
  at-university,
  city,
  date-format,
) = {
  v(2em)
  text(size: 20pt, weight: "bold", DECLARATION_OF_AUTHORSHIP_TITLE.at(language))
  v(1em)

  if (declaration-of-authorship-content != none) {
    declaration-of-authorship-content
  } else {
    par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_A.at(language))

    v(1em)

    list(
      par(
        justify: true,
        DECLARATION_OF_AUTHORSHIP_SECTION_B.at(language)
          + type-of-thesis
          + DECLARATION_OF_AUTHORSHIP_SECTION_C.at(language)
          + text(style: "italic", title)
          + DECLARATION_OF_AUTHORSHIP_SECTION_D.at(language),
      )
        + v(1em),

      par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_E.at(language)) + v(1em),

      par(
        justify: true,
        DECLARATION_OF_AUTHORSHIP_SECTION_F.at(language)
          + type-of-thesis
          + DECLARATION_OF_AUTHORSHIP_SECTION_G.at(language),
      )
        + v(1em),

      par(
        justify: true,
        DECLARATION_OF_AUTHORSHIP_SECTION_H.at(language)
          + type-of-thesis
          + DECLARATION_OF_AUTHORSHIP_SECTION_I.at(language),
      )
        + v(1em),

      par(
        justify: true,
        DECLARATION_OF_AUTHORSHIP_SECTION_J.at(language)
      )
        + v(1em),
    )

    par(justify: true, DECLARATION_OF_AUTHORSHIP_SECTION_K.at(language))
  }

  let end-date = if (type(date) == datetime) {
    date
  } else {
    date.at(1)
  }

  v(2em)
  if (at-university) {
    text(city + [, ] + end-date.display(date-format))
  } else {
    let authors-by-city = authors.map(author => author.company.city).dedup()

    text(authors-by-city.join(", ", last: AND.at(language)) + [ ] + end-date.display(date-format))
  }

  v(1em)
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
