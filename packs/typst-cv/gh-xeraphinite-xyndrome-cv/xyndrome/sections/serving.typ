#let serving-entry(
  name: "",
  description: "",
  date: "",
) = {
  grid(
    columns: (auto, 1fr),
    align(left)[
      #strong[#name]
      #{
        if description != "" [
          ,#text(size: 0.9em, [#description])
        ]
      }
    ],
    align(right)[
      #text(size: 0.9em, [#date])
    ],
  )
}

#let serving = serving-entry
