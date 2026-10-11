#import "template.typ": thesis

#show: thesis.with(
  authors: ((name: "Max Mustermensch", email: "max-mustermensch@uni-bremen.de"),),
  title: [Master thesis],
  supervisors: ("Supervisor 1", "Supervisor 2"),
  semester: "Summer semester 2026",
  abstract: include "chapters/abstract.typ",
  courseOfStudy: "mathematics",
  degree: "Master",
  language: "en",
)


#include "chapters/introduction.typ"
#include "chapters/chapter.typ"
