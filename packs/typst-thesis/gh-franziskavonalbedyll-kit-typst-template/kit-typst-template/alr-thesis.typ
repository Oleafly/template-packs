// SPDX-License-Identifier: ISC
// SPDX-FileCopyrightText: 2025 JohnnyJayJay
#import "@preview/nth:1.0.1": nth
#import "erklaerung.typ": erklaerung
#import "@preview/abbr:0.3.1"
#import "/thesis/chapters/0_Abstract/abstract.typ":*

#show: abbr.show-rule

#let thesis(
  title: [Title of the Thesis],
  thesis-type: "Master's thesis",
  english-abstract: english_abstract,
  german-abstract: german_abstract,
  author: [Author Name],
  grouplogo: none,
  institute: "Institute Name",
  lab: "Lab Name",
  company: none,
  // replace insitution-logo with the actual logo of your institution.
  institution-logo: "/assets/logos/kit/KIT_ALR_en.pdf",
  // replace company-logo with the actual logo of your company. If you don't have a company, you can set it to none.
  company-logo: none,
  referee: "Prof. A",
  second-referee: "Prof. B",
  internal-advisor: "C, M.Sc.",
  external-advisor: none,
  start-date: datetime.today() - duration(weeks: 16),
  end-date: datetime.today(),
  include-declaration: true,
  declaration-date: datetime.today(),
  declaration-city: "Karlsruhe",
  doc
) = {

  let sans = "Source Sans 3"
  let serif = "Libertinus Serif"
  
  set page(
    paper: "a4",
  )
  
  set text(size: 12pt, font: serif, lang: "en")

  let format-date(date, language: "en") = {
  if language == "de" {
    // German format: "1. Januar 2024"
    let months = (
      "Januar", "Februar", "März", "April", "Mai", "Juni", 
      "Juli", "August", "September", "Oktober", "November", "Dezember"
    )
    let month-name = months.at(date.month() - 1)
    [#str(date.day()). #month-name #date.display("[year]")]
  } else {
    // English format: "January 1st, 2024"
    [#date.display("[month repr:long] ") #nth(date.day()) #date.display(", [year]")]
  }
}


  // first few pages are not numbered
  set page(
    numbering: none,
  )
  
  // Title page
  page(
    margin: (right: 6%, top: 5%, left: 9%, bottom: 6%),
    [
      #rect(
        inset: 7%,
        width: 100%,
        height: 97%,
        radius: (top-right: 5%, bottom-left: 5%),
        [
        // Logos in one row (institution + optional company)
        #if company != none {
          grid(
            columns: (2fr, 1fr),
            align: (left, right),
            // Institution logo
            image(height: 2cm, institution-logo),
            // Company logo
            image(height: 2cm, company-logo) 
          )
        } else {
          grid(
            columns: (1fr),
            align: (left),
            // Institution logo only
            image(height: 2cm, institution-logo)
          )
        }
          

          #set text(size: 14pt)
          #set align(center)
          #pad(
            top: 5em,
            bottom: 2em,
            text(font: sans, size: 24pt, hyphenate: false, strong(title))
          )
          #thesis-type of
          #parbreak()
          #text(size: 16pt, author)

          #pad(
            top: 5em,
            [
              At the Department of Computer Science\
              #institute\
              #lab
              #if company != none [
                #v(0.5em)
                _In cooperation with_\  
                #v(0.5em)
                #company
              ]
            ]
          )

          #pad(
            y: 1em,
            table(
              columns: 2,
              stroke: none,
              align: left,
              [Referee:], referee,
              [Second Referee:], second-referee,
              [Advisor (KIT):], internal-advisor,
              if external-advisor != none {
                [Advisor (ZEISS):]
              },
              if external-advisor != none [#external-advisor]
            )
          )
          #v(1.5cm)
          Duration: #format-date(start-date) -- #format-date(end-date) 
        ]
      )
      
      // Content below the box

      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#text(size:10pt)[KIT -- The Research University in the Helmholtz Association]],
        [#text(size:10pt)[#link("https://www.kit.edu")[www.kit.edu]]]
      )
    ]
  )

  page([
    Karlsruher Institut für Technologie\
    Fakultät für Informatik\
    Postfach 6980\
    76128 Karlsruhe
  ])

set par(justify: true)


  page([
    #set text(lang: "de")
    #set par(justify: true)

    #erklaerung(author, declaration-date, format-date)

    #v(2em)

    #include("generative_ai_declaration.typ")

  ])
  page([])

  
  // TODO: heading spacing, size, ...

  // pages before toc: numbered with roman literals
  set page(numbering: "i")
  counter(page).update(n => 1)
  
  show heading: h => {
    text(font: sans, strong(h))
  }
  show heading.where(level: 1): h => {
    pagebreak(weak: true)
    pad(top: 5em, bottom: 2em, text(size: 24pt, h))
  }
  show heading.where(level: 2): h => pad(top: 2em, bottom: 2em, text(size: 16pt, h))

  
  show heading.where(level: 4): h => pad(top: 0.5em, text(font: sans, h.body))
  
  // pages before toc: numbered with roman literals
  set page(numbering: "i")
  counter(page).update(n => 1)
  
  text(
    lang: "de", 
    [
      = Zusammenfassung
      #german-abstract
    ]
  )
  pagebreak()

  // Abstract
  [
    = Abstract
    #english-abstract
  ]
  pagebreak()

  // List of Acronyms
  [
    #abbr.list(title: "List of Acronyms", columns: 1)
  ]
  pagebreak()

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

  set page(header: counter(footnote).update(0))
  set math.equation(numbering: none)

  doc
}