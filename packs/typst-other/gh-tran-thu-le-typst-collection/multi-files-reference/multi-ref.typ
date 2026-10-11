#let section-refs = state("section-refs", ())

#show ref: it => {
  it
  if it.element != none {
    return
  }
  section-refs.update(old => {
    old.push(it.target)
    old
  })
}

#show heading.where(level: 1): it => {
  section-refs.update(())
  it
}
