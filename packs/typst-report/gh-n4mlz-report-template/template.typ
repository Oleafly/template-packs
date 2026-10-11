#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space
#import "@preview/codly:1.3.0": codly-init

#let textXXL = 15pt
#let textXL = 12pt
#let textL = 11pt
#let textM = 10pt
#let textS = 9pt
#let textXS = 8pt

#let fontSerif = ("Noto Serif", "Noto Serif CJK JP")
#let fontSan = ("Noto Sans", "Noto Sans CJK JP")

#let project(
  subject: "科目名",
  title: "課題名",
  student-id: "学籍番号",
  department: "学類名",
  author: "氏名",
  date: datetime.today(),
  body,
) = {
  set document(
    title: title,
    author: author,
    date: date,
  )

  show: remove-cjk-break-space
  show: codly-init.with()

  set page(numbering: "1")
  set text(
    font: fontSerif,
    fallback: true,
    lang: "ja",
  )

  align(center)[
    #set align(center)

    #text(textXL)[#subject]

    #v(0.1em)
    #text(textXXL, weight: "bold")[#title]

    #v(0.2em)
    #text(textM)[#student-id #department]
    #text(textM)[#author]

    #v(0.2em)
    #text(textM)[#date.display("[year]年[month]月[day]日")]
  ]
  v(5em)

  set heading(numbering: "1.1.1")

  show heading: set text(font: fontSan)

  show heading.where(level: 1): it => pad(
    top: 0.8em,
    bottom: 0.7em,
    text(size: textL, it),
  )
  show heading.where(level: 2): it => pad(
    top: 0.7em,
    bottom: 0.6em,
    text(size: textM, it),
  )
  show heading.where(level: 3): it => pad(
    top: 0.6em,
    bottom: 0.5em,
    text(size: textS, it),
  )

  set text(
    font: ("Source Code Pro", ..fontSerif),
    size: textXS,
    fallback: true,
    lang: "ja",
  )

  body
}
