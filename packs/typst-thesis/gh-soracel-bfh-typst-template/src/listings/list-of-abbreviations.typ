
#let ListOfAbbreviations(
  list: none
) = {
  [= Abkürzungsverzeichnis]
  terms(tight: true)

  let abbreviationsList = ()
  for (abbreviation, meaning) in list {
    abbreviationsList.push((abbreviation, meaning))
  }

  // Sort by abbreviation case-insensitive
  for (element) in abbreviationsList.sorted(key: it => lower(it.first())) {
    [/ #element.first(): #element.at(1)]
  }

  pagebreak()
}
