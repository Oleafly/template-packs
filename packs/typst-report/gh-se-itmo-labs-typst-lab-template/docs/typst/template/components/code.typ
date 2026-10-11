#import "../theme.typ": default-theme

// Небольшой фрагмент кода внутри обычной строки.
#let inline-code(source, theme: default-theme) = box(
  fill: rgb("f2f3f5"),
  stroke: 0.5pt + rgb("d5d8dc"),
  radius: 2pt,
  inset: (x: 3pt, y: 1pt),
)[
  #text(font: theme.mono-fonts, size: theme.inline-code-size)[
    #raw(source)
  ]
]

// Многострочный листинг. lang отвечает за подсветку синтаксиса, filename и
// title — за заголовок, line-numbers включает ручную нумерацию строк.
#let code-block(
  source,
  lang: "text",
  title: none,
  filename: none,
  line-numbers: false,
  theme: default-theme,
) = {
  // Имя файла имеет приоритет над произвольным заголовком.
  let heading = if filename != none { filename } else { title }
  let code = raw(source, block: true, lang: lang)

  block(
    width: 100%,
    fill: rgb("f7f8fa"),
    stroke: 0.6pt + rgb("c8ccd0"),
    radius: 3pt,
    inset: 8pt,
    breakable: true,
  )[
    #set text(font: theme.mono-fonts, size: theme.code-size)
    #set par(first-line-indent: 0pt, justify: false, leading: 0.95em)

    #if heading != none [
      #text(font: theme.body-font, size: 10pt, weight: "bold")[#heading]
      #v(5pt)
    ]

    // Для нумерации каждая строка превращается в сетку: номер + код.
    #if line-numbers {
      let lines = source.split("\n")
      let numbered = ()
      for (index, line) in lines.enumerate() {
        numbered.push([
          #grid(
            columns: (2.2em, 1fr),
            column-gutter: 0.8em,
            align: (right, left),
            text(fill: rgb("777777"))[#(index + 1)],
            raw(if line == "" { " " } else { line }, lang: lang),
          )
        ])
      }
      stack(dir: ttb, spacing: 1.5pt, ..numbered)
    } else {
      code
    }
  ]
}
