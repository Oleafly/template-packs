#let CV(info_path) = {
  let info = yaml(info_path)

  let education_count = info.education.len()
  let experience_count = info.experience.len()
  let skill_count = info.skills.len()
  let half_index = calc.ceil(skill_count / 2)
  let row_count = 2 * education_count + 4 * experience_count + half_index

  let main_size = (-0.128 * row_count + 13.852) * 1pt

  set page(margin: (top: 1cm, bottom: 1cm))
  set text(size: main_size, font: "Cantarell")

  align(center)[
    #text(13pt)[Curriculum Vitae]
  ]

  text(14pt, weight: 725)[#info.name]
  line(length: 100%)
  table(
    columns: (1fr, 1fr),
    align: top,
    stroke: none,
    text(weight: 700)[Date of Birth:], [#info.dob],
    text(weight: 700)[City:], [#info.city],
    text(weight: 700)[Email Address:], [#info.email],
    text(weight: 700)[Phone Number:], [#info.phone],
  )

  text(12pt, weight: 725)[Experience]
  line(length: 100%)

  table(
    columns: (auto, 1fr),
    align: top,
    stroke: none,

    ..info.experience.map(d => (
      [#d.start - #d.end],
      [#text(weight: 700)[#d.place \ #d.role] \ #d.desc]
    )).flatten()
  )

  text(12pt, weight: 725)[Education]
  line(length: 100%)

  table(
    columns: (auto, 1fr),
    align: top,
    stroke: none,

    ..info.education.map(d => (
      [#d.start - #d.end],
      [#text(weight: 700)[#d.name] \ #d.desc])
    ).flatten()
  )

  text(12pt, weight: 725)[Skills]
  line(length: 100%)

  columns(2)[
    #for i in range(0, half_index) {
      [- #info.skills.at(i)]
    }
    #colbreak()
    #for i in range(half_index, skill_count) {
      [- #info.skills.at(i)]
    }
  ]
}
