// BTEC baholash va deklaratsiya sahifasi (SRP, DIP: faqat parametrlarga bog'liq)

#let table-stroke = 0.5pt + black
#let header-fill = gray.lighten(80%)

#let assessment-declaration(
  student-id: "",
  assessor: "",
  unit: "",
  assignment: "",
  submitted: "",
  signature: "",
  date: "",
  task-rows: 6,
) = {
  pagebreak()
  counter(page).update(1)

  [
    #set par(first-line-indent: 0pt, justify: false)

    #align(center)[
      #text(weight: "bold", size: 14pt)[
        BTEC O'QUVCHILAR TOPSHIRIQLARINI BAHOLASH VA DEKLARATSIYA
      ]
    ]

    #v(0.6em)

    Baholash uchun ishlarni taqdim etganda, har bir o'quvchi ish o'ziniki ekanligini tasdiqlovchi deklaratsiyani imzolashi kerak.

    #v(1em)

    #table(
      columns: (1.1fr, 1fr),
      stroke: table-stroke,
      inset: 6pt,
      [*O'quvchi (talaba) identifikatori:*], [#student-id],
      [*Baholovchi nomi:*], [#assessor],
      [*Birlik yoki komponent raqami va nomi:*], [#unit],
      [*Topshiriq nomi:*], [#assignment],
      [*Topshiriq topshirilgan sana:*], [#submitted yil],
    )

    #v(1em)

    Iltimos, har bir topshiriq uchun berilgan ishlarni sanab o'ting. Ishlarni topish mumkin bo'lgan sahifa raqamlarini ko'rsating yoki ishlarning mohiyatini tavsiflang (masalan, grafik, rasm).

    #v(0.8em)

    #{
      let header = (
        table.cell(fill: header-fill)[*Topshiriq vazifasi ma'lumoti*],
        table.cell(fill: header-fill)[*Ishlar taqdim etildi*],
        table.cell(fill: header-fill)[*Sahifa*],
      )
      let empty-rows = ()
      for _ in range(task-rows) {
        empty-rows = empty-rows + ([], [], [])
      }
      table(
        columns: (2fr, 1fr, 0.7fr),
        stroke: table-stroke,
        inset: 6pt,
        align: (left, center, center),
        ..header,
        ..empty-rows,
      )
    }


    #rect(
      width: 100%,
      stroke: table-stroke,
      inset: (x: 14pt, y: 12pt),
    )[
      #set align(center)
      #set par(justify: false)

      #text(weight: "bold")[O'quvchi deklaratsiyasi]

      #v(0.6em)

      Men ushbu topshiriq uchun taqdim etilgan ish meniki ekanligini tasdiqlayman. Ishda foydalanilgan manbalarga aniq havola qildim. Men noto'g'ri deklaratsiya noto'g'ri ishlashning bir shakli ekanligini tushunaman.

      #v(1.2em)

      #align(left)[
        #grid(
          columns: (auto, auto, 1fr, auto, auto),
          column-gutter: 10pt,
          align: horizon,
          text(weight: "bold")[O'quvchi imzosi:],
          if signature != "" {
            box(baseline: 45%, image(signature, width: 3.2cm))
          } else {
            box(baseline: 45%, line(length: 4cm, stroke: 0.5pt))
          },
          [],
          text(weight: "bold")[Sana:],
          [#date yil],
        )
      ]
    ]
  ]
}
