#let template(
  title: [Thesis title],
  candidate: (),
  supervisor: (),
  co-supervisor: (),
  department: (),
  university: (),
  school: (),
  course: (),
  date: (),
  logo: none,
  lang: "it",
  bib: (),
  abstract: none,
  acknowledgements: none,
  body,
) = {
  // Language dictionary
  let translations = (
    "en": (
      "contents": "Contents",
      "bibliography": "Bibliography",
      "acknowledgements": "Acknowledgements",
      "abstract": "Abstract",
      "chapter": "Chapter",
      "supervisor": "Supervisor",
      "co-supervisor": "Co-Supervisor",
      "candidate": "Candidate",
      "matriculation_number": "Matriculation number",
      "academic_year": "Academic Year",
    ),
    "it": (
      "contents": "Indice",
      "bibliography": "Bibliografia",
      "acknowledgements": "Ringraziamenti",
      "abstract": "Sommario",
      "chapter": "Capitolo",
      "supervisor": "Relatore",
      "co-supervisor": "Correlatore",
      "candidate": "Candidato",
      "matriculation_number": "Numero di matricola",
      "academic_year": "Anno Accademico",
    ),
  )

  // Get translation dictionary for selected language, default to English
  let t = if lang in translations { translations.at(lang) } else {
    translations.at("en")
  }

  // State to track the current chapter
  let current-chapter = state("current-chapter", none)

  // State to track new chapter pages
  let chapter-start-page = state("chapter-start-page", none)

  set document(title: title, author: candidate.name)
  show link: underline
  set page(numbering: "1")
  set text(size: 13pt, lang: lang)
  set math.equation(numbering: "(1)")
  set heading(numbering: "1.1.1")
  set par(justify: true)
  show heading.where(level: 1): item => {
    if (
      item.body == [#t.contents]
        or item.body == [#t.acknowledgements]
        or item.body == [#t.abstract]
        or item.body == [#t.bibliography]
    ) {
      block(width: 100%, height: 8%)[
        #set align(left + horizon)
        #set text(1.2em, weight: "bold")
        #text([#item.body])
      ]
    } else {
      pagebreak()
      // Mark this page as a chapter start
      chapter-start-page.update(counter(page).get().first())
      // Update current chapter
      current-chapter.update(item.body)
      block(width: 100%, height: 8%)[
        #set align(left + horizon)
        #set text(1.2em, weight: "bold")
        #text([#counter(heading).display()])
        #h(0.1em)
        #text([#item.body])
      ]
    }
  }

  set page(
    header: context {
      let chapters = query(selector(heading.where(level: 1)))
      // Get the current page
      let current-page = counter(page).get().first()

      // Check if current page is any chapter start page
      let chapter-pages = chapters.map(c => c.location().page())
      if current-page in chapter-pages {
        return // Don't show header on chapter start pages
      }

      // Find which chapter we're currently in
      let relevant-chapters = chapters.filter(c => (
        c.location().page() <= current-page
      ))
      if relevant-chapters.len() > 0 {
        let current-chapter = relevant-chapters.last()
        let chapter-text = current-chapter.body

        if calc.odd(current-page) {
          text(upper(chapter-text), style: "italic")
          h(1fr)
          [#current-page]
        } else {
          [#current-page]
          h(1fr)
          text(upper(chapter-text), style: "italic")
        }
      }
    },
    footer: context {
      let page = counter(page).get().first()

      // Show centered page number in footer only for chapter start pages
      if chapter-start-page.get() == page {
        align(center, [#page])
      }
    },
  )

  show outline.entry: it => {
    if (
      it.element.body == [#t.acknowledgements]
        or it.element.body == [#t.abstract]
        or it.element.body == [#t.bibliography]
    ) {
      []
    } else {
      if (it.element.level == 1) {
        linebreak()
        let num = counter(heading).at(it.element.location()).first()
        text(size: 1.1em, strong([#num]))
        h(0.5em)
        text(size: 1.1em, strong([#it.element.body]))
        h(1fr)
        counter(page).display()
      } else {
        it
      }
    }
  }

  // Title page
  align(center, block[
    #text(smallcaps(university), stretch: 142%) \
    *#school* \
    *#department* \
    *#course* \
  ])

  v(40pt)
  if logo != none {
    align(center, logo)
  }

  v(40pt)
  align(center, text(size: 20pt, title, weight: "bold"))

  v(40pt)
  text([*#t.supervisor*: \ #supervisor])

  if co-supervisor != none and co-supervisor != () and co-supervisor != "" {
    v(20pt)
    text([*#t.co-supervisor*: \ #co-supervisor.map(item => [
        #item
      ]).join(linebreak())])
  }

  align(right, block[
    #text(weight: "bold", [#t.candidate: ]) \
    #candidate.name \
    #text([#t.matriculation_number: #candidate.number]) \
  ])

  align(center + bottom, text(weight: "bold", [#t.academic_year: #date]))

  pagebreak()

  // Acknowledgements
  if acknowledgements != none {
    heading(level: 1, numbering: none, t.acknowledgements)
    acknowledgements
    pagebreak()
  }

  // Abstract
  if abstract != none {
    heading(level: 1, numbering: none, t.abstract)
    abstract
    pagebreak()
  }

  // TOC
  outline()

  // Body
  body

  // Bibliography
  if bib != () {
    pagebreak()
    bib
  }
}
