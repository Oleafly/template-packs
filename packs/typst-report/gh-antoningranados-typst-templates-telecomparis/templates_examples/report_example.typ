#import "../template_report.typ": *

#show: report.with(
  title: "Report title", subtitle: "Subtitle" /*optional*/,
  student_name: "Antonin", student_mail: "antonin@example.com" /*optional*/,
  supervisor_name: "Supervisor" /*optional*/,
  course_name: "Course XXX" /*optional*/, date: "01/01/2026" /*optional*/,
  header_content: lorem(150) /*optional*/
)

= First section
== First Subsection
#for i in range(2) [
#lorem(100)

]

#figure(
  image("../templates_res/logo_school.svg", width: 30%),
  caption: [Logo of Télécom Paris #footnote[This comes from this webpage: #link("https://www.telecom-paris.fr/fr/ecole/bref/logos")[Logotypes TP]]]
)

#for i in range(3) [
#lorem(100)

]

== Second Subsection
#for i in range(5) [
#lorem(100)

]
