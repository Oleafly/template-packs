
#let project(
  title: none,
  subtitle: none,
  author: none,
  year: none,
  programme: none,
  major: none,
  supervisor: none,
  advisors: (none,),
  collabpartner: none,
  date: none,
  pages: none,
  language: none,
  abstract: none,
  keywords: (none,),
  foreword: none,
  loc: none,
  main-font: "New Computer Modern",
  accent-font: "Arial",
  lang: "en",
  body
) = [
  #import "cover.typ": cover
  #import "abstract/abstract-all-langs.typ": abstract-all
  #import "foreword.typ": foreword-page

  #set text(
    font: main-font,
    lang: "en",
    hyphenate: false,
  )

  #set page(
    margin: (
      top: 3.7cm,
      bottom: 3.0cm,
      left: 3.4cm,
      right: 3.4cm,
    ),
  )

  #set par(
    justify: true
  )

  #show heading: it => {
    text(font: accent-font)[#it]
  }

  #show: cover.with(
    title: title,
    subtitle: subtitle,
    author: author,
    year: year,
    main-font: main-font,
    accent-font: accent-font,
  )
  

  #show: abstract-all.with(
    title: title,
    subtitle: subtitle,
    author: author,
    programme: programme,
    major: major,
    supervisor: supervisor,
    advisors: advisors,
    collabpartner: collabpartner,
    date: date,
    pages: pages,
    language: language,
    abstract: abstract,
    keywords: keywords,
    main-font: main-font,
    accent-font: accent-font,
  )

  #set page(numbering: "1")

  #show: foreword-page.with(
    foreword: foreword,
    loc: loc,
    date: date,
    author: author,
  )

  #pagebreak()

  #context outline(
    title: "Table of Contents",
    target: heading.where().after(here())
  )


  #show heading: it => {
    if it.level == 1 {
      pagebreak()
    }
    it
  }
  #set heading(numbering: "1.")

  // Main body.
  #body
  
]
