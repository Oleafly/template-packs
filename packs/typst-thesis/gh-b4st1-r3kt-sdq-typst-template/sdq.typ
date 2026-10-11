// SPDX-License-Identifier: ISC
// SPDX-FileCopyrightText: 2025 JohnnyJayJay

#let sdq-thesis(
  title: [Title of the Thesis],
  thesis-type: "Master's thesis/Bachelor's thesis",
  lang: "en",
  region: none,
  english-abstract: [English abstract.],
  german-abstract: [Deutsche Zusammenfassung.],
  author: [My Name],
  grouplogo: none,
  institute: "KASTEL – Institute of Information Security and Dependability",
  reviewers: ("Prof. A", "Prof. B"),
  advisors: ("C, M.Sc.", "D, M.Sc."),
  start-date: datetime.today() - duration(weeks: 16),
  end-date: datetime.today(),
  include-declaration: true,
  declaration-date: datetime.today(),
  declaration-city: "Karlsruhe",
  doc
) = {

  let is-en = lang == "en"
  let sans = "Source Sans 3"
  let serif = "Libertinus Serif"
  
  set page(
    paper: "a4",
  )
  
  set text(size: 12pt, font: serif, lang: lang, region: region)

  // FIXME: not localised
  let date-format = "[day]. [month repr:long] [year]"

  // first few pages are not numbered
  set page(
    numbering: none,
  )
  
  // Title page
  page(
    margin: (right: 6%, top: 5%, left: 9%, bottom: 6%),
    rect(
      inset: 7%,
      width: 100%,
      height: 100%,
      radius: (top-right: 5%, bottom-left: 5%),
      [
        #image(height: 1.8cm, if is-en {"logos/kit-en.svg"} else {"logos/kit-de.svg"})
        //Group logo top right

        #set text(size: 14pt)
        #set align(center)
        #pad(
          top: 5em,
          bottom: 2em,
          text(font: sans, size: 24pt, hyphenate: false, strong(title))
        )
        #thesis-type #{if is-en [of] else [von]}
        #parbreak()
        #text(size: 16pt, author)

        #pad(
          top: 5em,
          if is-en [At the KIT Department of Informatics] else [An der KIT-Fakultät für Informatik]
        )
        #institute

        #pad(
          y: 1em,
          table(
            columns: 2,
            stroke: none,
            align: left,
            if is-en [First examiner:] else [1. Prüfer/Prüferin:], reviewers.at(0),
            if reviewers.len() > 1 {
              if is-en [Second examiner:] else [2. Prüfer/Prüferin:]
            },
            if reviewers.len() > 1 [#reviewers.at(1)],
            table.cell(colspan: 2, inset: 2pt, []),
            if is-en [First advisor:] else [1. Betreuer/Betreuerin:], advisors.at(0),
            if advisors.len() > 1 {
              if is-en [Second advisor:] else [2. Betreuer/Betreuerin:]
            },
            if advisors.len() > 1 [#advisors.at(1)] 
          )
        )

        #start-date.display(date-format) -- #end-date.display(date-format) 
      ]
    )
  )

  page([
    Karlsruher Institut für Technologie\
    Fakultät für Informatik\
    Postfach 6980\
    76128 Karlsruhe
  ])

  set par(justify: true)

  if include-declaration {
    page([
      #set align(bottom)

      #line(length: 100%)
      _#title (#thesis-type)_
      
      #{
        if is-en [
          I declare that I have developed and written the enclosed thesis completely by myself. I have not used any other than the aids that I have mentioned. I have marked all parts of the thesis that I have included from referenced literature, either in their original wording or paraphrasing their contents. I have followed the by-laws to implement scientific integrity at KIT.
        ] else [
          Ich versichere wahrheitsgemäß, die Arbeit selbständig verfasst, alle benutzten Quellen und Hilfsmittel vollständig und genau angegeben und alles kenntlich gemacht zu haben, was aus Arbeiten anderer unverändert oder mit Abänderungen entnommen wurde sowie die Satzung des KIT zur Sicherung guter wissenschaftlicher Praxis in der jeweils gültigen Fassung beachtet zu haben.
        ]
      }

      *#declaration-city, #declaration-date.display(date-format)*

      #box(
        width: 50%,
        inset: ("top": 2.5em), 
        [
          #line(stroke: (dash: "dotted"), length: 100%)
          #align(center, [(#author)])
        ]
      )
      
    ])
    page([])
  }
  
  // TODO: heading spacing, size, ...

  // pages before toc: numbered with roman literals
  set page(numbering: "i")
  counter(page).update(n => 1)
  
  show heading: h => {
    text(font: sans, strong(h))
  }
  show heading.where(level: 1): h => pad(top: 5em, bottom: 2em, text(size: 24pt, h))
  show heading.where(level: 2): h => pad(top: 2em, bottom: 2em, text(size: 16pt, h))

  
  show heading.where(level: 4): h => pad(top: 0.5em, text(font: sans, h.body))
  
  if is-en [
    = Abstract
    #english-abstract
    #page(numbering: none, [])
  ]

  text(
    lang: "de", 
    [
      = Zusammenfassung
      #german-abstract
      #page(numbering: none, [])
    ]
  )

  show outline.entry.where(level: 1): it => {
    show repeat: none
    v(1.2em)
    strong(text(font: sans, it))
  }
  outline(indent: auto, depth: 3)

  // pages after toc are numbered regularly
  set page(numbering: "1")
  counter(page).update(n => 1)
  
  set heading(
    numbering: "1.1."  
  )

  // heading name in header:
  // first level 1 heading on page if there is one
  // first level 2 heading on page if there is one
  // last level 2 heading before page if there is one
  // last level 1 heading before page if there is one
  
  set page(
    header: [
      #context {
        let current-page = here().page()
        let headings-on-page = query(heading)
          .filter(h => h.level < 3 and h.location().page() == current-page)
          .sorted(key: h => h.level)
        let headings-before-page = query(heading)
          .filter(h => h.level < 3 and h.location().page() < current-page)

        let h = none
        if headings-on-page.len() > 0 {
          h = headings-on-page.first()
        } else if headings-before-page.len() > 0 {
          h = headings-before-page.last()
        }

        if h != none {
          if h.numbering != none {
            numbering(h.numbering, ..counter(heading).at(h.location()))
          }
          [ #h.body #line(length: 100%, stroke: 0.5pt)]
        }
      }
    ],
    //margin: (inside: 2.5cm, outside: 2cm, y: 1.75cm)
  )

  doc
}
