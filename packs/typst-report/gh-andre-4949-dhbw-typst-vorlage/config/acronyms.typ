// Dictionary with acronyms
#let acronyms = (
  DHBW: "Duale Hochschule Baden-Württemberg",
  acronym2: "acronym2 full text",
)

// Tracking used acronyms
#let usedAcronyms = state("usedDic", (:))

#let acro(body) = {
  if(acronyms.keys().contains(body) == false) {
    return rect(
      fill: red,
      inset: 8pt,
      radius: 4pt,
      [*Warning: #body*],
    )
  }
  context {
    let usedDic = usedAcronyms.get()
    // This may throw off some vs code plugins but it works
    if(usedDic.keys().contains(body)) {
      link(label("acro-" + body))[#body]
    } else {
      usedAcronyms.update(usedDic => {
        usedDic.insert(body, true)
        return usedDic
      })
      link(label("acro-" + body))[#acronyms.at(body) (#body)]
    }
  }
}

// Simplified function to display the list of used acronyms
#let printAcronyms = {
  context {
    let used = usedAcronyms.final()
    for key in acronyms.keys().sorted() {
      if used.keys().contains(key) {
        grid(
          columns: (1fr, 3fr),
          gutter: 1em,
          [#strong(key) #label("acro-" + key)], acronyms.at(key)
        )
        linebreak()
      }
    }
  }
}
