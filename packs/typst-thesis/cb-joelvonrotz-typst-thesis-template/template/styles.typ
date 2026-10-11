#let big-heading(it, numbering-format: "1", paint: red, size: 6em) = {
  v(1cm)
  block(
    width: 100%,
    inset: (y: size/4, left: 0.5em),
    stroke: (y: paint + 2pt),
    align(
      horizon,
      grid(
        columns: (auto,1fr),
        column-gutter: 1em,
        text(fill: paint, top-edge: "bounds", size,numbering(numbering-format,..counter(heading).at(here()))),
        text(calc.max(1em, size/2.5),it.body)
      )
    )
  )
  v(2cm)
  
}

#let underline-heading(it, inset: 0.5em, stroke: 0.75pt) = {
  block(inset: (bottom: inset), stroke: (bottom: stroke), width: 100%, if it.numbering != none {numbering(it.numbering, ..counter(heading).at(here())) + h(0.3em)} + it.body)
}

#let heading-frontmatter(it, paint: blue) = {
  if it.level == 1 {
    pagebreak()
    underline-heading(it)
  } else if it.level == 2 {
    underline-heading(it, stroke: (dash: "dashed", paint: gray.mix((paint, 60%)), thickness: 0.75pt), inset: 0.3em)
  } else {
    it
  }
}

#let heading-mainmatter(it, paint: blue) = {
  if it.level == 1 {
    pagebreak()
    
    counter(math.equation).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    
    big-heading(it, paint: paint)
  } else if it.level == 2 {
    underline-heading(it)
  } else if it.level == 3 {
    underline-heading(it, stroke: (dash: "dashed", paint: gray.mix((paint, 60%)), thickness: 0.75pt), inset: 0.3em)
  } else {
    it
  }
}


#let heading-backmatter(it, paint: blue) = {
  if it.level == 1 {
    underline-heading(it)
  } else if it.level == 2 {
    underline-heading(it, stroke: (dash: "dashed", paint: gray.mix((paint, 60%)), thickness: 0.75pt), inset: 0.3em)
  } else {
    it
  }
}


#let heading-appendix(it, paint: blue) = {
  if it.level == 1 {
    big-heading(it, numbering-format: "A", paint: paint)
  } else if it.level == 2 {
    underline-heading(it)
  } else if it.level == 3 {
    underline-heading(it, stroke: (dash: "dashed", paint: gray.mix((paint, 60%)), thickness: 0.75pt), inset: 0.3em)
  } else {
    it
  }
}