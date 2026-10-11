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

// ----------
// r#counter("p").update(0) to zero to start paragraph number at 1
// ----------

#let p = counter("p")
#counter("p").update(0)
#let step = p.step()
#let nr = context p.display()
#show par: it => {
  if it.body.at("children", default: ()).at(0, default: none) == step {
    return it
  }
  par(step + [#nr. #h(2em)] + it.body)
}

#set par(first-line-indent: (
  amount: 0em,
  all: true,
))

#lorem(50)

#lorem(50)