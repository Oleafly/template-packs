// "THE BEER-WARE LICENSE" (Revision 42):
// L. Daniel Casais <@rajayonin> wrote this file. As long as you retain this
// notice you can do whatever you want with this stuff. If we meet some day, and
// you think this stuff is worth it, you can buy me a beer in return.


#let verdeudima = rgb("#004d35")
#let rojoudima = rgb("#ec1d23")

// Fix in order to display the month in spanish
#let MONTHS = (
  "Enero",
  "Febrero",
  "Marzo",
  "Abril",
  "Mayo",
  "Junio",
  "Julio",
  "Agosto",
  "Septiembre",
  "Octubre",
  "Noviembre",
  "Diciembre",
)

#let SEMESTERS = (
  "Primer",
  "Segundo",
)


/// Writes the authors name in short format
///
/// - authors (array): An array containing the authors information to iterate through
/// -> content
#let _shortauthors(authors: ()) = {
  for (i, author) in authors.enumerate() {
    // name
    for name in author.name.split(" ") {
      name.at(0) + ". "
    }

    // surname
    if "surname_length" in author {
      author.surname.split(" ").slice(0, count: author.surname_length).join(" ")
    } else {
      author.surname.split(" ").at(0)
    }

    // connector
    if i < authors.len() - 2 {
      ", "
    } else if i == authors.len() - 2 {
      " & "
    }
  }
}

/// A functiong that generates the cover for the report.
///
/// - degree (str): The degree your are enroled in
/// - subject (str): The subject the report is for
/// - project (str): Type of project, i.e. `"Lab 1"` (mind it will only display what you put here, no content will be added)
/// - title (str): Title of the project
/// - year (array): An array containing the academic year, i.e. `(25, 26)`
/// - semester (int): Semester, i.e. `1` (optional)
/// - group (int, none): Course group number, i.e. `89` (optional)
/// - authors (dictionaty): Authors information `(name: str, surname: str)`
/// - professor (str, none): Professor's name
/// - team (str): Team name (optional)
/// - date (datetime, content): Presentation date. Either a `datetime` object or `content`
/// - date-format (str, auto): (Only if the type of `date` is datetime) Format syntax (see https://typst.app/docs/reference/foundations/datetime/#format)
/// -> content
#let _cover(
  degree,
  subject,
  project,
  title,
  year,
  semester,
  group: none,
  authors: (),
  professor: none,
  team: none,
  date: none,
  date-format: auto,
) = {
  set align(center)
  set par(justify: false)
  set text(verdeudima)
  set text(size: 17pt)
  set page(header: [], footer: [])

  // logo
  image("img/logo-udima.jpg", width: 70%)
  v(.5fr)

  // degree
  emph(degree)
  parbreak()

  v(.5fr)

  // project
  emph(project)
  linebreak()
  text(25pt, ["#title"])

  line(length: 70%, stroke: verdeudima)

  // subject
  [#subject #year.at(0)/#year.at(1)]
  if semester != none [ (#SEMESTERS.at(semester - 1) Semestre)]

  // group
  linebreak()
  if group != none [Grupo #group]


  v(1fr)

  // team
  if team != none [
    #text(size: 1.4em, [#team:])
    #v(0.5em)
  ]

  // authors
  if authors.len() < 5 {
    set text(20pt)
    for author in authors [
      #author.name #author.surname
    ]
  } else {
    for i in range(calc.ceil(authors.len() / 3)) {
      let end = calc.min((i + 1) * 3, authors.len())
      let is-last = authors.len() == end
      let slice = authors.slice(i * 3, end)
      grid(
        columns: slice.len() * (1fr,),
        gutter: 12pt,
        ..slice.map(author => align(center, {
          set text(size: 11pt)
          author.name + " " + author.surname
        }))
      )

      if not is-last {
        v(16pt, weak: true)
      }
    }
  }

  v(1fr)

  // date
  if date != none {
    set text(size: 1em)

    if type(date) == content {
      date
    } else {
      if date-format == auto { date-format = "[Day] [month repr:long] [year]" }
      if date-format.contains("[month repr:long]") {
        date-format = date-format.replace(
          "[month repr:long]",
          MONTHS.at(date.month() - 1),
        )
      }
      date.display(date-format)
    }
    v(.5fr)
  }

  // professor
  if professor != none [
    _Profesor_\
    #professor
  ]

  pagebreak()
  counter(page).update(1)
}

/// Main configuration function.
///
/// - degree (str): The degree your are enroled in
/// - subject (str): The subject the report is for
/// - project (str): Type of project, i.e. `"Lab 1"` (mind it will only display what you put here, no content will be added)
/// - title (str): Title of the project
/// - year (array): An array containing the academic year, i.e. `(25, 26)`
/// - semester (int): Semester, i.e. `1` (optional)
/// - group (int, none): Course group number, i.e. `89` (optional)
/// - authors (dictionaty): Authors information `(name: str, surname: str, nia: int)`
/// - professor (str): Professor's name
/// - team (str, none): Team name (optional)
/// - toc (boolean): Whether to show the table of contents (`true`) or not (`false`)
/// - bibliography-content (content, none): Bibliography contents, usually calling `bibliography`.
/// - appendixes (content, none): Set of appendixes.
/// - chapter-on-new-page (bool):  Whether to start each chapter on a new page (`true`) or not (`false`)
/// - date (datetime, none): Report date to put in the cover page, e.g. `datetime.today()`. If `none`, no date will be displayed.
/// - date-format (str, auto): Date format syntax (see https://typst.app/docs/reference/foundations/datetime/#format). Only applies if `date` is not `none`.
/// - doc (content): Document contents
/// -> content
#let conf(
  degree: "",
  subject: "",
  year: (),
  semester: none,
  authors: (),
  project: "",
  title: "",
  group: none,
  professor: none,
  team: none,
  toc: true,
  figure-spacing: 0.75em,
  bibliography-content: none,
  appendixes: none,
  chapter-on-new-page: true,
  date: none,
  date-format: auto,
  doc,
) = {
  /* CONFIG */
  set document(
    title: title,
    author: authors.map(x => x.name + " " + x.surname),
    description: [#project, #subject #year.at(0)/#year.at(1). Universidad Carlos
      III de Madrid],
    date: if date != none and type(date) == datetime { date },
  )

  /* TEXT */

  set text(size: 12pt, lang: "es")

  set par(
    leading: 0.65em,
    spacing: 1em,
    first-line-indent: 1.8em,
    justify: true,
  )


  /* HEADINGS */

  set heading(numbering: "1.")
  show heading: set text(verdeudima)
  show heading: set block(above: 1.4em, below: 1em)
  show heading.where(level: 1): it => {
    if chapter-on-new-page { pagebreak(weak: true) }
    it
  }

  // allow to set headings with selector `<nonumber` to prevent numbering
  show selector(<nonumber>): set heading(numbering: none)

  /* FIGURES */

  // figure captions w/ blue
  show figure.caption: it => {
    [
      #set text(verdeudima, weight: "semibold")
      #it.supplement #context it.counter.display(it.numbering):
    ]
    it.body
  }

  // more space around figures
  // https://stackoverflow.com/questions/78622060/add-spacing-around-figure-in-typst
  show figure.where(kind: image).or(figure.where(kind: table)): it => {
    if it.placement == none {
      block(it, inset: (y: figure-spacing))
    } else {
      place(
        it.placement,
        float: true,
        clearance: figure-spacing,
        block(align(center, it), spacing: figure-spacing, width: 100%),
      )
    }
  }

  /* TABLES */
  // captions on top for tables
  show figure.where(kind: table): set figure.caption(position: top)


  /* REFERENCES & LINKS */

  show ref: set text(rojoudima)
  show link: set text(rojoudima)

  /* LISTS */

  // indent lists
  set list(indent: 1em)
  set enum(indent: 1em)

  /* FOOTNOTES */

  // change line color
  set footnote.entry(separator: line(
    length: 30% + 0pt,
    stroke: 0.5pt + verdeudima,
  ))

  // change footnote number color
  show footnote: set text(verdeudima) // in text
  show footnote.entry: it => {
    // in footnote
    h(1em) // indent
    {
      set text(verdeudima)
      super(str(counter(footnote).at(it.note.location()).at(0))) // number
    }
    h(.05em) // mini-space in between number and body (same as default)
    it.note.body
  }


  /* PAGE LAYOUT */

  set page(
    paper: "a4",
    margin: (
      y: 2.5cm,
      x: 3cm,
    ),

    // header
    header: [
      #set text(verdeudima)
      #project
      #h(1fr)
      #subject#if group != none [, grp. #group]

      #v(-0.7em)
      #line(length: 100%, stroke: 0.4pt + verdeudima)
    ],

    // footer
    footer: context [
      #line(length: 100%, stroke: 0.4pt + verdeudima)
      #v(-0.4em)

      #set align(right)
      #set text(verdeudima)
      #if authors.len() < 5 {
        _shortauthors(authors: authors)
      } else [
        #team
      ]
      #h(1fr)
      #counter(page).display(
        "pg. 1 de 1",
        both: true,
      )
    ],
  )

  /* BIBLIOGRAPHY_ */

  // color bibliography
  // https://forum.typst.app/t/how-do-i-customize-the-numbering-of-the-bibliography/1490/3
  show selector(bibliography).or(cite): it => {
    show link: set text(rojoudima)

    // bibliography references (IEEE)
    show regex("\[\d+\]"): num => {
      set text(verdeudima)
      num
    }
    it
  }

  /* COVER_ */

  _cover(
    degree,
    subject,
    project,
    title,
    year,
    semester,
    authors: authors,
    professor: professor,
    group: group,
    team: team,
    date: date,
    date-format: date-format,
  )


  /* OUTLINES */

  // disable footnotes
  show outline: it => {
    set footnote.entry(separator: none)
    show footnote.entry: hide
    show ref: none
    show footnote: none
    it
  }
  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    // only apply for contents (headings) outline
    if it.element.func() != heading { return it }

    set block(spacing: 1em)
    link(
      it.element.location(), // make entry linkable
      it.indented(
        it.prefix(),
        strong(it.body())
          + if it.page() == "" { "" } else {
            "  " + box(width: 1fr, repeat([.], gap: 2pt)) + "  " + it.page()
          },
      ),
    )
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set block(above: 0.8em)

    show link: set text(black) // reset link color

    link(
      it.element.location(), // make entry linkable
      it.indented(
        it.prefix(),
        it.body()
          + "  "
          + box(width: 1fr, repeat([.], gap: 2pt))
          + "  "
          + it.page(),
      ),
    )
  }

  /* OUTLINES */

  if toc {
    outline(title: [Tabla de contenidos], depth: 3)
    pagebreak()
  }

  // contents
  doc


  /* BIBLIOGRAPHY */

  if bibliography-content != none {
    pagebreak()
    bibliography-content
  }

  /* APPENDIXES */

  // we need to start a new page so `in-appendix` doesn't affect the
  // bibliography
  pagebreak(weak: true)

  set heading(
    // don't show numbering for headings above level 1
    numbering: (..n) => { if n.pos().len() == 1 { numbering("A.", ..n) } },
    supplement: [Apéndice],
    outlined: false, // not in outline
  )
  // show just appendixes titles in outline
  show heading.where(level: 1): set heading(outlined: true)

  counter(heading).update(0)


  if appendixes != none { appendixes }
}
