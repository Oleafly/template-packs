#import "/layout/fonts.typ": *

#let cover(
  title: "", degree: "", program: "", author: "", class: "", supervisor: "", date: datetime.today(),
) = {
  set page(
    margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm), numbering: none, number-align: center,
  )

  set text(font: fonts.body, size: 10pt, lang: "ru")

  set par(leading: 0.5em)

  // --- Cover ---
  v(5mm)
  align(
    center, text(
      font: fonts.sans, 1.3em, weight: 700, "Министерство образования и науки Российской Федерации Московский физико-технический институт (государственный университет)",
    ),
  )

  // TODO: replace with your info
  v(5mm)
  align(
    center, text(
      font: fonts.sans, 1.5em, weight: 100, "Физтех-школа радиотехники и компьютерных технологий\nКафедра Микропроцессорных технологий в интеллектуальных системах управления\nPlaceholderCorporation",
    ),
  )

  v(15mm)

  align(
    center, text(
      font: fonts.sans, 1.3em, weight: 100, "Выпускная квалификационная работа " + degree + "a",
    ),
  )
  v(15mm)

  align(center, text(font: fonts.sans, 2em, weight: 100, title))

  v(10mm)

  align(right + bottom, text(font: fonts.sans, 1.2em, weight: 700, "Автор:"))
  align(
    right + bottom, text(
      font: fonts.sans, 1.2em, weight: 500, "Студент " + class + " группы\n" + author,
    ),
  )
  v(10mm)
  align(
    right + bottom, text(font: fonts.sans, 1.2em, weight: 700, "Научный руководитель:"),
  )
  align(right + bottom, text(font: fonts.sans, 1.2em, weight: 500, supervisor))

  v(1cm)
  align(center + bottom, image("../figures/mipt_logo.jpg", width: 26%))
  align(
    center + bottom, text(
      font: fonts.sans, 1.2em, weight: 100, "Москва " + date.display("[year]"),
    ),
  )
}
