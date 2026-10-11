#let __title_internal(
  title: [],
  subtitle: [],
  author: [],
  affiliation: [],
  contact: [],
  date: datetime(year: 2026, month: 1, day: 1),
) = {
    align(center, 
        block[
            = *#title* \
            #text(14pt, weight: "medium")[#subtitle] \
            #v(1pt)
            #text(14pt)[#author†] \
            #text(10pt)[
              // #date.year()-#date.month()-#date.day()
              †#contact, #affiliation
            ]
            #v(1em)
        ]
    )
}

#let title_block(
  title: [],
  subtitle: [],
  author: [],
  affiliation: [],
  contact: [],
  date: datetime(year: 2026, month: 1, day: 1),
) = {
  place(
      top + center,
      float: true,
      scope: "parent",
      __title_internal(
          title: title,
          subtitle: subtitle,
          author: author,
          affiliation: affiliation,
          contact: contact,
          date: date,
      )
  )
}
