#let preface(
  twoside: false,
  ..args,
  it,
) = {
  if twoside {
    pagebreak() + " "
  }

  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "I")
  it
}
