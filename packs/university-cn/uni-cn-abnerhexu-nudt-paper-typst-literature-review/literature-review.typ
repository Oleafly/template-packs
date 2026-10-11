#import "literature-review-template.typ": *

#show: project.with(
  title: "土拨鼠做饭技术研究",
  name: "敖吒",
  idnum: "202102001036",
  major2: "无军籍本科生", 
  major1: "计算机科学与技术", 
  college: "计算机学院",
  grade: "2021级", 
  advisor: "",
  jobtitle: "",
  unit: ""
)

#set text(lang: "en")

= Literature Review

== Introduction



#text(size: 14pt)[#v(0.5em)#h(-2em)References]

#bibliography("literature-review.bib", style: "institute-of-electrical-and-electronics-engineers", title: none)