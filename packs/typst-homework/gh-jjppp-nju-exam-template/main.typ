#import "template/exam.typ": exam
#import "template/common.typ": *

#show: exam.with(
  course_name: "计算机程序的构造和解释",
  course_year: 2024,
  show_answer: false,
  mock: true,
)

#include "problems/wwpd.typ"
#include "problems/diagram.typ"
#include "problems/hof.typ"
#include "problems/tree.typ"
