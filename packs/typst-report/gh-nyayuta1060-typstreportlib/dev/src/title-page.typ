#let default-title-size = 18pt
#let default-title-weight = "bold"
#let default-meta-size = 11pt
#let default-date-size = 11pt
#let default-title-top-gap = 3cm
#let default-title-gap = 0.8em
#let default-meta-gap = 0.3em
#let default-title-grid-rows = (auto, 1fr, auto)
#let default-abstract-title = "概要"
#let default-keywords-title = "キーワード"
#let default-abstract-width = 80%
#let default-abstract-gap = 1.2em
#let default-abstract-text-size = 10pt

#let title-block(
  title,
  author,
  extra: [],
  title-size: default-title-size,
  title-weight: default-title-weight,
  meta-size: default-meta-size,
  top-gap: default-title-top-gap,
  title-gap: default-title-gap,
  meta-gap: default-meta-gap,
) = {
  v(top-gap)
  set text(size: title-size, weight: title-weight)
  [#title]
  v(title-gap)
  set text(size: meta-size)
  [#author]
  if extra != [] {
    v(meta-gap)
    [#extra]
  }
}

#let date-block(
  date,
  date-size: default-date-size,
) = {
  set text(size: date-size)
  [#date]
}

#let abstract-block(
  abstract: [],
  keywords: [],
  title: default-abstract-title,
  keywords-title: default-keywords-title,
  width: default-abstract-width,
  text-size: default-abstract-text-size,
) = {
  if abstract != [] or keywords != [] {
    block(width: width)[
      #set align(left)
      #set text(size: text-size, weight: "regular")

      #if abstract != [] [
        #text(weight: "bold")[#title]
        #parbreak()
        #abstract
      ]

      #if abstract != [] and keywords != [] {
        parbreak()
      }

      #if keywords != [] [
        #text(weight: "bold")[#keywords-title]
        #parbreak()
        #keywords
      ]
    ]
  }
}

#let title-page(
  title,
  author,
  date,
  extra: [],
  abstract: [],
  keywords: [],
  title-size: default-title-size,
  title-weight: default-title-weight,
  meta-size: default-meta-size,
  date-size: default-date-size,
  top-gap: default-title-top-gap,
  title-gap: default-title-gap,
  meta-gap: default-meta-gap,
  grid-rows: default-title-grid-rows,
  abstract-title: default-abstract-title,
  keywords-title: default-keywords-title,
  abstract-width: default-abstract-width,
  abstract-gap: default-abstract-gap,
  abstract-text-size: default-abstract-text-size,
) = {
  set page(footer: none)
  set align(center)
  grid(
    columns: 1,
    rows: grid-rows,
  )[
    #[
      #title-block(
        title,
        author,
        extra: extra,
        title-size: title-size,
        title-weight: title-weight,
        meta-size: meta-size,
        top-gap: top-gap,
        title-gap: title-gap,
        meta-gap: meta-gap,
      )
      #if abstract != [] or keywords != [] {
        v(abstract-gap)
        abstract-block(
          abstract: abstract,
          keywords: keywords,
          title: abstract-title,
          keywords-title: keywords-title,
          width: abstract-width,
          text-size: abstract-text-size,
        )
      }
    ]
    []
    #date-block(
      date,
      date-size: date-size,
    )
  ]
}
