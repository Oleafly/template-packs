#import "conf.typ": conf, keywords

#show: conf.with(
  title: "A Comprehensive Study on Machine Learning Techniques",
  author: "Student Name",
  supervisor: "Dr. Supervisor Name",
  doctype: "Thesis",
  date: datetime.today(),
)

= Introduction

Your content here...

#keywords[machine learning, computer science, research]

#lorem(30)

= Literature Review

More content... @Zoo2015.
== #lorem(2)
#lorem(30)

#bibliography("sources.bib")
