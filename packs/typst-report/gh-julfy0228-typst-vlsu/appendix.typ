// Логика для приложений

// Русский алфавит для нумерации приложений (без Ё, З, Й, О, Ч, Ъ, Ы, Ь)
#let _appendix-alphabet = (
  "А", "Б", "В", "Г", "Д", "Е", "Ж",
  "И", "К", "Л", "М", "Н", "П", "Р",
  "С", "Т", "У", "Ф", "Х", "Ц", "Ш",
  "Щ", "Э", "Ю", "Я",
)

// Получить букву приложения по номеру
#let _get-appendix-letter(num) = {
  if num > 0 and num <= _appendix-alphabet.len() {
    _appendix-alphabet.at(num - 1)
  } else {
    str(num)
  }
}

// Нумерация заголовков в приложениях: А, А.1, А.1.1, ...
#let _appendix-heading-numbering(..nums) = {
  let n = nums.pos()
  let letter = _get-appendix-letter(n.first())
  let rest = n.slice(1).map(x => str(x))
  if rest.len() > 0 {
    (letter, ..rest).join(".")
  } else {
    letter
  }
}

// Нумерация элементов (рисунков, таблиц, формул) в приложениях: А.1, А.2, ...
#let _get-appendix-element-numbering(current-heading-numbering, element-numbering) = {
  if current-heading-numbering.first() <= 0 or element-numbering <= 0 {
    return
  }
  let letter = _get-appendix-letter(current-heading-numbering.first())
  (letter, numbering("1", element-numbering)).join(".")
}

// Заголовок приложения с указанием статуса (обязательное/справочное)
#let appendix-heading(status, level: 1, body) = {
  heading(level: level)[(#status)\ #body]
}

// Функция-обёртка для раздела приложений
#let appendixes(content) = {
  set heading(numbering: _appendix-heading-numbering)

  show heading.where(level: 1): set heading(hanging-indent: 0pt)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): it => context {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    pagebreak(weak: true)
    block[#upper([приложение]) #numbering(
        it.numbering,
        ..counter(heading).at(it.location()),
      ) \ #text(weight: "medium")[#it.body]]
  }

  set figure(numbering: it => {
    let current-heading = counter(heading).get()
    _get-appendix-element-numbering(current-heading, it)
  })

  set math.equation(numbering: it => {
    let current-heading = counter(heading).get()
    [(#_get-appendix-element-numbering(current-heading, it))]
  })

  state("appendixes").update(true)
  counter(heading).update(0)
  content
}
