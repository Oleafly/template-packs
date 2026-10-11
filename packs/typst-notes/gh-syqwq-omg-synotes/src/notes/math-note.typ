#import "../utils/mod.typ": *
#import "cover.typ": *
#import "@preview/hydra:0.6.2": hydra, selectors

#let note(
  course: "course",
  author: "author",
  watermark: "ecnu",
  course-alt: "sub-course",
  footer-text: "生如夏花之绚烂，死如秋叶之静美",
  body,
) = {
  show: show-utils

  set page(
    numbering: "1",
    header: context {
      let abs-page = here().page()
      let current-page = counter(page).get().at(0)

      if abs-page <= 1 { return }

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == abs-page)

      if abs-page != 2 and has-heading { return }

      box(
        grid(
          columns: (1fr,) * 3,
          align: (horizon + left, horizon + center, horizon + right),
          box(height: 50%, image("../pic/ecnu-logo.svg")),
          box()[#context hydra(2, skip-starting: false)],
          box(text()[\- #current-page -]),
        ),
        inset: 4pt,
        stroke: (bottom: 0.5pt + luma(210)),
      )
    },
    footer: context {
      let abs-page = here().page()
      let current-page = counter(page).get().at(0)

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == abs-page)

      if not has-heading { return }
      if abs-page <= 1 { return }

      align(center)[\- #current-page -]
    },
    background: image("../pic/bg-ecnu-logo.svg"),
  )

  set page(background: rotate(-60deg, text(100pt, fill: rgb("#faf2f1"))[
    #strong()[#watermark]
  ])) if watermark != "ecnu"

  set heading(numbering: "1.")

  show heading.where(level: 1): t => context {
    if here().page() == 2 { return t }
    // if here().page() == query(<end>).first().location().page() { return t }
    if here().page() != counter(page).get().first() {
      return t;
    }

    let chp = context counter(heading).get().at(0)

    set text(size: 30pt, font: (en-font-serif, cn-font-serif))
    [Chapter #chp \ #t.body \ ]
  }

  show heading.where(level: 2): t => context {
    set par(first-line-indent: 0em)
    set text(size: 18pt)

    [#counter(heading).display("1.1") #t.body]
  }

  show heading.where(level: 3): t => context {
    set par(first-line-indent: 0em)
    set text(size: 14pt)

    [#counter(heading).display("1.1.1") #t.body]
  }

  svg-cover(author: author, course: course)
  // elegant-cover(author: author, course: course, course-alt: course-alt, footer-text: footer-text)

  pagebreak()

  outline(depth: 2)

  pagebreak()

  body
}

// #let proof = proof.with(
//   thmtitle: default-thmtitle.with(color: black),
//   thmprefix: default-thmprefix.with(color: black),
// )
