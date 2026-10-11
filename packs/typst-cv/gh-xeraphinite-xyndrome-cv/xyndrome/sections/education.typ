#let education-entry(
  institution: "",
  date: "",
  degree: "",
  details: "",
) = {
  grid(
    columns: (1fr, auto),
    column-gutter: 2em,
    align(left)[
      #strong[#degree], #institution
    ],
    align(right)[
      #{
        if type(date) == datetime [
          #date.display("[month repr:long] [year]")
        ] else [
          #date
        ]
      }
    ],
  )
  details
}

#let edu = education-entry
