#let __listing_impl(caption: str, body) = context {
  let listing-counter = counter("listing")
  listing-counter.step()
  let listing-part-counter = counter("listing-part" + str(listing-counter.get().first()))

  show <listing-header>: header => {
    listing-part-counter.step()
    context {
      if listing-part-counter.get().first() == 1 {
        table.cell(emph[Листинг #listing-counter.display() --- #caption])
      } else {
        table.cell(emph[Продолжение листинга #listing-counter.display()])
      }
    }
  }

  block(
    inset: (left: -13mm),
    outset: (left: 13mm),
    width: 100%,
  )[
    #table(
      columns: 1fr,
      align: start,
      stroke: none,
      inset: (left: 0pt),
      table.header[header <listing-header>],
      table.cell(
        inset: (left: 3mm),
        stroke: black,
      )[#par(hanging-indent: 0mm, leading: 4pt, justify: false)[#body]],
    )
  ]
}

#let listing(caption: str, body: none, file: none, from: none, to: none) = {
  if body == none {
    body = read("../" + file)
    let lines = body.split("\n")

    if from == none {
      from = 1
    }
    if to == none {
      to = lines.len()
    }

    lines = lines.slice(from - 1, to)
    body = raw(lines.join("\n"))
  }

  figure(
    kind: "listing",
    supplement: "Листинг",
    caption: caption,
    __listing_impl(caption: caption, body),
  )
}

#show figure.where(kind: "listing"): figure => {
  figure.body
}


#let __table_impl(caption: str, columns: (), head: (), ..body) = context {
  let column-amount = 1

  if type(columns) == array {
    column-amount = columns.len()
  }

  let table-counter = counter("table")
  table-counter.step()
  let table-part-counter = counter("table-part" + str(table-counter.get().first()))

  show <table-header>: header => {
    table-part-counter.step()
    context {
      let header-text = [Таблица #table-counter.display() --- #caption]

      if table-part-counter.get().first() != 1 {
        header-text = [Продолжение таблицы #table-counter.display()]
      }
      header-text
    }
  }

  set align(left)
  block(
    inset: (left: -13mm),
    outset: (left: 13mm),
    width: 100%,
  )[
    #table(
      columns: columns,
      align: start,
      stroke: black,
      inset: 5pt,
      table.header(
        table.cell(
          inset: (left: 0mm),
          stroke: none,
          colspan: column-amount,
        )[header <table-header>],
        ..head,
      ),
      ..body,
    )
  ]
}

#let picture(path: str, caption: content, width: 100%) = {
  figure(
    kind: "picture",
    caption: caption,
    supplement: "Рисунок",

    align(
      center,
      block(width: 100%)[
        #image("../" + path, width: width)
      ],
    ),
  )
}

#let mytable(caption: [], columns: auto, head: (), ..body) = {
  if columns == auto and head != none {
    columns = head.len()
  }

  if type(columns) == int {
    columns = range(0, columns).map(i => 1fr)
  }

  figure(
    kind: "table",
    supplement: "Таблица",
    caption: caption,
  )[#__table_impl(caption: caption, columns: columns, head: head, ..body)]
}

#let project(
  title: "",
  theme: "",
  department: str,
  course: str,
  authors: (),
  group: str,
  date: datetime.today(),
  logo: none,
  add_toc: false,
  lecturer: str,
  body,
) = {
  let completion_text = "Выполнил студент группы"

  if authors.len() > 1 {
    completion_text = "Выполнили студенты группы"
  }

  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(
    margin: (left: 25mm, right: 15mm, top: 20mm, bottom: 20mm),
    number-align: center,
  )


  set text(font: "Times New Roman", lang: "ru")

  set heading(numbering: "1.1")
  set par(leading: 0.75em)


  set align(center)
  set par(spacing: 2mm)

  image("./logo.png", width: 20mm)

  [
    #upper("Минобрнауки России\n")
    Федеральное государственное бюджетное образовательное учреждение

    высшего образования

    *"МИРЭА -- Российский технологический университет"*

    #text(size: 1.2em, [*РТУ МИРЭА*])
  ]

  line(length: 100%, stroke: (paint: black, thickness: 2pt))

  set text(14pt)
  [
    Институт информационных технологий
    #v(6mm)
    Кафедра #lower(department)
    #v(20mm)
    #text(16pt, [*#upper(title)*])

    по дисциплине "#course"

    #v(5mm)
    #if theme != "" {
      [Тема: "#theme"]
    }

    #v(40mm)
    #set text(12pt)
    #set align(start)

    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 10mm,
      completion_text,
      group,
      authors.map(a => a).join("\n"),
      grid.cell(colspan: 2, [Принял преподаватель]),
      [#lecturer]
    )

    #v(20mm)

    #grid(
      columns: (1fr, 1fr, 1fr),
      rows: 20mm,
      [Работа выполнена],
      [#quote(underline("    ")) #underline("               ") 20#underline("    ")],
      align(center, text(baseline: 5mm, size: 10pt)[_(Подпись студента)_]),

      [Зачтено],
      [#quote(underline("    ")) #underline("               ") 20#underline("    ")],
      align(center, text(baseline: 5mm, size: 10pt)[_(Подпись преподавателя)_]),
    )
  ]

  v(13mm)
  align(center)[Москва #date.year()]
  pagebreak()


  // Main body.

  set text(size: 14pt)
  set align(start)

  set text(hyphenate: false)

  set heading(numbering: "1.")
  show heading.where(level: 1): it => text(size: 18pt, it)
  show heading.where(level: 2): it => text(size: 16pt, it)
  show heading.where(level: 3): it => text(14pt, it)
  show heading.where(level: 4): it => text(14pt, it)
  show heading.where(level: 5): it => text(14pt, it)
  show heading.where(level: 6): it => text(14pt, it)

  show figure: set block(breakable: true)
  set figure.caption(separator: [ --- ])

  show figure.where(kind: "table"): figure => {
    figure.body
  }

  show figure.where(kind: "listing"): figure => {
    figure.body
  }

  show figure.where(kind: "picture"): it => {
    block(
      inset: (left: -13mm),
      outset: (left: 13mm),
      breakable: false,
    )[
      #align(start)[
        #it.body
      ]
      #text(size: 12pt, it.caption)
    ]
  }

  if add_toc {
    set align(center)
    outline(depth: 3, indent: 0em)
    pagebreak()
  }

  set page(numbering: "1")

  // first-line-indent не работает для первого параграфа,
  // поэтому здесь этот костыль
  set page(margin: (left: 39mm))
  set par(
    justify: true,
    spacing: 16pt,
    leading: 5mm,
    hanging-indent: -13mm,
  )

  body
}
