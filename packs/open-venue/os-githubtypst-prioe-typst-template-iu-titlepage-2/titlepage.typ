#let iu-titlepage(
  title: none,
  author: none,
  student-id: none,
  program: "Informatik (B.Sc.)",
  course: "IWSM01",
  tutor: "TBD",
  doc-type: "Hausarbeit",
  date: datetime.today(),
  logo: none,
) = {
  set page(numbering: none)

  if logo != none {
    place(top + right, {
      set image(width: 4.5cm)
      logo
    })
  }

  v(3.6cm)

  align(center + horizon, {
    // \huge\bf
    text(size: 21pt, weight: "bold")[#title]

    v(1.3cm)

    doc-type

    v(1cm)

    // \large\bf
    text(size: 12pt, weight: "bold")[#author (#student-id)]

    v(0.95cm)

    [
      #program \
      #course \
      #date.display("[day]. [month repr:long]. [year]")
    ]

    v(3cm)

    [Tutor:in:#h(1cm) #tutor]
  })
}
