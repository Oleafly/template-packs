#let fonts = (
  song: ("Times New Roman", "SimSun"),
  hei: ("Times New Roman", "SimHei", "Microsoft YaHei"),
  kai: ("Times New Roman", "KaiTi"),
  fang: ("Times New Roman", "FangSong"),
)

#let sizes = (
  huge: 25pt,
  large: 17pt,
  normal: 12pt,
  small: 10.5pt,
)

#let date-format(date) = {
  if type(date) == datetime {
    str(date.year()) + "年" + str(date.month()) + "月" + str(date.day()) + "日"
  } else if type(date) == array {
    str(date.at(0)) + "年" + str(date.at(1)) + "月" + str(date.at(2)) + "日"
  } else {
    date
  }
}

#let field(label, value) = {
  grid(
    columns: (1.6cm, 9cm),
    gutter: 0.2cm,
    align: (left, center),
    text(font: fonts.kai, size: sizes.large, label),
    box(
      width: 9cm,
      inset: (bottom: 2pt),
      stroke: (bottom: 0.8pt + black),
      align(center, text(font: fonts.kai, size: sizes.large, value)),
    ),
  )
}

#let tbox(body) = align(center)[
  #box(
    width: 8cm,
    fill: luma(245),
    stroke: 0.5pt + black,
    radius: 1mm,
    inset: 9pt,
  )[#body]
]

#let shu-report(
  title: "XXXX课程报告",
  subtitle: "XXXXXX进展调研",
  author: "XXX",
  student-id: "在此填写学号",
  department: "上海大学理学院",
  header-title: "上海大学课程论文",
  date: datetime.today(),
  show-toc: true,
  body,
) = {
  set document(title: title, author: author)
  set text(font: fonts.song, size: sizes.normal, lang: "zh")
  set par(justify: true, leading: 0.78em, first-line-indent: (amount: 2em, all: true))

  // Cover page: follows the provided SHU LaTeX course report template.
  {
    set page(
      paper: "a4",
      margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
      numbering: none,
      header: none,
      footer: none,
    )

    align(center)[
      #image("assets/SHU_logo.pdf", width: 80%)
      #v(3cm)
      #text(font: fonts.hei, size: sizes.huge, weight: "bold", title)
      #v(1cm)
      #text(font: fonts.hei, size: sizes.large, underline(subtitle))
      #v(3cm)
      #field("姓名", author)
      #v(0.5cm)
      #field("学号", student-id)
      #v(0.5cm)
      #field("学院", department)
      #v(1.2cm)
      #text(font: fonts.song, size: sizes.normal, date-format(date))
    ]
  }

  pagebreak()
  counter(page).update(1)

  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    numbering: "1",
    header: align(center, text(font: fonts.fang, size: sizes.small, header-title)),
    footer: context align(center, text(size: sizes.small, counter(page).display("1"))),
  )

  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")
  show heading.where(level: 1): it => block(above: 1em, below: 0.65em)[
    #text(font: fonts.hei, size: 16pt, weight: "bold", it)
  ]
  show heading.where(level: 2): it => block(above: 0.85em, below: 0.5em)[
    #text(font: fonts.hei, size: 14pt, weight: "bold", it)
  ]
  show heading.where(level: 3): it => block(above: 0.65em, below: 0.4em)[
    #text(font: fonts.hei, size: 13pt, weight: "bold", it)
  ]
  show emph: set text(font: fonts.kai)
  show figure.caption: set text(size: sizes.small)
  show table.cell: set text(size: sizes.small)
  show link: set text(fill: rgb("#C000C0"))
  show ref: set text(fill: blue)

  if show-toc {
    outline(title: [目录], depth: 3)
    pagebreak()
  }

  body
}
