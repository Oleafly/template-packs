#import "../utils/style.typ": format-date, thesis-style, unimelb-logo

#let title-page(
  ctx,
  title: none,
  subtitle: none,
  author: none,
  degree: none,
  department: none,
  school: none,
  university: none,
  supervisor: none,
  co_supervisor: none,
  submission_date: none,
  blind: false,
) = {
  let style = ctx.style
  let labels = ctx.labels
  let show-logo = ctx.at("show_logo", default: true)
  align(center)[
    #text(size: 24pt, weight: "bold", fill: style.colors.primary)[
      #labels.university_name
    ]
    #v(1em)
    #if show-logo {
      unimelb-logo()
      v(2em)
    } else {
      v(2em)
    }
  ]

  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #if subtitle != none {
      v(0.5em)
      text(size: 14pt, style: "italic")[#subtitle]
    }
    #v(2em)
  ]

  align(center)[
    #text(size: 14pt)[#labels.thesis_submission_line]
    #v(0.5em)
    #text(size: 14pt)[#labels.thesis_degree_line #degree]
    #v(1em)
    #text(size: 14pt)[#labels.thesis_department_line #department]
    #v(0.5em)
    #text(size: 14pt)[#school]
    #v(1em)
    #text(size: 14pt)[#university]
    #v(2em)
  ]

  align(center)[
    #text(size: 16pt)[
      #if blind {
        [Author]
      } else {
        [#author]
      }
    ]
    #v(2em)
  ]

  align(center)[
    #text(size: 12pt)[#labels.supervisor_label: #supervisor]
    #if co_supervisor != none {
      v(0.5em)
      text(size: 12pt)[#labels.co_supervisor_label: #co_supervisor]
    }
    #v(1em)
    #text(
      size: 12pt,
    )[#labels.submission_date_label: #format-date(submission_date)]
  ]

  pagebreak()
}
