#import "locale.typ": *

#let titlepage(
  authors,
  date,
  title-font,
  language,
  logo-left,
  logo-right,
  many-authors,
  supervisor,
  title,
  type-of-thesis,
  university,
  university-location,
  at-university,
  date-format,
  show-confidentiality-statement,
  confidentiality-marker,
  university-short,
  page-grid,
) = {
  // ---------- Page Setup ---------------------------------------

  set page(
    // identical to document
    margin: (top: 2.5cm, bottom: 3.1cm, left: 2.5cm, right: 2.5cm),
  )
  // The whole page in `title-font`, all elements centered
  set text(font: title-font, size: page-grid)
  set align(center)

  // ---------- Logo(s) ---------------------------------------

  if logo-left != none and logo-right == none {
    // one logo: centered
    place(
      top + center,
      dy: -3 * page-grid,
      box(logo-left, height: 3 * page-grid),
    )
  } else if logo-left != none and logo-right != none {
    // two logos: left & right
    place(
      top + left,
      dy: -3 * page-grid,
      box(logo-left, height: 3 * page-grid),
    )
    place(
      top + right,
      dy: -3 * page-grid,
      box(logo-right, height: 3 * page-grid),
    )
    v(0.5 * page-grid)
    line(length: 100%, stroke: 0.5pt)
  }

  // ---------- Title ---------------------------------------

  v(3 * page-grid)
  text(weight: "bold", size: 2 * page-grid, title)
  v(page-grid)

  // ---------- Confidentiality Marker (optional) ---------------------------------------

  if (confidentiality-marker.display) {
    place(
      right,
      dy: -9em,
      circle(radius: 1em, fill: red),
    )
  }

  // ---------- Sub-Title-Infos ---------------------------------------
  //
  // type of thesis (optional)
  if (type-of-thesis != none and type-of-thesis.len() > 0) {
    align(center, text(size: 1.5 * page-grid, type-of-thesis))
    v(page-grid)
  }

  // course of studies
  text(
    "des "
      + TITLEPAGE_SECTION_B.at(language)
      + [ ]
      + authors.map(author => author.course-of-studies).dedup().join(" | ")
      + [ ]
      + authors.map(author => author.specialization).dedup().join(" | "),
  )
  v(0.25 * page-grid)

  // university
  text("an der " + university)
  linebreak()
  text(university-location)


  // ---------- Author(s) ---------------------------------------

  v(2 * page-grid)
  grid(
    columns: 100%,
    gutter: if (many-authors) {
      14pt
    } else {
      1.25 * page-grid
    },
    TITLEPAGE_BY.at(language),
    ..authors.map(author => align(
      center,
      {
        text(author.name)
        linebreak()
      },
    )),
    v(1em),
    date.display(date-format)
  )

  // ---------- Info-Block ---------------------------------------

  set text(size: 11pt)
  place(
    bottom + center,
    grid(
      columns: (auto, auto),
      row-gutter: 1em,
      column-gutter: 3em,
      align: (left, left),

      // submission date
      text(weight: "bold", fill: luma(80), TITLEPAGE_DATE.at(language)),
      text(authors.map(author => author.work-weeks).dedup().join(" | ")),

      // students
      align(text(weight: "bold", fill: luma(80), TITLEPAGE_STUDENT_ID.at(language)), top),
      stack(
        dir: ttb,
        for author in authors {
          text([#author.student-id, #author.course])
          linebreak()
        },
      ),

      // company
      // extract the array inside the if statement, this makes the whole line disappear when the condition is false
      ..if (not at-university) {
        (
          { align(text(weight: "bold", fill: luma(80), TITLEPAGE_COMPANY.at(language)), top) },
          {
            stack(
              dir: ttb,
              for author in authors {
                let company-address = ""

                // company name
                if (
                  "name" in author.company and author.company.name != none and author.company.name != ""
                ) {
                  company-address += author.company.name
                } else {
                  panic(
                    "Author '"
                      + author.name
                      + "' is missing a company name. Add the 'name' attribute to the company object.",
                  )
                }

                // company address (optional)
                if (
                  "post-code" in author.company and author.company.post-code != none and author.company.post-code != ""
                ) {
                  company-address += text([, #author.company.post-code])
                }

                // company city
                if (
                  "city" in author.company and author.company.city != none and author.company.city != ""
                ) {
                  company-address += text([, #author.company.city])
                } else {
                  panic(
                    "Author '"
                      + author.name
                      + "' is missing the city of the company. Add the 'city' attribute to the company object.",
                  )
                }

                // company country (optional)
                if (
                  "country" in author.company and author.company.country != none and author.company.country != ""
                ) {
                  company-address += text([, #author.company.country])
                }

                company-address
                linebreak()
              },
            )
          },
        )
      },

      // company supervisor
      // extract the array inside the if statement, this makes the whole line disappear when the condition is false
      ..if ("company" in supervisor and type(supervisor.company) == str and not at-university) {
        (
          text(weight: "bold", fill: luma(80), TITLEPAGE_COMPANY_SUPERVISOR.at(language)),
          text(supervisor.company),
        )
      },

      // university supervisor
      // extract the array inside the if statement, this makes the whole line disappear when the condition is false
      ..if ("university" in supervisor and type(supervisor.university) == str) {
        (
          text(
            weight: "bold",
            fill: luma(80),
            TITLEPAGE_SUPERVISOR.at(language) + university-short + [:],
          ),
          text(supervisor.university),
        )
      },
    ),
  )
}
