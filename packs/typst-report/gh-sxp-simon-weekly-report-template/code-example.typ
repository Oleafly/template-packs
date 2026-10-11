// 最简单的代码示例函数 (Typst 0.13+)

// 在Typst中直接使用原生的代码块比较简单:
// ```python
// def hello():
//     print("Hello")
// ```

// 如果需要更多样式，可以使用:
#let styled-code(body, lang: "text") = {
  block(
    width: 100%,
    fill: rgb(250, 250, 250),
    radius: 3pt,
    stroke: (thickness: 0.7pt, paint: rgb(220, 220, 220)),
    inset: 10pt,
    raw(lang: lang)[#body]
  )
}