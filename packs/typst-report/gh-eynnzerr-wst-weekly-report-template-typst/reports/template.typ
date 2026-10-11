#import "../utils.typ": *

#let private-date = "YXXWXX (YYYY.MM.DD-YYYY.MM.DD)"

#let private-overview = [
=== 项目 1
#lorem(30)
]

#let private-details = [
=== 项目 1
#lorem(60)
]

#let private-plans = [
1. #lorem(10)
2. #lorem(10)
3. #lorem(10)
]

#let report_yxx_wxx = create_report(
  date: private-date, 
  overview: private-overview, 
  details: private-details, 
  plans: private-plans
)

#set text(font: ("Libertinus Serif", "Noto Sans CJK SC"), lang: "zh")
#show_report(report_yxx_wxx)