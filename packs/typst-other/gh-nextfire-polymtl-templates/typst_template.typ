#let template(
  subject: none,
  title: none,
  subtitle: none,
  authors: (
    (name: "Nam Vu", number: 2230468),
  ),
  date: datetime.today(),
  semester: none,
  lang: "fr",
  doc,
) = {
  set document(
    title: (subject, title, subtitle)
      .filter(it => it != none)
      .join(" – "),
    author: authors.map(author => author.name),
    date: date,
  )
  set page(paper: "us-letter")
  set text(lang: lang)

  set heading(numbering: "1.1")
  set par(justify: true)

  set outline(indent: auto)
  show outline.entry.where(level: 1): it => {
    v(1em, weak: true)
    strong(it)
  }

  show image: it => align(it, center)
  show link: it => {
    underline(stroke: (dash: "densely-dotted"), it)
  }

  {
    set text(16pt)
    set align(center)

    if lang == "fr" {
      image("Polytechnique_signature-RGB-gauche_FR.png", width: 2.5in)
    } else {
      image("Polytechnique_signature-RGB-gauche_ENG.png", width: 2.5in)
    }
    linebreak()

    if subject != none {
      strong(subject)
      linebreak()
      linebreak()
    }

    if title != none {
      strong(text(22pt, title))
      linebreak()
    }

    if subtitle != none {
      strong(text(14pt, subtitle))
    }

    grid(
      columns: (1fr,) * calc.min(authors.len(), 3),
      row-gutter: 24pt,
      ..authors.map(author => [#author.name (#author.number)]),
    )

    if lang == "fr" {
      let mois_arr = (
        "janvier",
        "février",
        "mars",
        "avril",
        "mai",
        "juin",
        "juillet",
        "août",
        "septembre",
        "octobre",
        "novembre",
        "décembre",
      )
      let mois = mois_arr.at(date.month() - 1)
      date.display("[day padding:none] " + mois + " [year]")
    } else {
      date.display("[month repr:long] [day padding:none], [year]")
    }
    linebreak()

    [Polytechnique Montréal]
    if semester != none [ – #semester]
  }
  linebreak()

  doc
}

#show: doc => template(
  subject: "Subject",
  title: "Title",
  subtitle: "Subtitle",
  semester: "Hiver 2024",
  doc,
)

#outline()

#set page(numbering: "1")

#heading(numbering: none)[Introduction]
#lorem(20)

= Section
#lorem(40)

== Subsection
#lorem(40)

#heading(numbering: none)[Conclusion]
#lorem(20)
