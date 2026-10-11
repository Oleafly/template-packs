#import "@preview/theorion:0.4.1": *
#import "@preview/showybox:2.0.4": showybox
#import "common-utils.typ": *
#import "math-utils.typ": translation

// 这些文本格式函数要有 color 参数
#let default-thmprefix(t, color: rgb("#000000")) = {
  text(font: (en-font-sans, cn-font-sans), weight: 650, fill: color)[#t]
}
#let default-thmtitle(t, color: rgb("#000000")) = {
  text(font: (en-font-sans, cn-font-sans), weight: 350, fill: color)[#t]
}
#let default-thmtext(t, color: rgb("#000000")) = {
  let a = t.children
  if (a.at(0) == [ ]) {
    a.remove(0)
  }
  t = a.join()

  text(font: (en-font-serif, cn-font-serif), fill: color)[#t]
}

// 定义一些定理环境的样式
#let rect-box-style(
  prefix: auto,
  title: "",
  full-title: auto,
  fill: luma(500),
  thmtitle: default-thmtitle,
  thmtext: default-thmtext,
  thmprefix: default-thmprefix,
  body,
) = {
  let titlefmt = thmtitle.with(color: fill.darken(30%))
  let bodyfmt = thmtext.with(color: fill.darken(70%))
  let prefixfmt = thmprefix.with(color: fill.darken(30%))

  showybox(
    width: 100%,
    radius: 0.3em,
    breakable: false,
    padding: (top: 0em, bottom: 0em),
    frame: (
      body-color: fill.lighten(96%).transparentize(50%),
      border-color: fill.darken(10%),
      thickness: (left: 2pt),
      inset: 1.2em,
      radius: 0em,
    ),
    [
      #set par(first-line-indent: 2em)
      #block[
        #prefixfmt(prefix) #titlefmt(title)
      ]
      #bodyfmt(body)
    ],
  )
}

#let round-box-style(
  prefix: auto,
  title: "",
  full-title: auto,
  fill: luma(500),
  thmtitle: default-thmtitle,
  thmtext: default-thmtext,
  thmprefix: default-thmprefix,
  body,
) = {
  let titlefmt = thmtitle.with(color: white)
  let bodyfmt = thmtext
  let prefixfmt = thmprefix.with(color: white)

  showybox(
    title: [#prefixfmt(prefix) #titlefmt(title)],
    width: 100%,
    radius: 0.3em,
    breakable: false,
    frame: (
      title-color: fill,
      border-color: fill.darken(10%),
    ),
    shadow: (
      color: luma(220),
      offset: 3pt,
    ),
    [
      #set par(first-line-indent: 2em)
      #bodyfmt(body)
    ],
  )
}

#let line-box-style(
  prefix: auto,
  title: "",
  full-title: auto,
  fill: luma(500),
  thmtitle: default-thmtitle,
  thmtext: default-thmtext,
  thmprefix: default-thmprefix,
  body,
) = {
  let titlefmt = thmtitle.with(color: black)
  let bodyfmt = thmtext
  let prefixfmt = thmprefix.with(color: black)

  showybox(
    title: [#prefixfmt(prefix) #titlefmt(title)],
    width: 100%,
    breakable: false,
    frame: (
      title-color: none,
      border-color: fill.darken(10%),
      radius: 0em,
    ),
    [
      #set par(first-line-indent: 2em)
      #bodyfmt(body)
    ],
  )
}

#let plain-text-style(
  prefix: auto,
  title: "",
  full-title: auto,
  fill: luma(500),
  thmtitle: default-thmtitle,
  thmtext: default-thmtext,
  thmprefix: default-thmprefix,
  body,
) = {
  let titlefmt = thmtitle.with(color:fill)
  let bodyfmt = thmtext.with(color:black)
  let prefixfmt = thmprefix.with(color:fill)

  box({
    prefixfmt(prefix)
    if title != "" {
      titlefmt(title)
    }
    bodyfmt(body)
  })
}
)

// 组装定理环境
#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  theorion-i18n-map.at("theorem"),
  counter: theorem-counter, // inherit the old counter, `none` by default
  inherited-levels: 2, // useful when you need a new counter
  inherited-from: heading, // heading or just another counter
  render: plain-text-style.with(fill: colors.at("theorem")),
  // render: line-box-style.with(fill: colors.at("purple").lighten(60%)),
)

#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  theorion-i18n-map.at("definition"),
  inherited-levels: 2,
  inherited-from: heading,
  // render: rect-box-style.with(fill: colors.at("definition")),
  render: round-box-style.with(fill: colors.at("purple")),
)

#let (lemma-counter, lemma-box, lemma, show-lemma) = make-frame(
  "lemma",
  theorion-i18n-map.at("lemma"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("theorem")),
)

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("example")),
)

#let (remark-counter, remark-box, remark, show-remark) = make-frame(
  "remark",
  theorion-i18n-map.at("remark"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("remark")),
)

#let (property-counter, property-box, property, show-property) = make-frame(
  "property",
  theorion-i18n-map.at("property"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("theorem")),
)

#let (proposition-counter, proposition-box, proposition, show-proposition) = make-frame(
  "proposition",
  theorion-i18n-map.at("proposition"),
  inherited-levels: 2,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("theorem")),
)

#let (problem-counter, problem-box, problem, show-problem) = make-frame(
  "problem",
  theorion-i18n-map.at("problem"),
  inherited-levels: 1,
  inherited-from: heading,
  render: rect-box-style.with(fill: colors.at("problem")),
)

#let (corollary-counter, corollary-box, corollary, show-corollary) = make-frame(
  "corollary",
  theorion-i18n-map.at("corollary").zh.tw,
  counter: theorem-counter,
  render: rect-box-style.with(fill: colors.at("2")),
)

#let gemini = rect-box-style.with(
  fill: colors.at("1"),
  prefix: none,
  title: [#box(image("../pic/gemini.svg"), height: 1em, baseline: 0.1em) #text(weight: 650)[What Gemini says]],
)

#let proof(body, name: none, thmprefix: default-thmprefix, thmtitle: default-thmtitle) = context {
  thmprefix(translation.proof.at(text.lang))
  if name != none {
    [ #thmtitle[#name]]
  }
  thmprefix[.]
  body
  h(1fr)
  $qed$
}

#let solution(body, name: none, thmprefix: default-thmprefix, thmtitle: default-thmtitle) = context {
  thmprefix(translation.solution.at(text.lang))
  if name != none {
    [ #thmtitle[#name]]
  }
  thmprefix[.]
  body
  h(1fr)
  $hexa.filled$
}

#let show-thmenv(body) = {
  show: show-theorem
  show: show-lemma
  show: show-definition
  show: show-proposition
  show: show-property
  show: show-remark
  show: show-example
  show: show-problem
  show: show-corollary

  body
}
