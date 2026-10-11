#import "template/Resume.typ": Resume

#let preamble = {
  include "body/intro.typ"
}

#let core = {
  include "body/experience.typ"
}

#let side = {
  include "body/skills.typ"
  include "body/education.typ"
}

#let postamble = {
  include "body/publications.typ"
}

#let author = (
  name: "Yours Truly",
  github: "typst",
  linkedin: none,
  email: "yours@truly.com",
  phone: none,
  location: "Interwebs",
)

#let content = (
  preamble: preamble,
  core: core,
  side: side,
  postamble: postamble,
)

#Resume(
  author: author,
  content: content,
  debug: false,
)
