// Plotting library
#import "@preview/cetz:0.5.2"
// Colourful boxes
#import "@preview/showybox:2.0.4": showybox


#let preamble(doc) = {
  set page(
    paper: "a4",
    margin: (x: 2cm, left: 3cm, right: 1.5cm),
  )
  set text(
    font: "Times New Roman",
    lang: "ru",
    size: 14pt,
  )
  set par(
    justify: true,
    leading: 1em,
    first-line-indent: (amount: 1.25em, all: true),
  )
  // Доп. отступ под заголовками
  // LaTeX-like и это есть в шаблоне
  show heading: set block(below: 0.9em)

  //  Жирные заголовки H1 - LaTeX-like содержание
  show outline.entry.where(level: 1): it => strong(it)

  // Особенности шаблона
  // 12pt шрифт в подписях рисунков
  show figure.where(kind: image): it => text(size: 12pt)[#it]

  // "Рис." -> "Рисунок"
  show figure.where(kind: image): set figure(supplement: "Рисунок")

  // Формат подписи рисунков
  show figure.caption: it => [
    _ #it.supplement _
    _ #context it.counter.display(it.numbering) _
    ---
    _ #it.body _
    #v(1em)  // Требование шаблона №8
  ]

  // Подсветка ссылок
  show link: set text(blue)
  show link: it => underline(it)

  // Центрирование "Оглавления"
  show outline: it => align(center)[#it]

  doc
}

// Операторы в math-окружении
#let sign = math.op("sign")
#let sigmoid = math.op("sigmoid")
#let argmax = math.op("argmax", limits: true)
