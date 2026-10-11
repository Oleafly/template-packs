#import "template.typ": *

#show: project.with(
  title: "<Titel>",
  work-type: "<Pflichtenheft / Übungsblatt / etc.>",
  lecture: "<Vorlesung>",
  professor: "<Prof. Dr. Joe Doe>",
  authors: (
    (name: "Author 0"),
    (name: "Author 1"),
    (name: "Author 3"),
  ),
)

#include "chapters/00-intro.typ"

