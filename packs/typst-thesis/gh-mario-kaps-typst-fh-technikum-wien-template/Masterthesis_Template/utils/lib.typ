#let thesis(
  title: "",
  subtitle: "",
  author: "",
  student-id: "",
  degree-program: "",
  supervisor_1: "",
  supervisor_2: "",
  date: datetime.today(),
  city: "Vienna",
  language: "en",
  abstract-de: none,
  keywords-de: none,
  abstract-en: none,
  keywords-en: none,
  declaration: true,
  bib-file: "refs.bib",
  logo: "fhtw_cover.png",
  body,
) = {
  set page(
      paper: "a4",
      margin: (top: 3cm, bottom: 3cm, inside: 3.5cm, outside: 2.5cm),
      header: none,
      footer: context {
            let page-num = counter(page).get().first()
      
            if page-num > 1 {
              // Query all level-1 headings that appear BEFORE the current footer location
              let headings = query(heading.where(level: 1).before(here()))
      
              // Get the title of the last heading found, or fall back to the thesis title
              let left-text = if headings.len() > 0 {
                headings.last().body
              } else {
                title
              }
      
              text(9pt, fill: luma(100))[
                #left-text
                #h(1fr)
                #counter(page).display()
              ]
            }
          },
    )

  set text(font: "Liberation Sans", size: 11pt, lang: language)
  set par(justify: true, leading: 0.7em)

  // Title Page
    page(
      header: none,
      footer: none,
      background: if logo != none {
        image(logo, width: 100%, height: 100%, fit: "stretch")
      },
    )[
        #v(1.5cm)
        #text(14pt, weight: "bold")[MASTER THESIS] \
        #v(0.1cm)
        #text(12pt)[Thesis submitted in fulfillment of the requirements for the degree of Master of Science in Engineering at the University of Applied Sciences Technikum Wien - Degree Program *#degree-program*]

        #align(left)[
        #v(4cm)
        #text(22pt, weight: "bold")[#title] \
        #if subtitle != "" [#v(0.5cm) #text(18pt)[#subtitle]]
  
        #v(3cm)
        #align(left)[
          #grid(
            columns: (auto, 1fr),
            row-gutter: 1.2em,
            column-gutter: 3.5em,
            [*Author:*], [#author],
            [*Student ID*], [#student-id],
            [*Supervisor Technikum:*], [#supervisor_1],
            [*Supervisor Company:*], [#supervisor_2],

            [*Date:*], [#date.display("[day].[month].[year]")],
          )
        ]
      ]
    ]
    pagebreak()

// Declaration of Authorship
  if declaration [
    #v(1cm)
    #heading(level: 1, numbering: none)[Declaration]
    #v(0.5cm)
    “As author and creator of this work to hand, I confirm with my signature knowledge of the relevant copyright regulations governed by higher education acts (see Urheberrechtsgesetz /Austrian copyright law as amended as well as the Statute on Studies Act Provisions / Examination Regulations of the UAS Technikum Wien as amended).
    
    I hereby declare that I completed the present work independently and that any ideas, whether written by others or by myself, have been fully sourced and referenced. I am aware of any consequences I may face on the part of the degree program director if there should be evidence of missing autonomy and independence or evidence of any intent to fraudulently achieve a pass mark for this work (see Statute on Studies Act Provisions / Examination Regulations of the UAS Technikum Wien as amended).
    
    I further declare that up to this date I have not published the work to hand nor have I presented it to another examination board in the same or similar form. I affirm that the version submitted matches the version in the upload tool.“
    #v(5cm)
    #grid(
      columns: (1fr, 1fr), column-gutter: 10em,
      [#city, #date.display("[day].[month].[year]")],
      [Digital Signature],
    )
    #pagebreak()
  ]

  // Abstract Section
  if abstract-de != none [
    #heading(level: 1, numbering: none)[Kurzfassung]
    #abstract-de
    #if keywords-de != none [
      #v(5.5em)
      *Schlagwörter:* #keywords-de
    ]
    #pagebreak()
  ]

  if abstract-en != none [
    #heading(level: 1, numbering: none)[Abstract]
    #abstract-en
    #if keywords-en != none [
      #v(5.5em)
      *Keywords:* #keywords-en
    ]
    #pagebreak()
  ]

  // Outlines
  outline(indent: auto)
  pagebreak()

  // Main Content
  set heading(numbering: "1.1")
  counter(page).update(1)

  body

  // Bibliography
  if bib-file != none {
    pagebreak()
    bibliography(bib-file, style: "ieee")
  }
}