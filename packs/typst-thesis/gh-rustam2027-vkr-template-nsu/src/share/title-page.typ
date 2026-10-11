// Renders the NSU thesis (ВКР) title page from `metadata.typ`.
//
// The wording and layout below reproduce the standard title page issued by
// Novosibirsk State University for bachelor's and master's theses. Faculties
// occasionally adjust a line or two (the ministry name, the approval block);
// if your department's official template differs, edit the strings here —
// the values themselves live in `metadata.typ`, not in this file.

#let title-page(meta) = {
  let year = if meta.year == auto {
    datetime.today().display("[year]")
  } else {
    str(meta.year)
  }

  set page(margin: (left: 30mm, right: 15mm, top: 20mm, bottom: 20mm))
  set text(size: 14pt)
  set par(justify: false, leading: 1em)
  set align(center)

  let defence-date = box[«…»……………20…#h(0.15em)г.]

  [МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ]
  linebreak()
  [ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ]
  linebreak()
  [«НОВОСИБИРСКИЙ НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ» (НОВОСИБИРСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ, НГУ)]

  v(1em)

  align(left)[
    #table(
      columns: 2,
      stroke: none,
      column-gutter: 1em,
      row-gutter: 0.4em,
      [Факультет], [#meta.faculty],
      [Кафедра], [#meta.department],
      [], [],
      [Направление подготовки], [#meta.programme],
    )
  ]

  v(1.2em)
  text(weight: "bold")[ВЫПУСКНАЯ КВАЛИФИКАЦИОННАЯ РАБОТА #meta.degree]
  v(1.2em)

  underline[#meta.author]
  linebreak()
  text(size: 10pt)[(Фамилия, Имя, Отчество автора)]

  v(1em)

  align(left)[Тема работы: #meta.title]

  v(1.5em)

  grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: left,
    [
      *«К защите допущена»* \
      #meta.approver.position.join(linebreak())

      #v(0.8em)
      #underline[#meta.approver.name] \
      #text(size: 9pt)[(фамилия, И., О.) / (подпись, МП)]

      #v(0.6em)
      #defence-date
    ],
    [
      *Научный руководитель* \
      #meta.supervisor.position.join(linebreak())

      #v(0.8em)
      #underline[#meta.supervisor.name] \
      #text(size: 9pt)[(фамилия, И., О.) / (подпись, МП)]

      #v(0.6em)
      #defence-date
    ],
  )

  v(1em)
  [Дата защиты: #defence-date]

  v(1fr)
  [#meta.city, #year]
}
