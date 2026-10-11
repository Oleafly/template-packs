#let end-label(s) = label("csm-thesis-end-" + s)
#let end-label-appendix(i) = end-label("appendix-" + str(i))
#let end-anchor(l) = [#block(fill: none, stroke: none)#l]

#let coverpage(
  level,
  programme,
  title,
  author,
  date,
) = [
  #set text(size: 14pt)
  #set align(center)
  #set par(justify: false)

  // Logo
  #block(below: 2em)[#image("hy-logo-ml.svg", width: 32%)]

  // Level
  #par[#level]

  // Programme
  #par[#programme]

  // Title
  #par(spacing: 4em)[#text(23pt)[*#title*]]

  // Name
  #par(spacing: 3em)[#author]

  // Date
  #date.display("[month repr:long] [day], [year]")

  // Faculty
  #place(bottom + center, dy: -1em)[#text(16pt)[#smallcaps[
    Faculty of Science\
    University of Helsinki
  ]]]

  #pagebreak()
]

#let contactpage = [
  #set par(spacing: 3em)
  #set text(size: 12pt)
  *Contact information*

  #block(inset: (x: 2em))[
    P. O. Box 68 (Pietari Kalmin katu 5)\
    00014 University of Helsinki, Finland

    Email address: #link("mailto:info@cs.helsinki.fi")\
    URL: #link("http://www.cs.helsinki.fi/")
  ]

  #pagebreak()
]

#let abstractpage(
  programme,
  title,
  author,
  supervisor,
  level,
  date,
  abstract,
  ccs,
  keywords,
  info,
  appendices,
) = [
  #set text(size: 13pt)
  #smallcaps[helsingin yliopisto -- helsingfors universitet -- university of helsinki]

  #let celldesc(body) = {
    text(7.5pt)[#body]
    parbreak()
  }
  #set par(spacing: 1em)
  #set text(size: 10pt)
  #block(above: 0.5em)[#table(
    columns: 6 * (1fr,),
    rows: 20 * (1fr,),
    stroke: 0.5pt,
    table.cell(colspan: 3)[
      #celldesc[Tiedekunta --- Fakultet --- Faculty]
      Faculty of Science
    ],
    table.cell(colspan: 3)[
      #celldesc[Koulutusohjelma --- Utbildningsprogram --- Study programme]
      #programme
    ],
    table.cell(colspan: 6)[
      #celldesc[Tekijä --- Författare --- Author]
      #author
    ],
    table.cell(colspan: 6)[
      #celldesc[Työn nimi --- Arbetets titel --- Title]
      #title
    ],
    table.cell(colspan: 6)[
      #celldesc[Ohjaajat --- Handledare --- Supervisors]
      #supervisor
    ],
    table.cell(colspan: 2)[
      #celldesc[Työn laji --- Arbetets art --- Level]
      #level
    ],
    table.cell(colspan: 2)[
      #celldesc[Aika --- Datum --- Month and year]
      #date.display("[month repr:long] [day], [year]")
    ],
    table.cell(colspan: 2)[
      #celldesc[Sivumäärä --- Sidoantal --- Number of pages]
      #context counter(page).at(locate(end-label("bibliography"))).first() pages#if appendices.len() > 0 [,]
      #if appendices.len() > 0 {
        let appendix-pages(i) = counter(page).at(locate(end-label-appendix(i))).first()
        let ap() = range(0, appendices.len()).map(appendix-pages).sum()
        [#context ap() appendix #context if ap() < 2 [page] else [pages]]
      }
    ],
    table.cell(colspan: 6, rowspan: 12)[
      #celldesc[Tiivistelmä --- Referat --- Abstract]
      #block(above: 2em, inset: (x: 2em))[
        #abstract

        #v(1fr)
        *ACM Computing Classification System (CCS)*\
        #ccs
      ]
    ],
    table.cell(colspan: 6)[
      #celldesc[Avainsanat --- Nyckelord--- Keywords]
      #keywords
    ],
    table.cell(colspan: 6)[
      #celldesc[Säilytyspaikka --- Förvaringsställe --- Where deposited]
      Helsinki University Library
    ],
    table.cell(colspan: 6)[
      #celldesc[Muita tietoja --- Övriga uppgifter --- Additional information]
      #info
    ],
  )]

  #pagebreak()
]

#let thesis(
  programme: [Master's Programme in Computer Science],
  title: none,
  author: (),
  supervisor: (),
  level: [Master's thesis],
  date: datetime.today(),
  lang: "en",
  region: "GB",
  abstract: [],
  ccs: [],
  keywords: (),
  info: [],
  appendices: (),
  bibsources: "csm_thesis.bib",
  breakto: none,
  oldpagesize: false,
  infopage: true,
  doc,
) = [
  #let author = if (type(author) == array) {
    author.join(", ", last: " and ")
  } else { author }
  #let supervisor = if (type(supervisor) == array) {
    supervisor.join(", ")
  } else { supervisor }
  #let keywords = if (type(keywords) == array) {
    keywords.join(", ")
  } else { keywords }

  #set document(
    title: title,
    author: author,
    date: date,
  )

  #set page(
    width: 210mm,
    height: if (oldpagesize) {
      // This was matched to the original LaTeX template.
      // I don't know why it wasn't a full-height A4.
      272mm
    } else {
      // Current/next LaTeX template uses a standard A4 page size:
      297mm
    },
  )

  #set text(
    lang: lang,
    region: region,
    font: "New Computer Modern",
    size: 12pt,
  )

  #set par(
    leading: 0.8em,
    justify: true,
  )

  #let chapterheading(it) = [
    #set text(size: 24pt)
    #set block(below: 2em)
    #it
  ]

  #let appendixnumberingshort = "A "
  #let appendixnumbering(num) = "Appendix " + numbering(appendixnumberingshort, num)

  #show outline: it => [
    // Style table of contents heading with a larger font size and margin
    #show heading: chapterheading
    #v(4em)
    #it
  ]

  #show outline.entry.where(level: 1): it => link(it.element.location())[
    #block(above: 0.5em)
    #if it.element.numbering == appendixnumbering [
      *#numbering(appendixnumberingshort, counter(heading).at(it.element.location()).first()) #it.body()*
    ] else [*#it.prefix() #it.body()* #h(1fr) #it.page()]
  ]

  #show figure.caption: emph

  // --- Set cover pages ---

  #coverpage(
    level,
    programme,
    title,
    author,
    date,
  )

  #contactpage

  #if (infopage) {
    abstractpage(
      programme,
      title,
      author,
      supervisor,
      level,
      date,
      abstract,
      ccs,
      keywords,
      info,
      appendices,
    )
    pagebreak()
  }

  #outline(depth: 3)
  // #pagebreak()
  #pagebreak()

  // --- Customize headings ---

  #let chapter = state("chapter")
  #let section = state("section")
  #show heading.where(level: 1): it => {
    // Style chapter headings with a larger font size and margin
    show heading: chapterheading

    {
      // Hack: insert a dummy header which decrements the page counter on blank
      // pages, which are generated when breakto == "odd" or "even".
      set page(
        header: [#counter(page).update(i => i - 1)],
        numbering: none,
        footer: none,
      )
      // Always start chapter headings from a fresh page
      pagebreak(to: breakto, weak: true)
    }

    // Store chapter heading body for headers and unset section
    chapter.update(it.body)
    section.update(none)

    it
  }

  #show heading.where(level: 2): it => {
    // Store section heading body for headers
    section.update(it.body)
    it
  }

  #set heading(numbering: "1.1 ")

  #show heading.where(level: 1): set heading(supplement: [Chapter])

  #show heading.where(level: 2): set heading(supplement: [Section])

  #show heading.where(level: 3): set heading(supplement: [Subsection])

  #show heading.where(level: 2): it => [
    #set text(size: 16pt)
    #set block(below: 1em)
    #it
  ]

  #show heading.where(level: 3): it => [
    #set text(size: 14pt)
    #it
  ]

  #show heading.where(level: 4): it => [
    #block(above: 1em, below: 1em)[#it.body]
  ]

  // Restart page counter
  #counter(page).update(1)

  // Start displaying page headers
  #set page(
    header: [
      // Define helper functions
      #let pagenumbering() = [#numbering("1", counter(page).get().first())]
      #let chapternumbering() = [
        #show: upper
        #show ". ": ".  "
        #set text(style: "italic")
        Chapter
        #numbering("1. ", counter(heading).get().first())
        #chapter.get()
      ]
      #let sectionnumbering() = if (section.get() != none) [
        #show: upper
        #show ". ": ".  "
        #set text(style: "italic")
        #numbering("1.1. ", ..counter(heading).get().chunks(2).first())
        #section.get()
      ]
      #context {
        let nextheading = query(heading.where(level: 1).after(here()))
        // Do not show header if chapter heading is on current page
        if (nextheading.len() != 0 and nextheading.first().location().page() != here().page()) {
          // Headers have different layout depending on page side
          if (calc.even(here().page())) {
            place(left + bottom, pagenumbering())
            place(right + bottom, chapternumbering())
          } else {
            place(left + bottom, sectionnumbering())
            place(right + bottom, pagenumbering())
          }
        }
      }
    ],
  )

  // Customize tables

  #show table.cell: set par(justify: false)
  #set table(
    stroke: (x, y) => if y == 0 { (bottom: 0.7pt + black) } else { (bottom: 0.3pt + black) },
  )

  // --- Set main pages ---

  #doc

  // --- Set bibliography pages ---

  #show heading: set heading(numbering: none)

  #bibliography(bibsources)

  #end-anchor(end-label("bibliography"))

  // --- Set appendix pages ---

  #if (appendices.len() > 0) {
    show heading: set heading(numbering: "A.1 ")
    show heading.where(level: 1): it => [
      #show text: set text(size: 14pt)
      #it
    ]
    show heading.where(level: 1): set heading(
      numbering: appendixnumbering,
      supplement: none,
    )

    set page(header: none, numbering: "i")
    counter(heading).update(0)

    for (i, appendix) in appendices.enumerate() {
      counter(page).update(1)
      appendix
      end-anchor(end-label-appendix(i))
      pagebreak(weak: true)
    }
  }
]
