// appen_1.typ


#let appendix(body) = {
  set heading(numbering: "A.1.", supplement: [Appendix])
  counter(heading).update(0) // set update to 0 so that you can start with A .
  body
}


#show: appendix

= This is Appendix A

== My Contents

#lorem(50)