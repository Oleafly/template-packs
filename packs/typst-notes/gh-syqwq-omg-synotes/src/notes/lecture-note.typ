#import "../utils/mod.typ": *

// #let en-font-serif = "Libertinus Serif"

#let lecture-thmprefix(t, color: black) = {
  text(font: en-font-serif, weight: 650, fill: color)[#t]
}

#let lecture-thmtitle(t, color: black) = {
  text(font: en-font-serif, weight: 450, fill: color)[ (#t)]
}

#let lecture-thmtext(t, color: black) = {
  let a = t.children
  if (a.at(0) == [ ]) {
    a.remove(0)
  }
  t = a.join()

  text(font: (en-font-serif, cn-kaiti), fill: color, emph(t))
}

#let lecture-render-fn = plain-text-style.with(
  fill: black,
  thmprefix: lecture-thmprefix,
  thmtext: lecture-thmtext,
  thmtitle: lecture-thmtitle,
)


// 组装定理环境
#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  theorion-i18n-map.at("theorem"),
  counter: theorem-counter, // inherit the old counter, `none` by default
  inherited-levels: 2, // useful when you need a new counter
  inherited-from: heading, // heading or just another counter
  render: lecture-render-fn,
)

#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  theorion-i18n-map.at("definition"),
  inherited-levels: 2,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (lemma-counter, lemma-box, lemma, show-lemma) = make-frame(
  "lemma",
  theorion-i18n-map.at("lemma"),
  inherited-levels: 2,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  inherited-levels: 2,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (remark-counter, remark-box, remark, show-remark) = make-frame(
  "remark",
  theorion-i18n-map.at("remark"),
  inherited-levels: 2,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (property-counter, property-box, property, show-property) = make-frame(
  "property",
  theorion-i18n-map.at("property"),
  inherited-levels: 2,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (proposition-counter, proposition-box, proposition, show-proposition) = make-frame(
  "proposition",
  theorion-i18n-map.at("proposition"),
  inherited-levels: 2,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (problem-counter, problem-box, problem, show-problem) = make-frame(
  "problem",
  theorion-i18n-map.at("problem"),
  inherited-levels: 1,
  inherited-from: heading,
  render: lecture-render-fn,
)

#let (corollary-counter, corollary-box, corollary, show-corollary) = make-frame(
  "corollary",
  theorion-i18n-map.at("corollary").zh.tw,
  counter: theorem-counter,
  render: lecture-render-fn,
)

#let gemini = rect-box-style.with(
  fill: colors.at("1"),
  prefix: none,
  title: [#box(image("../pic/gemini.svg"), height: 1em, baseline: 0.1em) #text(weight: 650)[What Gemini says]],
)

#let show-tthmenv(body) = {
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

#let note(course: "course", author: "author", other: [Autumn #datetime.today().year() -- Professor], body) = {
  show: show-utils
  // set text(font: "Libertinus Serif")

  set page(
    numbering: "1",
    header: context {
      if here().page() == 1 { return }
      box(
        stroke: (bottom: 0.5pt + luma(200)),
        inset: 5pt,
        course + h(1fr) + smallcaps("Lecture Notes") + h(1fr) + smallcaps(author),
      )
    },
  )
  set heading(numbering: "1.1.1")

  set figure(numbering: it => numbering("1.1", counter(heading).get().first(), counter(figure).get().first()))

  show heading.where(level: 1): it => {
    counter(figure).update(0)
    it.body
  }

  set par(first-line-indent: 0em)

  // show outline.entry.where(level: 1): strong
  // show outline.entry.where(level:1):set outline.entry(fill:none)
  show outline.entry.where(level: 1): it => block[
    #show: strong
    #box(link(
      it.element.location(),
      it.indented(it.prefix(), it.element.supplement),
    ))
    #h(1fr)
    #it.element.location().page()
  ]

  align(center)[
    #set text(size: 18pt)
    #course Lecture Notes \
    #set text(size: 13pt)
    #author \
    #other
  ]

  outline()

  pagebreak()

  body
}

#let lecture(date: datetime.today(), topic: "topic") = {
  v(1em)
  figure(
    outlined: false,
    numbering: none,
    heading(
      supplement: topic,
      level: 1,
      outlined: true,
      box(
        width: 100%,
        height: 40pt,
        stroke: 0.5pt + black,
        inset: 1pt,
      )[
        #set align(center + horizon)
        #set text(size: 14pt)
        #strong[Lecture #context counter(heading).get().first()] \
        #set text(size: 12pt, weight: "regular")
        #emph(topic)

        #place(
          top + left,
          dx: 5pt,
          dy: -5pt,
          box(
            fill: white,
            outset: 2pt,
          )[
            #set text(size: 11pt, weight: "regular")
            #date.display("[month repr:short].[day] [year]")
          ],
        )
      ],
    ),
  )
}
