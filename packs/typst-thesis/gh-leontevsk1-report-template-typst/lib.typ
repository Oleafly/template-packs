// Шаблон отчёта по ГОСТ Р 7.0.11-2011 для кафедры ВТиЭ АлтГУ.
// Портирован с altsu-report.cls (LaTeX).

#let indent-length = 1.25cm

// Нумерация заголовков вида "1.", "1.1.", "1.1.1."
#let gost-heading-numbering(..nums) = {
  nums.pos().map(str).join(".") + "."
}

// Нумерация рисунков/таблиц/листингов вида "<номер главы>.<номер элемента>"
#let gost-figure-numbering(n) = {
  let ch = counter(heading).get().first()
  str(ch) + "." + str(n)
}

// Оформление листингов кода (ГОСТ-стиль: рамка, номера строк, аналог minted/frame=lines).
#let code-listing(raw-elem) = {
  set text(font: "DejaVu Sans Mono", size: 8pt)
  set par(leading: 0.55em, spacing: 0.55em)
  block(
    width: 100%,
    stroke: 0.5pt,
    inset: (x: 6pt, y: 5pt),
    breakable: true,
    grid(
      columns: (1.3em, 1fr),
      column-gutter: 0.5em,
      row-gutter: 0.4em,
      align: left,
      ..raw-elem.lines.map(line => (
        align(right, text(fill: gray)[#line.number]),
        line.body,
      )).flatten()
    ),
  )
}

// Титульный лист.
#let make-title(
  ministry: "",
  country: "",
  fulluniversityname: "",
  institute: "",
  department: "",
  shortdepartment: "",
  worktype: "",
  title: "",
  author: "",
  groupnumber: "",
  supervisor: "",
  supervisordegree: "",
  date: "",
  ..sink,
) = {
  set page(numbering: none)
  set align(center)

  [#ministry~#country]
  v(0.5cm)
  upper(fulluniversityname)
  v(0.5cm)
  institute
  v(0.5cm)
  [#department~(#shortdepartment)]
  v(2cm)
  worktype
  v(0.5cm)
  upper(title)
  v(1cm)

  v(1fr)

  grid(
    columns: (1fr, 1fr),
    column-gutter: 1cm,
    align: (left, left),
    [], [
      #set align(left)
      Выполнил студент #groupnumber~группы: \
      #box(width: 2.5cm, line(length: 100%)) #author \
      «#box(width: 1cm, line(length: 100%))» #box(width: 3cm, line(length: 100%)) #datetime.today().year() г. \
      Проверил: #supervisordegree \
      #box(width: 2.5cm, line(length: 100%)) #supervisor \
      «#box(width: 1cm, line(length: 100%))» #box(width: 3cm, line(length: 100%)) #datetime.today().year() г.
    ]
  )

  v(1fr)

  [Барнаул~#date]

  pagebreak()
}

// Страница реферата.
#let make-abstract(
  count-work-page: "",
  count-work-img: "",
  count-work-lit: "",
  count-work-tab: "",
  keys-ru: "",
  abstract-ru: "",
  ..sink,
) = {
  align(center)[РЕФЕРАТ]
  v(1em)

  grid(
    columns: (1fr, auto),
    [Объем работы листов], [#count-work-page],
  )
  v(0.5em)
  grid(
    columns: (1fr, auto),
    [Количество рисунков], [#count-work-img],
  )
  v(0.5em)
  grid(
    columns: (1fr, auto),
    [Количество используемых источников], [#count-work-lit],
  )
  v(0.5em)
  grid(
    columns: (1fr, auto),
    [Количество таблиц], [#count-work-tab],
  )
  v(1em)

  upper(keys-ru) + [.]
  parbreak()

  abstract-ru
  parbreak()

  [Отчёт оформлен с помощью системы компьютерной вёрстки #smallcaps[Typst].]

  pagebreak()
}

#let report(
  ministry: "",
  country: "",
  fulluniversityname: "",
  institute: "",
  department: "",
  shortdepartment: "",
  worktype: "",
  title: "",
  author: "",
  groupnumber: "",
  supervisor: "",
  supervisordegree: "",
  date: "",
  keys-ru: "",
  abstract-ru: "",
  count-work-page: "",
  count-work-img: "",
  count-work-lit: "",
  count-work-tab: "",
  body,
) = {
  set document(title: title, author: author)

  set text(
    font: "Times New Roman",
    lang: "ru",
    size: 14pt,
  )

  set page(
    paper: "a4",
    margin: (left: 3cm, right: 1.5cm, top: 2cm, bottom: 2cm),
    numbering: "1",
    number-align: top + right,
    header: none,
  )

  set par(
    justify: true,
    leading: 1.15em,
    first-line-indent: (amount: indent-length, all: true),
    spacing: 1.15em,
  )

  set list(indent: 0pt, body-indent: 0.5em, marker: [--])
  set enum(indent: 0pt, body-indent: 0.5em, numbering: gost-heading-numbering, full: true)

  set heading(numbering: gost-heading-numbering)

  // Сброс нумерации рисунков/таблиц/листингов в начале каждой главы.
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: "listing")).update(0)
    it
  }

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set align(center)
    set text(size: 14pt, weight: "regular")
    v(0pt)
    block(above: 0pt, below: 15pt)[
      #if it.numbering != none [#counter(heading).display() ]
      #upper(it.body)
    ]
  }

  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "regular")
    block(above: 1.5em, below: 1.5em, width: 100%)[
      #h(indent-length)#if it.numbering != none [#counter(heading).display() ]#it.body
    ]
  }

  show heading.where(level: 3): it => {
    set text(size: 14pt, weight: "regular")
    block(above: 1.2em, below: 1.2em, width: 100%)[
      #h(indent-length)#if it.numbering != none [#counter(heading).display() ]#it.body
    ]
  }

  // Подписи: таблица — сверху справа, рисунок/листинг — снизу по центру.
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: "listing"): set figure.caption(position: bottom)
  show figure.where(kind: "listing"): it => {
    set block(breakable: true)
    show raw.where(block: true): code-listing
    it
  }

  show figure.caption: it => {
    if it.kind == table {
      align(right)[#it.supplement~#it.counter.display(it.numbering)#it.separator#it.body]
    } else {
      align(center)[#it.supplement~#it.counter.display(it.numbering)#it.separator#it.body]
    }
  }

  set figure(numbering: gost-figure-numbering)
  set figure.caption(separator: [ -- ])

  set table(stroke: 0.5pt)

  body
}
