#import "../lib/common.typ": hrule
#import "../template.typ": *

#let titlepage-font-size = 14pt
#set text(size: titlepage-font-size)
#set page(
  margin: (
    x: auto,
    y: auto,
  ),
)

#stack(
  dir: ltr,
  spacing: 1fr,
  if logo-left != none {
    set image(height: 2cm)
    logo-left
  },
  if logo-right != none {
    set image(height: 1.7cm)
    logo-right
  },
)

#v(4em)

#hrule
#v(0.5em)
#align(
  center,
  box(
    width: 100%,
    par(justify: false, linebreaks: "optimized", text(
      weight: "semibold",
      font: heading-font,
      size: 18pt,
      hyphenate: false,
    )[
      #title
    ]),
  ),
)
#v(0.5em)
#hrule

#v(2em)

// #for author in authors [
//   #align(center, text(weight: "semibold", author))
// ]

//#v(1em)

#align(
  center,
  if kind == "Bachelor" {
    par(leading: 0.8em)[
      #text(weight: "semibold")[Bachelor-Thesis] \
      #text(
        size: 12pt,
      )[zur Erlangung des akademischen Grades Bachelor of Science (B.Sc.)] \
      \
      #text(size: 14pt)[
        #university \
        #course-name \
      ]
    ]
  } else if kind == "Master" {
    par(leading: 0.8em)[
      #text(weight: "semibold", size: 19pt)[Master-Thesis] \
      \
      #text(
        size: 12pt,
      )[zur Erlangung des akademischen Grades Master of Science (M.Sc.)] \
      \
      #text(size: 14pt)[
        #university \
        #course-name \
      ]
    ]
  } else if kind == "PA1" {
    par(leading: 0.8em)[
      #text(weight: "semibold", size: 19pt)[Projektarbeit I] \
      \
      #text(size: 14pt)[
        #university \
        #course-name \
      ]
    ]
  } else {
    par(leading: 0.8em)[
      #text(weight: "semibold", size: 19pt)[Projektarbeit II] \
      \
      #text(size: 14pt)[
        #university \
        #course-name \
      ]
    ]
  },
)

#v(1em)

#align(
  center,
  block[
    #table(
      stroke: none,
      columns: (auto, auto),
      inset: 5.5pt,
      align: start,
      table.header(
        text(weight: "semibold", size: 12pt, font: heading-font)[Verfasser:],
        text(weight: "regular", size: 12pt, font: heading-font)[#authors.join(
          ", ",
        )],

        text(
          weight: "semibold",
          size: 12pt,
          font: heading-font,
        )[Matrikelnummer:],
        text(weight: "regular", size: 12pt, font: heading-font)[#matriculation-numbers.join(
          ", ",
        )],

        text(weight: "semibold", size: 12pt, font: heading-font)[Unternehmen:],
        text(weight: "regular", size: 12pt, font: heading-font)[#company],

        text(weight: "semibold", size: 12pt, font: heading-font)[Abteilung:],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#company-department],

        text(weight: "semibold", size: 12pt, font: heading-font)[Kurs:],
        text(weight: "regular", size: 12pt, font: heading-font)[#course-name],

        text(
          weight: "semibold",
          size: 12pt,
          font: heading-font,
        )[Studiengangsleiter:],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#program-director],

        text(
          weight: "semibold",
          size: 12pt,
          font: heading-font,
        )[Wissenschaftlicher Betreuer:],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#scientific-advisor],

        [],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#scientific-advisor-email],

        [],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#scientific-advisor-phone],

        text(
          weight: "semibold",
          size: 12pt,
          font: heading-font,
        )[Unternehmensbetreuer:],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#company-supervisor],

        [],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#company-supervisor-mail],

        [],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#company-supervisor-phone],

        text(
          weight: "semibold",
          size: 12pt,
          font: heading-font,
        )[Bearbeitungszeitraum:],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#timeframe],

        text(
          weight: "semibold",
          size: 12pt,
          font: heading-font,
        )[Abgabedatum:],
        text(
          weight: "regular",
          size: 12pt,
          font: heading-font,
        )[#submission-date],
      ),
    )],
)

#v(2em)

#pagebreak(weak: true)
