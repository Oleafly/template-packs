#import "../lib.typ": bachelor-thesis-style

#show: bachelor-thesis-style.with(
  title: "논문 제목",
  subtitle: none,
  author: "학생 이름",
  supervisor: "지도교수 이름",
  pubdate: (
    year: [2026],
    month: [12]
  ),
  coach-date: (
    first: (year: [2026], month: [9], day: [15]),
    second: (year: [2026], month: [10], day: [20]),
    third: (year: [2026], month: [11], day: [25]),
  )
)

#lorem(200)

= 첫 번째 장

#lorem(150)

== 첫 번째 절

#lorem(100)

=== 첫 번째 항

#lorem(80)

= 두 번째 장

#lorem(120)

== 두 번째 절

#lorem(90)

= 세 번째 장

#lorem(140)
