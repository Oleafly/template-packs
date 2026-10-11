#import "@preview/hydra:0.6.2": hydra, selectors
#import "@preview/zebraw:0.5.5": zebraw
#import "thmenv.typ": *
#import "utils.typ": *
#import emoji: drops, eyes


#let note(course: "", author: "syqwq", watermark: "logo", body) = {
  set text(
    font: (
      en-font-serif,
      cn-font-serif,
    ),
    weight: "light",
  )

  show "。": ". "
  show: show-thmenv
  show: zebraw

  set par(first-line-indent: 2em)
  set math.mat(delim: "[")
  set math.cases(gap: 0.5em)

  set page(
    numbering: "1",
    header: context {
      let current-page = here().page()

      if current-page <= 1 { return }

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

      if current-page != 2 and has-heading { return }

      box(
        grid(
          columns: (1fr,) * 3,
          align: (horizon + left, horizon + center, horizon + right),
          box(height: 50%, image("src/ecnu-logo.svg")),
          box()[#context hydra(2, skip-starting: false)],
          box(text()[\- #here().page() -]),
        ),
        inset: 4pt,
        stroke: (bottom: 0.5pt),
      )
    },
    footer: context {
      let current-page = here().page()

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

      if not has-heading { return }
      if current-page <= 1 { return }

      align(center)[\- #current-page -]
    },
    background: rotate(-40deg, image("src/syqwq-logo.svg", height: 10%)),
  )

  set page(background: rotate(-60deg, text(100pt, fill: rgb("#faf2f1"))[
    #strong()[#watermark]
  ])) if watermark != "logo"

  set heading(numbering: "1.")

  show heading.where(level: 1): t => context {
    if here().page() == 2 { return t }

    let chp = context counter(heading).get().at(0)

    set text(size: 30pt, font: (en-font-serif, cn-font-serif))
    [Chapter #chp \ #t.body \ ]
  }

  show heading.where(level: 2): t => context {
    counter(math.equation).update(0)
    set par(first-line-indent: 0em)
    set text(size: 18pt)

    [#counter(heading).display("1.1") #t.body]
  }

  show heading.where(level: 3): t => context {
    set par(first-line-indent: 0em)
    set text(size: 14pt)

    [#counter(heading).display("1.1.1") #t.body]
  }

  show math.equation: it => {
    if it.fields().keys().contains("label") {
      math.equation(
        block: true,
        numbering: n => {
          let count = counter(heading).get()
          let h1 = count.first()
          let h2 = count.at(1, default: 0)
          numbering("(1.1.1)", h1, h2, n)
        },
        it,
      )
    } else {
      it
    }
  }

  show ref: it => context {
    let el = it.element
    if el != none and el.func() == math.equation {
      let count = counter(heading).at(el.location())
      let h1 = count.first()
      let h2 = count.at(1, default: 0)
      let fmt = "Eq"
      if text.lang == "zh" { fmt = "式" }
      link(el.location(), numbering(
        fmt + " (1.1.1)",
        h1,
        h2,
        counter(math.equation).at(el.location()).at(0) + 1,
      ))
    } else {
      it
    }
  }

  let cover = {
    let fill-color = rgb("#D8CFC6")

    set page(footer: none, background: image("src/bg-6.svg", width: 101%, fit: "cover"))

    set text(fill: white)
    set par(first-line-indent: 0pt)


    place(
      image("src/ecnu-logo-white.svg", height: 30%),
      dy: -80pt,
    )

    v(5fr)
    [
      #align(left)[#underline(
        (underline(text(size: 45pt, weight: 800)[#course], offset: 7pt, stroke: red)),
        stroke: red,
        offset: 11pt,
      )]
      #align(left)[
        #text(size: 45pt, weight: 800)[笔记]
      ]
    ]
    v(1em)
    text(
      font: (en-font-sans, cn-font-sans),
      size: 16pt,
      weight: 800,
    )[#math.copyright #author \ East China Normal University]
    v(10fr)
  }

  cover

  pagebreak()

  outline(depth: 2)

  pagebreak()

  body
}
