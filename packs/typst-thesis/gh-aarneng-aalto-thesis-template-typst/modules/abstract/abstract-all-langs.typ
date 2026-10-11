#let abstract-all(
  author: none,
  title: none,
  subtitle: none,
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
  main-font: "New Computer Modern",
  accent-font: "Arial",
  body
) = [

  #[
    #set table(
      stroke: (x: none, y: 1pt + black),
    )
 
    #import "abstract-EN.typ": abstract-EN
    #import "abstract-FI.typ": abstract-FI
    #import "abstract-SW.typ": abstract-SW

    #show: abstract-EN.with(
      author: author,
      title: title,
      subtitle: subtitle,
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
    ) 
    #show: abstract-FI.with(
      author: author,
      title: title,
      subtitle: subtitle,
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
    )
    #show: abstract-SW.with(
      author: author,
      title: title,
      subtitle: subtitle,
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
    )
 ]
  #body
]