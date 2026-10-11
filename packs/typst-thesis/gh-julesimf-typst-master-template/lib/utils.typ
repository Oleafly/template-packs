/// Вспомогательные функции публичного API шаблона МФТИ.

// Буквы для нумерации приложений по ГОСТ 2.105
// (исключены: Ё, З, Й, О, Ч, Ъ, Ы, Ь)
#let _appendix-letters = (
  "А","Б","В","Г","Д","Е","Ж","И","К","Л","М","Н",
  "П","Р","С","Т","У","Ф","Х","Ц","Ш","Щ","Э","Ю","Я"
)

/// Создаёт ненумерованный заголовок первого уровня, включённый в оглавление.
///
/// Используется для разделов без порядкового номера: «Список сокращений»,
/// «Введение» (если ненумерованное), «Заключение» и т.п.
/// Раздел отображается в оглавлении, но не получает числового номера.
///
/// Пример:
/// ```typst
/// #unnumbered[Список сокращений]
///
/// ОСРВ — Операционная система реального времени...
/// ```
///
/// - title (content): Текст заголовка раздела
/// -> content
#let unnumbered(title) = heading(numbering: none, level: 1, title)


/// Создаёт страницу аннотации (реферата) на русском и английском языках.
///
/// Аннотация *не* попадает в оглавление — в отличие от `unnumbered`.
/// После аннотации автоматически вставляется разрыв страницы.
///
/// Ожидаемое оформление:
/// - Заголовок «Аннотация» жирным по центру
/// - Название работы обычным шрифтом по центру
/// - ФИО автора курсивом по центру
/// - Текст аннотации на русском
/// - `vfill` (англ. раздел смещается к нижней половине страницы)
/// - «Abstract» жирным по центру
/// - Название на английском обычным по центру
/// - ФИО на английском курсивом по центру
/// - Текст аннотации на английском
///
/// Пример:
/// ```typst
/// #annotation(
///   title-ru: "Программная реализация...",
///   author-ru: "Иванов Иван Иванович",
///   body-ru: [
///     Стандарт ARINC 653 определяет...
///   ],
///   title-en: "Software implementation...",
///   author-en: "Ivan Ivanovich Ivanov",
///   body-en: [
///     The ARINC 653 standard defines...
///   ],
/// )
/// ```
///
/// - title-ru (str): Название работы на русском языке
/// - author-ru (str): ФИО автора на русском
/// - body-ru (content): Текст аннотации на русском
/// - title-en (str, none): Название работы на английском. `none` — не показывать.
/// - author-en (str, none): ФИО автора на английском. `none` — не показывать.
/// - body-en (content): Текст аннотации на английском
/// -> content
#let annotation(
  title-ru: "",
  author-ru: "",
  body-ru: [],
  title-en: none,
  author-en: none,
  body-en: [],
) = {
  set par(first-line-indent: 0pt)

  // ── Русский раздел ────────────────────────────────────────────────────
  align(center)[
    *Аннотация* \
    #v(0.3em)
    #text(size: 12pt, title-ru) \
    #v(0.1em)
    #text(style: "italic", author-ru)
  ]

  v(1cm)
  set par(first-line-indent: 1.25cm)
  body-ru

  // ── Английский раздел ─────────────────────────────────────────────────
  if title-en != none {
    v(1fr)
    set par(first-line-indent: 0pt)
    align(center)[
      *Abstract* \
      #v(0.3em)
      #text(size: 12pt, title-en) \
      #v(0.1em)
      #text(style: "italic", author-en)
    ]

    v(1cm)
    set par(first-line-indent: 1.25cm)
    body-en
  }

  pagebreak()
}


/// Оформляет блок приложений с буквенной нумерацией по ГОСТ 2.105.
///
/// Сбрасывает счётчик заголовков и переключает нумерацию на буквенную
/// (Приложение А, Приложение Б, … — исключая Ё, З, Й, О, Ч, Ъ, Ы, Ь).
/// Подразделы нумеруются А.1, А.2, А.1.1 и т.д.
///
/// Пример:
/// ```typst
/// #appendix[
///
///   = Пример конфигурации
///
///   ```xml
///   <Config>...</Config>
///   ```
///
///   = Таблица результатов
///
///   ...
/// ]
/// ```
///
/// - body (content): Содержимое приложений
/// -> content
#let appendix(body) = {
  counter(heading).update(0)

  // Заголовки внутри приложений не попадают в оглавление
  set heading(outlined: false)

  show heading.where(level: 1): it => context {
    let idx = counter(heading).at(it.location()).first()
    let letter = _appendix-letters.at(idx - 1, default: str(idx))
    if idx > 1 { pagebreak(weak: true) }
    block(
      above: 1.8em, below: 0.8em, width: 100%,
      par(first-line-indent: 0pt, justify: false,
        text(size: 14pt, weight: "bold",
          "Приложение " + letter + h(0.75em) + it.body
        )
      )
    )
  }

  show heading.where(level: 2): it => context {
    let nums = counter(heading).at(it.location())
    let letter = _appendix-letters.at(nums.first() - 1, default: str(nums.first()))
    let sub = if nums.len() > 1 { "." + nums.slice(1).map(str).join(".") } else { "" }
    block(
      above: 1.2em, below: 0.6em, width: 100%,
      par(first-line-indent: 0pt, justify: false,
        text(size: 12pt, weight: "bold", letter + sub + h(0.75em) + it.body)
      )
    )
  }

  body
}
