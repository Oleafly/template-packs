#import "@preview/muchpdf:0.1.0": muchpdf
#import "thesis-template/translations.typ": *

#let page-break(to: "odd", weak: true) = {
  set page(numbering: none)
  pagebreak(to: to, weak: weak)
  set page(numbering: "1")
}

#let thesis(
  thesis-lang: "en", // for Slovak, use "sk"
  thesis-type: "bp1", // bp1, bp2, dp1, dp2, dp3, etc.
  paper-size: "a4",
  // TODO: not used yet in the lib.typ code
  page-numbering-position: "center", // "book" or "center" (default: "center")
  evidence-number: "FIIT-XXXXX-XXXXXX", // thesis ID number obtained from AIS
  title: (
    en: "The title of the thesis",
    sk: "Názov práce"
  ),
  author: "Placeholder for author name", // "name surname" with titles in double quotes
  thesis-supervisor-name: "Placeholder for thesis supervisor name", // "name surname" with titles in double quotes
  // departmental-advisor == pedagogical supervisor == pedagogický vedúci
  departmental-advisor: "Placeholder for departmental advisor name", // "name surname" with titles in double quotes or `none` if you do not have additional supervisor
  study-program: (en: "Informatics", sk: "Informatika"),
  study-field: "9.2.1 Computer Science / 9.2.1 Informatika",
  workplace: "Institute of Computer ... / Ústav počítačového ...",
  date: (en: "20xx, May", sk: "Máj 20xx"),
  assignment: none,
  bibliography: none,
  bib-style: "ieee",
  underline-links: true,
  annotations: (
    sk: [
      Text anotácie. #underline("Dĺžka by mala byť 150-200 slov.")
      #lorem(200)
    ],
    en: [
      Annotation text. #underline("Size should be 150-200 words.")
      #lorem(200)
    ],
  ),
  acknowledgement: [
    Write your acknowledgement. #underline("Do not forget") to mention your
    thesis supervisor.

    Napíšte svoje poďakovanie. #underline("Nezabudnite") spomenúť svojho vedúceho práce.
  ],
  list-of-abbrev: none,
  list-of-figures: true,
  list-of-tables: true,
  appendices: [],
  // TODO: not used yet in the lib.typ code
  // text sizes
  main-text-size: 12pt, // the document is tested mainly for default value of this variable which is 12pt
  body,
) = {
  // setting text to selected language for typst paragraph justification (build-in function)
  set text(lang: thesis-lang)

  // for translating from dictionaries
  let lang(v) = {
    return v.at(thesis-lang)
  }

  // document global settings
  set document(title: lang(title), author: author)
  set page(paper: paper-size)
  set text(font: "STIX Two Text", size: 12pt, spacing: 0.35em)
  set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--], [∗]))
  set enum(indent: 10pt, body-indent: 9pt, numbering: "1)a)i)")

  set std.bibliography(title: text(1em)[#lang(supplements.at("bib-name"))], style: bib-style)
  // line spacing {default: set par(leading: 0.65em)} src: https://github.com/typst/typst/issues/106#issuecomment-1497030336
  set par(leading: 1.5em)
  set heading(numbering: "1.1.1.", supplement: lang(supplements.at("section-supplement")))

  // underline all links based on user choice
  show link: it => {
    if underline-links {
      underline[#it]
    } else {
      it
    }
  }

  // tables & figures setup
  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set text(size: 10pt)

  show figure.where(kind: table): set figure(supplement: lang(supplements.at("table-supplement")), numbering: "1.1")
  show figure.where(kind: image): set figure(supplement: lang(supplements.at("figure-supplement")), numbering: "1.1")

  show figure.caption: set text(size: 10pt)
  show figure.caption: set align(start)

  show figure.caption.where(kind: table): set align(center)
  show figure.caption.where(kind: image): set align(center)

  // supplement for references and for captions are the same !
  show figure: fig => {
    let prefix = (
      if fig.kind == table [#lang(supplements.at("table-supplement"))] else if fig.kind == image [#lang(
        supplements.at(
          "figure-supplement",
        ),
      )] else [#fig.supplement]
    )

    let heading-levels = counter(heading).get().first()
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))

    show figure.caption: it => [#prefix~#heading-levels\.#numbers: #it.body]
    fig
  }

  // ------------- INFO FIGURE AND TABLE COUNTING ----------
  // show heading.where(level: 1): it => {
  //   counter(figure.where(kind: image)).update(0)
  //   counter(figure.where(kind: table)).update(0)
  //   it
  // }
  // set figure(numbering: (..num) =>
  //   numbering("1.1", counter(heading).get().first(), num.pos().first())
  // )
  // -------------------------------------------------------

  // references setup
  // configure equation numbering and spacing
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 2em)

  // configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.element.location(), numbering(it.element.numbering, ..counter(math.equation).at(it.element.location())))
    } else if it.element != none and it.element.func() == figure {
      let fig = it.element
      
      // Get the prefix exactly like in the figure show rule
      let prefix = (
        if fig.kind == table [#lang(supplements.at("table-supplement"))] 
        else if fig.kind == image [#lang(supplements.at("figure-supplement"))] 
        else [#fig.supplement]
      )

      //  We must query the heading counter AT THE FIGURE'S LOCATION, 
      // not at the reference's location.
      let heading-levels = counter(heading).at(fig.location()).first()
      
      // Get the figure's raw number
      let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))

      // Construct the link content to match your caption format exactly
      link(fig.location(), [#prefix~#heading-levels\.#numbers])
    } else {
      it
    }
  }

  // heading setup
  show heading: it => {
    // find out the final number of the heading counter
    let levels = counter(heading).get()
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    if it.level == 1 {
      // start each new chapter (1st level heading) on odd page like in a book
      page-break()


      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)


      set text(size: 23pt)
      show: block.with(above: 15pt, below: 2em, sticky: true)
      if it.numbering != none {
        numbering("1", deepest)
        h(0.75em, weak: true)
      }
      it.body
    } else if it.level == 2 {
      set text(size: 16pt)
      show: block.with(above: 30pt, below: 1.75em, sticky: true)
      it
    } else if it.level == 3 {
      set text(size: 14pt)
      show: block.with(above: 30pt, below: 1.5em, sticky: true)
      it
    } else if it.level == 4 {
      set text(size: 13pt)
      show: block.with(above: 30pt, below: 1.5em, sticky: true)
      it
    } else {
      it
    }
  }
  // ========== END OF GENERAL SETUP ===============

  // cover page
  [
    #set align(center + top)
    #set text(15pt)
    #lang(university) \
    #lang(faculty) \
    #set text(10pt)
    #evidence-number \
    #set align(center + horizon)
    #set text(15pt)
    *#author* \
    #set text(20pt)
    *#lang(title)* \
    #set text(12pt)
    #lang(thesis-type-name.at(thesis-type))
    #set align(left + bottom)
    #lang(supervisor-str): #thesis-supervisor-name \
    #if departmental-advisor != none [
      #lang(departmental-advisor-str): #departmental-advisor \
    ]
    #lang(date) \
  ]
  pagebreak(to: "odd")

  // title page
  [
    #set align(center + top)
    #set text(15pt)
    #lang(university) \
    #lang(faculty) \
    #set text(10pt)
    #evidence-number \
    #set align(center + horizon)
    #set text(15pt)
    *#author* \
    #set text(20pt)
    *#lang(title)* \
    #set text(12pt)
    #lang(thesis-type-name.at(thesis-type))
    #set align(left + bottom)
    #lang(study-program-str): #lang(study-program) \
    #lang(study-field-str): #study-field \
    #lang(training-workplace-str): #workplace \
    #lang(supervisor-str): #thesis-supervisor-name \
    #if departmental-advisor != none [
      #lang(departmental-advisor-str): #departmental-advisor \
    ]
    #lang(date) \
  ]
  pagebreak(to: "odd")

  // assignment
  if assignment == none [
    #text(blue)[
      Input your assignment as `.pdf`. The `.pdf` can be generated by AIS in the `Final Theses` section. Use the `assignment` parameter of `thesis` to set the path to the file, e.g.\ `assignment: "../assets/assignment.pdf"` \
    ]
  ] else [
    #muchpdf(
      read(assignment, encoding: none),
      // width: 100%,
    )
  ]
  pagebreak(to: "odd")

  // honest declaration
  [
    #set align(bottom)
    #lang(honest-declaration)
    #v(3em)
    #lang(in-place), #lang(date)
    #set align(right)
    #v(2em)
    #for letter in author {
      [..]
    }\.\.\.\.
    #v(1em)
    #author
  ]
  pagebreak(to: "odd")

  // acknowledgement
  [
    #set text(size: 17pt)
    *#lang(acknowledgement-str)* \
    #v(10pt)
    #set text(size: 12pt)
    #set par(leading: 1.5em, justify: true)
    #acknowledgement
  ]
  pagebreak(to: "odd")

  // annotation is done in special way because it is included in both languages regardless of the thesis language
  let annotate(lang-anotate) = block[
    #set text(size: 17pt)
    *#(en: "Annotation", sk: "Anotácia").at(lang-anotate)* \
    #v(10pt)
    #set text(size: 12pt)
    #set par(leading: 0.5em)
    #university.at(lang-anotate) \ \
    #upper[#faculty.at(lang-anotate)] \

    #table(
      // setup
      inset: (left: 0pt, right: 3em),
      align: left,
      row-gutter: 0.5em,
      stroke: none,
      columns: 2,
      // content (1 row divided by \n in the code for better clarity)
      (en: "Degree course:", sk: "Študijný program:").at(lang-anotate), study-program.at(lang-anotate),

      (en: "Author:", sk: "Autor:").at(lang-anotate), author,

      if thesis-type.find("bp") == "bp" [
        #thesis-type-name.at("bp2").at(lang-anotate):
      ] else if thesis-type.find("dp") == "dp" [
        #thesis-type-name.at("dp3").at(lang-anotate):
      ],
      title.at(lang-anotate),

      (
        en: "Supervisor:",
        sk: [
          Vedúci #if thesis-type.find("bp") == "bp" [
            bakalárskej
          ] else if thesis-type.find("dp") == "dp" [
            diplomovej
          ] práce:
        ],
      ).at(lang-anotate),
      [#thesis-supervisor-name],

      ..if departmental-advisor != none {
        (
          (en: "Departmental advisor:", sk: "Pedagogický vedúci:").at(lang-anotate),
          departmental-advisor,
        )
      },
    )

    #set text(size: 12pt)
    #set par(leading: 1.4em, justify: true)
    #date.at(lang-anotate)
    #v(1em)
    #annotations.at(lang-anotate)
  ]

  annotate("sk")
  pagebreak(to: "odd")

  annotate("en")
  pagebreak(to: "odd")

  // table of contents (1)
  set page(numbering: "I")
  // make 1st level headings bold in the outline
  show outline.entry: it => {
    if it.element != none and it.element.func() == heading and it.level == 1 {
      strong(it)

      // show "Appendices" section" after References if there are appendices
      if it.element.body.func() != text and appendices != [] {
        strong(lang(supplements.at("appendix-supplement-plural")))
      }
    } else if it.element != none and it.element.func() == figure {
      let fig = it.element
      
      // Determine prefix string (Table / Figure)
      let prefix = (
        if fig.kind == table [#lang(supplements.at("table-supplement"))] 
        else if fig.kind == image [#lang(supplements.at("figure-supplement"))] 
        else [#fig.supplement]
      )

      // Get chapter and local position numbers relative to figure location
      let heading-levels = counter(heading).at(fig.location()).first()
      let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
      // We pass our formatted [Figure X.Y] prefix to it.indented, which keeps the 
      // core table of contents structure perfectly safe and version-agnostic!
      link(fig.location(), it.indented(
        [#prefix~#heading-levels\.#numbers\:], 
        it.inner()
      ))
    } else {
      it
    }
  }

  // table of contents (2)
  outline(title: lang(toc-str), indent: auto)

  // list of abbreviations
  if list-of-abbrev != none [
    #set heading(numbering: none, outlined: false)
    = #lang(list-of-abbrev-str)
    #list-of-abbrev
  ]

  // list of figures
  if list-of-figures [
    #outline(title: lang(list-of-figures-str), target: figure.where(kind: image))
  ]

  // list of tables
  if list-of-tables [
    #outline(title: lang(list-of-tables-str), target: figure.where(kind: table))
  ]

  // paragraph setting for the body of the thesis
  set par(spacing: 3em, justify: true, leading: 1em)
  set page(numbering: "1")
  body

  // display bibliography
  set par(spacing: 2em)
  set heading(numbering: none, outlined: true)
  bibliography
  set par(spacing: 3em, justify: true, leading: 1em)

  // appendices
  set page(numbering: (..nums) => {
    let h = counter(heading).get()
    if h.len() > 0 {
      let letter = numbering("A", h.at(0))
      return letter + "-" + str(nums.at(0))
    }
    return "A-" + str(nums.at(0))
  })

  set heading(numbering: "A.1.1", outlined: true)
  counter(heading).update(0)

  show heading.where(level: 1): it => {
    page-break()
    set text(size: 23pt)
    show: block.with(above: 15pt, below: 2em, sticky: true)
    if it.numbering != none {
      (
        text(lang(supplements.at("appendix-supplement-singular")))
          + text(" ")
          + numbering("A", counter(heading).get().at(0, default: 0))
      )
      h(0.75em, weak: true)
    }
    [\ \ #it.body]
  }

  show heading.where(level: 2): it => {
    set text(size: 16pt)
    show: block.with(above: 30pt, below: 1.75em, sticky: true)
    it
  }
  show heading.where(level: 3): it => {
    set text(size: 14pt)
    show: block.with(above: 30pt, below: 1.5em, sticky: true)
    it
  }

  show heading.where(level: 4): it => {
    set text(size: 13pt)
    show: block.with(above: 30pt, below: 1.5em, sticky: true)
    it
  }

  counter(page).update(0)
  appendices
}
