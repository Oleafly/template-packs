#import "template/cv.template.typ": *

#import "@preview/cuti:0.3.0": show-fakebold
#show: show-fakebold

#show: doc => cv(
  lang: "zh",
  paper-size: "a4",
  font-size: 12pt,
  font-family: "fangsong",
  bg: "/media/bg-a4.png",
  doc
)

#cover(
  university: "XX大学",
  program: "XX系",
  school: "XXXX中学",
  name: "陈大文",
  font-family: "kaiti",
  logo: "",
  bg: "/media/bg-cover.png"
)

#include "sections/resume.typ"

#toc()

#show: doc => page-numbering(doc)

#include "sections/letter.typ"

#include "sections/info.typ"

#include "sections/appendix.typ"
