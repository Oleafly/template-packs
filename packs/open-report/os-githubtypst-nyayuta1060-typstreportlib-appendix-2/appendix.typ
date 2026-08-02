#let default-appendix-title = "付録"
#let default-appendix-numbering = "A."
#let default-appendix-break-before = true

#let appendix(
  title: default-appendix-title,
  numbering: default-appendix-numbering,
  break-before: default-appendix-break-before,
  body,
) = {
  if break-before {
    pagebreak()
  }

  counter(heading).update(0)
  set heading(numbering: numbering)

  if title != [] and title != "" {
    heading(level: 1, numbering: none)[#title]
  }

  body
}
