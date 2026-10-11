#import "template.typ": *

#show: evaluation_report.with(
  title: "Your Report Title",
  authors: ("Author One", "Author Two"),
  advisors: ("Advisor Name",),
  type: "Bachelor Thesis",
  date: datetime(day: 1, month: 1, year: 2025),
  lang: "en", // Here we set the language to English
  grade_suggestion: 1.7,
)
= Objectives and Goals
#lorem(100)

= Strengths of the Work
#lorem(200)

= Weaknesses of the Work
#lorem(200)

= Summary
#lorem(100)

// ---------------------- German Version ----------------------
// #show: evaluation_report.with(
//   title: "Der Titel Ihrer Arbeit",
//   authors: ("Autor Eins", "Autor Zwei"),
//   advisors: ("Betreuer Name",),
//   type: "Bachelorarbeit",
//   date: datetime(day: 1, month: 1, year: 2025),
//   lang: "de",
//   grade_suggestion: 1.7,
// )

// = Themenstellung & Ziele
// #lorem(100)

// = Stärken der Arbeit
// #lorem(200)

// = Schwächen der Arbeit
// #lorem(200)

// = Zusammenfassung
// #lorem(100)