#let globalPage = (
  paper: "a4",
  margin: (
    left: 40mm,
    right: 20mm,
    top: 40mm,
    bottom: 30mm,
  ),
  // header-ascent: 15pt,
  // footer-descent: 12pt,
)

#let globalText = (
  font: "New Computer Modern",
  size: 12pt,
  lang: "en",
)

#let globalPar = (
  leading: 1.6em, // double spacing
  justify: true,
  spacing: 2em,
  linebreaks: "optimized",
  first-line-indent: 1.5em,
)

#set bibliography(style: "ieee")

#let globalStyles(
  doc,
) = {
  show heading: set block(above: 3.2em, below: 1.6em)
  set heading(numbering: "1.1")
  show table: set par(leading: 0.75em)
  set text(..globalText)
  set par(..globalPar)
  set page(..globalPage)
  doc
}

// table of contents etc
#let lists(
  doc,
) = {
  counter(page).update(1)
  set page(numbering: "i")
  doc
}

#let getSubsectionHeader() = {
  let selectorBefore = selector(heading).before(here())
  let headingsBefore = query(selectorBefore)

  if headingsBefore.len() == 0 {
    return none
  }

  // If this page starts a new chapter, suppress the header on this page.
  let chapterSelectorAfter = selector(heading.where(level: 1)).after(here())
  let nextChapters = query(chapterSelectorAfter)
  if nextChapters.len() > 0 {
    let nextChapter = nextChapters.first()
    if nextChapter.location().page() == here().page() {
      return none
    }
  }

  let heading = headingsBefore.last()
  if heading.level < 2 {
    return none
  }

  let level = counter(selectorBefore)
  let headerText = {
    set par(spacing: 0.4em)
    level.display()
    h(1em)
    heading.body
    h(1fr)
    counter(page).display()
    line(length: 100%)
  }
  pad(top: globalPage.margin.top)[
    #smallcaps[
      #headerText
    ]
  ]
}

#let mainContent(
  doc,
) = {
  counter(page).update(1)
  set page(
    numbering: "1",
    header: context getSubsectionHeader(),
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 24pt)
    v(128pt)
    it
  }

  doc
}




#let tableOfContents() = {
  outline(title: "Table of Contents")

  pagebreak()
}


#let defaultMetadata = (
  title: "My Research Title",
  author: "John Doe",
  year: 2026,
  month: 1,
  university: "University of Turku",
  department: "Department of Computing",
  lab: none,
  thesisType: "Master of Science (Tech) Thesis",
  supervisors: ("Dr. Jane Smith", "Prof. John Wilson"),
  keywords: ("typist", "thesis"),
  includeTurnitin: true,
)

#let coverPage(metadata: defaultMetadata) = {
  metadata = (defaultMetadata + metadata)

  set page(numbering: none)

  set par(
    leading: 1em,
    justify: true,
    linebreaks: "optimized",
  )

  align(center)[
    #let title = {
      line(length: 100%, stroke: 2pt)
      align(right, text(
        metadata.title,
        size: 24pt,
        weight: 100,
        costs: (hyphenation: 1000%),
      ))
      line(length: 100%, stroke: 2pt)
    }

    #v(1fr)
    #title
    #v(4fr)
  ]

  set par(
    leading: 0.5em,
  )

  align(right)[
    #text(size: 12pt)[
      #smallcaps[#metadata.university] \
      #metadata.department \
      #metadata.thesisType \
      #if (metadata.lab != none) [#metadata.lab \ ]
      #datetime(year: metadata.year, month: metadata.month, day: 1).display(
        "[month repr:long] [year]",
      ) \
      #metadata.author \
      #if metadata.supervisors.len() > 1 [
        Supervisors:
        #metadata.supervisors.join(", ")
      ] else if metadata.supervisors.len() > 0 [
        Supervisor:
        #metadata.supervisors.at(0)
      ]
    ]
  ]

  v(1fr)
  align(center)[

    #if metadata.includeTurnitin {
      text(
        size: 8pt,
      )[The originality of this thesis has been checked in accordance with the University of Turku quality assurance system using the Turnitin OriginalityCheck service.]
    }
  ]
  pagebreak()
}
