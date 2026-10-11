#import "template.typ": Logbook

#show: Logbook.with(
  prac_title: [Counting from 1 to 10],
  prac_number: "1",
  fan: "smit1234",
  name: "John Smith",
  subject_code: "ENGR1234",
  subject_name: "Counting For Engineers"
)

= Logbook 1
== Introduction
#lorem(100)

== Method
#lorem(400)

#table(
  table.header[Some Important Factors][Important numbers],
  [Yes],[10],
  [No],[3],
  columns: (1fr, 1fr)
)

#lorem(150)

== Results
#lorem(200)

== Discussion
#lorem(300)

== Conclusion
#lorem(100)