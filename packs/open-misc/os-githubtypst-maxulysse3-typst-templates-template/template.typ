#let conf(
  title: none,
  authors: (),
  doc
) = {
  set page(
    paper: "us-letter",
    numbering: "1 / 1",
  )
  set text(lang: "fr")

  align(center, text(17pt)[
    *#title*
  ])
  set align(center)
  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors
  )

  set align(left)

  v(5em)

  doc
}

#let res(val) = {
  set align(center)
  box(stroke: black, inset: 1em, [
    #val
  ])
}

#let tend(under) = $
  -->_#under
$

#let question_count = counter("quescounter")
#let exos_count = counter("exocounter")


#let exercice(title: []) = {
  exos_count.step()
  context {
  [
    #set align(center)
    #line(length: 100%, stroke: black + 2pt)
    #set text(weight: "bold", size: 14pt)
    #question_count.update(1)
    Exercice #exos_count.display(): #title
    #line(length: 100%, stroke: stroke(paint: black, thickness: 1pt, dash: "densely-dashed"))
    #v(1em)
  ]
  }
}

#let question() = {
  context {
  [
    #set align(left)
    #set text(style: "italic", size: 12pt)
    
    #question_count.step()
    #v(1em)
    #h(2em)Question #exos_count.display().#question_count.display()
  ]
  }
}

#let lim = math.limits(math.lim)

#let integ = math.limits(math.integral)

#let code(lang, val) = {
  box(inset: 1em, radius: 4pt, stroke: 1pt + black, fill: silver, width: 100%)[
    #raw(val, lang: lang)
  ]
}

#let vec(x) = text(weight: "bold", x)
#let EE(x) = [$times 10^(#x)$]
