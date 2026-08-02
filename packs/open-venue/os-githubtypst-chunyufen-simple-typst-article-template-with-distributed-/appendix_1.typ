#set par(
  first-line-indent: 1em,
)

#let appendix(body) = {
  set heading(numbering: "A.", supplement: [Appendix])
  counter(heading).update(0)
  body
}

#show: appendix

// ----------
// don't change the above
// ----------

= Tables and Data<app1>

#lorem(50)

#lorem(50)