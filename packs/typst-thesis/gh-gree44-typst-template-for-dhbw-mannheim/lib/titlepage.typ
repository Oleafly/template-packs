#import "locale.typ": *

#let titlepage(
  authors,
  date,
  heading-font,
  language,
  left-logo-height,
  logo-left,
  logo-right,
  many-authors,
  right-logo-height,
  supervisor,
  title,
  type-of-degree,
  type-of-thesis,
  //university,
  university-location,
  at-university,
  date-format,
  show-confidentiality-statement,
  confidentiality-marker,
  university-short,
  university-declined,
  department,  
  head_of_study_program,
  completion_period,
  completion_period_format,
  submission_date,
  submission_date_format,
) = {
  if (many-authors) {
    v(-1.5em)
  } else {
    v(-1em)
  }

  // logos (optional)
  stack(dir: ltr,
    spacing: 1fr,
   // Logo at top left if given
    align(horizon,
      if logo-left != none {
        set image(height: left-logo-height)
        logo-left
      }
    ),
    // Logo at top right if given
    align(horizon,
      if logo-right != none {
        set image(height: right-logo-height)
        logo-right
      }
    )
  )

  if (many-authors) {
    v(1fr)
  } else {
    v(1.5fr)
  }

  // title
  align(center, text(weight: "semibold", font: heading-font, 2em, title))

  if (many-authors) {
    v(0.5em)
  } else {
    v(1.5em)
  }

  // confidentiality marker (optional)
  if (confidentiality-marker.display) {
    let size = 7em
    let display = false
    let title-spacing = 2em
    let x-offset = 0pt

    let y-offset = if (many-authors) {
      7pt
    } else {
      0pt
    }

    if (type-of-degree == none and type-of-thesis == none) {
      title-spacing = 0em
    }

    if ("display" in confidentiality-marker) {
      display = confidentiality-marker.display
    }
    if ("offset-x" in confidentiality-marker) {
      x-offset = confidentiality-marker.offset-x
    }
    if ("offset-y" in confidentiality-marker) {
      y-offset = confidentiality-marker.offset-y
    }
    if ("size" in confidentiality-marker) {
      size = confidentiality-marker.size
    }
    if ("title-spacing" in confidentiality-marker) {
      confidentiality-marker.title-spacing
    }

    v(title-spacing)

    let color = if (show-confidentiality-statement) {
      red
    } else {
      green.darken(5%)
    }

    place(
      right,
      dx: 35pt + x-offset,
      dy: -70pt + y-offset,
      circle(radius: size / 2, fill: color),
    )
  }

  // type of thesis (optional)
  if (type-of-thesis != none and type-of-thesis.len() > 0) {
    align(center, text(weight: "semibold", 1.25em, type-of-thesis))
    v(0.5em)
  }

  // type of degree (optional)
  if (type-of-degree != none and type-of-degree.len() > 0) {
    align(center, text(1em, TITLEPAGE_SECTION_A.at(language)))
    v(-0.25em)
    align(center, text(weight: "semibold", 1.25em, type-of-degree))
  }

  v(1.5em)

  // course of studies
  align(
    center,
    text(
      1.2em,
      TITLEPAGE_SECTION_B.at(language) + authors.map(author => author.course-of-studies).dedup().join(" | "),
    ),
  )

  if (many-authors) {
    v(0.75em)
  } else {
    v(1em)
  }

  // university
  align(
    center,
    text(
      1.2em,
      TITLEPAGE_SECTION_C.at(language) + university-declined + [ ] + university-location,
    ),
  )

  if (many-authors) {
    v(0.8em)
  } else {
    v(3em)
  }

  align(center, text(1em, BY.at(language)))

  if (many-authors) {
    v(0.8em)
  } else {
    v(2em)
  }

  // authors
  grid(
    columns: 100%,
    gutter: if (many-authors) {
      14pt
    } else {
      18pt
    },
    ..authors.map(author => align(
      center,
      {
        text(weight: "medium", 1.25em, author.name)
      },
    ))
  )

  if (many-authors) {
    v(0.8em)
  } else {
    v(2em)
  }

  v(1fr)

  // author information
  grid(
    columns: (auto, auto),
    row-gutter: 11pt,
    column-gutter: 2.5em,

    // students
    text(weight: "semibold", TITLEPAGE_STUDENT_ID.at(language)),
    stack(
      dir: ttb,
      for author in authors {
        text([#author.student-id, #author.course])
        linebreak()
      }
    ),

    // company
    if (not at-university) {
      text(weight: "semibold", TITLEPAGE_COMPANY.at(language))
    },

    if (not at-university) {
      stack(
        dir: ttb,
        for author in authors {
          let company-address = ""

          // company name
          if (
            "name" in author.company and
            author.company.name != none and
            author.company.name != ""
            ) {
            company-address+= author.company.name
          } else {
            panic("Author '" + author.name + "' is missing a company name. Add the 'name' attribute to the company object.")
          }

          // company address (optional)
          if (
            "post-code" in author.company and
            author.company.post-code != none and
            author.company.post-code != ""
            ) {
            company-address+= text([, #author.company.post-code])
          }

          // company city
          if (
            "city" in author.company and
            author.company.city != none and
            author.company.city != ""
            ) {
            company-address+= text([, #author.company.city])
          } else {
            panic("Author '" + author.name + "' is missing the city of the company. Add the 'city' attribute to the company object.")
          }

          // company country (optional)
          if (
            "country" in author.company and
            author.company.country != none and
            author.company.country != ""
          ) {
            company-address+= text([, #author.company.country])
          }

          company-address
          linebreak()
        }
      )
    },

    // department 
    if (department != none) {
      text(weight: "semibold", TITLEPAGE_DEPARTMENT.at(language))
    },
    if (department != none) {
      text(department)
    },

    // HEAD_OF_STUDY_PROGRAM
    if (head_of_study_program != none) {
      text(weight: "semibold", TITLEPAGE_HEAD_OF_STUDY_PROGRAM.at(language))
    },
    if (head_of_study_program != none) {
      text(head_of_study_program)
    },

    // company supervisor
    if ("company" in supervisor) {
      text(weight: "semibold", TITLEPAGE_COMPANY_SUPERVISOR.at(language))
    },
    if ("company" in supervisor and type(supervisor.company) == str) {
      text(supervisor.company)
    },

    // university supervisor
    if ("university" in supervisor) {
      text(
        weight: "semibold",
        TITLEPAGE_SUPERVISOR.at(language) +
        if language == "en" {
          if university-short != none { university-short + [:] } else { [:] }
        } else { [] }
      )
    },
    if ("university" in supervisor and type(supervisor.university) == str) {
      text(supervisor.university)
    },

    // completion period
    if (completion_period != none) {
      text(weight: "semibold", TITLEPAGE_COMPLETION_PERIOD.at(language))
    },
    if (completion_period != none) {
      completion_period.at(0).display(completion_period_format) + [ \– ] + completion_period.at(1).display(completion_period_format)
    },

    // submission date
    if (completion_period != none) {
      text(weight: "semibold", TITLEPAGE_SUBMISSION_DATE.at(language))
    },
    if (completion_period != none) {
      submission_date.display(submission_date_format)
    },

  )
}