#let award-entry(
  name: "",
  date: "",
  from: "",
  details: "",
) = {
  grid(
    columns: (2fr, 2.5fr, 1fr),
    column-gutter: 1.15em,
    align: (left, left, right),
    [#strong[#name]],
    [#text[#from]#{ if details != "" [; #details] }],
    [#{ if type(date) == datetime [#date.display("[year]")] else [#date] }],
  )
}

#let award = award-entry
