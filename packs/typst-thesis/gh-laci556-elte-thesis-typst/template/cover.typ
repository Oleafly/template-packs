
#let make-cover(title, department, city, year, student, supervisor, ext-supervisor) = {
  set align(center)
  set page(numbering: none)
  set par(justify: false)

  stack(
    dir: ltr,
    image("../images/elte_cimer_szines.svg", width: 25%, height: auto),
    {
      {
        set text(size: 1.4em)

        smallcaps[Eötvös Loránd Tudományegyetem]
        v(0.3cm)
        smallcaps[Informatikai Kar]
        v(0.5cm)
      }
      box(text(size: 1.2em, smallcaps(department)))
    },
  )

  v(5cm)
  text(size: 1.7em)[*#title*]
  v(4cm)

  let author(role, name, affiliation, alignment: left) = {
    set align(alignment)

    stack(
      spacing: 1em,
      text(size: 1.2em, [_#role:_]),
      text(size: 1.2em, name),
      box(affiliation),
    )
  }

  let student-row = author(
    "Szerző",
    student.name,
    student.degree,
    alignment: if ext-supervisor != none { horizon } else { left },
  )

  if (ext-supervisor != none) { student-row }

  if ext-supervisor != none { v(2cm) } else { v(1cm) }

  stack(
    dir: ltr,
    spacing: 1fr,
    author(
      if (ext-supervisor != none) { "Belső témavezető" } else { "Témavezető" },
      supervisor.name,
      supervisor.affiliation,
    ),
    if ext-supervisor != none {
      author("Külső témavezető", ext-supervisor.name, ext-supervisor.affiliation)
    } else {
      student-row
    },
  )

  v(1fr)

  align(center, emph([#city, #year]))

  pagebreak()
}
