#let qcv_size_col_left = 20%
#let qcv_space_between_cols = 1%
#let qcv_color = blue
#let qcv_gray = rgb("#888888")
#let qcv_size_section_title = 20pt
#let qcv_size_entry_title = 15pt
#let qcv_size_entry_details = 12pt
#let qcv_size_years = 8pt

#let qcv(body) = {
  set page(
    fill: white,
    margin: 3em,
    header: none,
    footer: none,
  )
  show heading: it => [
    #set align(left)
    #box(rect(width: qcv_size_col_left, height: 7pt, fill: qcv_color)) #text(it.body, fill: qcv_color, size: qcv_size_section_title)
  ]
  body
}

#let header(
  name,
  email: none,
  webpage: none,
  orcid: none,
) = {
  grid(
    columns: (1.8fr, 1fr),
    align(center + horizon, text(40pt)[
      #name
    ]),
    align(right, text(12pt, fill: qcv_gray)[
      #box(image("./orcid.logo.icon.svg", width:6%)): #link("https://orcid.org/" + orcid)[#orcid]

      #link(webpage)

      #link("mailto:" + email)
    ])
  )
}


#let raw_entry(
  min_year,
  max_year,
  year_start,
  year_end,
  title: none,
  details: none
) = {
  let year_size = 100% * (year_end - year_start) / (max_year - min_year)
  let start_percentage =  100% * ((year_start - min_year) / (max_year - min_year))
  let years_text = if year_start == year_end or year_end == max_year {
    text(qcv_size_years)[#year_start]
  } else {
    text(qcv_size_years)[#year_start - #year_end]
  }

  let rect_or_circle = if year_start == year_end {
    circle(radius: 2pt, fill: qcv_color)
  } else if year_end == max_year {
    rect(width: year_size, height: 4pt, fill: gradient.linear(qcv_color, white))
  } else {
    rect(width: year_size, height: 4pt, fill: qcv_color)
  }

  let align_top_of_rect(body) = context {
    let size = measure(body)
    move(dx: start_percentage + (year_size - size.width) / 2 + if year_start == year_end { 2pt } else {0pt}, dy: -1.5pt, body)
  }

  grid(
    columns: (qcv_size_col_left, qcv_space_between_cols, 100% - qcv_space_between_cols - qcv_size_col_left),
    align(left + horizon,
      stack(
        align_top_of_rect(years_text),
        move(dx: start_percentage, rect_or_circle),
        rect(width: 100%, height:0.5pt, fill: qcv_gray)
      )
    ),
    "",
    align(left, [
      #text(qcv_size_entry_title, weight: "bold")[#title]
      #text(qcv_size_entry_details)[#details]
    ])
  )
}

