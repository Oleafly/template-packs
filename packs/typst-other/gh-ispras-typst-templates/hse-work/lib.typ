#let template(
  work-type: "Курсовая работа",
  author-name: none,
  title: none,
  specialty-number: "09.04.04",
  specialty-title: "Программная инженерия",
  programme-title: "Системное программирование",
  organization: [Федеральное государственное автономное образовательное
                 учреждение высшего профессионального образования "Национальный
                 исследовательский университет "Высшая школа экономики"],
  supervisor-name: none,
  supervisor-regalia: none,
  consultant-name: none,
  consultant-regalia: none,
  city: "Москва",
  year: datetime.today().year(),
  font-type: "Times New Roman",
  font-size: 14pt,
  body,
) = {
  assert(author-name != none, message: "Author is required")
  assert(title != none, message: "Title is required")
  assert(supervisor-name != none, message: "Supervisor name is required")

  set page(margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 1cm))

  set text(
    font: font-type,
    lang: "ru",
    size: font-size,
    fallback: true,
    hyphenate: false,
  )

  set par(
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 2.5em, all: true),
    leading: 1em,
  )

  set heading(numbering: "1.1")
  show heading: it => {
    set text(
      font: font-type,
      size: font-size
    )
    set block(above: 3em, below:3em)

    if it.level == 1 {
      pagebreak()
      counter(figure).update(0)
      counter(math.equation).update(0)
    } else {}

    it
  }

  show figure: align.with(center)
  show figure.where(kind:table): set figure.caption(position: top)
  show figure.where(kind:table): set figure(supplement: [Таблица])
  show figure.where(kind:table): set figure(numbering: num =>
    ((counter(heading.where(level:1)).get() + (num,)).map(str).join(".")),)
  show figure: set block(breakable: true)
  set figure(supplement: [Рисунок])
  set figure.caption(separator: [ --- ])

  set enum(indent: 2.5em)
  set ref(supplement: it => {
    if it.func() == figure {}
  })

  state("section").update("body")

  set align(center)
  v(5em)
  upper(organization)
  set text(size:16pt)
  v(0em)
  author-name
  v(0em)
  set text(weight:"bold")
  upper(title)
  set text(weight: "regular", size:font-size)
  v(1em)
  upper(work-type)
  v(0em)
  [по направлению подготовки #emph[#specialty-number] ]
  emph(specialty-title)
  v(0em)
  [образовательная программа "#programme-title"]
  v(0em)
  set align(right)
  "Научный руководитель:"
  v(0em)
  supervisor-regalia
  v(0em)
  supervisor-name
  v(0.5em)
  box(line(length: 4cm, stroke: 0.5pt))
  if (consultant-name != none) {
    v(0em)
    "Консультант:"
    if (consultant-regalia != none) {
        v(0em)
        consultant-regalia
    }
    v(0em)
    consultant-name
    v(0.5em)
    box(line(length: 4cm, stroke: 0.5pt))
  }
  v(5fr)
  set align(center)
  [#city #year]
  set align(left)

  set page(
    numbering: "1",
  )

  set text(
    font: font-type,
    lang: "ru",
    size: font-size,
    fallback: true,
    hyphenate: true,
  )

  outline(title: "Содержание", indent: 1.5em, depth: 3,)

  body
}
