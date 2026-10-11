// 前言
#let preface(
  twoside: false,
  ..args,
  it,
) = {
  pagebreak(weak: true, to: if twoside { "odd" })
  counter(page).update(1)
  set page(numbering: "I", number-align: center)

  it
}
