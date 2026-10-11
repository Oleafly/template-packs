#import "src/side.typ": side
#import "src/header.typ": header
#import "src/question.typ": *

#let question = question
#let choice = choice
#let subquestion = subquestion
#let blank = blank

#let exam(
  name: "",
  school: "华南理工大学", 
  course: "",
  semester: "",
  duration: "",
  body,
) = {
  set document(
    title: name,
    author: school,
  )
  show: side(course)
  set par(justify: true, leading: 0.8em)

  header(
    course,
    school,
    semester,
    "B",
    "闭卷",
    "所有答案请直接答在试卷上",
    duration
  )
  body

  finish-exam()
}

#let section-title(title) = [
  #v(1em)
  #text(size: 14pt)[*#title*]
  #v(0.8em)
]

