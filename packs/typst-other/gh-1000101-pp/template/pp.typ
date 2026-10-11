#let pp(
  uni: [],
  subname: [],
  title: [],
  subtitle: [],
  author: [],
  abstract: [],
  abstract_title:[Abstract],
  language: "en",
  date: datetime.today().display("[day].[month].[year]"),
  doc,
) = {
  let lang = language;

  show heading.where(level: 1): set block(above: 2em, below: 1em)

  set smartquote(enabled: true)

  set page(
    margin: 3.5cm,
    paper: "a4",
  )

  set text(
     font: "Latin Modern Roman",
     lang: lang,
     size: 12pt,
  )

  set cite(
    style: "chicago-notes",
  )

  set footnote.entry(
    //indent: 2em
    indent: 0em, // no indent of footnotes - not standard, but I like it a lot - hotter than hot
  )


  place(
    top + left,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      block(below: 4em)
      text(size: 12pt, font: "Latin Modern Roman Caps", smallcaps(
        all: true,
      )[#uni])
      block()
      text(size: 12pt, font: "Latin Modern Roman Caps", smallcaps(
        all: true,
      )[#subname])
    },
  )

  place(
    top + left,
    float: true,
    {
      block()


      block(
        above: 10em,
        width: 32em,
        text(size: 18pt, weight: "extrabold", smallcaps(all: true)[#title]),
      )

      set text(size: 12pt, weight: "thin", style: "italic")

      block(
        width: 32em,
        above: 2em,
        par(justify: true)[#subtitle],
      )

      block(above: 2em)
    },
  )

  place(
    bottom + left,
    float: true,
    scope: "parent",
    {
      block(
        stroke: (left: 1.5pt),
        inset: 1em,
        text(
          size: 12pt,
          font: "Latin Modern Roman Caps",
          weight: "medium",
          smallcaps(all: true)[   #author],
        )
          + text(size: 12pt)[ \ \ #date ],
      )
    },
  )

  pagebreak()

  place(
    top + left, //  top + center //
    float: true,
    scope: "parent",
    {
      block(below: 1.5em, par()[
        *#abstract_title*
      ])
    },
  )

  block( align(left, par(justify: true)[
    #abstract
  ]))

  pagebreak()

  set par(
    justify: true,
    first-line-indent: (all: true, amount: 2em),
    spacing: 0.8em,
  )

  set page(numbering: "1")
  counter(page).update(1)

  doc
}

// custom quotes are special quotes used for example at the beginning of a chapter, they are unindented
//
#let customquote(text) = {
  block(
    above: 24pt,
    below: 24pt,
    inset: (left: -1em, right: -1em),
    quote(
      block: true,
    )[#text], // alt [#emph[#text]] but that also emphasizes the citation numbering
  )
}
