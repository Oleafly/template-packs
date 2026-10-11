#import "@preview/zebraw:0.4.0": zebraw
#import "@preview/non-unlabeled:0.2.0": dont-number-unlabeled
#import "@preview/theorion:0.6.0": set-theorion-numbering, show-theorion, set-inherited-levels

// В project_data main.typ передает данные из yaml-файла
#let project(project_data, body) = {
  show: zebraw // Для красивого отображения листингов кода
  show: show-theorion // Для корректного отображения теорем/лемм/доказательств

  let theorem_numbering_style = if project_data.theorem_numbering_style == "continuous" {("1",0)} else {("1.", int(project_data.theorem_numbering_style))}

  set-theorion-numbering(theorem_numbering_style.at(0))
  set-inherited-levels(theorem_numbering_style.at(1))

  
  // Параметры документа.
  // Используются только в метаданных pdf-файла
  set document(
    title: project_data.title,
    author: project_data.author,
    date: auto,
  )

  //mc = magic_constant
  // Волшебная она в том смысле, что подобрана
  // на глаз, чтобы как можно лучше соответствовать
  // оформлению в LibreOffice
  // 
  // Typst по умолчанию трактует отступ в 2см
  // как расстояние от края до основного текста, 
  // а офисные пакеты — как до текста в колонтитуле (номера страницы) 
  // 
  // Этот дополнительный отступ с некоторым форматированием футера должны обеспечить визуальную сходство

  let mc = 1.39cm 
  
  let numbering_footer = [
    
    #block(
      height: 20mm + mc,
      width: 100%,
    )[
      #align(center + top, block(height: mc, [
        #align(bottom)[
          #context counter(page).display()]]))
    ]
  ]
  
  // Параметры страницы
  set page(
    margin: (
      left: 30mm,
      right: 15mm,
      top: 20mm,      
    ),
    paper: "a4",
  ) 

  set page(
    margin: (bottom: 20mm+mc),
    footer-descent: 0pt,
    footer: numbering_footer,
  ) if project_data.emulate_libre_office

  set page(
    margin: (bottom: 20mm),
    numbering: "1"
  ) if not project_data.emulate_libre_office
  
  // Параметры текста  
  set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "ru",
    top-edge: "baseline",
    bottom-edge: "bounds",
  )

  show table: set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "ru",
    top-edge: "bounds",
    bottom-edge: "bounds",
  )

  show table: set par(leading: 0.65em)

  // show enum: set block(inset: (left:1.25cm))

  set enum(indent: 1.25cm)
  show enum: it => {
    set enum(indent: 0pt)
    it
  }

  set list(indent: 1.25cm)
  show list: it => {
    set list(indent: 0pt)
    it
  }

  set footnote.entry(
    separator: block(width: 30%)[
      #line(length: 100%, stroke: 0.5pt)
      #v(12pt)
    ]
)

  show footnote.entry: set par(leading: 1.25em)

  show footnote.entry: it => {it; v(0.75em)}

  show raw.where(block:true): set text(
    size: 10pt,
    top-edge: "bounds",
    bottom-edge: "bounds",
  )

  show math.equation: set text(
    font: "New Computer Modern",
    features: (
      ss02: 1,
    ),
  )

  show raw.where(block: true): set block(below:0.75cm)

  let interlineage = if project_data.emulate_libre_office {1.53em} else {1.5em}
  
  // Параметры параграфв
  set par(
    leading: interlineage,
    first-line-indent: (
      all: true,
      amount: 1.25cm,
    ),
    justify: true,
    spacing: interlineage
  )
  
  // Параметры заголовков
  show heading: set block(
    below: 1.5em,
    above: 2em,
  )
  
  show heading: set text(
    size: 14pt,
  )
  
  show heading: it => { align(center)[#upper(it)] }
  
  set heading(
    numbering: "1.  1.", //hair
  )
  
  show heading.where(level: 1): set heading(numbering: none)
  show heading: set text(hyphenate: false)
  show <core_chapter>: set heading(numbering: "ГЛАВА 1.")
  
  show outline.entry: upper
  
  // По умолчанию используется сквозная нумерация формул
  set math.equation(numbering: "(1)")
  
  // Эта часть обеспечивает поддержку внутриглавной нумерации (1.1, 1.2, ...)
  // и переключается на нее, если в project_data.yml выбран именно данный способ
  
  // Создаем внутриглавный счетчик, который обнуляется в начале новой главы
  let eq_numbering_intrachapter = counter("eq")
  show heading.where(level: 1): it => {
    eq_numbering_intrachapter.update(0)
    it
  }
  
  // Используем этот счетчик для внутриглавной нумерации, если
  // project_data.numbering_style == "nested"
  set math.equation(
    numbering: it => {
      eq_numbering_intrachapter.step() // Сразу прибавляем к счетчику единицу (по умолчанию он начинается с нуля)
      context {
        let chapter_number = counter(heading).get().at(0) // Получаем номер текущей главы
        let eq_number = eq_numbering_intrachapter.get().at(0)
        numbering("(1.1)", chapter_number, eq_number) // Передаем номер главы и значение счетчика нумератору
      }
    },
    // Настройка применяется только при выполнении условия в строке ниже. 
    // Иначе — дефолтный режим со сквозной нумерацией
  ) if project_data.eq_numbering_style == "nested"
  
  // Отключает нумерацию для формул без тегов,
  // Если того требуют настройки в project_data.yml
  let numbering_style = {
    if project_data.eq_numbering_by_default { it => it } else { dont-number-unlabeled(math.equation) }
  }
  
  show math.equation: numbering_style
  
  //  Настройка корректного отображения таблиц:
  //    - Нумерация справа над таблицей
  //    - Название посередине над таблицей
  show figure.where(
    kind: table,
  ): it => {
    align(right)[#it.supplement #it.caption.counter.display()]
    v(-0.5em)
    align(center)[#it.caption.body]
    it.body
  }
  
  // Переопределение нескольких символов для лучшего соответствия
  // русскоязычной типографной традиции
  show sym.lt.eq: $lt.eq.slant$
  show sym.gt.eq: $gt.eq.slant$
  
  body
}