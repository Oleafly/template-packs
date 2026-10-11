#let section-title(
  title-string,
  line-stroke: 0.9pt,
  line-gap: -0.75em,
  top-gap: 1.0em,
  bottom-gap: 0.3em,
  text-size: 12pt,
) = {

        // Отступ сверху перед блоком
        v(top-gap)

        // Сам заголовок
        set text(size: text-size, weight: "bold")

        // Заголовок, как в примере
        title-string

        // Небольшой зазор перед линией
        v(line-gap)

        // Горизонтальная линия “на всю ширину”
        line(length: 100%, stroke: line-stroke)

        // Отступ снизу после блока
        v(bottom-gap)
}




#let alert(
  body,
  fill: red,
  radius: 4pt,
  pad-x: 6pt,
  pad-y: 2pt,
) = box(
  fill: fill,
  inset: (x: pad-x, y: pad-y),
  radius: radius,
)[
  #set text(fill: white, weight: "bold")
  body
]