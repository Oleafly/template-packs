#import "../utils/mod.typ": *
#import "cover.typ": *
#import "@preview/hydra:0.6.2": hydra, selectors
#import "@preview/catppuccin:1.0.1": flavors


#let cat-palette = flavors.latte.colors
#let cat-color=(
  theorem: cat-palette.teal.rgb,
  definition: cat-palette.subtext1.rgb,
  lemma:cat-palette.subtext1.rgb,
  corollary:cat-palette.subtext1.rgb,
  remark:cat-palette.teal.rgb,
  example:cat-palette.sapphire.rgb,
  proposition:cat-palette.teal.rgb,
  property:cat-palette.teal.rgb,
  problem:cat-palette.red.rgb,
)

#let cat-thmprefix(t, color: rgb("#000000")) = {
  text(font: (en-font-sans, cn-font-sans), weight: 650, fill: color)[【#t】]
}

#let cat-thmtitle(t, color: rgb("#000000")) = {
  text(font: (en-font-sans, cn-font-sans), weight: 450, fill: color)[(#t)]
}
#let cat-thmtext(t, color: rgb("#000000")) = {
  let a = t.children
  if (a.at(0) == [ ]) {
    a.remove(0)
  }
  t = a.join()

  text(font: (en-font-serif, cn-kaiti), fill: color)[#t]
}

#let cat-render-fn(fill: rgb("#000000")) = plain-text-style.with(
  fill: fill,
  thmprefix: cat-thmprefix,
  thmtitle: cat-thmtitle,
  thmtext: cat-thmtext,
)


// 组装定理环境
#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  theorion-i18n-map.at("theorem"),
  counter: theorem-counter, // inherit the old counter, `none` by default
  inherited-levels: 2, // useful when you need a new counter
  inherited-from: heading, // heading or just another counter
  render: cat-render-fn(fill:cat-color.theorem)
)

#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  theorion-i18n-map.at("definition"),
  inherited-levels: 2,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.definition),
)

#let (lemma-counter, lemma-box, lemma, show-lemma) = make-frame(
  "lemma",
  theorion-i18n-map.at("lemma"),
  inherited-levels: 2,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.lemma),
)

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  inherited-levels: 2,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.example),
)

#let (remark-counter, remark-box, remark, show-remark) = make-frame(
  "remark",
  theorion-i18n-map.at("remark"),
  inherited-levels: 2,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.remark),
)

#let (property-counter, property-box, property, show-property) = make-frame(
  "property",
  theorion-i18n-map.at("property"),
  inherited-levels: 2,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.property),
)

#let (proposition-counter, proposition-box, proposition, show-proposition) = make-frame(
  "proposition",
  theorion-i18n-map.at("proposition"),
  inherited-levels: 2,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.proposition),
)

#let (problem-counter, problem-box, problem, show-problem) = make-frame(
  "problem",
  theorion-i18n-map.at("problem"),
  inherited-levels: 1,
  inherited-from: heading,
  render: cat-render-fn(fill:cat-color.problem),
)

#let (corollary-counter, corollary-box, corollary, show-corollary) = make-frame(
  "corollary",
  theorion-i18n-map.at("corollary").zh.tw,
  counter: theorem-counter,
  render: cat-render-fn(fill:cat-color.corollary),
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


#let note(
  course: "course",
  author: "author",
  watermark: "ecnu",
  course-alt: "sub-course",
  footer-text: "生如夏花之绚烂，死如秋叶之静美",
  mail: 123456789,
  body,
) = {
  show: show-utils
  show: show-tthmenv

  set heading(numbering: "1.1.1")
  set page(header: context {
    let abs-page = here().page()
    let current-page = counter(page).get().at(0)

    if abs-page <= 1 { return }

    let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == abs-page)

    if abs-page != 2 and has-heading { return }

    box(
      width: 100%,
      stroke: (bottom: 0.5pt + cat-palette.surface1.rgb),
      inset: 4pt,
    )[
      #set text(
        font: (en-font-serif, cn-kaiti),
        fill: cat-palette.sapphire.rgb,
      )
      #align(center, context hydra(2, skip-starting: false))
    ]
  },
  footer:context{
      let abs-page = here().page()
      let current-page = counter(page).get().at(0)

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == abs-page)

      if has-heading { return }
      if abs-page <= 1 { return }

      align(center,text(fill: cat-palette.sapphire.rgb,[#current-page]))
  })

  show heading.where(level: 1): t => context {
    if here().page() == 2 { return t }
    box(
      height: 15%,
      width: 100%,
      align(right + bottom)[
        #set text(
          fill: cat-palette.subtext0.rgb,
          size: 25pt,
          weight: "bold",
        )
        Chapter #counter(heading).get().first()
      ],
    )
    box(
      width: 100%,
      height: 2.5em,
      stroke: (
        bottom: 2pt + cat-palette.subtext0.rgb,
        top: 2pt + cat-palette.subtext0.rgb,
      ),
    )[
      #set text(
        font: (en-font-sans, cn-font-sans),
        fill: cat-palette.subtext0.rgb,
        size: 14pt,
        weight: "medium",
      )
      #align(left + horizon, t.body)
    ]
  }

  show heading.where(level: 2): t => context {
    align(
      center,
      stack(
        dir: btt,
        spacing: -0.5em,
        rect(width: 100%, fill: white, stroke: cat-palette.surface1.rgb, inset: 1em)[
          #set text(
            font: (en-font-serif, cn-kaiti),
            fill: cat-palette.overlay2.rgb,
          )
          #t.body
        ],
        rect(fill: white, stroke: none, outset: 0pt)[
          #set text(
            font: (en-font-serif, cn-kaiti),
            fill: cat-palette.overlay2.rgb,
          )
          #math.section #counter(heading).display("1.1")
        ],
      ),
    )
    v(1em)
  }

  show heading.where(level: 3): t => context {
    set text(
      font: (en-font-sans, cn-font-sans),
      fill: cat-palette.overlay1.rgb,
      size: 13pt,
    )
    counter(heading).display()
    set text(weight: "medium")
    t.body
  }


  elegant-cover(
    author: author,
    course: course,
    course-alt: course-alt,
    mail: mail,
    cover-pic: "../pic/dragonfly.png",
    cover-rec-color: cat-palette.surface1.rgb,
  )

  outline(depth: 2)

  pagebreak()

  body
}
