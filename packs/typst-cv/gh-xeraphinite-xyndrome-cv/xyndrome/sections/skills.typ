#let text-size-override = state("text-size-override", none)

#let skills-grid(
  categories: (),
) = {
  context {
    let active-size = text-size-override.get()
    for category in categories {
      grid(
        columns: (1fr, 4fr),
        column-gutter: 1.25em,
        align(left)[#text(size: if active-size == none { 1em } else { active-size })[*#category.at(0)*]],
        align(left)[#text(size: if active-size == none { 1em } else { active-size })[#category.at(1).join(",  ")]],
      )
    }
  }
}

#let skills = skills-grid
