#import "gost_fonts.typ": gost-serif

#let gost-appendix-list(..apps) = {
  pagebreak(weak: true)

  // Заголовок перечня приложений (стиль Заголовок 1 уровня, как у СОДЕРЖАНИЯ)
  block(
    above: 0mm,
    below: 10mm,
    sticky: true,
    align(center, text(font: gost-serif, size: 18pt, weight: "bold", upper([Приложения]))),
  )

  // Форматирование списка приложений (Основной текст)
  set text(font: gost-serif, size: 14pt, weight: "regular")
  set par(first-line-indent: 0cm, leading: 1.5em)

  for app in apps.pos() {
    let (letter, title) = app
    link(label("appendix-" + upper(letter)))[Приложение #letter #title \ ]
  }
}

#let gost-appendix(letter, title, body) = {
  pagebreak(weak: true)

  [#metadata((letter: letter, title: title)) #label("appendix-" + upper(letter))]

  // Устанавливаем глобальное состояние, чтобы рисунки/таблицы/формулы знали, что они в приложении
  state("gost-app-letter", none).update(letter)

  // Сброс счетчиков
  counter(heading).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: "listing")).update(0)
  counter(math.equation).update(0)

  // Заголовок приложения (по центру, Приложение Х - bold, Название - regular, без отступов)
  align(center)[
    #set par(first-line-indent: 0cm, leading: 1.5em)
    #text(font: gost-serif, size: 14pt, weight: "bold")[Приложение #letter]\
    #text(font: gost-serif, size: 14pt, weight: "regular")[#title]
  ]

  // Содержимое приложения
  body

  // Сбрасываем состояние после приложения
  state("gost-app-letter", none).update(none)
}
