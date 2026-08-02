#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1 / 1", number-align: end)
  set text(
    font: (
        "Inria Serif",
        "Source Han Serif SC"
    ),
    weight: "medium",
    lang: "zh"
  )

  set par(justify: true, first-line-indent: 2em)

  set heading(numbering: "1 ")
  show heading: it => {
    set text(font: "Inria Serif")
    if it.level == 1 [
      #v(1em)
      #align(center)[
        #strong(counter(heading).display())
        #strong(it.body)
        #v(1em, weak: true)
      ]
    ] else [
      #set par(first-line-indent: 0em)
      #strong(it.body)
    ]
  }

  show emph: it => {
      set text(font: "AR PL UKai")
      it.body
  }

  show strong: it => {
      set text(font: "Source Han Sans SC", weight: "medium")
      it.body
  }

  set list(indent: 2em)
  set enum(indent: 2em)

  // Title row.
  align(center)[
    #block(text(font: "Source Han Serif SC", weight: "bold", 2em, title))
    #v(1.5em, weak: true)
    #text(weight: "semibold", date)
  ]

  // Author information.
  pad(
    bottom: 0.25em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, author)),
    ),
  )

  // Main body.
  body
}

// 处理首行缩进消失的零高假段落
#let fake-para = {
  $ $
  v(-1.65em)
}

#let angled(..x) = $lr(angle.l #x.pos().join(",") angle.r)$
#let QED = align(right, rect(width: 0.75em, height: 0.75em, stroke: {0.5pt + black}))
#let rank = $op("rank")$
#let argmin = math.op("argmin", limits: true)
#let argmax = math.op("argmax", limits: true)
#let varnothing = move(scale(x: -100%)[$nothing.rev$], dy: -0.12em)
