#import "@preview/oxifmt:0.2.1": strfmt

#let i18n_title = (de: "Gutachten", en: "Evaluation Report")
#let i18n_topic = (de: "Thema", en: "Topic")
#let i18n_worked_on = (de: "Bearbeitet von", en: "Worked on by")
#let i18n_supervised_by = (de: "Betreut von", en: "Supervised by")
#let i18n_handin_date = (de: "Abgabedatum", en: "Hand-in date")

#let i18n_time_date = (de: "Ort und Datum", en: "Time and Date")
#let i18n_grade_suggestions = (de: "Notenvorschlag", en: "Grade Suggestion")

#let evaluation_report(
  title: "", 
  type: "Bachelorarbeit",
  authors: (), 
  advisors: (), 
  date: datetime.today(),
  grade_suggestion: 4.0,
  lang: "de",
  body
) = {
// Set the document's basic properties.
set document(
  author: advisors, 
  title: title,
  keywords: (i18n_title.at(lang))
)

// Adjust the page's general layout
set page(
  numbering: "1", 
  number-align: center,
  header: [
    #set text(size: 14pt, lang: "de")
    #h(1fr)
    #strong(i18n_title.at(lang) + " " + type)
    #h(1fr)
  ]
)

set text(font: "New Computer Modern", size: 10pt, lang: lang)
set par(justify: true)

// Set the document's headings.
set heading(numbering: "A)")
show heading: set text(size: 12pt)

// Indent the document's lists and enumerations a little bit more
set enum(numbering: "1)", indent: 1em)
set list(indent: 2em)

{
  // make the table appear a little bit bigger than the rest of the text
  set text(size: 12pt)
  line(length: 100%, stroke: (thickness: 1pt, dash: "dashed"))

  grid(
    columns: 2,
    gutter: 1em,
    align: left,
    [#strong(i18n_topic.at(lang) + ":")],[#title],
    [#strong(i18n_worked_on.at(lang) + ":")],[#authors.join(", ")],
    [#strong(i18n_supervised_by.at(lang) + ":")],[#advisors.join(", ")],
    [#strong(i18n_handin_date.at(lang) + ":")],[#date.display("[day].[month].[year]")]

  )

  line(length: 100%, stroke: (thickness: 1pt, dash: "dashed"))
}

body

v(1cm)

stack(
  dir: ltr,
  stack(
    dir: ttb,
    spacing: 0.5em,
    strong(i18n_time_date.at(lang)),
    "Garching, " + datetime.today().display("[day].[month].[year]")
  ),
  h(1fr),
  strong(i18n_grade_suggestions.at(lang) +": " + strfmt("{:.1}", grade_suggestion))
)
}