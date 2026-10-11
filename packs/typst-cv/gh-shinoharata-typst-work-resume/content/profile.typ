#let profile = yaml("profile.yaml")

// 生年月日から満年齢を算出（コンパイル日の日付を基準）
#let parse-birthday(raw) = {
  if type(raw) == type(datetime(year: 2000, month: 1, day: 1)) {
    raw
  } else {
    let s = str(raw)
    let parts = if s.contains("-") { s.split("-") } else { s.split("/") }
    assert(
      parts.len() == 3,
      message: "birthday は YYYY/M/D・YYYY-MM-DD、または datetime としてください",
    )
    datetime(
      year: int(parts.at(0)),
      month: int(parts.at(1)),
      day: int(parts.at(2)),
    )
  }
}
#let age-years(birth) = {
  let today = datetime.today()
  let y = today.year() - birth.year()
  if today.month() < birth.month() or (today.month() == birth.month() and today.day() < birth.day()) {
    y - 1
  } else {
    y
  }
}
#let age = age-years(parse-birthday(profile.birthday))

#table(
  columns: (0.15fr, 0.3fr, 0.3fr, 0.15fr, 0.3fr),
  rows: auto,
  stroke: 0.5pt,
  inset: (x: 7pt, y: 10pt),
  fill: (x, y) => if x==0 or y==0 {luma(222)},
  align: center+horizon,
  table.header([*フリガナ*], [#profile.kana], [*生年月日*], [*年齢*], [*最寄り駅*]),
  text(size: 1.3em)[氏名],
  text(size: 1.6em, profile.name),
  text(size: 1.3em, profile.birthday),
  text(size: 1.3em, str(age) + "歳"),
  text(size: 1.2em, profile.nearest_station),
  text(size: 1.1em)[興味・関心],
  table.cell(colspan: 4, align: left)[#profile.skills],
  text(size: 1.1em)[趣味],
  table.cell(colspan: 4, align: left)[#profile.hobbies]
)

#table(
  columns: (0.8fr, 2fr, 2fr, 2fr, 2fr, 2fr),
  rows: auto,
  stroke: 0.5pt,
  inset: (x: 7pt, y: 10pt),
  fill: (x, y) => if x==0 or y==0 {luma(222)},
  align: center,
  table.header([], [*環境(OS等)*], [*開発言語*], [*フレームワーク*], [*インフラ等*], [*ツール*]),
  align(horizon)[
    実務
    経験
  ],
  align(left, profile.experience.environments),
  align(left, profile.experience.languages),
  align(left, profile.experience.frameworks),
  align(left, profile.experience.infrastructure),
  align(left, profile.experience.tools)
)
