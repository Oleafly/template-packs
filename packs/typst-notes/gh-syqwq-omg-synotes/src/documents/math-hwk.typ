#import "../utils/mod.typ": *

#let doc(course: "course", hwk_id: 0, author: "author", stu_id: 1234567890, body) = {
  show:show-utils
  set text(font: (en-font-serif, cn-font-serif), weight: 300, size: 10pt)
  let title = course + " -- HW " + str(hwk_id) + " 解答"
  set document(title: title)

  set page(
    paper: "a4",
    numbering: "1",
    background: image("../pic/bg-ecnu-logo.svg"),
    header: context {
      if here().page() == 1 {
        return
      }
      box(outset: 4pt, stroke: (bottom: 0.5pt + luma(220)))[#text(font: (
          en-font-serif,
          cn-font-serif,
        ))[#title by #author] #h(1fr) #counter(page).display()]
    },
    footer: context {
      // 仅在第一页显示页脚页码
      if here().page() == 1 {
        align(center, {
          counter(page).display()
        })
      }
    },
  )

  align(center)[
    #block(text(weight: 500, 17pt, title))
    #v(1.5em, weak: true)
    #text(14pt)[#author #stu_id]
    #v(1.5em, weak: true)
    #text(14pt)[#datetime.today().display("[year].[month].[day]")]
    #v(2.0em, weak: true)
  ]

  body
}

#let problem-counter = counter("problem")
#let doc-thmprefix(t, color: luma(0)) = {
  underline(
    text(font: (en-font-sans, cn-font-sans), weight: 600)[#t],
    stroke: color + 2pt,
    offset: 1pt,
    evade: false,
  )
}

#let problem(body) = context {
  problem-counter.step()

  doc-thmprefix(color: red.transparentize(30%))[
    #context translation.problem.at(text.lang) #context problem-counter.display()
  ]
  body
}

#let proof = proof.with(thmprefix: doc-thmprefix.with(color: rgb("#614de4").transparentize(30%)))
#let solution = solution.with(thmprefix: doc-thmprefix.with(color: rgb("#614de4").transparentize(30%)))
