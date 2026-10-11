#let hw(
  name: "utopiatopia",
  class: "CSE",
  hw_num: 1,
  date: datetime.today(),
  body
) = {
  set page(
    header: grid(
      columns: (1fr,1fr,1fr,1fr,1fr),
      align: center,
      name, class, [HW\##hw_num], date.display("[month]/[day]/[year]"), context [#counter(page).display("1") / #counter(page).final().at(0)]
    )
  )
  set rect(inset: .75em, radius: 100mm)

  set math.mat(delim: "[")
  show link: url => text(blue, underline(url))
  show figure.where(kind: "diagram"): set figure(supplement: [Diagram])

  body
}

#let problem(
  number: [],
  body
) = {
  box[
    #context [ #place(dx: -(measure(number).width+1em))[*#number*] ]
    #body
    #v(1em)
  ]
}

#let hline() = align(center, line(length: 25%, stroke: (dash: "dashed")))
