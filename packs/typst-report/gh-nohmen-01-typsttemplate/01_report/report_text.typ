#import "/01_report/report_template.typ": *

#show: cover.with(
  Snumber:[00],
  day:    [2026/ 04/ 02],
  title:  [TYPST TEMPLATE #underline[FOR U].],
  sub:    [test text],
  overview: [#lorem(30)],
  aff:    [所属（学年・学部）],
  grade:  [学年],
  id:     [20260403],
  name:   [NOHMEN],
  cutoff: [2026/ 04/ 03],
  class:  [授業名],
  period: [授業時間],
  teacher:[教員名],
)

#flyleaf

#h1[First Heading]
#h2[Secound Heading]
