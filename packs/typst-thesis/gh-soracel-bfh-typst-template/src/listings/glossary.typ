#let terms = ().sorted(key: it => lower(it.first())) // Case-insensitive sort

#let Glossary(
  list: none
) = {
  [= Glossar <glossar>]

  let glossaryList = ()
  for (term, explanation) in list {
    glossaryList.push((term, explanation))
  }

  v(0.5cm)
  table(
    columns: (1fr, 3fr),
    ..for (term, explanation) in glossaryList.sorted(key: it => lower(it.first())) {
      (term, explanation)
    }
  )

  pagebreak()
}

