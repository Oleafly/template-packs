#import "locale.typ": *

#let titlepage(
  authors,
  date,
  title-font,
  language,
  logo,
  many-authors,
  supervisor,
  title,
  type-of-thesis,
  university,
  university-location,
  date-format,
  page-grid,
) = {

  // ---------- Page Setup ---------------------------------------

  set page(
    // identical to document
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
  )
  // The whole page in `title-font`, all elements centered
  set text(font: title-font, size: page-grid)
  set align(center)

  // ---------- Logo(s) ---------------------------------------


  place(
    top + center,
    dy: -4 * page-grid,
    box(logo, height: 3.5 * page-grid)
  )
  linebreak()


  text(fill: luma(80), size: 11pt, "Fakultät für Elektrotechnik und Informationstechnik")
  linebreak()
  text(fill: luma(80), size: 11pt, "Institut für Medientechnik")
  linebreak()
  text(fill: luma(80), size: 11pt, "Fachgebiet Audiovisuelle Technik")
  linebreak()


  v(7 * page-grid)
  if (type-of-thesis != none and type-of-thesis.len() > 0) {
    align(center, text(size: page-grid, type-of-thesis, font: "Latin Modern Roman Caps"))
    v(0.25 * page-grid)
  }

  // ---------- Title ---------------------------------------
  text(weight: "bold", fill: luma(80), size: 1.5 * page-grid, title)
  v(page-grid)



  // ---------- Author(s) ---------------------------------------

  place(
    bottom + center,
    dy: -15 * page-grid,
    grid(
      columns: 100%,
      gutter: if (many-authors) {
        14pt
      } else {
        1.25 * page-grid
      },
      ..authors.map(author => align(
        center,
        {
          text(author.name)
        },
      ))
    )
  )

  // ---------- Info-Block ---------------------------------------

  set text(size: 11pt)
  place(
    bottom + center,
    grid(
      columns: (auto, auto),
      row-gutter: 1em,
      column-gutter: 1em,
      align: (right, left),

      // submission date
      text(weight: "bold", fill: luma(80), TITLEPAGE_DATE.at(language)),
      text(
        if (type(date) == datetime) {
          date.display(date-format)
        } else {
          date.at(0).display(date-format) + [ -- ] + date.at(1).display(date-format)
        },
      ),

      // students
      align(text(weight: "bold", fill: luma(80), TITLEPAGE_COURSE.at(language)), top),
      stack(
        dir: ttb,
        for author in authors {
          text([#author.course-of-studies])
          linebreak()
        }
      ),


      // university supervisor
      ..if ("professor" in supervisor) {
        (
          text(
            weight: "bold", fill: luma(80),
            TITLEPAGE_PROF_SUPERVISOR.at(language)
          ),
          if (type(supervisor.professor) == str) {text(supervisor.professor)}
        )
      },
      ..if ("university" in supervisor) {
        (
          text(
            weight: "bold", fill: luma(80),
            TITLEPAGE_SUPERVISOR.at(language)
          ),
          if (type(supervisor.university) == str) {text(supervisor.university)}
        )
      },

    )
  )
}