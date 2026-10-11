#import "template/template.typ": *

#show: project.with(
  title: [日记标题],
  author: "作者",
  show-name: false
)

#include "src/01-prologue.typ"
#include "src/02-diary.typ"
#include "src/03-appendix.typ"
#include "src/04-epilogue.typ"

